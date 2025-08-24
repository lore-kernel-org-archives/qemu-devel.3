Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A9CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 15:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqCwi-0002ni-Fw; Sun, 24 Aug 2025 11:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqCwf-0002nQ-Gp; Sun, 24 Aug 2025 11:47:49 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqCwd-0006Mm-UC; Sun, 24 Aug 2025 11:47:49 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3366de457a5so3878331fa.0; 
 Sun, 24 Aug 2025 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756050465; x=1756655265; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zVcvf6N1+8o3jeMKc47yk3nCFx/BK5BHs6172xH/slc=;
 b=aEoqTm2iFFmI2xoZ/m89EHcttsTyq4zPjoVkX/4OqE1g7WRhyhpsvIty8ulTtMQ9DT
 MSzx+kfpzyQCF9OkJR8EWcwNg85Ru2iuF0Uig5DBZkUywPI0Ds8fWFFoc3/ORPpKD0hM
 hN88L4Ufvaw4a+Of41RIm3dmm3KjHOHZUAEBbuYaSiVnQCKBFD8e5SadQRmxu+l4we47
 0gWNZUVPjg2tcd4DuiV6gJxzTTCPAuX3ahfmmRQOBJUDZ7fGv2OmRw+u8SBgkgGNvS8s
 EiEs1fPtISRCmUq51L+3tzwI2GjYSNjQyAKn09WhnFRmmL+Mpti8bkNSAi9q8l00jXQj
 +fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756050465; x=1756655265;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVcvf6N1+8o3jeMKc47yk3nCFx/BK5BHs6172xH/slc=;
 b=eJiBMblbLiInCSE4sS66vmT87XPnJH3wr+EjprxeCjkSRIN6nUvvTko25wpoD9nmgL
 Tf6YQAhVullBoikV6Ot1Pa2VLckNQQED0gOEZmMiuNoEhj/bWjZ3CQ1N9TAJZWgp4cGz
 xwiCQveTiZyQDLy2ZFLbV7aOqJG8VSEnoD6Zuexz+p23UKbR3pG27BIJxzvPg5m+M8A1
 Sqak5ySbmBvPWNCPZXsWjYqI1vQCKKgg81LEscX4VvUmPgYrcvM6V50NlpFpxsPVklZJ
 rZFphu2QsYUo/vx+h9XsZ+wjz1QROGXNdxiSDzb8zL/N5jqMdUx5W8kiVaqRTQgpANPC
 /haQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEKffbL1ey11Tdf7b4iqjMFLseqT/vna6lT4v3iRPNCV/Mxjy7bHEz/IsHldaLJ6rAx4XJXeNEjA==@nongnu.org,
 AJvYcCX4rDX0FEB1x6ipRhXoo7XZBu5jFto06oYZ9ioAFsrSxGBCC3l/ameXpGh6EB9Mt9ypSqOaMJAOUWTK6Q==@nongnu.org
X-Gm-Message-State: AOJu0YzB2DLgwDY0xz4ukg1DxY5/luYiZpE5z4M08YVcyonhp8qnM1h8
 L0Kfnji6XffzqW+TEJ57+XALklhpOI5awo5LoRqUoYExLZQOBvWmLrPw
X-Gm-Gg: ASbGncvdIkFUDDeMgDUy3bKRp9jiuMHbbp6SWr25akwQmGR/18c6M+QHxZTri2YirQV
 1mu/5Ey9WxeH3Gm/nf2fkLKjX2V8N4WbHhmm5zirBcMQAX1sOw+/PZlq8YfUYA5X7XKtd+hPJ0L
 E39jXo/3CV0tOSzmdVyCxotYzosmRl5TLRoiZUYU9/rrmCH/vZc9qEJEHYs/AOPTPXNJHwugpkX
 Gm4VXF48MBPNRSrd/soW8HklnMzf/pvAOL7XlWGRQxK4YFj3LpKQqR0wYVD9hSbRg5nWKaMeP8e
 DHY/NVqLVuwj+Wlxf/m2XfY44gpvbrPq6WHnfDSfMZVVQyLtanlWOWOlp1llqGRDdb6Q1TSdTqV
 cUU6bAztAgJkQda05lQsprb9D9aDdxZ8gaToeXHFJNtAVmRr1BU46+l9fypZA+YgESNE+hA==
X-Google-Smtp-Source: AGHT+IFVM5HFkO646CqImYDWzBwIqMXrSaCdRiuVR/Sxbi+VjFKLzPrJexLM+G/joyuX6gNl3ugNMA==
X-Received: by 2002:a05:651c:3256:10b0:32b:3104:f89c with SMTP id
 38308e7fff4ca-33650f3fc52mr22458121fa.29.1756050464355; 
 Sun, 24 Aug 2025 08:47:44 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e5f4199sm10724941fa.63.2025.08.24.08.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 08:47:43 -0700 (PDT)
Date: Sun, 24 Aug 2025 17:47:42 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 04/14] hw/arm/zynq-devcfg: Prevent unintended unlock
 during initialization
Message-ID: <aKs0HvG0OrKwWIhS@zapote>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-5-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815090113.141641-5-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
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

On Fri, Aug 15, 2025 at 11:01:02AM +0200, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> During the emulation startup, all registers are reset, which triggers the
> `r_unlock_post_write` function with a value of 0. This led to an
> unintended memory access disable, making the devcfg unusable.
> 
> During startup, the memory space no longer gets locked.
> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/dma/xlnx-zynq-devcfg.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index b838c1c0d0..f28d0015e6 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -221,7 +221,9 @@ static void r_unlock_post_write(RegisterInfo *reg, uint64_t val)
>  {
>      XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
>      const char *device_prefix = object_get_typename(OBJECT(s));
> -
> +    if (device_is_in_reset(DEVICE(s))) {
> +        return;
> +    }
>      if (val == R_UNLOCK_MAGIC) {
>          DB_PRINT("successful unlock\n");
>          s->regs[R_CTRL] |= R_CTRL_PCAP_PR_MASK;
> -- 
> 2.50.1
> 

