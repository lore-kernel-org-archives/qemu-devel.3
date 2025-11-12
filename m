Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42256CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBGT-0002Wl-A3; Wed, 12 Nov 2025 08:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7V-0004F0-3a
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7T-0001Ob-Je
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477632d45c9so6278605e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954961; x=1763559761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TFalIf6p2Ud7G8385u1fjKI34moKfzih1m84zw2yGM=;
 b=lQp6jxW0ut3ceKMa/WdcmJbq+fxNjAFS69TGOI1iRB3oiINqk1iY/L7FB8rsqALziI
 uUOT1Cp9g9nZUaSFA/glvT9Q80hF2sZBYYCWEXk4lZ5RlhyYxHk4bd+hUZ+mab2omsZW
 FTaoO2TCvRfYrH1p7v2Fdb54uaemT3v6epO2pvHpGK4egAhek3Nt74gcT15mYGEGn1u+
 DCO5Tqolpbqxli3meSU11r+HaZRWlU9+dGqTtk8ub+fw1pgy6OgE8RZcUkPDXhbOLUz/
 6Ou2f4eIBK27dsmUtF1//fQjjG6vnqUKV6ZzGNIms8UpTTHLLbphlywlJnZH7DmK1WIH
 X4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954961; x=1763559761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7TFalIf6p2Ud7G8385u1fjKI34moKfzih1m84zw2yGM=;
 b=drawAe2aQOxzOp2axJXS64yWCFufejdKzC2dFLVMN21kwbPfilPVIV7tXiC2ht/2vg
 iR8TsvkNf7dgdWJhl2v2CUdZ+3XzqH0M7vLqjsO+jNsntF0yYjr/zAdfHyxPQl6JlnT4
 93vpoyvwUJnpRy8ccZd6x/H+X91GdymqXtuRsHxsk9Ajwr5GWkEv7EoUIre8HZcvoDb4
 0Cn7gCBad8Hm/HfkzxpcQOLTBFVgf9dztTVv111036Uw626XnoHSvKs8yOMho3YQ5xbz
 rwKx9FB6M7Zx8zc4+EApBNNCkQbaf1MBv5PIjTaM/sdahr+w1KKpoy/QwVdBKE9YRcV2
 z8gg==
X-Gm-Message-State: AOJu0YysqC0oqndiKuzEKu86HSwJrGJuikcybNap5WlOUizKZ/9NUM6t
 4eaBh5OlFg9IwKCOlshI6F5bgBVgQtFIK+JntYS34QU4poQ9Cx0OU+Cj+TnNgg7+BNEQ/ZHQ0m8
 VAO1OQPlg5g==
X-Gm-Gg: ASbGncsmweZ+xeOs4KW4rwW8aG1Bq2hJhhrlnk5I8kZXaZtWW30mrWFwTmkLAGPZemj
 qxHMOUVA/FmiJjnR0OrfJUsflOgZbFLWuV3mU8JyfQTEPjiTelZA+SIr6CkQP0q90Uh+6AtW9l0
 degUitseZA/aCJlmPM5HKtqaKDEj7eie89dWR9ceS2+ErfnSKekqZ7DwHNvXX8mdF1o8WylNPn7
 z0T6z5mwoGBE41wosmPxgEVmFexPzzIRYpeXAHzTxPOPgCAh0y5i6c3ET5mTVGPGdC6sG6P4EnX
 eHDP5GQA5EvQnVB//Ip5MNWU2QH3egl0Yg25hYyrG4Pe5ZpJX8CMbzDBmihGc/p2rkUOAttr0Up
 arq0ygGJ3v49kas0K+4ZdgeYyWq02xOfh1k8uTFqbKm7MXzshiWXUST/yeCDoxw/cW5Erg674Hw
 OpgoKv7CqD4rx11Ei69iRZfmzOrcJcQo1ZgBvEQVZgBmvjfQkPlsayNnQ=
X-Google-Smtp-Source: AGHT+IGjJz/Ru1QoGC/G6zHrb0o3uOx0SmaXgE1I/3vEgRpYCihWxP1Y7QoO1ELr5TmRunhBvUqDfw==
X-Received: by 2002:a05:600c:1d10:b0:477:5486:ec73 with SMTP id
 5b1f17b1804b1-477870b953emr28428685e9.39.1762954961484; 
 Wed, 12 Nov 2025 05:42:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b32ecf522sm22908082f8f.45.2025.11.12.05.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/10] chardev/char: Document qemu_chr_fe_write()'s return
 value
Date: Wed, 12 Nov 2025 14:41:41 +0100
Message-ID: <20251112134143.27194-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char-fe.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 36bcf1f88a6..fbec6a73dbb 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -238,8 +238,9 @@ guint qemu_chr_fe_add_watch(CharFrontend *c, GIOCondition cond,
  * will send data from the front end to the back end.  This function
  * is thread-safe.
  *
- * Returns: the number of bytes consumed (0 if no associated Chardev)
- *          or -1 on error.
+ * Returns: 0 if no associated Chardev or no data could be written,
+ *          a positive value indicating the number of bytes consumed,
+ *          or a negative %errno indicating a definite error.
  */
 int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int len);
 
@@ -254,8 +255,8 @@ int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int len);
  * this function will block if the back end cannot consume all of the data
  * attempted to be written.  This function is thread-safe.
  *
- * Returns: the number of bytes consumed (0 if no associated Chardev)
- *          or -1 on error.
+ * Returns: 0 if no associated Chardev or no data could be written,
+ *          @len on success or a negative %errno indicating a definite error.
  */
 int qemu_chr_fe_write_all(CharFrontend *c, const uint8_t *buf, int len);
 
-- 
2.51.0


