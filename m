Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A135EC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr66-0007Xy-3B; Fri, 17 Jan 2025 13:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5k-0005cc-MM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:12 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5i-0000J1-Ra
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:12 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ef87d24c2dso3452806a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138549; x=1737743349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPqE5pOJRUt4lCbKjtOFdsXTgP83uWIvLseojaZHM+8=;
 b=eGlo++CwRfvLBDQtOSXfmuK7ZvMnYd8VqsH/Mhd5M6g9Vb97DP4k5ZJI4+1gY+roLF
 OrBSnOlNTl7GSRmtgJyd/yZ/0TjNPjNm5cMVlcQEQMEMzrORM9g87MPsCnOuwR7y/PDN
 6XT5t10y9NqZuEUwwvDMenxyYT6iEFIJUTzf/3Ut9sEf7qs95JL1v1BinGLkbGBujnwy
 /O2SCleG0GUXqPV/7buaomCoDHSgUKOmw7mKoTfUHpAX766+8zso3x5NdaVQkXPZb0ne
 QAwNwnsthmBbKeRzgWOsTQ8oj3ffOVUevQImSgSC40fytGYVT1mUw+OBoRrnwVRstgyM
 3tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138549; x=1737743349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPqE5pOJRUt4lCbKjtOFdsXTgP83uWIvLseojaZHM+8=;
 b=hHtlpnMNIbwwFD7Cu5pr4vWVviObHweJqVuoDSIB1yqM+57HmPkyf+LQOTvDupUu1y
 /vB3RkHJ0vT9ts+b6PvHOFtIaWVcbjB66RDcmjQxNB4s3yR1sY0myBSCB6anngGZr043
 cJkdcYYfeGZk2AQNi35c+yMXEM5bu8SUkxy4NoVQoJ7F/BpuViA5zrSUie0HnOCu/w4i
 QjcQv12TAt79z46KWNdwyAntTnNM9TePmnDBxuuJ2t2oGhw0EIiIDpr8pqgFKVTIsRUh
 82VfPcoopH/w9yb6wszOjk83J7+XS+Hb9oamy3StJsGFcgFDZnqlQ5MZOlnQoG8UNVA6
 7ZgA==
X-Gm-Message-State: AOJu0YzKsShP43WenkCC2kUuzXbmZRMtIHy3Ujx2PAyGTttFy4YwoLdb
 g+ZMHo4kii55N+65PX5Ufk9LdgYI+swRq/5TJ89nTo0u/HuodrLSKZ9mrERRPi1A88CgB4ELx8d
 q
X-Gm-Gg: ASbGncurlM+ELPp6f62XSyK07ZUYAqmEKtZPL1UOE4eesvDtZ/RsZkiQIeVak5jmaTx
 8xfbagF9WbgORLi2BXGXVonvYrXo3RfXQKEo+UANK1JvYAcU26lX3zdDpUfnmvM8Jdf5Ur51oDF
 Ingtt+XlIp5AVy1YL6W118g10R61PN3g7ubeo63jqJPqzg4qJkmpJgFWS25k29XcJ8rJzkXTfvF
 aevow82RfqnMYQWY2kPu8imP4K95yS7JoQ28scvl9IPNrwMYEoe6E0aLgmjCT8VZAyIYDv3qtrj
 g/G1GxxSIZS+T/s=
X-Google-Smtp-Source: AGHT+IEgPu+ycSU/WRrX+r/skZxbEhoTp2HsPe7MLc2qoBH/AzRVSnFEeDVFwCVrN696+OmNNR4bpw==
X-Received: by 2002:a17:90b:51c2:b0:2ee:8430:b831 with SMTP id
 98e67ed59e1d1-2f782c65787mr5534314a91.2.1737138549388; 
 Fri, 17 Jan 2025 10:29:09 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 60/68] tcg/tci: Remove assertions for deposit and extract
Date: Fri, 17 Jan 2025 10:24:48 -0800
Message-ID: <20250117182456.2077110-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

We already have these assertions during opcode creation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.c.inc | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 88cecbd62f..8dedddce5f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -775,28 +775,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     CASE_32_64(deposit)  /* Optional (TCG_TARGET_HAS_deposit_*). */
-        {
-            TCGArg pos = args[3], len = args[4];
-            TCGArg max = opc == INDEX_op_deposit_i32 ? 32 : 64;
-
-            tcg_debug_assert(pos < max);
-            tcg_debug_assert(pos + len <= max);
-
-            tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], pos, len);
-        }
+        tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
     CASE_32_64(extract)  /* Optional (TCG_TARGET_HAS_extract_*). */
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
-        {
-            TCGArg pos = args[2], len = args[3];
-            TCGArg max = type == TCG_TYPE_I32 ? 32 : 64;
-
-            tcg_debug_assert(pos < max);
-            tcg_debug_assert(pos + len <= max);
-
-            tcg_out_op_rrbb(s, opc, args[0], args[1], pos, len);
-        }
+        tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
     CASE_32_64(brcond)
-- 
2.43.0


