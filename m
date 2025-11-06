Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71023CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5J5-0000DU-Gs; Thu, 06 Nov 2025 14:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vH5J1-00009j-9e
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:05:59 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vH5Ix-0003GU-Np
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:05:58 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-37902f130e1so12189831fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762455954; x=1763060754; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dS+ECZMCGe21Uh59scVnNIvYFqd5IEgJbnmtPYbZCs=;
 b=KCF+cS102b5w64/Pt4ycidwlJR3o2GlDm38HHhNcKad3oL3JSrGmBblmjJ6+NnuPNd
 kIc6/vEhWXrAxT5/wd0rBH4VdsQeqiItybZwbXJx0+7LHbP4qXeD1ZmF4R5ZsJer/rnW
 2dUOdk7dx0G5anRnTJSSHyx9tGnFTcZNpuWMRt9FspiqTZ2vCsEZG6P43sRFCHdPiJAS
 WQMkKyMSqf5tIKtm4XPJY3+153sfgORl/sdOubvmrw6+zOO6tsq452LgAfqGP3Doybf+
 h00H1vKMjqhcDl7WdbZ8Y9M/MG5eAt3mp4jsw2dOsHVJCE0YaOvBTAa4Qah2gTXnWwZ/
 nGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762455954; x=1763060754;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+dS+ECZMCGe21Uh59scVnNIvYFqd5IEgJbnmtPYbZCs=;
 b=RS9UZvF7RDrHuV4ypldMrd1aW0irTKDCPg7tQveFO/XYYFCVWA3Kiq3/+AXFPM9NjF
 U1YErpMHglMXZM2X8j+H4G9aKhyoZfkuInyfWoLSeUBW/ggoefBBlkU2sMLpQIGRzdRX
 Slzsroj2KNA8Ou9ImgX96Ehq/d4DGJUYKVPs9ddgzFrNkfZc3TIYxLzWNjcXrUSDuZko
 9RfeHhrlAo29N+0y7kZO/gHqY64unczskh9V7CiO9KmJFqMC1gUi45Vr3sJrDNmOeUjz
 UCydgYRJgatOlEfkfZJaHsMnjXlx1MSPUZZF6NcHU5HuFh5UTScTBYvjwf8icHUwgw3v
 5EJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYtkzv/BktER+1wRXxMgRSj9vtspWvxSyKFQi9BT/ZIhiFoWMdgP16beawsexWFnlvj0yv3bUmqSIz@nongnu.org
X-Gm-Message-State: AOJu0YzyDsmbPSIkguNskW5VGUXKLja6KAVyONB+G6tuSn3LFzJ/d3jw
 GUi2zXj80BjqHjxfLRpw5++K92NFD/5uCnICqppnI4mONkI2oC9wSr53a3SvRH4pfVA=
X-Gm-Gg: ASbGnctomXHe0ntPYCwV5GMXgTRA+TZrP4qJggWLKyBZfboThHl8QNhdjffkRdoG9I4
 ehgqBGyFzAvuU8VOwUxIrZF9hJ4Cj434dzq2H7JdNcTydUGxS8Xf3DJM60f7QGu2JHbt58zq1gv
 4BsCmtMNejK7P21vjvh9CUhdpUryn6bKf7i6gInhmxhVxbTNR/qhCpT5fkakYKhvaZ9ND86X+TL
 0aqD7inAIzy4uue3OTQn0f/05Og4NKLZ0GgJe1urMgUYEkrdyKqVUVeeR8PsQbi/mF3ZeH8rYIk
 cus7O3GNfvGE61GbF5DKVE9XhMmWTbreoBi32sqp7JQRf9YXVcS57Q76LDf0S50eH/qZ5+LbzZ3
 U7NchsqXZcQX1ECa2t5oZWFhm471JH0wxwc7/4vLbYHEbOmAn8YYbdg5Pt7rFFr1EWh5Iwdm+zb
 VRFcNWzsoc3UQo3eMnYTmg+oc47HBNtqMxorow
X-Google-Smtp-Source: AGHT+IHuOTe6rDBlFpnv8q3qrdeH5WGQO7eMT57Zxp2EhKrGWD3vIVsU3+XD/FUd0Nvu/Yca1DxX8Q==
X-Received: by 2002:a05:651c:1118:20b0:37a:3902:7d70 with SMTP id
 38308e7fff4ca-37a73322f17mr887251fa.23.1762455953595; 
 Thu, 06 Nov 2025 11:05:53 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37a5f0dc502sm7905221fa.31.2025.11.06.11.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 11:05:51 -0800 (PST)
Date: Thu, 6 Nov 2025 20:05:50 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 2/2] hw/display/xlnx_dp: Don't abort for unsupported
 graphics formats
Message-ID: <aQzxjimb9omqLRs7@zapote>
References: <20251106145209.1083998-1-peter.maydell@linaro.org>
 <20251106145209.1083998-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106145209.1083998-3-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22c.google.com
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

On Thu, Nov 06, 2025 at 02:52:09PM +0000, Peter Maydell wrote:
> If the guest writes an invalid or unsupported value to the
> AV_BUF_FORMAT register, currently we abort().  Instead, log this as
> either a guest error or an unimplemented error and continue.
> 
> The existing code treats DP_NL_VID_CB_Y0_CR_Y1 as x8b8g8r8
> via a "case 0" that does not use the enum constant name for some
> reason; we leave that alone beyond adding a comment about the
> weird code.
> 
> Documentation of this register seems to be at:
> https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/AV_BUF_FORMAT-DISPLAY_PORT-Register
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1415
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/display/xlnx_dp.c | 53 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index c2bf692e7b1..d8119a56292 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -665,14 +665,28 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
>      case DP_GRAPHIC_BGR888:
>          s->g_plane.format = PIXMAN_b8g8r8;
>          break;
> +    case DP_GRAPHIC_RGBA5551:
> +    case DP_GRAPHIC_RGBA4444:
> +    case DP_GRAPHIC_8BPP:
> +    case DP_GRAPHIC_4BPP:
> +    case DP_GRAPHIC_2BPP:
> +    case DP_GRAPHIC_1BPP:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented graphic format %u",
> +                      __func__,
> +                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
> +        s->g_plane.format = PIXMAN_r8g8b8a8;
> +        break;
>      default:
> -        error_report("%s: unsupported graphic format %u", __func__,
> -                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid graphic format %u",
> +                      __func__,
> +                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
> +        s->g_plane.format = PIXMAN_r8g8b8a8;
>          abort();
>      }
>  
>      switch (s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK) {
>      case 0:
> +        /* This is DP_NL_VID_CB_Y0_CR_Y1 ??? */
>          s->v_plane.format = PIXMAN_x8b8g8r8;
>          break;
>      case DP_NL_VID_Y0_CB_Y1_CR:
> @@ -681,10 +695,39 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
>      case DP_NL_VID_RGBA8880:
>          s->v_plane.format = PIXMAN_x8b8g8r8;
>          break;
> +    case DP_NL_VID_CR_Y0_CB_Y1:
> +    case DP_NL_VID_Y0_CR_Y1_CB:
> +    case DP_NL_VID_YV16:
> +    case DP_NL_VID_YV24:
> +    case DP_NL_VID_YV16CL:
> +    case DP_NL_VID_MONO:
> +    case DP_NL_VID_YV16CL2:
> +    case DP_NL_VID_YUV444:
> +    case DP_NL_VID_RGB888:
> +    case DP_NL_VID_RGB888_10BPC:
> +    case DP_NL_VID_YUV444_10BPC:
> +    case DP_NL_VID_YV16CL2_10BPC:
> +    case DP_NL_VID_YV16CL_10BPC:
> +    case DP_NL_VID_YV16_10BPC:
> +    case DP_NL_VID_YV24_10BPC:
> +    case DP_NL_VID_Y_ONLY_10BPC:
> +    case DP_NL_VID_YV16_420:
> +    case DP_NL_VID_YV16CL_420:
> +    case DP_NL_VID_YV16CL2_420:
> +    case DP_NL_VID_YV16_420_10BPC:
> +    case DP_NL_VID_YV16CL_420_10BPC:
> +    case DP_NL_VID_YV16CL2_420_10BPC:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented video format %u",
> +                      __func__,
> +                      s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
> +        s->v_plane.format = PIXMAN_x8b8g8r8;
> +        break;
>      default:
> -        error_report("%s: unsupported video format %u", __func__,
> -                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
> -        abort();
> +        qemu_log_mask(LOG_UNIMP, "%s: invalid video format %u",
> +                      __func__,
> +                      s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
> +        s->v_plane.format = PIXMAN_x8b8g8r8;
> +        break;
>      }
>  
>      xlnx_dp_recreate_surface(s);
> -- 
> 2.43.0
> 

