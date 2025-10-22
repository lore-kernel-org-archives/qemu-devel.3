Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8428CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaTF-00021j-08; Wed, 22 Oct 2025 11:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSc-0001LM-KX
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:09:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaSU-0001CB-Be
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:09:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so4659641f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145736; x=1761750536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsuwaPSDBJqW9x7+kDRZ6Zqv9gzfoIIzIakN2x8uDIw=;
 b=uBs5JBRKOOcBTfIrYwaET2wZpRwkj9QI3QIuYasJJGvcemtPaeuBFQwl3qHG7m9dle
 XKC0sdDTxILi3DFec9qSoqQkPK61TDP+HaKQ1qyx7/7cB+lsQ7H4+CHGF7xBCFlzQzKB
 eC9PvN3/tjpJeyvTdjar4BihKGCqG16vCa00gOu9guliKyaZxtjtGaRI4YZTftMF6Bua
 WkYykHbQ4OJIyTTtGgnlegy8cBNdL+CKr7HwG/qRWehD9VhShQy94IjgYelpHiikum4/
 3UJet7vShfp/E1sJ4DNFLYhSb7fZ1EU15jMIjdyZt+fPMMXBFPyTOZe2fsdE5qiu5PUK
 Ydvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145736; x=1761750536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UsuwaPSDBJqW9x7+kDRZ6Zqv9gzfoIIzIakN2x8uDIw=;
 b=RucSS53AMTQvGnlBgY5Krj9YbCFY9w7GKY2INUWazrdggQSa3U1959XHwklRzO1AoY
 LRWfvmmlSYRxsCEGqdjKXKD2fVgdWXvSz+wokK8aOEa6bucmZTuLbl0n8A8T9SeaDHYJ
 HnY4kRKNjVY/Dz5nYY0/Cd4mhB4Ji+YZsOn6IYnTGMQKsv0cNOOiDXJSeZYwlPVaGj1Y
 MnJd6FweOUg8wJR9vtwWBx8xuv9G29uv/HqbiceQ50xQ/3ZlOd9E737mzLK2CIbfarKs
 NxMMk90I8TjrCAp1gwZ85DMhjqNFphzT+ZHjky0HxEUy08yYw9y+eiZshv2NLeZ3ZcDI
 jj2w==
X-Gm-Message-State: AOJu0YyHGWMYS9p3nbbSMBgOix7fVErvqMPHDyeb+3aFhOPdNn3S2BFH
 x2OjzwK1Xftk5L0FIZlmnzWttt5WoiUspoQHCmdyf+4jHjHMOVGLwd9KJYyzFwQyOda6NPay7tn
 KzF9nRek=
X-Gm-Gg: ASbGncs8exvLDLGM7lPINFCI3UYT4oOGUeb8bsEvQzviXLvqTy+0jLzm7QobrspTBPM
 v32dHed0Rv/5B+Mi4ti7mzX7Hy8owOLvxUkTH91CL2Fp5K/9Ohk7L8/sisuA3o5rU+gCl1Jn8hD
 mpFi4WSJFiZHIhTIC+a3Obpqun6+u08nnmFg58XKRmkUDiV+dePeoY9gaJ0wqyQb8EMtDMkXs9I
 LoSzgh8WLu2A7Tk9WZbbgCDzcpR1ThnF1kgfaRbGH9PGtS+cFKf3cdIqSHf0L7nA80CJ7bFSpQf
 depRy8AHRPyzGAlAuNByE1GfIRf4Bd6XC6Pp+tSU3ZngXoH9AlsVO4qKyvbJvby02OIzEKgDAXP
 BApZ87D50bSPx8ffBFMKoxA6RjG+Btsl6Pl5GsRdsqwKnLfEgwxZLI/pUURT+KKwBNY0OTiCUi3
 5FvlFcHpnAWDBzhy2U2nnsLtCxaL1EA2+WwJENME2VjK7x+uOHaQ==
X-Google-Smtp-Source: AGHT+IFZ9tEG32XVrcMhhtPZiHUpiLFemQcPesxatfU5D8gsn6bntLE6TaSR+aLrCSZK2BX440ZYtA==
X-Received: by 2002:a05:6000:4013:b0:3d1:61f0:d26c with SMTP id
 ffacd0b85a97d-42704dce7bdmr14965356f8f.54.1761145736498; 
 Wed, 22 Oct 2025 08:08:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a1056sm25271264f8f.2.2025.10.22.08.08.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:08:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 6/9] chardev/char: Allow partial writes in qemu_chr_write()
Date: Wed, 22 Oct 2025 17:07:40 +0200
Message-ID: <20251022150743.78183-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 30b21fedce4..5c8130b2435 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -189,7 +189,7 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
         replay_char_write_event_save(res, offset);
     }
 
-    if (res < 0) {
+    if (res < 0 && offset == 0) {
         return res;
     }
     return offset;
-- 
2.51.0


