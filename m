Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0465C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjYsh-0007qj-Co; Tue, 14 Jul 2026 04:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjYsf-0007qA-Q4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:52:45 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjYse-0003fS-6e
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:52:45 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81ea9f974ebso6596207b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784019162; cv=none;
 d=google.com; s=arc-20260327;
 b=LZzcwEee6G+RtitdKC3Qz0YAKDK3YWYopWPZMKMPjs3kaD6SdJn1tZq7pr7cuz6s+0
 vDP9uKqd16lVADPvVpz+Ely0OUkAThBzgdDYKQ4STQjgJ80tVW48wTnRWYy9j6pjzNuF
 e9sjPfRXB2pQgsCZLLDD5I6oQsUx5s/uruwjNC/mGOlIqz8jcz4Z11aIXrQ0pR5GYRDq
 Fz8yMH3doBt58WRRBvmbzkGr5bFfUW9Rs4B3XVZeEBsiSiWERx0YyZg5dV4AF27Qr2YG
 fRuBTYFUI7o4p0GrHFnPfig/NKtXom8hKx6BA2ChcJDZDJvQARNe2ZAFnXE0UKUxoNE8
 /6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QL/wKds2Y0rZ11D7iCVe8iDdXFTMhHVl5Zz6gZePVlE=;
 fh=GyGp6ZDplNma4OjAFCTdtediX2M3UMx7SzqwKXy4QJQ=;
 b=rOvmquXZKo1sOJpne5RephPOA5Enmb3sd4UQjYZVRXhbIcurS/ifEaBpSqYFl4ke2S
 9D+GOChxN63mXEx9h2fSg7auOqeHTY8ubcqKYqb9cnjLSRVoORP40pgPBu5XukfjcNTu
 Ucr6/jT7kLF9fP9IAz1eOBfdIUbUbsQfZ3u7bJQjWWwF1ZJki052mQneT5PgiRK5iwEL
 RyS8UDwfDPHvTKcdl4qxtAyds7K5dxo7+90dK0hOcRixLhLQ+PUrv0HzLEvN5IP0SOpj
 vWlpxwDxLgS73gocCF/bBBUeA+G0TXbkZCNJfW7sJzz3PUXuhnXXjwzU/BBgjZoLu+uO
 H7Yg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784019162; x=1784623962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QL/wKds2Y0rZ11D7iCVe8iDdXFTMhHVl5Zz6gZePVlE=;
 b=Bspwyma0H34Vhk10xuNmfQ1mo3eB2DDI/E+a/kXNRHbThDEkNLhqSLxPpn3+jow1Hw
 Ud1SptKermGy7CEsJ82BUpqUmmwr0wZI2nGVrzgrL1RlrkplBLb268Pf4o0XdqepyHsy
 HgnGFQSJRgOx6d9CU9nD93Q/ZCwlC8v9WU5x9wGH0m7+VyM7urEIat5jLWL8xverymap
 SVmxQhCsTvEsxLElIh+tZ9Tx57wv94qJfT6pEWLT7AMy/NrvPypYAIMHi0TL2UBL+IG0
 nCCkYa8q33G8+O5b4jy2Y6qbLYHfG3qUO+yarcnalLmlzWq1jWzwJF2qfCma135EHPuW
 Su8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784019162; x=1784623962;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QL/wKds2Y0rZ11D7iCVe8iDdXFTMhHVl5Zz6gZePVlE=;
 b=guXmDzTzpeVkL+NStg1jyXgYO+o4fhnAKy5wyJ/7k7KSj4Nip/KPHMxuNN+3RnPoXZ
 eq7pADahsKitBvYPPQa9rCJlYbQDY3LWh9adfqlDB+WOlP7GYvTVQUZG98zPIEscwnER
 pD945nMeo3QuUaS+K8v3OmeGXiFTgfFpfFjY0mhWFs9teMCvzdO4BjAl/8DT7B8unN1F
 XjgMxu2I3/29SveI/hJp51pl7gX/eLN2E0p8qa2CJSZn2+3V6yCzj0YLF9yYACavzRfu
 TmujE4uLPtHcDMBxlNIazS1OUULXpBtu+Y/1Cz7sywxec5ZOE+u/oK31HR4shQP9ntgc
 v0eA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCsXMN3+dLMnLW0qpMHsZpSbcSWV35FCFa09CDf6RHRQApcSgWPM0MrlM6fzlE47OGQgCpg0UOzcDL@nongnu.org
X-Gm-Message-State: AOJu0Yxuevzw4+Jfd1QUN+WT8ORSnDarLN+E6eYG5bECIKamWbcxiz93
 bSupDwsIYG9zAnbenWsPDVkUAL6dMu0Q56gK2OeHIkHV6v4t9/BSjpJDByxARlWLzjKsCmiQjYf
 q2pW6aN9Msi7JSoAcHfpX/ciZgIhpNJoSTLxD9lFjTg==
X-Gm-Gg: AfdE7ckj2M73sXYycIdl+aCl0Swps52xTWekkNrezeCaFsQAsa1+QgIauayHY44J3Gd
 vVor5uTLamkK5QhdxvcgjlASD3Nqf2ALQfOo29ruauNDxHKqOW4OmQcaVZJN9krzOzcWH1+RhiB
 s9/Ai7I8PMpMeh6JGvdO+XfAGKcW+uv/aVv2m+VzwqLVuNNezZ0xC8F248s4ohQx9qIEfhXpbD0
 UeBMXR/zRFbZedgSeBb0V5WFrurka25ZW1ZG2mbgsu1v0zwp6G1sjO/SWrWBtpJGbmCIUdyRPxn
 FBys2uDcMRBMZdrYHedz2DZIqbCzypUpFFFpNNIQIQ8OmOib5V5uE2/b
X-Received: by 2002:a05:690c:3603:b0:81c:e8ab:c4ed with SMTP id
 00721157ae682-81e90181e3bmr93385797b3.51.1784019162146; Tue, 14 Jul 2026
 01:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
 <tencent_3045B23CF7A9872F29FC351E24D8F9373F07@qq.com>
 <6c0ff642-8125-4c35-8ed0-8f89da555ee9@oss.qualcomm.com>
In-Reply-To: <6c0ff642-8125-4c35-8ed0-8f89da555ee9@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2026 09:52:30 +0100
X-Gm-Features: AUfX_mzDxOCUO2U47PkEe6TS2caoUo6qynmsAPH3uE3iZ1T4Mvu6THCAwsO2iPY
Message-ID: <CAFEAcA-AqgGDgRkkc4MzCcE1zeMT-aWbYoyPYsUJsYShy0-0dA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 5 Jul 2026 at 23:05, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 4/7/26 03:41, Yanfeng Liu wrote:
> >
> > Philippe,
> >
> > The v1 always creates UART1 carelessly, then Peter suggested following
> > 5d8a250f9068 (openrisc) and e7100972f2 (arm) to reduce guest breakage.
>
> Oh I missed that. I'm confused because I thought not checking for
> backend use of a chardev (in particular calling serial_hd) was part
> of Peter's recommendations, since he did that cleanup years ago.

Where we're modelling a real piece of hardware that always has,
say, two UARTs, we want to always create both UARTs (because they're
always there in the real hardware, whether there's a serial cable
plugged into them or not). Having the chardev code handle "backend
is NULL" as equivalent to "this is the do-nothing backend" lets us
avoid unnecessary conditionals in the board code.

For "virtual" board types where it's QEMU defining what they are,
the situation is a little different. Ideally we'd do the simple
thing, i.e. "just create all the devices", but where there's
existing guest software that makes assumptions about how older
versions of QEMU used to behave and the number of users of the
board type is big enough that we care about not breaking that,
we sometimes need to do something else. The "only create the
second UART if the user puts another -serial option on the
command line" was the best idea I could come up with for letting
the user opt into the extra functionality if they needed it.

(If we have another future architecture that creates a "virt"
board type we should make sure we have it create at least two
UARTs right from the beginning, because we've now made this
mistake twice :-))

-- PMM

