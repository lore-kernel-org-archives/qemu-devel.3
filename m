Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537F5CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbpV-000221-2S; Tue, 19 Mar 2024 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbpL-0001wh-P4
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:56:36 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbpE-0007kF-AV
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FZmi42BD9yc1UXurDJHUacCk9Jpc+RAUJfMa1M6JjTQ=; b=uOf84nUWaepW+s97xGYJ+t8L6/
 CuoI3sxtNcZKiu7lVeZOkp5m6kmZkaGBFnZKCMrK0UDkqWcWmx+IJjuCykcjRfZzRu3pg292maxMc
 y+1sHtm+1tVNwKUSbxj/TN1XkE7PqjqpDRjHBcNYfVeDxwf00i4snawdmF/6spdhGz9k=;
Date: Tue, 19 Mar 2024 16:57:15 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 4/8] target/microblaze: Use 32-bit destination in
 gen_goto_tb()
Message-ID: <yulkwtt4gdyr52siolayxvlu7zyryzwldgteff2uh53qqw3ixz@dod2pgo5s5go>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-5-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 19/03/24, Philippe Mathieu-Daudé wrote:
> cpu_pc and jmp_dest are 32-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 4e52ef32db..d6a42381bb 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -121,7 +121,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
>      gen_raise_exception_sync(dc, EXCP_HW_EXCP);
>  }
>  
> -static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
>  {
>      if (translator_use_goto_tb(&dc->base, dest)) {
>          tcg_gen_goto_tb(n);
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

