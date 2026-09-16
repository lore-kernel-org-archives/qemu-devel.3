Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C98BC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQw-0008KP-RW; Wed, 16 Sep 2026 09:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQo-0007Ot-SE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:11 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQl-00020x-Em
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:10 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a29bf27so404051b6e.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564326; x=1790169126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a/IPU6OG8DNnwykMcPfCw/JVnRhv9fHLr5HOcMID90c=;
 b=ou1DNVksxVax6KLw+v58kWIc0FOdla8dUB17H7X41vKwmJw+TUvkDJzN+16PkVJPS2
 s24L5ojT5DwLiiZt0Ml0id0MXLD5IvCvK5fhpfGHkKYMSBlhwSnKuGfDbIvdVlVS5wO/
 vpRIqJQ3TjNmh+rquD1IU3L/2kOs+ZJPc+vw06qPYNT7260wC8OZdQsxTAjWL1JeQWR0
 bgB/Mq2rKuhqwmxt0y9rbL7p2JiQvxOWEXMKp4B4g2RWMXq2ywUZkrPR5wVBvFImMcba
 IIJfD+1C0Pj0YeOrhZ8Wg9bsR2ABj146Ui3mwOtOpmGWEAfyv/fckYNSJk5tdsxLA8Bo
 T3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564326; x=1790169126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a/IPU6OG8DNnwykMcPfCw/JVnRhv9fHLr5HOcMID90c=;
 b=Se+kj7d/62+rOfgdclTGfgnxldp4H5gcbSuQQoL6p2txtxleRiCM13JlGTpNlPPjGM
 3nNV08fOO0qY7DEtF2SEMm9N3SfxRcAaNxUqIfXnQxSSWFiLNsCE7YbTfN6ytC+t51GM
 UGAszWAHA9gDjCS7WZQpnWoO8hEQX7ZortCunsdLryI6Ol/gU2BMa54FZf0wsBFIdhY2
 VW3BLR+p0s6lt6ESkFYsLf4kRVR0ZI5KysS7EOxr9wwHfYjcK0psG7c4b3enW8mAQXkG
 8IPHCYpTmYLmwLWPnyyzL3NQawnNg6iNLJhTRafQ6Zb8Pg0wE8kLBJnzrSFPzWjj5LTX
 2CVg==
X-Gm-Message-State: AFuF++mvUSva0iZ8ufiKKWu2K1MoUR17snJN+umyqxIhc6jx8llZ7sAe
 8qR4WredXgyflLEufqcOuL909aAiv65lfNK31Q4a5gNFaiPXkC28wHJAGqWoBQxCWAEa/M5tZbK
 /DORU3lA=
X-Gm-Gg: AYBFou0xc6K3JAZQkWMv1jtXTzdqhrIpV1dzIeO31vMOLzvFLE42rm7UowT8ASz2i56
 5EeG81dPW6FCT4JL83ucZkaBkGDnJMomzw5KBehE4x4BFvzu7sRUOPir5RYVtTKMIDrZQGbt9z7
 65wIdMGkasTrsHMdDJ7ootglP0wMSSF4mAIi/MLZmiVGbioCan1/+gFeODUwIAz1M+igScGC/20
 9BQiqxyw/mQ3cMCN4zbCRdN4DvvlafFR5eFLf9hJoFyzXA1CZZwlg87/9O9zkcL0q059196Trg0
 8V3cnzIQFf84+2qewQVvW3vve9ELtmobRbSD40aEw/ZEa72yn3k4/Vd25/wI5UMMCE1rKBSQ7y5
 BAHpeVPJ5VRVZKKdecK7OKPyUYY4lnuiyjXMeCwH0NOkMcHVnkWrSC3ZW7cCRejBKiw18R7NLOO
 a6+CE/H5tBmCHnxJOn68EP/dVz/+r/2+R8meIxK4b6Sz7hDkbGkIUlCdB6zAqipJsSQZVwaPHbL
 wGC5As=
X-Received: by 2002:a05:6808:bc3:b0:495:feaa:9e3b with SMTP id
 5614622812f47-4ca49dd32e3mr3027543b6e.7.1789564325871; 
 Wed, 16 Sep 2026 06:12:05 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 90/92] tcg: Annontate functions in tcg-op-common.h with
 QEMU_*_NONNULL
Date: Wed, 16 Sep 2026 03:04:05 -1000
Message-ID: <20260916130409.3382710-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 278 +++++++++++++++++++++---------------
 1 file changed, 162 insertions(+), 116 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c3d080222d9..77955c3af41 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -12,24 +12,24 @@
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
-TCGv_i32 tcg_constant_i32(int32_t val);
-TCGv_i64 tcg_constant_i64(int64_t val);
-TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
-TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
-TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
+QEMU_RET_NONNULL TCGv_i32 tcg_constant_i32(int32_t val);
+QEMU_RET_NONNULL TCGv_i64 tcg_constant_i64(int64_t val);
+QEMU_RET_NONNULL TCGv_vaddr tcg_constant_vaddr(uintptr_t val);
+QEMU_RET_NONNULL TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
+QEMU_RET_NONNULL TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
-TCGv_i128 tcg_zero_i128(void);
+QEMU_RET_NONNULL TCGv_i128 tcg_zero_i128(void);
 
-TCGv_i32 tcg_temp_new_i32(void);
-TCGv_i64 tcg_temp_new_i64(void);
-TCGv_ptr tcg_temp_new_ptr(void);
-TCGv_i128 tcg_temp_new_i128(void);
-TCGv_vec tcg_temp_new_vec(TCGType type);
-TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
+QEMU_RET_NONNULL TCGv_i32 tcg_temp_new_i32(void);
+QEMU_RET_NONNULL TCGv_i64 tcg_temp_new_i64(void);
+QEMU_RET_NONNULL TCGv_ptr tcg_temp_new_ptr(void);
+QEMU_RET_NONNULL TCGv_i128 tcg_temp_new_i128(void);
+QEMU_RET_NONNULL TCGv_vec tcg_temp_new_vec(TCGType type);
+QEMU_RET_NONNULL TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
 
-TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
-TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
-TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
+QEMU_RET_NONNULL TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
 
 /* Generic ops.  */
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
@@ -41,8 +41,8 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
     tcg_set_insn_start_param(op, 2, a2);
 }
 
-void gen_set_label(TCGLabel *l);
-void tcg_gen_br(TCGLabel *l);
+QEMU_ARG_NONNULL void gen_set_label(TCGLabel *l);
+QEMU_ARG_NONNULL void tcg_gen_br(TCGLabel *l);
 void tcg_gen_mb(TCGBar);
 
 /**
@@ -86,7 +86,7 @@ void tcg_gen_goto_tb(unsigned idx);
 void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
-void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
+QEMU_ARG_NONNULL void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /*
  * Construct operations from templates.
@@ -132,234 +132,280 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
+QEMU_ARG_NONNULL void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
+QEMU_ARG_NONNULL void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
-void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
-void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
+QEMU_ARG_NONNULL void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
+QEMU_ARG_NONNULL void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+QEMU_ARG_NONNULL void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+QEMU_ARG_NONNULL void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
+QEMU_ARG_NONNULL void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
-void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
-void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
-void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high);
-void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
-void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
-void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg);
-void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg);
-void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi);
+QEMU_ARG_NONNULL void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg);
+QEMU_ARG_NONNULL void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high);
+QEMU_ARG_NONNULL void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg);
+QEMU_ARG_NONNULL void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi);
 
-void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
-void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
+QEMU_ARG_NONNULL void tcg_gen_extr_i128_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i128 arg);
+QEMU_ARG_NONNULL void tcg_gen_concat_i64_i128(TCGv_i128 ret, TCGv_i64 lo, TCGv_i64 hi);
 
 /* 128 bit ops */
 
-void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
-void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
-void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
+QEMU_ARG_NONNULL void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
+QEMU_ARG_NONNULL void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
 /* Local load/store bit ops */
 
-void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
 /* Atomic ops */
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_i32,
                                     TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_i64,
                                     TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
                                      TCGv_i128, TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
                                         TCGv_i128, TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                  TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                  TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
                                   TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_add_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_add_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_and_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_and_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_or_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                      TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_or_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                      TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_xor_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_xor_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_smin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_smin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_umin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_umin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_smax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_smax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_umax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_umax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_add_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_add_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_and_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_and_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_or_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                      TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_or_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                      TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xor_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_xor_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                       TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_smin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_smin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_umin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_umin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_smax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_smax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_umax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_umax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
 
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_and_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
                                        TCGArg, MemOp, TCGType);
+QEMU_ARG_NONNULL
 void tcg_gen_atomic_fetch_or_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
                                       TCGArg, MemOp, TCGType);
 
 /* Vector ops */
 
-void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
-void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
-void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
-void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
-void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
-void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
-void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
-void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
-void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
-void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
+QEMU_ARG_NONNULL void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
+QEMU_ARG_NONNULL void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
+QEMU_ARG_NONNULL void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
+QEMU_ARG_NONNULL void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
+QEMU_ARG_NONNULL void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_or_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_xor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_andc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_orc_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_nand_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+QEMU_ARG_NONNULL void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
+QEMU_ARG_NONNULL void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
-void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
-void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+QEMU_ARG_NONNULL void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
-void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
-void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
-void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
-void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+QEMU_ARG_NONNULL void tcg_gen_rotls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 
-void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
-void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+QEMU_ARG_NONNULL void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 
+QEMU_ARG_NONNULL
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
+QEMU_ARG_NONNULL
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
                         TCGv_vec b, TCGv_vec c);
+QEMU_ARG_NONNULL
 void tcg_gen_cmpsel_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                         TCGv_vec a, TCGv_vec b, TCGv_vec c, TCGv_vec d);
 
-void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
-void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
-void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
+QEMU_ARG_NONNULL void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+QEMU_ARG_NONNULL void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
+QEMU_ARG_NONNULL void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-- 
2.53.0


