Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D910CFD65A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVvL-0003D9-D7; Wed, 07 Jan 2026 10:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdVvD-00038t-C7; Wed, 07 Jan 2026 10:58:08 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdVv4-0001AJ-HK; Wed, 07 Jan 2026 10:58:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 84AA1596A10;
 Wed, 07 Jan 2026 16:57:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id tLo9gPXVVEnb; Wed,  7 Jan 2026 16:57:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7D2D3596A0A; Wed, 07 Jan 2026 16:57:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B89F5969F6;
 Wed, 07 Jan 2026 16:57:50 +0100 (CET)
Date: Wed, 7 Jan 2026 16:57:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 4/5] target/i386/tcg: allow VEX in 16-bit protected
 mode
In-Reply-To: <20260107151400.273916-5-pbonzini@redhat.com>
Message-ID: <d3747279-4dcc-b58f-18f0-c8a87c4abcf0@eik.bme.hu>
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 7 Jan 2026, Paolo Bonzini wrote:
> VEX is only forbidden in real and vm86 mode; 16-bit protected mode supports
> it for some unfathomable reason.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> target/i386/tcg/decode-new.c.inc | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index f662364c600..243df7e3735 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2875,7 +2875,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>          * VEX prefixes cannot be used except in 32-bit mode.

Does this comment need updating too?

Regards,
BALATON Zoltan

>          * Otherwise the instruction is LES or LDS.
>          */
> -        if (CODE32(s) && !VM86(s)) {
> +        if (PE(s) && !VM86(s)) {
>             static const int pp_prefix[4] = {
>                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
>             };
>

