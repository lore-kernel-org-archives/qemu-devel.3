Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A13FC5933
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZSQ-00081w-HA; Thu, 26 Feb 2026 06:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZSM-00080q-Id
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:22:58 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvZSL-0006cN-4O
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:22:58 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64aedd812baso464635d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772104976; cv=none;
 d=google.com; s=arc-20240605;
 b=BK93KUoKBxnRWNoVmYj+eVovXb4gju6Iyg+gfki/3g7tMTo/8DRv7ARr98ZruZDBOJ
 o4QJEsbtkwltcv+eaz6YKKdFifx+eF0/VtbrZRUYo2ElFt9D1pr0YrmJ5Qst7ve6b2la
 1gqpRwI14vH7LySvPYxuPVYKi/ueocfwRvvL9bLIHTCa/zw8LqtwaqDQTX1Kp+a3D22C
 Uvja39y9bO7yoONVCB15/K9D6n7dkNICjCtFH88WzO4WMGEeWm0gpt4GFeBUVGThOX1f
 FCZ/8O5AfMYylR5/gr1PpCebNxjcj2UXdGQ35BWscGO7PW6WZiCm3YYLHdAkHo2zCm1e
 FRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/SiJRGb+OvNY68jQ3xeAkk3Ef9PVJlg2ZsyyEjFofvU=;
 fh=EyLUZsdvxUvmIXohxHVBSxxRCCRJss8LIEsNGHnQQzY=;
 b=ALHqB1j7xn7S/H4O/orDkwub8KTO1lX3IYa5xS8TmRT1Ii3adQSDDdwkTgkNcDyDDH
 sky4vUGK1J3Fi+cd7a2yOSjIOLewd1tcE3cPl90ut3QmEaRT0zCgbHeLbDGdz4Yvvk6s
 g6C/TaZcCIh+pEAyI1vulC6Hu+WsAlE5xTyBPfqYAfp3UZ8UZldVm18F2+jhCB+Pka9R
 W8xz9mjmvHQAfC2vXNixQ/WC0c6d/r6M/HhY2uA1hxgIZI3Zq07znHSD+PxFUCDrZRJj
 Pw0eG9g066k+DY0YfcabJ/At40e3Q1qoJYgfFnbf7nhjGq6fiyuglELWtiBobJchcERb
 QQjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772104976; x=1772709776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SiJRGb+OvNY68jQ3xeAkk3Ef9PVJlg2ZsyyEjFofvU=;
 b=euGghUO91iGraOl8JoLvfAmidFTOkBSwUL//Hh+AliHCpgro4eN4EdlL24oK7Mao7d
 hs6o9OYSvGFCfKEeTGfVWt7Ot1A5u8NrxK6t2byFPR+oIUu8MWEzBeybLr8A10hqzQji
 MninIjJcqfT5DbFpO4kU/CqxllYKQoKYKlWv3nb81HFX33tF+ZHIyr4XSg747u8RxNQ5
 Fb2Y3Y4HisOWjsiO8jOi94UoKIY9VPOt0E9xMJA7EMd7CRXjHPrT2GQprooSscX/MRP4
 Zs1+XRLQgC/qOtjTmHVCjXTqF4+wZ2DRBZzYNQRYR9NzKB06HbyUmsrHtFqFbfkRxIn9
 jo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772104976; x=1772709776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/SiJRGb+OvNY68jQ3xeAkk3Ef9PVJlg2ZsyyEjFofvU=;
 b=np2b3u0b+Su2srDIRX0PGVL0hfuKo2jDyH60cIAG/XwvvxMunCdimElFe+WcbyGE5/
 cxyzD5gGKUBcBmDDm6GExClSQJuw3jL18MvkETVvw4iAutXWy7ngVqF7OLEHOFeddvBw
 +CnrLXtfQsCBktoRwmYGzA+kkNtKgg1CyQGLfjybXNU+zn/MVyssD6yLSX3z2kxvi2Sy
 H5MQlbn4IbRKizymend3cdYLR/4mdUg628aBeBBIRx+/wVTkw7Ewk5TJfppdOrh81DCD
 ur6cTBs8OoI5k2kPk6cYsoArFb/MegK+rrYjtXjnr6Lr7HQcRLe8pHkx/C37hSTqkCwI
 iYXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3J9AkpTBOCQ0SEQUzpKLNHxnVApmaxOVlpq1oMaMS7ctQUd8JJlzeebWRwQ10Wwf8ogajnH4JcpK0@nongnu.org
X-Gm-Message-State: AOJu0YxF9WI5YgOsMGcmex7NgtQqas1fHpPK++gabGT3yBnlu2FmV6U5
 xDZujPFesis/gbD2tN6d+T8pB2DgdZhgvlAMQ4SdkDWy7uqagAXeeWu8hGgWwtaIJMghVgyl6sg
 Znz3HYKfANWg0mPM3YUVYXS2Qp9V0+OFL5Io/vqHrZtyl4PUSzrAT1tE=
X-Gm-Gg: ATEYQzylx0UNc76EI6Cb3sjAYN5RQEzp/Ox6nHBl8eOIZQxnmWB6DOxJQtWdKU9DL7Q
 8w9ikxsxy3+J3VPuffxaXe2MMSn78al4G9gXkAVP2XeaNjAqLIPoA4Dv/y9lulXeKekyrnqhCTp
 mo844t/dfXHogdLS3ncrullQlnzGDfz9x3l6xwWgm4NLKxMxPjZqj3M+l4cxQRNKHmxWa1Av4Vq
 uRFpLEHGYauUM3DRqgPreXfRFKhWjodogDMsBHXeOZ05eh9tZI5tYvq+mUE8cPsTDFXTbpTLlKw
 nehkeXqm3HrMI0oFjWuup1b6lF4GnIyaSZEI1K7Y9W8xSIZt+MFGzC2+88LnWIDqTNtyeEdkq/g
 seg==
X-Received: by 2002:a05:690e:1243:b0:646:5127:9d14 with SMTP id
 956f58d0204a3-64cb7c88f47mr1177601d50.79.1772104975720; Thu, 26 Feb 2026
 03:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20260224181440.832943-1-jsnow@redhat.com>
 <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
 <aaArdNcA8Iq9DrBA@redhat.com>
In-Reply-To: <aaArdNcA8Iq9DrBA@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 11:22:44 +0000
X-Gm-Features: AaiRm53-r08IOIgbyXGrjEjDU_Pu38wjRERWwtM75V9AZCV41zY76Kc6G1dc9yQ
Message-ID: <CAFEAcA9dBtOsgDL+0WvyB9GHVR=Y02VbTvPA-fjfiEkog1Khfg@mail.gmail.com>
Subject: Re: block/nfs.c and libnfs vs Fedora 43 (was: Re: [PULL v2 00/19]
 Python patches)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@dlhnet.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 26 Feb 2026 at 11:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Feb 26, 2026 at 10:44:58AM +0000, Peter Maydell wrote:
> > I'm guessing this is because:
> >  * the coverity job runs on the amd64-fedora-container
> >  * we just upgraded our Fedora container to F43
> >  * coverity configures with --enable-libnfs
>
> Do we really need to be hardcoding configure options ?
>
> It is a pretty random subset of options, compared to what gets
> enabled in the build.

The comment in scripts/coverity-scan/run-coverity-scan gives the
rationale:

# We configure with a fixed set of enables here to ensure that we don't
# accidentally reduce the scope of the analysis by doing the build on
# the system that's missing a dependency that we need to build part of
# the codebase.

And indeed this thread shows that it worked -- without the
--enable-libnfs we would simply not have noticed that we'd
silently stopped scanning block/nfs.c. Now we get to make an
active decision that we're OK with that.

thanks
-- PMM

