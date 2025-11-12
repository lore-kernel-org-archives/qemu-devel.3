Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431CDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBEF-0007E3-3N; Wed, 12 Nov 2025 08:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7H-0004Ae-5d
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7F-0001Me-Nf
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:30 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso404039f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954947; x=1763559747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NuFzPNCwgBB9LblffFmsa55eQ/4iQv98wvI6PkiWGA=;
 b=owaGmlmgWg1p5xYyiifAAn3J6VH3Vhx1c7iYeQGw4wypdAZe3DIPw/SRm8mQxw+a6I
 Zym7NOUtqWcJ2Lu0/LrhOWSqP8HdXPh6ri5OkR+Weoe2R2P4uwda5fnd0CfJeoHJUtNR
 VYe+nChDm8ZyEJlaxHJUB386YpZvwdcI1zf2hZZnv1XziK66mPsi2LrDyc5sAG5rtJMO
 l+DngIHhlM5OiLrSuuy0Th3CLjUrj2tkwdxGUzmzmO71iTtdb7IJIaNuv5lsx3NtsbSQ
 DWW+NUpdCghHJgjNJtj/eL6G8onX2pq6/eIplgNG2rtBUiwrHYVeGgiaRdkFZ4s/B1hq
 twOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954947; x=1763559747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6NuFzPNCwgBB9LblffFmsa55eQ/4iQv98wvI6PkiWGA=;
 b=HHOrT3HBVQpyyBom7ov/vF0vpYMje6cI2HxgVVPfBnL7uE34Jifhfhq7qC/Pslevrc
 gaQsE28rgXfv3tUNdObXWOYeM+lSJy3DZmSpipyowNWCIufmXsUk5wN226HzjJo2+QLO
 46SzxHpWi2GKuL5+4Xo9b17kdQPRlah0x3AvrvRJWL16KGLMCmy5sxw5ZzH12hs6PUBG
 AHyOvRX12Xc1U336y0SdaHd5bra5g7QtGeL6chSYjyaNhz00uJGjDbwHIPgfv80bxwbf
 aiVnQeJLA/cTLD/Cd83mFVQMRLu8uBFDZjEfQ/ZWPXEub2kR/k/SAEThKEHVWkmKeAEV
 ie6g==
X-Gm-Message-State: AOJu0Yz82vs1w52mNz1Yv9+5mbcnvnUaXiskTqwH4obNyrdEboT8KiDQ
 McWV5dEl+2LJAHvksn4IEDgW6YL8W42L0y1KqieZpuZAHhy7crxIGfCUZbI7Xz4myv5k7LmN5mk
 X6TqPfKpnQg==
X-Gm-Gg: ASbGncvmFBbYssArBIuozHSQ+dwMIJf5HDiRGxDhaCDOPDtC0LNm+A2L9RfnewS8Zot
 SHrk5Mfv4fXU6Xz3EFRSSnCAJmoOchA6T3iXK6ZT2JMkoSjCcSBKRv3oM23gdomsOdssICR8XuL
 kMUyVKDxY7A9rgd0eWdrebD+MRurlVtp1eRGf9KdLB3mpHHHvZiQTttYM6n1g+xa1XnyF1+Z2bw
 Sq01+av1vZ/rYbfvJNXw+v1zFheRogyN8VaQxf2tm0lyLGbYjza7RlmYaTof+XJNiIbf3vS/j3i
 FjhsgwgJ92WyhvyR2y/QZe9s8RkkhO+2HRW6vUzDF8DkisE655Rc19t4DAljuynbRssBOq0txh7
 HubvFvp2Jj89Cme2mS/HKvkI3NXzVzMYIO/74l2rxmweRIG2FWjkccGeDKaZp8y2xMR1e2RZDBo
 xl4zQqdYeeotiUR5AnsfZ3BurUt7FHJwq3at1keJkc1ofvvs4y+NKn+MA=
X-Google-Smtp-Source: AGHT+IExEjIeS26/WorPB2eRgkhHxRI7V4iJI1VXXnfi0zNWFgmjvLuo2AoPLb/BheG19yMF7z8irw==
X-Received: by 2002:a05:6000:2888:b0:429:cc1c:c2e with SMTP id
 ffacd0b85a97d-42b4bb90b6bmr2259806f8f.1.1762954947478; 
 Wed, 12 Nov 2025 05:42:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67921c3sm34772695f8f.40.2025.11.12.05.42.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 06/10] chardev/char: Allow partial writes in
 qemu_chr_write()
Date: Wed, 12 Nov 2025 14:41:39 +0100
Message-ID: <20251112134143.27194-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If qemu_chr_write_buffer() returned an error, but could
write some characters, return the number of character
written. Otherwise frontends able to recover and resume
writes re-write the partial chars already written.

Cc: qemu-stable@nongnu.org
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 chardev/char.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 105b0d53184..7931f4e0832 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -186,6 +186,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
 
     res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
 
+    if (!write_all && res < 0 && offset == 0) {
+        /* Allow partial writes */
+        return res;
+    }
+
     if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
     }
-- 
2.51.0


