Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2854CEA813A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq2e-0001MP-9X; Tue, 10 Feb 2026 10:52:44 -0500
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq0l-00014x-3B
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:52:40 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vppuN-0003NV-9V
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:44:13 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cfdf7e7d19so3683705a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770738247; x=1771343047;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RyEGPal6sMPxAA1OJWLh+7E7jJfQjtzO8gdCkQ/32NQ=;
 b=uZQa0ufcpGGt2KRP4LxVqPrZAzj5KVjsclASC0zpi5EX0yu1s+58QPucINIL3ykwPI
 wkatdi54ZdQUJc3V+R+DMmYFyFW75Jk/ZAbqAo+jF71FgCQVIV6fFflHnHabDYCM/ns3
 JcockWiGZlqNAkNOwt5SO2sRNzcusOBCI6KPsxVAk1NgvcOa3dMWnWn+Vwf4mlcr3vG4
 fhlsDD/Sng6P//DyvlbMqO3YLKPlIczl7l7Xp1zr27mGHjd55vlJseNF2/1ct2P7K7h9
 UyZhQmReKdMo8F7TXP92kMk6+cKKMJSvFnXGm929Z3lYkwfb5C3pyo+kBY2J1a2swAqX
 VqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770738247; x=1771343047;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyEGPal6sMPxAA1OJWLh+7E7jJfQjtzO8gdCkQ/32NQ=;
 b=FPaLSkBqqB0D2N2t8T/Bzn4HdP8XBdJrGJFTO4nAzeODyXBkiT+nT7BhBev2fJg1pe
 E0RJTPbr16E7AhWMZwJ9cPH53pOl5PD+yepftH496C0mmHjtm9RZEyGiYKvYUBdlVmRB
 zgxl5fiIBzMiew91fPKBRjRRLJCPjjIS9xkBAORtnQgWiVAQM33Kt3bwvMXF3b0fJ+ze
 2ZfHIQKkVlNXT3YDtwmG3BVpWEPXo1Pc1Ihod6lrhE08DdWyzUdtOURqBrShF2HftEXU
 SoMvdzU3ixM0hKuvUSuZTFlKJayFS7qf00GgDpugrcPzv+Vk1/OeysJyqdVpF+dcAN5Q
 q39A==
X-Gm-Message-State: AOJu0Yw0snHjFayEsy3ama4jK/BgnLlmzWqsQeKygVE8wKdEJfzZO6PA
 gVWxb59Lsh78Jm24UrZAJWqGaWl62h57Bs8CVvoAPaZkB2yYkQLJ+rA3PdnhCWDJHbM=
X-Gm-Gg: AZuq6aJjhW4HSX+vp/bczx5IXuWRti60EG8dWFsGVtilCkgrZsPervduNEw2HWiJMBk
 hW80ZdRsdS58OrW0K9mxYNjO/6j1RAhR/v9EHKdJ3Eg++pQ9OEKVhN5yQcEZjVaPAVVUp8fQc6H
 37F52ruew0OnWF9S5BdW/RCzt0TDmCEZ63OcckRNO1gAB0UVzGE6e8hmOjhVbnSbWMBXLSOdwbF
 JSyU9kVA9kPzemvwRy2v+ps0oVhD+yHu4qnSGSgp4G7SvsCUi6Q7fk3zaFfx1ZoPqBek7m2vkbb
 6uOY00vH6/BSk8VpbiVwC1pQ70IXnfl7PsvzRX36u+GBCEd3W1urkX0cYC54UJo3A+BRXlo/Va0
 hG7JSUikONev6JKgNiJ/z+nh6yF03ixukkFVBVqBoxiSBjIUprXOSEc8Rxq4a7wSNlMRO4M6BPy
 cuaFHpuL9DkQ==
X-Received: by 2002:a05:6830:83a2:b0:7cf:e57f:def6 with SMTP id
 46e09a7af769-7d4643e559fmr10186177a34.6.1770738247087; 
 Tue, 10 Feb 2026 07:44:07 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46479964fsm9872976a34.22.2026.02.10.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:44:06 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 08:43:48 -0700
Subject: [PATCH] freebsd: FreeBSD 15 has native inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-freebsd-inotify-v1-1-009430118133@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIADNSi2kC/x3MQQqAIBBA0avErBN0iJKuEi1Sx5qNhkYU4t2Tl
 m/xf4FMiSnD3BVIdHPmGBpU34E9trCTYNcMKHGUqKTwichkJzjEi/0rtHFyMmj14BS06kzk+fm
 Py1rrB9LrUh9hAAAA
X-Change-ID: 20260210-freebsd-inotify-8bd07b2c84d1
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xEHoOvN3TkR/IWEoiMhI679mber/sRBzm2hmlAn2tXo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi1I3JOrFcXtzSwFREfWMs1Ql4LGVLnrSr9GZX
 KkdpgyTga2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYtSNwAKCRBsHNEofbAR
 ADncEAC7h6hBz+GOfTIZNpPplQbRvYDi6Rv3Do82X4Yua5L63jqFEnT2i+g6144mHnA5HKoQdYV
 l0pXWNYt5ZcZmTM7EcAgROiDYwE39hnwva8vVPsYz1sBi1DwbI3XG46kKuWimEYvqVxmqJsKFP+
 W9f6uOpqAkRg8C2Pi4UQ/QSNGfuTu4J4vGwdw9LHw6PEWmEN04CoiSqCiLwQWEArlktBaLL8nz3
 vVLy8NTGMX1L0Uz0SHCTGkqRTnCx9/2iNAlyaDKjfdwOLMovvlKej8AbYXLERnLDLLj8Ao4qB96
 nzjYIhAbpbsIgovzK8m+H81vrwPzKOXXB07VWSrn+G12bq48WX8GOdbFsIEmXBh5FsO1813dlOg
 aHmI02kVThIMAjZAyrWrXplz+z+uHtCEFP0ua3ZtouWpJOiKjcL+UYpuQwuP2YyHeszs1JYNQU3
 ONjt1rf+IkUbnjWfAy2cdVBI1BuoK8f1UAwIrRk0Gs6OhbP1QKcFKTiXkppMP+T6x6DnNSMZ+pv
 d994HwmnLdoz4mW9yEwouXLKrhOYsDa0rV5UtOVc5moyFsdJFqMt+VbJVKlI8dCeg0s/KpeDiQV
 LhWRpIMXpRkm8Eh2WOH6j9mljpfHqrjT2dY2JGkPHri+8PeLAHYh+Xqskl6BA/XXVUFxKr+Z/Hf
 QJS0Ze0PjkQ92Ng==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Check to make sure that we have inotify in libc, before looking for it
in libinotify.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
FreeBSD 15 and newer now has a native inotify implementation. Check for
it before checking for the wrapper libinotify library which is needed in
FreeBSD 14 and earlier. Make the check dependent on symbols, not host
version.

Separate series because it's really independent of the two other
patch series I have submitted and it is more important.
---
 meson.build | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 2d114e9018..537f50283f 100644
--- a/meson.build
+++ b/meson.build
@@ -2662,13 +2662,15 @@ have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
 inotify = not_found
 if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
-  # libinotify-kqueue
-  inotify = cc.find_library('inotify')
-  if have_inotify_init
-    have_inotify_init = inotify.found()
-  endif
-  if have_inotify_init1
-    have_inotify_init1 = inotify.found()
+  if not cc.has_function('inotify_init') and not cc.has_function('inotify_init1')
+    inotify = cc.find_library('inotify')
+    # libinotify-kqueue
+    if have_inotify_init
+      have_inotify_init = inotify.found()
+    endif
+    if have_inotify_init1
+      have_inotify_init1 = inotify.found()
+    endif
   endif
 endif
 config_host_data.set('CONFIG_INOTIFY', have_inotify_init)

---
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20260210-freebsd-inotify-8bd07b2c84d1

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


