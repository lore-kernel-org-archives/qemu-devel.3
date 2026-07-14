Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA85C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTAS-0008RA-1T; Mon, 13 Jul 2026 22:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTAP-0008QS-5C
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTAN-0006cq-Ka
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1ehNsRYSWhnJLSMyFUakhUmUXHYh8MaiUNq0NwGhXQ=;
 b=JyPSOHLcq3hYy3GxehyY4SrDT355zUv6+QtUbjFGwYq90jx0U2IUN/2/Ql7G0gwbKb7RFu
 SQiXTtJ4JThhQaaciMD+icvAMocNm8/y9yxBgwAmyLpMO/j8EdQugSmp1W5Ovccb4W4T/f
 KR9NBLuMV1+sH6Dfuf1F9MisY7e2Zeg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Ozazf7R4OQusPG_MWQP4TA-1; Mon, 13 Jul 2026 22:46:35 -0400
X-MC-Unique: Ozazf7R4OQusPG_MWQP4TA-1
X-Mimecast-MFC-AGG-ID: Ozazf7R4OQusPG_MWQP4TA_1783997194
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8409ba0easo464026a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997194; x=1784601994; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l1ehNsRYSWhnJLSMyFUakhUmUXHYh8MaiUNq0NwGhXQ=;
 b=jyG5tHBdDtCA2+wMdCbXMBJh6wbX/x0wj1rD9tKnZFBVL6MXrKFtLXGOiuphkxRNqz
 5ZDcOVKT903smQPKU3mdZxwqnitYb8FH23LAalGmLGsmx/E9GKKzhQ816Gv3Tf0HSgYs
 VVAFfPxdrAxIHurFoJun7Ve9+gluv1+EuzEhYyJy4JdHxE49fNhrX/oT99h1GzbllNG7
 IMkiznbt+5XdLZ5SnoE8K5zQUa2pVqklnGxicmQFgF10thiCl77hTeXWmHeIBhjgQR+p
 5Ep67gKqSVPHJrSW8p6sSSY2JV1QsS7lckYs9KjGhrmBzsmLbWE4kbPZejFW/XJF2rp/
 Xd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997194; x=1784601994;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l1ehNsRYSWhnJLSMyFUakhUmUXHYh8MaiUNq0NwGhXQ=;
 b=prUQi8IkyodhI4BiWOPLDRxtXJ7ZFRqqPGNG42DbzFRfbPDSi2BAxC5f64dZR4MH2i
 qvRyiErDo/6MQqmReE8GebaVsiXVsqMXELjEOJYVVfHO/e7Nm+jGSoDMKf5r5VNCqS+I
 t7JrwuCUnH+4/0sW9x0q9N52ddJaD7bTpFe0LZwBXMIvKTsUR98OmAgqUudemc7h6J83
 TbEupMLex/JkdKw5Lpq85wEbWpCaURoUGctJHrEym248E/nvL41q3RVn1HyrQPB+/4aW
 MxB0ksiwg71iWNCCBw6FQ0YOaHYdNGDjgukIZUxJWXdWkDTZtGUhaZTKXsgI/ilPbwlH
 4h8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHdzZkUu/A0EFp8wmQNDOMmlbxCiwh4punn2VowAGce7bKkUEDya+Mm6zV4YsC2YTH9PURQtBQBfxk@nongnu.org
X-Gm-Message-State: AOJu0YzR/QuejuZ3Ik2MEmhSsXt93s2SM7AWBg7mBdI4LVf2ks4wS8SG
 47TImmmbtf1Qi653ZROeutgG9Kmw1rKmOb6QT5DaSRVSvYq9ZrYNx7JzypTSHH0DeEFqTjkgci4
 R6fTj5tavioSZXWS22aKkQJKLx1gdf5Sbhafehm322oVqZdl3J3hsRWfh
X-Gm-Gg: AfdE7cl+bIWwsHr6HgHr7vV+2iU95TtFCUTou3DpFO9p0QAipIxJcX97NEfMiwhiUkH
 vdxmD6zg3XuKGn0WKxW+6jhBmNOT3Q0up5eC6HHdDeYjvHKfoox1Ks5If7+9an/WDArq+++h96U
 C4kq7Th2KgnkAmA4lGKeAOvHXFwZ7kIC/ALAtngzcs++IHa59qs7otBluCt0ehaC9prpr/Vr/U8
 6slxkjbGf47hr4Qfb8uxJO6xdd/9TDy6PBeJRbjncCXiog9YR8F2rklGNDGJ17C60VAJaNfRTQE
 5He6Uz8UnZMB0V4Bu49fDY1EzvXA5d+NGp52ncRCXTI+SQL+uYQEd5cM8W858LHstzyo99OOk7r
 4yWvE2ItrXg2FY/dIKb+rxrD7QfcReHKH1m7rePPW5IiYfw==
X-Received: by 2002:a05:6a21:1404:b0:3b4:731e:6fad with SMTP id
 adf61e73a8af0-3c0f094035emr17175332637.16.1783997194121; 
 Mon, 13 Jul 2026 19:46:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:1404:b0:3b4:731e:6fad with SMTP id
 adf61e73a8af0-3c0f094035emr17175295637.16.1783997193671; 
 Mon, 13 Jul 2026 19:46:33 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:33 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] Update MAINTAINERS
Date: Tue, 14 Jul 2026 08:15:28 +0530
Message-ID: <20260714024557.204578-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260714024557.204578-1-anisinha@redhat.com>
References: <20260714024557.204578-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..c51eea98b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2826,6 +2826,19 @@ F: include/hw/acpi/vmgenid.h
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


