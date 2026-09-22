Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73446C98306
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964B-0000bZ-DX; Tue, 22 Sep 2026 15:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963a-0000Xn-8L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963X-0002Nw-GP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:34 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6ed1de994so202049b6e.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104890; x=1790709690;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WCbS/CXY/RTWtQaFnNbXhvG/7hN5jeg2nC9MHaPKqJQ=;
 b=u6Z57iTPsl1Yb+VTxtGu00fesCWLvuGR+9hcZbbXRGLD79p9ZxOEUQoY9ir68dJq4O
 7ngvupwZU67B8yEw3ztVFPd3wuJoe3zzK8lAcgBqXjyOQ4fTRydzzxSTYa0TOoLefu69
 noAmDz/Ejjg3CSC5Yj5hHITFvUui6drSmgAfJseyF/2yu+Nk21yAbfcDaPvH2O9glcZe
 nbkwejA5fdHqXdl7NQy4wA8CwTdVi8rItN1KlAywtvVO4odCiAIrWlUoC7AA8fSqrZMw
 JhxAZBumct6NtCjmpIVMCttElSAVzMQEedxZPV3iejy54K/C5ftCTqt2m8Tx3jft/QSG
 1qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104890; x=1790709690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WCbS/CXY/RTWtQaFnNbXhvG/7hN5jeg2nC9MHaPKqJQ=;
 b=DvXx4IoeCZ8k0bQI6mphymtMJgDeovN7HWvV+E8Xh5b8b1HZIoIw1w94wa3yw9ZF2b
 spaGDAHwNYDUDLPaxgr2WNEvG+/h8SP21t+4dWTGeATXLyJMAwmMKykZJ6MG/FKFaNCv
 JMwPL3T70mWgGNtNx3kwwT+idP4BUlfazVyOfB+qwR6kVfhS8+1rb9+VnAhagZoKKkFY
 l9z3icNXPMyXm6+8SeqrN9k1nrhzz8DWt9wGAsmMT1YDG2cb70CpH0zxP+ScL+pIO3XL
 kVbba2ks3HkTDKfkMmJEFG+qWWoQDW+VlTqwhUIqQp7iGUt63zbe073Cfaa9MAxxY2hN
 kHnA==
X-Gm-Message-State: AFuF++nkNPLIu4naSshtbjSpJ3qWMTwG0Q9nq6l++/pddYg/ASdwvBsF
 dfLJo9C6SDbanOht2ncdPfMln7ExpXr0R4CpL0T6RPWDRJU3rzB2eQ37KKi+0qUb+aOPKszyeD6
 8Uvhx12c=
X-Gm-Gg: AYBFou38D/eqzcHEEf0HgOe6HU+WG7IIJ2NPRf1vpiRUL1K+/rWqCOTu3bAvDmwvCKm
 pQ/HfTicaHRN6c0SfRElsAmk6NRUvZP0iMR1JBC4ktH1AhIMM8VVrmWOsZfyyvcVyAIjE70cC9m
 5kUFX4MApu/3RbHOgQ0zJ4f8KlsA9oxQu4uiB88eNTLg5MUluBt3nuaS0+VFkem9vTWlSRrPrte
 pVPjZnPsK7jNx2EVizPo+GfHKepPZg1R1/pcD+vmu3nrIkZ7MBXtisFO2yf/dZpzcCewB4Phdps
 J7S13obpNZDm467/XF6yFyo5QMLS2Woj1+umaLpjtKRq2jt9GZtLp3iSfV7wVvRFGjHQ61LrZ84
 9UVw7jFT6Z42u4gIayPxxJmFMG012/kcgZiGf4s/fv82PuP+dnodBGRA2pOIjlHxgVKEBUm3m4J
 G/Ys7zm3050rn5ph+iNRn8cBpFsXZFDSWl5GMZKjQPwU67k9J6SnPjjIK8P+yV9YSXeC0U
X-Received: by 2002:a05:6820:1ca9:b0:6b3:1874:6f21 with SMTP id
 006d021491bc7-6d2cd07afedmr441952eaf.0.1790104890213; 
 Tue, 22 Sep 2026 12:21:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/11] bsd-user: Drop support for FreeBSD 12
Date: Tue, 22 Sep 2026 13:21:00 -0600
Message-ID: <20260922192109.98467-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
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

All supported branches have these, so we don't need ifdefs anymore.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/target_os_user.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
index 9703b9a61a..688da6c81a 100644
--- a/bsd-user/freebsd/target_os_user.h
+++ b/bsd-user/freebsd/target_os_user.h
@@ -297,17 +297,12 @@ struct target_kinfo_vmentry {
     uint32_t kve_vn_rdev_freebsd11;  /* Device id if device. */
     uint16_t kve_vn_mode;   /* File mode. */
     uint16_t kve_status;   /* Status flags. */
-#if (__FreeBSD_version >= 1300501 && __FreeBSD_version < 1400000) ||    \
-    __FreeBSD_version >= 1400009
     union {
         uint64_t _kve_vn_fsid;  /* dev_t of vnode location */
         uint64_t _kve_obj;  /* handle of anon obj */
     } kve_type_spec;
 #define kve_vn_fsid kve_type_spec._kve_vn_fsid
 #define kve_obj  kve_type_spec._kve_obj
-#else
-    uint64_t kve_vn_fsid;   /* dev_t of vnode location */
-#endif
     uint64_t kve_vn_rdev;   /* Device id if device. */
     int  _kve_ispare[8];  /* Space for more stuff. */
     /* Truncated before copyout in sysctl */
-- 
2.55.0


