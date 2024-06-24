Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFC2C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkGI-0001XY-I9; Mon, 24 Jun 2024 10:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLkGE-0001WK-9T
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:01:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLkGC-0007PL-9D
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:01:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d07464aa9so4064381a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719237688; x=1719842488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsEaTKpu47SdPW+RydyV2ylH3pJT/VZC8Bxke+9Lm0g=;
 b=WqIdt4/J1bMTj9Zon6fEHcTURTCi08f8lFLNdEf/PJeQHPeBZ3l/b8EvWjsGSbGTPE
 TuDwWjry2sdRO1wfv3PxEtKJLlvGbe7sZBmNTCH2rJBxPXUqtc6FZEiBLbz3irKxPOA0
 0rhnH/c6EDpl4f3QsuBFr7vbOzzXVHbz0musKSEhp3/d5tOnkWLh/okPIZVth+WZki36
 5d/wbL0Urb4rxAFFusewNpm7XgNsFIT1RntzRxeHYvzr8D1skrGXJdUH1ObJ92cT8pcb
 k7S2urD0XSLgLU4rry0zc7MIfCIKpiyGGc0LN73/A5er7gOODDgLmyQbcfEaxeeUzj0b
 iy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719237688; x=1719842488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsEaTKpu47SdPW+RydyV2ylH3pJT/VZC8Bxke+9Lm0g=;
 b=e6Kk5KAJFS91zCX0nWY8S9Yv8sQchnMu9lgYpKR/UxejFzIjfXhEwUg3obBSn7Eoxr
 txwxq2yUGNxaTR8D0cFuyn9E2wDrwhfX63dStmoQdMvkFbNxxkQrdewteKArH6ppnPdJ
 cHwBE0OiZb6hhM7ij9Clpein6mxEvmO2TIfvHVwZ8UsZ09XEVpHmBUxqIqqHkQtcJ6z5
 Z0/bwqYl9iN87hS2pYQsQMcgEFneDUt48P4ZTF/CwzMCqstc36iDh37WPI5U5YigsxXH
 vRFsfw8maqtywX4f5PtR+DhfE0zEZaWPCDMgXvvVCRn++Kio/Flt2Juuz2nDt9hcb2ld
 ArTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYV1lz2Tbn861JyCbMBo5CrUo1HnIB6ToyuNwNV4shEJswsOpMRs5Iv6U320N125wvoPkkuK9C21DgMSHWMLHa/NGiOMU=
X-Gm-Message-State: AOJu0YyjZCr26RZpZlMcMGjE+y3MnEa5xH/Rmb2x9J2Hy0zPEqOKNU6K
 ++YqgwT4Ka0hYwfjEjBHTozAoLMQxSHBlEqLnqDtF0fRW8FxGn6xyzfBkdZyt/94lJCYFRVCIZ4
 /2X3pXT8wOLcsRPQO8qarwQN9Hyp8LqxVJBKYNQ==
X-Google-Smtp-Source: AGHT+IEKD0JKkYkbDwW8Ki7ihme4CPqBUHu082NSXAvWZ/FxkBx1QS6po3C3C6VfptO0uqZni9KRhg4Ha2PQyzSxGUY=
X-Received: by 2002:a50:f604:0:b0:57c:aac9:cd8 with SMTP id
 4fb4d7f45d1cf-57d4bd5648amr2949038a12.8.1719237687896; Mon, 24 Jun 2024
 07:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240619093508.2528537-1-jamin_lin@aspeedtech.com>
 <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
 <CAFEAcA8tTHusKOR7JhyU+wwA3JJWq1o5wVaNXugw2S9SjAsESw@mail.gmail.com>
 <b013bd79-c206-446e-b482-91eeb926c70a@kaod.org>
In-Reply-To: <b013bd79-c206-446e-b482-91eeb926c70a@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 15:01:16 +0100
Message-ID: <CAFEAcA_fWTUpfRvYjDDXnXBoFuiZZubzVaKDbgKpmsDr98uXtw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] aspeed/soc: fix coverity issue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 24 Jun 2024 at 14:58, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 6/24/24 2:18 PM, Peter Maydell wrote:
> > On Wed, 19 Jun 2024 at 10:35, Jamin Lin <jamin_lin@aspeedtech.com> wrot=
e:
> >>
> >> Fix coverity defect: DIVIDE_BY_ZERO.
> >>
> >> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> >> ---
> >>   hw/arm/aspeed_ast27x0.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> >> index b6876b4862..d14a46df6f 100644
> >> --- a/hw/arm/aspeed_ast27x0.c
> >> +++ b/hw/arm/aspeed_ast27x0.c
> >> @@ -211,6 +211,12 @@ static void aspeed_ram_capacity_write(void *opaqu=
e, hwaddr addr, uint64_t data,
> >>       ram_size =3D object_property_get_uint(OBJECT(&s->sdmc), "ram-siz=
e",
> >>                                           &error_abort);
> >>
> >> +    if (!ram_size) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR,
> >> +                      "%s: ram_size is zero",  __func__);
> >> +        return;
> >> +    }
> >> +
> >
> > Isn't this a QEMU bug rather than a guest error? The
> > RAM size presumably should never be zero unless the board
> > set the ram-size property on the SDMC incorrectly. So the
> > SDMC device should check (and return an error from its realize
> > method) that the ram-size property is valid,
>
> That's the case in aspeed_sdmc_set_ram_size() which is called from
> the aspeed machine init routine when the ram size is set.

True, but if the property is never set at all then the
struct field will be left at whatever value it had, which
is 0, I think. So if that's not valid then it either needs
to be a different default or else the realize method should
complain that the property was never set.

thanks
-- PMM

