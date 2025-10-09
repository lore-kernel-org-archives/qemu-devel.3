Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71558CCD18C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x7D-0003QY-IH; Thu, 09 Oct 2025 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7C-0003QL-6C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:19:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7A-0007Kn-93
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:19:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so14056685e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041190; x=1760645990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m2Lyt+0udrVb1mOdX7b54UqQtjC3opuwdxGlwegG0f8=;
 b=pwUQK2hfDk6x+onq/IZ36WCSTECp3gWzYAypdyrIQzvhVrX8G/Wb+8hZ71A9g252zk
 s7xkfXsH2jj0s5k39fTGmFrU4/zPtL38Y7HquMwq5+FMQxA7SFm32p6IDtBp3SKaMoCs
 dxKD2AdE7Gu8lCFz0HYEhliPyP92LfDmm671xnxfDJaxDdIOO7ZDIG+s0aB8ILDb9L8n
 HHK60+bJ9GViPDYY3r71+gXE3dVY2QBwxakk38D4jFlBksiQnb28BRO0UssAu+7E3OM8
 DJxhEGgmeQjCctIwSuQiRJAF2dDtqw8MMW5e98pBvQuW0Cbyt1sXFboJ6gUYtfkrJBVp
 c4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041190; x=1760645990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m2Lyt+0udrVb1mOdX7b54UqQtjC3opuwdxGlwegG0f8=;
 b=Lx12IK5xXp8YaeUJUqjwXfPy5fgQ4LWu6RXw0ldJj8GV7nBenNFiR4aaA2XspGeBlB
 wInFndcOR8eVs8YoKKVaXF1leOINUoxewRdqhsnOuGbfQxu0RVbSj7RzxB3YqWjuI38w
 SMYDe5Mpp5JFqCE+8c0ZwTnNKOSVxSF634oEjLrnkMIIdQ4gms1fAnhGTIaG76K0Oeof
 JboDgL+3nwEJMsI0pTSAjZXpc01edWegl7/eDXoXox7Nj/bMkuVY8rnBnGDlg99ERUjU
 fw04m+M7xZRhRWYvuk0BkiAcbdQtQTQ8O7/jIK3QNzppIlGYMrbuwbONUBnzHjWpaxEQ
 sVlw==
X-Gm-Message-State: AOJu0YxfU905QG+3Ee2CRY1zh0WJMRr3rjed1fNvS2wcMUKWS+gUTEY8
 7zAD+aKiOtZgGOHF0fPKSIpozg8snFwbaOOvjiX2OlKliGnLGw1jCCDEi7u/tkvG0e+8/YM2MjW
 PCPh/psNnWg==
X-Gm-Gg: ASbGnctjRdfUodT4jSZEDI+K1zCnPE0EmH765Xb+b0ohtBzMgZLalF2vz2AJ9wEBB8L
 lmL43qIuwZLL/y43hqILFUB13+5cBQQT7Pl+zRpKdldauXhRGfszW/24NU/gp9GeIRt1XGa889q
 6oXqv3ZChZ4uyy3Nb1PKIn0B4syElMWEJWLBihkTkKUNJtTZMwVdiA2dzWqPB7POHhbV29TU2Dm
 HDfU9ylKEeQUNlzdTHhdj5UEc9oaDCKIu/uVKkKwqKeI6+esdTS2Z9RqR1Jvg38p8GoXJPB7kfB
 3+YMDA6dmMN41seLqKRMO6BxaITKEXuKHzrAEf7nY4B9N0gYttujpIRg5VO8DlUGT/GZaQsKcm6
 ecHb310ElpmqEbYa3RxthL4JZ7PcKZ0gmhMHakDBceFmQLACY7Nwc6EeEpYutugUDD798Noh7/G
 exgx21nV6ToxY/tyzMWXFANVCc
X-Google-Smtp-Source: AGHT+IHdHiZYOgLdSFSBBH30Evkagp5eu8ZZa7pijO/prWLUszInI9kqteUTsUrrmCwq0f8IT8iNVw==
X-Received: by 2002:a05:600d:8108:b0:46e:4580:c6c5 with SMTP id
 5b1f17b1804b1-46fa9b175a6mr66602565e9.35.1760041189667; 
 Thu, 09 Oct 2025 13:19:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497aea6sm12210915e9.4.2025.10.09.13.19.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:19:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/loongarch: Remove some unnecessary target_ulong
 uses
Date: Thu,  9 Oct 2025 22:19:42 +0200
Message-ID: <20251009201947.34643-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Remove few invalid target_ulong uses in LoongArch frontend.

Philippe Mathieu-Daudé (4):
  hw/loongarch/boot: Remove unnecessary cast to target_ulong
  target/loongarch: Remove target_ulong use in gen_goto_tb()
  target/loongarch: Remove target_ulong use in gdb_write_register
    handler
  target/loongarch: Do not use target_ulong type for LDDIR level

 target/loongarch/cpu-mmu.h                             | 2 +-
 target/loongarch/tcg/helper.h                          | 2 +-
 hw/loongarch/boot.c                                    | 7 ++++---
 target/loongarch/cpu_helper.c                          | 2 +-
 target/loongarch/gdbstub.c                             | 2 +-
 target/loongarch/tcg/tlb_helper.c                      | 4 ++--
 target/loongarch/tcg/translate.c                       | 2 +-
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 8 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.51.0


