Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E91099B40
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3hkh-0001jv-GM; Fri, 20 Mar 2026 17:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hkd-0001je-SF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:51:27 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hka-0001Vi-U6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:51:26 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ad9516a653so11148405ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043483; x=1774648283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWFuE+0LizUOl7DhNeN9aVSmOiaXaQAlDc65xJAwLcg=;
 b=zNvThdm25qwiF2MvpqZhRpeIyqe95bKQs8eoNv3vgR4+hDb3+o9u28w89lu7UMhrpG
 RASoVtQLXvPvzI65bD122e28+vBdTxoWY9w3HfleDlWAeNn93fazYAVrYn2Gmul/TgjH
 eaO8UigAxKS0VVhZB7AXduZzfFO5biHMwXiiKjYvwPka8Y0Mcm9W4qqsNgtL2YSwFzIV
 akQk0J1EC9LOGjqlAZsB+0WwE+HeClH/hTfRm4eEgG9gyphAnEWHu1G1arkpJdJ3evay
 HMjs+NDqof8zsWEK72p25z/fVSlb6b3Sth0dBy2BTbyYyLl697ewv8mQ0TggnmD9tBn6
 UPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043483; x=1774648283;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWFuE+0LizUOl7DhNeN9aVSmOiaXaQAlDc65xJAwLcg=;
 b=DUCCIZWHOxeFKdxjo7JVGjsH64JanlUhHQr2e+8eB3Hz7KZobtFBcuTH16F4wyldGp
 3WwtBPaJkhoxq+2gKMG0K0KDir9gXDVO+bfWbZi0XVOqf/YO1IgmNahyzhRphmCWcVsD
 p/rtneMqDVBF5Mb/qiBUpY0dT1jiZuo6E/Er9PP/ER6+M6Q1DfaRuUOWuRjvmuVuEYkk
 EW5JiObPhDa5CflMXgpqb6Vo02PsLX4X51JMvNS73oNhYXk6sh0KSFVpkh6SHYY7BsNz
 n5tQGVD8mvUIGQFK7AitHNtHot00HE20FUpMER18sbgcB2e4FwMlBioNJTyRZARLxIRs
 A8ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkaHr3YYX9OVK13slTvoYjbrKZDMPUBMWjtayxqpaWKmI1eJVhCJJkCu2UK9EmuCizCP+nfb4a1RZx@nongnu.org
X-Gm-Message-State: AOJu0YxX4QDs2KozFlYMxQUfiW3c+/tUU2ERlG4yavrJVbFkTiNH8q7p
 KPzpzS91IwkXNXlkiY49RDsH+bqLyzlQrD8NnK5qV2MiCBWIfEXsjEYCQ4cS7CdgCHI=
X-Gm-Gg: ATEYQzwZSKio+kpLzaUZnYPjtdaWmNYbym67BEGcKLHNmiewx850pd/AuTYY5Lxrd6/
 ygfbDJxwQEkZZf3dSFcqjC01z6cmoAl27o/rujIuGOqgB6D4d8HOtPQ1b8t7Nroe1KXkKo8PC0H
 OLrg7DxmPo2KC0V8XZbwxUdTA/N4SpDHF9gN2YZ2ruhfMAfpRpkRvm0MvFArFA8/7UhzWRJl3ln
 yRaHKEAYKFLGdkV+UNQIpsk2iZHUN4GZI8dAtChW7c5eQY/MPqM0pU02PgeC2zJYNyN6T1IZEhW
 11a8oAqpRUe3PkliL5NmIN5W+KA2DUELroeOTwGokacCgxB5JrfATWzAHakSUh5Ns0dD3HneRLG
 BctFdehhJZCZDd7zwcXm+6UMt//Yey/I7tznAEC8y4UhNRH0NEjasoRMPmMwVkR58CT3E291ZAU
 NY/jTdRgPJPlNQ0jTPoM/r4QT76jMoLixLi7WPheQ5o/gtpEvGHFrVgztDMvYkSBpNwEEuWDIrZ
 rWDk8U=
X-Received: by 2002:a17:903:2f87:b0:2b0:4c8b:7d33 with SMTP id
 d9443c01a7336-2b0827d5356mr37925155ad.51.1774043482873; 
 Fri, 20 Mar 2026 14:51:22 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083655b5dsm42277765ad.52.2026.03.20.14.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:51:22 -0700 (PDT)
Message-ID: <858c6dde-8ccf-459c-acfe-af38bcba977d@linaro.org>
Date: Fri, 20 Mar 2026 14:51:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 4/6] monitor: Remove last target_long use in
 get_monitor_def()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320091019.59902-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
> Truncate manually, removing the need of target-specific
> code in get_monitor_def().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/hmp-target.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 155caedd784..5e9f1b0db5b 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -34,7 +34,6 @@
>   #include "qapi/qapi-commands-control.h"
>   #include "qapi/qapi-commands-misc.h"
>   #include "qapi/qapi-commands-machine.h"
> -#include "exec/target_long.h"
>   
>   #if defined(TARGET_S390X)
>   #include "hw/s390x/storage-keys.h"
> @@ -93,7 +92,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>   
>       ret = target_get_monitor_def(cs, name, &tmp);
>       if (!ret) {
> -        *pval = (target_long) tmp;
> +        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
>       }
>   
>       return ret;

Looking a second time at it, I don't think you need it. Same in previous 
commit.

Since pval is a pointer to a (signed) int64, sign will be extended from 
32 bit value automatically. So either, it's a positive value, and will 
be treated as it is. Or it's a negative value, and all upper bits will 
be set to 1.

So the casting in int32_t has no effect, since it will be extended again 
automatically.

Regards,
Pierrick

