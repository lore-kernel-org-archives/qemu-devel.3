Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E38C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 10:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCFIS-0006Se-Nq; Tue, 06 May 2025 06:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCFIQ-0006SG-Q7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:13:06 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCFIP-0000hf-5B
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:13:06 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so16648a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746526383; x=1747131183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuuVejNo+bsYeezQ7cJzx8kVZCSuW9A1pxXWLBvCogA=;
 b=oGQJCyz71+nD6oKOR9x2VRgJ3UR5IZuJXgKVBSpgIx+AbzGpPvYWv+VzqezVDIZgS+
 9SykcsS0g41JMhFpT5x0dqaQqzK74wr5l7X6+8PbgZUpCqAad52mjlkeXsj9ECxi/LYw
 6aHpPZGz1qFAXVChLSl713X9EqaRpkooYAZDVTYlLQ9S03qykfceIZaH1v8L9oPIEeR0
 P3GKr1YlW+kjdEAyNacm2r6K67r2tCCO0ROoSm5jv4lB2jP81o2FKzD+7HbcPXeydyHF
 jJjZL0p8xUTse/D0GQ4EnwiFO0bYKInGyYw/rBmahIH16VY1qdJ0kDJ6MDjRFTku9t8Q
 oevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746526383; x=1747131183;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JuuVejNo+bsYeezQ7cJzx8kVZCSuW9A1pxXWLBvCogA=;
 b=AObClIeXNlRO9zuUq/G0U7fjxEb3P8oMwKnnsZhR5oXn05SCcjQRXxbYYcpY5t8d5m
 uz/vgEYXQkwY3kYzXF0VJid5cftkwJ+zfjVDdym+UdicXDn06gEWo4X6tZRe2xRL6m+f
 p1GSOinwhFmSUcOmLzWBX41XVtScXC6Edt3IHGy8MxA5G1VGrnVj/oUUtLFRIa6SCbN+
 dLuv0Engc9sf3NV6ILvXlVYTCtzjgjGNWfsrokS+1+8ZkmuotfnPFI+K3N48HHAapwph
 VJYkN3BC5gF+7KjZ5jsAkidbRiNIXFyphal+YcTfMlWy9GDxRAhbCW7S3aY373uPumPc
 aWNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN3awg9NUugj4X5AgaG5hIepuDiFlAH5gQuCxpC1NRqJzMRhH6jaWIeMaDhOyP1zCbVs8dHsH/ztYC@nongnu.org
X-Gm-Message-State: AOJu0YzlS1KxnftQaI6+RysYOMYQq02F6T+Tg4LmbOugjaxXWax9p86+
 Z7zarZr1tThNd021k11wIPtr2Za35PEEgbR7DVfOT2/9+s+Y6UlXmGy0zfb+Yqo=
X-Gm-Gg: ASbGncuV8ZYvWQHwXQ1Z/83e7RMy6BW9Zjwknc31T+ewvJfQdFmd2rM4RTGh6yarayK
 aLPTXEVBec6cQ/0TYyxxcYJwJmProekzYWyegkYxWOM1ARXnX9lgjW00AhXW5v+j46TSKFj1yhl
 FkyfBuHVFFZIVWtZyag2adVujTxHJojHIfutmIHG1paY+I1hN1H4J/dCRM/fb3mRl7NARzBEu34
 s/YeLQcVPhN+eVc3cL327wHOkuWcASm+RxxUHvIHeWaR0+l/DCG3hL2kyRTG/Edh7bFas3WltKY
 2HjYvCjXw80U/Tlgp/ffjfCxRmsbcUCWZP9Zapm/3vE=
X-Google-Smtp-Source: AGHT+IEvlIJ4Q71GUC7hAQNCRLYThccNyjAQlQ9UpNpVJkTwmzgl+xkXU8jOsZqIuzxV92o9kfd66g==
X-Received: by 2002:a17:907:3fa3:b0:ace:c225:c723 with SMTP id
 a640c23a62f3a-ad1a48bc5efmr966691366b.12.1746526383558; 
 Tue, 06 May 2025 03:13:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c8bbesm7525601a12.22.2025.05.06.03.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 03:13:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9FC55F8BD;
 Tue,  6 May 2025 11:13:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH 6/9] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
In-Reply-To: <2e72ddae-2198-41ca-a31f-aab583ea4be7@collabora.com> (Dmitry
 Osipenko's message of "Mon, 5 May 2025 19:07:56 +0300")
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-7-alex.bennee@linaro.org>
 <9115fa7c-ed94-449d-816b-a13125275dac@collabora.com>
 <cdc4d710-2b7a-44fc-b58c-78a81ca83b36@daynix.com>
 <2e72ddae-2198-41ca-a31f-aab583ea4be7@collabora.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Tue, 06 May 2025 11:13:01 +0100
Message-ID: <87y0vanj2q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 5/4/25 10:20, Akihiko Odaki wrote:
>> On 2025/04/30 3:56, Dmitry Osipenko wrote:
>>> On 4/28/25 15:59, Alex Benn=C3=83=C2=A9e wrote:
>>>> Seeing as I've taken a few patches to here now I might as well put
>>>> myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
>>>> it's not my core focus. If someone with more GPU experience comes
>>>> forward we can always update again.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>> =C2=A0 MAINTAINERS | 3 ++-
>>>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 661a47db5a..f67c8edcf6 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2636,7 +2636,8 @@ F: hw/display/ramfb*.c
>>>> =C2=A0 F: include/hw/display/ramfb.h
>>>> =C2=A0 =C2=A0 virtio-gpu
>>>> -S: Orphan
>>>> +M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> +M: Odd Fixes
>>>> =C2=A0 F: hw/display/virtio-gpu*
>>>> =C2=A0 F: hw/display/virtio-vga.*
>>>> =C2=A0 F: include/hw/virtio/virtio-gpu.h
>>>
>>> Thanks a lot for stepping up!
>>>
>>> This reminded me that I wanted to propose myself as reviewer for the
>>> virtio-gpu patches. Will do it soon.
>>=20
>> Thank both of you for stepping up.
>>=20
>>>
>>> Akihiko Odaki is also good at reviewing virtio-gpu patches. Wondering if
>>> Akihiko would want to be added as reviewer or co-maintainer of virtio-
>>> gpu?
>>>
>>=20
>> Yes, please add me as a reviewer.
>>=20
>> I guess it would be better if Alex add you and me with the next version
>> of this patch or add follow-up patches to this to avoid change conflicts.
>
> +1 Feel free to add us as reviewers in v2 of this patch. Otherwise I'll
> send the separate maintainers-update patch along with nctx v12
> patches.

I shall add you both ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

