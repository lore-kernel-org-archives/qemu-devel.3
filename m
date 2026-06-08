Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E91CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 02:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWQBS-0007vc-5n; Sun, 07 Jun 2026 22:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wWQBP-0007uZ-2k
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 22:57:47 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wWQBN-0006IV-Fh
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 22:57:46 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1382533d428so1297889c88.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780887462; x=1781492262; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F0ybTsXpRtSsOnAJvkaAfgt66zHmzQMMx618/yj4OKw=;
 b=Mkn2PYkOHlqzEbtL941FO/yjd8HP9xfbJIXUXSFGtyd9iOSGZAI7izTF0xWgiRxw1S
 rpXTiEN2xm8AmN1c11z61Hc1w+uLMOPKugNThrZkdmWs9ebR2VZeEkzfb4B6HSerKqX3
 SXal3JUprHQ5rVkdw40pyTwqCFkh5qFc0Ye3BJSwnj4QmtYKMop+ExiWPALGecGWUFIM
 LGFz7PuTZFvPBMqEoyWlaJU3LiVWrwCdTpf6enp/+t6lXLRvGs9q7If2WkROfToezenQ
 Aun41XzVAYbQETm+qiCdkwCP3ecKassX7O4XNrd202SJX4rrXQCwgpV6PSfx0FhNbZab
 3Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780887462; x=1781492262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0ybTsXpRtSsOnAJvkaAfgt66zHmzQMMx618/yj4OKw=;
 b=bXw3ayv5ouUGR7rRITYiIgDFNU1UcYV2gy852ETa2O0fU8T6CnK/5UZKxHvLubOt3c
 NkP3Hb55KQcfEGlp/adHvxm5KkABz22q5YXrloQ5QI5fsQxJs1xPMUUbXkDIumem/7kQ
 4GctDbiKRDgMoytgtqjb1XLkaSXGLxWniYx3YtGB03Qv0Z5j9Hl1uPvPQ5jwYKo2qUeT
 8hHgIl5oVBlZnxgvsKnbzHWQ2Fql5bO7GNOe7BCcC0QUqVg9LGjXVL/iLc59ins19+z7
 FLzeR9cbWcfI4PQb7BedvDZAus0WKql9uuxb5TVGy9fcL6hkXZoTaYjedFt4XM+/LfOz
 WPXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hN+6R3MOOxVGG3EQpBAItD7lpFXYyxy6o/oIm1k8o84NM96aiAl+DFjlhJsWJKmwjVfbUg4pM9lWw@nongnu.org
X-Gm-Message-State: AOJu0YzptrzpSHEikRvF5hLq3c5WBFL2QUcRI3QnRtu0IT8jjQtQY0bK
 pbHXS5EBCurybPmCJsOfzKXfj1di4K7wtm6PpSxeNHo1vZcCSfQiN42X
X-Gm-Gg: Acq92OGdEDs1ENefFXNxzImfMSNRXZaIsY1fsCwTU2uLxel+C5apy3Y9I2PnoBL8YPV
 cYDOaHbuJ9YteFFkEJCDdYoVfpN9rI7o9IlMIJlHF4UzTk4tOzKn4EAkxf4hPKglG2HN33wn3Jf
 P9qLlsqS/kRMegZze1lrL6BIZK7nrYOOIiNRE3b+vTzdtVr3Vy6T9mN8iASJK8kpJ2xyo6ApBGX
 WRb9KoLfhEGARwuEI3hxOf21sWFgDDgK8Cq44HOV87vezQnSx6n0XYvxZoutFIZCWaB/zZsAYh8
 wDWSsHJoW2FUf+1BjSWBP0CGPPru5FWAkCwwdvGCRaA+90EUEUxT/P5Ho273aLKvbMKYzF7BQu7
 aToFFkhqLMxBulVWuVx2uHE7NZfKUP5L8hhGB3XMTJJMQNeu8G6YF8SpIgzcul9A+OvCIvaDk7J
 BuG6qFrru5onN7ymtcaoRCebBNVrZj0VTI+ytUsZJt2Z2kcqj2Uj4oGa+iOeDZCJHSZmYW1SAS2
 QdfR4Us
X-Received: by 2002:a05:7300:bc06:b0:304:dfae:68a with SMTP id
 5a478bee46e88-3077b29b6c7mr7022266eec.28.1780887462237; 
 Sun, 07 Jun 2026 19:57:42 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm20199224eec.23.2026.06.07.19.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:57:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:57:38 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, 
 Alvin Chang <alvinga@andestech.com>, Yu-Ming Chang <yumin686@andestech.com>, 
 Joel Stanley <joel@jms.id.au>
Subject: Re: [RFC PATCH 01/25] target/riscv/debug: Check only mcontrol
 triggers for break/watchpoint matching
Message-ID: <aiYvkZXHIObH_mK1@ChaodeMacBook-Pro.local>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114044701.1173347-2-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
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

On Wed, Jan 14, 2026 at 02:46:34PM +0800, Nicholas Piggin wrote:
> trigger_common_match() has some warning log messages in it for
> unsupported triggers. Don't call it in BP/WP checking except for
> mcontrol/mcontrol6 triggers applicable to BP/WPs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/debug.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5664466749..4273ab7a8d 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -952,6 +952,14 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>          for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>              trigger_type = get_trigger_type(env, i);
>  
> +            switch (trigger_type) {
> +            case TRIGGER_TYPE_AD_MATCH:
> +            case TRIGGER_TYPE_AD_MATCH6:
> +                break;
> +            default:
> +                continue; /* No other types match breakpoint */
> +            }
> +
>              if (!trigger_common_match(env, trigger_type, i)) {
>                  continue;
>              }
> @@ -976,8 +984,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  }
>                  break;
>              default:
> -                /* other trigger types are not supported or irrelevant */
> -                break;
> +                g_assert_not_reached();
>              }
>          }
>      }
> @@ -998,6 +1005,14 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>      for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>          trigger_type = get_trigger_type(env, i);
>  
> +        switch (trigger_type) {
> +        case TRIGGER_TYPE_AD_MATCH:
> +        case TRIGGER_TYPE_AD_MATCH6:
> +            break;
> +        default:
> +            continue; /* No other types match watchpoint */
> +        }
> +
>          if (!trigger_common_match(env, trigger_type, i)) {
>              continue;
>          }
> @@ -1036,8 +1051,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>              }
>              break;
>          default:
> -            /* other trigger types are not supported */
> -            break;
> +            g_assert_not_reached();
>          }
>      }
>  
> -- 
> 2.51.0
> 
> 

