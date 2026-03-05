Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E4F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7QJ-0006Fp-SL; Thu, 05 Mar 2026 07:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy7QD-0006Co-8t
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:03:18 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy7QB-0006KP-Eu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:03:16 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79885f4a900so47155147b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 04:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772712194; cv=none;
 d=google.com; s=arc-20240605;
 b=Kj2T8OSSBXVVtmP2irPaWTvcUW4OGwBckue+3ad/r0BH7s0WYdDKd5XIxqbwZBjzuE
 HtCOvLnoawVFv4Q8VPKZk5Z/p7EQ3hYCCwJQgenBIKLE37pHsiJf29Zv52NtsPCw0Tfa
 1fRHz6w7aRBZerFxvp2jyKar3hJxLOlY2RhRXBTlkstZNt9l6QGODjsQmbzTfeyh84fo
 2szp46a0c6bL7DwppDK/vuHlN1lKpb36mImmu12eYXLflf9K1X/ho3/vbrgtsesgH+O7
 8HNcLvzEzvkEBV7yBxaOXoSi5W1D7qMyInFWbEQnxfp7BrKcy1r7PHpnP7IL86fbbrcI
 TsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IuMOilKQ9k9Wi6+SPKTq7NtdvbPDI4EMOkI66dOrp8c=;
 fh=V31X8Q+q+o18R3rQGl8mr0gBbIaaOVq3DIPeAWUak1I=;
 b=ggMJv+1LEWEo3iF/6Ph4C10nHMFUlvHXtQl5V5j1AT8w7K1uJeEhM+MRsNk+9J8OOb
 X7bJBKilP3SyN6ag5YjMWNcXbumTl8ZeNt/nGjUCL9/Okkb8kJBkg2uHFrSac05mr6mh
 vupCy9T04vXgKLcJHolwoty3GCigAfXXH5NkfoDsn5k6ZhCTlzZ5ZHzjn+J/Y1eFy7S6
 FYp7KV9nWMC62AKDbaO0Nj5DDYyBIc2cTQjG80x5fBiUcjffr3L93bx67hzkfRUhMqAM
 H2jAbNdX96xB4ujII7xrog3OGZ1haopP8yV9/6/h0Y7trdZ5fPN2nQpJax6yEF65b3T4
 BIRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772712194; x=1773316994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IuMOilKQ9k9Wi6+SPKTq7NtdvbPDI4EMOkI66dOrp8c=;
 b=CEKWqqu9YrgKW+iABsEgNzisI7t8hO0LA9UxH+bkbydcm9+SNg3LGVCgFwBoMQGn0B
 hfB0/KTHvvnEtsxawchBTLO1fun4w9EYWjw/vxNMDf9po52mWFMtNKuK8SGmhVjCMxtW
 cGRmNHpJhX9wi6DHYDhMApW/7uU7faml5H+DEP2EkmGiW8YcElwHZCfzokjcarditcZ6
 UqjEMYPBwa3X1SfaKSae3B0AH/xKJ6qAQuGbaZfHdKxtSZMBdfaKN4jCUFoau8plsNdJ
 YVvpEpSB3BsOje00S+vWvL/FzspEDQUsJaKS1zmYHOUskECoZ+zhvvf6F/MEVgqb6WaM
 fH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772712194; x=1773316994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IuMOilKQ9k9Wi6+SPKTq7NtdvbPDI4EMOkI66dOrp8c=;
 b=tf/z6L35FlzD91+aFknH/yO2wdcoSpt/XiLAde9vkLGN0bybwouv8wm8Xpem4krTfB
 AAbP1Oo1YgCbrCoEN7e4slScyY3bTOo2Wl6yOAmZV07PW2k3cfF48LwFwQGDd1biqvuf
 OfrrnDEBpWYXKGAh01I8z+ZanxdjqOwm4TMjJU3/Wg36eFgdG6gLdPrTJ48DWINJcu2m
 n1U/hnhnglBwEgXYPwyXn0EjYZoNbctZ+K2Ss1NWYC5MH3DZCTmLthGAPsMcchF5A3bV
 Sf9KrI81Z1IT3XcPXgduouZ62GblUaJ8yzhhtKUyEgtu7gPCbe8hFe7GnYvZk7VNXH0e
 0W1w==
X-Gm-Message-State: AOJu0Yx7y40Y2cKePQKJMipt7FfYPEJuEoN9VX2JE3N9V8MPPAtmkiyR
 NWfZQrR/bxJr8nkcydkrRR7yY2zt578TNg8fq51bwguTNkSLgvoDW58HEnv2P90jJlt9yRKz6nJ
 sievWIO5XU3rYYbkhpTMzvPgdviVsuXNBH1PhnOYmfw==
X-Gm-Gg: ATEYQzwEjCE5s6Fym73SplhiYxNjVptZfmLn8ncgE+lUsKM4lA6iHGORqnC/iyGE0zD
 fFd5V/yOqANNCAWprGsrW4Pw0n6DT0VR8/CA5XoPFGyc6aGswhoM0PuPqKucx2rVmvjB+Fp3+nC
 saXhKdpEPsMy9LPaaVA8PUAj3GU9IuJjk2HoqK7T09osiGp+UE64ra06bcvGA+dEEeUV2eo9/JN
 ZHCASWWtG0Er/+eDX/cZ3xWbfpUl3U38o7OQ9i27fQbBbYsUa0awscgq0knEzkRWTTlyDujh/jo
 I0H6t2rFO2ztF+oBv9/cXQjH7/whbLoWSMyoo5CPWiDsHMpQphKJ/OAm2TzU116oseIW/oB+vvz
 CBA==
X-Received: by 2002:a05:690e:134b:b0:649:ef06:1622 with SMTP id
 956f58d0204a3-64cf9b31708mr4146690d50.1.1772712194279; Thu, 05 Mar 2026
 04:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20260305111832.1068093-1-peter.maydell@linaro.org>
 <aalp-ZyIcGIQ6IxU@redhat.com>
In-Reply-To: <aalp-ZyIcGIQ6IxU@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 12:03:02 +0000
X-Gm-Features: AaiRm50CkF28IKZlJw_h8q-WMDNL_3jH_yYK2qu4CMRtjxTAZ5dCaWAL0SrWybM
Message-ID: <CAFEAcA9-PEYiDb-hoOgN=po9Mn+kNAJwhvmngA06e8s4muaB6w@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 5 Mar 2026 at 11:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Mar 05, 2026 at 11:18:32AM +0000, Peter Maydell wrote:
> > Here's a patch that takes the "just work around this one problem"
> > approach to the gcc sanitizer compile failure.
>
> The alternative is a "#pragma push" to temp disable the
> -Wstringop-overflow warning, though that would need to be
> done in the 2 code locations triggering the bogus warning,
> instead of this which does the single code location that
> first confuses GCC, leading to the later warnings. I don't
> mind either way though so...

I preferred not to do that, partly beacuse the warning
is triggered in three places, and partly because this
code's use of memcpy() is pretty confusing to me and I'd
rather we kept the warning enabled on those calls if we can,
so we don't accidentally silence any genuine overrun bugs here.

thanks
-- PMM

