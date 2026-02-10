Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0EEB26F3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 18:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpsSb-0000ii-Vb; Tue, 10 Feb 2026 13:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpsSY-0000i2-Cm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:27:38 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpsSR-0006ML-S4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 13:27:35 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1957594fac.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 10:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770748050; x=1771352850;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FiPZF9v5rJnmwRrEkyINv1aceYVWIObbfvU4wbxGh6g=;
 b=sprgLlAM0PrhHwSoWibyIVNgKgDVC9Yq58zd9xJ+4f8r9yzUCPQUrEYMw7/xkcBnci
 DV2ynH1e8MH/H34O9zqs0QYS6hdj3sQWO7gpLhi85eLlxEp3nkkPJ1mUf11xwL8xQZn/
 6hGGscfkpw0rY7qS1rOulr+bI5HKR11sEnrytlcrhJibYIUskw9olltK/8W37nk5pXgJ
 1TQZBK3zDJFSC2scV+0m3Vawf2F9eGCmlFUk/rZb3pTEGj3tnMZyoSbMT0KBb4ZSTnx/
 D4Bn2LYnsyx3WCntXugrTDUi96/nZAC/MOzApzVMVt0RC1+5nB6Tk1uwjOGnqrchcb6y
 NHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770748050; x=1771352850;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiPZF9v5rJnmwRrEkyINv1aceYVWIObbfvU4wbxGh6g=;
 b=J32DmlsT0LrM4skzIr0vxyPnyYQcLsiDpu0YCAeBvqRngB1YAJ/ZrIYYcejoAy/voi
 rJcn9ENLKGnb9jXPSIUrREUTObHG3O4zLZfYqDanMc4ImsyC4zqPVBurjWJf3hm17mRv
 bOLLW+vfHY1kb4v4tK+D7r7eldIHvQ6vO2hPm0Abbuc8I8cHlfHq3W3Pg99UTZJFRNcn
 pOOBsMPcQE4LtOv9ifSDnIGOGFwB/LssLAYfevOxJHw3LGOW59GAQznD4T9x8DnOKxNf
 /uZF2ONNVBOu+go1gpSv2x77kZRHkPj9uVs334Jf6kw5hB16trEz+Z9hX9tsaoemP5wR
 hNOg==
X-Gm-Message-State: AOJu0YzpJNnsdyTYq9ZEfS7mg4MhbB70j/m5TbBx8I357HZvl9uA71Du
 ymU9orMjtkGys0B1Jp2vhLhb7Vn+Wu2SlZS7tGC8I/hEYNp0flyh5Fbr7opysf9ZiRw=
X-Gm-Gg: AZuq6aLpBZUAUG6BtK+qMsH7E4H8ac7DC3fpDklpLDOHYP3h09vzNYv/NCoCyP7AFeL
 fn4VeLbpJHni7XRZaxDWMy4aBycdjqL1e7Sv0xmTOwmslw7BIzSqMKRRMxk0EDVuM6iQOkc1eo2
 eNOI0gfEqtPEpXjz0oQhnW8sHAfq/CSAi2YxTcCTZZf9d/CRrig0annBmMZVZyeoe39kJDelEvH
 i7FyoAHR7PZFRQxgnYsxRK2MjjBA9julfCtNkfzaU3KnUdEX6TbzIqRnWMMiYYW6J6bukShfKx3
 e65WFNzXOr2nZz3odCxBBiifr/GyFuoYEHInBoOV6PP2b/XklE4qUcbZaBs4U4FjK/r6LHYRnOC
 NTMZ7FrSZi6ZllMvCLOH2h+ArlXvgTuUS+Z/h+gp4svSgJ1WqDmqFa1WOIR1TGIBlgSfdrNKHd4
 HKxISqkH8PIw==
X-Received: by 2002:a05:6870:d18b:b0:3f5:d285:9342 with SMTP id
 586e51a60fabf-40ea960dbe1mr110571fac.45.1770748050075; 
 Tue, 10 Feb 2026 10:27:30 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a992edd71sm10823091fac.5.2026.02.10.10.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:27:29 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 11:27:17 -0700
Subject: [PATCH v2] freebsd: FreeBSD 15 has native inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-freebsd-inotify-v2-1-66e7142b9b2a@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIAIR4i2kC/3WNwQ6CMBBEf4Xs2TW7hSh68j8MB0sX2QOUtKSRk
 P67lbvHN5N5s0OUoBLhXu0QJGlUPxcwpwr68TW/BdUVBkPmQoYJhyBio0Od/arDhq11dLWmbxv
 HUFZLkEE/h/HZFR41rj5sx0HiX/rflRgZiW5NTcwt1/WjtDot595P0OWcv9Tvhi+vAAAA
X-Change-ID: 20260210-freebsd-inotify-8bd07b2c84d1
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2843; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=aXxsLm6JPypjgBm81zrUWHJL9A2zoWPpHSubVV43Jys=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi3iJxxCMBJREtAH8N61Bv4JMJhBDFfn4FG/Cx
 MbcaeSXpP2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYt4iQAKCRBsHNEofbAR
 AFWaD/954rGDBk7Mvdynn3ku+ukEvuR73ten/GphXPbgGGgPP9XmMoCqkODndOH5QgUDvHpf0Ux
 dqF19xJx47Tngsjd61jiXC5V9gGY76iP79OkSlxbcK2E9ShvrxuNlZchX0VNTaTH/FWYxTFfOBU
 iHnMvaphpcbNU2wviw+Tl1pZPTawopy8rBW8nhOk6PZGNfDxxvOZsXutSr2e+Phz7ctzLQFFOX1
 ipc15FfPtw0h+yKeAtQ74l9oujToerynRukRfJRpaWI7Aa8uzu/0qFwkZS+PRZgtLA7W/SwnS4+
 bCmlf6h7AunwOedUFn3KtLOsDpoY4OuyIKjWIBKTh9QbvgDpLMvC2BkvR2LNjtLs7YgU6lS8xfE
 UWYM6vA02mk8SJqa38frtDxg1n70Yf9DMs8sovfq+CTOoEznwKNlhyeCcrdRIRl7DskDXOvsDB5
 nMkRlRdHOGySfOMA9OywMEGmzoUKolJgVDf9hb5y+0yx18YKgypn33HDyyZldQFi8HPYxNCyOgI
 ArZcLFX7SjGyvADWhZePQ401VxH8zFp4VBVszb/WPRLXrwASErGOB7eGR4Uu/h6OCS0hjH5e6W9
 9VriEwN1SAW3H3tjCd7FfE7r8YP5U4YjeW8rdNeqPZI2Ts8RDY2b539kkUYDINuilcbjJKhBN+9
 PpPBBzuV2Ko/yJA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
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
Changes in v2:
- Make simplifications suggested by Bonzini.
- Link to v1: https://lore.kernel.org/qemu-devel/20260210-freebsd-inotify-v1-1-009430118133@bsdimp.com
---
 meson.build      | 14 +++++---------
 util/meson.build |  6 +-----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index 2d114e9018..191266d9be 100644
--- a/meson.build
+++ b/meson.build
@@ -2658,18 +2658,14 @@ else
 endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
+inotify = not_found
 have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
-inotify = not_found
-if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
-  # libinotify-kqueue
+if (have_inotify_init or have_inotify_init1) and not cc.has_function('inotify_init1')
+  # FreeBSD 14 and older need libinotify-kqueue wrapper
   inotify = cc.find_library('inotify')
-  if have_inotify_init
-    have_inotify_init = inotify.found()
-  endif
-  if have_inotify_init1
-    have_inotify_init1 = inotify.found()
-  endif
+  have_inotify_init = have_inotify_init and inotify.found()
+  have_inotify_init1 = have_inotify_init1 and inotify.found()
 endif
 config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
 config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
diff --git a/util/meson.build b/util/meson.build
index 7c9445615d..e7a2a2a64c 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -102,11 +102,7 @@ if have_block
   util_ss.add(files('throttle.c'))
   util_ss.add(files('timed-average.c'))
   if config_host_data.get('CONFIG_INOTIFY1')
-    freebsd_dep = []
-    if host_os == 'freebsd'
-      freebsd_dep = inotify
-    endif
-    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
+    util_ss.add(files('filemonitor-inotify.c'), inotify)
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif

---
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20260210-freebsd-inotify-8bd07b2c84d1

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


