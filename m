Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8906CC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofnf-0001TJ-9m; Tue, 28 Jul 2026 07:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wofnW-0001QX-PE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:16:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wofnU-0005cp-UF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:16:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so27694305e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785237391; x=1785842191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VOFBP/T90PBYUvVnaOb7OX7hosCDnhBkxoYr0mmJGQo=;
 b=wgpxRXZle7WXQ0a6QCHrc9C9hFEqGh28ZmHMks6+iTei4zilMbxFfPQj/LpZZ3Z/Hl
 ZJDQuO1/8g+OppD2HqxAgaCUkQKqTRl9D54cEqy9AcT6CANQtLgqQoMifYCPYH+58kca
 GXEguco9aXH285g8VXEu6eJ8bCB6DweYz8Vz4oa+Es5EPsZusmlCBQDbJJshCoB6q5gm
 guSNjBBQEReGIHpA8dZk/u8ziwnH98LoTGaKwk3cQ3Jcvo5CJwS/VOrWrNwcfeTKkXG+
 J9dDv/E2l73V0oTKWAZmGxqlpDlQXwxB+4hAIA7WjQqCybbf0rZ/thEGx1Ni2Z6Wpbya
 RbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237391; x=1785842191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VOFBP/T90PBYUvVnaOb7OX7hosCDnhBkxoYr0mmJGQo=;
 b=ksaGYAK8vB4buzILqPDRl5CXpRZ6FaPV6PL/ILNwk3j9M+N+MjqPBExWc3rTAtjzk5
 7lYkxCBVmEmcGdk8O6Y+9c4FVPFK3Mj7/8gtcThcRvMpgsg7bn2GKX/nGaXBchM/jhad
 wUkJyprZTZr4n0qiP5l/feaAoNff4sSBM1WMeeu7bTXpa0n7s96rXfKbLMNky4XQk4Eg
 KrWfJJN+BrNQMPQxn09X1DstuPM7Ql7TG1g/0RFjlc/DcURDe3Ft9GWj2Ce3J5sSn27q
 WnMq2Q92sR6+CcN7vbITof2ChOOKVs3R6whz8lEMcDtSQHmXwMz1dPlYAmXfhreKMaXk
 G/yg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxHXNugkeSZNJGYYAFVYURjlHXgPp21riR6FA7cQEC21vIAhLItFNJb2gJZbdXBgp4BuRXZveVR4nM@nongnu.org
X-Gm-Message-State: AOJu0YyB5IoQtxunWKSGdNdY1eqTSb4k5TeBs1tDLdy1YY5HYNxnYWFb
 UtoUy0t6omIF0dwN+3o8raktUXAwn2smENOXVyLA9HJspg6IrTf3VIjRvNdc1m8QevQ=
X-Gm-Gg: AR+sD12L34YZJvfqYZWb2MX9MxB4qQtyV0ndYgcnydTdPmKekz0dSM+yA6AaLa/LNIm
 0PzuzplcXof1Kl27HPfDz2cuNyhC1ykZpcFm04CS8xwKgdrS3H8KcvA8g2uNGoMRyo/BPZntv/8
 QLq4+hJL4S+DB4Ttsm+sr2k6TlA+yLv5VpqMdAo5GOIze0iJZ9j7oR/hTxljfselQq30i6BC/dT
 spUlFB7bBDmJFaayYPKy3cZNz6mvLAol9CzTtxdefP6nDVysreZ+wkmB2zv0GdUIDbVWuySg1IV
 WozBgr1ChbAJ/mAXLhQP0QrK0QM3j9x9dnRWycCsPoRpTio+znkycoz0Yz+PHgiPQBo8hM5E7Kf
 gj0NW1NFazDyIJoIy+AQ+CR3Y8SvmrWIPz/tjR9wrwPZobfKuOErHV6zCajaaYp+44kG1a90Gq/
 UWq7vyr3/Aju9+O/Mz68WUys256EGl1gvmu57zdtRgT8+fYFrpO9a184beZT6klsHodjy5m11in
 mT5XdJ3LxhIZ1RKPWax6g==
X-Received: by 2002:a05:600c:4fd6:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-496c64394dbmr21014155e9.11.1785237391062; 
 Tue, 28 Jul 2026 04:16:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5ed646sm284546255e9.0.2026.07.28.04.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:16:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH for-11.1 0/3] target/arm: Fix SEV/WFE handling for v6K and
 earlier
Date: Tue, 28 Jul 2026 12:16:26 +0100
Message-ID: <20260728111629.1705308-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an extension of my previous patch
https://patchew.org/QEMU/20260727151325.1428686-1-peter.maydell@linaro.org/
("target/arm: Don't NOP the SEV insn on v6K CPUs") to also get the
architecture version checks right on SEV, WFE and YIELD.  (That then
means all the insns in the NOP-hint space have checks in them).  RTH
suggested that a mismatch in the condition check between WFE and SEV
was more important than I had thought, and I agree.  A guest might
choose to have spinlocks using WFE/SEV regardless of CPU architecture
version, and rely on them degrading to busy-wait loops on older CPUs
because both WFE/SEV are NOPs there; if we make WFE actually wait but
SEV a NOP then that kind of code would deadlock.

Patch 1: same as previous, already reviewed.
Patch 2: add checks to WFE, WFI and YIELD.
Patch 3: trivial comment cleanup.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Don't NOP the SEV insn on v6K CPUs
  target/arm: Make YIELD, WFI and WFE be NOPs on pre-v6K
  target/arm: Remove stale comment about WFE/SEV implementation

 target/arm/cpu.h           |  1 -
 target/arm/tcg/translate.c | 48 ++++++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.43.0


