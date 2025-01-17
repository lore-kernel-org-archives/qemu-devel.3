Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC71C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2R-0004aI-6h; Fri, 17 Jan 2025 13:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr2G-0004BW-05
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:36 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr2E-0007wI-Gn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:35 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so5847523a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138333; x=1737743133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1SIeY37CMzXA5XDrmfkkdr3FnSIL/bvtLXVM8kBUK0=;
 b=eroRHQNfz40Ep5kdbR0ThLy+2PLQgUDM4eNtwQ0e56i7T8IwgMnlOaEZ0Y6xrM/PqH
 mzutK51ZmFmV4KrUVg9EkYzmpx8KtjDdCOsfup3VMyiipIJ9EyogIgEfLHVeNMqahAdr
 Y3UZY27ChkNi8Tn3md9xKwSjiL7bPnDapue4RYsQCUQc4DoR3vRDvs+7c6O2AQhR/kcl
 dVL52lW9hMcIAq3EroJCxz9ZOIbQI5MzqEaEBizQiXdhZzUS8UvqRn0sIOpY2MgkoVzL
 0PRcS7oGKPI3BlL9R7FHbiBxaW04MijhqOv6FSpG1pauvWnzvnj3RSdtfyQmw6G2hp/r
 QTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138333; x=1737743133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1SIeY37CMzXA5XDrmfkkdr3FnSIL/bvtLXVM8kBUK0=;
 b=dP1SQ7BG3gsGrFHODfPV79WfSfLQGyzXi1muIhPYr6En8/Hf0vKoLmKLTWamzs6IMY
 ufScGtfoRHURKY0OrpXK0jQsau0aRKxdBMCrb1kG7qr8WyJda3omaMbnhQEWZb8ZcfJL
 T3NfrWGasbjH3F/GbNs3k9nmLcCWg6FdJT1QpjxD7T9HiWbuTkcCWBtaDaG0jGZsmlqd
 IWwTKJEOqJur0aubzHhKpJpROMYzIaR6A6IkQHe+wzMvPgPyAd53gN1NMYtX3/RSOWsS
 TmOQK4NUuF0HEvDgnvvcaBGL93/xEfuujUEufV91BDq4ZS0956cJ1cgbXLPm/GBy7m59
 7yNg==
X-Gm-Message-State: AOJu0Yw5w4VJLkftSzrBMWejaaj6JCemuuvCEkejXNv7wSnxR3r+Oq3S
 ziMMnb2n81KYiOtL2FZLz83W3QM/ex8ZYw+5Ki9sDszetDJ9pf+sM7jBFpeGtcDKd9qT11cAHF5
 5
X-Gm-Gg: ASbGncse7y5AiguirvTTwjf7a99EvR4fSd6BNF4soEkJFgBP7HF9ZP4Wyw9IUUHlpx2
 NStbnWw/ZoDj6BcZQFOo6+O4h9S8fb06K49vkHrBvx5P2P52Mqc+MqFcLDfa9NexN7K37AQjCMH
 djMOkjPI98qiaxsxiTyE7RO3IHe1rdc67pswbUvttF5DJ3GIy9pNci8USKhPEln0qkml4VkJXRf
 4z1suv5DiGh16Y6J5Z0Swg+TDFP8kKWdAG2DGCc9Jm6fmjTw4XNyJIDy0qKhV/wtCVJye38AEoz
 eoLebQn2kM2wLs0=
X-Google-Smtp-Source: AGHT+IEz8rYyX+Y7KgNJQ1gHdZCpnBkHWvs3G4cPLwh4jqWmpOwu8I7YuNdXCkV2lKD6IStXCEe2qw==
X-Received: by 2002:a17:90b:350a:b0:2ef:e063:b3f8 with SMTP id
 98e67ed59e1d1-2f728dc0772mr17944409a91.7.1737138331402; 
 Fri, 17 Jan 2025 10:25:31 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/68] tcg: Validate op supported in opcode_args_ct
Date: Fri, 17 Jan 2025 10:24:27 -0800
Message-ID: <20250117182456.2077110-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

We should have checked that the op is supported before
emitting it.  The backend cannot be expected to have a
constraint set for unsupported ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 32975fe298..b9119a1ec7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3367,6 +3367,10 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGConstraintSetIndex con_set;
 
+#ifdef CONFIG_DEBUG_TCG
+    assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
+#endif
+
     if (def->nb_iargs + def->nb_oargs == 0) {
         return NULL;
     }
-- 
2.43.0


