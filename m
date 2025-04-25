Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00971C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OzF-0005M9-Pj; Fri, 25 Apr 2025 15:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OzE-0005Ln-8v
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:45:24 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OzC-000841-In
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:45:23 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so2404299b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610321; x=1746215121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1M513FYBONtiriWWule+I2j+8/BUimoPIUeOxQusUyM=;
 b=qtpt24SHddmDTsTatfK0/aRNyEEWLfEybd7aII0Xka3IQ5+CJiFBcQ6Y1y0VbPEY+/
 D1zPP5GAlVNb0gD1ZK3+Dj1Z7bP69VCd/SGpcdTCrZiahA/9wtKTiwVVch1AVblHQnhM
 l3VOF9f/jAeFAvbOsaxkc21U6HdhrKXEegCGt79a/cs9v2cJjVXr+W1Y++7GFHWVS3gS
 BBFCJQAzLgK8FmOBiqBgCefYss1tVavqFU2o8feGloqKYiCiFGctYDzdJkUQRA/S9L5o
 8bbHYETJ4Agg4ejrky7xjWlGrhU/kZhlo+m8RiW33Hry1uNTS3EKkpq/L52iidYSqvOp
 cDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610321; x=1746215121;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1M513FYBONtiriWWule+I2j+8/BUimoPIUeOxQusUyM=;
 b=Q3+Li+n9BKea0KOieKwOaZhzsdfUONqgZbFVmy7I/kfI/Zb0NGpB/2rNeLtv6HgaRD
 i8gyVVIsXKpRO2g5C0UDwy4S8cKf1XrwYpee8snM6ez217Auk3v+D9GHnNmyJPaCjwJa
 bkJ8M6zG0Nc44zK9e10KhcqBlBdgDFzBg9EFDDq4KQJc8ZsgdKtL8BHKj0WOhGO9xVmv
 a+mHcWIvmaTwK98hnRfzEwh+H6r2fRWHUAnMdiuUALeliGkdgS4RLb0Ajn3tYVvyYKfj
 PXuiEnllHJnCymgu1nEPKlZBBlIFNmFmY0lNqUnjHoj7AIwt9B9lqQdTxfzrcz0lWWN/
 cdxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKA0aZ/gqc0SUABzAJF9zPaGE2bxeYhRdWG6rThZyjlPk4Npjh2aLGNoXlZB9YCVU2cRqW0GxyJBrI@nongnu.org
X-Gm-Message-State: AOJu0Yw24xNcNfzsjeCu10uOb9dDTxAbicR34z4w8FNLnlm3cHJxeIyW
 O35wHX+xKzmmbMaHJ6/akOqHAYa/dTv1SzSwI7YjCR3N1QikjJ6TrtWyInL9w8sRFM1N/8t1W7Q
 aqkczuw==
X-Gm-Gg: ASbGncsbkxBDwqmw/0Uh1BN6EKylAzbmqKJ46n4RS5QInCO71urqwswnF4sTWNH6alc
 4uPaVvfJtsMqZ7dkjrBdu7VLMtDrtUoJnY1vJv/q8PPe1RuZ4AHSbD/+srfjBi53yX3afVSvKRq
 smYnVonEEM5SOp25i/iM6O9HCG3Cj4VJFxKc8xXuTx7Cq45IAqVUvMepp5/39SLUMX4AiyD8KC+
 XbZzNv44KmtHhw+fxv8rpXOhGy4lad+qPIuUgy3dYrwqQywecxlhdo5ufzZN48GdozBpC9nj9lL
 yRJ4rKWxxwklZLT4idpjTudg1vECNyc4fnNftXJlHKxDHLxMm/gq+Q==
X-Google-Smtp-Source: AGHT+IHVn6bSaEb/vX6ZcjHu/TqfKtURTlPC0mLoNIuPjVdp28CP44ch2B8tC9WcgskQbGStYNx0Aw==
X-Received: by 2002:a05:6a00:3d46:b0:736:a7ec:a366 with SMTP id
 d2e1a72fcca58-73fd70d880amr3998122b3a.9.1745610321030; 
 Fri, 25 Apr 2025 12:45:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a923sm3550590b3a.123.2025.04.25.12.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:45:20 -0700 (PDT)
Message-ID: <b2c6e0c1-bb93-42a1-aeba-287ab3fc305e@linaro.org>
Date: Fri, 25 Apr 2025 12:45:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] accel/tcg: Use vaddr in user/page-protection.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h | 18 ++++++------
>   accel/tcg/user-exec.c          | 51 ++++++++++++++++------------------
>   2 files changed, 32 insertions(+), 37 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


