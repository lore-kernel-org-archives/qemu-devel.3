Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB66C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5rV-000396-Vq; Fri, 28 Jun 2024 03:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5rI-0002rb-BA; Fri, 28 Jun 2024 03:17:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5rF-00087M-OM; Fri, 28 Jun 2024 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cF+qyKhKg5T5d1hfo16Tc9vECZbCvl+/c0GWoQ5g1Ug=; b=UnhUz+tsbffXpIMCYTeCkgOEcD
 6rFY9i7bh2Lj5WCUO8X0YAIoGix1Zok+szsH4+oy94rD4zcGvbDfWqXFwh6Omm2VH75R3A5zw9kGj
 nkEhsrZGtLjf2xSdD/rW506nCm04u/cTovXwCZpG2kYbsJ6wn2e0wDNyMXhXNJlb77FoZIOWsruq5
 y4KNv9UgohfFlw0cqpyetzxktirEIp5uLo227x/s46KnvhGU7gADhXuAyLLAkMUEUD+nvEF8jOa90
 4ETS5yb6wFSigzuGygdVLJH4n4x/pWWyvvjPZV9oCmc5f2DRax3G0BoDbC65QyovVMMLIQAYzuJIi
 yVwzqufqeFN/voOi0X7vPxEWwXPSIky586fnNghdfhfqxme4aLAVbKQDBn/7maDdu6uoC1yAxdgVR
 8nb5V5Q8eivTvo0o0MyJvY9oVam9GCG9Bpa6cI28My2DTOGx4GrbO2uGJhVU7kftHbiR4rjoy8LEB
 uxOOkRwRCdGQ8KHT7CC87R1Zkt7R8Ed+wwtCB+GYPXylfk7YK6Abn88EL6Qz0nKRdAQPp5S+5kxqQ
 LWH4A1mfbqmMn9ediT7wLVUuZw2rrosmd0nr2nowL748mQlg/Cd2N5C8WkrgK+NEIUpUHZQ1pMNi7
 CQwQwyYmRJZPZ0M3CIR2quU+jJsH8oC9pa2EcOETU=;
Received: from [2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN5pJ-0008JS-EJ; Fri, 28 Jun 2024 08:15:25 +0100
Message-ID: <55e1f4c7-f140-42b4-80bb-21a7674625e9@ilande.co.uk>
Date: Fri, 28 Jun 2024 08:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-2-f3cc42302189@daynix.com>
 <CAFEAcA-DNieFTV7VbM1MBTbEr9zd5kJ4oaWcsUrsPxCzQki+_g@mail.gmail.com>
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
In-Reply-To: <CAFEAcA-DNieFTV7VbM1MBTbEr9zd5kJ4oaWcsUrsPxCzQki+_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 02/14] hw/ide: Free macio-ide IRQs
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

On 26/06/2024 13:59, Peter Maydell wrote:

> On Wed, 26 Jun 2024 at 12:09, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> This suppresses LeakSanitizer warnings.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/ide/macio.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
>> index aca90d04f0e8..d8fbc1a17ba6 100644
>> --- a/hw/ide/macio.c
>> +++ b/hw/ide/macio.c
>> @@ -464,6 +464,14 @@ static void macio_ide_initfn(Object *obj)
>>                                qdev_prop_allow_set_link_before_realize, 0);
>>   }
>>
>> +static void macio_ide_finalize(Object *obj)
>> +{
>> +    MACIOIDEState *s = MACIO_IDE(obj);
>> +
>> +    qemu_free_irq(s->dma_irq);
>> +    qemu_free_irq(s->ide_irq);
>> +}
>> +
>>   static Property macio_ide_properties[] = {
>>       DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
>>       DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
>> @@ -486,6 +494,7 @@ static const TypeInfo macio_ide_type_info = {
>>       .parent = TYPE_SYS_BUS_DEVICE,
>>       .instance_size = sizeof(MACIOIDEState),
>>       .instance_init = macio_ide_initfn,
>> +    .instance_finalize = macio_ide_finalize,
>>       .class_init = macio_ide_class_init,
>>   };
> 
> Rather than this, I suspect macio_ide_initfn() should not
> be using qemu_allocate_irq() in the first place. Looks like
> maybe a QOM conversion that left a loose end un-tidied-up.

This is definitely old code: there used to be problems interfacing the IDE code with 
qdev due to the hard-coded bus IRQs but I think this may is now possible with the 
advent of ide_bus_init_output_irq().

I'll have a quick look and see what has changed in this area.


ATB,

Mark.


