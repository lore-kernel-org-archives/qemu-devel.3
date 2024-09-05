Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F275CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC8k-000167-KH; Thu, 05 Sep 2024 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC8Y-0008Sk-Aj
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:03:00 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC8W-0002AJ-8y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:02:57 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso864796a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541373; x=1726146173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwnn1XgdkvGh9rrbYATl2uNkRA38AcvdqPQRMxn7g48=;
 b=WRfOay2wMQJenotypXcyg2Gpe1aXiatUqdmh4H6sWRzY6fWXlxeS4/lcFl9slQxaOU
 lTns+BOnirL+45/V2Qw4Kugtcef61tT2qovsgMZt3ssE/UJJnvYRKG9icy7eLaONP9mN
 EiIytphFAZWHBwRATCw3Ct2ANUaubVgT+VWtaRt8ZwAPbV8za7d5T2tjz8wvn+GI2Uv+
 OV4wdmGuiG3/J+rBFDGNzcl/8dvq8D8ZKX/uIVi/lxVHmKu8y9WQQi2mJw6E0fAxgTx3
 /oGmwAw6uE+dgd/Ehp++VPNYxdm7uRlP8w3lW48ZPALSSDNoBg9sm5wPreZkkKfsVuWN
 tr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541373; x=1726146173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwnn1XgdkvGh9rrbYATl2uNkRA38AcvdqPQRMxn7g48=;
 b=YVS1aUkY7ktlkaIHMHjsLPhGduzoV/RqEEH1x8N8pYRafv+gmaFQ8oACLnODfi2pbv
 RLbK4espokGkMWzprIbzIdMyXLLUaqXynSBIBCBrsdfkVGCc6yEcWTsG7cuVBAduD1wJ
 Y7428lm5Psc/F25PKenlQwhruhy0H5Rg2Ok376osmIhy7HkTvrgFG0r38qN9cjwnh9Un
 EU0XHJJfWHFu03HLoLpDNxI1TSeHP6OypXKO4cPrxF7uQU+mJ/SnnO4EeJwkJumQtf7D
 brphFcg4KajPYyo/3iEfa7UbIooEgzeAtQ+ztPyTcQfNdEXGX0t++QpYA0+zfFr9KvBN
 tJeA==
X-Gm-Message-State: AOJu0YylGm1u+MIDo/ff/E/urGM8EqNzqCF9n1rX8RK97WG95lpONhTI
 Ucrb4Kx3SX9cpSTAhLRZ/ROYKflsjn4dHcGbxAa/Uoavoh/jgGBHYXJ/CPpZo9ukq7zogDJuBfu
 Ie+KAyGFPRNPHx9TLcG9Whphji258Pjp1TdGsfg==
X-Google-Smtp-Source: AGHT+IHuk5vVn71M07bqWrqA5LQ4xwYNrAysM+fssQLHDk77ddSciZL9cQ0oxyggV7o0rjmlGJLhfVkO+BwZMpolwms=
X-Received: by 2002:a05:6402:1eca:b0:5c3:d8fd:9a3b with SMTP id
 4fb4d7f45d1cf-5c3d8fd9c58mr246637a12.28.1725541372714; Thu, 05 Sep 2024
 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240905073832.16222-1-shentey@gmail.com>
 <20240905073832.16222-4-shentey@gmail.com>
 <08360075-385e-4083-8dea-5e2275d02834@linaro.org>
In-Reply-To: <08360075-385e-4083-8dea-5e2275d02834@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 14:02:40 +0100
Message-ID: <CAFEAcA_x6zwG+V-E_Lzr_3njQ2W5PN5=BXVNnOT11K3jMxTC5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/char: Extract serial-mm
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Wu <wuhaotsh@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Tyrone Ting <kfting@nuvoton.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, Paul Burton <paulburton@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 5 Sept 2024 at 12:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> Could we start recommend to also add SPDX tags for new files committed
> to the repository? They are clearer than mis-copy/pasted license with
> typos and can be parsed by tools.

This is probably worth a discussion in a separate thread, not
buried in a comment on a refactoring patchset :-)

-- PMM

