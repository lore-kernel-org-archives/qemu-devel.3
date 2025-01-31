Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6CFC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyEg-0003Ew-G2; Fri, 31 Jan 2025 16:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEe-00038m-My
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:32 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEc-0007y8-7W
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:32 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab70043cd05so230132766b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738357648; x=1738962448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BetlsGPf6x/cAu/u2HsYJvno1Ndk3VLiQmEbobhwDUc=;
 b=WlBs3W4Yl3Ar62o/T2egcWzFgOwZSoSWZcZAvU7akPr4TwmOt80rglT2RP/LRpcLLU
 wB1fgz6hzKfzZp/eTeq6cOks6ABWxmmLYzJY+pDoWeinyHWS/WkGXUi8v47sZ+X53GHr
 uSvDtLg+3Ag7+UcozyE3gO/l7+H3SQMeUEyRYqt4iC9sv5MBnJz+dUnSwikb5jyqejGi
 5QOGqzrtS2l5zQogIHasKQstcor0jRVDHbOnWDpc20MyCFqdpLIniQ4GuPLvqHiSyEp3
 nSTLfHhOHMNunIw5i3cjzuPsiDlYAIRHD9nZFCiZUl6X+JjJ21a0OuVq4yaO07uN3wPS
 L1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357648; x=1738962448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BetlsGPf6x/cAu/u2HsYJvno1Ndk3VLiQmEbobhwDUc=;
 b=VjonCoABSSO5pyigqw95KUKGBhZBEKKg7PHwA8EcavTpA/ToPNz6gYKyrzI3+kDE7Q
 QxInbS8HPOCABSv75CNP9ysLqiHTdKMYhBvMq/GYnIo3gGO07Qan1X+wqMw22vafwtYP
 0n8XtUMpMotq3iGQw3ofQhjoT+FkJzIAiniogQJGmZdYMmWHsuP7SEwoyP6ew8w5qkal
 uISxFl2AGq2KCFwA+JXHs+uITgherpGKLdfzjQhUkO5ObO/wkEGiWkH6n2hS5HFvVhO5
 c8C0NdPM/AJ29psy7HMJod8ptygtnzSGw/P1zkmL/GB9BMHzQLK/o5hYb2hy0OljUpSI
 D8kQ==
X-Gm-Message-State: AOJu0YxCWWe6X+04dQwLSqiAk3hcICWl4/2WrLqki6HnV6S2cm7QqJyq
 Wmyh6S9QUcFDc6z9an7+W46Tdyx4O4tAR519nt/geuIL3DAHhe07eTXZKw==
X-Gm-Gg: ASbGncta+Xj99hRdAsEY3sSrYaHd4411ttAOiELBjmu51OdgE9T9nUNXUW1KTBYASH+
 nU0PaLppU55KVfTtJz1qV2/YN76MTNI780eydg8smnh45CJYXD4s10VsVCytm6iqHXs0/f4foW3
 yFcQ2xW+ZRlrONgf5+BKjQk5vWwyqYUhOnDkjZlcQsqB5WS9pjTfjKqO1yIJf6CMhqMHryfVtuW
 +jO4mxmNLJPwHlKsjfbYd9iU0cFKvaDobRAxHFCeRo03tm42TKk0TBacrcBlYAMTLFJ8UrMwaPL
 ts2Lyf8m/qM=
X-Google-Smtp-Source: AGHT+IHjVf6bw7Vo228BZRbkDY5BtEXkcarmCOTXp7chSJN/BkBoVm8xzuyvxuPFtHJZInMXJI7rQg==
X-Received: by 2002:a17:907:9493:b0:ab2:f5e9:9a39 with SMTP id
 a640c23a62f3a-ab6cfceb67dmr1227575566b.23.1738357648086; 
 Fri, 31 Jan 2025 13:07:28 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a31624sm347719666b.142.2025.01.31.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 13:07:27 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v3 0/3] plugins: add tb convenience functions
Date: Fri, 31 Jan 2025 16:07:21 -0500
Message-Id: <20250131210724.3330110-1-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=lacraig3@gmail.com; helo=mail-ej1-x635.google.com
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

This PR extends the plugin API with two functions which allow convenient access
around tbs.

The first, qemu_plugin_tb_size, provides a mechanism for determining the total
size of a translation block.

The second, qemu_plugin_tb_get_insn_by_vaddr, allows users to get a reference
to an instruction by its virtual address rather than just its index.

In response to feedback from Pierrick I have updated the implementation of
qemu_plugin_tb_size.

Additionally, I have added these functions to the insn.c test plugin in
response to Alex's feedback.

Lastly, I'll provide a reply to Alex's feeback (repeated below):

> But the general comment is this is an example of tying the plugin API
> too deeply with the internals of the translator. Why does a plugin need
> to know what is an implementation detail?

Finding the line between implementation detail and relevant to plugins is
challenging, but I submitted this change because I found myself implementing
these functions in plugins. If you'd like for me to enumerate examples where
knowing the tb_size is relevant to analysis I'd be happy to submit some.

The change relevant from v2 and v3 is adding a sign off on the commits (thank you Perrick).

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


