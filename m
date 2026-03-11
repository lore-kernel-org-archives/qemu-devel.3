Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AA0103E2F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 23:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TDF-0005ZJ-41; Wed, 11 Mar 2026 19:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TDD-0005Z8-Tq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:43:35 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TDC-00039I-EO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:43:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-662c6aca253so492098a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 16:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773272612; cv=none;
 d=google.com; s=arc-20240605;
 b=HHIJhwb3vqKLsZ/AzXVE4Z7nMrEru5s5BilmKJoh5WiWrwnC5za8NKnBc3IrrPmRkU
 tTe0CCKquxOIsgBaJyg9G52dHYd8Lwg6TZ/Z7ORgFPZLb4bNdcgHuTz447nucXBMLcXJ
 TPS1sQjHINHs1UVc7053RcseAzT/mWxnT1skCagS9fOwyfPnE3iOlmuu6YTYl8nmYARI
 nh3a52MR6GRIhBTFRU5RXhq2w4r6lYkfOFgloApaUIThTvMcQEDqiyw2sKc4aQOiSzXM
 maU9lkwz+AA2yppibgm1vDLe6mGsdYUbJWAGwhb95k1JYFyesDTEPamjckdOYFpKfSt9
 xpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Xcmbx4GC8/Ai7Q60q9TeW+BRqKKhwaIgFqdEotrMI4=;
 fh=k4oQgMZHWkZowjNniTwzvyfj54+fb0bd+QEqa9MBeWQ=;
 b=Qdj7+7qwVVOYbJBWFa/5i78QhySs99StqhC/gv9GGpnrTjbtCH/G3pkvPKFvU4ojsR
 Bq3ac1XM88aQGUp3pVGnVmTRy8JN1DFVmNt9bfFscm1FmkQKOn4wi/fh2Z0shCsqThsp
 pkDIrTqq9TWsrhoi5ednS0iJYN0NELCp9D/6ZoEWZYFJ0OfU7N8GCYbAtTYW6SMja+HK
 S7g8kvSYUU7EhxpGnsaGQBPOoFQ0mHERMjBxI90lY0EHb98Qn2MYOtWyRD3NLUu6+8tZ
 gDop6/MCFnZKsDNH9oYrDxvNGj3qN25Fe9LPCOqr0ndnI83xKiyavSUVlCXlFjypdFRG
 S70g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773272612; x=1773877412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Xcmbx4GC8/Ai7Q60q9TeW+BRqKKhwaIgFqdEotrMI4=;
 b=aaQhY8P+y8cfmgSNoPUVHLWAIvv2HHfPbweU6f4VVgVZ18/czLHRoBLihJNVlUjBot
 QgG7SEyfya5dma/IqoaPkc0Ifd63/uk6vuujkaYIPj03tlDXtxOkdoDrrHJyGuwWf1Bz
 f3sX1sZhp/zfVOK1FOb8/GAdtBEAoPN9RnGgCdia91mGjKF5szU5dGS8vTGMH8YmZeB7
 MW1YSc21689tjRrXvi2ILdxDnTn2lYV1A5g1K9g31e0etWh7u5/ubfIJwdrySYbYtqVD
 7t0DsrlmDxPjwz3BeFshpay3n6WmHCIW/8LD7hpkECATnGoF7wy3b2RWaCxU4QXGzG3V
 ELQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773272612; x=1773877412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Xcmbx4GC8/Ai7Q60q9TeW+BRqKKhwaIgFqdEotrMI4=;
 b=TSMfpAkKXYk8S8bhzxSxHUnJpcmP7gbLA3xvPSQwuZ5eZUMbdBoe9xKqHa+4yTF4x7
 YHHZhOh/YJYSt10iVxGtVr+VUunRdmUT/xn5tG9n1ncVGc+SQPIhwvhHNOVL7H0lpkE4
 V9FDm7iYylRnVJxa+VlgAOQu5KOeuIuWRSTyZBNwkjF3DrpwRru/AUYMc3ooQtVHD1HY
 6z9ni4Gcff685pj/GHhR/JAE3WnYIYarlgLTb+WwVEKXgaBQEt0mBEbW1inVHOb57mk4
 ++LBYu17zsRjxrKG6Fiq9Iq96wS4u2g8RH+N6cLFZrJAwVDg1FeDWC2gZYiyXaNtCoO4
 dCHg==
X-Gm-Message-State: AOJu0YwaPJb9fB12LlxuM95ibfnfFc2bZuBETT26i2nVa0rauwsBl/q3
 sC4W7Jk6rVHR71qyE0U+4EzZNtPD1pq5i8mTRBZaC1029NobNm5Z6eon5K6cwLxIOe5F+fhbumq
 qi5yL2hXWpBBlWNSTktbXbx3DAFL+agc=
X-Gm-Gg: ATEYQzytblw47uLybR4mhViHEP3z41nTa9Ghl8IXAaWrZBUGAv+DX8XKREbDRnp5V37
 IZvqfBGUNf0ckZhYXrl61xT5mQVfcsyZF+IQpYGA4egMbTZgZ9yYZkn5TMKMaJ27YymyvQERde+
 aZP72dRfVq4pmwfrZuNzgsiHML15aWkMl46dE4lUYK7dsJm6KnALV9L7rfNoNkNFtxwbYOMQyQe
 oWkObkGBRho4e91pFPdVIPRqa8+Wl8vWRD0mPzYueEkwrC45wrjKxxdE8BLR7Vlz3CsLJHEyVje
 hIByukoEafWPqSFkAsyPRJ0EB/v4hNTA0aFMFA==
X-Received: by 2002:a05:6402:1d48:b0:659:36de:6d20 with SMTP id
 4fb4d7f45d1cf-663196d1714mr2217584a12.14.1773272611424; Wed, 11 Mar 2026
 16:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260309095328.1406779-1-peter.maydell@linaro.org>
 <CAFEAcA8x70ruJzSXhSo5OentZnTgsh4xnZmqL3h9+1EcFY=z5A@mail.gmail.com>
In-Reply-To: <CAFEAcA8x70ruJzSXhSo5OentZnTgsh4xnZmqL3h9+1EcFY=z5A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 09:43:04 +1000
X-Gm-Features: AaiRm529iwcv0MGz1OAns_FUmpKJNdiws6AapVlslsFMleMXA5k8iOlW6d0Txoc
Message-ID: <CAKmqyKOUUmKZUhFwjKB1+t5qO9swD1Sduot9kWApvNz46Ap=DA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/riscv_cpc: Free CPU array in instance_finalize
To: Peter Maydell <peter.maydell@linaro.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 9, 2026 at 7:54=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Mon, 9 Mar 2026 at 09:53, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > The TYPE_RISCV_CPC device allocates an array in its instance_init,
> > but does not free this, leading to leaks like this from QOM/QMP
> > introspection:
> >
> > Direct leak of 512 byte in 1 object allocated from:
> >     #0  in calloc
> >     #1  in g_malloc0
> >     #2  in riscv_cpc_init /home/pm215/qemu/build/san/../../hw/misc/risc=
v_cpc.c:175:15
> >     #3  in object_initialize_with_type /home/pm215/qemu/build/san/../..=
/qom/object.c:570:5
> >     #4  in object_new_with_type /home/pm215/qemu/build/san/../../qom/ob=
ject.c:774:5
> >     #5  in qmp_device_list_properties /home/pm215/qemu/build/san/../../=
qom/qom-qmp-cmds.c:206:11
> >     #6  in qdev_device_help /home/pm215/qemu/build/san/../../system/qde=
v-monitor.c:313:17
> >     #7  in hmp_device_add /home/pm215/qemu/build/san/../../system/qdev-=
monitor.c:1005:9
> >
> > Free the array in instance_finalize.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/misc/riscv_cpc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> PS: this file isn't listed in any MAINTAINERS section -- which
> section should it be under ?

Djordje can you add this to MAINTAINERS please

Alistair

