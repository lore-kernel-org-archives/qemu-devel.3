Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C5BCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbo9-00026t-GF; Mon, 22 Jun 2026 06:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbbny-00025U-Nr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:23:04 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbbnu-0008Ot-Uh
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:23:01 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6607e80a846so4307192d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 03:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782123777; cv=none;
 d=google.com; s=arc-20240605;
 b=MAoqrVTJNMdfA1LzDpdMa+jP1P1NJUcv7UsuCib22Y0Yzi/UGizkeZz24nc1XViXNI
 r8DYdVCZv1W1HdLZb3FLfuT9KpS7TZw22J1SKDfyP49ms1MzAY8oE72xivMNHFpAYJGw
 KpMDS2n0Q9rosUBSdUaL508mkwxVG4AEzAKMjcdk4nV1cMBTjJ6RnN4nnFEPuo0qvQM+
 /IakzrY7aHtu3lu+NBcK/3z/jIgXReCIexUy4EX8oLWY+mWImOZZw589nXeneNMnhmle
 9RYM69ULpwJ5ZoJ7wlXnT5MHcxf1FVJKSw67U03rEBrN85Tjq+TGv0eAIJ2Ym6YwarLW
 G4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k/HUmJlLMvc0aM+WDK4IfrdimbTRflTejHffYN89N5U=;
 fh=IXPj/8uHoGi4lVtexXZ0gMy7avf9W7sRRdI7uFrq9h4=;
 b=D9u62GzAr+0ZXai5cLSKABtlAGyYlOHoHnKJYu9euoyKuYZlUfW9NuQjow69q2B9ge
 FSWlsPWAK/7Y3RMa93qi6cLLIoecqoIJUvyMGR3je0LE/menLO33jIOxO25B0tcUmiGU
 fGWZ68nIPecXLhoudn3RiqRkhOBtP/sTcnQGGtlgIWEOIDJEVTB/n4rpniFUHa7V2wVF
 HeqoMPVM1XMOfIIVYfFGfwqV9LdlL7j4R/UYDN1ietYAPf23o52J1cV1X8Ske+JuvZoH
 cY/kF/7ZGg2tOd62Ska0RnrNHDOQixkhD3gQmM1gPCQgpa6FrSaW2LaCLaZvDpoMrqPz
 7fCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782123777; x=1782728577; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/HUmJlLMvc0aM+WDK4IfrdimbTRflTejHffYN89N5U=;
 b=Ob0HU2KnArMCDDoQRJ768ArwMSjVahBTkZohQgQMTU9WPpJpm38/f83Sly5IFuc4wT
 3SXVaUEQOZeDSb6eYDDXsQAOBVbMbg9Hnvc88WCLC7Gf4afrd7fGJTmhbIByI9yH5DC/
 NFVvFYynUWegBc36rN6aHI4yCUNW5CwKf79xGs64cw5ou/DJymciOSMvmV3HPJdtxyxD
 J9Imit4mJCsGviVPcLKsjUXSv6NTGVqomK1c7w3hGmQFw8A9fqsJG7X95jfY/bxDx+E8
 4jS9Nuzy1LhLbjTw1gQ33+UteT9anSpvfqsfbZYd2WHlcxkFV/LeE/TyaRiQ5UjmZqb2
 AG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782123777; x=1782728577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/HUmJlLMvc0aM+WDK4IfrdimbTRflTejHffYN89N5U=;
 b=fGGD8B9/oC06jkqILo4iuJ9RAlUUBXJFa0kdb1ihE3gEncW0SDvp2KpC00FzGpn6VQ
 vpUuH1neYQS5zjPYLMyFlgviCC/srHfiwTjEJTeYCCjQ/ltz+eIJp+sGfSqK6pq9KSFK
 kpnKWRlfqcCH8u5PMb/SlerYvY9PXUT9obMIJ1v1eaB6ry6cr8kw82mFp9ZtyLQmcQAO
 sbwSxCBOa1Kd5/l5+QLfPwXChS3fxwmm1IJfl7jX6v9xu93367Kjz1s60V2QreeaeKB5
 cCM20RX7FVIJycoqM1oO6MnTBldUHiOFnLelvlcLbd6C8IGncMlvkO9sTAUT3YBHgzs4
 3l7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6gJntjx7HAniqNBEcDTTHrX8/tEy3zz6G2COVh/DtPukbEzqI3XhhmEhXPy7OuI6ps4sR862Ys3aK@nongnu.org
X-Gm-Message-State: AOJu0YwH0pXr/qAkqOLXFP80cwKMN1lNJ1Ig9c9Ef3G79UA3+kUC0ugL
 otHg//STLj3TY51nrdU6Ui6aQvecQVQ9WyoK0yT0awepkMkTLkna4H+IATCzQMYBvLG+la+TOqO
 LoajQx4WcpD9nQTuDw4RueBUsIFfe3Hto1jMZxYNqTg==
X-Gm-Gg: AfdE7cl8SYlF+EFxS74QZZyZ84gZfLOBEQHPddrDagRGDu74Ti0JAEWFN4/hUAG+xBA
 R91J+Sab1V4uWnM2djOKkVUN8ZoAzY8/1hK57OHkepJzReMAqymlOVWat2hHbuFHoKpfYj2zrxD
 NGknJJZsxZ7rLzgga3g9hSmhUob28jYY41Hqvc4pY3CxIX/WVSygQgCHa9Y6mKMKohzk2Pt8I8y
 sp14bDj+PL1Pp6zIATfVG8VkbqGjtNV+P0VMJ9+LEshZWRby1EQNC0fHBn+hWMWhAr+0iCR3NTU
 UrQX7f2qGFQzu+gP45HkNtIdfXZ5ilx6Kq/yBI7o1A3iOunpMtq3aXeijBLRbG4qS6s=
X-Received: by 2002:a05:690e:3cd:b0:660:ffe0:2dfe with SMTP id
 956f58d0204a3-662fc9fcfbbmr9475639d50.37.1782123776661; Mon, 22 Jun 2026
 03:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260609105626.1038690-1-thuth@redhat.com>
 <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
 <CAMvPwGpvpHD+Sx-HZR4FFMJB+W8Rk8LoU0256Q=vwKAdC96HSQ@mail.gmail.com>
 <CAFEAcA9N_O7RZRU+SPTfB_ePasjVZvUsFPhndfQDuHgQ+4Q-5A@mail.gmail.com>
 <CAMvPwGpzAcDxeqSvQmOjzkQn6T91CAmTO31bNs0wmSMqQKG=Qg@mail.gmail.com>
 <CAMvPwGrnh9-UMv5919bLXLF8oLcyTa=coTdqh+1ALNvCKLmOJQ@mail.gmail.com>
In-Reply-To: <CAMvPwGrnh9-UMv5919bLXLF8oLcyTa=coTdqh+1ALNvCKLmOJQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 11:22:45 +0100
X-Gm-Features: AVVi8CeuH3mh7XJlmeOdZH_8nSVPI7iYi8piPpYAqU995iKkIwQkqo8n5iqgam8
Message-ID: <CAFEAcA-Te1aK8J-FPdpudm-3tQW9+kDdYgAa69tYXj2_TyLgVQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting
 too many bytes
To: Titus Rwantare <titusr@google.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 9 Jun 2026 at 17:00, Titus Rwantare <titusr@google.com> wrote:
>
> oops, the patch series that fixes this needs to be upstreamed.

I see we have a patch that's been submitted:
https://patchew.org/QEMU/20260614222131.5795-1-imaginos32@gmail.com/
that fixes what the #3388 test case is actually running into
(guest writes a 32 byte string to a device register, and so
we lose the NUL terminator and strlen() returns a too-large
value when the guest reads the string value back).

But looking at the code it does also feel to me that there
might be a bug in what the issue report description claimed
it was testing, where the guest triggers multiple
pmbus_send_string() calls without reading back the data,
and the data piles up in the buffer and causes the assertion.

Is the patch series you want to upstream a fix to the "no NUL
terminator" problem, or to the "multiple send_string calls
fill the buffer" problem?

thanks
-- PMM

