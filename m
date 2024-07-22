Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F438C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZx-0005Z3-Rl; Mon, 22 Jul 2024 12:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvZu-0005NJ-N3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvZs-0007gS-P9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so2359060f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664474; x=1722269274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qcm1dWrebznI1t8ebTrFn2d5NidY82tKkmYUS0FD2gQ=;
 b=NLV8eCeEiYdnLs8qvOnojSPbb3yEkQyxJY7ossDISd215Lb+4C4m9MnbsOvrR/OEkF
 njJw9aazeaFsET3BcQqW3VQ965dXapeQQzT4U6rdV7lnxdhOG3amI7IIqfqsox4OKCcK
 Po/E0iJkai2HDfh/NZJvDCFQH4ZjdfINvy/KHf2KQuCQeC5MUG08Vre37g0OxvmZfUI0
 eEjyEUGrsmqskI+bRH+JSNfY/Lk/gbzO6/EdR/FqguNRdKBLzBCJKUFl9ZNW65u1NmPm
 k2hNKG51CztPX4+lc2S4VDF/kFArQEofD84bssQP2JlQz6hltol73gZwAvAJOM8HhWZJ
 f9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664474; x=1722269274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qcm1dWrebznI1t8ebTrFn2d5NidY82tKkmYUS0FD2gQ=;
 b=ecRYQKlRq1764sy8VWQ5PGnQw8tvdCto7or0v7cok5kXrcplOoWo/oJ+8XTQNEK3D5
 AR7ecRzPjg0YNtuBWcCmgxdxk1KiNvyzrgO3JG2vIgGUWKBUCq7C29bpR+LsjZ2V0ejP
 k9KVWgKQpMuEaKJcQZXixpLLFoNl3NAnhsViNzoD2ogO0zf7/EczkF3tQ2xSw73pr7HG
 pp0TN9UKjcCK9Kh7tEa2rE2k6YllGQ2YHienbzJn0eVmLLAU7QHVJjlAAis4Q+xxjmXY
 FLmU92WI5hCbrc3crpgxRJxAjMOc4d72cGMycW6skeT5ovdAPCMs72Ur0hEsvPVCxirl
 vyZw==
X-Gm-Message-State: AOJu0YyANUqmKnX6EqIoh3FGG15GxRd3Eb1ALquC1GxWIiGhweDUWzxW
 Bx1wA/0vhP0czcDtwD8k8PH8sc5BfnWE6M0ti6x4gupQfzRyZN5Ljoa47gcMcVDxdcFmHZj2WD8
 w
X-Google-Smtp-Source: AGHT+IHUiOdd5zhKEM8wd0wDnkyHCYq8h5McOhCLMzlh0XaA3hJKKozIc1odihHXY0dc7Ih77ZpZEQ==
X-Received: by 2002:a5d:6b02:0:b0:368:420e:b790 with SMTP id
 ffacd0b85a97d-369debf8ba2mr218506f8f.14.1721664474403; 
 Mon, 22 Jul 2024 09:07:54 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cec6bsm8920870f8f.71.2024.07.22.09.07.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:07:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] chardev/char-fe: Document returned value on error
Date: Mon, 22 Jul 2024 18:07:39 +0200
Message-ID: <20240722160745.67904-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722160745.67904-1-philmd@linaro.org>
References: <20240722160745.67904-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

qemu_chr_fe_add_watch() and qemu_chr_fe_write[_all]()
return -1 on error. Mention it in the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/chardev/char-fe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index ecef182835..3310449eaf 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -228,6 +228,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
  * is thread-safe.
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
 
@@ -242,6 +243,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
  * attempted to be written.  This function is thread-safe.
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
 
@@ -253,6 +255,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
  * Read data to a buffer from the back end.
  *
  * Returns: the number of bytes read (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
 
-- 
2.41.0


