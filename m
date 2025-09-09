Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1276CCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvu8w-0001pa-L9; Tue, 09 Sep 2025 04:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvu8t-0001ot-Ho
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:56:00 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvu8j-0004z9-3A
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:55:59 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-723bc91d7bbso52331897b3.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757408141; x=1758012941; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dc4sSOb7vrpzCcCQrCsaWuTjd3SmxmNMXfvOTkoAsrs=;
 b=puxXtsKnrPtGzpCt/GYyXwtjSpGhYyATh8H0SSmQEY7Fp0KJ6oKSWLrX4htySRxjLG
 wDb9E7pNLpPv9ygVKdsx/Z/ItXue2fkSRHxg4bUf4GJHgAsRsL0NghiIoXDJBZiUN/Tj
 ZL3DsKAZ8KH2qc6ZL+XnRJ7h4kHcIeBWe+Y2Ij7ZMFlEeuWAvNyKJbBY+WoZvoPtasiw
 mDSj/A12SQY9I916rT3eBTsBV4giS0gXq3nVoGVD7nzzlPYjxIbjHEpW4RcaR3SE8H4P
 6NWXhRZTTl0+QXfKMZDMTamBoNO4oV1QlSejp/ETNcIGAAmKOW6X5WQyB8bQ5WfIvwXt
 9lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757408141; x=1758012941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dc4sSOb7vrpzCcCQrCsaWuTjd3SmxmNMXfvOTkoAsrs=;
 b=wC904P6+zp/isKNTho3dOKlsVi/Wkn56eUGMmJ9faagCLJAckLV063x+JQgprygB+u
 LRkuAljwGsxq+v/YohCHlW0dJCYuImxcqV4z+GnUCzRTTXwT3DSneMz9q2boBnghxUJb
 0nLfn7pCDT8r2y5uwjFi1kal64+pQNa+J4njIbuL67pmMB0WVPQ7A5S2FzIz1yMJ52kc
 aB5F+f8ayi6UzwLecKbEEvox20+f6d94iQCTQp7hL7/96SGHfHLGdc5hk8Zd6U9RFnNq
 siN7heKKaBO7ZU3o7qrq6w6lE4uU9zX+OxdT8ZBhETjaEn5kgEhiqqXqjni0Btd+Dxx5
 LFnA==
X-Gm-Message-State: AOJu0YwJQiN1StkSN42ytUhUSPqqfYWDk26fRpoWUVPRmOfj5mfuZA7t
 jIf4MTUXF7QH1sFeGh/xJsnluJaYrov1yekUluzKKy9t5Z3w3BkArfU3HF88qlvpSfMpp0NkRD/
 haw3VjnIxZUCdtOyyaVhbuGP3D3IJwPnGX+Th4WFa2Q==
X-Gm-Gg: ASbGncuculRuVHfvFtONvHpzOI5wllp7Y0wJ3bPF1f1uv19NasSgzdJ048qL00ze8pZ
 aYHBYmks2fSpZ7f/2YjEo1B4YYdM2KD+s1IxI4tLp9lyMeubDUx8tgXfbV9OaGo6WW35YBw1Hg0
 J6t7zoxM9EsTow1AxlrnTAqbkJuAe6CmkWuCtrV+sZR4pQjcQmlzlpUXhkeGhPAjQQiA87arLQa
 40wDRJIU9DLcPKsKX0=
X-Google-Smtp-Source: AGHT+IGBjL8QbBon3yTNa8Rll2YkRy2gjLOs39JJGGxIshRWWxGbKtdgqvHFa5kbwIcYk6FRCEJ9Mox24h6d/+3ZOm0=
X-Received: by 2002:a05:690c:9207:b0:729:df2d:4a40 with SMTP id
 00721157ae682-729df3c9f38mr59173837b3.23.1757408141474; Tue, 09 Sep 2025
 01:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
 <20250826184504.510279-4-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9_wXKT6zfpCSty2bRjVpCSyzLcdfWuJofJEZcZuqRgYQ@mail.gmail.com>
 <CAEWVDmttumhB+kx7RExyTV1vUoUCY=ED_qbj=7tbBx0hDPeqUg@mail.gmail.com>
In-Reply-To: <CAEWVDmttumhB+kx7RExyTV1vUoUCY=ED_qbj=7tbBx0hDPeqUg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Sep 2025 09:55:30 +0100
X-Gm-Features: Ac12FXwmpNyVmoOBAbe936vRsmKWAmALsK9o18rJ2s2UpGj-0uv8EiMUmCnUSTw
Message-ID: <CAFEAcA8Qnv+_=-MeNuHuZm3DuAK7A-DqYo0GsArQCk62GF0jEQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] target/arm: Added test case for SME register
 exposure to GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 8 Sept 2025 at 19:32, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:

> >So the only difference between these two branches is that we are
> >checking "int(v) == MAGIC" rather than "v == MAGIC" ?
>
>
>
> >Is this a "one GDB only works one way, and the other GDB only
> >works the other way" case? Or is there a real interesting thing
> >we'd like to test involving the cast ?

> Yes, the only difference between the two branches is the presence
> of the int cast. This seems to be an issue limited to specific versions
>
> of gdb. This has been discussed with the gdb team
> (https://sourceware.org/pipermail/gdb/2025-August/051868.html,
> https://sourceware.org/pipermail/gdb/2025-August/051878.html) and
> a bug has been filed. With additional tests I have found that the
> int cast causes no issues with the testcase when running gdb16.1
> or newer. Other than this issue there is no intention on our end
> of testing anything interesting regarding casting as the int cast
> was included to stay aligned with the existing SVE test.

So if we can test QEMU's gdbstub functionality by writing
the test in a way that avoids the int cast and which doesn't
lose coverage, we should just do that. That would mean
we don't need to have checks for whether the gdb can do
the cast and multiple paths through the test code.

-- PMM

