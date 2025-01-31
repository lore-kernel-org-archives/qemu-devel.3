Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE3DC02195
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvGg-0000NZ-Ka; Fri, 31 Jan 2025 12:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGe-0000Mb-Hc
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:24 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGc-0004T5-Sj
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:24 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso2828858a12.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738346240; x=1738951040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5cZWceW8bztVnMfrmSKkFinK13DlQGyKEvQJijip1fk=;
 b=CjJLcduqyT5ppeNaQ2XfBbGiNYdjKGN0EylrQUe3meRauALQj15fOhZx+j0H8YFJ36
 4Kzo00NBEA0qAblIYywIM+Hw1VrKvXfx8wY5+sAkJ9R1A4g/rG1iPEzom1mYJ2WZhz6r
 kWZi0/uzv5nU5ygpqUXfSLtld0T7EzgtI84f4nWSiETNBP5oLGoEtd73ezYn1gkVA1mp
 BSMiNmueStIBJ/5JBhIQwRszr3Z/xYv6RjBOhxl5iE+5Km2EazzsyI2FVQKrbpU1mj3a
 aisIkmilnvDtt94rdWnZ0IPiLr3DGToFuMQYP2BoDciFxO39+KyGFs3f/8MVW7XAU0vp
 PqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738346240; x=1738951040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cZWceW8bztVnMfrmSKkFinK13DlQGyKEvQJijip1fk=;
 b=jIClcS6Z4shgxk7tlnTIlBD0qBlBFVeBRjMcwWR1b3XzrdRq5jSNjIsHHIxcQu3ioP
 PMDN4Te6bEP5olr8IOlsXp4WVka9NlmuLXhyTyNnACFwokKS0eQs9VTXI+kUOMKoZ7gV
 JA4DZnVZTaLHquQbCz9ew6pAqXkRKfPYlpxBZRcdxD5TW2SYs461WXHFuUfSgWcKGQOv
 cZMRE6HivrkJE1dcY+y/mMwcSVyUtljEvhp/cImeac03gEinqMfBWOflN/qQextJ1QxZ
 AtphmqP/7nPSpQZ5+0gHiuZkwsXn+lm5Cu004SUv8+UoeRNMslW/vWbgwR/KVjzfENkG
 E2Cg==
X-Gm-Message-State: AOJu0YybXp5fhy2o5UfxBFcwYO5UA5s/jgZFOroSoZX1arPTI/CvYo60
 lDbd6EigJ9PMzIIikfozffCXi7xCrdSBEbmGxeZKkLGEzRjTiADdkK6HSg==
X-Gm-Gg: ASbGncsIYr4OjckL5VRABl0wJBY6vjwfUHGIrJLCQnmfUwedELa0/7ForioU5JmxyMI
 +mfL2KmeVZJzKSDj7glNb3d4JrWqMof8bxYeZBHzVAt6izaxIbmSmsVyUiD9BM6ckykakRYWQhV
 X62hkkQa+iqL60Nc3/eos1djshSwUGfNR+0YDiAQJye5v0hrp47i+h/Ou2MildxGZYinCz45cM8
 Sm7514Zkz8fcHdg7Rih52UysanvHvGdZpogvgUwn/fmoOr5W4w8YE49RR/pzrKi0K1XiZqtHikh
 8b98N4nQ6LU=
X-Google-Smtp-Source: AGHT+IG5gNc5BScZl8l0O/9fuopDjDe1ikQy8k031wS4cJ7N/JjV6JIx39004qDY3JJpNMcVMWNAzw==
X-Received: by 2002:a05:6402:5255:b0:5dc:560:853 with SMTP id
 4fb4d7f45d1cf-5dc5efc5b68mr12260986a12.15.1738346239453; 
 Fri, 31 Jan 2025 09:57:19 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723efc45sm3110074a12.32.2025.01.31.09.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 09:57:19 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v2 0/3] plugins: add tb convenience functions
Date: Fri, 31 Jan 2025 12:57:13 -0500
Message-Id: <20250131175716.3218600-1-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=lacraig3@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This PR extends the plugin API with two functions which allow convenient access around tbs.

The first, qemu_plugin_tb_size, provides a mechanism for determining the total size of a translation block.

The second, qemu_plugin_tb_get_insn_by_vaddr, allows users to get a reference to an instruction by its virtual address rather than just its index.

In response to feedback from Pierrick I have updated the implementation of qemu_plugin_tb_size.

Additionally, I have added these functions to the insn.c test plugin in response to Alex's feedback.

Lastly, I'll provide a reply to Alex's feeback (repeated below):

> But the general comment is this is an example of tying the plugin API
> too deeply with the internals of the translator. Why does a plugin need
> to know what is an implementation detail?

Finding the line between implementation detail and relevant to plugins is challenging, but I submitted this change because I found myself implementing these functions in plugins. If you'd like for me to enumerate examples where knowing the tb_size is relevant to analysis I'd be happy to submit some.

Luke Craig (3):
  plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr
  plugin: extend API with qemu_plugin_tb_size
  plugins: extend insn test for new convenience functions

 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 20 ++++++++++++++++++++
 tests/tcg/plugins/insn.c   | 10 ++++++++++
 3 files changed, 51 insertions(+)

-- 
2.34.1


