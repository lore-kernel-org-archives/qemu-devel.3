Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6CCC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra9no-0004nE-OR; Wed, 14 Feb 2024 02:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=AQUf=JX=kaod.org=clg@ozlabs.org>)
 id 1ra9nk-0004kX-Md; Wed, 14 Feb 2024 02:35:28 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=AQUf=JX=kaod.org=clg@ozlabs.org>)
 id 1ra9ni-0005vi-Hn; Wed, 14 Feb 2024 02:35:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TZVN810Kxz4wcs;
 Wed, 14 Feb 2024 18:35:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZVN33Vgsz4wcQ;
 Wed, 14 Feb 2024 18:35:15 +1100 (AEDT)
Message-ID: <677bba7b-f206-4c9a-8384-d48a6e9f2c85@kaod.org>
Date: Wed, 14 Feb 2024 08:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxv/stxv MSR facility check
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Lucas Mateus Castro <lucas.castro@eldorado.org.br>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240213083933.718881-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240213083933.718881-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=AQUf=JX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/13/24 09:39, Nicholas Piggin wrote:
> The move to decodetree flipped the inequality test for the VEC / VSX
> MSR facility check.
> 
> This caused application crashes under Linux, where these facility
> unavailable interrupts are used for lazy-switching of VEC/VSX register
> sets. Getting the incorrect interrupt would result in wrong registers
> being loaded, potentially overwriting live values and/or exposing
> stale ones.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Joel Stanley <joel@jms.id.au>
> Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1769
> Tested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>

with a RHEL9 image.

Thanks,

C.


> ---
>   target/ppc/translate/vsx-impl.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
> index 6db87ab336..0266f09119 100644
> --- a/target/ppc/translate/vsx-impl.c.inc
> +++ b/target/ppc/translate/vsx-impl.c.inc
> @@ -2268,7 +2268,7 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
>   
>   static bool do_lstxv_D(DisasContext *ctx, arg_D *a, bool store, bool paired)
>   {
> -    if (paired || a->rt >= 32) {
> +    if (paired || a->rt < 32) {
>           REQUIRE_VSX(ctx);
>       } else {
>           REQUIRE_VECTOR(ctx);


