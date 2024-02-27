Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7ECC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyir-0000cU-TE; Tue, 27 Feb 2024 09:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reyhK-0006Zn-79
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygT-00027i-8n
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a4848f0dso15769115e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045032; x=1709649832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZ1nEd8NJNCNQAO45v/M0dXLXOT0Wd7jVxF+jov+Saw=;
 b=moX9ko5jz78GmLtVK5GwTfNhzqgruARbryvL624+RbpY6Oe0JzgEK7MKNeOdq2+SjN
 7oQcy8l9iW+lLSoXZiW512GWhlrbkFQyllDFsJCpaaf8qge7LV6V+mzYhp883Z5TtqS2
 +VkIH7lMmFlnYX/pzjg8zazGjplsX49ph58xFAxQsOAvBWfn5ofX8NC9Ryl/jmKbB2vF
 84hxbff9VcnmysrnJ9G8Xa9lXTFZEeS/ZYwj7revyguWZGiaYClGVAvppdbEGHhW891j
 wvQfI5k02fEHFyVOlZWNIIVF87b84ntetrgjXFOkVlaY1hcq/KoS5y18sBKQc65qIO1E
 qhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045032; x=1709649832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZ1nEd8NJNCNQAO45v/M0dXLXOT0Wd7jVxF+jov+Saw=;
 b=J+zBXHAyuvPK1NjxK44GU3D9qdR19XstufQeoR7AQTAoOzaV1mEZV4W4GcUvnOZbWP
 1GFhgYTB2RcSLG7BKJR1Vh4pyXJ9YlaZrtLjNka4LP/7fQ8Tc5S6rKL8eCYPAeiu+1Xf
 mP8XcIsCWO6vk05Dk/rQ5D6lF+yFE+RZEg/GXqQKd0FfllSLg3K0UHcEUOO9z1gM6onh
 wrMQy6uEmG++MmB1VvhTTUu12lfA455uLxxLjPJLipGw6RQmMycgXkTI5E8VwL250tRM
 sdKvWbUlm+FS1LaLlrTqAdD5371xLBtRnlTg9PSc9CnZKBQteMPJIfHwa1TGAjaud0LO
 Nk0g==
X-Gm-Message-State: AOJu0Yy/AZCGJtQihjPmrWgwdEtRNZeK+eDt8YVS9QP575gemnE8Ce0E
 pESWzAA/yw5hkFfNCufZxZCLLgJrbcH+Ze+fst0yJZUm/M1nzAfo2amYFeoaYU0=
X-Google-Smtp-Source: AGHT+IGz44XdYBYFBIZ3a+ovorB9gaLTI4VHaTdRMlNQO1YUc5hQ77oi3syl9h6WC9lGy9kzmXm31w==
X-Received: by 2002:adf:f882:0:b0:33d:e3d8:ee47 with SMTP id
 u2-20020adff882000000b0033de3d8ee47mr2745402wrp.27.1709045031881; 
 Tue, 27 Feb 2024 06:43:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n17-20020a5d4211000000b0033d97bd5ddasm11556120wrq.85.2024.02.27.06.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE1375F92C;
 Tue, 27 Feb 2024 14:43:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 25/29] contrib/plugins: fix imatch
Date: Tue, 27 Feb 2024 14:43:31 +0000
Message-Id: <20240227144335.1196131-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We can't directly save the ephemeral imatch from argv as that memory
will get recycled.

Message-Id: <20240103173349.398526-40-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/execlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 82dc2f584e2..f262e5555eb 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -199,7 +199,7 @@ static void parse_insn_match(char *match)
     if (!imatches) {
         imatches = g_ptr_array_new();
     }
-    g_ptr_array_add(imatches, match);
+    g_ptr_array_add(imatches, g_strdup(match));
 }
 
 static void parse_vaddr_match(char *match)
-- 
2.39.2


