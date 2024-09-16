Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AC8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqIvc-0007np-Re; Mon, 16 Sep 2024 17:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqIvY-0007lE-4Z; Mon, 16 Sep 2024 17:06:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqIvW-0002zQ-Nc; Mon, 16 Sep 2024 17:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jVH8tgGMs1HthQyRShB0Cy+S74YJDnqu1hI9kEmVD74=; b=YRa6u0uN+2+r60XAUik2IO0EDk
 Q/RjHq4Olk/SGL6Vw08O+IWF1W8vlhuSKSyqQK1xIDWxJ8Y5Qps5M1+TKgm7Wwl87f+gQ30WNZxSF
 dXDNfhMlqcS6LKQmaumlbCmF8tfznAtSruIna4J2NooUmIgqg/xpV1e2y8Q8YN/H3xO4qPdvbJAO4
 oje+cZVmdtUwxWiwiNAARTVeJ7o8I9tT8kGBnC3ic3sf1X7Yw4V9sUVwCIhrIQ25FB5ZTwSCIHDDP
 nWcr1Ab/jQboqNy9CzcvMgi2LLplGigI72c0fg0jw4TLjIz7rPZC8RacmmT4dJJW3iv0M4UrXwpTx
 Ra2I1pCzPfKHzOxBcjAWJgB9vmDyxKLCZEeS+sbPbUVxbQjHnV/vaJIOrzwxBl1ka5cDY5v6XLBd5
 7lNk5IAzMGVnVW5cEB70GUJPHQw/3hpTPgNQvUiwn3KFsq/O2Hc7N8X0PQsMmUJvRacu0UDVP27dy
 DzPxbTn+ZCVkj/Jrvtm2nhHmBOzvEeH9Ep9t3E4o3pkGMaVngp0+Zp3qEFu5i+OiAUcaGB97vpoG6
 1ka5aRbXFttAjeoHpG/PBqKT4aBTDFWScTsoJ4FF6dJg78kKL8PDcawTXKxCLVkAUc/YDNi8FdtWC
 x5J5nwhwJQKousgY2p3gdXghWckMNH0eWwG55luMU=;
Received: from [2a00:23c4:8bb8:3e00:4b5a:5123:f084:c1f2]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sqIvF-000BPa-Im; Mon, 16 Sep 2024 22:06:17 +0100
Message-ID: <c7ded7f1-3985-4694-b033-6070911f49dc@ilande.co.uk>
Date: Mon, 16 Sep 2024 22:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20240916175708.1829059-1-mnissler@rivosinc.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240916175708.1829059-1-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:3e00:4b5a:5123:f084:c1f2
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] mac_dbdma: Remove leftover `dma_memory_unmap` calls
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16/09/2024 18:57, Mattias Nissler wrote:

> These were passing a NULL buffer pointer unconditionally, which happens
> to behave in a mostly benign way (except for the chance of an excess
> memory region unref and a bounce buffer leak). Per the function comment,
> this was never meant to be accepted though, and triggers an assertion
> with the "softmmu: Support concurrent bounce buffers" change.
> 
> Given that the code in question never sets up any mappings, just remove
> the unnecessary dma_memory_unmap calls along with the DBDMA_io struct
> fields that are now entirely unused.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>   hw/ide/macio.c             | 6 ------
>   include/hw/ppc/mac_dbdma.h | 4 ----
>   2 files changed, 10 deletions(-)
> 
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index bec2e866d7..99477a3d13 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void *opaque, int ret)
>       return;
>   
>   done:
> -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> -                     io->dir, io->dma_len);
> -
>       if (ret < 0) {
>           block_acct_failed(blk_get_stats(s->blk), &s->acct);
>       } else {
> @@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
>       return;
>   
>   done:
> -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> -                     io->dir, io->dma_len);
> -
>       if (s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) {
>           if (ret < 0) {
>               block_acct_failed(blk_get_stats(s->blk), &s->acct);
> diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
> index 4a3f644516..c774f6bf84 100644
> --- a/include/hw/ppc/mac_dbdma.h
> +++ b/include/hw/ppc/mac_dbdma.h
> @@ -44,10 +44,6 @@ struct DBDMA_io {
>       DBDMA_end dma_end;
>       /* DMA is in progress, don't start another one */
>       bool processing;
> -    /* DMA request */
> -    void *dma_mem;
> -    dma_addr_t dma_len;
> -    DMADirection dir;
>   };
>   
>   /*

Thanks for looking at this, Matthias. I've given it a quick spin around various PPC 
Mac images and it looks good to me, so:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

My guess is that the current use of dma_memory_unmap() was a misunderstanding/bug 
when porting the macio IDE device over to use the byte-aligned block DMA helpers, so 
I think you can also add:

Fixes: be1e343995 ("macio: switch over to new byte-aligned DMA helpers")


ATB,

Mark.


