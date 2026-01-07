Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251D9CF6BE4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdLXp-0007RB-KV; Tue, 06 Jan 2026 23:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vdLXo-0007O9-6Z
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vdLXm-0005xo-S6
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 23:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767761594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m7DSRDbx8t8gfx3UTTV0pJFl8M7eZT/f6aNA9bhLPMM=;
 b=fzlCuopi9UrVYffJj8gdHy9B8ATMxRS4dMYKf8o4qhYUCWIyCqU5bNPwQRktGwtVXX4nvB
 wlF5xkFgadyjTQXAyoJ1m6L3S/vB8W08V7f+USeNTDKTKQkDQ1PcrG9vkKOJ64tYTvJP9M
 H3MGvyEDXQU6Vb1zxumwvQGLj6mRQSk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-cLthvks2PmeuDmtoG8DZiw-1; Tue, 06 Jan 2026 23:53:12 -0500
X-MC-Unique: cLthvks2PmeuDmtoG8DZiw-1
X-Mimecast-MFC-AGG-ID: cLthvks2PmeuDmtoG8DZiw_1767761591
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a089575ab3so20401765ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 20:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767761591; x=1768366391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m7DSRDbx8t8gfx3UTTV0pJFl8M7eZT/f6aNA9bhLPMM=;
 b=F9ev5fI6OozubFd5xcxmj0uUYqtIH5B+B+8HP9ydG6/jdEnx4JeukGZdz/HtJgl2cL
 QfAxdDyxZSlidwXMXbDQIxv0EwpAAEvhE52bvefVM1kwPHJNLP2f+gwiK2rQuz+/azCR
 FLDx0NgugJQMoU2zprFGM46nilD/JiX4i3QZbhrl4WGah5z3x9nbWXAnkZjRY7MP62af
 s5ydIaVheLb5LlKOvWcak6Es25+NkDTaQfBnDl27N8q+CXMeBT8QFjGamwMmRNZ92QOK
 KiMQ5c/fTRwWQD3Dz+x57iKxncFK+ymDlQIiVYdcRRKMNtFkpRontoRI/I5LcStEOAUE
 aaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767761591; x=1768366391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7DSRDbx8t8gfx3UTTV0pJFl8M7eZT/f6aNA9bhLPMM=;
 b=OeVbkMRnHmRyHWvBExATb41APr7twXrub0adhu86okObHtrKnkjbH0/bNGVuLx+QDd
 FHuQvyphqZEiDJ3CdaZNrQP7CZaniUXSV+J4Y97jskxaHBHdXHD5Bvt2C88zYMh+l1qJ
 /7sjbTJ29SIdif1688V3oWqV3BDKCitdliIWa0Xkwd6rvuujkCgeAlZmIDeJQPC76G62
 qV8ZpfQhFBjiLTol+VYjdu81c5gVwcvspY9kWHp7+6NmY97eG0OaGshcqeL8/kAnDR0c
 dk8EIeo2/I+hkRPUu7EG7x8D2m6PBHn/JcE9z2Y9/dmeNmyO2RjwLYV02yF0QyPotfOJ
 HDxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbnNgwCGyrB6zaM1U1epD3uZvoPs24nvQrGLUpbjbI5ah1QfaY/4US/Ilz4KUW2/u6/yX4G4JttFT0@nongnu.org
X-Gm-Message-State: AOJu0YxHolDgvxt1oyPD8vaY1auoupf+dElOTGi3UN63AaUFuax3yxyS
 ZQsXc/MqGDJFT+8YGRwoE84eSs7X03Mpu5u2rrVDyzMBZ9wuz0On68DBX16JzfDlCV436n2TDbM
 l5nlzcFEosgsp7vtr2nMpdSpY/1cpu6Ui8CPHIDVXOWhwRYSiuXPukK31
X-Gm-Gg: AY/fxX4Dqb48H1z7+9mgWSWhV4SHDjJdACX3AYs4xL+mUUmFKHUFVyD+3HAjWnGv3Bg
 26wYTJVucs6wwajtDK/d+ScNM7orHGg2M0FClDydFaN50hZst8Yy0EAA4AcZWkoKG6Nx5pjpOjj
 RNpgO6LNGLV8YFKseDLGcOa4x1C7TR1Jbc+isI9Slp6Bar5odMmO2FxxmZax2Kx64jlrq35W3/A
 w2xf+XxdkD7AzTgl1LZ8+gXY8/ty9WTvuGx1i5qtMj6fJ4T/duSrJ/9rK0VWa3CXJRWjBBKd6Of
 kTFEubj/byfw4PjkIQLW92Te+QZh/ipwfK277iX5z0sIYV3PPmVPEpSt3l3nPWjsIKeD72qihGM
 jR433QeQAjjndL55tF1jbIViVbK7G/GDHejEAoRjRDA==
X-Received: by 2002:a17:903:3c2f:b0:2a0:afeb:fbb6 with SMTP id
 d9443c01a7336-2a3ee4379abmr10317095ad.8.1767761591480; 
 Tue, 06 Jan 2026 20:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaFpQcKFirsRK86M0ce/AlMKntPTUAw8+fC+bu1Y4SZC/IgWsXO031Smj35JJRBkoJvceDaQ==
X-Received: by 2002:a17:903:3c2f:b0:2a0:afeb:fbb6 with SMTP id
 d9443c01a7336-2a3ee4379abmr10316955ad.8.1767761591079; 
 Tue, 06 Jan 2026 20:53:11 -0800 (PST)
Received: from rhel9-box.lan ([122.163.3.101])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc7856sm36963325ad.68.2026.01.06.20.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 20:53:10 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] docs: update copyright year to 2026
Date: Wed,  7 Jan 2026 10:22:50 +0530
Message-ID: <20260107045250.34420-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We are already in 2026. Update docs to update copyright info to year 2026.

Cc: peter.maydell@linaro.org
Cc: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index bc4e9622dc..f835904ba1 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -92,7 +92,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2025, The QEMU Project Developers'
+copyright = u'2026, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index bc8fab9169..a9ccec7b38 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2025 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2026 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.42.0


