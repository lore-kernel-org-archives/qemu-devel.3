Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CBDCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4rE-0001lg-0J; Fri, 12 Sep 2025 10:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1ux4rC-0001lH-0B
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:34:34 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1ux4r9-0004zY-Lv
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=UC/sPgzgMcFDF96IBWuOtInXhnFruOQhXs3xgyo1TUA=; b=QvGjYxA3YQdQ9N5
 fcgIyDBRNNcAPkvQvLmOcwF5v4cYm1LcSxsiStvfC2tPuY7pjnQy1KbJJ7rdakVPJ+0+31y76G8+i
 50Yzcn1rLPFCzSribjcwa+Ba4nSLqCF+EefnofW8ZVtgd9GZB5UkCgmM1ApSiKHp6PCeFyD8cQz2R
 ak=;
Date: Fri, 12 Sep 2025 16:37:01 +0200
To: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH] target/mips: Fix msaregnames off-by-one
Message-ID: <mejygpnvahkqhmbnhsgxdrogx7m27qnrkdo3ajbjlxvhuqickt@xewbbdagze3s>
References: <20250912141325.17788-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912141325.17788-1-anjo@rev.ng>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/09/25, Anton Johansson via wrote:
> The names of w10.d0 and following registers are 7 bytes in length
> including null-terminator, not 6 bytes.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/mips/tcg/msa_translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index 82b149922f..0e947125a0 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -32,7 +32,7 @@ static inline int plus_2(DisasContext *s, int x)
>  /* Include the auto-generated decoder.  */
>  #include "decode-msa.c.inc"
>  
> -static const char msaregnames[][6] = {
> +static const char msaregnames[][7] = {
>      "w0.d0",  "w0.d1",  "w1.d0",  "w1.d1",
>      "w2.d0",  "w2.d1",  "w3.d0",  "w3.d1",
>      "w4.d0",  "w4.d1",  "w5.d0",  "w5.d1",
> -- 
> 2.51.0
> 
> 

Ignore this one, I missed muxregnames! You could say I was off-by-one.
Sent a new patch fixing msaregnames and mxuregnames..

-- 
Anton Johansson
rev.ng Labs Srl.

