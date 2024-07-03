Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AA0C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 20:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP6ni-0006PA-NH; Wed, 03 Jul 2024 16:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sP6ng-0006OI-Fa
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:42:01 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sP6nd-00048Q-V9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:42:00 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so3418131a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720039315; x=1720644115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8YUmQFY0WwKgGPwjaUXJEir6/u+cqixc4Gcal+YbCms=;
 b=So1MPllfh2Jd+T2lkdNBzWtZjtaNZhoacXY8/RLi7sUcM2G0yJy/nWsxctgCXtgBd+
 JE3cWnibJqyLcs6AAPCZ8qRAyCim62kv2mElsIAXN3AT/NKpTqtxwDWIfipK3jw8iwCx
 YC9INmmhKE1JQ0W1Y1J+Q07iDio+wQMpSlf19XQzNnLtFZaHwhhnmnpC4cKY1IL8hwLn
 DsJwv2w2EcuCXyfWjWWOlNZZgY6fk/DdMS0a2xUHToqHJsKppL2yIuP+ln9EGFM/F8In
 5G7heQNDdyWLSdckKrrMNirV32mnotm6NrdFE2Ckmhgp3a0nDzETtILOPsRGuDqbITHk
 0vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720039315; x=1720644115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YUmQFY0WwKgGPwjaUXJEir6/u+cqixc4Gcal+YbCms=;
 b=Mry87isinlOKlVt3tK9SBab9XZ3N7GPCAC4FLcPNjEcUTT57HhHtPLYt8o39qJrDHG
 jgBxmBgP25EV6goAhXv51OAPl5RhaNxBcZv9RbDmtHxPhxa81Nwlzn5tNJzrVdJAxVcQ
 j1gCqzZHAoohfbppQyv0CD+U6Xjw77ld2JAmEkMR0RZwSv+evvsYjkwnb6oiuB0mIzIG
 cjvrsvxdpBbvSW/d0ms+LeiGFxFc+LMPr744UmscJfVvHlJmUol7lBrnq7yDcmKDjMmE
 DpBi4n5dqXQyVCnUlqCcVvuWrYNXiyR1KTHXTcJF2ZMvNMfSjvfBCqwI0eHe2c4tes3f
 FlHA==
X-Gm-Message-State: AOJu0YzNBb8gEG4N6hUbsqTPoaoG4VtydSeZQy795NlsEA+z/yPtN80I
 y/bYZipuzj1A0usGVaBTCaGyJsfLRNGhg+8y8KoTaPX1bhfoi4YSf3KSus5u6mcsaSZN4OSS6xJ
 p
X-Google-Smtp-Source: AGHT+IGuD7LRYfNbYAQod5khucr/PdzI5mDAtjZp9xl7bQ6XQkM/AsG23/R0SWsl6FZ0p/xybS76tQ==
X-Received: by 2002:a05:6a20:7fa9:b0:1bd:253e:28e with SMTP id
 adf61e73a8af0-1bef61398b1mr13361542637.16.1720039315593; 
 Wed, 03 Jul 2024 13:41:55 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce42667sm11284888a91.16.2024.07.03.13.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 13:41:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com,
 eduardo@habkost.net, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] object,accel-system: allow Accel type globals
Date: Wed,  3 Jul 2024 17:41:47 -0300
Message-ID: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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

Hi,

In this new version we followed Daniel's suggestion in the v1 review [1]
and moved all 'globals' related functions and definitions from qdev to
object. Functions were renamed as follows:

- qdev_prop_register_global() is now object_prop_register_global()
- qdev_find_global_prop() is now object_find_global_prop()
- qdev_prop_check_globals() is now object_prop_check_globals()
- qdev_prop_set_globals() is now object_prop_set_globals()

The API change that were done in patch 1 is now being done on
object_prop_set_globals().

It crossed my mind to rename test-qdev-global-props.c to
test-object-global-props.c, but since the file is dealing exclusively
with qdev related tests I think the rename was unneeded.

No other changes made.

Changes from v1:
- patch 1:
  - move all globals related function and declarations from qdev files
    to object
- v1 review: https://lore.kernel.org/qemu-devel/20240703094626.1704990-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-devel/ZoUwMr1X170aQNDS@redhat.com/ 

Daniel Henrique Barboza (2):
  qom/object, qdev: move globals functions to object.c
  qom/object, accel-system: add support to Accel globals

 accel/accel-system.c                |  2 +
 hw/core/cpu-common.c                |  2 +-
 hw/core/qdev-properties-system.c    |  2 +-
 hw/core/qdev-properties.c           | 71 -------------------------
 hw/core/qdev.c                      |  2 +-
 include/hw/qdev-core.h              | 27 ----------
 include/hw/qdev-properties.h        |  5 --
 include/qom/object.h                | 34 ++++++++++++
 qom/object.c                        | 82 +++++++++++++++++++++++++++++
 system/vl.c                         |  6 +--
 target/i386/cpu.c                   |  2 +-
 target/sparc/cpu.c                  |  2 +-
 tests/unit/test-qdev-global-props.c |  4 +-
 13 files changed, 128 insertions(+), 113 deletions(-)

-- 
2.45.2


