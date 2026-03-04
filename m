Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E6EF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmPE-0005kk-TE; Wed, 04 Mar 2026 08:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxmP8-0005kS-2w
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:36:49 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vxmP5-0004kI-Mx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=nMyZE8Di4GzyLyiPGZcDscRYYnfjL+xdgUvo7OQN6t4=; b=Hg5zp0RTByRJ+wk
 Zadrzs6nKr02CjDyxQ1n4RY+CjteCzAXGH139VHyt/fr2Yao2K8Djb+YKH52eX3DnuLmchfLZAzNk
 nbhp0As0FxQcpxnRH+8nNnOn8iBnD2gbR31cWgudnkgxJVml7ak29Cq8ig1yZvpW0X1ISy5Z3eYzr
 h4=;
Date: Wed, 4 Mar 2026 14:40:11 +0100
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: Re: [PATCH v3 05/37] target/hexagon: Handle system/guest registers
 in gen_analyze_funcs.py and hex_common.py
Message-ID: <aagjarOCvf_gSv-8@hive.localdomain>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-6-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227203627.932864-6-brian.cain@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/02/26, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_analyze_funcs.py |  21 +++-
>  target/hexagon/hex_common.py        | 161 ++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
> index fdefd5b4b36..985386c1309 100755
> --- a/target/hexagon/gen_analyze_funcs.py
> +++ b/target/hexagon/gen_analyze_funcs.py
> @@ -22,6 +22,8 @@
>  import string
>  import hex_common
>  
> +def has_analyze_func(reg, mode):
> +    return callable(getattr(reg, f"analyze_{mode}", None))
>  
>  ##
>  ## Generate the code to analyze the instruction
> @@ -42,6 +44,14 @@ def gen_analyze_func(f, tag, regs, imms):
>      f.write(f"static void analyze_{tag}(DisasContext *ctx)\n")
>      f.write("{\n")
>  
> +    if hex_common.tag_ignore(tag):
> +        f.write("}\n\n")
> +        return
> +
> +    if ("A_PRIV" in hex_common.attribdict[tag] or
> +        "A_GUEST" in hex_common.attribdict[tag]):
> +        f.write("#ifndef CONFIG_USER_ONLY\n")

use hex_common.is_sysemu_tag(tag) here instead! 



> +
>      f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
>      if (hex_common.is_hvx_insn(tag)):
>          if hex_common.has_hvx_helper(tag):
> @@ -58,13 +68,14 @@ def gen_analyze_func(f, tag, regs, imms):
>      for regno, register in enumerate(regs):
>          reg_type, reg_id = register
>          reg = hex_common.get_register(tag, reg_type, reg_id)
> -        reg.decl_reg_num(f, regno)
> +        if has_analyze_func(reg, "read") or has_analyze_func(reg, "write"):
> +            reg.decl_reg_num(f, regno)

I'm not a huge fan of redirecting control flow based on whether or not
the register class has certain functions, feels hard to follow.  It's
also unclear to me why this is needed, I assume we have some registers
where reg.is_read()/reg.is_written() are false but we still want to emit
analyze code for them?


>  
>      ## Analyze the register reads
>      for regno, register in enumerate(regs):
>          reg_type, reg_id = register
>          reg = hex_common.get_register(tag, reg_type, reg_id)
> -        if reg.is_read():
> +        if reg.is_read() and has_analyze_func(reg, "read"):
>              reg.analyze_read(f, regno)
>  
>      f.write("    mark_implicit_reads(ctx);\n")
> @@ -73,11 +84,15 @@ def gen_analyze_func(f, tag, regs, imms):
>      for regno, register in enumerate(regs):
>          reg_type, reg_id = register
>          reg = hex_common.get_register(tag, reg_type, reg_id)
> -        if reg.is_written():
> +        if reg.is_written() and has_analyze_func(reg, "write"):
>              reg.analyze_write(f, tag, regno)
>  
>      f.write("    mark_implicit_writes(ctx);\n")
>  
> +    if ("A_PRIV" in hex_common.attribdict[tag] or
> +        "A_GUEST" in hex_common.attribdict[tag]):
> +        f.write("#endif /* !CONFIG_USER_ONLY */\n")

and use hex_common.is_sysemu_tag(tag) here also


> +
>      f.write("}\n\n")
>  
>  
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 63f83a8de2a..b5ab2efa5a5 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -33,6 +33,42 @@
>  overrides = {}  # tags with helper overrides
>  idef_parser_enabled = {}  # tags enabled for idef-parser
>  
> +
> +def is_sysemu_tag(tag):
> +    return "A_PRIV" in attribdict[tag] or "A_GUEST" in attribdict[tag]
> +
> +
> +def tag_ignore(tag):
> +    tag_skips = (
> +        "Y6_diag",
> +        "Y6_diag0",
> +        "Y6_diag1",
> +    )
> +    attr_skips = (
> +        "A_FAKEINSN",
> +        "A_MAPPING",
> +        "A_CONDMAPPING",
> +    )
> +    return tag in tag_skips or \
> +        any(attr in attribdict[tag] for attr in attr_skips)

Up to you if you think this is easier to read or not, but you could make
attr_skips a set and do set intsersection instead 

    attr_skips = {
        "A_FAKEINSN",
        "A_MAPPING",
        "A_CONDMAPPING",
    }
    return tag in tag_skips or attribdict[tag] & attr_skips

-- 
Anton Johansson
rev.ng Labs Srl.

