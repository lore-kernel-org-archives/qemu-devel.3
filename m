Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7C5C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAA-0005Nw-IE; Fri, 18 Sep 2026 00:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA7-0005M0-57
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:23 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA5-0004Aj-Km
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:22 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7ff1e4ffb3aso141870a34.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705520; x=1790310320;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mDkP0dtWB36TzbGajHdmCtPZU5XPoaXCX6IaOFZEw+0=;
 b=nka5stu+ZiuiyOMJxvtWo+kNQzLeK8SVzPEuuNEjw4aN0hh5sFDsEr6sjyg9ZNIOR8
 2PnTTaPj7puhfVbyqhVveukym24skaBakayrnYq3Pm+vH43aUBkYDW3N0oBOoA/V7beo
 bXcL7iigJIl4m3lqyG553LtFpzSt+H4I+fKi0XcG/cX8SOn4qCncWJYDEmQRy8jpsir6
 dkbgnsDI0vORaZ859ZYxYSMBTZ848YDMbSsyhI1oQM5zBjaJERUf6WY5ZHAqJriVLj3N
 5Zbcy9FhkmNPJnPNj+II6JpphHgwbYZPLJtDu+ONUpuwewchViNnkzey0S1NoICmlPEY
 uCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705520; x=1790310320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mDkP0dtWB36TzbGajHdmCtPZU5XPoaXCX6IaOFZEw+0=;
 b=LvcvguRsi7HyIGsblptFfLZibkQZ6SgipIWQp2DYqHPsAjI6PkdE2S4FvRB3gsay77
 DWqBCggFK9AuwtdVySMMZVuGXFQF/kjmdZVIiLEoYGuRZVeCUA4UxWnFp2IlVm5h8OEQ
 JIlZgVGJhpSPPFW1DzAzogDzTTXr4uM+CL9HNVOxb5b1eKZlvOjGLvWosSWnfQ87thQ2
 t8lI7GqUBsP6EQNEr7gwFjeZLWdzbC9dMzbG18oT7siDaOwvCTdpkwzTNf/ubiMPqTuN
 OUpTsCWm6Gf7jpnOJsIIUYEgjnP4LF1arG3Xs0Q3zZkv1nAZm6DT9QPvFzA+L+ENtT5i
 jUsg==
X-Gm-Message-State: AFuF++nv7pdQl24dpghj+kvY99nMWXIX63pktBLdi754y7FISUX1gZA0
 HcUmdOmuz+bOlJbXpC/94tpdL5BLqQZRgeSelFPUCOXYwgv3qvpHyQSrr/4n+SkkyuPl+YGJySX
 M0M2QBCg=
X-Gm-Gg: AYBFou3AnsJvVhCPDZ/rDAroyREmj8O+THV58L5/hu+ehsd0xceJox8BbWWznqNbImJ
 j5RhRUyg5rjRjcYnt3JSGfuA1ht7LOCTIH7GKfvPeXZ9w2P6L9MIAW3MyF+6S4xZ/A8xUVCVBbs
 xYHM1XvE0gbJxngxf1r0ewtrH8CMAU1te2xIJbWxXDiZPXkd7IiOwOO/L6B8ruDuiqds1mMKUmD
 qboN1Zo7ZX7GYj63xccfUn/SZJZGl4eQgnFaxRxKyMmuDOtQS+VSxlLqb35Brt74lGnSAHGyqHT
 d8b3D3BK3Swb7FIHIqJc4lRSoz/rW+jKFV8M5GpdDXdpokVzDizY+3SFNECjYdJKEzwsEUF1hH8
 9p/Q3S1dDhQeomzmXPdOXW9vOnegVom3cnc/M+d424ZvyYnjYaRricdcrXAp9jAGpemF2t79LKJ
 JtEIKOWywWVrAze3axIth2pnVljK3s/a+4CxS6L9BHkiIbuIX9sL2DhlJTvg==
X-Received: by 2002:a05:6830:25c2:b0:7f8:4a55:b82b with SMTP id
 46e09a7af769-80ddf967e8fmr1628859a34.2.1789705520594; 
 Thu, 17 Sep 2026 21:25:20 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/41] bsd-user: Fix realpathat for FreeBSD 15.0 and newer
Date: Thu, 17 Sep 2026 22:23:52 -0600
Message-ID: <20260918042422.38713-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

Fix __realpathat to use __sys___realpathat on FreeBSD >= 15.0.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index ea95aa6344..4e5fc30de4 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -622,11 +622,6 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
-extern int __realpathat(int fd, const char *path, char *buf, size_t size,
-        int flags);
-/* https://svnweb.freebsd.org/base?view=revision&revision=358172 */
-/* no man page */
 static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -640,12 +635,11 @@ static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
 
-    ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+    ret = get_errno(syscall(SYS___realpathat, arg1, p, b, arg4, arg5));
     UNLOCK_PATH(p, arg2);
     unlock_user(b, arg3, ret);
 
     return ret;
 }
-#endif
 
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.55.0


