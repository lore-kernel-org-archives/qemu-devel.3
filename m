Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EE4FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzJG-0004am-NJ; Thu, 23 Apr 2026 15:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFzJG-0004aZ-6I
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:01:58 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFzJE-00038w-NA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:01:57 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79db5e18ac6so85055557b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 12:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776970915; cv=none;
 d=google.com; s=arc-20240605;
 b=j9WDkMPGkRloKyG1QctHYro0abvqhtJsh9bugNmYeNewd8lotV3uz85RKXcPZcHT2b
 zZJfOhcqL1Ll6mPhwiO4YLfR9Wsrc14k5TFRwX3g0xkfTaLI4VUJXGpYaqMip2PzTK5d
 MDT3dRHpmQ+o/7DWTDFgBxsJ2fUcKYkWn/fW1mqA5MOg2rs3ZjL8h9IDC3puVRF0oVyM
 iKWOuro6I6xhDNf30lkC30nfDMjC+wrF7AmlTGb74ZEIJz8cLnw0rhyFwMPZY2/cyx1s
 ZkvonBkoDQYSMBuak/Jdb5XCBr9U/T0MNf1XHmN/m69YXPI7THxyF2KBiHurXTvODBoA
 q2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B5zwKjAIc8+MGHRRSySYoKSERnHY92hjxdFN/pjgdK0=;
 fh=bJmps0/GYrffiBUvJ9cR3IgPCmpf4tiD4yrJ764HH8M=;
 b=UuhK7mvjDtQHl4NRQsCJIQLhTnP+OdkfIpEEu2iTzpOP78eLJt1rtEERNqsCZOFdO6
 AOPTZUBWBWt8CyN9JRczR3ATG+n0xtcEbGUtSjPjTCA+vZv+n+oES3lJsVh4/qWfNze8
 dXtiRYamzzvsdlVH4SMVnDgRxnC6/k67KM7O4l+6q8vPs7T7BFVlWnpYYXC8XUfsm2Fy
 64P7vv2OiXRCSAJtXgUZKhL2MEDeDzafWADwAwd/PZwLoRhvaPBqwc2yGeuY0Wiqqw54
 sht/fnhRwpt9/u+8AwedQuw+gyQI9RAUUEE9w+63ayb8WPcFFpptOymPSQhwmKQj98lI
 34rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776970915; x=1777575715; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B5zwKjAIc8+MGHRRSySYoKSERnHY92hjxdFN/pjgdK0=;
 b=P7dYTZEanCyBFqM7U60E5KRMnvy5/BnUQbvWYZnYF4curv4CND/pTFLSCpTOaVoeUj
 NIVMk2FZGR36HRmJ7mywc6NORKF+fwxLeN+rfpdTyn8nKZlE9d75J8lY5G/sNKNCmSST
 iHgoPozURNOGijhOMIuHjodeFt4a5SOeJbF6gsV7raJ5hQRbPf3kUNVwTPkSf91B7cwx
 ZjesAp7pDk5dDFN9ri/YhYeLx406Fxei/Vf/4rWUgiSdjByLP1+KBZtTRhPbr+bU6RD8
 MhciJkb4HVQAqUTtf0LRp/7oAnhC27bu4W2Tf/QwzsZIQsx3c43ARsX5TlA3xmPlL13Y
 vwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776970915; x=1777575715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5zwKjAIc8+MGHRRSySYoKSERnHY92hjxdFN/pjgdK0=;
 b=DyOFci491P36qrGiaw5h2d0PS5W4Fw04CUQROlZWHh1etK9nCIYba6tMZdG/PF2GDl
 30FWl54VUxrHFcx8SS74V5xVlZSrRmk4DA7+50KDnkSTHRHiRDYQN16xOi6ql742JPwL
 K5Q92VowFNemMOD5Uo37LBHRsCxgwX9U2qU7ZP5k/lK5kplvjKymW5ybGDYt2vK8F1Tt
 CpxJDQasAW3hKBDjjzWRVesDOlURHs/wFqBJaS94y9NMlbCBPiJK9KjuiqtbM+QCV3v0
 441mgusaEw4Hz87uFlopBl7txJVfZUzEU3F3PEeShRkjWhYzZV0zv4c9ZKDLICc9gIfW
 9nOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h2IdfSmyW0FlXWnAikYp5OnZ+8u6Qd7pBFnj/aYmOEiLWX2pR/Yw9/HIkEK2x2Zmd7fuuFBmSdO6V@nongnu.org
X-Gm-Message-State: AOJu0YyLIj89uzkqUfgJWvQJ7d5lDuLFhiI/ViOIFAbURPFlbBOufw9g
 dAWnQLU4QHnjDmuIrWEzAcdQ5W2iBAxwYGEdTzTdg1C8y8Zgwrh5Vq7iCwG5iNO6EVZYgu5vDcT
 DT6k7YicOoPNdwVZchO2JFQbA88U0ekGfJ563GN5ksg==
X-Gm-Gg: AeBDiesOjopruiVmprZoTbYCp3Pfl5LPabZezOU+ZB1c2vKciui7i/yQrSYGdFprlT7
 5gAGXUEPrFvfvVwEDUtkDfuGPa/ZKPWOGNTRJaCbw0ZyR8Lz7ijKSdo/6O+NLnM7Tm4w0nFVjz5
 T2x+VPcTlQRARkA2R69S5UUK3fl6QrPrit172wz9uFEUXOUIIPk12yhWARvXGoB7Uu2dGZJtl9P
 F5Jlk/L6TnGIKoMoOdlP6sAqzjgw821uQsL3gj3p1BeWMhfGerShRi2EoDviPj698YbsiiVK16i
 L/Y1QVhsx2ezncXUVYzkHxmiPIexpZuqrnat/HjjPUPaQGG+jprXV5PIhWfuBbjZ97hNFDNN5xY
 +cA==
X-Received: by 2002:a05:690e:4842:b0:654:6a61:fb60 with SMTP id
 956f58d0204a3-6546a620b17mr1618358d50.26.1776970915483; Thu, 23 Apr 2026
 12:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
 <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
 <ff06a5b1-f36f-ccc9-3d8d-90f3fed1320c@loongson.cn>
 <CAFsMJvDO8CPt1xAYMBc9JWEE6FPsvNZjwAtWEAsQjVoMneTUNw@mail.gmail.com>
 <23e33b6a-acca-4e01-aa3e-d702aa45ea4c@gmx.de>
 <CAFEAcA_SdysnnbwVt0SLLA3=sjzNxKwxUgE7Eue3XPea8od4wA@mail.gmail.com>
 <81a244cd-2ba6-43ae-8071-90df3c52a1b5@gmx.de>
In-Reply-To: <81a244cd-2ba6-43ae-8071-90df3c52a1b5@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2026 20:01:43 +0100
X-Gm-Features: AQROBzC3TRcvGFgFbQ7v2JSc4NSIigihMYMo-G7Hp5xE9YScB3lgzz9XDQiVRIs
Message-ID: <CAFEAcA-fLKTi_E5MMvWCvhnyggzkt+RsWNbGX4wOfkOYxV0Aog@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Helge Deller <deller@gmx.de>
Cc: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, 
 xianglai li <lixianglai@loongson.cn>, pierrick.bouvier@posteo.net, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 gaosong <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 23 Apr 2026 at 19:33, Helge Deller <deller@gmx.de> wrote:
> Thanks Peter !
>
> I've changed the commit message accordingly.
> Should I add an Acked-by or Reviewed-by from you?

Yes, you can add my R-by tag.

-- PMM

