Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4D4C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYQv-00057z-93; Fri, 09 Feb 2024 16:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYQu-00055J-0W; Fri, 09 Feb 2024 16:29:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYQs-0000vK-FK; Fri, 09 Feb 2024 16:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tc41nzlhPfcnvcnQlQu2yUetEJaW8wNBxXxeuL7JRBE=; b=Sp7Aw5T5ISMD9uMGUTSRaQ3/mn
 uv/gQYgpOHcfAi92AbWwdl6B4HPAkfxYHZqSo3b4JfLrfHBxOyNfFirYovfOiu/t4o16pSOGNVc9M
 mlF6dn7ms5VOHvTBymB6Cbo0Ip4+fhGl13j6d50pXj3+MjxIX24b0OIAaF0MrzvN19fCXS1uN0tn4
 igFLmqH43aHi9IlxLF3oQmCmhPtbuPu7lYqFQvxvrd9kg/kyyBTkqinvYxdsgFGA/Py4niuv7GT2d
 JJdMScj170wDzco+GuuN6kq40av1RtMhWddrgRcB1Tf/zCVwLwj4dhFH3qqzshi67A46auxgCG5Hf
 1kNL8Z4zIsf70UeGuCEE7AgmP4rAOD5/IyAW8nURcG96PinjPgUY3dvGCBQ7Li1CHIYMnDYBN9QxU
 EFERtfjQ+ybGoVsTYFBlt4Gwce7S302GKvNObffxKKzdz5G5lOlH3obrBpXVpXtTMvmd+gnqO38Lt
 GwnZRWcMifJtkOCkZnz2HC94tRvnNSRP/VcwsBvTKvO/EZxGtdYmr5V0quffB9qFW5Khg4//4uuky
 aRDygZApfdpFc/727wRUN83jo01ECmONQma6fI7oyFP4P0Ic+UJBUOM+NKGFWXOpNxdxLKY4qQlh6
 8AXAfN1YGBF1W69XwdoblKe0QRLFAvKo4FE6/c3gI=;
Received: from [2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYQ7-0002PI-Hx; Fri, 09 Feb 2024 21:28:31 +0000
Message-ID: <942e7659-af0a-4805-822b-43b182868c3d@ilande.co.uk>
Date: Fri, 9 Feb 2024 21:29:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-6-philmd@linaro.org>
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
In-Reply-To: <20240208181245.96617-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 05/11] hw/ppc/prep: Realize ISA bridge before accessing
 it
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 08/02/2024 18:12, Philippe Mathieu-Daudé wrote:

> We should not wire IRQs on unrealized device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/prep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 1a6cd05c61..4eb5477069 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -278,9 +278,9 @@ static void ibm_40p_init(MachineState *machine)
>   
>       /* PCI -> ISA bridge */
>       i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
> +    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
>       qdev_connect_gpio_out(i82378_dev, 0,
>                             qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
> -    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
>   
>       sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
>       isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


