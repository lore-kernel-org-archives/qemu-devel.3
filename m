Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BA4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvFN-00065j-5q; Thu, 11 Apr 2024 10:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ruvFL-00065H-6k
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:17:47 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ruvFJ-0007QU-4Z
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712845065; x=1744381065;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=D2/xZ/+UAN3hoV64W3sdxFk8s157sjQ6wR8/ys8mY5A=;
 b=CPcMBwifm5yule7pjfhZwHLGjCjnKQldedV8GDjSJaSydBdHj1zdxDba
 Ee+r0no3IbNOOhyAvnYyrqcOQsCZilTxo8kOWv4xI9t+y2a1qEzXtPzLW
 HX5/tJjWCcaEAd/rHqz6NUYDHepOksMWhJZDVV0fczcQlcfupWATRMm0R
 UY9cReM3U3HmPlIupucjzDHjU4dhd5mbKKSwIJtNXC+HK69+h7E/2T35v
 PmEVizfyzjhdGwHcsLd2+H8+Gd9u2xa6zu6PJg4g9hapopeihCqxvfBC5
 brWHuCKE2sg+s6JnGNS/Ivsm1YSC8ZSbaEisRrm9Omon35Sk4QGGsFKPI g==;
X-CSE-ConnectionGUID: rR5AEAyfRWuFwgqu7KwHCg==
X-CSE-MsgGUID: 7aKbuN4RQhiX3aafko5DNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8816410"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8816410"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2024 07:17:40 -0700
X-CSE-ConnectionGUID: +tqthBRhRIKs3rjh53749A==
X-CSE-MsgGUID: VZAMf4BxS12yNBuc/k4oIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; d="scan'208";a="20964246"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 11 Apr 2024 07:17:40 -0700
Date: Thu, 11 Apr 2024 22:31:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
Message-ID: <Zhf0Te5frGkdGnF9@intel.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409164323.776660-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Paolo,

I just did some tests,

> +    [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
> +    [0x99] = X86_OP_ENTRY3(CWD,    2,v, 0,v, None, None), /* rDX, rAX */
> +    [0x9A] = X86_OP_ENTRYrr(CALLF, I_unsigned,p, I_unsigned,w, chk(i64)),

X86_TYPE_I_unsigned is defined in patch 11, so the related changes
should be move into this patch to avoid compiling failures:

--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1642,6 +1642,11 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         decode->immediate = op->imm = insn_get_signed(env, s, op->ot);
         break;

+    case X86_TYPE_I_unsigned:  /* Immediate */
+        op->unit = X86_OP_IMM;
+        decode->immediate = op->imm = insn_get(env, s, op->ot);
+        break;
+
     case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
         op->n = insn_get(env, s, op->ot) >> 4;
         break;
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index ca99a620ce94..790ad5e1d006 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -48,6 +48,7 @@ typedef enum X86OpType {

     /* Custom */
     X86_TYPE_WM, /* modrm byte selects an XMM/YMM memory operand */
+    X86_TYPE_I_unsigned, /* Immediate, zero-extended */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
     X86_TYPE_0, /* Hard-coded GPRs (RAX..RDI) */

-Zhao

