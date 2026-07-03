Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C4DC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 00:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfRzn-0003l4-Sn; Thu, 02 Jul 2026 20:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfRzi-0003gh-CM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:43:04 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfRzb-0000vW-2I
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:43:01 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-381191ea2adso3620a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783039374; x=1783644174; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cqnBRya1C2qxBqUT7BJVOfbRy+ySXjr+DV1JdBFBSK4=;
 b=f/BTd8Ooj5R0bJhMgswidTunKsOTp12EMB34mr87o8uDmh6+dB2Z7qARpti9QGUt2O
 /AoqlN8bhgpLgQP+duoAO3OYHwYbXJkN992GdZVE6Ajl8tCDM8Dzjs+/tAjwdkGGn0Y8
 iHDRUVx8jQkyZt0/jSPJKEEoZg3/NFc+uhZvhFTW+bxRa3JgrOfIiGogxsFZnM1vHhmh
 mKMWqXBGjlJovlJbtukghsht69FquuNX0p2ZUAuUqI7Wb8TXM8Ezx9G1YJwUDSvvN6e9
 onJToqwMKEjO3n79vUej1JPOcOJQcMac00+f/XaO4Rzp1F+j63CfhT4rn5vO6Axc6VFV
 R8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783039374; x=1783644174;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqnBRya1C2qxBqUT7BJVOfbRy+ySXjr+DV1JdBFBSK4=;
 b=DQbxhY2D8+I2LOD2+KzdPg5k9EMsGgX12MbCdgIfIvC718NCtOQwyIjOzRTE+P3WsG
 tfUaVg+Qbl1G0wR8WYN1Rlts+RkN9QqlLHzQk0jtM3gOHQyHFcIXKM+9MXBS31K/w3Et
 rCJQPMmxYd9Y7nESSYumkGil9XL7MI5GBMdBCEeR3zQ2ez5O+Gy5GPofMepiVleeLzmi
 qnCl4ZNzOpTLkDdT1wDcMk3bNlCFOVdiAFhHWaVtJmK2fAdYjlcRwLHGZvV1CL5ggn7g
 PqS+Fia6JsUIE01MAlF7NW4UMzgEhd9hVEeTWd2nE3bjAPe4+35hZJfo0Wvqm7A+MLmz
 7dvw==
X-Gm-Message-State: AOJu0YyqEE9YY3rgh/4YqhliKa8u1C6MegA7+t04tP3c73bUaEeFZWvu
 WwzVLF6vafgqpqoDVO9HsSa9sQW5+IYyiOzzd+ckyhyec6V5DT/9rm0Y
X-Gm-Gg: AfdE7clm55fYNewfSCg29Dht1r5v1EahNiv/PFeYWJf65aCOxChxqoBTHh2swO/FQ9J
 PWRaKjNHiI62KRUYg1GAlRS6lgYo0C7AeTqsZ4xICGYZe+K6pDl3va4wQPsDfO1Ddf/RcCWoVXj
 N/GHH6ZlXRfZDoy0Vl8thST3Ga6Zgc9jY19wmPYyRZ08svW6CzAOs9uwe0WsW3UQ8Z2mFQOVC2a
 BGevChBLFeKPapF9fRm15MdYUThhkY3ouPKiRk/QWw63EP55bIswjGLcDBXEDmVdCTZLHVWurDH
 OqAXMFOmM68eK793shkGTJOw479jng2fM8GlKCAjWMSFei6y3rfh+yJ/RoxHAT2zAiUo30RvNcN
 LTkvRXk2M2a8NjOq6QkE5MasrxD3iYjGmxawz1VJTXgVrjoMXZA4wbX0D11N/EjdjFVY++HGuLM
 REF0wlihAO+NRZp6GVaRQ65ycJDd7ILjYctMA8qznHerbqmmQv
X-Received: by 2002:a17:90b:2807:b0:380:83fc:4315 with SMTP id
 98e67ed59e1d1-380aa206b4amr9572157a91.21.1783039373620; 
 Thu, 02 Jul 2026 17:42:53 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f1595e912sm11393962eec.31.2026.07.02.17.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 17:42:53 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:42:50 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/33] target/i386: Remove duplicate tlb_flush() call in
 cpu_post_load()
Message-ID: <akcFgoelvTDJdXLl@ChaodeMacBook-Pro.local>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-3-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630220100.1289-3-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x04.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jul 01, 2026 at 12:00:29AM +0800, Philippe Mathieu-Daudé wrote:
> Common vCPU cpu_post_load() handler calls tlb_flush() since
> commit 9656f324d25 ("Move interrupt_request and user_mode_only
> to common cpu state..."), no need to call it twice.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/i386/machine.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 1f5c517e562..df0e0c178e4 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -401,7 +401,6 @@ static int cpu_post_load(void *opaque, int version_id)
>          env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
>          cpu_x86_update_dr7(env, dr7);
>      }
> -    tlb_flush(cs);
>      return 0;
>  }
>  
> -- 
> 2.53.0
> 

