Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B861CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy5-0003fR-Cc; Fri, 15 May 2026 17:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxq-0002x6-AH
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:01 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxo-0003AG-SK
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:58 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbec19732eso372351a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880055; x=1779484855;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Njs7wIR5DF4xPBft8B1295A2iuXF4T9ZCX8i6CxKtW4=;
 b=z3rB3exUWDO3/hBABDIYgKcOvpgK+2sBakckOJwQC6uDKHmxh3c3qt189eAgCEezd4
 fjMg89qDRUkJvR8dw6zBT9UG9b7nBK6L+X+bjBbiehNXl9/HfqNDHyAHfmRj2undXNWC
 4rO0yr8bIcep2G8nU2C8dGG2V2pxsu0M9pZQrwiC+VLUWR6m+zw7qA/ThERIuhzhBHMq
 ecfH2HyjiGSsPhBUbnM4hS3017EltQKNHQriWskOZs/I2ktcc3H/rMPQ1nH3nApzGvWm
 LAgKyvQeVvoRIfdsavmPPE+gtus9p9lYXj+7Liof4EBzmEW+j17thNKnbc8/G2zEsBIG
 ielw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880055; x=1779484855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Njs7wIR5DF4xPBft8B1295A2iuXF4T9ZCX8i6CxKtW4=;
 b=VbAgMa5hkVs2PLkD8nQ59DZPlWIe9bhbdW4+DtqvY1yaqTY74MiaCo6kau9fAFnjqT
 RT2iqNNZdwjXfmtSKQlNUoUbhrh7aFyT0n4OtIV4oU5p91njHW0RGZwSTAJA+lquH3mC
 dBzZa0HXg/SKPMdmfgUEm7MQWGwumwqfyUeMQLUgihO0Y7dENzlQXUBDxfE4rXLoP6MX
 bVBaT+5A7FRBpuuHY47gDXikIctIfT3YrjYGMeDJ/RVhG2tWqV+uXbnKqlHZ4+QFNtYm
 HOLwCO+6LfyICd/U2F0AVQhvjGCoqqZCSQU55rMGg0mdh7CkaDd4wYf4qzYrXHo5MOvC
 pw3Q==
X-Gm-Message-State: AOJu0YwHPcCmmD6xOUdXEm6lPZMzqItLkHlOO/lKcHMah5O3v04NMAuI
 2uqIYQ7CPDkQ6GuWf0Bqgv1pRRAWcXMaM+dJ70JNxZ1JxItYUdkA4XaT0Wacik6i18hlgmWh+7b
 73eXNStE=
X-Gm-Gg: Acq92OHC0QB7so4uZRMs8MRKigexoUPKqxRwgoOIRMD/METQdSamzB1gkOE1TMHycEe
 Kc2ROOseN1+DkmvopIUfLM07PMZjPLvVLCZvqwRoqgtztUs1N5uMZPV1VLAmG8vPwL961WyWEtF
 lrcPJ5AvAVPAKl3Peitaj4UPE2rlpO1rTevyLlnBBEV7j88+CODyG15XatrW14oPR3ZkY+HbJWU
 MOW/kCFORLEseUFZaUyh/zE2q2jMTxxSIwgY4JZOalYggHKvjOoyZglBYWeQtd5bGvq9qz/2irw
 InD7Jv/Yylp9VwCjKJD449S4JL2gD8Rlxl/kaK8O3olYLpHRSPM6E5Wze3clGiiSsY+XkzKqEbm
 LgwIFVXL+oWiuTuNJomVgQQ/iLwCxW7/3j3jvnKWLlNyhwDmzLhFNr1x6anyeRWhmGT67eu7ETU
 RbxB3WE/WXTw/DLHZ/2o9e
X-Received: by 2002:a05:6830:4489:b0:7dc:d601:a69 with SMTP id
 46e09a7af769-7e4f2b8e71emr4250453a34.20.1778880055286; 
 Fri, 15 May 2026 14:20:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:50 -0600
Subject: [PATCH 51/66] bsd-user: do_freebsd_ppoll: unlock target_pfds in
 error paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-51-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Reco8f6NIkhhdCqPoh1VTSSeLM9+lRdTbFAd7ff2l9A=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43njWFKLYP180TJ+rCVtnC+0AfWCQoWbgTBV
 b0OzMMIcZiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 AHSGEACRQWYyNKuOvK73K1udWVfm2u0knjSIoBqx0hnxZaaqAGagCMpaZBJYD9Azx5+63Q2c3f5
 Q58Hi+5nlHY7Jrtwl/L7gTPrf1PPE5o9xVejoNVwpvj9qCoFnryxU8NrTjOrd6CEiyTnlZHunQm
 bT17cNe7MdMZ6/0oIYnZ9AeSX3C/opd/zG29MVzQGt4KVkv6IGZY/LGnf9Z4lgPz3Y90Pr3g9nP
 cRCXRIAYXvns01mlhTBbmz1Lik0sugPIeqVP88vSudiwwAOXKc71NDV/FFLn2oTyzpDkCAJctFf
 aSGCHHAXehR6NwyclfGWZLUDL2uo6Bba8H43bSLGWeeTRSofzy0O/l3gAe5xrqyEoj+ZU52BbEc
 qs2CTZigr+ukaJ5l/uGBFqGveYdLcvw4zkxC/sP/Q16Uqz0J2iTE41nRSL3YYYfIHRliE9VsBwo
 Kz2lu0ZZNZWbca5SxQrd6LrKvowLq5V+0g/8DOibFJJeFz7oL4L0sQz/Zcg9Bm0vYx4gi+jxr5G
 XIosB0DjwQbioPqKupmcJrXNgKcj7BYIhHldbVu0zwTBxsnS/IZQT5i0jrEaWYR2OjdI0YKc54r
 12PfESuQazYulxf5LxQChTdqMHGqWXAAl4U8kZ5lu14mvPnwKGkSqA7+zlfMGa5fdsP49X+N2LX
 4TnU6LXwERB0m8w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index d838994742..ed075b7df4 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -595,6 +595,7 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
     /* Unlike poll(), ppoll() uses struct timespec. */
     if (arg3) {
         if (t2h_freebsd_timespec(&ts, arg3)) {
+            unlock_user(target_pfd, arg1, 0);
             return -TARGET_EFAULT;
         }
         ts_ptr = &ts;
@@ -605,6 +606,7 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
     if (arg4 != 0) {
         p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
         if (p == NULL) {
+            unlock_user(target_pfd, arg1, 0);
             return -TARGET_EFAULT;
         }
         target_to_host_sigset(&tstate->sigsuspend_mask, p);

-- 
2.52.0


