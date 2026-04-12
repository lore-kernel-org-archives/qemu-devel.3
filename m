Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA76E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxIC-0006Ue-QO; Sun, 12 Apr 2026 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxI0-0006Rv-Gr
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:04 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHx-0004Xb-LB
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:04:00 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so2422949fac.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009833; x=1776614633;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=umfzvOji71umc53PSuHoNWCYUoaF8ndU8jIV+mTrGw0=;
 b=lub+rRRrHz0wc04WMtXrPNVRcbi72Dh+P5vZ7mHx+vt4K2JAE8CyhS49UnYIkhtO8m
 b7AdRGs3TxWxjN9InhGWzIGIWl56EDdOHWKC/wo8QJQdj18kzIRsM5y3UHRt7WwFM7kY
 mFNMRYnDaqP7ZnPy3OoJr9JIi+FmfVKY6B6z9zBmcTqNvczQVPLPb/BCGchtlbEzqKN2
 t9VNcMBEaI/+qHXAzgHPtiOzSFqJooQjZxWjM7IJV8S40GlhGGLrPq9y2a9FzmKoluZR
 NRoAWrmF4QJmLRNjIrp3zBzevCEP5kDC0zZsuQfk1nRwHJKj3W5iyLnKh1NdltupwCmg
 m5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009833; x=1776614633;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umfzvOji71umc53PSuHoNWCYUoaF8ndU8jIV+mTrGw0=;
 b=r2c/k2EWLzLzhmTD4a9V6RfMslRelWxR6z8JgRVQ5kFOQosqCJQP1eA2kqnfO372Qz
 /DJ8uq/BJyJ6UdhTD1jZoJHMEo2+bnKicSJXTqEs2ApMTkrJwqsSe/xXyabdwWaF37ha
 NVoVkX/3uFPhbSb8/sSdBrKKRYehbK52YnzrK7SSK2XeOyTjH9oaPmIUyURxcEl/FqLK
 PtyF5/Od+XPrZEeLUuaGjgUTtZSVwOTRD5udjd9MMISwZY2HfpriAf/CfuI7NJ51J3Xy
 h2LFWzauzDVE5Ed0s0P1nMmGgZygcBkQZvXUA3SxGOcwgXYjX9AaAjdWJg5px5ld4kUJ
 dmqw==
X-Gm-Message-State: AOJu0YzyGI729FvMsdWqIdgJ1kNToUgN0GfGzrvVY6VEoKqNvvBuyse1
 4w6Xy9i2HDv+IGTT0ngHc5n98YMtvwAhb0aIeWz3utxngtkBUq9Z1RQH689fWGcuyzJghAjyHPp
 mCssIXmA=
X-Gm-Gg: AeBDievlWAiQhvPkex1P+rhN7T0YU/nUoxImq/vXLPxhancx/AdttrLuuUWPVE7y3Dp
 LtpswJ+/4xUyyM33PmcqQJHXaQB0yMxIdovwSIWTbwyekQYZgLakewfmr2bj4J7ZsGi4rknViEe
 N1Ksnb+LWzyeIgrcaAY04j19BcyM5aZuoEr4bLfXNqBWx0WjGZODII1KIksWuc97eoMzCAZC+mI
 WNJbS1tkBwsFR4ZqF5RWhyT+P8uL8u7jNw2A76ZtYbsPT2syKicNxD6EY/hlah7rP56YH20icig
 jg3I+IdObCprYa6IJvn985cZkr5hyUqeVzy6Y4Y8YlHVhVnuNmNnWEJV29gm4nboGOrwi1zJSxB
 ZPa1e7dUiCmV1wnYUkq6ZJrNWu/Vz/0f+79ZqCfwu6g/IDviCZDUWu8dGlcxd9NfGBMzcTMazHF
 L1BmF8rRGXLvC8ikpB1ig2
X-Received: by 2002:a05:6870:e131:b0:417:6402:395f with SMTP id
 586e51a60fabf-423e0e18313mr5817252fac.13.1776009832751; 
 Sun, 12 Apr 2026 09:03:52 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 12 Apr 2026 10:02:38 -0600
Subject: [PATCH 15/17] bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-ioctl-v1-15-1d998a460560@bsdimp.com>
References: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
In-Reply-To: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8zLJUOP9iTXAdsPkZjgut3g1hr2+Sb8fdxbKAXICtBw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28Ihxa0JsbGwDGTQvzuaxXu9vvL48pgmfXB7D
 VDUsAZpTwiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCIQAKCRBsHNEofbAR
 AE0wD/9eCWRLn9h+D+WuazBggeU1wHs3n8YwK+DjbvsByfOUg685siLJDvsMvTZ9psgO30VKQ9I
 1fDhbBuqdFgfeGZ/JAX0kFcLHCAy6u1ygjqU8o62hQCBA/Xtf1KxX6k2QXYFXWg7v7K1HVPFQuR
 NZCZzfCfyot4rj/h23uFjiuEzTiu4tmdoCCxZVs0c2Xw5++yLGt2dGtZHq/RJ/AJLYsZ8gHMBTH
 PM1HgADI6ShbvtpzHUE+yqVTBFarjx2h6jlwpQRB7y2iiA2Vbg6B+hUAL+iM5roEGgsX5N2kj25
 snPhcNHsxxv4bB9qpLP0GQzcny9raA2yKo5v3nD84T/Q38QHQ0Xq+DPOSqw6qKBJFnJ4YppZAEc
 IYrystuEGWo5TiVwMoLx3ZwN0Jw6R6a+kFR5ECqVxi8maq+bbN+Mws9wD/KJuvDQ1umaDiIkFo6
 iwCLGTZ7XRv+GkVTu61RfCt/qPgf8EU1b2TBNr93ilIFnrnQeDp6+v13cReJygZKmBMIPUKwdr0
 iuEAbj9CdkynJV2zv6pUtaXAyr9SuKKTEkD0xiqFwTXBy0wd5AbYX7x28+3+MyvCkOIX8U+UYSp
 /EEGIyzJrSA8cGwMiACCXzTAVAIORlIIFGm5ULhh7KTqZ19p6xYhvi4sqn84LvF8r1x75Dt0awb
 zJ+U9EqMB2y6amA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x36.google.com
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

Add special handler for IPv6 interface request ioctls that take
a sockaddr_in6 structure as input and return an integer flag value,
such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 2ff37a0817..aa0153bbaa 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -262,3 +262,35 @@ static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
     memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
     __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
 }
+
+/*
+ * For ioctl()'s such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6 that
+ * passes a struct sockaddr_in6 in and gets an int out using
+ * struct in6_ifreq.
+ */
+static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
+        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg)
+{
+    abi_long ret;
+    struct target_in6_ifreq *tin6ifreq;
+    struct target_sockaddr_in6 *tsa_in6;
+    struct in6_ifreq hin6ifreq;
+    struct sockaddr_in6 *hsa_in6 = &hin6ifreq.ifr_ifru.ifru_addr;
+
+    tin6ifreq = lock_user(VERIFY_WRITE, arg, sizeof(*tin6ifreq), 0);
+    if (tin6ifreq == NULL) {
+        return -TARGET_EFAULT;
+    }
+    memcpy(hin6ifreq.ifr_name, tin6ifreq->ifr_name, IFNAMSIZ);
+    tsa_in6 = &tin6ifreq->ifr_ifru.ifru_addr;
+    target_to_host_sockaddr_in6(hsa_in6, tsa_in6);
+
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, &hin6ifreq));
+    if (!is_error(ret)) {
+        put_user_s32(hin6ifreq.ifr_ifru.ifru_flags6,
+                arg + offsetof(struct target_in6_ifreq, ifr_ifru.ifru_flags6));
+    }
+    unlock_user(tin6ifreq, arg, 1);
+
+    return ret;
+}

-- 
2.52.0


