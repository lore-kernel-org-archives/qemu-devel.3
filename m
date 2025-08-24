Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 15:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqD2i-0004kM-Tf; Sun, 24 Aug 2025 11:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqD2X-0004jg-Ds; Sun, 24 Aug 2025 11:53:54 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqD2U-00075l-SL; Sun, 24 Aug 2025 11:53:52 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-55f30367cbeso2161122e87.1; 
 Sun, 24 Aug 2025 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756050828; x=1756655628; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yh6wRbGIxcsvZFACd3jBTPWgFXVqAOSBSLjRVibz3pI=;
 b=O98bT52ExxgaX3qKOMKb3V61G1AIigsHsIOMPlmblscfDk/Yzc0MRmUNBAOU+e885n
 N8HkfAjBtKiuJ8GRhdvM/ilNxzxGT4CZ1D9WQyKkI+XlGkA4qZPcViu3Ag4ttxguDLL2
 LieLCjWdS8DUPLeT1CODXoHoEuNQEnPpxZ9NXcz73KO7JaQcxOJ9l8a1fTGnhibQiCJZ
 2aCX94HdsIgJtam6FbOVyZqwOY/KRzCG5X8H/SUiZuNmWECSu+jpNalZaXWTGwnofMoy
 rMYT2MG5KBRb6z5olfqWTltGI5y1550qBnxUX8DVlTosnci1DpJ82wk+CJA6cZbkk6U6
 wjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756050828; x=1756655628;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yh6wRbGIxcsvZFACd3jBTPWgFXVqAOSBSLjRVibz3pI=;
 b=b9eu5ULjR/SsF9DpAQ3Yl6CN5ZaeVxriSBp4gp8eaqkw01Yy34mlmn9L/bVrli27qf
 s0TV09mydDt6fXL/+/FcfqRm3P+TeLAYawnmgHCzcn7hFYSVD60jA4MGkJjT78xVPrAt
 9IKCH+to81+CVw5UyB0yuAa3iCrMcA5lH85D11WUj3SXTHcXMDCKDL/SbaSlTE9K2zBl
 LV4T14Vf4Blf8jCXXY0v4b6Yw4rKJLvbWOAfO8gArAqbV1mkot6nCGzuAsVrRG+UKhsD
 aL5+pVJjPE4HhY11gwI3p9znKizXFqkplWbNnVwHmCIgVRujtO84XJUCL0zYu14amYwJ
 u3PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPP3QA3FyyCHPVBIXkTKL7ylQr4c/tZBTmKn3qZ7TZmq3U0zQKKnXvTz9H89e2DsUowxZ+lTZxg==@nongnu.org,
 AJvYcCWxgeWRZlrLEGnnOONunC1bl1wizeW8z2UfWUb8Fa132Dl1nBZhMUH3poi6BEENxfX+3b6d68Qw0kHnhg==@nongnu.org
X-Gm-Message-State: AOJu0Yx7OQc/qHmi8sZa2lCKVFK/uYuAmdrusfph+T1uf3vK4yicB3fA
 7hEwkxSDdB0eC8BFFwu3x+EaobDWzVriK1LYLDgdghn6rmgMGOsR19YG
X-Gm-Gg: ASbGnctn+v3JVMdHkMUH3NoPLYCZv5rTSLEAZhBFZGiynpWq1KNjcEFwWJ7opfJeRwu
 shGzHbwOhKTMtn/xEG/OgvGM+kmRxrIFAMCHqKaFGzQ9kV9WrG4WVZelloma3nXD/MU/fl/zp3s
 I2MVuk3nUALbmn1YYYdlfiz0IrwD/BcduJyOzVBZZ4PE1u3abtFhJORhGbYEBl74mtDzXOgwlNW
 +V7UzK1S9BrNt396EMjuTVCUKZCzZWcUTS/5iT5z6sSxQG1GN9nnff7rIbkfWlTIGn/KVDwDcMj
 KGIEB1g5iZUVMdJxxExdi3WOuKKLaXyb7dHPuAIJFZzg8xukM+eqwUAcoGLrPjkZV7R1zuDSIxW
 34OqBeBd1HJ67rp9f6q1IYJvDf8B+GVlNrs3Sn9RTHS6aEGdt8djCF/AL3DVfjs5rr7hkO8o5vo
 20UxmL
X-Google-Smtp-Source: AGHT+IEtk5Uo70sHYMD14dcmuN7SiBSTJrZyzRsF1jLhsNXUCOZnqm6EE1rocCq1xshpds/vjRX0jQ==
X-Received: by 2002:a05:651c:1994:b0:32a:6b16:3a27 with SMTP id
 38308e7fff4ca-33650feeb3dmr25911371fa.35.1756050827541; 
 Sun, 24 Aug 2025 08:53:47 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e5d1fb0sm11973711fa.54.2025.08.24.08.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 08:53:46 -0700 (PDT)
Date: Sun, 24 Aug 2025 17:53:46 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 06/14] hw/dma/zynq-devcfg: Simulate dummy PL reset
Message-ID: <aKs1ihlBaDv2BELM@zapote>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-7-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815090113.141641-7-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
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

On Fri, Aug 15, 2025 at 11:01:04AM +0200, Corvin Kˆhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> Setting PCFG_PROG_B should reset the PL. After a reset PCFG_INIT
> should indicate that the reset is finished successfully.
> 
> In order to add a MMIO-Device as part of the PL in the Zynq, the
> reset logic must succeed. The PCFG_INIT flag is now set when the
> PL reset is triggered by PCFG_PROG_B. Indicating the reset was
> successful.
> 
> Signed-off-by: Yannick Voﬂen <y.vossen@beckhoff.com>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/dma/xlnx-zynq-devcfg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index 60ea351494..c699df6ad4 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -49,6 +49,7 @@
>  
>  REG32(CTRL, 0x00)
>      FIELD(CTRL,     FORCE_RST,          31,  1) /* Not supported, wr ignored */
> +    FIELD(CTRL,     PCFG_PROG_B,        30,  1)
>      FIELD(CTRL,     PCAP_PR,            27,  1) /* Forced to 0 on bad unlock */
>      FIELD(CTRL,     PCAP_MODE,          26,  1)
>      FIELD(CTRL,     MULTIBOOT_EN,       24,  1)
> @@ -116,6 +117,7 @@ REG32(STATUS, 0x14)
>      FIELD(STATUS,   PSS_GTS_USR_B,      11,  1)
>      FIELD(STATUS,   PSS_FST_CFG_B,      10,  1)
>      FIELD(STATUS,   PSS_CFG_RESET_B,     5,  1)
> +    FIELD(STATUS,   PCFG_INIT,           4,  1)
>  
>  REG32(DMA_SRC_ADDR, 0x18)
>  REG32(DMA_DST_ADDR, 0x1C)
> @@ -204,6 +206,13 @@ static uint64_t r_ctrl_pre_write(RegisterInfo *reg, uint64_t val)
>              val |= lock_ctrl_map[i] & s->regs[R_CTRL];
>          }
>      }
> +
> +    if (FIELD_EX32(val, CTRL, PCFG_PROG_B)) {
> +        s->regs[R_STATUS] |= R_STATUS_PCFG_INIT_MASK;
> +    } else {
> +        s->regs[R_STATUS] &= ~R_STATUS_PCFG_INIT_MASK;
> +    }
> +
>      return val;
>  }
>  
> -- 
> 2.50.1
> 

