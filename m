Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F50CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 19:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP3y1-0008V0-MB; Mon, 18 May 2026 15:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3xs-0008TI-Ax
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:49:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3xq-0006b5-Pn
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:49:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-452169ae568so1757827f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779133760; x=1779738560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgH/EpClVj36vD0mFCHEvS+oT8byVUNIwK3om4YJTWU=;
 b=fXRM5Q8h0VSXjOIsevPGTfzZ+BJuBqKeCwcK698hbkvH50Cd86htTJ6cct+ibsFU3x
 E0KyHMNp7j+IsMCytBc9GTPXa/87eAAhCdKAMR6exYjt9FwW7esQt+KLEaTQWzDJUKFs
 JC4IprjBSMc5JEk3cqg5wfL01jv9yvVWoYWDmsFjAJsUGiywGw1vyyXAv0ANT4iCLULG
 Yye/tBHyZPkson3zcl0TKBTcRwye3gc3NUAT1TaxonKP+eOUxnC+WcaCw5vWxejYYMv3
 1Decz7a2v1r9ioRKL9AtmLgTkYUjbW3mFQhv4lZIPHQHpYJDfpem0TrUOMK9e6grqefk
 y/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779133760; x=1779738560;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgH/EpClVj36vD0mFCHEvS+oT8byVUNIwK3om4YJTWU=;
 b=A5+aR9T6iXwQE2oOk0Pxn0CwUFyJf4biPt92wvJXyipRFqPdJh0f63sMYLRyv1VF8O
 uMOP6SyqFYtH2jDECwMNXn9/TXpRMShndoRhSE4hcxQEvk0gPIj1nKwhndj6VOSHLraI
 gBy1Br0fitLx2Ymk2rAG75hmEaJneBtIzbSjO1p9j5o0tA6GEo8lUIuxjJsy6Il6QztN
 hk2yatTZr46s435/QGFI3hZ+E8DA33booFPYR7EebwWqdOLXVivVwrdnLLvic7anTsb5
 C+qxM2SSS/CeAt9gNGQDYiP6lPUppakmxaMl9wsgornRPdR2oXlBgRyc83ThthUvF49F
 XC2Q==
X-Gm-Message-State: AOJu0YzhqLKVK40SVRgWYVIDR9RA6e0zZx9vJ2eCPme/Bx/dYrF01OUY
 CywSW3uW/WDQhMJB1gCcI3W+XHcYu996vSpHP+l+HkQPHsAS4PVILG4LDA2AHEQKE9g=
X-Gm-Gg: Acq92OF05WtPwe/4IqvPqzpwIzT0SaPTrMQHjvZIdwZM00hjytYqc//QIAapdwKeGbD
 00TuAtmTYUYQuFVap6gruFhNdxxVHIvdO1HekoT9vjjh1h2S/aCJrYfxXkuPT7FQohfWx3qdORV
 WweL83OZe9im3NSMPj935dtes3HGvXs4Y0S9p5akPZRnS/aGSv9U97FY5lj+vNHNWRKWdH7gWeE
 etXMcr8uoJo61djslrDphNGjWcMr6TS6MI6+s5V2SyqD1kGlyOM+q72naDwXV90dKEA1+yksBDI
 G0vsNLfkg4nLGzNifDEAR0Ontc0IAHZz0K6uclfdvy8m/BGa9KGNJIVqFWyhwiL04MO0JVug94x
 U12y2sQn0B6XcBpA3LBDHvTQzY26DTHZawT8NGnloIUxBYPU+WajmMSBYvVB086NWtBe1QPhMDL
 j1zZlR0IrqXbzcbddlJRNptj4=
X-Received: by 2002:a05:6000:2f87:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-45e5c5bbef7mr27222780f8f.9.1779133760448; 
 Mon, 18 May 2026 12:49:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm39693646f8f.8.2026.05.18.12.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:49:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D81045F7B1;
 Mon, 18 May 2026 20:49:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 dmitry.osipenko@collabora.com,  marcandre.lureau@redhat.com,
 visitorckw@gmail.com
Subject: Re: [PATCH v5 2/4] virtio-gpu: add VIRTIO_GPU_F_BLOB_ALIGNMENT
 header definitions
In-Reply-To: <20260317182049.33848-3-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Tue, 17 Mar 2026 15:20:47 -0300")
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260317182049.33848-3-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 18 May 2026 20:49:18 +0100
Message-ID: <87bjeccxc1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Define VIRTIO_GPU_F_BLOB_ALIGNMENT (feature bit 5) and the
> blob_alignment field in virtio_gpu_config per the OASIS virtio
> specification.
>
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>  include/standard-headers/linux/virtio_gpu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standa=
rd-headers/linux/virtio_gpu.h
> index 00cd3f04..252704e7 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -64,6 +64,11 @@
>   * context_init and multiple timelines
>   */
>  #define VIRTIO_GPU_F_CONTEXT_INIT        4
> +/*
> + * VIRTIO_GPU_F_BLOB_ALIGNMENT: device advertises blob_alignment
> + * in virtio_gpu_config (OASIS virtio-spec feature bit 5)
> + */
> +#define VIRTIO_GPU_F_BLOB_ALIGNMENT      5

What kernel version does this symbol get added in? I can't see it in 7.0

Headers should be imported with the scripts/update-linux-headers.sh
script, see 49f6b93d075 (linux-headers: Update to Linux v6.19-rc1) for
an example.

>=20=20
>  enum virtio_gpu_ctrl_type {
>  	VIRTIO_GPU_UNDEFINED =3D 0,
> @@ -365,6 +370,7 @@ struct virtio_gpu_config {
>  	uint32_t events_clear;
>  	uint32_t num_scanouts;
>  	uint32_t num_capsets;
> +	uint32_t blob_alignment;
>  };
>=20=20
>  /* simple formats for fbcon/X use */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

