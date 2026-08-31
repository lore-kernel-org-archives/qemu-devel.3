Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E521BC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1BpJ-0007J2-OZ; Mon, 31 Aug 2026 19:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roiklevansky@gmail.com>)
 id 1x19SQ-0000fj-U4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 17:22:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roiklevansky@gmail.com>)
 id 1x19SP-0004nf-2b
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 17:22:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso3770095e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788211338; x=1788816138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z9WafF8jVdm/lbhcxOaSLb+RwsFR/e0Er5SXOPxwqg8=;
 b=bdIU5ytxG8jgqTTJWU+/o8BsstSHcws3vsK97ElTLg76V2jPq8w2RkiN+Zwbo5wMKL
 7UwOKu193cc7OyJBu/aSRkTt/zgbXx5iPSQWCO8Te0AH+B/hfj1efurFZ025uI02Xl2B
 SHcJBuTrjzQ00RsPhg1c6xDUmJHXfrNz/JGnFSdf3gVWNqJXa8WRv6xZJofzL67SOOa/
 +hBfHVX5rhjuISvUt+ce/Fy4oE6efxUAa5uR8ENQ2BnYAY2jlPRoLtdbmwHVCi65Pyqr
 Z2aR1A0VRTgZLiWMvBPKrZ6nOdkVlUVfuyFg4ogNYgZmgt35dKeGli7EUu1H7iKNmAZf
 xvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788211338; x=1788816138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z9WafF8jVdm/lbhcxOaSLb+RwsFR/e0Er5SXOPxwqg8=;
 b=HyeIrcvZs/HNYxQAE1xGT8oPpYt6wtuz/HjAkVI1fF8mgtUEb/TGi7lYxKJEkZUfS1
 xGl63RoEpqbr2Z0qjMw6eDUy6fhHOGbh1BvqlM+CMqxx53XAJwIexAnXLsLb1iIdolA3
 smQyXb08Sth1IrZWkAftA/j3/kox0CCfnR6ebeb3MuE042ZZwlOvi/XkTFf8GGeZhjRZ
 dlPO2IQydvttK227B6ruqpvjwE4ERt53sRdfhVrL2UCi+qrVtwP2P95sKqh31+v6dWl8
 0L0pHtdIyCmNUlFF4HEeY/LOulykZiVeVEU533YIq++44cv74K2ryspkvPbQsLAkoyRi
 Zj+A==
X-Gm-Message-State: AFuF++lqtI6BIVzQ/LBTu7YE37niJ+zK3a7iaUg1r4BFW7vguj4Ol4Jw
 yt5qMdHe8nLEcx7SEHbfQipowqanigJYt91Z8jL4RxBJwfB1py2csYVt2Hps6x7X9sjf5A==
X-Gm-Gg: AR+sD11PC5JvuXKsfkY6edYSTFvhou5UV1+5JryDSsohpvgZPCHSF/WTztA5AtGRh67
 NFEMD8tubBS8UAhOJbgf7s40eR6wDvEhdcOpVoO9z/Usc8GExIqalAvSSbuQd64jmujvrnZB7zm
 W2Zmt/PScyavXVNsrfXqCIg5+g3+49HawXGKlO7zwgyv4dq0wEVqoxVL/NWJDOxKBwWYZymHmto
 m6lSArWtlyfTzxI+6Ts02Tm0I8LCU7XWqSZl9K2YysMRz0W0bX/57k04zyo0del4c6kReqioJBF
 5vAyLUKdKaOjj2U8WWQUoJjWp1mQlrtbiIgWlx1arYmLLoHQPRBt1ThmCK7EryHO5GNoC91I9cW
 STOrdKLY8LtrP3kuUlI+ek6XduOriurW9t/uoUd2EAfuElBQOE7wyv+J/l5xM86zeIgPrtOCiEz
 8g7UX1glswM0prq11cn5UcTYZg7vxvzOSVbao9VjjrzFF5g7S77h66qOo2Dti1ncCYAVk6lCh92
 ACbyP0WKJEhhrXKiYGOciwLs1LDcYR+BUfIcxmR6UddjL7iIr3YFv5zKSIUnQ==
X-Received: by 2002:a05:600c:4e4c:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49cdd416ef1mr14051705e9.4.1788211338104; 
 Mon, 31 Aug 2026 14:22:18 -0700 (PDT)
Received: from sima-pc.tail8094aa.ts.net
 (CBL217-132-71-241.bb.netvision.net.il. [217.132.71.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce10148sm18749815e9.5.2026.08.31.14.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 14:22:17 -0700 (PDT)
From: Roi Klevansky <roiklevansky@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Roi Klevansky <roiklevansky@gmail.com>
Subject: [PATCH 1/2] linux-user: return ENOMEM from madvise on unmapped ranges
Date: Tue,  1 Sep 2026 00:20:39 +0300
Message-ID: <20260831212040.1833650-2-roiklevansky@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831212040.1833650-1-roiklevansky@gmail.com>
References: <20260831212040.1833650-1-roiklevansky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=roiklevansky@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 31 Aug 2026 19:54:06 -0400
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

The kernel fails with ENOMEM when madvise() is called with a partially
or fully unmapped address range. This fix allows target_madvise() to
emulate this behavior by calling page_check_range() upfront while still
allowing advice specific errors to take precedence.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4382
Signed-off-by: Roi Klevansky <roiklevansky@gmail.com>
---
 linux-user/mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc0c2ee6c2..e5195cf501 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1305,8 +1305,14 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      * success, which is broken but some userspace programs fail to work
      * otherwise. Completely implementing such emulation is quite complicated
      * though.
+     *
+     * When some (or all) of the pages in the range are not mapped, madvise
+     * should fail with -ENOMEM. If another error occurs, its value is
+     * returned instead.
      */
     mmap_lock();
+    ret = page_check_range(start, len, PAGE_VALID) ? 0 : -TARGET_ENOMEM;
+
     switch (advice) {
     case MADV_NORMAL:
     case MADV_RANDOM:
@@ -1316,7 +1322,6 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
     case MADV_FREE:
     case MADV_COLD:
     case MADV_PAGEOUT:
-        ret = 0; /* OK */
         break;
     case MADV_REMOVE:
         ret = -EOPNOTSUPP;
-- 
2.55.0


