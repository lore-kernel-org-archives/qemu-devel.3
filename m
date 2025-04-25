Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA03DC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LnW-0006gx-F2; Fri, 25 Apr 2025 12:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8LnV-0006gD-2K; Fri, 25 Apr 2025 12:21:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8LnT-0002pT-FQ; Fri, 25 Apr 2025 12:21:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1892805f8f.2; 
 Fri, 25 Apr 2025 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745598061; x=1746202861; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gduuq9AA6XvtvZByzzwErUG8FM90r6CEbZhkOsLgA+M=;
 b=d02DcdJN8X/ju2JoHf3DCN9uULClLRdEIZZi4baMpwzWqKnuENyjsHTKRI/PDe4Q1j
 7fD+P940GvdgMzn7rA29A/zOr3IMTIl5HTodZcLUZlSmlaWXUW4XUudRKN0Pt7z0RWg8
 KWE2k31jmXaCdP1Lu0qLzpiRTxWLfvGVW8QMsaGsYx28VJ8NhFvbf76tpqhXvsyFdcXg
 ++mWHdXFPrESp4hmbYE0uXErEcK6qPNGwlPwLmdUuoUwJJnrMVw/MyHDhlkf2Rt9Qdem
 pBKOFta0G6YfgVUpWhb7maXFTdHEPITxzBCLfRFi/zelOqkl2A4jD9HaL9Ie4oA7ex5d
 KsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745598061; x=1746202861;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gduuq9AA6XvtvZByzzwErUG8FM90r6CEbZhkOsLgA+M=;
 b=wvLsK09fR6+kPDJ6Yvdh8gyVjwSOmPGHQTI/5yJb9hB1X2bV/Tb5R1mEN3K00+DZN2
 MQPMmLeQ9NKOEsifTvV+gtxPV6Vk6pSEqmx7BhXl8N3PMlhXDrhuYz1BcG+0K8dt3RNu
 8AjDn/A6ZDoNnHhLW8DcevPXMwKEaI4xpD3bP2pbptYtoTxkQUa1FtqPUcCG+wMTLrGQ
 Y/3AHcnw1J56P0SZsgBu6z41k+g4+BFmqwF6/Qv76k3uHFB0jVueA+B03odhdRSzjTsm
 5ZgTem6wAZ5K8SP8DlRJ4WX+wgVvhAQB3TGj9ZqUc7wmO8xbAE69j15JyfIKSCVC3h8h
 WtKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWitLMXPUFKnyaUcb0lE7Lob9eDNjqKticBrLqurYZ0uVeL6VseiHxnM+3Br+5VWp/CJ42sXT0yhQ==@nongnu.org
X-Gm-Message-State: AOJu0YznjyJOSfwU1OvCWrpyT+7baaiWr4DTGAGQwW231rOqsNJiPNY/
 0Ttwmb13vKRObfwjNsyPlxOpxelQGmW0lr60YGAQ65BnwDcQO1cf
X-Gm-Gg: ASbGncv4Sszf5la6ffMBtVrrkP0BIqQgj/nk5776+EC8YGP6+i1v0+XwH2i6Gi/G1Z8
 h0+9T9kH9kuCC533vU1SkGGgNOxbh+Hjy57F2Dq1g7uDtBZeMYy+dWwu3cVb7Vq0VlR2aViKgD0
 QObr9zhK7VhtOypa2eRN9PxFgJ1gLTe+nkueAVFqDMs4lDQuF2yKX6HMSI4LrQCemR4zXck9FO6
 /EZj58lqnpEAQUTqDBeMEhAbd7ZI6mv2MRerk/flBVYpf3K36ljSeAInp62TZKFix1tCabgaA79
 H83Bh/CIqUdft8Y4B0hJhX++J/9nvmGgyaiOlxSZhWICWhQRkPnE3QjxahGwYErVYffNT2SJLDo
 ALTb32oBk/529
X-Google-Smtp-Source: AGHT+IEm6SwFhQlv4rq2mB3ahMIxM8xA1zAGAF+Knor5RsanKNCOH+Wsu4QG7OkOkZFv5WuvICbf1g==
X-Received: by 2002:a05:6000:401e:b0:38f:2413:2622 with SMTP id
 ffacd0b85a97d-3a074f3981amr2546482f8f.47.1745598060786; 
 Fri, 25 Apr 2025 09:21:00 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a52f8861sm30553135e9.6.2025.04.25.09.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:21:00 -0700 (PDT)
Date: Fri, 25 Apr 2025 18:20:59 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/21] hw/dma/zynq-devcfg: Simulate dummy PL reset
Message-ID: <aAu2a1V4D_5JZf7n@zapote>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <20250318130817.119636-7-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318130817.119636-7-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wr1-x433.google.com
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

On Tue, Mar 18, 2025 at 02:07:57PM +0100, Corvin Kˆhne wrote:
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
> ---
>  hw/dma/xlnx-zynq-devcfg.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index 611a57b4d4..c44b802b22 100644
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
> @@ -209,6 +211,14 @@ static uint64_t r_ctrl_pre_write(RegisterInfo *reg, uint64_t val)
>              val |= lock_ctrl_map[i] & s->regs[R_CTRL];
>          }
>      }
> +
> +    uint32_t pcfg_prog_b = FIELD_EX32(val, CTRL, PCFG_PROG_B);

The declaration of pcfg_prog_b shouldn't be in the middle of a block.
Since PCFG_PROG_B is a single bit, better to use bool.
Or just skip the variable all together and do:

    if (FIELD_EX32(val, CTRL, PCFG_PROG_B)) {



> +    if (pcfg_prog_b) {
> +        s->regs[R_STATUS] |= R_STATUS_PCFG_INIT_MASK;
> +    } else {
> +        s->regs[R_STATUS] &= ~R_STATUS_PCFG_INIT_MASK;
> +    }
> +
>      return val;
>  }
>  
> -- 
> 2.49.0
> 

