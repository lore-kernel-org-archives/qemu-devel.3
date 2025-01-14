Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843E8E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfG0-0005Fo-0g; Tue, 14 Jan 2025 06:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFf-00056H-RD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:31 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFe-0005Pr-7b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:31 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso974177466b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854709; x=1737459509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoVYHxIQ6FzVx9Ejwb1qRhaSC8vYXzudlK+d3/Xo6Gs=;
 b=hgLSFJEcqDe01PjKD1GSDO6Rgchp12xoQ++pAm3gY5OzxkQsk3v4oeIshsBRIOnRD9
 TaH1ivWzVHNlF7SCqPXDhL8boi4Nj20StqozkUWkUHUXloyqQ7QkeMxtpTW2Ffm7I7KU
 l9shBoJyoMpw3FqckgwhGP+TQbMay80cNpLpVYlK23xPR2vqBUh3STq2p4VLXzgnsVkK
 6CkNY+IS9vQbCM9G/K7yCcosu9PDh13ouK92ViGdrZDoAlluYFKUV9RYx5vbyslsuVaS
 lxbr7UxvJ5T7Y9D/YZFKRi8NR1zNTgjuJB2x/fIGpzLM+MYkMhj1uFEhRDXLl7WFzh+K
 xQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854709; x=1737459509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoVYHxIQ6FzVx9Ejwb1qRhaSC8vYXzudlK+d3/Xo6Gs=;
 b=MpBTP/Dg335xxs9928yfj1F6faQIfc/Jbcd5Vun0gQNiSbFjCUqHRaJo5LGbglbWZK
 CJEQ7lZAl8UQ7v0rG4jEX3/Jb2ptNv9R9uebaRqIgskEl55PmxW+otw/+X+N2Kg1lw6O
 lNsNHAMsMzkbV+MDmpMF8KCMOTgukB4fygoH2zPfKYsH6ay6E5XsXGc2JaWH4qJTOisq
 5xo4g6K80RTk57E+gs0nx5od0TpDZ5Jz6YEJ6/LV10tkva3YM1amYgVMSV2+YTi6IuL2
 ZRRfH88fifdSJI0d+54Gj4iBgKP7KlK1F0rkjh+moRY+m3LbQ3kI32KR67V7cSoM+9E1
 c9WA==
X-Gm-Message-State: AOJu0YzQ7Mr8CrlFxBfW3qmWZXNOYxUauV2wLHlsJz+o8RUE6AvwNfz+
 /Be6pFSg91UQGJYm8bjKCgMYZKAUcuYR1HhMw7FYp+0m0lfMqY9zM/aY/Q74GmLGaNQv4ozDgwp
 eKn8=
X-Gm-Gg: ASbGnctpITmPDGixL0TiP4h1gbFWrVWkje9vxIWsdHhX85+BackOq4k3neuDAn/sOES
 ePRMLKHLpDwkqXnWnT/3n6b3Ik3N/3ERYvuI7FK98LC7JMstfi1rhh0vlmR2HoamtgbC1Oi68fG
 7+CKmV/wPrnAGW3keE5IEj9OW9ByMOIOY8YpSQVMn8TOKqTTnbREOIh5yLc9LtOBBS7A3Y/bfgU
 akaYY7KRUwo9u0t/PFxcRjnr7WtfMuXBngAKy3EmsFN79JkPkeqPP0=
X-Google-Smtp-Source: AGHT+IFZIEUTIxW4o2JF9gPbX1ZALE1aBODsqHCahnXwtVLak4uxvV+pjMSNdNiAOeKrhG+/lpviqQ==
X-Received: by 2002:a17:907:9490:b0:aa6:6885:e2f0 with SMTP id
 a640c23a62f3a-ab2abc78dd7mr2374565666b.46.1736854708635; 
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060c00sm619628766b.41.2025.01.14.03.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5AAC5F9DD;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 11/37] tests/tcg/plugins/insn: remove unused callback
 parameter
Date: Tue, 14 Jan 2025 11:37:55 +0000
Message-Id: <20250114113821.768750-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/insn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index baf2d07205..0c723cb9ed 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
-            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
-                GUINT_TO_POINTER(vaddr));
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
         }
 
         if (do_size) {
-- 
2.39.5


