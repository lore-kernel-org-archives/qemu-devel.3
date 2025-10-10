Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193FECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GaE-0007zZ-Kx; Fri, 10 Oct 2025 13:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GaD-0007zK-1a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:07:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GaA-00049H-9T
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:07:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-781251eec51so2044138b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760116024; x=1760720824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ussaFKaHRumUgIbYQc7yJ8LBq+sW6fyy92bVV+SZG0k=;
 b=egokXy3pIezCpY4z41yIuW4jtZrIOO9J6kiBFnfaykkKiDKY5rWSlHTyJPfX7/p3/1
 fys9JboYaFW8myotO+jOczNhDGeTBfhJSsBQv1Oe/n3w0wZgsTekkOThHivW3KWQP/UO
 HooKTz6xVpVvqwLbMVDBRr6njaa5LAQR4RbXv10IAtAm21DsAzHyFWQPFGDgruw2AJzV
 O9IoiHHLHfeL0pqvDQwIToLxkrYYUGsvmaNyWQyqMJipJDFuEHQRvU+qYUx4Dl7ZylE3
 Bo5Y9JXWaMHnV2jns8nh7axAVeKiowUnze3G+fxo8jfQFXwMtGJ8SFV6daP4AwGpUZhu
 l5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760116024; x=1760720824;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ussaFKaHRumUgIbYQc7yJ8LBq+sW6fyy92bVV+SZG0k=;
 b=ijhqzXx/jJqKHY2QKg30oM937r6vfhTvM9e0psj21iZnx0z6CdQE7CEct0oPFwexRN
 NISGhnG55P+jss7y4fGG8KNVZSwTpgcMtATG+8RC1uioBxSPjPQY2slirLUcrbhmj98M
 oeJFHf7/lmWNFTs2Wwuc7uMZcS340qZFUsXB8J0pSezDAPzuNsAeIU/vZooGa3Db8X0E
 dxD1BIR0Io2ju6ITo2pgamMJmjOJa9X3Qa2JcntrqS589QSO6OoR7fAOcZlY6Ff/kKaX
 gWrb4eaieh0rBfp59i0p3ee4ezmOU1ACQM7akL75M7x22sgG53xZaoboLwBCgrBzJ9an
 K0Fw==
X-Gm-Message-State: AOJu0Yz4+Bi59EvWLLGOzyYqjYHu1EFFoCk5Wzr5ZiysHZWjlMZmUNM5
 0wwFaJFSDElwj5m70mAqXC6rtdAdXQXtbpNpuTkgDw2BcfNLwc28BPo7LbOisKVKPFxaal7qOv4
 JH/bkViY=
X-Gm-Gg: ASbGncvDkOoDAajdPTHEAKHjcoecZbKFgZ4t4GYyYqo7KTsgObp5NrPaQRW7YuytpLU
 BjS0FPYcYQf9Sz7XgTo2xcYO0zD9OHf8pbVVT5cr+I0nAfdSoqrB3NXgz5U1i4QbZHq4TP6vsJR
 SrxEQ2MN3bDABb4rrH1JJK8tOktAQpf8t2lTqdhnL++qnxvT1FNSkEXUAnaxTAKLNNPNze8qj0J
 DRCFWvmN6FP2t38eWxSvUtE72ai2ebDFWET274krC80TkY0kuWQUqVlWE2PgZVOisnT1sNdcbXj
 XL8o1ZjXHLtfGrwlv0OjJgvg8KX/2sPyrG67LtZlCEwJvpj/s8FkUuFDAmki61P46Jyx7DgANhk
 6UEYJNCqBhDTMij/JdR+HuiAr8s1goH/45/u5XxUTuajcJP1/mE/gazEzL+0=
X-Google-Smtp-Source: AGHT+IHtztKsnzS9hfsVhiUQloeVTEkYLcnA0w0t5IqMnJfyDLXVDUyCxYLR1LeUhHB9r3/DwuJJSw==
X-Received: by 2002:a05:6a20:6a26:b0:2e3:a914:aab1 with SMTP id
 adf61e73a8af0-32da83e3df1mr16571850637.41.1760116023878; 
 Fri, 10 Oct 2025 10:07:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df276b0sm2791746a12.23.2025.10.10.10.07.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:07:03 -0700 (PDT)
Message-ID: <6f1254cd-ca47-4ffa-94d1-0facebf4b1ea@linaro.org>
Date: Fri, 10 Oct 2025 10:07:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target/tricore: Pass DisasContext as first argument
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> Unify style, always pass DisasContext as the first argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 68 +++++++++++++++++++-------------------
>   1 file changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

