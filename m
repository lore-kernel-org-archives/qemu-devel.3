Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6564ACF45B2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLfn-000570-UM; Mon, 12 Jan 2026 12:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLfE-00052W-C5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:25:20 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLfA-0001e3-Lb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:25:11 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78f89501423so59395137b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768238707; x=1768843507; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcaA07aja9AKHlBwmxqbWPv2fT49VPlbxbFhuj+X9cw=;
 b=hDem5PMxxWbnbbCWXq5GjlhpXQ9qb0IkqqN5kxn3VDDVxTBhlrE9a0UJpLKUOjEnNA
 A9LExFIG03F4VGN8OL4g2aPBIy3FqsCOwidbsOwmM2yCcMWhxYfuhoRjq0GUluiAsdc9
 +gveHPQDQodULWx9hpe/+nhrJWxtn/B1dSuQZhRI+5Hm75ylFDH9zssKnceHqtV7rw1h
 F22xIrshkXz8Ha9l1HWNLwjJ31jt/QaUkR+3jCeFa7YTXV0+Av1e0l/mjCfMppCtpny4
 xFBL6PUeHZofjS9xyOiTeTbOi0/k1Wk5sr99ln2Fx9kdzlLKCfl2twXc1NbGNLP6BSKj
 vKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768238707; x=1768843507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JcaA07aja9AKHlBwmxqbWPv2fT49VPlbxbFhuj+X9cw=;
 b=TaS+2AHqH3ysrJDDfsopEqmAVCcgWlITdgjbhE7QiD3C+nH7YS2EtfNJIA1CjPPhYE
 Oul3mc6qMsvQr97I7ukO8/56v2FAn3b/p28hOyZ8BwK9lste+Onl9tVU6PS4RyqEb6BH
 5mXqQ8ncchoHzbOrXagf5N1zEPX/OGC+oYagFpEZSdNjf1paZMaPS/eFKhMQFaptnqpT
 34dZOJz9R1Zlsk8fP6wZ4xjEZD29S/OlXeLNSPPGvvcFWXPAUR41si/Le/CKdy3cdUNv
 6yigXEeZKA3d1WnWN1PTmau5mKp9Te5W2zWdDqqKdw2fYeilNqplYEFcpwV1gFSbEH15
 Y6EQ==
X-Gm-Message-State: AOJu0YzOUZoJ54lazT5eZMvJwX5ttP1zNbYsTqE0j8IGRuaBG1hjTqww
 vc25tLvvMJkqg/uLfHuU9BcB6ofAZxn/IgwvTeNZUmbyPxb3F0LTym5WYmETNn687s7oVj/vWtN
 oVB1HvgiJnw8N/V5VOWCw0vICq+w5uS0DfOB8FS/QJQ==
X-Gm-Gg: AY/fxX7QFymk7XL2cLsDt57A/8UpBqWiAlO8r1uoKxuXaAb/TL2SombkTiUqm0J/k0x
 JNBcHOH7ANDoADugK1gc1LGHfL1+eSn6bjTaK4beohgu59Pg2YbLDNxjvIxRhIGkNUNvDoyXb3w
 OXPw2c1fJFuoDNabEJzJn6PFgDTQWoMZLkj6iIff6UzCuHhb0cI5UYMrwv05K+l7S/1gDJwrA/u
 DDZT4U71lEPRzfHMTnfBlT9eLo9UXbx7Vt8su27hU3KWRxMmFKDtDmj1gVPm5luWkD8/vku4s3r
 Nxp7FxTgyMhkOpJnfCvKyVw=
X-Google-Smtp-Source: AGHT+IHi1g1VCHTO/PKk4b2bg0Q2RoAJjo0ZxdlK/ZCQMXoqx/VCAACIc/4KgPaJIOkcS75OcI836lZK2LkNldBs/9M=
X-Received: by 2002:a05:690e:b87:b0:644:7b19:c207 with SMTP id
 956f58d0204a3-648f62e2358mr110348d50.38.1768238706664; Mon, 12 Jan 2026
 09:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20260112103034.65310-1-philmd@linaro.org>
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 17:24:54 +0000
X-Gm-Features: AZwV_QjBfKsH-d95xrBHkmPb53P__zhKgalrwijIMMb8sst0Pcpb0cuPwz2Eyq8
Message-ID: <CAFEAcA8YGQmc8-bdpRhtV9igq=M=ONc94vtf316Hz4hokPdg5g@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] target/arm/hvf: Consolidate
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 12 Jan 2026 at 10:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Series fully reviewed.
>
> - Patches 1-11 fix migration on HVF
> - Patches 12-14 remove a signal race with WFI
> - Patches 15-18 correct guest timer frequency
>
> Since v5:
> - Rebased on top of 3bee93b9abf ("Fix i386 HVF compilation failures")

Would you like me to take this via target-arm.next or are
you planning to send a pullreq for it? I don't mind either
way; I don't have any convenient machine for testing hvf
with, so via my tree it's mostly just avoiding possible
conflicts with other arm patches.

thanks
-- PMM

