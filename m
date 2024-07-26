Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F1C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXPus-0004A4-E1; Fri, 26 Jul 2024 14:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sXPun-00049F-Ri; Fri, 26 Jul 2024 14:43:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sXPul-0005iZ-T4; Fri, 26 Jul 2024 14:43:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc49c0aaffso8377315ad.3; 
 Fri, 26 Jul 2024 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722019417; x=1722624217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3f/5dqdjHzVB5Ks2A5QM+4rkcmI/TAPiTDSGI3yKC/0=;
 b=L5WnY8vw0E/U9lxoja3eM8B5kouLDzjA8vY5qZOifVrBFXg+kRFVbn4sh8ZFuZzeHS
 OYpLIGXn0vXDB1wOlWui4JwBCI1SsnKpf31HKrJ/jJ/OUkLIh8lnf+50fI04d9T7vXNj
 cJsFmF+XidIWrGvo0rIKa3ErohdFJ9+6zdS9hrV1L/g7EJbHSa6n4XbOMEK3VtU6LiqV
 PvbKlrNOO83+kpdtpyRy+oMJmKWGB1/yc08MhCT9TclZmJJmzQoyV/5g8A3TUwo2IRFD
 BiqpKbJcE0kJS73+bkiOPcni7VKr5wV/CkFsGOkmiStfyWAQCKSmQCQR23p26VdqTka6
 vSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722019417; x=1722624217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3f/5dqdjHzVB5Ks2A5QM+4rkcmI/TAPiTDSGI3yKC/0=;
 b=lScdtW2F3QtFTLGHF2AJHo9RdXy6EhT5NvQaHj/gy7167GWSOwVracuIwjg7IMIKZD
 6EhzPXen0R+YtivWF79VhKlGEU+y3sit2JeUVKi68S5O8zggai4YMYSuPiuavvxEqUxq
 +4EitK71TNiUj/xXuda/9FSj5khYy99/VXdkkIxYoWuMVdxTUyNsLkwStbtWxuCQcM29
 dQ55h4YdwdG73y1H3eQU+EdL6KEnaCUtClN6i7RTig6a5cF8ZwcVzbQgzP69VowZjMc0
 AVt+zclP/O9A5hQVzzbOQRDeMYBU6vNaYzjt0gzmoQgeYkxxR/Wo2zoBNaZ7xWEgyzgt
 mD7g==
X-Gm-Message-State: AOJu0Yzs7yKCQHOE04SYNrm43NzAUee1QDVIOp2G8F4pp9n/D4pL3N6m
 5Z/LvphiIrV/55v/VDWcVvg74++lLjPiWQzMJC3daUskYhN7pm8mxYfk3F4K
X-Google-Smtp-Source: AGHT+IFEDb6b7jJEt68yxEfbQx2y5rMCuZc5saYZrEUJ2MxS8L4YqoYQv3benWRXUzX3RYizR0XjYQ==
X-Received: by 2002:a17:902:dad0:b0:1fc:6339:2641 with SMTP id
 d9443c01a7336-1ff04950724mr5908205ad.62.1722019417433; 
 Fri, 26 Jul 2024 11:43:37 -0700 (PDT)
Received: from localhost ([205.175.106.198])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fed7ee2f21sm36173905ad.154.2024.07.26.11.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 11:43:36 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com, Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v2 0/1] Add support for generating OpenSBI domains in the
 device tree
Date: Fri, 26 Jul 2024 11:43:23 -0700
Message-ID: <20240726184324.597939-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x62c.google.com
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

v2:
- Addressed review comments from v1. Specifically, renamed domain.{c,h} ->
  opensbi_domain.{c,h} to increase clarity of what these files do. Also, more
  consistently use g_autofree for dynamically allocated variables
- Added an "assign" flag to OpenSBIDomainState, which indicates whether to
  assign the domain's boot hart to it at domain parsing time.

Gregor Haas (1):
  Add support for generating OpenSBI domains in the device tree

 MAINTAINERS                       |   7 +
 hw/riscv/Kconfig                  |   4 +
 hw/riscv/meson.build              |   1 +
 hw/riscv/opensbi_domain.c         | 428 ++++++++++++++++++++++++++++++
 hw/riscv/virt.c                   |   3 +
 include/hw/riscv/opensbi_domain.h |  51 ++++
 6 files changed, 494 insertions(+)
 create mode 100644 hw/riscv/opensbi_domain.c
 create mode 100644 include/hw/riscv/opensbi_domain.h

-- 
2.45.2


