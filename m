Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2742CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWl-0000SU-Q5; Wed, 06 May 2026 22:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVl-0007We-PL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:54 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVh-0000Zq-6W
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:47 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7de431da8fbso308884a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121043; x=1778725843;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/QyHxhh955w/HPRpKuYJ0dcnEhs1tLz/1RAUl0qOaU=;
 b=Zfw+j6dM5PPIiSXLA2tvQgj5yvUjJJ84GBdS1UfL69bbEHQ1pnsLBv4DhGwq6Q66Xt
 sz9rYB4Joc8BRrFrqETWiQfNZnWutb7FRFlTg4/73iW2qnLKtH9tsM/OOUDhsF0wELMX
 fz9m1ozjg5RyeVBvVz7xqwtSvRaG9dZlUybrEXg4i/lPYYkT8IC1ifftDILh3UYxF6Al
 IjZZvoKxGVAUXoZPMkwKQbsqD9POd/aO+SJzLWzSFdZCW7b2fZmZda8X2QQiU5vBLKWV
 koI15WrqOWicvAkCqwIS8VlKtAaGf9NLJUKERqtpZcU4cwiZ6ygsuljaTgdhtHgQ+hZ/
 vvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121043; x=1778725843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/QyHxhh955w/HPRpKuYJ0dcnEhs1tLz/1RAUl0qOaU=;
 b=bMKZUntDYfdk4FpThLDKmc6KGO+i3OSNbZUa5eW4uD+sgVW1MsJkEqiOQwMtwFaHjT
 0gvnNBgbLMuv8baYV8zHa/bzmjfHMvqCg8m8Wmz/pvnIfmri9lb6IvVTkeOq0C2D46xJ
 pASt28v8mWE2RikOKvrqOchxiTrb1swxsFihcY96J9bHl2iwtWUMDnvYa5Ou6rk1lUjY
 51iLS/joAINXXgWaKWp3gU67tZhaXRkZyLWhSYBDwQImJOi+ulu2XgkeM8QFaTNOP0Hw
 j6ODiCEXGcrXwFAD3CN9vSwQoLBO2BbGXhqcD07wKRZFt1RaebXHcNC1Lu2xTtgwfyKU
 2tkg==
X-Gm-Message-State: AOJu0Yxt/Fu0JGvd8lwZoZToT/6lJF/kInYTmESLAfwOEpGJNRPXpHCH
 MMPLvUXrp+fQIXsyEeI1tXkOqZymsCIoBv2zuo8kGsZj1+Im4A0LWQTTI+gwxi2UhXBb85fL7L6
 qnReNX8c=
X-Gm-Gg: AeBDievI5JmZNnFdxs57n6QEjpzmNueic2AahhEW0alp2RQFnsMNZxGh9eN7au8vmxy
 y2D2LQHlFibyrq3fPMe7Hv9eTyTahuFusTuFQtC7X5boJbEteg1Kjsecpbw1vL7QInukIJnEHB4
 xsgg89weaD+PfRPtklpgZ1QZlQOjEOl7vDgHhYdDUnUtPgnI+ImJKmdaqfF98D1WBiHIKi119jQ
 abqtaB2Ml949hfeT7eVudQ6Xll0QwG3EoIR3qTtdC+v4y3riAuQhyQS4QjQx1v88HEKJ9nXqiNp
 qdfZ+q6ZyYUzANQcbvbUbEZAY0xkiGP/4ptwcErUTbPTbQhAN/sNjtMXeMmA6Usg/XSdtZb949h
 JpOWLAuwM/8dg1fgkEq6Ke/bHslmviJmVmC37reCr0fiU0eOivUNnaTpX8dtAE7zDz1isnSXk9c
 v8CTgqjoIKPWUR/ASZi9Jm09R+3GVWxeA=
X-Received: by 2002:a05:6830:6f8f:b0:7dc:5899:c711 with SMTP id
 46e09a7af769-7e1deec9014mr3930683a34.3.1778121043324; 
 Wed, 06 May 2026 19:30:43 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 21/25] bsd-user: Add target_to_host_sockaddr_in6 function
Date: Wed,  6 May 2026 20:28:23 -0600
Message-ID: <20260507022827.44499-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add helper function to convert target IPv6 socket address structure
to host format, handling all sockaddr_in6 fields including address,
port, flow info, and scope ID.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 69d1ea1718..d2eb9105fc 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -249,3 +249,14 @@ static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
 {
     return -TARGET_ENXIO;
 }
+
+static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
+        struct target_sockaddr_in6 *tsa_in6)
+{
+    __get_user(hsa_in6->sin6_len, &tsa_in6->sin6_len);
+    __get_user(hsa_in6->sin6_family, &tsa_in6->sin6_family);
+    __get_user(hsa_in6->sin6_port, &tsa_in6->sin6_port);
+    __get_user(hsa_in6->sin6_flowinfo, &tsa_in6->sin6_flowinfo);
+    memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
+    __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
+}
-- 
2.52.0


