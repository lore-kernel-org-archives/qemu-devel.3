Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23A0CD0437
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd04K-0003ZD-HU; Tue, 06 Jan 2026 00:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04H-0003Rj-6s
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:21 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04F-0001kO-JP
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:20 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7fc0c1d45a4so658298b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679037; x=1768283837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBT+n3DU2JYMLHmwZN/8VPA+sv5Vw0wgFhnVYyDNOdA=;
 b=J3c0eSYYtnJet5vRiqfPT+45z49Tj11Czv33AJocTltippBWGtVzsV3E5w3UILn29g
 6RvsQoKgptliHs/SjdfJ2/fy322KkeiBol4sUzkG0VWu9qBgECwt4YduHZ1NnbR0w45e
 ING5dDu8A8fhfHHunGVJq8HBPm2uoRy4nnPUJg1ULC3PjR/dvVQv71TyD05cZiDheaT8
 THLh81oVpt3GGDlY5aIPrTMJY/HCQg4gh2UbAnbATW9v/4/tde4YHolnNLN8NYYEQ+Yt
 Qw96P61RdGV7irJjl1MLeAA6WGq7NFJWBY00oCB+1awYYMPY3iT10NYuU8aFx2RZ7/Ig
 NzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679037; x=1768283837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OBT+n3DU2JYMLHmwZN/8VPA+sv5Vw0wgFhnVYyDNOdA=;
 b=DFca7jI4T+AxCAevAheJxC820ntp0hmK0PsvVluN6K4675SYmvErUaTO7o4f+xDX/f
 kAuZPWoTKdVxbi2lYn6k7OK2nYz63FBiwLthezR1mIBnBVz20xczNwFig5phwn+nE++I
 52EAp8KdeEmHkpeQp6t4Dl55rQ/Ez6yCIvi/NyIKjNgTEzVDYd9EZDAjpAMD2fruBucF
 80wRAJ4FYyDMbfJKmVBP+PFT8Zrw2XbLEhHzbKvlrh8Mj5qi2rDMJwGjWe234u3CiV06
 3LYMEu3MBjgGeKHQTL8oMvAGXAZGh6O/M4wfIw4uJ+IJhVRrOWcj3gU7H9gmF2V+OZTY
 zVoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEBFy0nD26AlN29Ua+FVgJGem0fEATfF0GVjADeHtMXxmDCb2QnpuKf7ntLX5EjA8Lqu900RZYMqjm@nongnu.org
X-Gm-Message-State: AOJu0YyqFnfKrc7TiyzuvNpxhqf1kgphmQB6ESgwCkK4TZukIcJ9LQ+j
 +UBM1EJfeUAkx1driO/CoAcIgQyxcj5VCdZXJUjtv6vIGW1asQVK8TND
X-Gm-Gg: AY/fxX4OYRkxoHoLDFYvtbqpZssZfPxQvXNgiAql7pjPbTmPUy8LgbcTzAOnmrJiJ2F
 vzz/+PdZoU4jQ5qBhRc2akxlkudB2flZzrUx+EkrZOpqPVFvqG9M9UJ1P6xKgBWZgN51dOROKOR
 SSFqVkpeyDtvHTZWO5T52J0s63ufqqQxIRx9uZwKIi+kFRLqXSqUofjD3+5r0lztGl8lVlVBm4X
 a65trHs9WYzne96D2zz/dNwhYqIXvI0nQIksIVVysJd/qChdJZYffGKPQXkVvvcFpS279lUGk3G
 1jo+ri4xXu3GIC0UoFMQRAKJ85hpOFMZ1hnxFfcmyjEkTBzaqZSWBNNwiQjpCpsar3cOIdagYs2
 ITTh8u2tfq+twx2I7QotZGYGpN/ZrKPRAm7bQWvvlzTqTOCsU2rpfvoHdWmcXGMTPUgXi/rmNWa
 DhEPMVgcpWTZUU3GLEuTKK
X-Google-Smtp-Source: AGHT+IFluTxtfqMRN7A0OP82YV/thPtydBu1y8LdKSjHHoAKHxGf3Gq3p/CT5FStcCx078l7pV3A9Q==
X-Received: by 2002:a05:6a20:e293:b0:35f:5fc4:d895 with SMTP id
 adf61e73a8af0-389822a574bmr1626785637.30.1767679037036; 
 Mon, 05 Jan 2026 21:57:17 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:57:16 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 01/16] target/riscv: tt-ascalon: Enable Zkr extension
Date: Tue,  6 Jan 2026 16:26:41 +1030
Message-ID: <20260106055658.209029-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c84..2f31e79ae6cb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3169,6 +3169,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.47.3


