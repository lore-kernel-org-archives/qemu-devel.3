Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F15AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIBT-0001TC-MH; Tue, 06 May 2025 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCIBR-0001NJ-Mx
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:18:05 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCIBP-0006lL-F0
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:18:05 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70960e0b4d5so3428597b3.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746537482; x=1747142282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ry++gvQ3ZjoGDclwTqu4Yt0eg9TEBjs1UwzqzuDBf2s=;
 b=G/PmlKz2ZGEIfKQKOaFGQJToYX37ifc0VJWEgfHkuv1PnpbWyyp8oZ+sF40a5t28IF
 Db0tSQKCPJWiyA0Pg40NMiPL+9HFH47NLC8mg3s1o1yuqVvIfJHmZbVb8efnZbazKdEo
 aTxI06P/bV91sz/+DohTnY50bk6O+ZF7bSbxWqAZFvYX8e/LmuA4dyeRAQF6Of9v/coW
 Tcod7dhEX2Nx3QPs5HiUbIsxZ/iePov4CiQHxTe4gM13vbMBmqbS3p/eOSdkn49fVYfE
 zqPPKA18ncH/q1HdL3iM745/5zIEP1DwMWmJN2Unsmx0mEGjAxLo+JXNvbhFfvdBFXO/
 Tvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537482; x=1747142282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ry++gvQ3ZjoGDclwTqu4Yt0eg9TEBjs1UwzqzuDBf2s=;
 b=PzxJPv94gTSm+1GQ0M2GdoMeTOPmThKLCTE2LEXrnmE5dD6IGil8HZO2ZH0dKQZK2j
 uGQ7BBMVJjZxgN8QS64rO9HNnQzGwh5uhMpXMlCRAT+PmUawdRmkjvHHtWEN0E2zxj6F
 tIiCwRBwGnAiTP8LBWCM3eHZ+/d8ZI0bnjVvuXwP26m2sniZYOEhR8I8BJqEZ5jLoNR7
 Mk/lq5tNF3cVfGNRRPHk9SigcE/BWMMBi9CKNzlhnrVB/rN5vUHi33GGdxLbOj69/D0p
 1QJFR9eWjqZr2GjxWrVXKQAGC2bjs+MMQUsj59VgDED87DSa9ogpRS2o2oP2s7IAd/z3
 maqg==
X-Gm-Message-State: AOJu0YzKW1Rh2JxEA5c/lThxiY4tSZegSHUC8kwWeJ9gVlf5LOutT1xO
 /72IblVbLsNak7ce8Q0NkF31QEfS7rX3Hpeatub8vAbF1N0yWU030DbsLKuGmvdZn7GgM3vZ6Sb
 o9UR5B+/LSSVRi/yY6zJXYA3Oxir6YNjtHRoyxA==
X-Gm-Gg: ASbGncuaJOixfXkVcLa7ZNIYXtDEK613O5PPdqWnBRz0T2IqjR2B8fvIGHNb0KtLTv3
 WLEAp/ZLv+D8AU9MmJzY5PXx+t4dK3VIU2nFRVH4YK5z4UT/mROPWyyY01e/RDG4X5oA6nmAPMC
 QNX1au5jteoqeOcUg1KIBb2HY=
X-Google-Smtp-Source: AGHT+IHe4xnyaP7V2Da2muPp+sHvr/HuzFLGvN5dFqUMitMsVoUzpxuib+Zn7slfLqdqilsDxV0WNIyszueSrQBHkMY=
X-Received: by 2002:a05:690c:630d:b0:6ff:1d6f:38af with SMTP id
 00721157ae682-709197abf3cmr40581987b3.4.1746537481782; Tue, 06 May 2025
 06:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <20250318130817.119636-14-corvin.koehne@gmail.com>
In-Reply-To: <20250318130817.119636-14-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 14:17:49 +0100
X-Gm-Features: ATxdqUEgJqvj0g1MSL5cr-jD6Fh2bVFPb-pi8FVTpFFgz9-UeVtrlRnISs1Ivug
Message-ID: <CAFEAcA8sEVK5eaQjd-LmHtvf6Foj3ZjH1D0SMPoqQXGJneDCBg@mail.gmail.com>
Subject: Re: [PATCH 13/21] hw/arm/beckhoff_CX7200: Remove second SD controller
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 18 Mar 2025 at 13:11, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The CX7200 has one SD controller connected to address 0xE0101000.
> The controller connected to address 0xE0100000 can be removed.

Hi -- I see Edgar has done some review on the first part
of this patchset, but looking quickly over the second half
I notice that it has quite a few commits like this that
are removing/changing code that was just added in an
earlier patch in the series.

Please don't structure the patchset this way. If the board
has only one SD controller, then send a patchset that puts
in one SD controller, not one that puts in 2 and then
removes 1 of them.

Similarly for most of these other "remove" or "adjust" patches.

(If you want to add a board in a way that breaks it down into
smaller patches for easier review, one way to do this is
that you start with a "skeleton" version of the board with
e.g. just the CPU and one or two devices, and then in
later patches you add more devices. But in this case the
board code looks small enough that that's not necessary.)

thanks
-- PMM

