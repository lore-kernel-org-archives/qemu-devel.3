Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53F7CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw9A-0003Jh-L4; Thu, 23 Oct 2025 10:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBw98-0003I9-2m
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:18:30 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBw95-0007st-0h
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:18:29 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78488cdc20aso10967267b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229105; x=1761833905; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILb6a6dquYwm4ywy49WY48dEBgbB4ZDhcXdzJecZtIA=;
 b=lUyk59dLmLLD+kkCwXS4sYApgDohef5xSUFf+tUhOLXIZUXHs/WprT9z3Z48YI8vWD
 cTuz53Tpjfymv09JBIl+L/8BIYHorEcYzNCl6H/LvBFHpyoKYfZXazucAOAtua6fz4Kd
 QWSzbPfGTnEZ2gaPy0egF2er+cQeW2GKI04s6xX6P9N95xhkJQpnZvo7/HMGjkX85G8/
 IX0y7i/YWXr6ZJxiO5sQYA8Qo3aHZS3sSdMOLP5AMFvCcMLXNIBcl7SMmionLzJCvVZI
 cUHpWCFb2RgIHU2rEvzf+q0VUFhOybNmy8Hz+ZlQDcEiWxV46OnwqGMJfPn6E9QKVdgZ
 wd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229105; x=1761833905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILb6a6dquYwm4ywy49WY48dEBgbB4ZDhcXdzJecZtIA=;
 b=QPgRLvOTrgFLpuLE+A3Rq50Iv6GeEQqejSolQA7I2AtqwBZ4tHJ+OHoKYTyUKlHVuh
 MVJgLxLUQts1YNkFvf954A7TkYdPzGiKWPvoHiDEzP8g1dBTVO8TpBBCcRIzSibYtu3F
 HEuhC1XZibRC/zj7ru8E+HDGBFcipx1QfYkY3MNwp99C0H0gg/EL75F3OOHUcgJ09ntM
 MhSaiiVFhRJtyJqeb0+IfGgIT/UmN4Jybdo+1xOTC/bce1FHjRalzyQgWxtQc9PdTrJf
 0A4DvSg2NLgIFbcQa2+bXsLreCbY4D1g2qgYALZpuL60lSi/RJDFSxQnr9e0d1ay/73O
 lCxA==
X-Gm-Message-State: AOJu0YzuV9r2l2EDPfY7DTnJ27SHbJlwVkAloxCEDHjrMPmkLQqEg00C
 KIUXzoFooS98eSugLYkIYURtBatnYGGmLiEHtcwEw3W0W4/iAW2/6mY6bx+TxO9bSqKL88THC2T
 WdMw9jHsnqTvBcihptCOMxQeCH0gm/J5Sg5e1ncTncQ==
X-Gm-Gg: ASbGncsAJSMrlRoYhPIRNEvh/hhvk8Nadt180u9BFC0C05IfcrN7nw2udilksKwdtFa
 1txPFP1krm2UvK6BTAcJkmW4EP69smu0Fl0oWwIswyf1zZrI6NcqRUZRryfVoSUTSkQqaLa0R97
 u4N1YppKrMs6/rWw1wo3ZpLUY9qCO90z5cq2wei9c6NEin2kUvsUWgn9PpQmCcDsx4EZKZIt2zB
 +a13QWjiJc2D93zNKmqAa62z43u8OQl1ANw6lJlhesiDkiwQK7hLLArxna0k4Dua/ng8dFO
X-Google-Smtp-Source: AGHT+IFrBvYTznie5yOrXKRJeJERtPINvFVVYR1GSwPbvkwVab/Z6QUfz1SSGw+7D1+rAUd61nVybMIep1rnnZATmPQ=
X-Received: by 2002:a05:690e:151a:b0:63f:1e8c:f264 with SMTP id
 956f58d0204a3-63f1e8cfb4emr8097616d50.69.1761229105416; Thu, 23 Oct 2025
 07:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251021145313.4584-1-philmd@linaro.org>
In-Reply-To: <20251021145313.4584-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 15:18:13 +0100
X-Gm-Features: AS18NWAMpIG0-9i3EwRbCO1532y9Q9DCV5ubWS2KFVwAsxDgyTq6cgGiLfv5NYM
Message-ID: <CAFEAcA88AB9q=R4aN+CJj_xOiBNmS=aWEV72cwKTRfX_FEjTPA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 21 Oct 2025 at 15:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> uint8_t is good enough to hold a property "between 0 and 0xff".
>
> Define pullups/pulldowns properties using DEFINE_PROP_UINT8()
> macro, remove unnecessary range checks in pl061_realize().
> Update the two caller sites.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v2: qdev_prop_set_uint32 -> qdev_prop_set_uint8 in callers (Peter)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

