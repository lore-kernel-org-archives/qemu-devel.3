Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA81C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 08:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGajU-0000YI-UX; Mon, 10 Jun 2024 04:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sGajS-0000YA-R6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:50:27 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sGajQ-0005ts-81
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:50:26 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52bbdb15dd5so3030963e87.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1718009420; x=1718614220;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mQjfbGv2QFczg26/lC3rdmjue+xJb6SzL3gM5ippoSQ=;
 b=GlwGuyfpp4RaJmDBFv6qlD3d+5ckwMo4MZBGuMbTgw1dtn5CIOd7fc4T2Xm7Lyq7GF
 QZ1uOOvVv9S6St+7eKEjNTuWz+3E/kUX8d/Wb91XBOfmuAp2uqwFdg+cNkuBq3U/J6hC
 W95/dEvLS33B7kuf/FT+TSkWZ8yhjNp+BRy5kHJ+pr7Ywa/G/SR/VsV8yq938ezaoVMK
 z5YNJiSeggBaMkwPSwL8GBUvV9l77vmJyZLAlGX15yXa+OggMwYIejSyY44zgCQaL4dO
 UJaD04KI7HynJ9BzNMWLwGc+qPO4h6oZGPMuEI9ljlwgPdo3ArVHzEoOMxmi6ZjZg5Xk
 jLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009420; x=1718614220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQjfbGv2QFczg26/lC3rdmjue+xJb6SzL3gM5ippoSQ=;
 b=iFsrxIp3duhOf9yeM4t1scRlrPoYfrkkfrrm2bAa/U8cbvN5J46hnh5OT2uQWvo6Uo
 F5QpftgUeM76Sk7q0ebcmqj3rDGmKD04xgwby2KZkjSJQXpl/dYxIRUhEDv6QAP2KDnB
 JxJ1cyNgNdFX2bknkINsNRIPyw7p89ZXNvibmbqjsqCWaBlWEeG5RIh3IDFCsHJ0UFT5
 rWWhca+zTwVy8sqsZ8FP1p2jcyCNsOr4JooZ9JtnAM1yCWaQ5TFszt+8c9RujgcKE1dL
 zh0JYYi0p15kkFead00CIQ/723XRoExsUfQVzxPKPj1qa18fPBUu4pw16AbwPWcSt59l
 XM+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhcC3dxpUIsOOfT0clbhUmgRvZA20NBbpd4h7klu6nAh6oJ9hhAVx4+tUrU7Kbe3VdGXs7td+x377qI1RW8XWPIen8YYA=
X-Gm-Message-State: AOJu0YxmTD0YpnmpM1Mc2tqGsYSSMqETYMAtgUi32eY/x6OMrQfSjyVU
 fsy187DFL3z/Z2+jVzKskTQ/h9xPqT1zCeIKisv1tP0SqQwrIX8R6EM8rhW/BdN6HXIzf8+mrZ6
 QpcxhCnXf1pRXfO5Xv7fDS6YRhnt4g4/ulKJ1
X-Google-Smtp-Source: AGHT+IGdv31SRid2JYOIaSg2PsGorYtf3+eABNVkh6DExCgdeuPGKwkaNnvCn1LNLjgzo53OnUWXXL8WYDhUZ94cQQs=
X-Received: by 2002:a2e:8712:0:b0:2eb:e312:5af1 with SMTP id
 38308e7fff4ca-2ebe3125cd4mr21408651fa.22.1718009420105; Mon, 10 Jun 2024
 01:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-3-phil@philjordan.eu>
 <16786a0d-4cf5-4e62-9db1-a2f448f4b8a6@daynix.com>
In-Reply-To: <16786a0d-4cf5-4e62-9db1-a2f448f4b8a6@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Mon, 10 Jun 2024 10:50:07 +0200
Message-ID: <CAGCz3vtoof+EKnmjX=mAiCQ7Dy=gpXTN3eciZxMHCgnAfb7SiQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw: Moves int_clamp() implementations to header
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: neutral client-ip=2a00:1450:4864:20::12c;
 envelope-from=lists@philjordan.eu; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sun, 9 Jun 2024 at 11:00, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2024/06/09 5:20, Phil Dennis-Jordan wrote:
> > Both hw/input/hid.c and hw/usb/dev-wacom.c define identical versions
> > (aside from code formatting) of a clamping function, int_clamp().
> > (marked inline) To avoid duplication and to enable further re-use, this
> > change moves the function into qemu/cutils.h.
>
> Wht about replacing int_clamp(a, b, c) with MIN(MAX(a, b), c)?
> MIN(MAX(a, b), c) has a few advantages:
> - It works with any integer types
>    (so you can replace even uint_clamp() in hw/display/vga.c)

Well, that can of course also be achieved by wrapping MIN(MAX(v, min),
max) in a new CLAMP(v, min, max) macro.

> - It makes clear that b is the minimum value and c is the maximum value
>    while it is not with int_clamp()

I guess this aspect is rather subjective. When I see a MIN(MAX(
construct I generally feel the need to triple-check to make sure which
way around it is. (The minimum value is passed to MAX, the maximum to
MIN.)

On the other hand, there is precedent and convention for a clamp()
function with that order of parameters in other APIs and programming
languages: C++ std::clamp, Java Math.clamp(), OpenCL kernels and
OpenGL shaders can both use a built-in clamp() function, etc.

> - It is already used in other places.


The CLAMP macro would be my preferred compromise, although I don't
know how keen everyone is on introducing a new macro named after a
short, generic word.

