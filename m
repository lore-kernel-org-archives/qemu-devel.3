Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1AAC5AC81
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJre-0004V3-1x; Fri, 07 Aug 2026 08:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wsJra-0004Uf-CR
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 08:39:50 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wsJrY-0002rx-Tr
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 08:39:50 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-82113c53aeaso23798857b3.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 05:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786106385; cv=none;
 d=google.com; s=arc-20260327;
 b=f24UdReOu/UJcF67EIAQ7MAiiPuxNYg25czQToxFXAbo09610Dn/NwpIAjgtrL1GwK
 eiMgZ9pd21CwTabCrtdyxwb2QFYdF03r5PD4PhSoeL1aea1nTS13keo6rQ3FM5jKiOQF
 3iP7WKsDKkT/C8XMtSk+3szNm2Jyy24dFduw75x0C5BXYHae4yqpDydoLLk82pR4kwEj
 mD5gLYc4ZHrubU6enNHk7qbdNApbFc8amc7K6GR2XNE+cJ9d7Wra1gClmK1Va5eLqAZO
 OlVm3ZLKjQjiOy6rspFPoDOKN88Tqs5l4R7xwudVnf3VsulQEU+TAkUTXsbzAPYUY4hq
 BXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/unQYnt4dGcWOnoLsOmOb4Gr7VWVjFPmq0fcER/Nto0=;
 fh=c4YsF+xbwPsO7TD20ekzmIuvWRuS8wd7Xb6Dt0bE+KY=;
 b=YtCbT7Qw4kyRYWViRLDfD557hh1yMRTe02rJnaKqxiYdcVwinJfGOs1F+k9DehHFj/
 3lXPkJlGZIow2+RHRVA8VOx1n7nKQpnpRNUUajVB8I8QGJO6IwS9tcChd8XB/2+qXLSV
 ZcNU5RJDaargOxlZhczl7/UqzmG3rt6bfaE0KzoUk0psmK+mVoKvNTWQCNBdR6qzz6Cp
 L8AHYJcIvsL7lykdykePoHUqGs1b7Lpz8iC5WkMYzKe7saEoPzeG98efMud4+/CfeT9d
 Py6fwkheAiD2OnH4PM8ffyiK3CscFeDQ58Re3EzjTMJuQQva1yPCzOazFMhFLti86s17
 Aciw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786106385; x=1786711185; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/unQYnt4dGcWOnoLsOmOb4Gr7VWVjFPmq0fcER/Nto0=;
 b=T8ST7kPAyYtQlnv0NhkMjkB+06NJGIXGPRr9PaJPjvRKTePU4Pa8FUO1r58Nb6gs+V
 AsymF82YuR8QTv5d62DHjQL4SJWfHHMES0O0fvQ9oa9MlCqgOa0zmmAZYfHyKH6rUYX/
 wJU4NZHbUrhXNtmvjf/VMT3+oo3leWgQIIKQOdc8r/1xZTHAsmx9U+Wnhvd/uEwZ0xA4
 eEy0CkKeJrvg5BEQxayREl+1k460lPyqfSlvJC7boLcxmoHkPaI0xImDk0cMLDYbVSTJ
 +h3/GdSYVB3I4b8Ld5NFI3eo8ipK2qjRhdV4FPsQN9vW0T7Zx6V9tmo8oJ/r9gMFO341
 eOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786106385; x=1786711185;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/unQYnt4dGcWOnoLsOmOb4Gr7VWVjFPmq0fcER/Nto0=;
 b=tL8GbY4RuxHLC2RcTovu3j5n1BXW16YAQ5+wzQungLdvfxqpPN+D0JwT9JpnAb+Gt8
 5NIH68Iu6k4hScWx4urssxkjtwpg7u5QdZbMMQSX26nhZfLWLI9dqJQIsX7Y69uOqMLf
 0q5hq+OwXGz4VkzzFoC1bHoWR8Kp6PZLc/OkqELtipjUNzf4+q19ZYgIg8pVeRcDmmHa
 gYQgDN29wJM/QdHybd1AERM+GHG86ZIA8qySxopPa7e/aC/emMXkY7V6ZH1JBeN7O2QT
 nfNXHaMLSOdkVYJ5/cM1miVMhhLLgsiYvEpYAoQM6t26u2x500Bf08Xn98AOuH177Waz
 I1nQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjvZlCRaqIQzp37KY8DNs62WJGfoL2bRRhLhjFJbmkJTBWLDn7PVvmWvEcQWug1iltMVw2+c/Iif9o@nongnu.org
X-Gm-Message-State: AOJu0YwOEmDNFneo+vc7N1d4sagOkgT47WpNodNFklPogL4AVyCUgHqB
 GUKSLVEfLId93JWoTqmbWbFtrBLmmt4fLT+PLH3Hd1JYB5v5a2qIu85yWt8BWSbNRheUufEhZnc
 hnP8hpzfvCs6lGLrrT3ZiNR8FuG7rPYuEvbm0vz5L8w==
X-Gm-Gg: AR+sD13Ouej1poI/1EzMettyphKsLc/WlnJtvmsduuutmH70DgkJTQsz2ZTHL5pzqSU
 BurlDLIaqOTnoeXAeIYWzrKm31AZJOp+otcKhqSjUq2QEsyDv6lyQNiZm2aLlqpxGxmQehjOHjD
 K901ZDQohM6iNcOghgMRC1M6T9OTlfBi10TFoxiLwMxvuFJeNQrGD1QXCMplpX5sgPNAx8bCU11
 bcOyZ1zihPBsXQAR/f2a6bezJJdU0ioRdjXIK7rkpR5QSp9EnlrlPBG8d1+u21BUNMC6DgLbZdK
 OHY0gv+Ud1lHFzhgQ/tyeHX26R4WPof95HZEWnaAp3RuMpborAHe7q4y9l/gx7MX8zjdYwThskd
 dR/yQpWmN25ko833BeGoncII+Hpo7
X-Received: by 2002:a05:690c:6d90:b0:81c:8005:9104 with SMTP id
 00721157ae682-820224e5320mr138129437b3.30.1786106384818; Fri, 07 Aug 2026
 05:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260802154350-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2026 13:39:32 +0100
X-Gm-Features: AUfX_mxLU0M-fkGJJUdnmWTfxZs9xi6XUs1byYL0NVHvuaIyrfdGYaM-Z1Vl-Tw
Message-ID: <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 2 Aug 2026 at 20:51, Michael S. Tsirkin <mst@redhat.com> wrote:
> So GCC has now decided that 15 lines or so is ok, if a maintainer
> decides so, and that one
> should only count significantly different changes, what they call,
> following the gnu maintainer guidelines "legally significant contributions":
>
>         A change of just a few lines (less than 15 or so) is not legally
>         significant for copyright. A regular series of repeated changes, such as
>         renaming a symbol, is not legally significant even if the symbol has to
>         be renamed in many places.

That is more that the GNU project already had a level they defined
as legally significant, because they wanted it to determine whether
they needed copyright assignment or not. So it's natural for GCC to
use it also in their AI policy.

> GCC also makes an exception for tests and I guess we could make
> an exception for internal developer docs?

I don't think we should have AI generated docs, including
developer docs, as I noted somewhere up thread. That's not for
any particular copyright reasons, it's because we need actual
humans to be understanding and writing the documentation,
because it can't be easily cross-checked by tests.

-- PMM

