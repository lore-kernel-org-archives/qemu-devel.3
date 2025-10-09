Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA06CCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6siz-00021N-7i; Thu, 09 Oct 2025 11:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6siw-000218-Rl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:38:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6siu-0004Bn-4P
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:38:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so15627245ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760024306; x=1760629106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NixckH1D+RutLfGCv7CVHhrdUyUA0GTWfkdmBr9d90o=;
 b=DZuxFLRZvjKjQ83jNYzb+bMpxKSTadO0ZHYBPbCbeXPvWqUXYiQMAY3+bOON0ms/jP
 67BzSmYVZRzA6Ft71xpcsqWccw9Fz+jnZdhxW4RBQYpuwoFy5Sv6aFYDnTIL2+2zslGO
 Ube8epjU0SwgzmgsIyZdw2cImn/9GM8WNFHrWZFDXqX755K/vsSccJyMela1KoPRMmPI
 Bgo6/G/KDc4TjdAcgxJHDKVuBHw8neUGftdd+tVNc13XjaRSxK5BKkIR1MlH7NSkenye
 TfBQh38REP5rm7mHeZ5mjBmiyuARlRdVFO/g5SInwbA1zDtJu6f0paqJrmnEOSbfOOCp
 8XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760024306; x=1760629106;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NixckH1D+RutLfGCv7CVHhrdUyUA0GTWfkdmBr9d90o=;
 b=a74mFJ9DljsoWC7MK3bNtf60G6CfDfGuJrTlxN1VJB18t3RLJgcc1jm4UZ/EiUAXS6
 Mjkd7V9dU0mR0KabFAvQESSi6PNqYWihbvp+um5bV5CyatgRZO9r42Tpcbv+EsNS9xgm
 ea3fuPQzxzsaPtC3Rt2v62jrELAste+XUoV2zrArEBVcg7t/Aat0Gyuv8cBzqp8YzK1m
 qcKr1lbHvbPqPviL8kWPL45hNVUmROQ2gVDQiLk/vMo/pU0OTc3U9eLI6V+dxcN7aJjD
 TrJoMhZtU+zIcmOTxUpZgafKaatCttDiIwFlfDyZYqLpWGPxMsb9iq/MSisIFmM/77j4
 SeQw==
X-Gm-Message-State: AOJu0YxrU62B1cqzP5h3W4uZuz9ACQPZqcE4oWf1SLpF7WUDHXjIlIOj
 ocmtDUUUh40yojtFpUhNMGMvqWUYvt45ONyJJjXw/Trh9qPe8ySLVNjgc/WGrBSXv3ilCRua+lR
 6iHrVbU8=
X-Gm-Gg: ASbGncuU6YWFbZv6dpExDHCBllBEg6fUhu4XnyIzsvogR7eb6b/uRkuq53oS2GyieDB
 gjGF9hNmC2cEPH/YZLJjAVL+Da7X1SWHBt33Q5frW0FEu3T/pxvdsM0kEP3eOQw0GQtqUG5+Owg
 8uBxS1l14UirO9otccWw/7o+J6lqrQcLYucG7vuWawgFMJfPpl81SADWB9lngq2UmGaegsWmlyk
 PpJXjfF4hlW3ab9uvgckVdc3d1x+OstGFb6MOcB8pmEntA43Z5JrekON0jamcrJrhPZlYIbFIkC
 6njBpWsaR4UVk+T0Dt8toU5UNEPsESMGPh+9uxvM2NAd/Z1sJiUWHUY6oGTqhi2LH0ytn1l3aPF
 GxOR9MhlRrE1WS3iOh6VUzA4Je2QDAzHDmid4J28n0wyQFS5iqGSD6IzpEOumNXEV
X-Google-Smtp-Source: AGHT+IEYR2luF7ETqe39rf2npuP3yPtmWUaPA1JTt7tF3Ch953ZazYGXShzZ3vaCVtKHTL3H3K0C9A==
X-Received: by 2002:a17:902:e943:b0:248:79d4:93be with SMTP id
 d9443c01a7336-290272c1648mr103625985ad.30.1760024305663; 
 Thu, 09 Oct 2025 08:38:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de53f9sm32567995ad.14.2025.10.09.08.38.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 08:38:25 -0700 (PDT)
Message-ID: <ef9a9f73-6f84-442d-8eec-a2050bc9acf6@linaro.org>
Date: Thu, 9 Oct 2025 08:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
To: qemu-devel@nongnu.org
References: <20251009141026.4042021-1-rjones@redhat.com>
 <20251009141026.4042021-2-rjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009141026.4042021-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 10/9/25 07:08, Richard W.M. Jones wrote:
> curl_easy_setopt takes a variable argument that depends on what
> CURLOPT you are setting.  Some require a long constant.  Passing a
> plain int constant is potentially wrong on some platforms.
> 
> With warnings enabled, multiple warnings like this were printed:
> 
> ../block/curl.c: In function ‘curl_init_state’:
> ../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
>    474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
>        |             ^
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   block/curl.c               | 10 +++++-----
>   contrib/elf2dmp/download.c |  4 ++--
>   2 files changed, 7 insertions(+), 7 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

