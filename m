Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3283C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ree3D-0008KH-Ah; Mon, 26 Feb 2024 11:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree31-0008H4-E3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:41:48 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree2x-0004sq-MI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:41:45 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso4057136a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708965702; x=1709570502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zz0g/SyN3o6gzFvtFXQUqIxjWNzvG/FFb/14quMjtqg=;
 b=zg5+6lZo/TW29+BD6qnRaqpbujgfBKQPH9HyHX2MJ72EtLrXKkYAREMescyQyo7KNq
 AaYIqlrQsklO5O1oZ0xgfiT1Tf8KMaqXG/3sDTUuz2EhnqyK/9fJ7vZcgRqpYM273lsP
 hjt2KXuxHZm+DZnMmNQYWfVwlp21Gp/FeBhoSIem7m7du9KY2qhYyq4qo3uOzAWf1xPR
 L0ZWMT85qpYvUGapdzuZhcFyhBVmveYZMn4ej8Ure+8hSCv+A7qJissax+Z+bjUjfSy6
 bUrqE00syGRKFBuiEgK2XbxPk7djWDtL0mJRoxgm0GvNJgwwXMmO4R+hKdMKc1ItlqFg
 cKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708965702; x=1709570502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zz0g/SyN3o6gzFvtFXQUqIxjWNzvG/FFb/14quMjtqg=;
 b=IN8Hw3tWRT/Gt9vOTT5rqcyH2h3w2UwrmtsRVYBcyFLpyH62sXi3/T6yQgOXP0Zkof
 DYp1j+NjlcMcX9yGWblrXSgqHJFq81c1Td3hukNHpcbUNXLQYHiCMj3KOyLH+avTHfvd
 B0QYKWPZqUOXaePDRfkiFXWisYIaHGbQBqsLcj/RivMRp1XDS/YEJlmxtMScYbJLWYXU
 RhxGltakJNPo6v3qJ9MntMigJDw6wQnUOaJtXYFKggJgtPuWbfa6OY0F28+CJbe7mhzU
 h5hX83prPLP4GcEKH8ytBVCU5u/RgWzt7J/KyNp1bQlCmJItxZpYM1Kcq7HYHoqGckeA
 I9hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxiDVUEtC564Z+IkyaDh/WtCKL/mf8w+Du4xgnKTEakm/zCKJXi69AJ00Q2GzMV/2vvLPvGtL1WDvKjtypF/5XfOJC+XY=
X-Gm-Message-State: AOJu0Yw4z/Kbr+9w7QJCO3H0Qz2wq2x3CXKNXMFqZLB0Bj3ap7qcreyE
 Q4e0T06Zb1ntklKeC68LtsXKq+yuwtipKf3N7jUm6qwC6Ruj/aoxWcbyDBj46eJw5XvxjJgQv9B
 IXKOt4rFERjTBfYKGZn4bS1zrEMxpOZSfjASjvA==
X-Google-Smtp-Source: AGHT+IFLTpZAgrX+gUV1Qx7KITmZHH8sk6RyXboJZ04tSirfhte0h+GprFribGpPXXWjrPk0KBUg1XHa39Lp09bY4BM=
X-Received: by 2002:a05:6402:b14:b0:565:63d6:40d7 with SMTP id
 bm20-20020a0564020b1400b0056563d640d7mr5823202edb.5.1708965702008; Mon, 26
 Feb 2024 08:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-12-sergey.kambalin@auriga.com>
 <2ab7b523-816b-409b-a58a-f09e3f71ff8e@linaro.org>
 <CAFEAcA-WwWQnAQTmoCixaW5aeRWrdx__YoSHp_VyGEbk-rOkpg@mail.gmail.com>
 <df5f7f10-41ba-4c2e-8d50-9d35203d940a@linaro.org>
In-Reply-To: <df5f7f10-41ba-4c2e-8d50-9d35203d940a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:41:31 +0000
Message-ID: <CAFEAcA8D45XrBBL1f7SxBCVD6vUO+Yvsxko7Kx91qgEbzrXG2w@mail.gmail.com>
Subject: Re: [PATCH v6 11/41] Temporarily disable unimplemented rpi4b devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Feb 2024 at 16:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 26/2/24 14:39, Peter Maydell wrote:
> > On Mon, 26 Feb 2024 at 13:35, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> On 26/2/24 01:02, Sergey Kambalin wrote:
> >>> +static void raspi4_modify_dtb(const struct arm_boot_info *info, void=
 *fdt)
> >>> +{
> >>> +    uint64_t ram_size;
> >>> +
> >>> +    /* Temporarily disable following devices until they are implemen=
ted */
> >>> +    const char *nodes_to_remove[] =3D {
> >>> +        "brcm,bcm2711-pcie",
> >>> +        "brcm,bcm2711-rng200",
> >>> +        "brcm,bcm2711-thermal",
> >>> +        "brcm,bcm2711-genet-v5",
> >>> +    };
> >>> +
> >>> +    for (int i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> >>> +        const char *dev_str =3D nodes_to_remove[i];
> >>> +
> >>> +        int offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_st=
r);
> >>> +        if (offset >=3D 0) {
> >>> +            if (!fdt_nop_node(fdt, offset)) {
> >>
> >> Peter, I remember a discussion where you wre not keen on altering DTB
> >> for non-Virt machines.
> >>
> >> Since these devices are all implemented at the end of the series, why
> >> not add the devices then the raspi4 board at the end, so this patch is
> >> not even required?
> >
> > I'm not super-keen on it, but as you say it goes away once all
> > the devices are implemented, so I'm not too worried.
> >
> > Doing it this way around would let us take the first 11 patches
> > in the series into git now (they've all been reviewed), which
> > gives us (I think) a functional raspi4 with some missing devices,
> > which seems useful in the interim until the rest of the series
> > gets reviewed and committed.
>
> Fine by me! Sergey, don't we also need patch #39 (Add missed BCM2835
> properties) to have a happy Linux boot?
>
> Patch #17 "Implement BCM2838 thermal sensor" could also go in but it
> doesn't apply cleanly on top of 1-12); maybe Sergey can send a series
> of "patches already reviewed" on top so they get in for v9, postponing
> pcie/network for after release.

I'll put together a pullreq tomorrow (see my other email for details
of which patches plus the necessary changes to the avocado tests).
Sergey -- I suggest you wait til that gets upstream, and then
rebase on that.

-- PMM

