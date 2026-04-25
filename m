Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA1FF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcuQ-0007OY-1r; Sat, 25 Apr 2026 09:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuC-00079p-QL
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuB-0000EL-BP
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f8892d4d6so3835835b3a.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123120; x=1777727920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ojdWe8DEiJvFMFhtT9VbXuuzewxCBF2+DB34sWnmVg=;
 b=cRuOi+NS3nAzEd0zFrCYoRkvgb8med0693MCPR0E9UEv2r406axRZv/pD28mt4D2Ci
 ECsKBQGoNLyHbhSK+yVNBmf2+aifBp9l+ZUaUxdWm/rZNmppYYhYS2Zk+KjioMaeIFde
 xWeG28YWdIKEK7SJAw9ABrzFxGLwZ8pUu3ffmJdP110L1YxUg/8ZviX/n6JpuO2iLFLQ
 DDs0mqS9WVh4OFxVvHBoZQwqLDDg6FyTOFTo7W8jkbVME2jaselv8gHazHPSdnOL2ikz
 Zy6eYyyxieJ5VyxLLp3QoBxesd6jDoIUeyzurTp3cCC9utePfmBeJ2bwtJXS2u+Scp5/
 M9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123120; x=1777727920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ojdWe8DEiJvFMFhtT9VbXuuzewxCBF2+DB34sWnmVg=;
 b=SqZH7YUpgFx1/6lcIERWeBezrJJ0GgcTalg5i71IHabrUZ/eICrFd4nQPGd1f7eI5Q
 WiA/Jm6zoahZC4Q6dS3PChHur8cILdvPAswSnv7p/FcaS9T75UaheaVU5V6M979JI0rB
 Z6ooM7bL6Hq419v0bWRKVbdwkg2Bfx85Oh82cenAbxgs1LUXSWuNI06v5YGtftJD/Mgr
 awduC9a/us300rmXala8h4PBo7O/aQd1q6Hp3HxCO9w4vLKevW3O9B3M/414p5ewEiZJ
 aKyUVLL3Gcj4MOAzb9DxrM2DLcWhWKiuVNCsmY7wylgLZvWTnUzVijWU79kvIiE2acdx
 uOYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2/cmKNFSOzLNMkEMuqQabtuOiOZu80C4tNIKdGh7Ynitc01Za2Xmr0dMbkHH7n86heuK+h2taYd7G@nongnu.org
X-Gm-Message-State: AOJu0Yy2oeu4U2gOO0+KPEck1EkLBVKEOKuE3GlNQgJo5bPNvdgLBNze
 wJHPl+5aUwazlcIjxZZmzDJHDW1bY4DBfUZfT3oO22VH0ouxkktUEZJA
X-Gm-Gg: AeBDieuTKOb4BcUiO8K0qkJ88VfTEgaNDLFeD8Cytvk1yR2W+ed5cW79zHr+tVgMEvZ
 6f6m69VZr3UwKaAopf/sUHotRc45U40fOs5KPA0os3TrUsGuBftWFcK/kxixSZ8vU6z2UkJd5ev
 yvwr2cCvLXS+OmnyhOjyMvi6b55npwy/dC+Sprt5WixPElnYddKbNGGCOzIfNW5w3ZppNaJB8/g
 gqcJ/YE6weEMFBukhKxhij6zY/7/D+BGQxQdTzeXMAP85eMyEUJ7nDzreNgajHHEwpUGMlSRhPo
 AHwv43Tew1b4SYRJxRMeUcSVP5VOlJHH1aBDeHSiqnHLD8eopYOA6BTByr5XtotZIMmnlsPf0AI
 LnsbmJvV6xiqEHw//gY3tqHz+Jnkgedv5nxv3JqyaUVMFVTb37Vws3hOqrqhjaWhnDYwvTJkG19
 iUlWa0YT0FZmZ/5m+YpA1QLFOKTBMjeXSui5fDE5dCfdCQnK2QnDWU5pubSjE79NtZLg7pL2n7/
 2I02vlUpW2oOM+PSvwPQhLluydNhvyv
X-Received: by 2002:a05:6a00:bb84:b0:82f:1d38:f693 with SMTP id
 d2e1a72fcca58-82f8c8e0f98mr36573368b3a.35.1777123120371; 
 Sat, 25 Apr 2026 06:18:40 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:39 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 08/13] target/riscv: tt-ascalon: Enable Svadu by removing
 Svade
Date: Sat, 25 Apr 2026 23:17:14 +1000
Message-ID: <20260425131721.932250-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Svadu (hardware A/D bit updates).

QEMU makes Svadu and Svade mutually exclusive, remove Svade so
Ascalon comes up with Svadu working.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69649462dd89..97e35672649e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3204,7 +3204,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_ssaia = true,
         .cfg.ext_sscofpmf = true,
         .cfg.ext_sstc = true,
-        .cfg.ext_svade = true,
         .cfg.ext_svinval = true,
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
-- 
2.47.3


