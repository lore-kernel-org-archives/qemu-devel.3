Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEFEC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricqc-0006aU-BI; Fri, 08 Mar 2024 11:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricqT-0006WU-4a
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:13:17 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricqE-0008SM-8k
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:13:16 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso2557509a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709914379; x=1710519179; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ2bIR4RWpERTXGbwtYOeF30BF1NZkRmzn7glZuOhFo=;
 b=uixS1/Vf/BmPI7y/+qCaXqPKvS/baxN/oZ9fnZHF/GQb6PILtxWsul25BMUnhCuR9z
 /XaQ1IT3sun4NwrwjBTP7f6UsfxZvXUVbeRfIP7xa81VYRui8l2PnVShQ2UQJIlYcE8/
 Bwj06FV9CoKaX2FXH1VSCHmGP2IGGH06ixR4hg4dXp/FSXaX2qgjmLTz85bvrtrGKqcM
 hzinvxQZDsv2kfq73HgSOe5LNY9TN6PHjLsGUU64EFmorN8j/FsDHQ/Zy0IXidwGCRIo
 k3lxtGgyio5xiuyATQEISRU+FHUq2RjpKR+0s2AAFYMjk/1AU38ovvAPyQXDhaPFraB9
 PWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709914379; x=1710519179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJ2bIR4RWpERTXGbwtYOeF30BF1NZkRmzn7glZuOhFo=;
 b=UgW3JABJl7FRHrRyUAHb5AiTLCxgpF1Er5alyD+Uy4nCTQ1ira3H1iokgjTYDzgeNM
 OgBDXAhqXXHUCCrJd/nAlUdXvG2yhD4BWcXbTo6XardjIMcRXnllow5ITIODxPqdYjCX
 xvbj/x9O577B3ly8FXrMTW/lH42qSNc6zeY4M6DsRnKVSJ/+5+UnajbffyGbNlnD5z4x
 LtUBLviZzS9KilguJhT8Gfi7EZfvUqPOT4rf4tazxs+RdsIRAIhS0tDlz/9cG8FkRau7
 me70Odo0CQEpXHOLk+/xZ2qHNe2Zrra75iYzJTQHNopNSCSPTtmB3k6FhHhCiMajzbx6
 hj3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2dFCrgosD3T68gTfmXRXDKfIcZDY/tNS8D38MgJg4WwuHsUrQYwQ13RxoqttpxDZjwaHs+yj1mdQPC251GVtTCnq+ULM=
X-Gm-Message-State: AOJu0Yxh25QXTBzcF44BDGxy18P40Nu2kMWMXUp34U5JlLPEHyq38chy
 UziJQjsb0CeSrC1ScLt0uSbYkgvVVX8CqlhfIcJ6CgqdqONUvXJvHZSYj+FGxy7ECy1fKjn5/OW
 VRVPFMDiOiXmxnZtOGOqK3i+f3T619fqZceq+iw==
X-Google-Smtp-Source: AGHT+IHGVIIYsZBHfw144013TzjqrPZM03f8G8skRME3zGJTho828PLAGLWnUr/vdTCyCjAUKXK1hkx535hXXvhboOM=
X-Received: by 2002:a50:8e46:0:b0:566:2aff:2d38 with SMTP id
 6-20020a508e46000000b005662aff2d38mr2361637edx.26.1709914379606; Fri, 08 Mar
 2024 08:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20240226164913.94077-1-philmd@linaro.org>
 <20240226164913.94077-5-philmd@linaro.org>
 <Zd9iz9aIwM3cOqwt@intel.com> <5a42a295-bb1e-49f6-ae1d-94aec1efb61c@redhat.com>
 <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
 <52e08f6c-7698-4649-9bea-fd537f59fa2f@redhat.com>
In-Reply-To: <52e08f6c-7698-4649-9bea-fd537f59fa2f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 16:12:48 +0000
Message-ID: <CAFEAcA8V0hrD_-tJHV2Ph8tXFfiAwudrn=X6TO4+0XDuaTeGrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9
 chipset
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 8 Mar 2024 at 16:06, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/03/2024 09.08, Philippe Mathieu-Daud=C3=A9 wrote:
> > This form isn't recommended as it confuses static analyzers,
> > considering ICH9_VIRT_SMI_COUNT as part of the enum.
>
> Never heard of that before. We're using it all over the place, e.g.:
>
> typedef enum {
>      THROTTLE_BPS_TOTAL,
>      THROTTLE_BPS_READ,
>      THROTTLE_BPS_WRITE,
>      THROTTLE_OPS_TOTAL,
>      THROTTLE_OPS_READ,
>      THROTTLE_OPS_WRITE,
>      BUCKETS_COUNT,
> } BucketType;
>
> ... and even in our generated QAPI code, e.g.:
>
> typedef enum QCryptoHashAlgorithm {
>      QCRYPTO_HASH_ALG_MD5,
>      QCRYPTO_HASH_ALG_SHA1,
>      QCRYPTO_HASH_ALG_SHA224,
>      QCRYPTO_HASH_ALG_SHA256,
>      QCRYPTO_HASH_ALG_SHA384,
>      QCRYPTO_HASH_ALG_SHA512,
>      QCRYPTO_HASH_ALG_RIPEMD160,
>      QCRYPTO_HASH_ALG__MAX,
> } QCryptoHashAlgorithm;
>
> Where did you see here a problem with static analyzers?

Coverity tends to dislike this pattern if the enum is used
as an index into an array; for example commit b12635ff08ab2
("migration: fix coverity migrate_mode finding") is
essentially a workaround for the way the QAPI generated code
puts the MAX value inside the enum. Coverity assumes that
if you have a variable foo which is a SomeEnum then it can take
any of the valid values of the enum, so if you use foo
as an index into an array that was defined as
array[SOME_ENUM_MAX] where SOME_ENUM_MAX is a value of the
enum type, and you don't explicitly check that foo
is not SOME_ENUM_MAX, then it is an overrun.

thanks
-- PMM

