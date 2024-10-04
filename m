Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB62CF8857
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmy8-00012e-FT; Fri, 04 Oct 2024 14:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmy6-000127-VO
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:23:58 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmy5-0002ZS-Fs
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:23:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fac47f0b1aso30897811fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728066236; x=1728671036; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daj2G7v6GYNNMy/YdduAt2P4YOw8SO/gZvr0DGLa6xA=;
 b=h3q0omy8BpO9FP5XKwlgTc0q0+1Fn6+/aY5eCf0jNPBYTkXfE9JMcEWKsXLelQkFId
 A2TYzC/RsqCw/9rjej45EtNbhQabADpZc4Becs3x2Q52NL4cobi+vdeoF//ubPyxGX5z
 3ChcGL4T5m48WCHWCYWowEZV1qt1+th1BL40Q/x7CBjKu0urLF08zr/z1tkCiiYTU0mY
 4/yZAT7zTOceDlPd6E6pjGPKJKaewLN0zB87OPBAcBRcgZmwuRIhomJrshfUgHlLGkIb
 vS0Ruyp2OWK4jDwAbEeOgOjYTycoMbaUTKn0tYG0msNFfCsvKN3m1+lZVjUTu9uEMKkS
 fc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066236; x=1728671036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daj2G7v6GYNNMy/YdduAt2P4YOw8SO/gZvr0DGLa6xA=;
 b=YZRubMfi/R8HW1JwvXUigu557umkUX8SWnL9Pu8h7+ipEfTntqJUSf/DPTc8No58OC
 8FqGpMkJ6YXIXRNvgL8pBSXLYvV0GnfqcYzqXoSdOAMqBSUiqqgFJA925cpjiIbPbIGc
 GisswsxUuq7cCWrV3Bh76QLYUNRLqmzhSoiZqTBdSV4jG0RuNUJoMykz6jSPdxO3zLvF
 Pl4MBaPiqavVHnnc2ReUgXmh5Ypjd1GEm9EQJVf4H2hniLvzGmYTfYKnnWdekehPaaKR
 lMYVUCQ5LHCFY/eN5P7C5yd7a+IuctZNs2MiTxO6aR4L6RKZL5NdbM/eco50Os6RIDTz
 75ng==
X-Gm-Message-State: AOJu0Yz3xQjEJeksQINjuvW7KihT8ni4yvf4NHYA3rhWrWHgmgH4cKG5
 wJw3RCKuDbMnDgrSrv2kWr2yATnvzsL8r1Yjc6DxIx0eVp+gN9NTDh5zCBSflv4EwS6zpzx48w3
 j33701ZI+6gb49yF5AMRWplq95uNduVXe1PPsdg==
X-Google-Smtp-Source: AGHT+IFBJjEW1kMCwAyHlwhBlE1yj8cG75q4enI+4phx/Q3RWNwqBoMW7qYRVGmm2+shpK2fXPC8pnHyCzHVEzb8ySs=
X-Received: by 2002:a2e:d1a:0:b0:2f1:a19b:d5a4 with SMTP id
 38308e7fff4ca-2faf5cdead9mr13292311fa.22.1728066235764; Fri, 04 Oct 2024
 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 19:23:45 +0100
Message-ID: <CAFEAcA9=We-DwTezYw6=KApSQ14iExgdek8YLPTzU6HLLv_jpw@mail.gmail.com>
Subject: Re: [PING PATCH v5 0/3] Check clock connection between STM32L4x5 RCC
 and peripherals
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>,
 qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Samuel Tardieu <sam@rfc1149.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 3 Oct 2024 at 09:11, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> Among implemented STM32L4x5 devices, USART, GPIO and SYSCFG
> have a clock source, but none has a corresponding test in QEMU.
>
> This patch makes sure that all 3 devices create a clock correctly,
> adds a QOM property to access clocks' periods from QTests,
> and adds QTests checking that clock enable in RCC has the
> expected results for all 3 devices.
>
> Thank you for the reviews.
>
> Changes from v4 to v5: none
> (just added new reviewers in commit messages)

Thanks for the resend -- I've applied this to target-arm.next.

-- PMM

