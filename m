Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52234C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYP5D-0002en-7k; Fri, 09 Feb 2024 06:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP5B-0002Wf-C7
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:30:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP4v-0005rl-Lq
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:30:13 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5605c7b1f32so1149628a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478195; x=1708082995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95O8kmPD03feUB6gqwsumad7Tq+4Ieyq0JHjPy9CnFs=;
 b=gT7UwyvZbUtstn+mGs4NjmKHfxpghL9zOOr3fmjWHkd3yP/0SxmnWlTybNNQl1efwl
 HhE0dB+RUVO7CKADXI93b7+tXket9xZrH13XQD6kGP3jFW7xQhe0WmpzMR8mjMWyTcBY
 ir2tz8HZ8PCEbd2kHyVONGG+xRzcH/l1cSi+0jQ5171HQ7RlFPhxm9TDWQgN4QNb//EE
 LzjQYAzJzfpOevNNz09GddIx5X/sBCrhqA88wB7xRW4yn45e2FYaGpjY2ob/dCsN0Zqn
 rObUrRLcIkOPbOGvuw5kQfv0gjJtsLMIBcQgmNjYJ//bkR6nQYqiLIgvYKlDGv7coXan
 1Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478195; x=1708082995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95O8kmPD03feUB6gqwsumad7Tq+4Ieyq0JHjPy9CnFs=;
 b=KfQzxOT3B3fCeA1wDEtNx1Rm4xLiFNklfsCo1UV4hjgLy/DdXTbuB2pYOXtbsnrDYY
 uyA6ukHYuWWG3IMJqX+3FcLemBZtctdu4lKZ9aGUPOPbFPwad/ApXFr0DhzC1WMl2WXF
 sU74i6Z6Gaq2ukRy4p3xmHGu6fzG9agKLWf64gRsluOaaM30p4uGKhldSdE2R9CFWslt
 9QcNpAPEze3Md9KNgomxazC89IXMfSf4csvXpp4Lr3WhUxcmwzvWM4oWC8DPvxXmgNxZ
 te1usI5KDUh+yfoSy1Vy6WGuw3XNPjEjI3mpRVRGUrlvVlXLj9Dr+91ypyr7+hMpoHPW
 s5DA==
X-Gm-Message-State: AOJu0YyVtYEI/I3vfRShZ79KD3PMDlOCD52OaXH59jIyF/cqGF61klAJ
 l0dwU6gJs3/Qo4OaHXvyXjlly7CybiO2QHlCLDRvnNaqCQT04r8MmhCH5+2c5Sa3gjk4ywKsD3J
 Q2GIf1oK0tcPZNY1FVA2HsjLG4d7QmfsqDB4RPw==
X-Google-Smtp-Source: AGHT+IGKCGo467lzrccRMqRIto1qQc4q9waeKh0aOIoNMViPJtxytg/rMPJzsBaoRokZqeAg8nch/xQDLiFsJLKLRsI=
X-Received: by 2002:a05:6402:1c94:b0:561:51a0:2877 with SMTP id
 cy20-20020a0564021c9400b0056151a02877mr83210edb.19.1707478195532; Fri, 09 Feb
 2024 03:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-6-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:29:44 +0000
Message-ID: <CAFEAcA_RQmd6JoULKAwr4RUL5hPEbfc9UqKZV0vs3LC9+5M+Rg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] hw/ppc/prep: Realize ISA bridge before accessing
 it
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

