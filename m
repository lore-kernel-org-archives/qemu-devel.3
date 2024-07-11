Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A79C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtUu-000201-R9; Thu, 11 Jul 2024 09:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRtUt-0001sT-Dj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:06:07 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRtUq-00016x-EC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:06:07 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77c7d3e8bcso115954766b.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703163; x=1721307963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTN87uuquUXYfM7j/a7HcjQaL8Zy0hHHGMWXHuKr1eA=;
 b=VsF7gbppHn93STyrSOudn+5K7zfN5L1LyDisFbJoQPBUeMewSF9VJaNGagRDBdDSju
 R3/QV19fqkg0mPZCQZnfS4qRhwy5e5gu4r/qJbyIG0crizVej7ExzVGIn8QCJy7hxfyr
 CaQwPN1nUfdiBI0FzVFfBGYrOuwhLTWhA2kswaMA1Nm41q1w3vUMzwhA1dlSf/t4OWhl
 5FatyiXeO2S9Mz9Qol0GQKg8C3TOvdntmvliM/cH6lLeIo1nTZWPY/L85kDkT9vAc0kj
 UPmbTg0vgOiBa3S2dm7tSddnmms1qoEzhpMP6tKb+AbKv7FgJ5mCI/Y3d5mWyBAp6y8w
 OnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703163; x=1721307963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTN87uuquUXYfM7j/a7HcjQaL8Zy0hHHGMWXHuKr1eA=;
 b=RjqC+oAjgXO4/b6Z5bmPTuY/wXt7NqONOSt7C+YEALalP4koFxg0wY02VPP8iClJOE
 wgtInIAPdgvVnei6FvbvFBlj8NIWw15vb+ERme1sGVUqz9OeUoUVf09B+rVqZngNk2gv
 esb1YE+B972YXgYkuVS30EYmFL+yPaKenGRcfANQsvACaxk0AgLZY3g3s3wKnJPwq7U2
 jEEAJFeRuCarPmFTWVItBIfMNqoQKewI1tF4vIHHTAuDCOokiovUijYCY9WKYUp9EE3F
 EIfeitDUnLNGnTtLqRwCOILBM0eMfGTMAP2BtjoUg7Y8f1ylWB65vR7Uz4UylfU5NyI+
 dj1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYQEiDcUaenIBTYFdXjJ8/lPjXhE2qYPfBCgxdlsL1gq+T9a+/VNABidvjSyGeI9SPBmSsnsBcBq+dlitwTr5DHOt+TyU=
X-Gm-Message-State: AOJu0Yxl4XU+GKoFy0+AYSHcuyRH83ErYvnAReSFJzJFMJe898kWzDe/
 3TYW3GjdqmqXbHJNcv/JTbveTw/rhAKTLfGXEkZkCZj6GmhEPQIEFNYFbLkiU5fQwZNrpLrGncu
 Bd1Op57bHcMvei767xyj1vcbidY7IspHrq+U+WA==
X-Google-Smtp-Source: AGHT+IHvGoHRoPBfG9Ce2KqX8JOmx4m6zRu6HUbc/W/tW1ASTbuH/2pkOGcrQbetTwE+UfJFnFqFuBtnHL1acI/AK2Y=
X-Received: by 2002:a17:906:e246:b0:a6e:fb9b:6769 with SMTP id
 a640c23a62f3a-a780b89ed2dmr542087666b.75.1720703162585; Thu, 11 Jul 2024
 06:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240630130426.2966539-1-zheyuma97@gmail.com>
 <e9072d75-06e2-4439-bc47-668d921e3202@ilande.co.uk>
 <CAMhUBj=Da15FJRMoX2Y=yScOM9L1RyydBK9=WNddQ=rdfJHp5g@mail.gmail.com>
In-Reply-To: <CAMhUBj=Da15FJRMoX2Y=yScOM9L1RyydBK9=WNddQ=rdfJHp5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2024 14:05:50 +0100
Message-ID: <CAFEAcA-o+UuSthDkrgOxCBnEyMcqmu1yTJCKa=fZciSgzVMFEg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/tcx: Fix out-of-bounds access in
 tcx_blit_writel
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 2 Jul 2024 at 19:15, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> Hi Mark,
>
> On Mon, Jul 1, 2024 at 10:49=E2=80=AFPM Mark Cave-Ayland <mark.cave-aylan=
d@ilande.co.uk> wrote:
>>
>> On 30/06/2024 14:04, Zheyu Ma wrote:
>> What would happen if the source data plus length goes beyond the end of =
the
>> framebuffer but the destination lies completely within it? Presumably th=
e length of
>> the data copy should be restricted to the length of the source data rath=
er than the
>> entire copy being ignored?
>>
>
> Thanks for your useful tips! However, I'm unfamiliar with the tcx device =
and cannot find a specification/datasheet. I apologize for not proposing a =
proper fix.

Yeah, I couldn't find a datasheet for this device either.
In the absence of any clear information, I think what we usually
do in QEMU is take a plausible guess at what it might do
and/or implement something that's straightforward for us to
implement. Chances are good that real guest code never exercises
the weird corners of the device behaviour anyway. Possible
options include:
 * just ignore the blit attempt entirely
 * clamp source and destination addr/length and do the parts
   that do fall within the vram
 * treat address calculations as always wrapping around within
   the vram (so if you address off the top of it you end up
   reading from the bottom of it)

I would suggest we just pick one, implement it (with a comment
saying we don't have a spec so we're guessing about the
behaviour in this case), and then test that whatever guest
code we have (e.g. the bios, linux, some BSD) doesn't
misbehave with the patch applied.

By the way, doesn't this problem also affect the other
TCX accelerator functions? Most obviously, tcg_rblit_writel()
is basically the same structure for computing address and length;
but also e.g. tcx_stip_writel() and tcx_rstip_writel() don't
do bounds checking before accessing s->vram[addr + i].

thanks
-- PMM

