Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D8FC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGfR-0004yN-GG; Fri, 12 Jul 2024 09:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSGfQ-0004tu-7s
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:50:32 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSGfO-0003w7-B0
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:50:31 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52e9fe05354so2957512e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720792228; x=1721397028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+9IPVBHxRDUF2xs+deI22t9NTaCCmEaHDbgb3B+DBA=;
 b=u/fcXVfu42u3EO9CkGQKhr/lQR2M9Fq5B1P9ywWIgNt/+jbxC3cWo4xv1pXw+oJNE7
 LNPGdwsuz/WTowREQbwKhMMjb4nRZ091cae/oOIeS33qOoDrBbAhPImJ86VYRAFCVzlz
 LpSbSA8WXL71qNUu7+4T+eDfk0PTbQTR+bmxHwv0G3GxIpSmYom8ObZ30iHltI6ty95o
 aKS7GVMs3CNpAqNUFL0PLbQgLD7T2qfI4CvSNNX8ePhTTSN7wTpSFXXEdxBFEYJhq2NI
 5qKnf58UvwZWNsHRV9jRwUqTwxqMy/G3YyRpI4u0kh86/uuyE51b/wCuwyEELyQCO2UL
 DtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720792228; x=1721397028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+9IPVBHxRDUF2xs+deI22t9NTaCCmEaHDbgb3B+DBA=;
 b=KYnubVMxB0o7zJ+Y9Bn3aGBh3UnETX1dmSmSixknOsnTWhOqZmXNLJAAEmK8sGemR6
 WWDcaNnqTcXLHgkdpryAgbUieozW7dgOoXlRu76RlR4xCbYihV7B3rzZPk1f9Mi4oe/l
 AVaa7/HQ4Bn6hxP6G9VEH1tqCkgZawxNnBivpAF0m4vwA8k70bYuv5Tt1H8TZKkORZiF
 3LoJjqyeQt29kumjp31qZ+Qw6jIcJFpqPOnRkfKfi3+ICn7KDTgxsYVuXyq2xFMw2yyq
 kdSosWT23CmP7v3vl7BBAp5MGoryQJonqkLkJV21WVhKMJF2fLXbz7EStPtj7LfKuLeS
 w6fw==
X-Gm-Message-State: AOJu0Yx2sJ0nCfXGFWchdh3htK0XioFMUs8ZX/eJ/IBslsBwR2NqoCW5
 WuuR1LqDBQhtt4O8nVWzSAr7SBs7IpMtoqAs3QAfeBbvYqPzh7MOVYuAxGmdsZRxVYljoqC6aX/
 MqZiFZ7lKMcoblrAvAudniYCC7uNf6B2/Dmly3g==
X-Google-Smtp-Source: AGHT+IFszUOmdGoMu7NI7X/GjzveJkD+VHc0NeQsp4KsncsKThbRtwLglx20kWMSbepfIe5TBqbH7sW2xIk1WWhkQCc=
X-Received: by 2002:ac2:5f74:0:b0:52e:96d7:2f35 with SMTP id
 2adb3069b0e04-52eb9995334mr7045146e87.24.1720792227990; Fri, 12 Jul 2024
 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240705220435.15415-1-philmd@linaro.org>
 <20240705220435.15415-9-philmd@linaro.org>
In-Reply-To: <20240705220435.15415-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 14:50:16 +0100
Message-ID: <CAFEAcA98uHL41zH7BQrn2Q_Uu3w_HQ8YZkXRjEioYBNfPbcZHQ@mail.gmail.com>
Subject: Re: [PULL 08/16] hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Fri, 5 Jul 2024 at 23:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> "General command" (GEN_CMD, CMD56) is described as:
>
>   GEN_CMD is the same as the single block read or write
>   commands (CMD24 or CMD17). The difference is that [...]
>   the data block is not a memory payload data but has a
>   vendor specific format and meaning.
>
> Thus this block must not be stored overwriting data block
> on underlying storage drive. Handle as RAZ/WI.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Message-Id: <20240703134356.85972-3-philmd@linaro.org>


> @@ -2187,11 +2183,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>          break;
>
>      case 56:  /* CMD56:  GEN_CMD */
> -        sd->data[sd->data_offset ++] =3D value;
> -        if (sd->data_offset >=3D sd->blk_len) {
> -            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
> -            sd->state =3D sd_transfer_state;
> -        }
> +        sd_generic_write_byte(sd, value);
>          break;
>
>      default:

Hi; Coverity notes that we almost always check the return
value from sd_generic_write_byte(), but that we don't do
that in this new callsite. Is there something we should do
if it returns false here, or should we just mark the
issue in coverity as a false positive? (CID 1550397)

thanks
-- PMM

