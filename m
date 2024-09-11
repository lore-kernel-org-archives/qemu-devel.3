Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BF5EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE2G-0002Nz-Ba; Tue, 10 Sep 2024 23:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE2F-0002Jb-9U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:28:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE2D-000148-Qw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:28:51 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-201d5af11a4so66610505ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025328; x=1726630128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/4HX+beIu9n3Quu0AyNEfLp63zi1fd1zBwX3NHqEW0=;
 b=TsgDBP4tdq/Tj5jbmWKqk7C/aJ2MCoeRu4SdxvK3byZsXc7nefhhd+M8ZvKeXoV6xj
 uxZXJGT3rKofdTq32JPDqly5TEOYpUQ1iUXEwOFIVORUtKCkYmaVL5XjR00ctMu11DhK
 P3BJSI47NN7+O0YwYpr4vEG4GFfqY0S14jxx0TaPY5UiPyM8ToD4D/AG72i0HApcy1V5
 INIInaFPJBiVWDIOsg1kmsP79yzXM+gBStJagZOnKYBNitzKtIioMmW7GYXdIYY7dmjF
 49rVIDUPh2bQQOlYzKdfLXDbIIOZjc9d68n4Ln4Rdlk9E/rr3lzz69q2luWcZfHxXSHz
 EzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025328; x=1726630128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2/4HX+beIu9n3Quu0AyNEfLp63zi1fd1zBwX3NHqEW0=;
 b=jmXwOg929Yn/Y/zuui+wOiM5acdHrPWunocus4F51+Qixra7d7DkCspKqnvG60Dl+P
 wBmz5NJZMyCf0x8p+LRlitOwP7DsxZ+tdF9zga53Jqnd6wL2MkOqUJsXC5kPRn9Mz+CD
 fduF9UiG2gBbJHk4d+b60S5F50hv0VFq/I7TNsm9cNPswLwkmkp5S8N/8OZzrYlp5kYb
 lqJ99LPafN5Z0VnNmW0IC9FZn7dBdR68e4m++66wIqmKMW3q1s/jbBRRkSRhB1tVn/Ux
 KwUNBQANd7eoOh0oEeU/GtlcYj5WXC6e2JBKaBwE2fbhLEGu/VBn4hdgDRvPnKKa6ME+
 9zmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNC/lloAnvBbd1w8tOemrC9N7NH4YkXY8r6r0MyVfxqhTKeuzVW7s5QIqw1n9/LSxezHE5DLV1951j@nongnu.org
X-Gm-Message-State: AOJu0Yz08q74PVuyug2U6bOcNNSWHsHeY3Z9YstAplTahnw0ZK7lP8sk
 8M1n0zVLQrkMAHDN0wXaaBo3qr/o086SrIjQ61fcGH5fUsrNN38U1kofOQgc2DGFjOgVT1bhYKu
 Y
X-Google-Smtp-Source: AGHT+IHsuIU59X/JAMa/QlVFOW1GTxpW9dVHeuNHpB6fKp4JoIYBnKPcZrm2x12FQMxoYOlJRGZqEg==
X-Received: by 2002:a17:902:fc45:b0:206:d8c2:4a79 with SMTP id
 d9443c01a7336-2074c4d32a2mr49526725ad.15.1726025328503; 
 Tue, 10 Sep 2024 20:28:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e324bbsm54998785ad.87.2024.09.10.20.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:28:48 -0700 (PDT)
Message-ID: <1b9c206d-a5bf-4816-8537-54a3c83cb4fd@linaro.org>
Date: Tue, 10 Sep 2024 20:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/39] accel/tcg: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-25-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-25-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index ec89a085b43..2ee4c22befd 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -251,7 +251,6 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

