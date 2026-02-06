Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F26EE2084
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voK5X-0008Aa-0l; Fri, 06 Feb 2026 06:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voK5T-0008AA-VW
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:33:23 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voK5R-00023O-Nx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:33:23 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-790b7b3e594so22084207b3.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770377600; cv=none;
 d=google.com; s=arc-20240605;
 b=lTG9Ifodqwmn0+/ywW+/pf8Fc3Zb3g+ZolIsEY4blfQCOOsMShDqcXz3s9ZohDMEVE
 pZkI+gWEamhUqOnlS9cqDpJ5Zo+i8+V9HRXXQETvphQIIXxwy6KwXo6q4WWxd9jemvKL
 fwUek276r7g40iajvBokZSMIc4cU79LaWXvZKHVQRP4AkO7eqaW5Xlp9ZSqxKdIejVdh
 u4OxhxGFwzEtti6wRVhpCbOpuLxCqMCAo9Z9TLTFRY7MjxfHHcXfXGin1AxvAs/u6vg+
 4ky4StcCVIFf9kjKF60yknJTdgK198VGl0cOcytrsiOeaY+kxNUUXSbceCzuqxsDtb8Y
 FOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T++GV8RpjxB1iEtwc+EYk3ASVHUyL/7ICkMQtMIUrgI=;
 fh=+6hS1CKkz1auh1nwwWTbfFzcxVxSu+dDuSCiDMdahJU=;
 b=ZUds+rKFshIOUbEJp1ZkhA7TAyNA3LXsZad2DfGEHmgsE/AWWaZaf9M3D+nqW91Fxx
 VJ73RW/K4Gg7/5+ur9I5Z7bxyWF0nIRM1AhQEjVcdwFovpV+6k2/FvxPUsBhHvWiG41R
 xnnhRMCZaG+NZkrAm/KyW3kpML6AlpSpj3EYZnA/CdJCE4AquEouMGuNGHkH9fuXfh12
 CDFFHv7xrcPraP52M852fU8RbgzgeG//SABDS3n4qAsUb297KbQJyS/WX0nSxMLVivj3
 //oZ06RPtc4A80dChIDKXxreqlAEUevBAj4o1DzA3zEJ8c8DI3PhuuN1wAc0CySXRw/R
 NaTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770377600; x=1770982400; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T++GV8RpjxB1iEtwc+EYk3ASVHUyL/7ICkMQtMIUrgI=;
 b=LztvEooDArF+AkPO1fLlzGhX5rUCNudRIB8/xhUuj9YelvBUu95qDDaSPya7NyaCR/
 tX0i/GHq2KJRUrsZL0JWEE1bKqYhngNviT9K0YACqZJBXcoLgNf7Hrq+R/+7yCkqKNWz
 U46/ZT1HzPY2QlaZdTJRnPbj5EA5eOqK70tbZA169s10rzQtk9YuvCYY47uG30LfeNa5
 VrJ20GufO/8ByZXA0frCVOXUNEqBMlIzW/s5eLXfO0qSAhzuFU+pbhrelnNMLcZK256s
 3eMb9c2fZv24BfTGliEcqyM4pFHkdENRwHKycxkRoQ/FolSH8XntDjMZCYuUxSPvQDlk
 EL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770377600; x=1770982400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T++GV8RpjxB1iEtwc+EYk3ASVHUyL/7ICkMQtMIUrgI=;
 b=UefppMoNMWbNQvJcrS1F+RJCwKL6HH37EV4RBodG7RPGvy3t6Ays6nexP/llg/a5Aq
 wwjy6Vas/lspzxuFB5cDXQDJ2b/z31bJlX18592YH7pQEQQselvlXCWiWrb3XuozDieF
 MbRP6bGX4EGbEaZvDaFDGq7B5sUkSQo7xN25INpGnHx99Ol/KWaHHG3gOj/nrCYI/rdJ
 8RmStS/aWghs8zxPy0vHDeawXRdcCukClVdhmBaTnidHxur9rD4fWdBqlAcRy4R9w7N3
 YknLXX4KSGaRQDx+ieSZFvR4MYIcbgse5pAc0yy+jKOl8rzf90ijJFLwSXb+9BkKAlWx
 f14A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1JJbMeAC0OLavG+nLEE2coPkN7tbUjfeQ0FDKeCizS4m9VynB1nYBaEzaYYQ/q00p5xmlfITk0X5r@nongnu.org
X-Gm-Message-State: AOJu0YyEAlraqQg87NUc3s77YETyn2j8x69Ko0SpGEL2vXRDaQgEVdNt
 5Nwaru4SxgaxBehKWkNTv0OAbKX4qdDxTbaz+Mkc8wyeUxLAGCILpjamQUIWySLj+fLxjBQzG9W
 DjwqlMvEIZEoNJkHbP39cWagJNVeQDDrHY7fo/xoyRw==
X-Gm-Gg: AZuq6aJ9r5jxw/TNqzoPUsQCpJTvLLqwicqmBtL6I0m8pI0AD0E9Bjh3w8ZnOpT4kxh
 Ml6VoZvluDFbAyGHFDodMNXd733EQfUpGdiJ792+kHmdS8EdvFWTyZAQMQ2v5CtbFDslwNO8vUx
 72OYoRyOLO4jZaZpGDqnH3OoNu/v+/Vz5AYW63nwplhsxcPMs44ArrgvdzI1TQsnJ4DZ7h1MzaN
 Il0qKh6mwOh8clb7BHbCutjaycI3gxGGD9F9komO6F6Sh23SKS87pllMyTF0IW2SNQRZk9GNuiU
 QplozA5EyIhsyTbZ7EeXjDOKywzJd/IpqP31ySRuCCw6/bVOLAEx5EQ=
X-Received: by 2002:a05:690c:61c2:b0:794:de8:cbd8 with SMTP id
 00721157ae682-7952aa89570mr24373067b3.19.1770377599718; Fri, 06 Feb 2026
 03:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-10-jamin_lin@aspeedtech.com>
 <83d409cf-868c-4a2d-b1c9-5741d3e36adc@kaod.org>
 <a6757611-32d0-4451-be0e-724648e1654f@redhat.com>
In-Reply-To: <a6757611-32d0-4451-be0e-724648e1654f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 11:33:08 +0000
X-Gm-Features: AZwV_Qh4_xk0qWbaqx5val6sw-HIjvgmLMSCldlNS-__45PiYHH6K6SrTnAks5Q
Message-ID: <CAFEAcA83c+ZHANxxKQBhCNvX1ObTp9hk+Wb0Yzb8ezx7HqDxpg@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] tests/functional/aarch64/test_aspeed_ast2700:
 Add AST2700 A2 EVB functional tests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 6 Feb 2026 at 10:40, Thomas Huth <thuth@redhat.com> wrote:
>
> On 06/02/2026 11.11, C=C3=A9dric Le Goater wrote:
> > + Thomas
> >
> > On 2/6/26 06:33, Jamin Lin wrote:
> >> Add functional coverage for the AST2700 A2 EVB machine by introducing
> >> test cases that boot and validate an OpenBMC SDK v11.00 image on
> >> "ast2700a2-evb".
> >
> > I wonder if we need to test both machines. The test is already quite lo=
ng.
> >
> > On my test system :
> >
> >    qemu:func-aarch64-aspeed_ast2700             OK              119.68s=
   3
> > subtests passed
> >
> > With both machines :
> >
> >    qemu:func-aarch64-aspeed_ast2700             OK              219.79s=
   6
> > subtests passed
>
> If the machines are very similar, it's maybe better to mark one of the te=
sts
> with a decorator (skipSlowTest maybe), so we don't have to execute it by
> default, but we still have the test around if we need it.


It might also be nice to have them be a separate top level test,
so that the tests can be run in parallel. AIUI having 1 test
with 6 subtests forces all 6 to run in sequence, whereas with
2 tests and 3 subtests each you can at least use 2 host CPUs.
Or does the qtest subtest handling include parallelism?

-- PMM

