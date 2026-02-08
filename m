Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B0DEF06E9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASj-0001R2-8F; Sun, 08 Feb 2026 14:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-0000dM-SL
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:15 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQo-0008Vu-7N
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:11 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c7a71ba20so1269047b6e.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578795; x=1771183595;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4g4RzbVT/lDomHogcLl78lUZQLUCnr5TyeWesTUjIRU=;
 b=GXJfSaDqrSfzhO8YDEtG8GkjJVwx51bs57n7hASDnsRIREsmdCiZbg7AhuReadrXoK
 DPkQA5vOGeF93O9W/pEhOERrnyBWHeeei25pNJ1OjPXNio1Wq3LlBM10+iUEjbKBOYTp
 hUzYMzUvsEOBqE83eLT/QR3jE1AvoO78/eJO4UE+eQWCM6dkD6Pk/XURfHOSRTMyitmD
 3T9Idh6fWGgLTZrXHmAOCQ0xDB8WZyc4KDoL5sPIvfpBcYZatso7gQbMT6VTma3dMAHW
 xoGZqQ0Yt3DGs8XPydHPOm9cbNi746VQvJxtGJYAiFMLgBUcMfWOyCpONmafJNijd5SX
 nobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578795; x=1771183595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4g4RzbVT/lDomHogcLl78lUZQLUCnr5TyeWesTUjIRU=;
 b=MbMe5DqD/7dwwwYB3L9oqj3l91elcHG02cmU5nAuTqslASHXOz8NK2s+bXVmYn4Xun
 jVbQB8Jmlom/pJn6scDXae3R+wWliqKqxbhE8ap+CURDlopYZZ+pH69i7Bw88oshiHAb
 Jb7D2qLqw2wpu+1s34C7Wthlu7j+IGAm6tmZVPrxXsmYjdpjxBgkNYEPestdUM7hUshA
 Ywk/q2OMVduv5N27TJyWBLXQVJyeVuiRmrgSJeWH2qMAO1gekjkTlQndfCIZmmOgebvk
 +Zfqec+fed5jT7dOmQkm/l+7VM5b7GNXL04JPVVuRPFW47PW819HkOacNho4GE232QXl
 Ui+Q==
X-Gm-Message-State: AOJu0YzBBPInlmTh5XE+wOQAArC6SeHS4qRL4JP/LGXst662AGcxFXum
 N3fKJxeKoh8lNYJLGbgWUKYi7LoTSiuRTDEA7e7pMCKIgJ58oZj5ZjLg9LMihlJYRUU=
X-Gm-Gg: AZuq6aJwE4jACxAbFOHId32qm82m60jHvgt/5XZp4++zxfj+pZJjRJRts9T3ClZErAh
 AAvxlhzqkjCwVnkpt8VBdwqrht/N0iVujei8dlI9xop5+gAPh7tCgnrAdEFwoyXceO2LxQVvn1K
 iZKixeZqk99dWOJ0r0xqgZBx+lXfh9W/z1tmsp/1+dOUv+RhHbyONYXYmHZAJ8CA+XDv998lid3
 YTv1KL/TKD5WdDZ0K2qJkT3QE+jU7WgYIGFHWpIoeznfTlYZOIqa0jaxcd6mxandj1ZKgZOF9M0
 P6u9rXVYevblU+xK6fvv7Hq41xutubvzZsOZ0r3SL+NQgxEp0E65H08R/+gNFTmaAAdTUkPfvRn
 KbBqQ9vm3xivkKGI6YfOXFmLfGHwE2HGy0d0EkINnmtzeTDIufRIDQUwdk12eSg/NsC66zr3TGw
 ==
X-Received: by 2002:a4a:b6cc:0:b0:66e:1e4e:52ed with SMTP id
 006d021491bc7-66e1e4e53c8mr2373836eaf.34.1770578795589; 
 Sun, 08 Feb 2026 11:26:35 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:35 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:18 -0700
Subject: [PATCH v2 09/24] bsd-user: Add target_to_host_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-9-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=3TB9vM81uy1rxiUsHsSQ60E3QlDmUicdWl0yfDfR4Ac=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgqJkkQ0AnCByIQyyN4XNGK2jL5JmdhlUg9
 ue9nN6wMMyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 ACHmEADKY3sgoqO55q8SrSRhFzu2uyDRj/dk1yJr+le1FuUto3mi0BcuF8ZW4SHwn3Wdruj9SDx
 inPWu55VQcduRaEDRCrjfebRTAoGcXWV/Hq+scKWXebHZ1fHcODH3x22qPOsiqcdZ/g6NO0rksx
 2Z9jHcVRYlXSi5iV74ouyTssBLpGBm6Z2BW3fLQAlcFho/ssoVj1nOznJlukEWyVXDh7oymrVBs
 CAxTlibgCujoPJJL2vABT8WQEd2WSoVuSzMOQMmB9EaRjNbdhy17s46Fu+fL4yJiA+sWSKv0QW9
 4Bt3HaKLGK7tLJldye9HJ0d/ojiWeW9d4QWRfYYJ21y6RwaW/hgDqLonD2XmnNPG+fg/V4HPKIm
 vSGALSTofuw9zdwOH3rg3z68PFbhlmLGiNtF4LFWnwqvcbHm7p8OV0Vid7GqfNzPn5NoNJOAZ1v
 ya60DujxTV6Pim0h4+db1XgO5W4j0TBFj0Kl4uvw2ZvNV3555nSWR7P+FBScbWy97wba7AyhL02
 oaQo09GpWIJYnCz5rC4KasnGscoN+1ZpjGGVYtDvryaERwOnCtjQdGkX9UjrMyxQ3lOnMZYYbW+
 FSsVCf5F5osk6aZFT3kPsVpnc9By5HJq0lH5NbV4SI+diG9QhsD6JmgTmD7YHHJ6v9RgQYN5m2j
 tEjMHuaA/3vxY9g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
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

Add target_to_host_semid_ds() to convert target struct semid_ds to host
format for semctl(2) IPC_SET operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 677cb49d27..2a7c0520ca 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -112,3 +112,21 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
     unlock_user(array, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_ipc_perm__locked(&host_sd->sem_perm, &target_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* host_sd->sem_base  = g2h_untagged(target_sd->sem_base); */
+    __get_user(host_sd->sem_nsems, &target_sd->sem_nsems);
+    __get_user(host_sd->sem_otime, &target_sd->sem_otime);
+    __get_user(host_sd->sem_ctime, &target_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 0);
+    return 0;
+}

-- 
2.52.0


