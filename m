Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF5CC54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 21:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj488-0002ry-GR; Tue, 27 Aug 2024 17:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sj486-0002qS-Gr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:53:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sj485-0000uS-0E
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:53:34 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7cd76b56e59so2101813a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724795611; x=1725400411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VyksA4hwbgCNHrndNdLtbY6rlOpmDyueTnwvm2JzCLI=;
 b=DyD+G0pBwl+AwMdZbR4QNZLd7LmkeOOJtBOV2fKuMTPcKBQKnESA/q+ABg+RPon87z
 qJcQIrcQ5GnUhzcDalNc45E9ZNgWvl95DZhSqMIe22MJsqXRiTu44jDc5j9GEJjquGnV
 EWD66LtWg976RMm1c/jL77lK3JRtXpozP7fmeth4cpUVttTX7twHx1zBj1tts65AiOxP
 heNiDjurAROA2bkXIr0K92PINu4C91pFRFuSnzyPxwGAmUPM5HbmF3ltLIm0NON4qTpa
 M49AX5Sn0R6Su2ywoQEmpAyqe8BdIPhU0ZDXXIEVPW47kES3l4lOYAm/RpAQg8vdXS7o
 QVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724795611; x=1725400411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VyksA4hwbgCNHrndNdLtbY6rlOpmDyueTnwvm2JzCLI=;
 b=pTQJxhtu7Wdpd8dV2E9A8LqlMbVbsFmZjp70GfvM+uydusXH7cqJgOroQVVe2y3N0p
 f4EiKkFT7qbOdNmUi37CCX/ljpAJTs+Uga4ZpqfGFmosq5nrtzh/QsQQFkLXijhRrMN+
 u36VJRYFccd53BeBMpeSFtLyODR51ENIy0uitKS6yUi3wk135wVlaKbTn6RYJvHxM5ds
 HFadxzhza1coRk8m+NSIKBrZ0WrMaLI+qYRfGq+cSoCZPeNzY60jqj5Sciq0k9g561Vq
 zHgfqEySmKfMqps60yIJ4RM8z2orGJ9e6Qu8VqvZJwydpbehQXIHG8YpY730PiGSZ36v
 M84g==
X-Gm-Message-State: AOJu0YzSBOAmBz+CWYOJ01HdOzWXtys8qJpmdPhDsk2UBohc4yru9WY6
 HrJ89/FOI9km7aASAj5YENV9Zck3h5TJsbnV6LxtESwkDExOXS67msqL6YZprPoAGg==
X-Google-Smtp-Source: AGHT+IFxsnMYFs3eCpuVzeOQE2K9vtcBZCwRQeKl1hdGgZF2W7BSCxe5L8bPMiOl5jomARskl3LNZQ==
X-Received: by 2002:a17:90b:3144:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2d646bd1a32mr18213803a91.3.1724795610910; 
 Tue, 27 Aug 2024 14:53:30 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613b1f0d5sm12671445a91.55.2024.08.27.14.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 14:53:30 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v3 0/2] plugins: add plugin API to read guest memory
Date: Tue, 27 Aug 2024 14:53:27 -0700
Message-ID: <20240827215329.248434-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds one API function to the QEMU plugin API

bool qemu_plugin_read_memory_vaddr(vaddr, GByteArray *, size_t);

The API allows reading memory from an arbitrary guest virtual
address, which is useful for many things but the motivating examples
are:

* Virtual Machine Introspection (VMI)
* Accurate and easier execution trace extraction
* Debugging and logging tools

An example of its use is added to the existing syscalls plugin,
which now has an option to hexdump the buf argument to any write(2)
syscalls which occur.

For v3, fixed a missing '*' in a comment which caused a doc build issue.

Rowan Hart (2):
  plugins: add plugin API to read guest memory
  plugins: add option to dump write argument to syscall plugin

 docs/about/emulation.rst     |  14 ++++-
 include/qemu/qemu-plugin.h   |  32 +++++++++-
 plugins/api.c                |  20 ++++++
 plugins/qemu-plugins.symbols |   1 +
 tests/tcg/plugins/syscall.c  | 117 +++++++++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+), 2 deletions(-)

-- 
2.46.0


