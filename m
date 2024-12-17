Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC0AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZdq-000622-OG; Tue, 17 Dec 2024 10:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZdo-0005y4-AG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:37:44 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNZdm-00075k-Nc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:37:44 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb7f3b1342so2308669b6e.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449858; x=1735054658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q0lreq9AaC6QdZb/be1xciq5maga91WMxwxyW/TOyZA=;
 b=dZxcyzx9WUX+FGVM/9nrbwIgDoJKBxLv5jp3dmFS2atA8DT+vCk/m6KQkazrXApQtg
 Xnp7xjpop6tLoSJ0fOj6jOtNO1vwCiccUTFVY8Qqk+QUwgTrNDG0kAWxq/kHmBvGifEE
 3WupMAznXAw7ZNx5g/8thywmJuOe8RgSSdMv6llvFQPcWLnFXDOr2BuqbOlf/gXzri2N
 BaxpSmaDA8MNYNpKT1ZTtE3nSYOCS/vwZjNiMn0tx7O85y0tKrxidGkyEog5cCqJuBRU
 HT5UaFzTPhd/+Q966wLlGYGqmE+Ke1B0ykOhGpKs6FzdI84bm3GL3cJhNDQTH1AFbKPn
 ZsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449858; x=1735054658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q0lreq9AaC6QdZb/be1xciq5maga91WMxwxyW/TOyZA=;
 b=RVLWK+txXH7mlFYpMF0S/rcW0jMBd3ecg3FPhywzu5ljapLt63FHNnAByASzoqm2en
 d0FG3dYJbTpUIiD2LXhY9IaeiyKw732VOXJwdPF4scKazchJYZxgMrWraPr/bXFVDRyC
 ZkA2faVgLyrfJMoOAolmucvl0rWpuBHBziK5P6a4fkvdSjYlOUEZ5DXM3B+iYnGC58jL
 eObczIQf08y0xcQYBXc6zBdE/kRd7R8iEgHid373z0I++51FhH6QOsXJNMXgJJcAqLLj
 cqUV28FvDdLgNwlQw49frf6JHbO91Z/E/LbFeof4wVLu3pEq8vUDeLhUUtZeOdernJ9a
 8cmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ7oWONkxnE7VgCU2Ygz1DBWyiOKiv0Xa6GiiPNLBnvfNvTG6c5Fk+uOJkrA8EyUB/gxahclcSoJgN@nongnu.org
X-Gm-Message-State: AOJu0YylO5q+DmnkLiDn0qzZ92lK1cY66jTNNMQ/1wA3z6cVxAUQgGN0
 tf6Oq5ElMgtTLKT5kjPlNg8btcdyigpLqKbZHor4tpEYSlwGNuCZtF9m2MZbSqk=
X-Gm-Gg: ASbGnctyXLsmRzIOCYCSHpNLoyTCgsze4sOj8JXR4gl3yeDfcgG+Cym4XNtd1cokBUk
 AzAs+xmoEJgvVJQ8egHWa4qXeY0Uf76YhB0oFD6snKIORlqfoc++8Pqv4spl7KY2TTbdZNEof2s
 bi0EXGuD9QL1TjZ91vvVIMTO7zXRutHhO+xiasY1GEwpnZt7AKaM/RCGjNDIT5Uq+DJt68BFCdo
 T8pgmieUyYn0wCG/cX/RUKGh9409NnYEMikligCAXCaUg7ZqDXYaego4AQ5Id4TZz8wsabrGA==
X-Google-Smtp-Source: AGHT+IGUMjRqfsAZhw7klP9VtdFZTLa90DZfPiCKZjgGbq6SPJyvU5dNUEzOWYkwKcjENZw8PwWZPw==
X-Received: by 2002:a05:6808:1482:b0:3e5:f656:dd19 with SMTP id
 5614622812f47-3ebcb2b8961mr1794312b6e.19.1734449858430; 
 Tue, 17 Dec 2024 07:37:38 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb47b7caesm2264687b6e.26.2024.12.17.07.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:37:38 -0800 (PST)
Message-ID: <791beaf8-64fc-4174-8fdd-dcbb73dc4294@linaro.org>
Date: Tue, 17 Dec 2024 09:37:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] contrib/plugins/hotpages: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
>   contrib/plugins/hotpages.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
> index 8316ae50c72..c6e64937194 100644
> --- a/contrib/plugins/hotpages.c
> +++ b/contrib/plugins/hotpages.c
> @@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>   static void plugin_init(void)
>   {
>       page_mask = (page_size - 1);
> -    pages = g_hash_table_new(NULL, g_direct_equal);
> +    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
>   }
>   
>   static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
> @@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>       page &= ~page_mask;
>   
>       g_mutex_lock(&lock);
> -    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
> +    count = (PageCounters *) g_hash_table_lookup(pages, &page);
>   
>       if (!count) {
>           count = g_new0(PageCounters, 1);
>           count->page_address = page;
> -        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
> +        g_hash_table_insert(pages, &count->page_address, count);
>       }
>       if (qemu_plugin_mem_is_store(meminfo)) {
>           count->writes++;


