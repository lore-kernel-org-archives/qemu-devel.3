Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E36FCB607
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWe2-0002yR-SY; Fri, 06 Mar 2026 09:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWe0-0002xL-NP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:13 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWdx-0002GW-Sc
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:11 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso9191375d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809148; cv=none;
 d=google.com; s=arc-20240605;
 b=XOX1FjVIXl4zkfr6/TBRi3x3naMGMXsU+tVRFQpmpd46yV8U7+5YCacN/EXQzMnCee
 mE3k0wIDA/DoCj4RhpLXzDcPmqRW2SCRJVNDVq0vs4vKm8gGKa2saqnnOnP1cFsEw9DN
 3nlT6wcOuhvytx7l08pk1U6ZCm9CP/Ml2YpvqTkfMyWjsiBiuo/cWZWdFjxEoePLFgEf
 WJFBkZD4Y8DiVZZLJxtE4+Oq0B8Bz5cXbmR427lwfH4SY3/x6r8hTKmgHV3I57BpYyg7
 w/fymy24MLpyIg92svNAVJLtIgNusduIbY2grX9O0x3LiS8WOhCWf7QRcj3hrExky+ma
 l4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kqLiNDrMG9u9CrtCxuMN9Ra3KZe+gyeOFGxvnlKdFJc=;
 fh=jUYsI/2acYShRiXxoUq/Pm9LQcAd+S5Ayx7Ab2mBfmk=;
 b=ObFC892QHh2KJ+QjEIwufxdfrR1rhA/CbxLsKTOTjCwmcaUWYxuf3gVuWqZU9vUP+b
 d19QEvXPQwWGu1YhChft69+t49bZMbCiw7fFCM4tdgdb95wfOiRBDx740drQYgozsrt4
 px8luTDTuGS1Qpko3qieQmv0kPvoW2tBy9w4Gzisdeypmb5S2Rt6j4cc6XQAOL9K+N06
 M3c1OZO2dhCIVPhELQcOZPkXPvyE9UIyJufBX5Ld3V2WmLiLMmfiKm2f1PBpEVvNR+DK
 BTCW3FN6aBLKMjTAxIBEC+vIZ+hRnWbkifSzGOJrbACSx+/0NCSO6S6+Z1Oc0p9PLRR7
 XbEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809148; x=1773413948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kqLiNDrMG9u9CrtCxuMN9Ra3KZe+gyeOFGxvnlKdFJc=;
 b=XnW/Bb3oQUW7p7jUqws2DOAFQU/BnCepTj+H5tekEEBRIYFnfRhLJV6WSN0Eb5r3Vf
 /PT7ocjCyUYc5ABWudoYwubg58k039VCVzQnB7sEoxlXcXM39F8C2Lthl+gzNUraygYE
 rgUpZlGLzC1mlUxwEHynk46GHvaC5YwVdmm7B2lhuAQTdxXSbyGzos+lS/MpPXdl5yk3
 G59hQ0XEXfWKcmdLH0pSvlqS/FqcVUx7MV2BlhUYXmB9OLoG06/QUiUJ+uDQS1HwsVqc
 7UhcoiyssVfjR6McJ/Y1TJ0/xHku71ZBCCwBrM1sD4DiPNB+BPp5wzn+DWW4z+pELj5v
 WBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809148; x=1773413948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqLiNDrMG9u9CrtCxuMN9Ra3KZe+gyeOFGxvnlKdFJc=;
 b=sDkJFVSj1stERvXKYpoewbOhasaF1N2l4gQvL4o43EV79AdnZaDCmAH9vcuDmR+Zuo
 +VJ/dlaiwDP8OxUcQ2+bVrkzYRhFVach4ZWl3IgtfyOgMP5+dCtVpwAy2+gVXt0J/ZP9
 JsqHHDT7nj9t35hU+irSQ/qMh+xUgMGiNJdFrbP/tSvYQId/CcpU3Oowr701CWvaio7Z
 XTISP1ABV+hvcgQ6h+8Iw0l5658eGMOapzSK9owAjYjGYwZOvRTufklqglzQtK80IELb
 EHeFPcLk8aiet8abAFwvfEg87ZZk1WjzfnYs+c6TD50OaZ4OAU4jDxsSjHlbi5XfVU8R
 p5FQ==
X-Gm-Message-State: AOJu0Yx6ThR3Q6sSNS5TgT/w46btRH0jZRJzz+YLkFXxXlFZADmGyuF8
 PM4CdKDSBi7vQWcxHdaSTx13reGH96zw/iHK5ifxsB2FNMMYyUS+wPIxkXh1d0Zwf47J13SJbqL
 dimKZF0/UrcmfpF00jv9xGHqpt278rl12j7oOALFtvw==
X-Gm-Gg: ATEYQzxrodCr4LOXVDiaSL7g9KVyfL1aavc7H1+v0h3sCbqqSX1QHVz8Nl2+HDGSdji
 0VcPVGoUa95VxfroZqK1KevIVci60JA4KUWqkhSKPMgaNf7XUHfb16qSkAq48VlBDG3d7o9onqc
 lnUhiGohW3HlvQMl7VQ+nEmwVKPST3jwvk5PPPaLg9prqL1kdKqbJeFqurKJmHSWpyMjk5hN/qT
 UNd3vNLP6O77U14aMqlcdGdouZ3lhD/Ch5VRiGeH/xxreBCooCRZdxZAd5vLfXNXhxbZvgPdNTV
 JXJ5923/z2bjh3UFNYvbndcFpgyRGpndfDva1Hh9Fgc5eKbz+NJp3au+Yi78aigar0E=
X-Received: by 2002:a53:ac9c:0:b0:64c:f53b:d3d9 with SMTP id
 956f58d0204a3-64d14384e56mr2143910d50.75.1772809148424; Fri, 06 Mar 2026
 06:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 14:58:57 +0000
X-Gm-Features: AaiRm51VBQPLO4FWA1bXltCpVpvd7PXApj30YfPW5iQkdhzSjA63fi_bOrjM9FA
Message-ID: <CAFEAcA-e4GZB_TRG7Jm3O-RNJneUtk_WufiXNn6=UDHsgG4kdw@mail.gmail.com>
Subject: Re: [PATCH v15 00/17] HVF: Add support for platform vGIC and nested
 virtualisation
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 6 Mar 2026 at 13:01, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v15)
>
> This series adds supports for nested virtualisation when using HVF on arm64 Macs.
>
> Reviews would be very welcome :-) It's maybe a bit unlikely that this will make
> it to QEMU 11.0 I might as well try.
>
> The first two patches are from the SME enablement series and are present for the
> series to be buildable on its own.



Applied to target-arm.next, thanks.

-- PMM

