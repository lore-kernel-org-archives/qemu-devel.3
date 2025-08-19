Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB77CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOUI-0006tE-5S; Tue, 19 Aug 2025 11:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoOU4-0006qx-Mq
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoOU0-0002au-PK
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755618162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WNe1cb9MIP8S4WGdq0zxRIQB8fmZFCra4KLixtAZLRY=;
 b=S9TSFZeMEPPhTzdF4d6ynhnZkSwrq4KUGIkShI2hHs9BSvsuI4P5JEkYOMduaJfmbprWFW
 XXZ9BtD/QCrfT/cgpAe4itTiUwpMtiIDSphzL/WHMLxhhtVJpBzH0NfTJHJWoYFljlYT1M
 uTfLnjZMn3NwoIZq1WtVm3bNpu5mKXE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-QBsSITJIMK6xV5zESkDUgg-1; Tue, 19 Aug 2025 11:42:41 -0400
X-MC-Unique: QBsSITJIMK6xV5zESkDUgg-1
X-Mimecast-MFC-AGG-ID: QBsSITJIMK6xV5zESkDUgg_1755618160
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b9dc553704so3654751f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618159; x=1756222959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WNe1cb9MIP8S4WGdq0zxRIQB8fmZFCra4KLixtAZLRY=;
 b=LMVSdj8NwvhsZUoqnsInF3BrPUYqrHpd4WHw1jicWevVJLEim0qWBfncZj99OXxgkW
 Dod64xoYFtJxY7rau+2ilr37EZc0apNgeJ/9CDdiXEmrxuKu4p7TUMiK5ypn6gPLti7F
 hLDUI1z36E2PeU9yxUrH2Uby8K/7oSEGmYSERA2wCHHmEwMUd75Yl2APOfdgsIgTqHrC
 KfrkzXqdFL7obJApiA7s7cMnshILREgJAcAb+Qux9us7HyXJ2As6lJ/u077+ImxrrjoV
 gTctwAKtJ/KXMH1I7zbhvJx4p7ChtHiW6jAXwnRi3vyqOHnhrXcnBnhT43RvvQfny0ja
 JmRg==
X-Gm-Message-State: AOJu0YzQv3v7V4hQbHjHTtN6AbcchbyogNTcI/i8aWjYOBbPMwkqeRcR
 90R9jGw2zcOxG7s/+CMdbdwZKnumhctUMOafIQm+a7s7hqAui4BNICKDCZBT+TZnR39VKD/I9OS
 0ZYviwNAcoZhAaY0HLBrYpzSVhI64X7o9rc0qjbGGmwC5cOBoyqW12MEAykm60JLAwmbxehf2QC
 J+wyu9+uz11f9u7FardVqLVwfvshEr/NX8vm5/WUjG
X-Gm-Gg: ASbGncviOkpnzy+mYs8sMzqVXFYIa9w1lMyM1RIgtVeZWGmJYvUoLPxBKThOTCMQWF8
 7E8UrTodowgh+1GkXEbGuqzBVlza1WqqEzr9eM5Olq8NqR2vdT8/xVcN4FSFAyB0J5TQeiy6hMn
 GsIlHr/YateWpAiTGJTHpND+xmdLosGJF+YF9g4VMLcTV7v1HzfwIpsTXea0N4icnwXzoBeqjpn
 oz2sKecRvpGRe3paNiG2Wy4R8AtI13383UAvayrAumrOuGFZM32nIO/qMGPipVNILnv2dfo+p90
 0c+XSmb/OZ8unL0/gjsuQzKR4W6/8qXCKL7w4WjQ7g==
X-Received: by 2002:a5d:5d87:0:b0:3b4:9dbd:eee9 with SMTP id
 ffacd0b85a97d-3c0ec09e41amr2616737f8f.36.1755618159608; 
 Tue, 19 Aug 2025 08:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3xXhOVB01WpZaN7OcJ0S2hf2XXEpobCz42I8MqSGxjp6M9zCraliA3z2GULPYm/c4yrslIQ==
X-Received: by 2002:a5d:5d87:0:b0:3b4:9dbd:eee9 with SMTP id
 ffacd0b85a97d-3c0ec09e41amr2616700f8f.36.1755618158957; 
 Tue, 19 Aug 2025 08:42:38 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077788df7sm4190961f8f.48.2025.08.19.08.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:42:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH] MAINTAINERS: add a few more files to "Top Level Makefile and
 configure"
Date: Tue, 19 Aug 2025 17:42:37 +0200
Message-ID: <20250819154237.793315-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

A few files in scripts, and the list of packages in pythondeps.toml, are
strictly related to the toplevel build scripts.  Add them to the
MAINTAINERS file stanza.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed762..3979cffb042 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4403,6 +4403,9 @@ R: Thomas Huth <thuth@redhat.com>
 S: Maintained
 F: Makefile
 F: configure
+F: pythondeps.toml
+F: scripts/git-submodule.sh
+F: scripts/meson-buildoptions.py
 F: scripts/mtest2make.py
 F: tests/Makefile.include
 
-- 
2.50.1


