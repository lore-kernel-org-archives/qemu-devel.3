Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80493CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZphp-0000GI-EZ; Wed, 17 Jun 2026 08:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wZphn-0000FV-07; Wed, 17 Jun 2026 08:49:19 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wZphl-00027d-4r; Wed, 17 Jun 2026 08:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Ng5HDAOwBotpdtYsAA2XeL2eUk7lPd7GHr4iEYldGW8=; b=lcDjysU2vfOCJ7N
 3WMVapqjfKyiKbQqit5dTUUXAUC9ZwFuUElgNGWOhKdWrWvMrqIbPHC+yZEnDANycHtcpdh7QGNak
 CiEB03Nvv8KJlf6sm0sYT/7po5S/lMod/UUP7oKeL2jpSGj2R2KM1S8B/CdTMkxMRZufM3TzPbC1q
 G4=;
Date: Wed, 17 Jun 2026 14:54:59 +0200
To: Joel Stanley <joel@jms.id.au>
Cc: alistair.francis@wdc.com, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] target/riscv: Avoid NULL deref in IMSIC CSR write
Message-ID: <ajKZBy10qZvsZWDP@hive.localdomain>
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617054034.1020724-2-joel@jms.id.au>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/06/26, Joel Stanley wrote:
> rmw_xireg_aia() and rmw_xtopei() were changed to store the IMSIC
> callback's value in a local before passing it back to the caller.
> For write only CSR accesses that pointer is NULL, causing a crash when
> guest programs write to xireg or xtopei, such as when the guest sets up
> the IMSIC.
> 
> This only happens when setting aia=aplic-imsic so none of the existing
> boot tests caught it.
> 
> Fix it by guarding the pointer dereference as done for other CSRs.
> 
> Fixes: 63469ad75dcc ("target/riscv: Fix arguments to board IMSIC emulation callbacks")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  target/riscv/csr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ec931a8c3ddf..4502f2ab4788 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2732,7 +2732,9 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
>                                      AIA_MAKE_IREG(isel, priv, virt, vgein,
>                                                    riscv_cpu_mxl_bits(env)),
>                                      &wide_val, new_val, wr_mask);
> -            *val = wide_val;
> +            if (val) {
> +                *val = wide_val;
> +            }

Reviewed-by: Anton Johansson <anjo@rev.ng>

