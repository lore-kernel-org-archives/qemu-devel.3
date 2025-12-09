Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2F5D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzJL-0004b1-6D; Tue, 09 Dec 2025 10:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vSzJG-0004aF-Sw
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:07:27 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vSzJA-0004fH-Qc
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:07:24 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-787c9f90eccso56507617b3.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292838; x=1765897638; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MAa12+YAKfOdRNkkdVjiVUhECOX7C/drD2Yci6N+mU=;
 b=NF6nZKOOs+ebat14M2BPjVgiezAx1+gs3rxAu9A0xRTDcP58jacC2v8O2VlqjjyXDh
 onWAht1XYFPYUlRfplFAC7lSKS1IcGRFM7RYQ7vV3GEihyqFurYFL+DyvgyFAJ2aJkvT
 mcs5CxOuTMz+txelXnG0cW0T/bDTI+r5sLvIWCNvS9RSJQWd/FmUtm+S2s+6Tvp1iZVt
 IMlzDpyDI22WS5IHoNuw0qhPNJvoaTMuMI0l5NnratWmOGgzsA68Qlcx5atokXh60P4d
 +OTJUT4s9x/AIfTIxRPJACN41JYAtmdCeqUnj6bOGSsbOC54i8ixPK7ZD697oSBvqkVY
 lK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292838; x=1765897638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/MAa12+YAKfOdRNkkdVjiVUhECOX7C/drD2Yci6N+mU=;
 b=Gl+OZE298zRd/4qByNTOkhOsjdRs3D6eaj5d1UwzmB0CbY6k56UznKgy+jy9C7Vqb3
 3vtYsd0c/DUxzJ6XpgP0NOWVgs49ItCRv+Aqao5+EszABZBmq4Lu0JnIwQdVwn3Plrzf
 AsxYm66howf6s2vyICLhJ+DMtvd4YAMrS9l0QxsOrKOnB8LANFtsOK1jYkXCJJbP02YN
 slmSdbOYAQBOwkqYehIGsTZEQ2K3/1fA0zK02KzrCFQeckyrJruYaFc9vBobxDoZFZcv
 SFxlrYcrrUzkXnXvmLwxeC2HfzX2SEdxp18UQgWAGt80Ez1/a2c4zCAjtZR3zm2OjtUB
 owaw==
X-Gm-Message-State: AOJu0Ywh7dVHezcTvdCyZ0oYjPc1Qle6l3Z14wewBROZQ5m1Y2dNfXSF
 rTs2fWU5A7JSWHMl3l1d62Cf88OmtDhTgW7+ElIip7m6JL28Q19bOdaRPyr8myZ5u11/7Xqh1Ov
 15eTLOFSCJLfmcdd7tSOv+A2caYMHikMLF4PY/St2aA==
X-Gm-Gg: AY/fxX547f/cA8t4cDfuaoqI1PcmBBwT14lrCX5ApOFV4b2mhRohR2KZgXGGwSdpMRW
 vlWtcxhSu5/fK2DDJCiS9NjmnZwitaaNwq+fKEdHECPyQl4blJoEZSxHQ9mT4AuuFw/Q0Qwsz+M
 dqY1StuIwzhAfiFsOL/G17DQ2CdjhBVagDpClSrQznhUbEEAt+gGW4L+h2pdlR8QhzkEghQL+Vj
 IRC5RTF7Hcs56Gmip2V4/Im5vLGB7D/kHEWTXm8bwES774jfsu5nehu1MXJ9dwulEPpuBjs
X-Google-Smtp-Source: AGHT+IHH/KzmTJU0vmFEAjY+YWQuUkIk5epBNSQYe9tUlexeDS4JQ2Qm2olnqHhxXc5bi052Yds7dwIO/y83Q5mEMvA=
X-Received: by 2002:a53:d056:0:10b0:63e:2b26:a8ad with SMTP id
 956f58d0204a3-6444e7b618dmr8417620d50.38.1765292835789; Tue, 09 Dec 2025
 07:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20251209150346.650473-1-clg@redhat.com>
In-Reply-To: <20251209150346.650473-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Dec 2025 15:07:04 +0000
X-Gm-Features: AQt7F2pBMlNAD0O-GKn3SnSt84zU_L8M9gOPXjjf4gDZhH6u9frVbQvhN0BHALE
Message-ID: <CAFEAcA_q9LJAWu5wL4AosoHJqVLpnU6PDmJPj4U3Zfy1jh1F7w@mail.gmail.com>
Subject: Re: [PATCH] log: Fix result of strstr to 'const char *'
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
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

On Tue, 9 Dec 2025 at 15:04, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> Assigning the result of strstr() to a 'char *' is unsafe since
> strstr() returns a pointer into the original string which is a
> read-only 'const char *' string. Newer compilers

Which ones? Or does this depend on how the libc headers have
marked up the strstr() prototype?

> now complain when the
> result of strstr() is not a 'const char *' :
>
> ../util/log.c:208:24: error: initialization discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>   208 |         char *pidstr =3D strstr(filename, "%");
>       |                        ^~~~~~
>
> Fix that.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  util/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/log.c b/util/log.c
> index 41f78ce86b2522b8b7072c8b76d8e18603142db6..c44d66b5ce78338cf1b2cd26b=
7503cb94d4570cb 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -203,7 +203,7 @@ static ValidFilenameTemplateResult
>  valid_filename_template(const char *filename, bool per_thread, Error **e=
rrp)
>  {
>      if (filename) {
> -        char *pidstr =3D strstr(filename, "%");
> +        const char *pidstr =3D strstr(filename, "%");
>
>          if (pidstr) {
>              /* We only accept one %d, no other format strings */
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

