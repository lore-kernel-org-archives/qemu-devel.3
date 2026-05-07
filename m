Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A68CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyKs-0003IC-3H; Thu, 07 May 2026 09:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKyKn-0003HX-OJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:00:09 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKyKl-0001P0-Ms
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:00:09 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65d071aac6eso676902d50.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778158806; cv=none;
 d=google.com; s=arc-20240605;
 b=EfozV2+uQdi94mAYMakhcU8Yk5LuFbcIMZad1Hyf5Np3Yg/U4G0Sj/R/gwN6tn+Q4V
 TUZro3GFxpxpmLZDrWSzxfM2ALutvrH22g45ihQpZ6bj+lM9YHwutxtgMqtwwtsYbj3e
 3w4OkMiXTDnRCg9zB/kYM98Gocxabdhyfm/LlfGeXgNI1gApsMG72t2RfNBdilMm2W0B
 LKI5VMzYqPfA+Rj4IZfhrb2FUlHw3xXsb9cUeX6+mF5OeQmydmybIkyYjLpzkNwMCQ0J
 vwiuWX6Y5DWDiZ/7JLi7boHunByLsjWGhCtuqCIEfBWvxe3wnFIvYx8vFvQvjZmp4ze6
 S9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tdYXwji1sz9BqZ3nJqTK/y4jhXnBdMm7sbEKyfx3W/U=;
 fh=ZUR3al20C4uS0IK46eApU2WIKvkUU47arxKUvA0VfwI=;
 b=gDlGt5rHh6gGXGJazC9zqrbahypGV+e+SO7wfeyvEOXVJ7nhoYWWXDYhHEYBZ28wbJ
 /UIwcGEhQ3eE2UGpZZTa0BLI4I0ccFqluLmzBe3Jw6VqM5ZxKqjp+4TH45+qphS/I/0e
 7VJtkKdeeS0iBODx3TcjGk7Lk1tc/zvhV2UQwwEPVrnhAcT0+XWx9YXxBAplSdh7zmo8
 hzr0TBeONq5Tw5TQJiHSB4O5Rq2MncU8WQMyuVz5AAY3nuppUPC+fk0el5BCO43/xKQ6
 bU7S9PqwCXzaovNr1oVUduHZuhsqVcdNeHXadTEHUhor3RCtTHMEkKuWBYd0GD4BHffF
 QjZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778158806; x=1778763606; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdYXwji1sz9BqZ3nJqTK/y4jhXnBdMm7sbEKyfx3W/U=;
 b=m8I4ydRGXocxM9lS3tPcueNtobE4rVIDpTrbKieFiRWDg87bS/nHoVqPPrvk2mWzha
 jYZp+V10bLeg+Gj8fhH0xCq7OG1IPmmE5ntDxTpwgtcaFVqAvGQJhZV2GrVVru8lAs5l
 0NwAiaB7M9MRNBZLdy5qH+BJJm9tL+zjBwZFXBwgFTb8O07ZddR06GfHWnRJnJIzn3F9
 nki0oDwN9OtPc5nAVRGhFLOe9brWhrQi95n+jSyNeSwaYsdk+0XeiF+InD6bMGPJ02H3
 Unh3soGJPGvsDrBxf53ZWaJ+Wyf3CO8x9Sie/aM+KUQy0oMgVt2r7W7kdmuGytTcT3p9
 mOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158806; x=1778763606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tdYXwji1sz9BqZ3nJqTK/y4jhXnBdMm7sbEKyfx3W/U=;
 b=j0Cok96fbh1BU5V9VjmhnfUbHExaF5PRESMHchMS4rGO7OZ5179p45hA94UtNXk8bA
 cxizdqxUyEDRU9DxQoepIUztRXcEocJV6FzkagUHSOLO89q4vu5f4sxV1hmZaVFDjicV
 j8raZpTeVeYuhJTlTya1cDlhf/vRZMcu5nPyf2xE+sb8TXbguJ+8h0Nvgu6SLQZU1ICF
 TbP+mNTGtR/z0Nr98Orl2SeLMTvaTcmjhq4cEIdPF+O4S9oUthOJkTq7bnst0HVnPpc/
 o/5mN+BRJHnT6IfAt/smWc7zblocdoMwavmOuZuMVfRkREaeg9ObzNn05l3dBEaJlt1N
 1nDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Wz/P8extYNwTBlCabXGFEsa05p84u9O9Ec2Zr+3xo1kI6Ftq1BHaPXmmXiSNwgBpiF3hmn6vZz61K@nongnu.org
X-Gm-Message-State: AOJu0YwBKTEy2rngMvbxH7PK0job6HK5yT7NcyeXPotCVlnmgGId+o+7
 GLf7uBs3r+Onck/hJHYBKDA1VUvd6PKsW7lWtLxG27QA6noEKjMNgSkQo1y6Uskn7r1AgIp2+Xw
 DrqHYB2ySxQYDwSg+Hh3xeudPdz7JqwTqHpyL861GeA==
X-Gm-Gg: Acq92OEMpuXJSUnFrCPY4TqTXPp8eTU6mvxDHTmPm97R4h3qXDuxsarKUHlVkpBzWBz
 jJhafuVSRHvpZzjZIV7sZMUDUH4l+63bLL1XYBj0mxSjUM0+fLKU3S3auTXsQS6MQABQ/FkCcGV
 kopcJSciH1MVLdur6NgGino95mzlHqbQiA+LlTc0TcsoEMiwzEPsNMNdnDbYL4e01kuNmGAg/zW
 ecACitKxPZDO8eVtsSXsHJG4GS690133QoAXxWaF51IZQv7hAkGULJh0eL9Xfk5t3xdeILHcqeT
 lKCvjJnavFVvZEyNhS9XIDbYioPXijFa+QMUhh7SvLzekl49Dhhl9ihTGZJtO8SsMkfdNcs/9j6
 Kbg==
X-Received: by 2002:a05:690e:1449:b0:650:3b84:c250 with SMTP id
 956f58d0204a3-65c79ad52b6mr7713559d50.2.1778158805428; Thu, 07 May 2026
 06:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-9-alex.bennee@linaro.org> <afxMiS7Y5RIXPLUz@redhat.com>
 <87zf2bl7r8.fsf@draig.linaro.org>
In-Reply-To: <87zf2bl7r8.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 13:59:54 +0100
X-Gm-Features: AVHnY4JnQEqMVLnZrIZCeNQs_QBFsgflMTRTaawEsSe1MtgF2GDnY9G3qQhd8sU
Message-ID: <CAFEAcA-yErwL0bHhOwVLDruS+6t_LPebKzNELDt0N+Z-6nBtuw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] .agents/skills: add qemu-issue-triage agent
 skill
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 7 May 2026 at 13:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Tue, May 05, 2026 at 06:01:03PM +0100, Alex Benn=C3=A9e wrote:
> >> +kind: Not user visible
> >
> > What's this for, and why : instead of :: ?
>
> No idea - is this the mechanism we use to hide live security issues?

No, that's separate (and generally we don't use it at all,
so the only reason for a gitlab issue being "confidential"
is that the submitter didn't read our policy on how to
submit potential security issues, or misunderstood what
gitlab's "mark issue as confidential" UI was for).

This label has no current issues, but I think the intent was
to mark "this is technically a bug, but in practice it doesn't
affect any users because it's masked by other things or because
no calling code uses the buggy bit of this function, or whatever".

Since it's unused, we could just delete the label.

thanks
-- PMM

