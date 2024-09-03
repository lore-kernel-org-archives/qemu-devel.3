Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E6ECD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWPP-0001lf-4G; Tue, 03 Sep 2024 12:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWPN-0001gI-RD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:29:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWPM-0005l5-BS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:29:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374c6187b6eso1674842f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725380971; x=1725985771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxydAC50P2yhfEpJV1iGTTsx8xJMx9M15YH/lNRL5Tg=;
 b=LynotDMAWYDacdRxJP6bPcEH4TNmkqchyxQDHNYOMGsPPXQI4Yow3xvqGjMYg0OUfC
 5IV5ZsNgRzzcBwC1QYu03TjjYP80Pug8tyFd+1PlUUnEZY8ttecuelMuuc/esJBC/qiX
 3AQMq2KMEDS7gpIaSHYTHT34SfyIaeTZlbyLN9WNrQRRgIAytjCNuEhxe689R2YNGkwT
 3ZswCWOceV2vq0Qx+9t50YpyUl5WdG4d6N1aizzJdnagNmwbP+7TX+/CO+gHqOBKKUob
 GAgF/OEXwcJ3C51F/uqo/GxiwZHQKIRTPKPFoig8Mqy/gMWDvTYdVldoCguhjNk/sry+
 uI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725380971; x=1725985771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxydAC50P2yhfEpJV1iGTTsx8xJMx9M15YH/lNRL5Tg=;
 b=Rf690TIT2zaZ/1Vl24ufbMJ2+UusPfDi6gei7JxuAEaW/dP85NrhdTk78ULFduZgH5
 jMD/6hZY2ft+oYHJGADXwJFhfzH6L8T4ccib5zUf5rSWO0i/e4ZhZnyPjQduveS7Tgcq
 Ab1K3xDb9t0kEJueoHvPkirO93XJn/YxhuCwEX7SZnny+j1LdkqLDwR4m3C04JF0T3Vt
 1MdXtHszKZsA7xyYF/aSnzIuFhbrmuVqCf8m0P3uL+z0aid0o6lTrQcFPO/AJG5bb7K9
 YGJfBY8qLDsUiLldKhwo+xjVhVlFg2HdVCOUBZI2akUuNRAkMqceg7Sh8Lrfz3oQdfCW
 SlsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDhcBHTEUjeDal/jcdlVM34O+ufOYmrnRkXipccpTKCRRfvQcsM1ixxFwAmvClPoCDcOyEM9nlvaJa@nongnu.org
X-Gm-Message-State: AOJu0YySgYSPRlb9Q+KVCN7K+7omJTLdoN2febqUjdXcqkV4hT+10nzI
 DUGNQq0AuEGmBjoM51ePo6NAsLRJN3UdCes09kPTVPI4kbqEh6d0CNjCoHWR3suXQoTNDnKJrJx
 K1MoNYv0f2/Z5xjp5Kx2ZHvaMzii+0OPwd8WUcw==
X-Google-Smtp-Source: AGHT+IHH+uVHY/PyyYQy6/IUC4OnuSJUu0gqYbt+sKxDstMhjeMuRtZJuV/WMM8NqrcOpk+oVWvX28kjyHAt7jHR3wg=
X-Received: by 2002:adf:a79a:0:b0:368:71bc:2b0c with SMTP id
 ffacd0b85a97d-374a954579emr10162601f8f.10.1725380970646; Tue, 03 Sep 2024
 09:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240903153959.18392-1-philmd@linaro.org>
In-Reply-To: <20240903153959.18392-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 17:29:19 +0100
Message-ID: <CAFEAcA9PNA=xqrCCH+4tcVX99nh3xfL1_p=UDJRVTCFLR2rrbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/sh4: Remove the deprecated SHIX machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, 
 Magnus Damm <magnus.damm@gmail.com>, qemu-block@nongnu.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

On Tue, 3 Sept 2024 at 16:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Remove the deprecated SH4 SHIX machine, along
> with the TC58128 NAND EEPROM.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/sh4: Remove the deprecated SHIX machine
>   hw/block: Remove TC58128 NAND EEPROM
>   hw/sh4: Remove sh7750_register_io_device() helper

Whole series:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

