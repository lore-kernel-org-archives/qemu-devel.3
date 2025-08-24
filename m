Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E389DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 16:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqDnF-000345-Ob; Sun, 24 Aug 2025 12:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDnE-00033l-6U; Sun, 24 Aug 2025 12:42:08 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDn7-0003ri-QH; Sun, 24 Aug 2025 12:42:07 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-55ce508d4d6so2903468e87.0; 
 Sun, 24 Aug 2025 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756053718; x=1756658518; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aCg6LU779FH6AgbHL1NqzjmVjg4hYI9IRuZfYGExEAY=;
 b=aN+d8zZZ17y0t6KssInh1uVPJfB19iQb5Tbp5TWzzbHHc7gNFOqbFteFNbGKvOoYAQ
 KLmwKghdj7LsehC2523cXMdBAxlA7W4QDTrGJI52KGLYsPhWben+3qkkhxdh8wyFNFBq
 X1Dni/uQBVHWyJiEb/JdJ+GFICNCtEdkMvKk0DqBtQLOEGBmjpDnwx7PzU8oQkTYX+ts
 Z2FAghScIQqG5+wHlwNWy/jYT7xb5OvFVy2JxK5ZfnwQbfNtIdrtaLBqH356cTfmTT2M
 JKrTdPdIXdHTQ2NoIjZzCuZ6Lwa4ixmSYIaYR+93o1NodDflJDqapJ0fxMGsw/GiLcVD
 IN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756053718; x=1756658518;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCg6LU779FH6AgbHL1NqzjmVjg4hYI9IRuZfYGExEAY=;
 b=eSC6juT4S9OPemIiEXSJueACy99YfxFhOiaH7ymRWa+LduPekUy7pQu5lytKEIL998
 joNnAQWQLoR5ZaIWQI2hyVljAYa61Rehmm+TEMunCTwBpZUeRhvF3lTCz76Ej4JSpilT
 YMS/OHKCVoYt5H4H62sQ03ujm0s7v2TmfAvLIZ1UGwG9B6IRAJYic1z+oguC+ykMltIY
 +0cZRRby8GZN9xVHH2ciDzHzoNJKMOmXHlJhttbJfP4YNZxPLBbfSGXsFn9BvEXlFwLw
 X7JA2e53U3pxdeRaJFfT4CFVclV13UpE8zJ6dWKgud39+kFocsgFIhlnTgbVRcDp2j7N
 /vGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NeVgaKkxlAVqIK8i/Km9qPU3540bj5F7EAxwRF0GypBm9vots2gIaFkq0R3zUZ6iSGfu3GK4AQ==@nongnu.org,
 AJvYcCWRhIgAAK3Gg92XxDMYgY0HqFZU2i5ltIFSm2Sk2nTOjsVaqRL09FKuCHB/OUstn+PAEwE6uG0YgpTVkA==@nongnu.org
X-Gm-Message-State: AOJu0YxAUbfmhWaMEimeDCS8D8NlZeowIBKPyoVuCOarcuU+VQvf4v64
 cidOx//2VIYv8HTd3eZYYFY6lpqBDU4L321nIl1h8uk/YI0vWbEDKIwP
X-Gm-Gg: ASbGnct0GifKjhvvlK1CWN60QhFgAWN9lGhr11k7zRrV7z5dSLb7OeYvHP74bioAA3z
 mKqZxbYHisqS8XWdT55e3jGq2k9YafPjXSgwl8ql6qeoYkLwRN5zE5GjbZRwKy1phFOrXFa1Sff
 qMevpvOb+nPx2MfQNAHOKsWS07TLKXzJXnlU8Mqx710oqAMlEfnOEt+96kSfUKe+Ue6Mj9DNKBW
 ax8C8jJ5uELVQEBsj+jJwG4Ky7XM/WjqRe2FbaueirVcSxgas8WFlXeoW7uz6jK1K6WALlK0VzT
 ohZqwWonjjjfTi9MTA7j4GLH8OYuUJHALL1/x4W0vjkSoVeiz5aYaaU4NDtB+BSu92Sf+MCc7fj
 POVbmcR/3duueAM+0L1qIr4572eMBeJyV8xams2gtPWCf0aR+V0F7QYGMdGSK9EcDFyYEIQ==
X-Google-Smtp-Source: AGHT+IEPucUXfZeM9WRCMna/3okogGMgpb6kuYhnDH3c0z1MJqvuKsPRmeoA3DZsyYYmGlCK5oCe+w==
X-Received: by 2002:ac2:51cb:0:b0:55f:3f00:a819 with SMTP id
 2adb3069b0e04-55f3f00ac56mr1150921e87.7.1756053718068; 
 Sun, 24 Aug 2025 09:41:58 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c8bceesm1151261e87.72.2025.08.24.09.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 09:41:57 -0700 (PDT)
Date: Sun, 24 Aug 2025 18:41:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v2 10/14] hw/misc/zynq_slcr: Add logic for DCI
 configuration
Message-ID: <aKtA1Le3OW6u1jwb@zapote>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-11-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815090113.141641-11-corvin.koehne@gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x131.google.com
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

On Fri, Aug 15, 2025 at 11:01:08AM +0200, Corvin Kˆhne wrote:
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
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


BTW, I just noticed that this patch has style problems:

e8874ea66c (HEAD, beckhoff) hw/misc/zynq_slcr: Add logic for DCI configuration

ERROR: trailing whitespace
#72: FILE: hw/misc/zynq_slcr.c:571:
+        if (!FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) && $

total: 1 errors, 0 warnings, 61 lines checked



> ---
>  hw/misc/zynq_slcr.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index a766bab182..8d15f0cc66 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -180,6 +180,12 @@ REG32(GPIOB_CFG_HSTL, 0xb14)
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
> @@ -193,6 +199,8 @@ struct ZynqSLCRState {
>  
>      MemoryRegion iomem;
>  
> +    bool ddriob_dci_ctrl_reset_toggled;
> +
>      uint32_t regs[ZYNQ_SLCR_NUM_REGS];
>  
>      Clock *ps_clk;
> @@ -331,6 +339,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
>  
>      DB_PRINT("RESET\n");
>  
> +    s->ddriob_dci_ctrl_reset_toggled = false;
> +
>      s->regs[R_LOCKSTA] = 1;
>      /* 0x100 - 0x11C */
>      s->regs[R_ARM_PLL_CTRL]   = 0x0001A008;
> @@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
>      s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
>                            = 0x00000e00;
>      s->regs[R_DDRIOB + 12] = 0x00000021;
> +
> +    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
>  }
>  
>  static void zynq_slcr_reset_hold(Object *obj, ResetType type)
> @@ -554,6 +566,25 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
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
> 2.50.1
> 

