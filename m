Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA799C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9YI-0002dy-Bo; Fri, 11 Jul 2025 04:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9Rz-0001GN-Ki
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9Rl-0003GU-Lt
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6BRCnf6mn+tkU+QW5UVDKA7KXoonGizNF03QOyneTM=;
 b=cchW66xItAscNNJxtfzpKkUUVg6usJwsySh8m6tZFM9ccpVO1/NMgVtFfNzZ1+yycCxJAA
 nN/o0bdQLTx3tlj4Xe0ebYg94saTr3GtDEXmw2vViogP7CgpxwxsoUPjOJilYCsyMt9c1k
 xC46xpSiMVNf1pDFikkhB2t0m9keMt8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-XJhcgSWtNUO4KeVrpiQySQ-1; Fri, 11 Jul 2025 04:49:31 -0400
X-MC-Unique: XJhcgSWtNUO4KeVrpiQySQ-1
X-Mimecast-MFC-AGG-ID: XJhcgSWtNUO4KeVrpiQySQ_1752223770
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso9556685e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223770; x=1752828570;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6BRCnf6mn+tkU+QW5UVDKA7KXoonGizNF03QOyneTM=;
 b=is8o2C0GCZJ22yfHjM/RCvAzzQmslVbFaxVz3jGXKZUCOWcJ9LY26Uq7ZoH214z9gx
 Vdvp9F7k9fSyquXK7HfZ9nopcxPsVGGjnyrY6Bw2KS+FAfBUN2/PIxNbHv85+VgEHJRF
 iwf1htLnNfBeUOlmI6fZrRtEiuBRD02S7ZhZmzg5BxDpVW+ogFOpD5XC9denLr4kplZ7
 h1PWRNznT5tLXLH6iHGOdHP+6lpeEEzniGINq9mMjXwZ8u7wueZ+YfRbcrfefjqKsqU2
 tDQuv4g8QMjOwk64fIYFb+59ET6p4O1DV+QScpVM26soNMPyg6DZTxW9H8NJ+82rsctY
 PTeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ZnHiuOGWyeNO8JrTEvQTgug/nF9k4D8OdQYDVI0tR75xUtySENy4Dr1MGHImArc19T+x5tfzc1MA@nongnu.org
X-Gm-Message-State: AOJu0Yz86rzIdTUR+1NYBe7Ozuu1l3774RipNAOFkcxiTDLt9GiR7Ztt
 UjZmO/cABZUsPABJ31gYsOPDsA7D7tanT945PoIk9mrjWOKf2IXKU+bNUlLbe+MQNtxw4DJjXmX
 wkiprHE3qQcVryWk833pII8XiHQRI1fA/CwoscYMkYFMggsy3HyMtW86v
X-Gm-Gg: ASbGncvGPIHvouINVx0IckXMp9BFn2GnA4KPePFW3mO86RNjMT4+W9HoZb6jIn659Je
 pNlnbk2c+4uo/oBiNpLi4/p49+27CQLbLax/LCykwkfez/EC2Dpcix9ytgcxKHDALJD7MCv7a/K
 tKvFxjMzQitq38rOXvjxgLaf6iJrhftgLwP1B1TUI+dbwdyVIHvKFP4RFtD1EU5m3QXYGuVJzYE
 kr5mSliH9/jCu98+mTvcfIFWYkpQnMELqPooUAZ+Dk6+SbzznYeYm7mdrAfRa1ssw44QhfY3Mt/
 +HBXQyAQw7l5kmUlGI5uLlUPGfdQr3LOOFRIUl9L59gIRXMAf8St4shmQgvbNuEDuXc9k5doeRK
 iYskL
X-Received: by 2002:a05:6000:230f:b0:3a4:f70e:abda with SMTP id
 ffacd0b85a97d-3b5f351dea6mr1290079f8f.10.1752223769967; 
 Fri, 11 Jul 2025 01:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz/2gff4Ok+yuIsqtgiYhWyQE08H36eE028JImxIxWWMC8MA1qaP61v4WuAgAIFbLu9tgCPg==
X-Received: by 2002:a05:6000:230f:b0:3a4:f70e:abda with SMTP id
 ffacd0b85a97d-3b5f351dea6mr1290052f8f.10.1752223769417; 
 Fri, 11 Jul 2025 01:49:29 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a54sm3967219f8f.39.2025.07.11.01.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 01:49:29 -0700 (PDT)
Message-ID: <540f9942-d936-42c8-92ab-0f9a1281ddf1@redhat.com>
Date: Fri, 11 Jul 2025 10:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/s390x: Extract system internal declarations to
 s390x-internal.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org
References: <20250708095746.12697-1-philmd@linaro.org>
 <20250708095746.12697-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250708095746.12697-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/07/2025 11.57, Philippe Mathieu-Daudé wrote:
> Simplify a bit the big "s390x-internal.h" header by extracting
> system-specific declarations to "s390x-system.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h | 222 +---------------------------------
>   target/s390x/s390x-system.h   | 215 ++++++++++++++++++++++++++++++++
>   2 files changed, 217 insertions(+), 220 deletions(-)
>   create mode 100644 target/s390x/s390x-system.h
> 
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index 56cce2e7f50..dddd4460400 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
...
> @@ -257,11 +120,7 @@ S390CPUModel *get_max_cpu_model(Error **errp);
>   void apply_cpu_model(const S390CPUModel *model, Error **errp);
>   ObjectClass *s390_cpu_class_by_name(const char *name);
>   
> -
> -/* excp_helper.c */

Please don't remove the excp_helper.c comment here, otherwise the 
s390_cpu_do_interrupt() below belongs to the wrong section here.

> -void s390x_cpu_debug_excp_handler(CPUState *cs);
>   void s390_cpu_do_interrupt(CPUState *cpu);
> -bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
>   
>   #ifdef CONFIG_USER_ONLY
>   void s390_cpu_record_sigsegv(CPUState *cs, vaddr address,
> @@ -312,87 +171,14 @@ int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>   int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>   void s390_cpu_gdb_init(CPUState *cs);
>   
> -
> -/* helper.c */
>   void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);

s390_cpu_dump_state() should get a new comment in front of it:

/* cpu-dump.c */

> -void do_restart_interrupt(CPUS390XState *env);
> -#ifndef CONFIG_USER_ONLY
> -void s390_cpu_recompute_watchpoints(CPUState *cs);
> -void s390x_tod_timer(void *opaque);
> -void s390x_cpu_timer(void *opaque);
> -void s390_handle_wait(S390CPU *cpu);
> -hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> -hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> -#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
> -int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
> -int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
> -LowCore *cpu_map_lowcore(CPUS390XState *env);
> -void cpu_unmap_lowcore(LowCore *lowcore);
> -#endif /* CONFIG_USER_ONLY */
...
> diff --git a/target/s390x/s390x-system.h b/target/s390x/s390x-system.h
> new file mode 100644
> index 00000000000..9c7958742d3
> --- /dev/null
> +++ b/target/s390x/s390x-system.h
> @@ -0,0 +1,215 @@
> +/*
> + * s390x system internal definitions and helpers
> + *
> + * Copyright (c) 2009 Ulrich Hecht
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */

Can you please add a proper SPDX license identifier to new files?

  Thanks,
   Thomas


