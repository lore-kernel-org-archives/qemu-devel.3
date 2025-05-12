Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A76C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOm7-0006E7-LC; Mon, 12 May 2025 04:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEOlh-0003s6-39
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:44:13 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEOlf-0001wM-3z
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:44:12 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ff4faf858cso28457537b3.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039450; x=1747644250; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8NMssjOexXhNVoZv01AminjlYv1AX+PT7McAfM6BVIs=;
 b=MuoNaEH0bVSxWIdABrXg7Tx/b2nK1DDgKTnAtkKWH27cedrJd/ZOeL8P77rHZKy0Rz
 slq9RkIfaJarCZWMOnNt6TqCo9eLiXOtru8DPZ1beAaCauH5idRtsUvpYh3wZuFbMpBA
 3MyRftluj/vCtjtuaELHsfFXQS9ejtjcbs/H3B+oUge4kzaacNzxaO3OG4rV02pRDBPf
 1TJoTPeX3bOyxwf8lU9mpIZR3iFpKYmn3caMuaIHiIwMmmaajXUAhyLQ39ncW9hrchas
 WXMOSDyC+IJRjzf62ZzSrr59agXSr2kdqy9yvJkeRr102NvvOd+QzNz/d40OZglOxRcL
 PWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039450; x=1747644250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8NMssjOexXhNVoZv01AminjlYv1AX+PT7McAfM6BVIs=;
 b=RAhF8SL/E1Y0fnhvtTYLkbvEBB21ClDHfauysUzPdGwRakPD/zzeANkVLMpZ88HGYv
 mHFZWem3i5PwPILteiWo1JNFZtdwi3lsfNhql9Kj+IxiqpsfAm1H+bNWlgA2rEjsejBy
 XwsVjNsYi0yWaJpMQy5wakXUq33CSe4AygqLCc9K9nMW+efOwMMup9G1yu3O4IsPbo96
 kBnwXazVNajP43aAwXskTqJEfLDb7X3zJE8OpYelfLbjSvlHIpqgaOcDpSHqbAm4GIvP
 7p6hKZHLO2Jd29h/KjazT3h2xnM2r8/9ayAFxgKIESzb9PfQItdWyfiDHoADvUQ9UCQB
 QlyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIljkOedjvlUEZ91usiAp/BxPogO6ks+e1he/Im+Jlf2ldj/kzC14+dKRQKJJdPHlVuyCZiakR2oDC@nongnu.org
X-Gm-Message-State: AOJu0YwgRfnsyvgrSPG9MFVWJu++e4/vmUmqGgC/yDuz3OH73QuT34hP
 G0NjZX6ht8wFTBrhHHq4GZWRcbcHdLarWeuHRvOjqUly2JiTdhCAKsvItxDXKbwqq1xzmkTjKrn
 Ta12qW4pWOL297Yom57ScXtjclsRlfnzmzdYBzg==
X-Gm-Gg: ASbGncuiK6LkUZaO+YtoNohRlfO5fmYl4l1Z6iuBbCb6nCKh9j4xnB4riOfJ2vWH95R
 4fY1mIpe9eWXFgdFVMKlTBwUBHBtdjyzIdIq2G1lnObW+tlAVC0u1yR5w+Em33FrAoAy9ukB2Zu
 DJiORSwjeqB+NhSBj0xNvtYATn4jK7GTUZ2g==
X-Google-Smtp-Source: AGHT+IGCgEdVc/2DtS1tWBQPzFdYW7hTpP/8dRER3D/g3SK+80odgKMA3fENRsqdHkM4DGBbCOgL0zLaD0CGMPZYFl8=
X-Received: by 2002:a05:690c:608a:b0:709:19f7:d7da with SMTP id
 00721157ae682-70a3f9ec903mr197551317b3.2.1747039449853; Mon, 12 May 2025
 01:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250507091859.2507455-1-timlee660101@gmail.com>
 <CAFEAcA82=0Pp9U=W5EAjcVkR0GL_o1iVPuUPA=w2SFy4mwd_5w@mail.gmail.com>
 <CAFEAcA8qYRa+CHD+z687ATYwOBenrm_c1hg=yvVq-hzRDxMdRA@mail.gmail.com>
 <CAJG6D+g=87TT8qyHvztiLjr83Lm7oTR2qV89Pm4EfQC9zz25RQ@mail.gmail.com>
In-Reply-To: <CAJG6D+g=87TT8qyHvztiLjr83Lm7oTR2qV89Pm4EfQC9zz25RQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 09:43:58 +0100
X-Gm-Features: AX0GCFvi9cu8Qm1NQ_zgOD0c9SKDZqhSr2m-I1m-K3C-gwlcNuoyOo0v69sEWcU
Message-ID: <CAFEAcA9sYkgaGC7L-ydvCUpDtMEpCdWD-YOuf5Gg=A3oMP5TKA@mail.gmail.com>
Subject: Re: [v2] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Tim Lee <timlee660101@gmail.com>
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 12 May 2025 at 02:25, Tim Lee <timlee660101@gmail.com> wrote:
>
> Hi Peter,
> Sorry about that. When I ran this qtest and I found an error then I
> tried to modify npcm_pspi driver to make data register read/write test
> pass.
>
> [R +0.080118] writew 0xf0201002 0x4
> [S +0.080126] OK
> [R +0.080148] readw 0xf0201002
> [S +0.080153] OK 0x0000000000000004
> [R +0.080168] writew 0xf0201000 0x1234
> [S +0.080171] OK
> [R +0.080191] readw 0xf0201000
> [S +0.080194] OK 0x0000000000001234
> [I +0.080445] CLOSED
> ok 3 /aarch64/npcm8xx_pspi/data
> # End of npcm8xx_pspi tests
> # End of aarch64 tests
>
> Here is the change diff of what I modified in npcm_pspi_write_data()
> Should I submit this patch for npcm_pspi driver? I'm not sure if I
> modified it correctly. Thanks for your time.
>
>  static void npcm_pspi_write_data(NPCMPSPIState *s, uint16_t data)
>  {
> -    uint16_t value = 0;
> +    uint16_t data_l, data_h = 0;
>
>      if (FIELD_EX16(s->regs[R_PSPI_CTL1], PSPI_CTL1, MOD)) {
> -        value = ssi_transfer(s->spi, extract16(data, 8, 8)) << 8;
> +        data_h = (extract16(data, 8, 8) << 8);
> +        ssi_transfer(s->spi, data_h);
>      }
> -    value |= ssi_transfer(s->spi, extract16(data, 0, 8));
> -    s->regs[R_PSPI_DATA] = value;
> +    data_l = extract16(data, 0, 8);
> +    ssi_transfer(s->spi, data_l);
> +    s->regs[R_PSPI_DATA] = (data_h | data_l);

If you think there's a bug in the PSPI device then the
best thing is to submit what you think is the fix as
its own patch, with a commit message that details what
the incorrect behaviour is (and why you think it's incorrect,
e.g. with reference to a data sheet). Then the NPCM folks can
review it for whether it's correct or not.

You can send a 2-patch series with the bug fix as patch 1,
followed by the new test case as patch 2.

thanks
-- PMM

