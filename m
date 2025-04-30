Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70857C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAtV-0006yR-Ri; Wed, 30 Apr 2025 13:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uAAsw-0006np-Gq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:06:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uAAsu-0003qC-My
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:06:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so2721766b.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032770; x=1746637570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGJqPWAgUgY3KYiwBgFHReQCMU5aKRm6uD+kR5TJMYo=;
 b=IvvG/XSeCfitGCE3vHVabCtfp1OX84/ZfyEkBXn2ErTDGN9evnthazNNfpWAmg7lTZ
 XFinvoKj851m7g45KBeE4yUWqGG+LvqNs/THSuCWLAO8L7zbf+kYgXH5KvLP5A4RB64W
 n0THow/z2ZF9/alAVBfNZXMz3YZY3TTHCL7qUSa12xmruzuCPOlqrmanvJGFV601H/Bj
 1MhsxzMSWmN3Lquf1iO1ziVYSJq6c5gRqiPXVgt9MxAPma7vND4uCdzKlA4LHCRVpwqr
 Irhjht7OYLtVnlreRmHw28WRz/aotrlpAoV298X9nCkyG1DfZXcOMPiMkCExjMmg8arY
 hBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032770; x=1746637570;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KGJqPWAgUgY3KYiwBgFHReQCMU5aKRm6uD+kR5TJMYo=;
 b=m3erHzzzVup9BqG7EGyW0OnA/MUptpZ9Mj6utpaM71xUBLWp4ynlfCjGGwNxHwKKy4
 r+SnRs/PLkuz7wsyPDWayIZzdzc3RSeqF1MCYllT88JXrtoZEMeRyUh/QMgxaeJVB9VK
 jUmeDJOFcKBfQPJQXcXOEV+7Uo+OysywHODDBo/oIGf5+o5AiQ3juTsJFTzn77ffVTZ4
 at7ZQQB5+d0Kcrp52sSK12QmUsKW5xX5Yac1WaZNL7bXHRih1Q8vH/RPSSOBBrTaG2sn
 Y1AbZlJCXWFN9Vv8NiByvMUoQW+uXJa1TuM2+FFQpTBGCq8rYIdV11xtTlDoCNZ5sBCT
 s9Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN8ymYl/eXAxFYFmz/lG6Yhs7e3QKPhr+ad6ISvNI8DkN0WnLH4FXNTL17MVdWb+eZ+Rr5XtgEBSn3@nongnu.org
X-Gm-Message-State: AOJu0YyluQv00faXfe6sgjQ/FCCN9LA0mXQb46S8x0CrPMSH8itdSvmS
 Lbmfv9Y8TfeY/K9CK6TDc1gu2Y3vC9wjUvHFGvArlHbYS86P3lc7mW90YXCPkBE=
X-Gm-Gg: ASbGncssB3+TFuYv9W0X95vY4rGfdtPVHIfNwQwnsuHa7hTBEIJydsNZ46ozr502S8P
 TFfh3pZ9pT4uHaeEddAmRRtXuIE9UnNgxSMilq8uSKywXTVZ8vl73i5G2Phmnm73Z9m+8iWJPS6
 IU3c/HrQ/aqkvO5P2/9k2q2osOXatHVzU5iLRcyWzLFaT+4u6jli9bf8E4P42Z0x/TmKJW2tB//
 ZwICQ52o+qj8CWtzrUu7UwUHBPJhMUQewQWoRjaF70jgpSc+UEXTXAxtC5ruMxv/h5qmwyKwu8B
 k1xlnUP5jgW3c37ztTKS61d8eZGfPVd00gjNOxXiOn0=
X-Google-Smtp-Source: AGHT+IE22pD1cAglNhpfjhZw6bB/769TtHHIzfurksbFemdKEcsjKsuKlPcD5KywiUCj9KHpbzXN8Q==
X-Received: by 2002:a17:906:ef0a:b0:ac1:e6bd:a568 with SMTP id
 a640c23a62f3a-acee25c84acmr318872666b.37.1746032769981; 
 Wed, 30 Apr 2025 10:06:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41cb08sm961551466b.19.2025.04.30.10.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:06:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B25B75F8BB;
 Wed, 30 Apr 2025 18:06:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 pbonzini@redhat.com,  lvivier@redhat.com,  farosas@suse.de,
 sriram.yagnaraman@ericsson.com,  akihiko.odaki@daynix.com
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
In-Reply-To: <CA+QoejXO3dJu-ifwaN1t9rK=M5RRBs9xaptE=ik6naz-3oMncQ@mail.gmail.com>
 (Nabih Estefan's message of "Wed, 30 Apr 2025 09:48:36 -0700")
References: <20250429155621.2028198-1-nabihestefan@google.com>
 <CAFEAcA-K0B0gfpmG5x92o43aCNp-q3ocrgfvRG+7gN-NfgybJw@mail.gmail.com>
 <CA+QoejXO3dJu-ifwaN1t9rK=M5RRBs9xaptE=ik6naz-3oMncQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 30 Apr 2025 18:06:08 +0100
Message-ID: <87jz711svz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Nabih Estefan <nabihestefan@google.com> writes:

> On Wed, Apr 30, 2025 at 5:03=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Tue, 29 Apr 2025 at 16:56, Nabih Estefan <nabihestefan@google.com> wr=
ote:
>> >
>> > v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
>> > suggestion.
>> >
>> > ```
>> > ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned a=
ddress 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
>> > ```
>> > Instead of straight casting the uint8_t array, we use memcpy to assure
>> > alignment is correct against uint32_t and uint16_t.
>> >
>> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
>> > ---
>> >  tests/qtest/libqos/igb.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
>> > index f40c4ec4cd..2e0bb58617 100644
>> > --- a/tests/qtest/libqos/igb.c
>> > +++ b/tests/qtest/libqos/igb.c
>> > @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>> >      e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>> >      e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
>> >      e1000e_macreg_write(&d->e1000e, E1000_RA,
>> > -                        le32_to_cpu(*(uint32_t *)address));
>> > +                        ldl_le_p((uint32_t *)address));
>> >      e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>> >                          E1000_RAH_AV | E1000_RAH_POOL_1 |
>> > -                        le16_to_cpu(*(uint16_t *)(address + 4)));
>> > +                        lduw_le_p((uint16_t *)(address + 4)));
>>
>> ldl_le_p() etc take a 'void *' -- the casts here should not be
>> necessary.
>
> Should I send a new patch to fix this if it's already been queued to
> testing/next?
> Or can it be fixed directly in that branch?

I'll fix it up, I've taken notes when I re-base.

>
> Thanks,
> Nabih
>
>>
>> thanks
>> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

