Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C5BFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6C1-0004iE-SE; Wed, 29 Apr 2026 10:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bw-0004Zs-I1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:10 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bu-0004bp-Vp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:08 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dca5f64e86so7988144a34.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474024; x=1778078824;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=flxXVM9IUYo3v5A37ldvuHn8wPg9FyAcz4uvyK53nnI=;
 b=LEAlQik/XnQYUJQfHzKLn8DjYpB2NPC/xmvHGrr2Yuq/cLKM9I73W3UG14N/JCcuj/
 zI+ZvHU498ThfW5ZldweEwM2+EhJu97Tc/WglSKc0PgZq9ebQt2Y40FKxw+YtPLxmtTq
 +H9TJjEYWTueZwRNmTBpmlQ9GaaTu3KMnds1vxBuB4X7ogPsP6ZOR3nRv8acuugSpEMF
 Qx1jdntVWE8VHB2PeM1RI8SgBwR15gdigqvSapPqR97S6AqISDSoOqEpHepvCINPT791
 Xhn3TmgCRqqCBNrEiUGni0Jjc+FdP4DrCe4SBRL53BAa/vHxaP0kjW/2ZUKPyWv+9Sb7
 L3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474024; x=1778078824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=flxXVM9IUYo3v5A37ldvuHn8wPg9FyAcz4uvyK53nnI=;
 b=F2eRFaz7GAIXLAnfuOdTtl122/64YeEOfKt6BYAdB3epy05zOoa9R5k8fhCyOuP123
 MbiB9k+m9DVzLu80FDiZz4D9sYE/tVzrHT8o4ir+tFg/cwn/RnX68wBAmay+wjOy0WLz
 gRZOKjfPjXy7CttHqu5M36GYu483d23bQnpqCrtFFB1uOHRcsIREDdtRy0xxwx1gUXUh
 eAW25rgmnX1VPuXXa1VWZWaK6R+oWAwyZ6VMh6sr6Ptj1Cp7JYG+PDApnjMYzPVSuAKv
 g7yPdBF8+iJW2YdAaKL7WvHsTB2aOt39Sy5AcsKQOvV0ztSLnYCF/XLY3n8Qot3KKDIz
 GP4Q==
X-Gm-Message-State: AOJu0Yy4LfDE0tq4O3YOHBbw2PBtlmhHcirmDlqs5TG7jI+eLU4ZZ2as
 yJ6A9+Sl6/J5hahix/TPMPe+NaLB1OQLMlSsJ0CXNcetaXBpADpGCNlpxz41BKfuzcY=
X-Gm-Gg: AeBDiesp0bHCLdsDTrf0PbPGlsrfHWZftBphO16mVVXjHUC0YRgdLsejz+3jNVhCTBe
 sfklzGCugSBnGgAjefxdJEgccXHAz2woTTH63//FKYJuN01dOabnHNz76KsNETWSFT+hBCa80Hs
 qNXqYWBeVO+8XywY4swRc4go+Hs5hPSg7srzkIXM/G2VN2kpfDPqv/7TJdIp7Dy42zucTp/dkqU
 VwuYgpQ7C7z0qPiCJGnyjmjL+h9kmHRiOzTLjdj774T8o+pAyQO34blILaYZtM8gN1LR+/p9yMD
 0V5KQYiW0watEn/jkQlYjfo3g+pDECKYAvJuC5YXlIKFPQhdpa+dqN6By6ceJd/5ChIcnTIyc0Z
 wHeZ4dDljvxCtOR7zPcWZl7mTWqBrVws/dRYWKqArUCXqzw8Qw1zATlXfKBNaEE3p/LMyZJ5acC
 tkWUNbnjV39jaOEwn4JB2f
X-Received: by 2002:a05:6820:1c8c:b0:696:2cf3:3bc3 with SMTP id
 006d021491bc7-696684f21cfmr1910299eaf.41.1777474024187; 
 Wed, 29 Apr 2026 07:47:04 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:18 -0600
Subject: [PATCH v2 12/17] bsd-user: Add log_unsupported_ioctl function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-12-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xbGD7IcDXbypQMwK7rI7j0iz7UJrizyHubokpLPYvRQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl948SF6Ai/tO+7OXoit/A5zE3r0e4KfFFUJ
 0wTI3lSGLyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 AK7dEADMpJqmSOQE/EGBAFmoRw+xeT6OfUSHwY0+SfeD/bEfinHJzPbVRlDTOrrOep9SDljbcUu
 kjgMrRd6FPI8gqfs45Scm0hW3vmCoXyxKvr1iso26yp2dEF+6Z2AxuqohwENk+F3jzZNGd/SWob
 xSRFrb+iPEh8Z3ziC6tLGArPBquOtptmhLwJmGmNkG2p0m9U8SLCqfe/m0y+YvTB+KMtDSxX8yC
 0Y5E/RDJKyFyOPswqvcLFmVvCvuITQvUOCPpDFs1e85FsYCC/hB2W37SQJ+C5WHw15Iro+sqmHB
 TbN1OToh4BLGB5IJQhXnmo/BmLZAsmm2WZNWO6qPUMvpWjLrOR+vGYiJ33rT3XCeLQN+RNnVZqd
 ZyXbvlx1bMRESgcXGaoWudJa6o7SoDnLXR5K0STa1Yu8cEddp0u7h1SKkIa/13KwOiJSMxykkUV
 cMkVyHFVQsyCvrLjfWwO9HnBdmvpPBhhTsL7G50VTSJxnuQLSDQBdjJ+k5182VituIRGJMAi9XG
 McAWpW+bE/J8UD7bsSjegqWktvsVJP6MqBha91eU/k1Ck/+WWAhSbsy6CUQDj7C2FQVEbRRg8ca
 jEThfLt5NCtu8zmk2Vj8XybY6sR2Pc8+Y5pIYlnfylWtNVheRkWIkgBTC8mgDt3ssn7aV0sis/v
 sT/GEAdeLN+aTUA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

Add helper function to log detailed information about unsupported
ioctl commands, including direction, group, and parameter length.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 32fa9c3d33..049188e5e1 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -219,3 +219,27 @@ static IOCTLEntry ioctl_entries[] = {
 #include "os-ioctl-cmds.h"
     { 0, 0 },
 };
+
+static void log_unsupported_ioctl(unsigned long cmd)
+{
+    gemu_log("cmd=0x%08lx dir=", cmd);
+    switch (cmd & IOC_DIRMASK) {
+    case IOC_VOID:
+        gemu_log("VOID ");
+        break;
+    case IOC_OUT:
+        gemu_log("OUT ");
+        break;
+    case IOC_IN:
+        gemu_log("IN  ");
+        break;
+    case IOC_INOUT:
+        gemu_log("INOUT");
+        break;
+    default:
+        gemu_log("%01lx ???", (cmd & IOC_DIRMASK) >> 29);
+        break;
+    }
+    gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
+             IOCPARM_LEN(cmd));
+}

-- 
2.52.0


