Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08894FC97EE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 21:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6xiH-0000ky-T6; Sun, 29 Mar 2026 17:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w6xiB-0000kZ-AD
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 17:30:23 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w6xi9-0007KX-Ck
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 17:30:23 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35c2fe0d90fso1332164a91.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774819819; x=1775424619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53K8eaux8XzmY+23kbJkDV1nwI3zj95XEutby50E49w=;
 b=TuhdHA4jiJD4Q1sG+CRt9h8M5fS7Z15tNejuJdfUE/oTGYmOiTHtFT67JlM2BmW7Kz
 GUjINcONnzKs9AXILUiygqHLoWOP88R2siSIeA49CTZYPFjuvHsBKavObXr5zZTBI1Iw
 4x5j6mR09qgsk8Rg+BWQxJE4oa78idWJcnbF1iodbuoPdeHTyNpRpB8tSbIsmUYkKB+P
 oDh6pm9x71mdxy0LX4N1a3bGfwoiYpE7C0DnOE7iU9WwUOLP0yBSDk/c0OzaOsBYZzZb
 9OTIl1hk8IPw/yxNwXuD3iD+OOeZxEvDpYJJJqFOTXldWT+ftQqNH9yFhB3e4tQ1addp
 PVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774819819; x=1775424619;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53K8eaux8XzmY+23kbJkDV1nwI3zj95XEutby50E49w=;
 b=MUdCoQeWmL9WPe1KuFAX/LAgPi+ImczTXZNTvSw6gjj93eHNkJRyElpAoDaH1Z0zGE
 /EwlrwT46Zk/9L0niKTrxiQjiFTfkG7mfSfowkDAXgNKs/2pmN1sx0RcTPhumuLmJYrp
 5UNEVGPLtXrSXmzV2wFg+qP9gf/wOuRhbo0hBTMM/bv36/0ks7OQZcrlFD3WhBKxCqrn
 fYlnET+bIM5mjEkOJTNoshRf/O2QRvLkeB4dg7qo3qFqZx0gGoo170BxAuBSR0F+jpGX
 tLO695qjuHJNQfXl2p5i1RZtp2HmkWgS+5F34H+VlSwbRX6L7jBcQua8U1D9AX9GBWgM
 V0qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUKqxELAeZk3v2cFfJTnzLmAJwvuJAkIrJcMunnUEicgiUlG7cai5CHWdtrpiFaGjt40qPKO4AjdoO@nongnu.org
X-Gm-Message-State: AOJu0YzGLj/ObXd3yppsb1RWyAxD8/4uYmfLeOcb0hSNiKyMDRL6d8vV
 I2LVtsBkX26gVvzieh+DEaT6tXs7S94w5ykoD+uddxtZEFjnYOfqRSORYR575dN3/Ec=
X-Gm-Gg: ATEYQzxONtiSfHrT10JTpgHxAQ7fmSX/flG8pb0jhFKzQmA0RlPfidblbg7CTvv30gd
 K3xZViFBVMRiDh/MOr82CAUjTsj/GB3oegJHQ3m+bOl/1/AsT3EtgLyCgihlJDBeaxF5Tc+NwCE
 qxhU2D37GK8lRar7isv0g0/XdXk2hd5Uk09vDCVZmvEDjYKBJv04TMEq24lwE8/vFYFEFXRFAK5
 kYQreDyHQmSiZc8A3mg3oorv/X6LFcczXmRbdoYgMT6y5DQGToRCHzb+ndNB9ro1ueuoygX+2gM
 V/F3p492V3XjXIkaW5u34jCor3RBx67VSiEGZHccwTcEQ7riKuUXBMFvtV6w5W0v2TGLh3SjrD4
 OlmT6hcmNgXSsWOgqVmY+7cSKhPwkDylmbfVpDjrzSYYCzXl+T/QNbZZalPfRocIhTzM/JRNivk
 EbPGqq6s4BcifGuqq5S9/u7o+eoCHD5oSX+5sDtAYRa3LEca01mw==
X-Received: by 2002:a17:90b:3b4f:b0:35c:cba:3453 with SMTP id
 98e67ed59e1d1-35c30076fe2mr9990941a91.22.1774819818698; 
 Sun, 29 Mar 2026 14:30:18 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35da9ef1b70sm642405a91.16.2026.03.29.14.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 14:30:18 -0700 (PDT)
Message-ID: <a700c7c2-9d70-4237-9ddd-dc09b75dbc1c@linaro.org>
Date: Mon, 30 Mar 2026 07:30:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 2/6] monitor: Remove MonitorDef::type field
 and MD_TLONG / MD_I32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320091019.59902-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/20/26 19:10, Philippe Mathieu-Daudé wrote:
> None of the few targets still using MonitorDef use MD_TLONG,
> they either use MD_I32 or the %get_value handler. Remove the
> MonitorDef::type and its definitions altogether: simply check
> for the %get_value handler, if NULL then consider 32-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp-target.h |  4 ----
>   monitor/hmp-target.c         | 12 +-----------
>   target/i386/monitor.c        |  2 +-
>   target/m68k/monitor.c        | 24 ++++++++++++------------
>   target/sparc/monitor.c       | 14 +++++++-------
>   5 files changed, 21 insertions(+), 35 deletions(-)
> 
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 5167d17d41d..56322ceddd4 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -34,13 +34,9 @@ struct MonitorDef {
>       int offset;
>       target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
>                                int val);
> -    int type;
>   };
>   #endif
>   
> -#define MD_TLONG 0
> -#define MD_I32   1
> -
>   const MonitorDef *target_monitor_defs(void);
>   int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
>   
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 420969bd6eb..3f019ae2a28 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -82,17 +82,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>               } else {
>                   CPUArchState *env = mon_get_cpu_env(mon);
>                   ptr = (uint8_t *)env + md->offset;
> -                switch(md->type) {
> -                case MD_I32:
> -                    *pval = *(int32_t *)ptr;
> -                    break;
> -                case MD_TLONG:
> -                    *pval = *(target_long *)ptr;
> -                    break;
> -                default:
> -                    *pval = 0;
> -                    break;
> -                }
> +                *pval = *(int32_t *)ptr;
>               }
>               return 0;
>           }
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 446428602ef..977f65fe16c 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -602,7 +602,7 @@ static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
>   
>   const MonitorDef monitor_defs[] = {
>   #define SEG(name, seg) \
> -    { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
> +    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
>       SEG("cs", R_CS)
>       SEG("ds", R_DS)
>       SEG("es", R_ES)
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 08ced037b47..94bb12833af 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -24,18 +24,18 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   }
>   
>   static const MonitorDef monitor_defs[] = {
> -    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
> -    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
> -    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
> -    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_I32 },
> -    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_I32 },
> -    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_I32 },
> -    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_I32 },
> -    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_I32 },
> -    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_I32 },
> -    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_I32 },
> -    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_I32 },
> -    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_I32 },
> +    { "ssp", offsetof(CPUM68KState, sp[0]) },
> +    { "usp", offsetof(CPUM68KState, sp[1]) },
> +    { "isp", offsetof(CPUM68KState, sp[2]) },
> +    { "sfc", offsetof(CPUM68KState, sfc) },
> +    { "dfc", offsetof(CPUM68KState, dfc) },
> +    { "urp", offsetof(CPUM68KState, mmu.urp) },
> +    { "srp", offsetof(CPUM68KState, mmu.srp) },
> +    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
> +    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
> +    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
> +    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
> +    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
>       { NULL },
>   };
>   
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index e9300ded4ad..a60671a60a4 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   
>   const MonitorDef monitor_defs[] = {
>   #ifdef TARGET_SPARC64
> -    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
> -    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
> -    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
> -    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
> -    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
> -    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
> -    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
> +    { "asi", offsetof(CPUSPARCState, asi) },
> +    { "pstate", offsetof(CPUSPARCState, pstate) },
> +    { "cansave", offsetof(CPUSPARCState, cansave) },
> +    { "canrestore", offsetof(CPUSPARCState, canrestore) },
> +    { "otherwin", offsetof(CPUSPARCState, otherwin) },
> +    { "wstate", offsetof(CPUSPARCState, wstate) },
> +    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
>   #endif
>       { NULL },
>   };

Doesn't this completely revert patch 1?

r~

