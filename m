Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A28FC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyDS-0001PD-Nz; Mon, 17 Aug 2026 10:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyDQ-0001Ng-Hv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyDO-0002qn-Nl
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEynkQAuetadjiXXgnnb/1Qn5LV1t0jsCpsOMBFblu8=;
 b=X+DokLG1noMJD2jc37p4lvG+PKqm9jHSySrrQKz9/fx5jGHnhbLzlar8HzBZjTMlMyPHbr
 3PyemPFhMqDu8FQL5jmIVVZ29kN8hn5cPJIpj1RPwVFmjoKB9taD7aeAz6Nk1ZK/JlEy2D
 f3HE6XphP7K4L1p+4EVDhWIhH5Kj77s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-OJz5cmTJMae4RLxP4KJC3w-1; Mon, 17 Aug 2026 10:21:16 -0400
X-MC-Unique: OJz5cmTJMae4RLxP4KJC3w-1
X-Mimecast-MFC-AGG-ID: OJz5cmTJMae4RLxP4KJC3w_1786976476
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so36966795ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976475; x=1787581275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HEynkQAuetadjiXXgnnb/1Qn5LV1t0jsCpsOMBFblu8=;
 b=VTRBObi6D3haaoXS6H91z0KvL7EpYa7BZ4LO2Mi6deWcMZSTrl/EA7Q3v5pHrjOk8l
 eyXZWLrwgcDVT8qEtAtnxBvZtuJ8lDa/NVxUy4kHYhrArWV4tFcXBcv0lE5RMvFoAGs0
 sGwkyGb2zE5dDFmJZXQZ49k4h+nA9VEWMWGT8E/qpv5SOPrmtvBUONsfboXejG5jRRB4
 PEbWdM9Y5OC1hw5sQj13mkOEaP+o5QCuDbFAFd69ge7mhC6dbeoSrf8Y3AN02eH1/0kY
 iJULpUlYbpN+Ui5LZObaAF5eh7c7kEnR4ca8QiSOXrA/oBh+1wHqGafqGsF5hzNjTNJa
 5wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976475; x=1787581275;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEynkQAuetadjiXXgnnb/1Qn5LV1t0jsCpsOMBFblu8=;
 b=MrWrYnNNexAdDSJHps5eZ1mJccTuYKXWtnsnEX5DSACujynA6ASA55o4DzS6F7Oi8x
 bEE4ebkYcsDvvIO5BtJUAcT+6mHDwQdYSXgcOlL3OX8L+X6kx9IMvvVqN0Q9Ri/XOzzG
 Q5Wo8XdVjJ2Zmhkjdy9AZnnNawbYGJK1sbv0iSCdHWWyvmiJd34P2MtuMhOiMgr22fP3
 Fh6fiucqGtOcwSdR1M7O4QCCtcAJxoFduchfK64Qkz68dY++bw7u4VuABtMWfGsoI9to
 wPsXXpvGJTJpJ+qzBlyYjeFAb5W4H3aNstREAh9ge0525A0AdiKSvmks1hCiqAbp2rNZ
 ajJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF1nZOsjMSFC4UEF1R3OQBJuWq/qul4T64jhRbBPA5BbhA1rwbYw11lI4IbLj1G0r6thDbl47xB1Xt@nongnu.org
X-Gm-Message-State: AOJu0YxbKfii6MiTC56HXgBXiHBJnGqlIk34nYD2e4PjpLoFgJXQQhAb
 f5E/3xzukcJMKcUF9raVo/FRxr+9ZPf2Is6iQ2KeCisCFxxv+NWTgGv2y/RYmibVfiXEBC4m92l
 2SPjIZ1cpkSxajGNKaZJZAJzeKqn9a4JhvchI5/0SMEY9OWTozX3RrbGr
X-Gm-Gg: AR+sD10o4SJIPwwLLK6JgfjpWhb1IsgqKXgk6BhgUkc86NdYD5ToBN5u8gJnPAYJ5XV
 EZEOWaRHhRHgqbr7WwbIrvmlvCyk7hxi8qwlDX2+pjeGIDrT11RmsHXqleTUoBbOCw0LNudd3Bf
 ZHHDe/bw0yUMD0nutxzr5jL/iLJ9jue0jfdBgSI7MxbIogX175ZWFmQ67O29OEZkFrB47vpt+9u
 zRo+UwwK1wznSRuiZuo9u4pGcrjNcogMiA3ELfS24Yeir6sPXmZAv76R+Yp8BR9fpK5kgnqtzTC
 zfvX5RdrWanv6IglzLroYUzDGUMIRW32jIxXhAbeTmhURBX3ekU2Ynvce2ZtgBPg8aPEYrZxE21
 ibV9pBZk1zdUneAfO/Kz7V2qQOBpM9IfupA==
X-Received: by 2002:a17:902:c402:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2d3b0ce9623mr253496745ad.20.1786976475498; 
 Mon, 17 Aug 2026 07:21:15 -0700 (PDT)
X-Received: by 2002:a17:902:c402:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2d3b0ce9623mr253496225ad.20.1786976474813; 
 Mon, 17 Aug 2026 07:21:14 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:21:14 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, ani@anisinha.ca, agraf@csgraf.de,
 graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v6 11/11] Update MAINTAINERS
Date: Mon, 17 Aug 2026 19:50:06 +0530
Message-ID: <20260817142010.80693-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


