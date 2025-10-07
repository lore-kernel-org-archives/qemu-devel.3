Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EF2CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v696W-0003d9-Ry; Tue, 07 Oct 2025 10:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v696M-0003bK-50
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:55:42 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v696G-0007pH-4Z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:55:41 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d60501806so70926177b3.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759848931; x=1760453731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY2nbnHJE6bl70lDJ+Fb3n5xMaDjXClO3aHqDyQdols=;
 b=ktBhyrwIETacIfr3VdEtMp8gZf0SVLpCIZBHfa/yREgIC7Q+j/9fLhcvEmHUFxcekU
 HnXxV0wYGAoZx4Jq+6yhSFKFz/yet7ZL3t/ZuE0lZXKHoDFShQjncuyMENGj8RmpDMin
 KEYY8YwbzQtsJWHfrEU1iQo6Sr5yiYgIPI8sTS8hLgpJtb8yj8BzBFrD2APDCZonBuX8
 LWfCB/nVrrqaiPWbv2UrtDecxjJE34lP+PYNL5mFIFYvozmrmIhLBBDuJXYgvvFbqHXL
 yYq/8MaH/IyPepuSePbML8EV8W1Hj/1PLSNsyu4f7Ef6rvKBltBw2q1M3k8Z8feWx+Eu
 DIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759848931; x=1760453731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY2nbnHJE6bl70lDJ+Fb3n5xMaDjXClO3aHqDyQdols=;
 b=FW1wwxOfzYXtdDt11uZJADzXA4ZyaoRmiLg/WA3Nm6hr9nTtptgBwlW1Pov94BCU61
 O6M2qTW9G5XBLbQ64nzFe45mtubs2Q7oOtATqKeJXS801aYwe01bl2bXS3MNf2bY3Az2
 cuYqF8j0YgFmsee8Iv89ak0LZh34kNYyOQU1TJZ2KGIapkMuz8sbaeF4Ke9sXReJX1rO
 JBJY44q9aeYPGeqmhaCvaWmdL6G8mJbzkbqAtDHxlfeysuR4rQuEShAZbXh528LeONW/
 hfoNTV0+oWj7JMBX4kh+n7sqGyc9Q5n04Jt1pPCgMm8MA6Rzuw6iHrAGrS5l8mY18OZa
 UgRQ==
X-Gm-Message-State: AOJu0Yz35aFSoEIh2fp1r2xWo45dG+yAJw0RmYuP4Spsr2k/Ll/xnWSz
 qZI+kSpt+KYL02Ei5jmwu5it769HtZaGlf/zNkpf7U+mCMQqwCwwZZzbu4nCy+dnOz0lmb8ONHY
 Nmtyn/0SC9okMHzYBRrX/Ap6wq+BTxjmpjpUW1z1j0Q==
X-Gm-Gg: ASbGnct3aowVGfC2kVxKfqYc2HVjq4njQDoKiASZEU6Y3MCEtwjk15vMaQJhIsRUKzY
 opCsrcWxjQyasCNbtlKUHJdvi4mEMWtao+DmVSpDWeTGfJbE4fBiVJlFjDlO2+5gs6Fn1gctThK
 A5g4iCHTkvtBr6lT0MCF0QeKFJsPN7YYyO3Y7A54Ax2w6RZqRkTYJqS/E27fHEPJV4I4QH7Jv1j
 AFgg/3bTW5ndSOOULDgtFk/sy5bcgT0cfDu
X-Google-Smtp-Source: AGHT+IG/3oGa0JxS06IX9cKcaG8WG+sawfFu8rnOm6YtNrWDiW9Tnnn8FfftNo2kiN7/edZRd8nvXIA0BwcYKngu/+U=
X-Received: by 2002:a05:690e:d1:b0:636:d3c3:67de with SMTP id
 956f58d0204a3-63b9a0e21d3mr13854927d50.34.1759848930651; Tue, 07 Oct 2025
 07:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251007024006.43166-1-philmd@linaro.org>
 <CAFEAcA_ytH+AwTr9LAZBP2nbSTod0FkfuexbewW=T7Pbb3nkmw@mail.gmail.com>
 <66dbc389-4c83-4552-b447-87c0e1ada48a@linaro.org>
 <a7e21714-e19f-4465-96f1-dc27bd484cdf@linaro.org>
In-Reply-To: <a7e21714-e19f-4465-96f1-dc27bd484cdf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 15:55:18 +0100
X-Gm-Features: AS18NWAPGJPiMkEnxgtVXXbESzSvaeNPmvwtz-paduSD8-kjo_WpUSFbxn8GODg
Message-ID: <CAFEAcA_TWXGCSE4y6wgQJosDBGGvWF6wGr=8Br3ivdQx+MxOig@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/max78000_gcr: Do not ignore address_space_write()
 errors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Jackson Donaldson <jcksn@duck.com>, Jackson Donaldson <jackson88044@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 7 Oct 2025 at 15:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 7/10/25 15:48, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 7/10/25 10:27, Peter Maydell wrote:
> >> On Tue, 7 Oct 2025 at 03:40, Philippe Mathieu-Daud=C3=A9
> >> <philmd@linaro.org> wrote:
> >>>
> >>> Convert max78000_gcr_ops[] to take MemTxAttrs and return MemTxResult,
> >>> allowing the write() path to return error on failure.
> >>
> >> *Should* it return a MEMTX error on this failure, though?
> >> This is a question of what the hardware behaviour is,
> >> and there's no reference to the datasheet in this
> >> commit message...
> >
> > Right. Thanks!
>
> Looking at "MAX78000 User Guide (UG7456; Rev 1; 3/2024)",
> chapter "4.7.2 RAM Zeroization" and table "4-67: Memory
> Zeroize Control Register", IIUC failure can not happen.
>
> Would that change be OK?
>
> -      address_space_write(&s->sram_as, SYSRAM0_START,
> -                          MEMTXATTRS_UNSPECIFIED, zero, 0x8000);
> +      /* RAM Zeroization can not fail */
> +      (void)address_space_write(&s->sram_as, SYSRAM0_START,
> +                                MEMTXATTRS_UNSPECIFIED, zero, 0x8000);

We don't generally use the void cast like that. Just
don't do anything with the return value.

-- PMM

