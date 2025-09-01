Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D275CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut8BS-0004DT-MW; Mon, 01 Sep 2025 13:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut8BQ-0004Cj-IN
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:19:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut8BO-0000vY-Hx
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:19:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d75aso640610f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756747144; x=1757351944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sCqZB25DUfcm/4XKxVHPvAeQgXjO4vMXXkVVPHtE3o=;
 b=j1FOPXEhy34vnv0cZRsJMKsDEqcWiUecj0eerIndpV71ZoyAJtUoh+AS1Y8Y93LRt1
 SwPJVRCMspHkjL6LDAXXLaaXcb9SVeEx+MfBsbAMdUpk/sObEmiN+f1zZPoywPT1PrnX
 L/VIU5+ACbfKw4ZYOK9HPWBjMUNXJNFh+pFbj3UzkGy8rzU3g4REVSxcFxPo9efGp/41
 Yp6E44LRMoHE8g7a4UaCXa1fVuRYZbjYML0eWwh3pU2TY48F/xiO4fBzpvqNErGr18mC
 ZYwt8Gg851DNhkJuLsAcbWYBQYFGRcNr70B7wBceSO5+bLB3tJdMxk3bfAopN/4CblKj
 eMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756747144; x=1757351944;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1sCqZB25DUfcm/4XKxVHPvAeQgXjO4vMXXkVVPHtE3o=;
 b=r6wD7M1L90i4IXcplhlJjjNIy30K43MpVXIeMy3fNQTKuiGDRcE+VzkwM8zIFYb1OL
 ntLgklHm9QXA0Lq87M3TQVB+iANoF2CXHGFeLEQNgjEUxDXrccH8JHAXZIcl44nAncxS
 GjEVvKXBcXiwpZP5fxqukuIs77Z5dAQ1SfMkjMxPywM/x9BDMjKjSrgeBoTNd7G8bUCl
 z7i06nphyHGR75ezF4IOhF+mXD/pwi8Zftbcr06PQAWBSue3G088ShDt/2cJbhtRK4ht
 nlL5TxSPCrcPM3d1/vYbFA3ZHVap4J4DfN22i7wE40XEAlb8LxF7OowTDQdXf0HFxiGv
 94lg==
X-Gm-Message-State: AOJu0YzWR7NQh9m2v8HYE88lzxbX7AJgbhFIYjsqk1GiucQWhadU64dB
 bJhAjVoZiFJHuQK+Iz8+clPslcHSmSKrxsfal3JPGewonkfpXEfQzDnELLqgq46IuRU=
X-Gm-Gg: ASbGncv3d6OVYeDMtpOlSzSqDjyzBVfYmlm3SyH7yMNQLaHkRxWIqLW0O6iUOPNV/PJ
 eIu6nOotQYJUAXw4A0E6YDnaPtY46m4Zvk3mn/rVLhtbhgrlszMyEzmvUEmc0ncYNewl0BQTDu6
 TZ6yXA6ao9FvD5fcfYgHheTfKVVFr/TfGfc5wKEulS79eoVoqU4grKuVBt5P07uBOKyfKq3Uctm
 cb3IF0byOY7jwx25H59fAinQ/Zm3yDREK1jcmYyKB5TMxLZwFvk8dhod5e6enzSPyQp1d9jlrA+
 AeAkTzKQ75/K+Qg29SKRzULdtfzvNcP9J+d4r1IDMYRcUXTLjv2M699vLxsndDBZfJxHCDSA37d
 +vWTI8S/XNPNjedCqhX/qxZfBGSBWgg0QUg==
X-Google-Smtp-Source: AGHT+IHf4XtF3R4nNEcYqWb5xnCRc4YVZ2xSTr0Mht90V/zwbhqs9g+o32+fEei//O7yEAW7bfZV2A==
X-Received: by 2002:a05:6000:420f:b0:3c4:2f45:1503 with SMTP id
 ffacd0b85a97d-3d1b16f0bd5mr9675400f8f.16.1756747144002; 
 Mon, 01 Sep 2025 10:19:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e50e30asm165673725e9.24.2025.09.01.10.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:19:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4705A5F81C;
 Mon, 01 Sep 2025 18:19:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org,  Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 2/8] hw/sd/sdcard: Add validation for
 boot-partition-size
In-Reply-To: <1fff448da042bdf8cff7733ce67cadff4c540f1d.1756706188.git.jan.kiszka@siemens.com>
 (Jan Kiszka's message of "Mon, 1 Sep 2025 07:56:22 +0200")
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <1fff448da042bdf8cff7733ce67cadff4c540f1d.1756706188.git.jan.kiszka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 01 Sep 2025 18:19:02 +0100
Message-ID: <87ms7e146x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Make sure we are not silently rounding down or even wrapping around,
> causing inconsistencies with the provided image.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/sd/sd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 16aee210b4..834392b0a8 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2818,6 +2818,16 @@ static void sd_realize(DeviceState *dev, Error **e=
rrp)
>          }
>          blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
>      }
> +    if (sd->boot_part_size % (128 * KiB) ||
> +        sd->boot_part_size > 255 * 128 * KiB) {
> +        char *size_str =3D size_to_str(sd->boot_part_size);
> +

This could be:

  g_autofree char *size_str =3D size_to_str(sd->boot_part_size);

> +        error_setg(errp, "Invalid boot partition size: %s", size_str);
> +        g_free(size_str);

which drops this.

> +        error_append_hint(errp,
> +                          "The boot partition size must be multiples of =
128K"
> +                          "and not larger than 32640K.\n");
> +    }
>  }
>=20=20
>  static void emmc_realize(DeviceState *dev, Error **errp)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

