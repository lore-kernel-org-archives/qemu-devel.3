Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A16E9B358
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Y8-0000Te-3t; Mon, 02 Mar 2026 05:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vx0Y1-0000SM-KX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:30:45 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vx0Xy-0000pB-Ih
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:30:44 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-505d3baf1a7so856941cf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 02:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772447441; cv=none;
 d=google.com; s=arc-20240605;
 b=Q/Kkdn2M8hGVxXvRUfcCu4l6ym/BUY7I1q40evi8UmTW74PvgfhLWI6hjOjCF/wFIN
 8UHIaH/VLEcwNN4Vh753RQcr8JjmFgulnPRzIQLNiq6N12WitYQijP5CPbipItFN0Llj
 bHddQVJibT2PnXpXNygVOShGv5Dvw4+C8yDR+6SQ9eeO1fHjET6szstjGpEqxw6tDqan
 xnZcIHxRwtlYkMMKtA3jJcVxLmAMa6bczAPXWsLwazb4KhqnvDuyOglyu2YguTZL0vzz
 cQdUkqJTvHQO4SiO1Qr7y3z/3cj/Kz0fenVChE0qqlYBq9YOZornbDqy92rp+dvkRyss
 WO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rfhMUT7KiGMB4MQrlj5m2r1WYWrCliNf5mho226AQmo=;
 fh=ZOlpd4Tcvh64Y1NTJVyLnx19JNQJ0WHLQNj2wXKCmkA=;
 b=Hb9f7hSHWME1GSwF8Oqrw/ZGYzoNzXSLwST/j89faYmQtS638x2nxeH/+oOJmFKiUl
 cWbXgPJr9iaz5Xo//tKoMGNK5MAYuewOrmfjFsFOTv1nhqlGMWx1kDm1C6hVfXlPTlJd
 W/JbCSTaOtKXDRRnsyRmq+9tu5Tec0l7S9Q+fabPvf7vMhiU8wnd6xktLIxYqBZxzPVl
 XMTxq1Z6dmF9hAN7i+Opb+0b/pTYRJ1g9+ePSxCyE0KX9R06c0jzcsMbpX6arP8NZ98R
 siaDM2XE1727B5QlKpK/J+p/C4vDSalrufuynd5ZDJYZpEkDYC0/FvikuUStwB6axnvE
 pZWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772447441; x=1773052241; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfhMUT7KiGMB4MQrlj5m2r1WYWrCliNf5mho226AQmo=;
 b=CvAHUOOYecBNmG6dcg/5GxhMLkF438HUDr+uZ7kFgl0OtWfXI+p4wW6vR0oJU3/rsp
 4a+PSiAqyb5D/YaygiX8zH6Q5Yc+sHwpaj5/eJ3Zvc9N8/9J14moTO4N2ek8sBrQP6wU
 obmmBWG8IxsLEE8cCznH4bRxbS46ESl00MwXhPhIHx7nO+MW+ncC1RfcEl2Vu3QcXvWj
 AalZg2AUJ5MBdiY640l8/pKu3vxSCTPBqFv1z+cJzpji0smwnwmWouOb4bxlEg+zeGPt
 3R3xMSqzUti/OspCKavGW+2jBRW4x6AIJRna2X9XoFhDUDBuZsrFJWaGNp9UT+en3z2e
 3rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772447441; x=1773052241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rfhMUT7KiGMB4MQrlj5m2r1WYWrCliNf5mho226AQmo=;
 b=u6WzhGWvs+MYS5H4G5+/RQ/6rfmxGy0Pdv3SMHqBeaYvRT/vOkepqIAxtxU/IF/oVS
 ZLOQ10AMLJrWAjNPI3H/eoAG95+9SW7YfvsSJ0GrlLGbQKQ8o5uZZHqBgpPS+xg390JJ
 Rkuna0pUqXLKP8GrNstRIEA/PAW8KBiApRC2BqbUAHsGR1egd5MhtcwANcygTDtmxh1n
 SWb+G8LGBSDo2/eAMHvlfbTThXWh4sUASUyiSdEYMA3whZtK6JD40sVWM4wciV0Nlbnv
 ZWtTDb+2pXpBjC6aEdYO/uJj8wWjxr/txjGWkQDORDh+ee1op712jI1zKHFvVzwLp4y3
 te6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxfaZOKFXDk9PHfAGxiUm+aPnIfr4YL5tQm+xG3Xd2VBGnymAJCOc9H2Zsx7EASRYbf9imhEHyI15W@nongnu.org
X-Gm-Message-State: AOJu0YzARJFKVVTWaRhYIuleH4CsLQXbomsT2DWBq22hntPA85lm+u6Y
 /NC11+pT2PhL0BXzL2V8M1gMKXPwV8SWGx1Iw7MZP+o2Q0n9DGwjkCC6Nq6i928mKTc2CFHLYQE
 uDBa8vZS8en+y4pgXsCVW4HSEdtNGXJgYUsU4BrII
X-Gm-Gg: ATEYQzyiKxFM/zDLBUldtMqU0mZ6wknxjuzI/GHBZpQXKwwn/a+tT+a1a2+HnKWip/f
 FMOgCALfr9liwisGS8u5wwmr73uoUROYdPuGef01wjSRXLHcn4abN6kZxnMXhZKTw6Nn0cvs97X
 Bp1wj/DedPn5ZlI2IWxhVzrkj0ZuGMTeWv1q8agkLDqHvosvgnY+552KEY42I/bt84stdsQHNMa
 q+tySSqJfUQ1oIncMJM4OgDGze7MUWwAyvFp0mG+Wn/KP7ohAnZFk2NzqR6MS9JNHh8nNhJNwvv
 WSQpxD26fhfhOOsr2tMG4IZic63X+Ug9VdjvOd+vTx5FsLN9
X-Received: by 2002:a05:622a:1999:b0:506:1f23:e22c with SMTP id
 d75a77b69052e-5075fcedcc2mr20207881cf.6.1772447440591; Mon, 02 Mar 2026
 02:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
 <aaGuGuevX8HFqx0x@google.com>
 <db70af79-b9ef-4da7-a561-850ad75ccb61@phytium.com.cn>
In-Reply-To: <db70af79-b9ef-4da7-a561-850ad75ccb61@phytium.com.cn>
From: Mostafa Saleh <smostafa@google.com>
Date: Mon, 2 Mar 2026 10:30:29 +0000
X-Gm-Features: AaiRm52hS_F3ZcPsJCdC4nhBinNAxK961Z_ItUqJ1LS5vCwWX17vQD8xPaXdhvg
Message-ID: <CAFgf54rvZQ2q5hbZJyJdix-HxBKJh32VsaG2L36bwxLnrGDffA@mail.gmail.com>
Subject: Re: [RFC v4 13/31] hw/arm/smmu-common: Add sec_sid field to TLB
 entries
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=smostafa@google.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 1, 2026 at 3:08=E2=80=AFPM Tao Tang <tangtao1634@phytium.com.cn=
> wrote:
>
> Hi Mostafa,
>
> On 2026/2/27 PM10:45, Mostafa Saleh wrote:
> > On Sat, Feb 21, 2026 at 06:16:40PM +0800, Tao Tang wrote:
> >> This is a non-functional preparation step that adds storage for
> >> resolved security state in SMMUTLBEntry.
> >>
> > I am not sure about this, when I added stage-2 I re-used the same
> > TLB instance as it might be used for nesting, and we can have
> > end-to-end cached entires.
> > For secure state, I think it=E2=80=99s cleaner to instantiate a new TLB=
, as
> > both states can never mix, and in this case we can re-use the same
> > functions without adding the secure bit in the TLB.
>
>
> Thanks for the suggestion.
>
> I agree that keeping separate TLB instances per security state is
> cleaner and avoids having to carry a sec_sid tag through every cache path=
.
>
> The only downside is a bit more plumbing: we=E2=80=99ll need to make sure=
 the
> translation/PTW paths always pick the right per-bank TLB (otherwise some
> call sites may still default to the NS one). This also means touching
> the common layer since smmu-common currently assumes a single s->iotlb.
>

I see, I will need to think more about this. My initial thought was
that the iotlb seems to be exclusively used in smmu_iotlb_*()
So, I was wondering if we can change those functions to pass the iotlb
as a function argument. We should have enough context from translation
or invalidation paths to pass the correct iotlb instance.
But, I agree, it might not be as simple as I imagine, although I think
that would be cleaner. I will look more into it.

Thanks,
Mostafa

>
> Although some refactoring work is still needed, I=E2=80=99m happy to foll=
ow your
> approach and will rework this in V5.
>
>
> >
> > Thanks,
> > Mostafa
>
>
> Best regards,
>
> Tao
>

