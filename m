Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFCFC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQjK-0006cT-S5; Tue, 20 Feb 2024 09:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcQjI-0006bz-Lf
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:04:16 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcQjH-0008OL-1l
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:04:16 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so7389925a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 06:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708437853; x=1709042653; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HcYmC+O/kaq/mMhRCiy/822wCYlWWBDeIseRTPuWak=;
 b=QekDMBxxE+6VE3Z9Fr4GjbM67Rhikk/3j62w79AJjrcKxSy67MRx0OvaTx7274PAW5
 qfc68PzLxQTzvwjDJ6MvSqTd9LdLri4RQmorUm/Zdw4ud7b9Kc9DTL1W8jfT7WqrJxme
 7RZVFMVrbUoyy/SzJR8S3KVmqQNSUK8zcwQK6ExrPEx3KbPzSftSIuYGD3lo47jfKS8U
 cCcK8eqotFBZn44f9IDQImkSE6XkisjVOPaV/jsYaQpsOxaU+pXNb6+Tpa9JxnkfxIXW
 G9f0w26ZteZozDTkkRIjEl3YAkOTlRdBKJTEtErOUnbDvLma2R9G1P5lWciCUvNyO2yY
 kSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708437853; x=1709042653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HcYmC+O/kaq/mMhRCiy/822wCYlWWBDeIseRTPuWak=;
 b=JRBPqbD6Me7uLxomSSiiK2PfSb9+WXE0TPiwPFO8JYL/Yhfkr8zLzwhFPcZptUnGOW
 BqtYy+LmDTiDSV1h5uPQo9AGqaW8wLtGPADaqVNW+vCkegv5FfqTr3khCt4AuVTd3luI
 W4nWjVSJELH/q26pSKhkCgG4IDYTF1Bgr13VlptCfXePgmHAFO75tNC7vySpqWRs6Hyb
 HqdkoLWisOQFcDqW318zUZyoHl5qRmV2aqv/Eaut3byWk96W82/3j8thDQLWN5LaSx+g
 mwDcg9OCqi/mOhdpslGJIacEpxQN+Qa+94p3UqPSEDrieFwYpUgQXMmcHsT8p9rz4t4V
 hWGA==
X-Gm-Message-State: AOJu0YwHeqESppfhnw40v9x0TKjwbIA+FJTdL05q4yIug72IfP9moWWi
 D8N+hmQmro0RXf40FH4+bJ7GUpAEaYIoJMp86W1prBiwpwGEc2fvWUwtg4VcfV5Yi7LV74p9VcS
 QjBUpGfZa75ixCf6s0CWk/qcqOYOn4mzW36lE3A==
X-Google-Smtp-Source: AGHT+IE3+Uo4bJoUcdMjVLgsrEPiRA1kRe4srUUoPb0q0r62EC6koPVaMf8zABaj4H18OjrZFBXRQVM4BsOHSwHfMTI=
X-Received: by 2002:a05:6402:1b1a:b0:55f:f94d:cf76 with SMTP id
 by26-20020a0564021b1a00b0055ff94dcf76mr10101954edb.27.1708437852739; Tue, 20
 Feb 2024 06:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20240216150441.45681-1-philmd@linaro.org>
In-Reply-To: <20240216150441.45681-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 14:04:01 +0000
Message-ID: <CAFEAcA-SYyXN94cH2mmVynW7LPB-YoSQTZ_E0WH18ra0UGB7-g@mail.gmail.com>
Subject: Re: [PATCH] hw/sysbus: Inline and remove sysbus_add_io()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 16 Feb 2024 at 15:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> sysbus_add_io(...) is a simple wrapper to
> memory_region_add_subregion(get_system_io(), ...).
> It is used in 3 places; inline it directly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/sysbus.h | 2 --
>  hw/core/sysbus.c    | 6 ------
>  hw/i386/kvmvapic.c  | 2 +-
>  hw/mips/mipssim.c   | 2 +-
>  hw/nvram/fw_cfg.c   | 5 +++--
>  5 files changed, 5 insertions(+), 12 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

