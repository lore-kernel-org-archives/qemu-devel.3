Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68D3C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA8-0005MN-3Z; Fri, 18 Sep 2026 00:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA5-0005LR-Nx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:21 -0400
Received: from mail-oi2-x24.google.com ([2607:f8b0:4864:32::24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA3-0004AB-ID
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:21 -0400
Received: by mail-oi2-x24.google.com with SMTP id
 46e09a7af769-7f4f0dd5507so111586a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705518; x=1790310318;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kYUlt20I8KHIPYiSRmKgCElsTxWsdBrolVifzGqZwc8=;
 b=CoEilYcqfHZNC5HVSc5YqUCdmHVFz5r+RZvyUbDrxk+zFQpjCehrjR4PoOz0+Re3Eb
 5s/1cRaG23ak2nV95ceHXYywruqkx2E3eUa/wOyoQPCx0A31P2e/m2xq/46jDmfKJ78c
 U1NI8LHVMBOwRe2syPcQ91E52KR3c3vPcjN9mXwOy6pfkEWTYArHaLNb4tJXvvRLyuPi
 2wDjyY/1sLqmu08Bx2JVYiUwf48Y29v1xLpSWTEHfyc6crDn9Y8giXUg0ClurFCxZbJU
 4XgFQs7qW3w6wvxXI8hOIPE20DFyR0iVFqQCgq5oz+jVmuCYugijY0k4svYtpQh2KAsi
 ttxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705518; x=1790310318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kYUlt20I8KHIPYiSRmKgCElsTxWsdBrolVifzGqZwc8=;
 b=xNdYplDNl2EJkyr/DkLMDmfj33yUJICTBYfHciHMNesbEWOqM0dy/HDDtaIhpoXVaQ
 8Y8qqKJZ2Hx77EnwO/7MBMpgZPztzJ0yUWzJ8kI38Qig2XtxvFcYKZgJuH3DWE5jQNIx
 E5IswgtjHNjP3bz040UizmDh3ixFJPHPzgovwEHYxxSI00sSxAfT5sKq13kj0TTcwNPL
 7GSrDqXLbnaGtWLm49WOz71cGCZbmOlft/zP8P0aj+PzHhaQUhkVP9eJHBxKHX7L/pWb
 vWu3SxozrsSi6JSmnREtKn+sGw26Jzzv6XzvKFXbcIdjRQR0WeQv00CTU2csZiB+y7Lk
 w8sg==
X-Gm-Message-State: AFuF++nQVYp8AgAtFVbfCGzJ72Cd+d+mEqkNwJOUEfimuW2GY2XCCiUW
 G/xkMETmFUioCDPAPrw6Wcc7td1ry5/T7r+NlWCp0rPcVVJgpzmvdr/8lBk7afMTZ4y9kVCJxQf
 bWGZZ/yU=
X-Gm-Gg: AYBFou2tt4gf6FS0FYpLOs0MjoGcKCidRCboMnk0WQ4rvQKhbplTcV0igcc4eHPSfrS
 ViMECwMzwNx8JnlrvnwbdfHTRYcJEfqL6FgaAYa/EODucj221gQd3Ul0wHKaM2vZ4yT0nu9zR9R
 TNXbuB3192R+wJwoJfDm3c9/d8dIHyNW41lDMmeEa0uj+CszRBWu82F8wDnlmIQPVt4lTqBi3dE
 L887xwua2PCZL2/b9vvfhQfuDKY3iD/1eKdJtDwC+BwsXTooOsU6V8jgvHd0wXy5hzbD8Kg9FRq
 UyxeGczhV7DzLLMGnNGRPV2l2g6189ojPKueKDxq4uMUbSiGGXRX4+RL8ss7PF5AwrUxgwaq7SO
 mdphdf1r5dqAnbCunODsGl48AiaFGC2Vxs/4yQe/bIESb2fznjFf0adYhbL2c6R/FHo0/X+eKZy
 oY6IBr4ghLScMp/HA93c+W8V4hEQ9ONXqZ1ZMRgxaP/tufsWltUD/sO75CeA==
X-Received: by 2002:a05:6830:6d27:b0:7dc:4947:36a1 with SMTP id
 46e09a7af769-80de159c14emr1628338a34.12.1789705518433; 
 Thu, 17 Sep 2026 21:25:18 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:18 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/41] bsd-user: Use target_suseconds_t
Date: Thu, 17 Sep 2026 22:23:50 -0600
Message-ID: <20260918042422.38713-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::24;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x24.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

We no longer need target_freebsd_suseconds_t, so use target_suseconds_t
instead.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 7646a52744..4af79669e2 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -128,8 +128,6 @@ struct target_msgbuf {
  * sys/timex.h
  */
 
-typedef abi_long target_freebsd_suseconds_t;
-
 /* compare to sys/timespec.h */
 struct target_freebsd_timespec {
     target_time_t   tv_sec;     /* seconds */
@@ -151,7 +149,7 @@ struct target_freebsd__umtx_time {
 
 struct target_freebsd_timeval {
     target_time_t       tv_sec; /* seconds */
-    target_freebsd_suseconds_t  tv_usec;/* and microseconds */
+    target_suseconds_t  tv_usec;/* and microseconds */
 #if !defined(TARGET_I386) && TARGET_ABI_BITS == 32
     abi_long _pad;
 #endif
-- 
2.55.0


