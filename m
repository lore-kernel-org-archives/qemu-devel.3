Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E52D625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT5-00078a-OV; Thu, 22 Jan 2026 03:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSk-0005c5-0C
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSi-0005xs-Fx
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:45 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so7218695e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072083; x=1769676883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CZwMmcCwari3wv2IxDtkxCCsWu1wof68pvdYYbNPhbA=;
 b=mlfsaoq7MbKwcXjXS4kbJKZrlN/7M3vDYF5mIqPYOgzlSBLObbikHlqxTVplkgNjus
 Dal16EBMclmmqXb28Hk+lBeVdwFk7+wDbCeIf7aoUmzkX1W82G3X1GnTXNZLRPsyt3OA
 mlCOZvUXN8zsl9VIOv/TFAzAycJQ//eOJqb+xCgRM0AQoGL6iRqa8LCXEkVx1OFjykPa
 FPgfOwVdVRiNvuJy6k+WAHGP+PlNSe3lDPsvnhy5FcT0abeu2LPbFxEN/q4KKakSQELZ
 +S/xGmDJlKkQlh9GgtMnnrFTxuDK++aR1tSy7jByfa0x9D+dGi212lrNlgKM5rlJxYkq
 yo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072083; x=1769676883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CZwMmcCwari3wv2IxDtkxCCsWu1wof68pvdYYbNPhbA=;
 b=P2hG2+YcIxl80vuakC8f+eCXSuJ9CC+6JPI2qq2YQbqIJvO6BaA6O6k8sgYzSlxSiJ
 rSJ639GFig7reruFA597SfMauVDH9K/GydF/7DYoCLRKT6Hc56etlTCqmQG7QjvdDA6v
 dEtxo/rW+6qSwIVZOI6TTxvzItYzk5pkjGgqkxXUSziGZzYbjBiDCIzfCTNRJBwNNuqf
 WYWI0TyMrsYv9nCQeUue45HK3zUpf63l9f3QiJtvNuLAVCScRtEAAD5aY5KyCkWFWTrq
 xjSxkk7KSwdTzA/io0FNrK6SJ/lISr34mSPgGfkFydFxOgDdY0jUUBS1vyWzbgTHsQio
 bgUQ==
X-Gm-Message-State: AOJu0YzWG0IcixH7BKavNQv8PqSiAsdBt5vIb/8G4lh2jP8lhOL5wiD0
 v1JnmAPLpxFuqGMO/b/3yT4mACRBoB3OIBgbJn1ObJHnmvnau8KL0EKUCV+3VpNDyyDZaNqsxV5
 99MFHl7U=
X-Gm-Gg: AZuq6aJJkEGuoGO2t5o7P9XSwDSq0vs77tGT55r6ybwkgcKILSU3SyZJ4eCRwIeXHE2
 Si3AL5SNhgu8XDF5gMTeGaW9khNB6HweHSIn70yhCpTHtjjTlUMs1e1FcGmHulDbghJHBNcRA4F
 a5BCXKMJKcptVqLSaZZI1prck1AcBQ4rsbJcoOubhQ+46CaKIF3xVp9DJff6vPRFtGSegClQlRz
 fDUenzdFHjIQxgj3j1rN2h8LvkBvwa3PGN+AcqP2fzuVJkKxR5nMxN574bRyi2/BRfVb35/FOFu
 RzHR266QGRMvVtuBjqbryWtPad33CTaSk7iCFcPOaVSxq11vheHPZhXcCxFBZPIoPUDdXkrZkYi
 oq6TcCtuZ6BRX2gc/xZ5dB7Plxhtf+ojNDT05gmgrLf088+5aUFU4Zb0Ix4YeEI6tWXKzNHSUR7
 TdpfAsFnFwnDejXO+5beaua8quy8RiAUbsrCIT9PA8AL1C0fzhE7DIEBziJe6b
X-Received: by 2002:a05:600c:5486:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-4801e3484ddmr265886405e9.32.1769072082689; 
 Thu, 22 Jan 2026 00:54:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804704087asm49261705e9.6.2026.01.22.00.54.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/31] system: Allow restricting the legacy tswap()
 'native-endian' API
Date: Thu, 22 Jan 2026 09:52:39 +0100
Message-ID: <20260122085255.95035-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-19-philmd@linaro.org>
---
 include/exec/tswap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c431..9e94fa0021c 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -21,6 +21,8 @@
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
+#if defined(CONFIG_USER_ONLY) \
+    || !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API)
 static inline uint16_t tswap16(uint16_t s)
 {
     if (target_needs_bswap()) {
@@ -68,5 +70,6 @@ static inline void tswap64s(uint64_t *s)
         *s = bswap64(*s);
     }
 }
+#endif
 
 #endif  /* TSWAP_H */
-- 
2.52.0


