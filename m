Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A86FE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 05:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWUEI-0001Tq-4a; Sat, 11 Jan 2025 00:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWUEG-0001Tg-Eb
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:40:12 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWUED-0007Ic-Ph
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:40:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so61200475ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 21:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574008; x=1737178808;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOSvtagptYw+NpCKjysV15pLrROR3Wppp0AI2AaUmHM=;
 b=mm7raH/5aYEUBSc3YEapmV3RQD3ghv4Q05KWKyx9+cqQL65AuV+dhi7LF/lhT9baBq
 4sgKV7YMkg5/olweM++HSdLik1eZZOs5+XclJj8Ld5KCP78/C/wAmbvu0zWowTb6pON4
 oSYTcAOPjLD0WQ0Ry8z1hG20k/UTWEj83GEMZZiQyG/VBEg3yIGuFhYoNPKnBJ2/9NFM
 6afXkzPs3BYDkz58ojfnozxLTEj0RjlHAmsg/RMZzaXQLPYuhHkMtwjGXynHh//+hD9I
 yS8l/kwokUZTLT6pwMYr5MTVCUbQ57Mn8egM73KMPMt93NKgDVTgdBxKFnbS2u8LreoO
 D91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736574008; x=1737178808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOSvtagptYw+NpCKjysV15pLrROR3Wppp0AI2AaUmHM=;
 b=cnhYCS3ooNl6cu7aLRmSbPxnh+ceddn7Uvmzv2JwfYIv4ntsJ8DRDVUTpxMilnjNsI
 74nehPzgzJ6qyn/86WwRgxOMM6FWUTx+na1cjZkCIIjbPUxpYOudhVT+2VYg/ZRCKbkI
 eDAmQvCbS7oKz2npoXXQRjlniB7fba0gTUikFDlIg34eTYRPLvB44ABLcCFxq9uRI3RH
 chI9SbbfLY6LP87La5dsQLbBgfRPbL92GwTr/KsfRdL5dH0XnU2Sw+Mf22ib7imdIwAq
 ENVdGmn5v/GbnsPK/tBQWOe1HesV7EWHsmCfEs/n8rE04UPuZN5gsrEHluHFbyefK8Vs
 TgIg==
X-Gm-Message-State: AOJu0Yw+XCVeH9I0MxgUjZ6gk486nJDdUdF9nE7DQ6ulBRtlWgx3P7hR
 HhFU00cphsXTqpKmSA0k/30G8VINUr1U7URUlQ1gfwBDabg/oDYaBEnQQkn6XfA=
X-Gm-Gg: ASbGncsDunuGFAyODvToqZ8fZgVcPiEwL+DGUOOfp7+b6Wk9+3kRudcxTyG2FYsBzTN
 6wuFHzwuNk4Gw7VRG4fmqadseOGYCCUq2/Py6xSbFDJwRGOsO7znEHZaq4I11zzByRe8L2QoQBH
 DAes7TWVuK5wDVByhoYpyrA3/IuYTLqNskJ8AuTr6GX8Tz/pWDpNPSiNJOaMUNmIgVuo02AH5n4
 6OeIk7At18OPCTI0MoJWc/rfpdIuPbsHf285Bfzo82HEOlkCl9J3niLmOSZ13QOk+4=
X-Google-Smtp-Source: AGHT+IFndUVWemjHYFG96COKXZaZLesR7XNEKrzJzKg/4ztwTvm5+5PPOKZaxUlmjk/FlS2uFDOmMg==
X-Received: by 2002:a17:903:185:b0:215:b190:de6 with SMTP id
 d9443c01a7336-21a83f3f59amr172008285ad.3.1736574008118; 
 Fri, 10 Jan 2025 21:40:08 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10dd84sm21187385ad.14.2025.01.10.21.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 21:40:07 -0800 (PST)
Message-ID: <4d3ab3a9-b683-4bf8-9608-73d895d8e195@daynix.com>
Date: Sat, 11 Jan 2025 14:40:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Call drain_call_rcu at exit
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241013-rcu-v1-1-a93b7c5957f3@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241013-rcu-v1-1-a93b7c5957f3@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Paolo,

Please review this patch.

Regards,
Akihiko Odaki

On 2024/10/13 16:31, Akihiko Odaki wrote:
> call_rcu() callbacks may have potential memory leaks, but QEMU may
> sometimes exit before draining the callbacks and leave the leaks
> undetected by LeakSanitizer. For example, PCI devices register a
> call_rcu() callback by calling address_space_destroy() and they will
> not be freed until it gets drained. This hides memory leaks that
> is going to happen when PCI devices loose references to the memory
> allocations.
> 
> Call drain_call_rcu at exit to expose memory leaks by call_rcu()
> callbacks deterministically.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   util/rcu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/util/rcu.c b/util/rcu.c
> index fa32c942e4bb..118a974e3438 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -415,6 +415,7 @@ static void rcu_init_complete(void)
>       qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
>                          NULL, QEMU_THREAD_DETACHED);
>   
> +    atexit(drain_call_rcu);
>       rcu_register_thread();
>   }
>   
> 
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20241013-rcu-b4864052a103
> 
> Best regards,


