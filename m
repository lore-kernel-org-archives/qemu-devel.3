Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF6CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjgk-00068d-NS; Mon, 19 Oct 2026 05:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjgi-00067w-Jt
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:29:48 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjgf-0003LD-QM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:29:48 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso10338877b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402184; cv=none;
 d=google.com; s=arc-20260327;
 b=ppyVrfDh9dn14lzBVQfqDliUe4HmYYBsapmsD6blsyTw/gvP4HjMWpITDwQTiY7ZXm
 EIWGQacJ+hHNW/NHdN+BDCySmLvwC0FZ5KExxG11V7ZfMKJp4lhS6NsR9tU+y8eh+WZ4
 blROJk9mTAemIj8XWQD7+/i5YJpNa9rc/5HCZvpytDj4LzdzFEIrIr2JPK1wqZInKnJ7
 FFIH2GbcaysbN2QG6IQ3ExpuDIsGOEdX5IqYSfo/QlvhMo+WXyjJGnBZAK4pj7ptElm7
 frh8EcpVKZkOVmOoe6la1E4wr+TgnGsvvETnBqmeoeG81gA6SN0zOR1MxdY6q40MMlCt
 Hppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wu/aJVrJjYsU7n16Y8vhi1YVFKpn9Ard0xiCuPPmtaE=;
 fh=d+PIiUQTFPfu/Cafj1Vz8V0LoDy3uqaq5iwDI1dTbVA=;
 b=SVb5v79e0plKaN104jZ8Met5NS+vpvs5q85qYX3JYH9Hop6EwxGVTGD9jo30Sbrzyp
 BakUXIB942YYRRepGOwyF/XHTB/dhQviHgXeRyMvRR/gN6RQ/SbBZ7ywhkoqv/uLB5gM
 X6piznjsLr+gEXkJCsVQK2QI+kPLQN4CAOCxEoS9CwiopelVVJIrf3sI3ggvhasMvKvr
 aIF8TpgILdoVZY5dtBMluhiWVCuh4sYQlU7PoL7N4/lozjvLj33GpW8pLgPzav2Gq4+0
 klWeY7Kk81HySQlm/SbS8KxN/WwI1bXWp6g0WAo0h86XaeB6MkIDSGFhKevbDR7ckc+P
 tLFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792402184; x=1793006984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wu/aJVrJjYsU7n16Y8vhi1YVFKpn9Ard0xiCuPPmtaE=;
 b=AHrCL7twMCDT2lj3OjlhI39eKhTXbUwFQXk6naXjFbBDUiYc8hkt1Bl4lukjd1HJr4
 0cbcPxd6LVBb2tDbiNYGPa3V+7290C5r4tv8emFHxkRNOG74phPZxpRl9wBnYLMGRV8M
 XpJ224LlIGjlPytPUTVFDbZ+WfvLNgD0Rc+gVMmV0Gb2XXHW0P3PopYwYNpDYNnOZN9l
 Y3De9k1YFNicYqaQkOPH3Wkn/E84mcE0eWSxp2zGcu65cKawh3Zwm+aqWTf86SH7angW
 q6Mosc1Pph7vUuflKzpwFFjhS93jbpdYSMAE8C7AlVUPEUqOe5ynwDe2MhNMS8U4Om+C
 mOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402184; x=1793006984;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wu/aJVrJjYsU7n16Y8vhi1YVFKpn9Ard0xiCuPPmtaE=;
 b=clkO3Aq2XTtnwR78LVEZf5AxlVP4YdYSWoq5OTWdA1eOKSe3thheI8RgBV6ZIRXiTG
 hhRrVCvbFVs6prlmT3JGNkawLi/VU+Inc/caCt2I8+7hrA/tPZOpLjSbunxC67jnTsmx
 1vLPU3z3wG9vZp3hcEn5ssofSd9EGO1fIT3EE9fyeU/NP98nj+ciZQIGcNMQgxhjdDCM
 c3H1pmuOfZY5uY2gNgpGAz/aPQnwTuM/9YrfmWcOrchl9OyDG0DJf4nd47NpcwH2jZXJ
 3j4Ra1sHfvwlBV8Miifnbh12Y3d/N4A1PMgp9YKrPFP4NNDQfHy2B34HosXVzsSAgqJR
 4Akw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBuphvdbLtmyu1wgHWYByjpTOPMXNEHo8FmgZYDLpHiYWKscI/yzMWKzhcBIAzejL9JIlp35gARQN9@nongnu.org
X-Gm-Message-State: AFq9FYI2WhCXgU6Bap3uQYmeY5Y3T7VHitnYkKmH/1aDn8mei+D13IJI
 OSVRz50AtlH/biEt52FufjklcWoddG6ldoNgLjcsLAxAjZrtnVTx87N8xlIChUQWymXIIKSa+9i
 kmejp9aRar9zD9ObFf5adw1vBlef2r/TbZ+YLYAdWpQ==
X-Gm-Gg: AYBFou038ttJ6XZpRherelbQjUbgduA5mA3zHn95DWWsU+bqOhwrplMFGDRsYCxUwmx
 4SX8lz6UMV1A8lSf7OAJGA6FER2YS5Yr/h2Xj6PJpC0NRQIzPSlqg1pZrlrmUw8Tzajg24jWuug
 h/cOyS7A1kxQJa64ML0CIui9QBbFjwLwIj91VLMX0lC2ieFyjPTApn7AeAkVmNYPMUWTel4awmo
 bcX1H1sS8Sogl0lsZEve5/z5sAxVYxse3l+D7HeXfLz4ssUqXBkkquqQkKngibtxfVtzcQygoon
 xtMTZ4Dn5RAKAZtQDl92qgH0c1ICnq7xEbgL48pQQqVrmE4NDLkvJU5PIYmN4E8P9f+8yLTXJha
 BZNC6SQGAhNzi5vP9s9q2SZ+PhM5cN3uTKg1e0pc=
X-Received: by 2002:a05:690c:582:b0:8b0:ad5b:d466 with SMTP id
 00721157ae682-8b0f2169b86mr25778217b3.25.1792402184296; Mon, 19 Oct 2026
 02:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
 <87fqy23vag.fsf@draig.linaro.org>
 <bbdf0c72-b842-4c06-b4d8-85c6613fb64f@huawei.com>
In-Reply-To: <bbdf0c72-b842-4c06-b4d8-85c6613fb64f@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 10:29:32 +0100
X-Gm-Features: AclHuK_83zqwDeRCTJnjFQoF8lhhb65lU7wQASrI2Z2OJ6aeMdRsqZRi4pGZUMA
Message-ID: <CAFEAcA-vWJ2iMoGhF6kcKWH18cH=gy79X3-2PdQ_sNrz1-iJZA@mail.gmail.com>
Subject: Re: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jinjie Ruan <2118537295@qq.com>, anisinha@redhat.com, armbru@redhat.com, 
 eblake@redhat.com, imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 19 Oct 2026 at 10:21, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2026/10/19 17:16, Alex Benn=C3=A9e =E5=86=99=E9=81=93:
> > Jinjie Ruan <2118537295@qq.com> writes:
> >
> >> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >> Add the MPAM system registers for TCG: MPAMIDR_EL1 (RO) reporting 64
> >> PARTIDs and 4 PMGs, and MPAM0_EL1/MPAM1_EL1 (RW, of which only
> >> MPAM1_EL1.MPAMEN is architecturally reset). Advertise FEAT_MPAM via
> >> ID_AA64PFR0.MPAM for TCG CPUs.

> > Something is wrong with this thread, when I was reading the cover lette=
r
> > I couldn't find the rest of the thread. How did you post this series? I=
t
> > looks like the cover letter, first 16 and remaining patches where sent
> > in separate batches?
>
> Hi Alex,
>
> Sorry, due to SMTP rate limiting, this series has been split into
> multiple threads. The complete 37 patches are as follows:
>
> - cover letter:
> https://lore.kernel.org/all/tencent_22E95650AA60C6E59860452C0D61A21F1105@=
qq.com/
>
> - patch 1 ~ 16:
> https://lore.kernel.org/all/tencent_0D8D61C20611EC56598A6F86E7B869052E05@=
qq.com/
>
>
> - patch 17 ~ 37:
> https://lore.kernel.org/all/tencent_88B063FC15FDB4BD89164484DB67A9B61907@=
qq.com/#t

This is OK for initial first pass human review, but you'll need
to fix this for future submissions, because it breaks the automated
patch handling tooling. I do fix this up for first-time submitters
for small series, but 37 patches is way too many to fix up by hand,
so this isn't going to get applied unless it appears as a complete
series in one thread on the list.

Note that you don't need to *send* all 38 emails in one big lump,
you just need to send them so they all have the right threading
headers.

thanks
-- PMM

