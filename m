Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F176E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZVz-00039n-Qn; Tue, 17 Dec 2024 10:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZVy-00039b-Fr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:29:38 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZVw-0005oK-Tj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:29:38 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467725245a2so52553271cf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449375; x=1735054175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oU/r0i563De0NrV2eXivMK70+lBQ9PWriyHQbatCaUY=;
 b=N+ehyc7bdDtEOCxpQB0fV9rSFHy8aw1xbZVA+JiU8MSOQLgYP2nYTZEvf86a+DyzGw
 59E6KTAs9dk4LPTZOTym6Wnu4enWlEgcBUZd88LNFCbOYz1vVtlwTqBf20qeS2P49vJt
 8ed0rvDz+P0s+g9dQsigtJdfsRcxPNJK6K7j0gGM90zgFKp9GJE9GlDtbZxJ1CxP5QLo
 gb/H/S/H0RY1qcXMpH0b2NgCQHZxxAeQaXAtAAz+joHcSq8iBH5D6tM/692DPCUehOHn
 opQ4zGFClLL+dvHs76Q29AIu8ofTzThxn/AYGz9Zv6HXPwdwoAk9lPncz7RvKASDF+YW
 boZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449375; x=1735054175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oU/r0i563De0NrV2eXivMK70+lBQ9PWriyHQbatCaUY=;
 b=BXeGVYmuv6Zwrt6w6hymN8ZVRm+HuMwUx4oClaMNgA6RtI38eGRkfNAGeqF5jpsx0u
 lS2+kzHWNQpJx9Qj88EsuaZZBOKaND8+rK+dCpx2cVDnrEL3gxgGOODB8UQ94omFyM/f
 npEyCUxNcZ0byPCvyUU+lj4wnYn33POya/1yclphoMO2vvNKo6hJ/rprw4W70LEFMuwQ
 RncAgpugD0+nXZTZVUqUZEpKgNaUOgziFp02t+k0bR07S9CLQarUBcSLhTK8ulqrxPcg
 8bDF1fY/I3HYzHDX31XI9kHtJ5FVfl7WQzS+jtgEcPBGTU9juSGcINj3Nnxc+MY2biRj
 xPIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOqmePbR7dfpn563rkxBsklPXG3wPlQwnMx0IsX3/Su9y34HW2U8n2G1ElwdsI03ASe4+RK3MJXCE+@nongnu.org
X-Gm-Message-State: AOJu0YxL+wgNTwYKZLPrGMFOASlM7YAp6VLGaxP/8KQlakRJPSUvbGnj
 F6RrllYiXUvc+ym2fCBxWn69Ap/SBarXXS5Ru3lZWEw2aWpErFuLcLXbpWhLdXA=
X-Gm-Gg: ASbGnctQ/GyYwjhSb3uKK4JLj35MWA1bBBIJZgaEyPoPm6h2eqfdW2uYvP0jHmFeqwy
 4OjkRFVZJ9Zwtr/5hRzE7amO9Jo09Py1kWrLUxIBgFqi4gaUwFt/6PyEf5zTIzqn20zSxEreOk2
 z3E7PBoYYTdR4epf0cHNHFm5+2Bp4oBz+y0/YXjH2no9Se9sLVxVJVOdTNsznC6UUdsbTWyfx+D
 sVPs6tye8YzDdrZbzYsUB0Ah0mokDfZdtg6DgqidiuekVLADKFlEdZexJ14bu04dELDHGnqFA==
X-Google-Smtp-Source: AGHT+IF0QiF9xbqSCNoECU7YpaM2n8y0YmtZR3EDerhP4V9kcAYBBkCwhau8ehbvx3sTyUKT2BPpEA==
X-Received: by 2002:ac8:5d10:0:b0:466:8eb7:59c5 with SMTP id
 d75a77b69052e-467a580242bmr284934981cf.34.1734449375417; 
 Tue, 17 Dec 2024 07:29:35 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2e83181sm40232001cf.62.2024.12.17.07.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:29:35 -0800 (PST)
Message-ID: <600bd66a-5b76-4e12-884a-4cf8182ba992@linaro.org>
Date: Tue, 17 Dec 2024 09:29:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] tests/tcg/plugins/mem: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

On 12/16/24 19:07, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/tcg/plugins/mem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
> index b0fa8a9f277..d87d6628e09 100644
> --- a/tests/tcg/plugins/mem.c
> +++ b/tests/tcg/plugins/mem.c
> @@ -135,14 +135,14 @@ static void update_region_info(uint64_t region, uint64_t offset,
>       g_assert(offset + size <= region_size);
>   
>       g_mutex_lock(&lock);
> -    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
> +    ri = (RegionInfo *) g_hash_table_lookup(regions, &region);
>   
>       if (!ri) {
>           ri = g_new0(RegionInfo, 1);
>           ri->region_address = region;
>           ri->data = g_malloc0(region_size);
>           ri->seen_all = true;
> -        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
> +        g_hash_table_insert(regions, &ri->region_address, ri);
>       }
>   
>       if (is_store) {
> @@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>   
>       if (do_region_summary) {
>           region_mask = (region_size - 1);
> -        regions = g_hash_table_new(NULL, g_direct_equal);
> +        regions = g_hash_table_new(g_int64_hash, g_int64_equal);
>       }
>   
>       counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));


