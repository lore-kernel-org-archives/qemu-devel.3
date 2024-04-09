Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747DEC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBmz-0008Pa-13; Tue, 09 Apr 2024 09:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBms-0008Kc-To
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:45:23 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBmr-0001oG-Bn
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:45:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so1599416a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670319; x=1713275119; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKGxx2OlQ+3Z0q29r7RMLAlgnAXZwZsrFm//OAQVoFc=;
 b=hon731dXbaWkkyxuTgPlKcQ/a4GWxO+ANmhP6omnCQ0vjZsxIqW/+Fv1FcECuFdFSD
 JR4bQ46kHFHii3Iy7q3MJuJ2N8Ckhwt7aMsvgUVCtpTJhxPoW3/lYDAtRW8DVaysitdu
 kUIyhBVfgRI0ToC58SNUHj2X1hgGNUke/69Yj82Qf4DM7KCn8rr7OxP7CPMzuXfdUhnt
 V+0wf+uB0jBsVWohDYzuesuZTzHGpQi2oVKP5jtWoG0txFbcOYLg9rT/IDTNllgoWDCQ
 S1fV20q+xJJ1b8ccxRYZBM6S3seR8QK5xwR4K67tmvt1sd/CRa7jS+xJcgZ+1eInT0gy
 F2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670319; x=1713275119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKGxx2OlQ+3Z0q29r7RMLAlgnAXZwZsrFm//OAQVoFc=;
 b=RgLb5b8RKwHufcoF9YT0foPF2dYfpusIUlv69U4Kh+YFwOJyfsMbcpPZgC64DHOCnq
 rsjyaqipxDlEEu+izPIiV5eQtZDWettZM96XzPbEcqv7DkLnpXjE/YHvkyINuEbURkNx
 aRh21ZnJA2tjlAQlG7n1poTSehbEbKaQAV6wY+98LCrwBmOIvUdF4EYk9byh3fs5wuPf
 7jdwspQWMplSaoifDTKdp8rIKafR74KSLP9hd//XvoKANpMNj6A9tCrEzemdb/xSqcVS
 rtBx3zJGtCU2GdPQweGDRVxWbB3sm9FSWBH5NIcOFJRDfRVmXx+HIzq37L0d9j+1fjxp
 TT6A==
X-Gm-Message-State: AOJu0YyKSXrSI4Ca/l42vb5RJP8lAXOPU2MTMBlFiR2l/txijM4rchea
 xlCSh30Y8hudRDSfgk9PrntXwPsAvYIB8TsR5hgz+1rNBlClYjR7wcfhmtbH3hbxMm0e0ISTWtj
 7DthaRg9+4BqgYs6IR6cgbg3Bhb6rRY/VR7Ba7A==
X-Google-Smtp-Source: AGHT+IE9Oxm2mYB7mQ5gzKYwHNV3fqYJ/haYyLrxtmkHGzPnjwpkGMbx+/KXn+Csb+0T9KhB1WPHPA0JChBoc7pDRZU=
X-Received: by 2002:a50:9ea2:0:b0:568:c621:c496 with SMTP id
 a31-20020a509ea2000000b00568c621c496mr8964965edf.42.1712670319684; Tue, 09
 Apr 2024 06:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-5-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:45:08 +0100
Message-ID: <CAFEAcA__PD1ngOeiMhZjwG3rT77oZ5HSd4PeFkMX4fvSDedKXg@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 04/11] hw/net/lan9118: Replace magic '5' value
 by TX_FIF_SZ_RESET definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> TX_FIF_SZ is described in chapter 5.3.9,
> "HW_CFG =E2=80=94 HARDWARE CONFIGURATION REGISTER".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

