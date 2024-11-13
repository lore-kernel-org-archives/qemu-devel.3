Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C58D462B9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBF5Z-0002jY-FV; Wed, 13 Nov 2024 10:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBF5L-0002dS-Lk; Wed, 13 Nov 2024 10:15:11 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBF5J-0006LW-0x; Wed, 13 Nov 2024 10:15:10 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53da22c5863so696874e87.0; 
 Wed, 13 Nov 2024 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731510907; x=1732115707; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5skamxa0qjEIqgFjjXcFyEiinV5QlOKKS5WslP2NvK8=;
 b=Oh4+tLOLfYLyANc35f2bboYXDq3smknqfhrg/WVnF1YWg5qsQfaB7bymbM/r3eKahS
 wDfItFvlSi65Dh16fWz+D/D1T6NljFXgQL5LMRMeeFDbLPozXu8mH1Vprosj9fi4ECTM
 6kW7i0HRR7EmKOZWnhXe/kxSLlxqKcwXF44E3BO06jpfi6Rfm8SZNCUmmaEkjXIwogJa
 PiyXIecQNgnD/njn+JYuQwfz4Gogl2j8ngFk+f/+Y0zpKfEgpaTYR6ubfeib7dRchPWn
 g7zBzFAe6p9jUqHfti4nAlgG3irx5r1zZdsYbb7IMZTXUH+78i48KExVwcvjIGY+TWDI
 NPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510907; x=1732115707;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5skamxa0qjEIqgFjjXcFyEiinV5QlOKKS5WslP2NvK8=;
 b=eALOiJE0zkgz/pC3tV7vv+IwcUZIehceT0yhdnfdxGzYoS2J+L2x6Z7K1zq5RLDRdv
 lhwyWKypFSPR+0CIWmHa5n0CpOXeAmv9o9e/vOHPYKYUwSeCQs1/w09p1nGmNuRP4OQ6
 28SiD2kCNoGzIQsAxZm8wjerdkzmwA78dPBzMfgEDfZfK5bgqRJ25N4dsB8Vot/7tGkJ
 LkBpqoDJM2cWta/1aqyY7iGd3UTcfihdn/m8dYaygSLhj+utqUBujz9eamC/8fQgOd44
 ydvfo99MKQEk26KdOyLA9UMMHul2yMlHcglLY/iKWRDqKa5oEVdDpataxyAYEBnCz+5k
 xscw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoHNIPLKFjqHzRVC1GJr6ib7NKB+GVhFFP7ZLY6XIHQC6xjo8PSI4DWPynKc0mP77M/rZj1uIuTg==@nongnu.org
X-Gm-Message-State: AOJu0YxrmCpufq/ZJ+4QYdeGu9TiSVuBOMx8hydYb4fZ+7IChTbUGpMm
 kkUAALzcSXdrtgyCWWftjBIJul55A/lVTjG+Dv4Y2sPBUIippBzw
X-Google-Smtp-Source: AGHT+IHFSV3QYu6Area498LxPZklADHa83AuamBPQRXLkdTR9diihzEeuVEYJhdC/TbfzRlsIvTulg==
X-Received: by 2002:a05:6512:3b98:b0:539:fbf7:38d1 with SMTP id
 2adb3069b0e04-53d9a40701fmr4552031e87.2.1731510906416; 
 Wed, 13 Nov 2024 07:15:06 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d82686327sm2243371e87.102.2024.11.13.07.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:15:05 -0800 (PST)
Date: Wed, 13 Nov 2024 16:15:04 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 05/20] hw/net/xilinx_ethlite: Correct maximum RX buffer
 size
Message-ID: <ZzTCeKXtmaKxhvSP@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-6-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 12, 2024 at 07:10:29PM +0100, Philippe Mathieu-Daudé wrote:
> The current max RX bufsize is set to 0x800. This is
> invalid, since it contains the MMIO registers region.
> Add the correct definition and use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/net/xilinx_ethlite.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 0f59811c78..e6f6179fce 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -46,6 +46,8 @@
>  #define R_RX_CTRL1    (0x1ffc / 4)
>  #define R_MAX         (0x2000 / 4)
>  
> +#define RX_BUFSZ_MAX  0x07e0
> +
>  #define GIE_GIE    0x80000000
>  
>  #define CTRL_I     0x8
> @@ -195,7 +197,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>          return -1;
>      }
>  
> -    if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
> +    if (size > RX_BUFSZ_MAX) {
>          trace_ethlite_pkt_size_too_big(size);
>          return -1;
>      }
> -- 
> 2.45.2
> 

