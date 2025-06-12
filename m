Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03CBC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 07:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPcV2-0006AJ-GJ; Thu, 12 Jun 2025 03:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPcV0-00069t-Sn; Thu, 12 Jun 2025 03:37:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPcUz-0006Bg-E3; Thu, 12 Jun 2025 03:37:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cf214200so5208435e9.1; 
 Thu, 12 Jun 2025 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749713839; x=1750318639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZ6sPcipkdgCHZUrlXXsBzdJ/gVBOKP0mf97qysVYPc=;
 b=muvwtyR0RLtqw9LFIxihZs2Q65Zkr7E+/KDe2x6ETMwcAl4nXtjkTIMWKF0xwdHMwc
 7lKYO4AeKeBsjaiMsp/gTdzsCw+WFX7wy4Bsb1Wjifvf/jErT0Yqj8nOOIp1P7bpqPFN
 +i6VBTeyS/i3ycvQznX/a+VSE/pP11uw/puX4FHQlhSPm4IyLPNY/EHapZvnx7Z8Vsyt
 m4aWfmbNZUHS+Qo8Tz2kbZRwuBNeivEnOHakCo1l0PAa0ToBTuFu7L25R/o8CQfGcV3l
 s7jglFsHtIRqj21wK/XGjL+FBqGLHHN8YlnToiMey3cq894MPDv21CbI2XdBpGeOmqWu
 3avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749713839; x=1750318639;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZ6sPcipkdgCHZUrlXXsBzdJ/gVBOKP0mf97qysVYPc=;
 b=CoB/RLzqd48IdyprnFs/+zHlWEy6UOE+Q4LcvGxKY5rho68HGJIb7rCuklS6LL6tHq
 WDzts1BbHXSzUx4t9ek2TedlGa5INd1/OOlr7qfGBRZ3ASShC4dIOULK0uufyzdA/kL2
 EBSaPyatuvuyj3IeWX5OMzajMQ77e8GJYpwdVcKz+3a57eUvD+Juq3ccFoz3ZWpyDA2+
 TikDiW0hhSQvGY/aWjxHIrANI3WL0vZy0KwMi0r8kLIm8FzgAk9z9NSMnpl2D8fo6wc8
 ci47eCaUDd0sQ5Hs43RH6b16/cZjSwcmaCuUMu6IUXy3XcHWZq+1FPLDMu7TtxjdAb90
 XE/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj88JZ1UuELYqmS4eoqJ/DSJDmmV73wTOZ5PK5as8t3S0ZEMJfofzQ7oO30rcvQTjEZwvJBJoiuFo=@nongnu.org
X-Gm-Message-State: AOJu0Yy7fOIhGpvrkyG4w+1y9VwM+RikhQutN/ln4MI8VpXviNmF6Dk8
 hwrERzD2a9hrNfFxuNr/klOdPipyrKK3iTTSlzbB/ybofgB2uXIyLVfu
X-Gm-Gg: ASbGncs1L2PCikb9zDCA0th5++OlbFma5nuYYB7z4NIBACHVK9AHctdhBMryMaepsKe
 spXBc1CiAz9EpsZC0l09rzMbkHKKI4WK3/D477TXwUnqIHrXc+GMjeBuBD0D2p4KHw7bK23tF2v
 MoUbEsD9dDhNd5k7h80P1OqzbmpSldEHCjhqnD3oD+vGBr+nwsBpWEIhELgtcBF835jB4KBpmPv
 lZEaYGinWEV0TOyGo0F5ne9RFpNC1z1FSn9MDKFz60FdQvUT3S2UrZlDXT1e/YtqvEbxM+GAmOt
 9Wmxt43cr2HehOziqGVZVGmFoyFNhKO21av6ALlNg2/8yEbV0r2Kp290
X-Google-Smtp-Source: AGHT+IFl5jqHyNZJmbERnvs3fvJqKJtQk+dO7ngtBkNDQyaqzWni7HZf6pBPTYXKLcQOPC4JKrpXNg==
X-Received: by 2002:a05:600c:8b0b:b0:450:cd25:e68f with SMTP id
 5b1f17b1804b1-4532b966c95mr23746935e9.27.1749713839247; 
 Thu, 12 Jun 2025 00:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4531febf905sm60164575e9.0.2025.06.12.00.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 00:37:18 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:37:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_rust/qemu-api=3A_Add_?=
 =?US-ASCII?Q?initial_logging_support_based_on_C_API?=
In-Reply-To: <CAAjaMXZ5S7GUPmhwxsyuVmF4tvUh3vgjnK8OLKv-A+h7JCPqBA@mail.gmail.com>
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
 <CABgObfYgoYBJmZjin_Wj8JeEviFMM+vFa_QX_8Np+1n9apq4kw@mail.gmail.com>
 <CAAjaMXZ5S7GUPmhwxsyuVmF4tvUh3vgjnK8OLKv-A+h7JCPqBA@mail.gmail.com>
Message-ID: <9C43F9B8-6A5A-40EA-88B4-C5B8B17B9F5A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Juni 2025 12:17:57 UTC schrieb Manos Pitsidianakis <manos=2Epitsi=
dianakis@linaro=2Eorg>:
>On Wed, Jun 11, 2025 at 2:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat=2E=
com> wrote:
>>
>> On Wed, Jun 11, 2025 at 12:57=E2=80=AFPM Manos Pitsidianakis
>> <manos=2Epitsidianakis@linaro=2Eorg> wrote:
>>
>> > Maybe we could take this chance to remove the requirement for trailin=
g
>> > newline? Not urgent, and also something we could change afterwards
>> > anyway=2E We could also introduce log_mask_ln! macro but now I'm just
>> > bikeshedding=2E
>>
>> Good idea; there is no "formatln!" but I think you could use concat ins=
tead=2E
>
>I think `let formatted_string =3D format!("{}\n", format_args!($fmt
>$($args)*));` might be sufficient, but I haven't checked it myself
>

So the idea is to have a log_mask_ln! macro instead, since there isn't rea=
lly a point for a macro that doesn't add `\n` at the end=2E Correct?

