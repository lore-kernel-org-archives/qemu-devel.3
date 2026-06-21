Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EC4CDB46B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hp-0003XR-RO; Sun, 21 Jun 2026 00:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hg-0003Ej-Sd
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:40 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hf-0005Ql-HK
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:40 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a0eb19ff49so820148eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015758; x=1782620558;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LR9lFk+mxAxbjJU5Z9czAKz/et2kSY91hVXwWMWBddM=;
 b=Y/24n0ed9khuThEjDbLeSMEmy6DCT/NUSKl53CPs4ex982oZYw8m+HAqlWWp9/ptp0
 GbY+5/LU283sCI1FJH6Fq3Bwg7EzMmcQAY0ANrHeTxgtc5tO3V7nA5yzKaMk9tB78kGd
 lBE6VZ+dHqS6ohAEeA7ekCjf+g19CtbjQKVgV4ETcuDNqSR5iwYje4OU31wmS1EGBMhI
 dplV44BmoILXCRIjHTdCPR1vABqJyGiwxnEds5orgPEV+uqT7z18Z11IVrtodEwwqICt
 0UYdW1QA1nQv1w86TbaEmlvzVs2ivfEKCbYhjT+GGa3nh6ZsDCtZYzl6U9X1WX2pwKRj
 c4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015758; x=1782620558;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LR9lFk+mxAxbjJU5Z9czAKz/et2kSY91hVXwWMWBddM=;
 b=dv4YgRlun7edDKV+BdfnZUF/VcF2eXCPZAi4n6iqmVdgLFL1cqSEG290qyvpWdSRsx
 lK7m34vitAB1dYC8f1pgRabGwJajSX+x4xvH245OZI4IbRrxp9qMPk6AfjtXw3gBCrrY
 YNRwNcePWp4wovj0Sx+qJmcQDeaPRe4qSC6epxDJSgSfMXFEuLb8teonBWUoLytuWnKq
 82PPe5bmOQ4xS+YHAEF5hubroc1tIJgDCKAtsL9lQ49u63JPgiYZnFtqe0tpUtfZroLx
 /VC5gqN/E41tDHY2lHd9G9a2qms2W4FiDRNJfFemJoQP3QqEqAlUnff56W+detijXjEz
 52iw==
X-Gm-Message-State: AOJu0Yzi/Nw3uf4bbDrboXFG4GoT/bIZLXRO7MTLnhi9FwOF/UXTDENz
 nFyFDIcaqOcKH0qhoVgjgzw4kn1ysn09tTF+CCQJUis5pQv3Mw4gIXu47+dyXxhW+rs=
X-Gm-Gg: AfdE7cnTwlA74naz6E9+WIQJrtUpD9/yAjT3DJyut6kAeD4BCa92wVIWdnI8UKd4g3L
 j0rYxQvAH+MX4KJDByDvGN93xL/8KU4YyIihZavygSWS4MTH+/5xDIfpTSp+KFUnABjERzI7LMh
 ny76Cwxz9i9QB2azq8kqxGcUzTZvAml7+PV5cxH5iYYvXxl9f8xmzZwVW4QB+zaDz7pwBtfsHqc
 SdI7yAG7w0vSmblUttkTiAHi7j70OdfWwKOKJfi7TmFzddLOd8PckSuLvm/OmQXavfBaugTHGxg
 yh7TYvvZ2foWvkewUbUwe+YYtC5KI9+cLVVtG8KNJw3L9PPB0lj+Ypqw06E5ZWreMSN5rJxp0nW
 A5LPmlJv025bMmebkRbj5P4KvBpvOinuUcoDQ8ObIYEx4JPWQYHOlHHKYCCCPneeoSYCygNAFRB
 ikzCw8R4Ku1g==
X-Received: by 2002:a05:6820:1a0a:b0:69e:428d:136d with SMTP id
 006d021491bc7-6a0d8887828mr8463886eaf.19.1782015758555; 
 Sat, 20 Jun 2026 21:22:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:26 -0600
Subject: [PATCH v3 39/40] bsd-user: Move qemu_guest_random_seed_main to
 same as linux-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-39-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=vAHbZWc3zpEl4d8agZA4APlWismbA5dNWh1VfyToEe4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aB6mrKGm2n1ZKDwLQ/Yhyww4yORxv4zsaXI
 /z/aAQiFiCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgQAKCRBsHNEofbAR
 AIwKEAC3sJApN1xIwtKnm3ksE7Tnt/7oqOrBFiAjNtLw/QVo+zieRjXIgSYWsDQujJ67EGayXxz
 VDZ2vvT7T74pvAORCVrtPDEvs2tTnb3CYGhadzeb9WjGrVzLu1T3sV4LsPKw4PQ8z2OEZBvp9mw
 8CXuguBjJSqZwIAC/nYj2AmFlsIqHKxU21bbfXLMnMiNmMCWqk24V1Sq0HijVXDzFQyFxTgRsOT
 HYupX1IKZRfq12T3mXkSQfU08KHQlCoUAzG6WCAfeoXsvwIVyNJQ631OJsKqmuntEi+jy7o8SvQ
 5CXsfaZbC31vN9pdcWJa80/h7Tt+HD0ioBawk1YnNeOQS6Z2pGVSVbvdcFnYttizSdzMXGKuH4w
 cgCAs+S22gV2eUc1rzuzqMFOpNdpjq8l5U4Y7OKhK/pSRErK7XfnEK63DydLVUoVwQyuvE+S+k6
 X97G+YzD4H99qHFIidfPq3uS9n+YzYxpDP7WeJMGYlvhm5fv3qcj6NR6f17JWStD3JrFXUQnuXx
 k09Hd5GcRaKEvsw/qxbI3aO/d+g8ZgSFzyD6EKOUtvqAbdO7htNXUxKqoAE4mJfK71yk1RLc/ae
 IBGqwtbwOkzsfMqdsO8cSouobhFq90M2gxhjJU2ma/r1xIU6VyZ5gkfnbHKeJEyfJwjA6CO/rtW
 eOwhgiqm/u4jDSA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2e.google.com
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

Linux-user initializes this before doing the environment stuff. Go ahead
and move it there for consistency, though it doesn't matter since we
don't use it until later.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 9dff2cbcb7..6541ed2608 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -542,9 +542,6 @@ int main(int argc, char **argv)
         do_strace = 1;
     }
 
-    target_environ = envlist_to_environ(envlist, NULL);
-    envlist_free(envlist);
-
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
@@ -558,6 +555,9 @@ int main(int argc, char **argv)
         }
     }
 
+    target_environ = envlist_to_environ(envlist, NULL);
+    envlist_free(envlist);
+
     /*
      * Now that page sizes are configured we can do
      * proper page alignment for guest_base.

-- 
2.52.0


