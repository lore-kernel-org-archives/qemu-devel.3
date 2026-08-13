Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1B7C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSmf-0006Ad-Pd; Thu, 13 Aug 2026 06:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmb-00069l-Q0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmZ-0000Rv-7a
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEynkQAuetadjiXXgnnb/1Qn5LV1t0jsCpsOMBFblu8=;
 b=fxnqZrQQNS21u5rfa4xKRoD7Kzx/CdeOfidc7GA3kDdRCvgA3YmjI4uaN1r5BmlZRxkC3r
 0uJnh9RFvjIj3+rp5HZEkk3N6MYp4bGSHGDsityCdp1bfBKlsZK65KF59zGiruh2nHh6rG
 DmDxkk9P8SifHyIwHh9SgqF1GGQcNHY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-8WmeWZZFM6aNAw49gJEfOA-1; Thu, 13 Aug 2026 06:35:27 -0400
X-MC-Unique: 8WmeWZZFM6aNAw49gJEfOA-1
X-Mimecast-MFC-AGG-ID: 8WmeWZZFM6aNAw49gJEfOA_1786617326
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso1784279a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617326; x=1787222126; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HEynkQAuetadjiXXgnnb/1Qn5LV1t0jsCpsOMBFblu8=;
 b=dNMcbfmoGL8wD/z2y/DKyJ4zLflqdZMmM0cecgGLmaj14TXwfa+9gSZXbudloJVntB
 aJxv6PovXD/iPcGTd7lJl7dOvkqOamkgVz7wym4GBQU3twR7IkgA5jj2A/HdiUVmrdkG
 U+KihEjpllXLd453+dRvmo8nZFhWRK39Vl3rElOcWRjFfeTeqmveSnhzusve9akJwSMg
 5lgMMYX04OLUYTsRF2ZHd/ZmhoRV2NNVjFO2WsDfvGwiYxSU9VRblhz6DOsL9gcbBasx
 vuJX77iJFLAuHbWgDiEnDp6hk1TX3GYGCO8RTB5ggpvh9c6eWT/OR7TusxS7OQRIk83F
 CBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617326; x=1787222126;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEynkQAuetadjiXXgnnb/1Qn5LV1t0jsCpsOMBFblu8=;
 b=M3zjEZOINHK1/eVie7CoAjCDsruXtpgmTmEsdFRiNOwAgJufs3uCRmlpmXNSWbbWPI
 KPCO5NAFngY+LV932bCd6GJ18eqUZ1BSJWEmAishYLYQciF4LwMzmDfLy3QAD5OYr4sF
 pdg3Cea7EHpPWM6TA0XBxl6JhO5WeAbYwkVleMmi2lQEM9ARPidXg9p1PuDC/vy/1bNR
 hoVfdADKxONx5kACWOlw0/lDMJgQQ5sS2GOQnUexFT5w7Hrvjnsx3IZpMELWTyftHvK4
 CxBATFICTT9zNoFi3BbP/8PERJdBP+R30d/kieFz9YooVhhoObgtELagyBOY1QtFiOCw
 WKAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxZOnn4+Bsdpe8aP0KjBr397KfMMD6DrRPjPYLFvmGr3IvwLsvW0r+91YFr7FH6lco5SoX123utjgx@nongnu.org
X-Gm-Message-State: AOJu0Yzd0hqbKV1rCE6o7swp9qXMtnlCb9bOPKmleeBhoUhWFi2mY+Uc
 RuMBGMQQbk11Y/ZXmG860AXL4qXYPnA0Zz+4q4IYafBbwadSOjJ4SffXZxwCnZ1Vx2xASW1dvXA
 DEBWOAmiHOkozYq3OnKqr2qquF/KVO0C7UAxF5KLaWfdQEMe9DMSAzAne
X-Gm-Gg: AR+sD10/0tTNOl/x50oGq/YT6ExAaHB/glLchKgpC8Bp4y+HZHxN823c7KRHRVjcEGw
 EVN9GpNFPntjsJ3jQQEmTboWF+4bPBjE5qu1KVPrN9ClK2b2hoHs8OyIAvKQMGbsuXJTC8ifa0R
 FzN4jAB3x+qzp3DCUJzRF/osFei1+OuDwfJpx8PQTeXlcYd4AIITGuw68qb/+e0pAr8TuWEfx86
 G7DDAYmIfnfWdWTsGr8KnU/8Wxt2yC/p4ftAeL/KVgEhLKx0mW+464dyolFAXnFZVRgGxr/jt65
 rYiiHMg5kjecztb6Q6Bg+epiiH91RZNPYZtpRdRL7Q6WukDVLloc/7+6NAQ2iLR7u9q39qR4voq
 L3hqizN+yEcFcb0MZzWnkydCnozE/VB2ShQ==
X-Received: by 2002:a17:90b:4fcd:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3931e233613mr5647551a91.14.1786617326003; 
 Thu, 13 Aug 2026 03:35:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcd:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3931e233613mr5647494a91.14.1786617325588; 
 Thu, 13 Aug 2026 03:35:25 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:35:25 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, ani@anisinha.ca, agraf@csgraf.de,
 graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v5 11/11] Update MAINTAINERS
Date: Thu, 13 Aug 2026 16:04:13 +0530
Message-ID: <20260813103425.24474-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add maintainers for vm-launch-update device and associated documentation and
test code.

Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f249be744e..bbee4e565e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2850,6 +2850,19 @@ F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
+VM Launch Update
+M: Ani Sinha <anisinha@redhat.com>
+M: Gerd Hoffman <kraxel@redhat.com>
+S: Maintained
+F: hw/misc/vmlaunchupdate.c
+F: include/hw/misc/vmlaunchupdate.h
+F: include/standard-headers/misc/vmlaunchupdate.h
+F: docs/specs/vmlaunchupdate.rst
+F: tests/functional/aarch64/test_vm_launch_update_aarch.py
+F: tests/functional/x86_64/test_vm_launch_update.py
+F: tests/qtest/launchupdate-test.c
+F: tests/data/igvm/*
+
 LED
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
 S: Maintained
-- 
2.42.0


