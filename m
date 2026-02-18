Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F1E9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 00:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsVAC-00010o-Aw; Tue, 17 Feb 2026 19:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsVA9-0000x8-KS
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 19:11:29 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsVA8-0001C1-8D
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 19:11:29 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso1181310b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 16:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771373486; x=1771978286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a5T6jjLg6MGMZhMrnWRyRJIEZ6BK5B/3sq5mjCz7iGs=;
 b=ihBaDehjb5WE+o3cUpciyl3vHHBiOCKlHJ2nTcKiybHR7OAI4NLjP3m8OdFEqvlCje
 eQW7bSv0mq11pcqz7WUKa2rqebuy1nUI2fAy1EMB6v4rI8DjYANo+N5TXN1HYmAifLKw
 VY03/FCQOb0+Pbj/vG5HejiCpChgPnGWjR9d7K7S1G3LumjSWvoHJoynTqhT+Di+zf5+
 yZGNIwqFtblJrioQRBRu+lQgxVfqQK9TI3yGZKAtCWBVpylbk0YuxJ6DuPni75Gh4YC9
 0jdYRBkjEbkpHaOgP2BZ+fL8Wjpefe48HL2QCEdX7mI+QOkYSqjNHeeQv+EtYADi/MVZ
 8YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771373486; x=1771978286;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a5T6jjLg6MGMZhMrnWRyRJIEZ6BK5B/3sq5mjCz7iGs=;
 b=VefD6zxh1Ar3AqdQGMkmrklsN+93hlNtrx2PnWbYso1NhY45FusFGUC++HB30qyyTB
 ptYnLwenQ+FsC8EQe6FPQk2P6Z+MPfm4U6ni6hpFX6WH6MOhvbazifSRNcXJcPMNOrie
 it+B0TySvDpKP2zheuGetLQOMua7Ax19upd4IG/Nd4rLqM4gimk7QIFSKIqgQtOvtw5l
 nGMJfYpmh1Lr20yayx+mmSe3AQJIDaAwNAmJq7sENPaojNP8MBc5D7aeDlSk+h1Go5GA
 VNP7Oz9++TMBPGQ04aGQf9ZnHOgJBkTsg/nTlGT4gEelc0lPwRLrmCiaWsPHLDWhTtcB
 9djg==
X-Gm-Message-State: AOJu0YygQWHDGW/RY1Ep4XRTTcSIAyHGcUlfoavo1t9HsSXyO60vySV8
 xoFiZYznjOu/GZndVB0cf2wIk3pb81imAjwhFu/ahzm8GA9T0zn6DtvR5eT8VY/r9cE3TnVC5DF
 FMCPmK7E=
X-Gm-Gg: AZuq6aJEOE4rypaR4arjFyiwnERBAMi+UAcNi2PpiSja+qQVPjRu5F7tqdKaAEwx9XC
 NPaZfJybJ0dou4euiuBoKLlWfcgooeJS/Jtf5u9IcTH4zbSdvM0K8fJjmBW2E0pioHDYt/fFYkA
 EhcbnVpBItla/1P9J0SBjnXospofcsg6nhmsx94HjOvpsumbHkQ5NcxbU5ydYg+COf0jodmhWfR
 RXqDxY+zgEesjPHXIGsuf4/IaTvaBVmFIn8resPTl5f03uP6Vcq1Z5hFUlNy7lwToq5AeTQRua5
 BmCjhsSa9Yqkxj0/kS2RlUeeAekrBG0zHgMJ+OY2jrD6gUFWu347ikDW8v1ujt3dWOAmR3XLPKQ
 gU8E0uFUtChl5+09flNP8Ef6zuzN+wNTRhuu4NUqeeXXJs/SZMXu/M1vLbfbIiNqZq6ElG0NNsD
 zsJVUS4YJR5WvT6cs3cq85xiRIL6kQWy0ipDjWg4aAwHdswZL8Zv6Elmw04Mj3zoMmqk/vzzMiq
 /I5Nq9NZi/8MGKfOSl7GydDhphNfSaEQHCtoBBCzGoYJ5+d43t6qM5KSECj+f4WMx8B
X-Received: by 2002:a05:6a00:369a:b0:824:a4c4:3b3a with SMTP id
 d2e1a72fcca58-82527488f85mr319280b3a.7.1771373486442; 
 Tue, 17 Feb 2026 16:11:26 -0800 (PST)
Received: from ?IPV6:2403:580b:742d:0:9dae:4750:549a:793d?
 (2403-580b-742d-0-9dae-4750-549a-793d.ip6.aussiebb.net.
 [2403:580b:742d:0:9dae:4750:549a:793d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6bb34b0sm14142533b3a.60.2026.02.17.16.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 16:11:25 -0800 (PST)
Message-ID: <563f2365-196d-4f25-9292-09707d914983@linaro.org>
Date: Wed, 18 Feb 2026 10:11:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/display/macfb: Constify macfb_sense_table[]
 array
To: qemu-devel@nongnu.org
References: <20260216213121.47122-1-philmd@linaro.org>
 <20260216213121.47122-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216213121.47122-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/17/26 07:31, Philippe Mathieu-Daudé wrote:
> macfb_sense_table[] is only read, never updated, so can be const.
> 
> Update the single call site, macfb_sense_read().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Reviewed-by: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> ---
>   hw/display/macfb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

