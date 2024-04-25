Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9776C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00p8-0006w6-QT; Thu, 25 Apr 2024 11:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s00od-0006gS-KT
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:15:24 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s00oU-0002Dd-Ja
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714058106; x=1745594106;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=u7WG00B7+uNOK3xQT0kyO08wZ8tgfhwulD0Raj+SN5U=;
 b=Gs8+Lg0XEo/cMOKBRVCtcfDqN1HQKIZrwx5lkX+GdWu6gNy0umrea7cY
 voUE9HxazcRNGhskP01wrfPilBlnHY47vLzArgfZZK8mWBvmhVBaw/GSM
 Ms0OTI1SzuMIpFca5w4pbUQj4H8TRSQODKeeGyy30BBWzqJPyECIu8mzO
 vhBl7h6oIYWKva4FpZanCuqhWMCu0d8Ig7ZL3o0CP3j2jKtoWIme8EqlQ
 x2HcAwIlNpCN2pnUT9r61dxDyleq7CHwNrB47/M/vN/mwoP51xE7Xc4Wu
 miBJvF1Scje35Eu5lZntDdIvJVADL/isy3rAzjIMYcjk35a8yHHEQ2IyT w==;
X-CSE-ConnectionGUID: ly+NY3TVR6CyaATcEPD94A==
X-CSE-MsgGUID: yw0EU1YoTwmeCAhmYMuO2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13588209"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="13588209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 08:15:02 -0700
X-CSE-ConnectionGUID: ftF/dONzTPa36XXj2DMJDg==
X-CSE-MsgGUID: CdqXhzrHRJuzWz3XB778tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; d="scan'208";a="48365264"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 25 Apr 2024 08:15:01 -0700
Date: Thu, 25 Apr 2024 23:29:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
Message-ID: <Zip2xJorL/cPxm5B@intel.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
 <Zhf/czBP8LaaGORr@intel.com>
 <CABgObfYMu8sAzqJvMSQiDiY6M+uxBYc-fQadpvtoT=J=waWv4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYMu8sAzqJvMSQiDiY6M+uxBYc-fQadpvtoT=J=waWv4w@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Apr 24, 2024 at 01:13:01PM +0200, Paolo Bonzini wrote:
> Date: Wed, 24 Apr 2024 13:13:01 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
>  decoder
> 
> On Thu, Apr 11, 2024 at 5:05 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > HMM, I met Guest boot failure on this patch because of ata unrecognized.
> > I haven't located the exact error yet, so let me post my log first.
> > If there are other means I can use to dig further, I'd be happy to try
> > that too.
> >
> > # Command (boot a ubuntu Guest via TCG)
> >
> > ./qemu/build/qemu-system-x86_64 \
> > -smp 1 \
> > -name ubuntu -m 4G \
> > -cpu max -accel tcg \
> > -hda ../img_qemu/test.qcow2 -nographic \
> > -kernel ../img_qemu/kernel/vmlinuz-6.4.0-rc6+ \
> > -initrd ../img_qemu/kernel/initrd.img-6.4.0-rc6+ \
> > -append "root=/dev/sda ro console=ttyS0" \
> > -qmp unix:/tmp/qmp-sock,server=on,wait=off
> 
> The issue is that INS and OUTS are using the incorrect operand size.
> 
> While at it I also made OUTS a bit more similar to OUT:
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 0951b042dfa..46682cfe070 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1544,8 +1544,8 @@ static const X86OpEntry opcodes_root[256] = {
>      [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b, sextT0),
>      [0x6C] = X86_OP_ENTRYrr(INS, Y,b, 2,w), /* DX */
>      [0x6D] = X86_OP_ENTRYrr(INS, Y,z, 2,w), /* DX */
> -    [0x6E] = X86_OP_ENTRYrr(OUTS, 2,w, X,b), /* DX */
> -    [0x6F] = X86_OP_ENTRYrr(OUTS, 2,w, X,b), /* DX */
> +    [0x6E] = X86_OP_ENTRYrr(OUTS, X,b, 2,w), /* DX */
> +    [0x6F] = X86_OP_ENTRYrr(OUTS, X,z, 2,w), /* DX */
> 
>      [0x78] = X86_OP_ENTRYr(Jcc, J,b),
>      [0x79] = X86_OP_ENTRYr(Jcc, J,b),
> @@ -1592,7 +1592,7 @@ static void gen_INC(
> 
>  static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>  {
> -    MemOp ot = decode->op[0].ot;
> +    MemOp ot = decode->op[1].ot;
>      TCGv_i32 port = tcg_temp_new_i32();
> 
>      tcg_gen_trunc_tl_i32(port, s->T1);
> @@ -2310,10 +2310,10 @@ static void gen_OUT(
> 
>  static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
>  {
> -    MemOp ot = decode->op[2].ot;
> +    MemOp ot = decode->op[1].ot;
>      TCGv_i32 port = tcg_temp_new_i32();
> 
> -    tcg_gen_trunc_tl_i32(port, s->T0);
> +    tcg_gen_trunc_tl_i32(port, s->T1);
>      tcg_gen_ext16u_i32(port, port);
>      if (!gen_check_io(s, ot, port, SVM_IOIO_STR_MASK)) {
>          return;
> 
> 
> (sorry about any word breaking)

Thanks! With the above fix, now I re-test on each patch, and all patches
could boot Guest properly! If there is a v2, I can continue to test it.

Regards,
Zhao


