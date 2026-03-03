Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B98EB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFf-0000CC-Nq; Mon, 02 Mar 2026 20:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFe-0000Bw-E8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:42 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFc-00070s-KF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:42 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8273e0fb87aso2749108b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500118; x=1773104918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X5L1Hjz372ds4F+FOYTjKFBen/u1i+ktROGLrxXxe34=;
 b=ntiKzGRcA2CV8mKhlPPYHHtA/se6CkvYFPLSRNn/s2QuELn1tqCo3S8mCBMGwQ7/6F
 KeK3/xzHL98D1sChLVzb2IFVy7VRmk59NIbns3mElsok6WmSItZerPOe6jje1r19O/+7
 nU+cU3Ng29JETQd8mPYg/8rRX/XLanWIHuMACMkEvD4wcaE/iOIKbJAkelFZqCtHLjYk
 dpL9+a9MT20rLh/34G7LfGkoYnkRoQSv9hNYt9bah7c0IvNdvAfdbFPsjpC/Xif3XP4a
 2JoN9zhdfFZeS7kWrYlGVtnsgckruZJlt2No6eXtXzOi1Asn4p350Mxz9Ou7mk7lPADs
 DCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500118; x=1773104918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5L1Hjz372ds4F+FOYTjKFBen/u1i+ktROGLrxXxe34=;
 b=wvvzviCgrzBoulC0jIawovSiG8dh8ilP7CPnhuUvVmdqb66KvOEnL9ilsZ9Yu/JuJk
 IjX1TW1BldNhsIpvpiEkYGQOF80IzJMfys+fF+g6i+lUmMjQhgZakuFWZDYpal2BM+58
 wzBLCASfMvpsZSNwq/0/h+5P/O8R/KitGWjRCWMU5/2E4peKgjGgf68pVod+LCKhZf0Y
 i2JSo1lgO0MTBdg3DmqDmP11bXEkmpQWT+f+xAxcHNqamL5hX64rOk9wzcqXWE5bmwQy
 6J9kcKhZ+sRDNvexjnesiqFku19If0FioZLkV6ZHZEr5ljeXyZGNrpyzlsLnShLD7k3f
 YdKA==
X-Gm-Message-State: AOJu0Yx2jFqX5aBmbalEtvD7Rwh+DozJu0YWhj5dBOH7jb06zC6NTxX0
 V3qilGVkfGYOhsedL1uLbIz8AS1CL0tpHCgBwmV2cAxjSB3TtAdVuJHPg7rG35rJRx4VZHTBsbK
 +J1DDT5A=
X-Gm-Gg: ATEYQzw2d5ieFC176Al4mUTrx1n7MyfVrniVPG0ip6LSGdoBLMDcEeH7SqyBzcPNTzN
 Jt+uN7pDgAQnyFYzxP440SnYqXJTiJto0a/qAWL8sxmf7nKd3hs/Xazi8fizzKh4x0UJOgNEv9N
 tZ+wPCejDx7gLlYJF9FmJCQANBf1p6ZH8mQYidct0EujFBFaMH0RqR1Aku7tfmGe4lShxqvbYu8
 2a8j8P1qkCPNsnu3pyTTyNS089UMtGC79XgBOSSxSCTRpAeVRAUDLxXgxTOct5RV6jf3+2V7a95
 mOaGH4cl7a2pkYsL4XdB0HSFrxfV55mNGATBxvhvBxq+mDMOPBu3vXCMVCj0h2hMQA4kd/GwpPF
 OgwJ5K2ph197XwQZtPvu0geu/rnFf84ZuLVF8sOphRHxlSgxo0uQ8O6LnOmJAsun4Blx3mUDJWu
 0LuqYCpOu1jK0neqkXJHW66V2RD+rY/ar5Yll5vjea
X-Received: by 2002:a05:6a00:2e04:b0:7e8:4471:ae6d with SMTP id
 d2e1a72fcca58-8274da568d3mr17101862b3a.57.1772500118387; 
 Mon, 02 Mar 2026 17:08:38 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 0/7] tcg: Improve extract and deposit code gen
Date: Tue,  3 Mar 2026 12:08:25 +1100
Message-ID: <20260303010833.1115741-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Changes for v3:
  - Drop shl+extract expansion of deposit-into-zero.
    This was origially done for code size on x86, but
    is redundant with the new shl+shr expansion.

Patches without reviews:
  - 1 (new)
  - 7 (simplified)


r~


Paolo Bonzini (2):
  tcg: Add tcg_op_imm_match
  tcg: target-dependent lowering of extract to shr/and

Richard Henderson (5):
  tcg: Drop extract+shl expansions in tcg_gen_deposit_z_*
  tcg/optimize: Lower unsupported deposit during optimize
  tcg/optimize: Lower unsupported extract2 during optimize
  tcg: Expand missing rotri with extract2
  tcg/optimize: possibly expand deposit into zero with shifts

 tcg/tcg-internal.h |   5 +
 tcg/optimize.c     | 266 ++++++++++++++++++++++++++++++++++++++++-----
 tcg/tcg-op.c       | 215 ++++++++----------------------------
 tcg/tcg.c          |  21 +++-
 4 files changed, 309 insertions(+), 198 deletions(-)

-- 
2.43.0


