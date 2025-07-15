Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC366C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgyr-00040Z-3a; Tue, 15 Jul 2025 10:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgFG-00014T-Ra
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:02:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgFE-0004eG-Om
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:02:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45629703011so4326715e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588174; x=1753192974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FH/ZcURhLo0Xm3FSEsSZ2gz9up2wAsUxgJVAPjae0kk=;
 b=vHhQE6LRyn25YrZXqTQIL/EVh3aaO+les1fyuOVbiZyvpx8vPUBsvYjRjUWX7F0LuY
 PmuU0oxjh0mokrMB3lt33j30FHpixcMKNgUiU3utulgBXARwgM+RKin3tttYbHr//ZkJ
 jDTfN3+pDfl+QDbDkGyIq2Me3ES1YJbJ6diH5O7DwmptcU3IxU/UJoMbNQSRDI5L+obI
 Gz0CQ4BU4a+6zlOgsJCtd6xV+5v2rCd132ZY5Nf+BofLWSv1gd30LECGyemamHPOlYos
 7KZ6cNMdw7/3FNkRDN00D71j6iqEk03LIC53dMd3Sp9Zvy9thdmBbQk5Ttxzq8CHIvww
 iWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588174; x=1753192974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FH/ZcURhLo0Xm3FSEsSZ2gz9up2wAsUxgJVAPjae0kk=;
 b=UuMtonKSK7Tdbc52g1sbRYrM7TuK/sdG/+eczb3QcFcmeuX5YpGbcSE2r3cWJGvQMI
 eX2y0xKr71MiYz8V1sCD5YuBUzzniItVzxarWXtdZrZH+KPLX5omoJLWIXBVlwZoSLfd
 w6CHZ8UwRiVCS/auBbMYXi46J/lNKU7SpL0+tLRdXdKyK3WZHRT+WLlZrfAmE73BiniD
 W6wkHzl+c8xLuXYGXIpHJ8NMy4+V0ZHHXvJuiQa2cPK6l9rsil9EBICSp498JzWqdK7k
 oPQ436oFkBNAqDOwBj3V8nmE14BIHgP/kbVGSTrO0hrhDqNyDx/lqcDGjanLYCYeZEsK
 5bew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu9a0dFiZGC6D2klvQJjCWOCZ0hAuuaaXRGZU5JV0diDHSxUiAZRS/6kGotoxobozXM8Ct6MDPPkLx@nongnu.org
X-Gm-Message-State: AOJu0YyJShgIYDIv7lxBrXfqCOIUhdmA1z/6rEgaIla3rSFyZw17+8mk
 FF0SvleQdHA+jqvTMW8BbX/GR3HUBciasHVJ3m8Q1YtdqPTRDFPaUGfm+cjKjI7wZQsinbaQ7YH
 oOu5K
X-Gm-Gg: ASbGncs87s9sX45IB+G2THEPgZ+eCY3NUjt60zCAnT6lt23/OyeVInyTHtkraZ88pSG
 e7gI1nDv6gpkbdVzQy3JgispJ4ICdE65HCCHUfiJym70MnsXe0PHOwDx28UHDib6EIqp4XMesTn
 xCweEYiWxZWnDlbZbuuc58H3PJEDtt+MmtlQJuXBpvQg3K1p+Rh+ModE75pPoJn2TFwyMlm3JIr
 CaZ5QEJsowCTyh/quf5K8yMgvvOXPcDpsQNvA4NCfpP1u0SHR71sdMGI6gjEFOdBapCn/154FVK
 muGYBFnPUzNRYgxaVpQ5gLmirvqCz643DP7EyTzqQZbUPsZpcPJXYBVeLQ+ZSbNqfVhKk5Fje/2
 Aa/Ymf51ylFjgjhrflHrOblwdNCMJB8juMtszAP0DeqxaMKa4dwn6/JXM5yegYdIHLKBEjkyPzH
 QK2Ts2pQ==
X-Google-Smtp-Source: AGHT+IGHIyq73AhZQ9NMo5rsxHdv/8VxtmdsksZYEAOH9NQbTRR5odycRh/+t/J3SZc9jC0s5HIMaA==
X-Received: by 2002:a05:600c:3d8f:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-45565ed6320mr167703835e9.16.1752588173774; 
 Tue, 15 Jul 2025 07:02:53 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc22a8sm15568934f8f.34.2025.07.15.07.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 07:02:53 -0700 (PDT)
Message-ID: <6c8032ff-1724-4868-a83c-84f297d39921@linaro.org>
Date: Tue, 15 Jul 2025 16:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cutils: Add time_us_to_str
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-3-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715124552.28038-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 15/7/25 14:45, Fabiano Rosas wrote:
> The migration code has a function that converts a time value (us) to a
> string with the proper suffix. Move it to cutils since it's generic
> enough that it could be reused.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   include/qemu/cutils.h          |  1 +
>   migration/migration-hmp-cmds.c | 17 ++---------------
>   util/cutils.c                  | 13 +++++++++++++
>   3 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 36c68ce86c..7621726621 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -171,6 +171,7 @@ int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
>   int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>   
>   char *size_to_str(uint64_t val);
> +char *time_us_to_str(uint64_t val);

s/val/us/

>   
>   /**
>    * freq_to_str:
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index bb954881d7..1706f3a0f7 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -52,19 +52,6 @@ static void migration_global_dump(Monitor *mon)
>                      ms->clear_bitmap_shift);
>   }
>   
> -static const gchar *format_time_str(uint64_t us)
> -{
> -    const char *units[] = {"us", "ms", "sec"};
> -    int index = 0;
> -
> -    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
> -        us /= 1000;
> -        index++;
> -    }
> -
> -    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
> -}
> -
>   static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>   {
>       if (info->has_postcopy_blocktime) {
> @@ -121,8 +108,8 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>           monitor_printf(mon, "Postcopy Latency Distribution:\n");
>   
>           while (item) {
> -            g_autofree const gchar *from = format_time_str(1UL << count);
> -            g_autofree const gchar *to = format_time_str(1UL << (count + 1));
> +            g_autofree const gchar *from = time_us_to_str(1UL << count);
> +            g_autofree const gchar *to = time_us_to_str(1UL << (count + 1));
>   
>               monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
>                              from, to, item->value);
> diff --git a/util/cutils.c b/util/cutils.c
> index 9803f11a59..023793211a 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -1004,6 +1004,19 @@ char *freq_to_str(uint64_t freq_hz)
>       return g_strdup_printf("%0.3g %sHz", freq, si_prefix(exp10));
>   }
>   
> +char *time_us_to_str(uint64_t us)
> +{
> +    const char *units[] = {"us", "ms", "sec"};

(static)

> +    int index = 0;
> +
> +    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
> +        us /= 1000;
> +        index++;
> +    }
> +
> +    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

