Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D0AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8P9u-0002Px-L4; Fri, 25 Apr 2025 15:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8P9t-0002PU-Bo; Fri, 25 Apr 2025 15:56:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8P9r-0001Fk-9D; Fri, 25 Apr 2025 15:56:25 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so1884372f8f.1; 
 Fri, 25 Apr 2025 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745610981; x=1746215781; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A2gfaBXNp4dU0dm+i9LlMdykMAI/Yullks1UebA9OG0=;
 b=lxahaUzSpOAuwokyBFXPBQqvuoIB0Y/eI/dV2gA/NH5qdi0ldsl8DslgCWnY/+n3vT
 RAiWwCQuh+EF/P57sznJlJ1cBlYZDyxUydXHvXjaKEjzDANg51HQOIiOqEV3Gk5UTzsp
 Rnm4PexXmu2xaQqhhjjAqdWTw5eyhdpkYtDsZiptHfY/wjqoVaINR+i/Jrc5BA9QXj5W
 ObbUNhlCESYF58GrRAz+svXKOHe4oeqJyWY45mtDAwwugkv4lJM/O6N9ACeI84xgKKym
 LD1ibcIO1fQJLhcSvYhihP9z77Z72CgUBQ0sSFKzZCcm9KJXtx/UTTZ0735g9mk+1A/T
 fZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610981; x=1746215781;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2gfaBXNp4dU0dm+i9LlMdykMAI/Yullks1UebA9OG0=;
 b=ZSvKcDh4iEeOYTC/5qWDFASBeytFuuXBCGNmbdqSj8+wrA8qDvUde+icp+lwc5B8i9
 STAFIUKwcU2I6PCAUUUy0VGbBAkKmyIZopLF91URKZrHD2GWctjUHfGN6b1ONxIz1j0o
 Y/SQwpeGPc91x8vmftYrhwd8uN34Wde1Z6ISF4PbjXTxOg5IO958W0ZiOg7gCGNCJjqw
 ZZkg47akKYo/a/Esq4/EPBpzv2TdV8F47FtpHi2+3W+pKiRL0/w/A1Cg/UrkcxThX//B
 O8iOqt5Utf3wBStPFU98zbse2QiZJqXO/f0e87249S0j9rkQ1DauizU66T3fBdLePYY4
 mCqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8HyIR5DoTVS9E7z6IKVYW4z1+YGrQX4pjZfMMm3TVJLt4voKmfkraY9ALE4AlCpgjY7MsxMJ36g==@nongnu.org
X-Gm-Message-State: AOJu0Ywsz9ft76o88S3GVEtOHHogTw0v6wRJMu68mYZckGMD/LpMj1iW
 l0C8DaGe6ik272n/dfz+hgJzevuPFD/Q4uQhXbvLPBuSKIK+JO3E
X-Gm-Gg: ASbGncu9GN4vDsaA4ygUf7xCpieKLY81JgIHcrRPZB3DKfHSa5G8RqbKk/Zf/s02YrE
 JBwajoRLAqM0O5xMhRNMkmR1VmL2OtoP2040r0sK/c56XStGHkn9tpAdwV+yPM7+KH10Z5+2XLO
 WfKgbyZ7HnO9XUaRsl6O9rYT6d3SKUq2XAmwxZ7hUIJ3RaA3FCFPmu+sDLdGA2GAeUo0IX8xs3D
 AX71X5t+NEZE2bhVd9R1NUZjqo1vPZM14ZKS1w0KnmAdyb5qc2FQRJ5VPS843WIZ8S8hI10RO/f
 BNJPo0f5O+rBgfrIP3E+eH+LoLU43XDzeMb4rVNeFQ9AmDxBTe/HcKcs3bxwu9iNoy/g0zEEX3U
 fSmHyWEi+vGsr
X-Google-Smtp-Source: AGHT+IFPc14uPY4ZvxH25N5kQbAk1JSTFHjRt56GVHPCAokD31/lLopSzZ7oM7Z1isV3lM1hueeNLg==
X-Received: by 2002:a05:6000:240b:b0:38d:d701:419c with SMTP id
 ffacd0b85a97d-3a074f0dca7mr2867191f8f.41.1745610980402; 
 Fri, 25 Apr 2025 12:56:20 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46501sm3171296f8f.73.2025.04.25.12.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 12:56:19 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:56:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/21] hw/misc/zynq_slcr: Add logic for DCI configuration
Message-ID: <aAvo4vhsKM7rApVy@zapote>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <20250318130817.119636-11-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318130817.119636-11-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wr1-x434.google.com
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

On Tue, Mar 18, 2025 at 02:08:01PM +0100, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> The registers for the digitally controlled impedance (DCI) clock are
> part of the system level control registers (SLCR). The DONE bit in
> the status register indicates a successfull DCI calibration. An
> description of the calibration process can be found here:
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/DDR-IOB-Impedance-Calibration
> 
> The DCI control register and status register have been added. As soon
> as the ENABLE and RESET bit are set, the RESET bit has also been toggled
> to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the status
> register is set. If these bits change the DONE bit is reset. Note that the
> option bits are not taken into consideration.
> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>

LGTM:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> ---
>  hw/misc/zynq_slcr.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index 9b3220f354..10ef8ecee8 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -181,6 +181,12 @@ REG32(GPIOB_CFG_HSTL, 0xb14)
>  REG32(GPIOB_DRVR_BIAS_CTRL, 0xb18)
>  
>  REG32(DDRIOB, 0xb40)
> +REG32(DDRIOB_DCI_CTRL, 0xb70)
> +    FIELD(DDRIOB_DCI_CTRL, RESET, 0, 1)
> +    FIELD(DDRIOB_DCI_CTRL, ENABLE, 1, 1)
> +    FIELD(DDRIOB_DCI_CTRL, UPDATE_CONTROL, 20, 1)
> +REG32(DDRIOB_DCI_STATUS, 0xb74)
> +    FIELD(DDRIOB_DCI_STATUS, DONE, 13, 1)
>  #define DDRIOB_LENGTH 14
>  
>  #define ZYNQ_SLCR_MMIO_SIZE     0x1000
> @@ -194,6 +200,8 @@ struct ZynqSLCRState {
>  
>      MemoryRegion iomem;
>  
> +    bool ddriob_dci_ctrl_reset_toggled;
> +
>      uint32_t regs[ZYNQ_SLCR_NUM_REGS];
>  
>      Clock *ps_clk;
> @@ -332,6 +340,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
>  
>      DB_PRINT("RESET\n");
>  
> +    s->ddriob_dci_ctrl_reset_toggled = false;
> +
>      s->regs[R_LOCKSTA] = 1;
>      /* 0x100 - 0x11C */
>      s->regs[R_ARM_PLL_CTRL]   = 0x0001A008;
> @@ -419,6 +429,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
>      s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
>                            = 0x00000e00;
>      s->regs[R_DDRIOB + 12] = 0x00000021;
> +
> +    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
>  }
>  
>  static void zynq_slcr_reset_hold(Object *obj, ResetType type)
> @@ -555,6 +567,25 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
>                  (int)offset, (unsigned)val & 0xFFFF);
>          }
>          return;
> +
> +    case R_DDRIOB_DCI_CTRL:
> +        if (!FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) && 
> +            FIELD_EX32(s->regs[R_DDRIOB_DCI_CTRL], DDRIOB_DCI_CTRL, RESET)) {
> +
> +            s->ddriob_dci_ctrl_reset_toggled = true;
> +            DB_PRINT("DDRIOB DCI CTRL RESET was toggled\n");
> +        }
> +
> +        if (FIELD_EX32(val, DDRIOB_DCI_CTRL, ENABLE) &&
> +            FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) &&
> +            !FIELD_EX32(val, DDRIOB_DCI_CTRL, UPDATE_CONTROL) &&
> +            s->ddriob_dci_ctrl_reset_toggled) {
> +
> +            s->regs[R_DDRIOB_DCI_STATUS] |= R_DDRIOB_DCI_STATUS_DONE_MASK;
> +        } else {
> +            s->regs[R_DDRIOB_DCI_STATUS] &= ~R_DDRIOB_DCI_STATUS_DONE_MASK;
> +        }
> +        break;
>      }
>  
>      if (s->regs[R_LOCKSTA]) {
> -- 
> 2.49.0
> 

