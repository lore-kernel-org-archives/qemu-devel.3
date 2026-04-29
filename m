Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF6FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6CG-0005Bm-HM; Wed, 29 Apr 2026 10:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C4-0004lK-EA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:16 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C2-0004fC-FN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:15 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-673ee2a98b1so6715318eaf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474032; x=1778078832;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Io57xFIzSdjFwvyqCc7fTyL68avblP79bNQWneISrX4=;
 b=ENZCLEkFqtWuIQ3OfxUc1HeWYZGniIGV0kUTq03hFyZFi9nUjU2eeng0iOoDM/0FFq
 uiq2Y1DwIAp7CUGex7cRj7x6OxHMcy9We5Zqe5orhsh6UhiOwpl5Cv0+qwVISu9UeQhi
 UuBTRdvzRoWXKQnaDTfjikTORjGWN2sQtvf6Vc2jzT+pJw5croAXkys8HSLbh9LbdqzA
 Ah+wEYBU4Khq8vhBeZEW8NV8242XeoTXfXLyWiXYN2nLvtMlOqe/I9fx29HnH7eP0Pil
 JwYxUsVNp21xb36OfRbl4EYLEptd95w1IQomCAUDNhNgh48S9WlDtYW1/8N6oim4LQsS
 vUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474032; x=1778078832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Io57xFIzSdjFwvyqCc7fTyL68avblP79bNQWneISrX4=;
 b=QLbfYcSZnJ6+iM+nVjBOdSNepdhIF2m/57I+RwA7maeshMafg7Bv3cnCU19lklnxqE
 6pj0hWhDm7GZq9RlP0trSPVfloybEcXaD2OhHnN8TAeUeKHewqrVT5f9yTLr09UobSUv
 r4sHvwfMuDyIOzZka252P3WuDZdIHrQ9Fj/hrQ171NT1gJL7THpaZkiiRCtpPx6UXsYJ
 Ckn9l306xNUXygtnMk26wbmYiAp5rGIYqVpYMr3GM2LpRIzjCQmLngOQbEuusDqdI17+
 CdfO1sT9zyMkBVT3cObPj40l1acGeF+36WBnJzsiwrjoB1kZWPNtHizVrD/MMNSw54/a
 8ZLA==
X-Gm-Message-State: AOJu0Yx4FEfsKaE8Yb7JKmmw3sMh0V9PQ+MVuV/KvIXAjIdpLa+Lm9/T
 VjRfXJehzbjJqCUDhFqr7s2w9katpzGDMzCE1bygjRDRneS3Ff6giRSHh0ou04yEHvs=
X-Gm-Gg: AeBDievNz8l9g6Cvsexe/tt4bKM416p8c2sQQneM6ZhsU7w7kAZ6+eYSUHWFq0hkSAz
 4dMi9q2wdFb/uJ/UwZM8ajf4OLpTKMRoXV8zL5Myi2Bpvd/BAlQliHa/iOtvWvdFINgNm2VE0lU
 vBk8Wh/zniLVcyqWPwbd6KNL1qk1jDLs8Yg2s4sWgMf9j6qAgx8OJJZ4HfI8GWRhxqzKPFOuPzJ
 d7tcxrNbJEY6sM23BMQ3LjwIGViGYVQyu+1xUmgK36tKcLBI9hMQM0XrX81RtaSe9IZcCyGA1A/
 gnb2z4LvhNs7tU5aFDOTbPdib8F9M3VrGwkOBmIzIQC2rmkyMnQNg0xADFCsn4K+xECCJ+P7n85
 lEZjT+TCtj6w1oZgMFVbe+TYPU+E1O2CgcdLKshDkeqrribtBBEmZT4cdeQ6F4bEExribj+IC5r
 FBobXzfJCnyp0Pr6EZkFuuqybsevdi/rE=
X-Received: by 2002:a05:6820:f02b:b0:696:1ef9:e089 with SMTP id
 006d021491bc7-6965caae4d0mr3802341eaf.25.1777474032643; 
 Wed, 29 Apr 2026 07:47:12 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:20 -0600
Subject: [PATCH v2 14/17] bsd-user: Add target_to_host_sockaddr_in6
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-14-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gptYB3Ta+ssbSfFtE/iXz28A9edNGVvJaAH+IXwJ/LE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl99yIUDe4uxwWzbbvzQsy8A2bmd1MkG1RkW
 y4Xwcfgc1GJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 ACZTEADOMqUm6aZ9wKL92SNWjtzRhtGGeWelbWteNnWvbjZ4AC+rKIqqySKiWcpOLf3kdXce/r/
 /jCSFqKaa5ZU2Ko8e9cvNWnykJkP3jr2KO11eU237yEU01/k3q8OtuOkYvdjRhd/jP1w63obw04
 68rP6qcVCsu8kbgyA6fPraVrkG3qgnAW3W2bZa6/WlBYrUJg13dEr3CL4x8Tdwi+IMHBYZyRybh
 4enCEbrqDbF7pTwM8kmyXDthk8xuJFfzCK8C7lGSYS6QtFw/e7Q5bu5mi2lrlzwk0DUu5qjOT8D
 l0ZpeM/cQXlteZ5IzgjexsW0e6eFWcsZb5AmUQ3Lz3gAoJ5zi35uDVfLf1JSwnSAOMOkwwl7P+2
 VF+aUEeDfgrguZ5xDyZMWDYM4myuPE06MyH3nRu9EwNhx/I7WQ/oKzmVj9By14P+5e/cjhz5aCN
 RhNTvRiz5L+nVre4tJBrp/J0ET2+oyJcPy/oL2BCkgaOgrzxPsHawwexV3d6nRerAGEPWWaGfo7
 B5B5/g3BVIFeLJnmym8CPHkN8BkXYoyk0B+IWdyWuVir0QSo4wuC2zH61Lf8ZtBCL0Vq2aFZvL8
 evah10HSXGf6vdcWbTfdYyN0tL3dLhPUDliKeVXR714t30UMxzTzfh9gR0qKKiP/3QI715Nkjsf
 +wMCTD+tVrEcoaw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc33.google.com
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

Add helper function to convert target IPv6 socket address structure
to host format, handling all sockaddr_in6 fields including address,
port, flow info, and scope ID.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 41f310c734..2ff37a0817 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -251,3 +251,14 @@ static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
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


