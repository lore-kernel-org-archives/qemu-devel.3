Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D3CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8Ej-0005vr-5d; Wed, 27 May 2026 02:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wS8Ef-0005vi-Nl
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:59:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wS8Ec-0006Tc-IA
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:59:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4903974854dso50057545e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779865161; cv=none;
 d=google.com; s=arc-20240605;
 b=J1hUT/DMOsh1L56eHbdsy+qTM5mHWHdki+vKaeesSq9Y3R/VJ28BcNe3lmBxoTIl6E
 C2cDAVfp8ufxz4eGEMyI7Mti0GHg4YOSlLTgAMFj1fxLPpEb1bTUVGSHeXMAYR9K0nZ1
 /3/l9mg/kCwzXdLkHCmkFAANOpCvN7yO/gNescmof5MSVvKo0mm2xmZ2MIgvjjMr7wNc
 vMl1xDPAt0e5vc1kMUdnlUvMShsOi4eb7JUZB4FEcy4qlq4f7oaANoqcRoJj6skByfDi
 cHZ0rkBBqwntevyDQ1AuEvpZ9wyaHgMZXwbeDoOON4jP1gRsiyFrUygWYN0K9h9hJdhd
 uc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dMuyzzqkhhl2P+Q2TCySsnjCd6cDzFQ7lxW22XoWh4k=;
 fh=07Th6ozDznQxY1UVRmIoI6+IMTqXDa3aNmG13lS67KU=;
 b=JxzBTLIafrEXfgZC+M3jDMsChkySeMNL3yEqYbv3HIbKVdWxsIueNnansduu2QU0jS
 JvYW4YZmcEzzSC3GWmfv0jk3Denas6DfI5SFMSutkjvmNZpSKYn0oRQ96BY8rXutr6ni
 vlMuAh4uRZvwAHqvA9IWLenlEhdisexVoueHOsTFjSLEpfhqQL7X5AB4DXMEUuiGJ++3
 TN4wlPoacN86ayuaBKi5fNrU5KZJU3UYD5MEB0m/nDcV1CyXK3Y7Q0/UqD8sY0hMcAFF
 MK64uYGzlENKwPQl95NIqLwzHKxW7CNQ3Rk6r1i9TPLtBtW/+ZjVB9kMj1LWjeB76fkV
 Bp+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779865161; x=1780469961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMuyzzqkhhl2P+Q2TCySsnjCd6cDzFQ7lxW22XoWh4k=;
 b=pS108pFQuJHcKaH5MdU4/K+sQf6AFFuN2Hrj0cN0vQyABxUrnA09xzj9ts6Sxq1f4t
 Gtv80aAAfuGm4BLaxlyENIZlpmknIf0J9hahXM0clJSI47M08HHOw0JPYZucE6XCQHH5
 fdnhVWSRhGXstQq+UdXwk/3gi33MixX8cKXtcE3k9EJr6QmGTDZGWuiGhwM/zZ4fVvO7
 GlBYYC7FKEQ6OQBkJjCPKxjHqMfL5ZuLRDjHZJejV9u+wqJoXHadQNbwruVWToX/D1xU
 zyCrgdA8KjnbCAPGCb87tmJB8AEawENZJNrul9zwjZ/qEI3HQIT5g8SwX9x64dF7Rzfa
 vEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779865161; x=1780469961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dMuyzzqkhhl2P+Q2TCySsnjCd6cDzFQ7lxW22XoWh4k=;
 b=BIWJXX0D3OMfRkSRf9c3p6+6/M1KQSFSFch9S56gVIkNjRZBNkPhiqlz4CnV1g5bOY
 yBMu7pjVzX5ZSzoLYHwrfhKi4iPU5W7SC4TmchOYkA/F4RklOYPygGpnDYyP9nQ8TRGs
 52CMJTKS8j7qX/ve92M2yyBWR9JV7Sx9Dh5L8ZczM8RPa8j64n3WE7sSenkB3NBeO4+w
 y22o4eCRPLAahXtm4Nfjsp8uCcXkM5A9Ck1ZSY/9yyHMRI4Y37Fixf0KYXowbbmo5UBr
 mrHlKwpDjskzIRdj+k0Mx7saEldAh/dktOCzeoVNJKqiZAoXFouY7NHQ5qYp+kasA6Ni
 QQsQ==
X-Gm-Message-State: AOJu0Yz9ES4rcUymVWoaan3SNvjk782yIUx/BXRqg7ATS/oyqsDxIMFf
 16P5jHma6inWpRvMpD0rTjtOudAYRtNNR3KgLC2QM4srhQrD2DmWLbHsrK9JDvHrfcJgKLAlqZY
 5X7Wx4xKmrgs7es55iHAcb9vSCitJyAPvGQNmQnCfdg==
X-Gm-Gg: Acq92OEblvPE0LjCpdbBVfZO04rkaj1ejAYh4Jvhbt5ZeAviCT2280Ex8T690RYRMxI
 n/3wJCHqDK70ohFxaWr4BSG9fnpWGmAgTW+KIpZo0Hwq61irc6nxVN5EEe0Nxp9aRdy50c7SYno
 XjPkSDZmWvokGJKZDmn1NV2kBA/t+qW5YpXoXOdUqekMHeN9xJ5ghyyLxr1lE0XKHwkD5aYnThC
 Y9VqZjwyU5qK8XInPq2qrpkqiVtMSgFaKnVk41eleFq1ZEkJSlGo08TsQ79jdM/X3FdYHhydX1a
 kkMJocvNT7eGwcgJaZAO6hsK02XVkU+5RiA10diORmwfFIp6EQ==
X-Received: by 2002:a05:600c:8207:b0:490:688b:ece5 with SMTP id
 5b1f17b1804b1-490688bedbamr168215205e9.30.1779865160620; Tue, 26 May 2026
 23:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260527063102.91205-1-philmd@linaro.org>
In-Reply-To: <20260527063102.91205-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 27 May 2026 09:58:54 +0300
X-Gm-Features: AVHnY4KGf0hfEatm6HphPYRqDuC-mKkENzw9C5LIuxLZPnJEyLwXMIE3MZHl_hE
Message-ID: <CAAjaMXbpLC4Lr=hFPvFYi-g=-dcUbAZbHMDEoxc8e6+-68sEJw@mail.gmail.com>
Subject: Re: [PATCH v4] MAINTAINERS: Orphanize FW schema specs section
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Wed, May 27, 2026 at 9:31=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> I'm not paid to support this code. I haven't followed
> it neither, so be fair and just remove myself. Demote
> the status to 'Orphaned'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a89d6c6ca63..892380a6d51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4003,10 +4003,9 @@ F: docs/specs/fsi.rst
>  F: tests/qtest/aspeed_fsi-test.c
>
>  Firmware schema specifications
> -M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  R: Daniel P. Berrange <berrange@redhat.com>
>  R: Kashyap Chamarthy <kchamart@redhat.com>
> -S: Maintained
> +S: Orphan
>  F: docs/interop/firmware.json
>
>  EDK2 Firmware
> --
> 2.53.0
>
>

