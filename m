Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48471EEE241
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooQk-0002kN-Ji; Thu, 12 Sep 2024 14:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooQi-0002dH-P4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:20:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooQh-0000id-Df
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:20:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso995405b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726165230; x=1726770030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yfv4xJtsSYuWqrEKGqm2DEGqxnHJkXDKWXf0EitTx8s=;
 b=AJldAhUlwyh3fcP+0imzx7NZGdr1DjH1IEwmZoNngzNy3KpjQWsNhOJKpTxmapXNE3
 SIkwu/0K9MACl6XozToG3EYyV9/LNb07/PwnPQGWY/xOWj4pfR4Gl7Vc2QRLP8kAOOyO
 qKDsIeYawqizJ6t+iuWeQfsgXJOmeeIy/tUxfxRWg5hDGLWP78LDgt+fOyd9mJxW/ZNw
 zRtyqjhFUX/MNwU3uBVRW1zydpB1DoX+k+s566dOLx9X+CJ6GsDJJnpkI2s19AtvhLMR
 AiRcAePqzsyEiYNZd/l+E4gWrPKDssWp9AdSQ73JlhABucEx5RIhh0sXtmGib1Yz6EJU
 CTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726165230; x=1726770030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yfv4xJtsSYuWqrEKGqm2DEGqxnHJkXDKWXf0EitTx8s=;
 b=qwveaWj2JM7CObVGXoQWSzcshsaKJzlQlo7XwhhL9pnPhBq++xk8YPW8uRqFdHE1sD
 JMFK2dm/3i0SxQAkOgyDO7Cu67TlBXP4OYeScF8oXgndrY8p2MeMjrFE09GEcHwrR4RW
 w1QdVoUCioDOJJ6TzRK+j/5NPFhix7M5NFPPnJXLevQgIanqrxitQNCkcbelK/iCH9cH
 gG/xAMrLArOqS87GeUOY8gW8JTAV8vZCXJXmIeahN9ZBzfZ1u1VeW8sh2of29mXo2z8s
 gRARd1sitG7eyOGN2OJlWspNwqpeaYR+dViyMJ/YB/+otff4iDE4ZmL9PVLhkT3vjcEj
 v7mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlfrrSpzo+DkUVWTGjcG/Xos6Hf17CstVNHCDhw/+RVHQAs+mhaqrKbqJ+CKsX48jmNntV7NHoKqvG@nongnu.org
X-Gm-Message-State: AOJu0Ywz3sKJSQU+5g2hjcONz8H+6047dNcVQqZdLW/J44KQi11eDC8e
 UoE0+/XUfCDlVUuYwHaHwuQGYFTz9w1nCkkdAZuuibyfFlGSwyHEO5sEyJRZCywDhB0TdnPK4JK
 R
X-Google-Smtp-Source: AGHT+IEC4j2wsFEgoDYcVcFARsPgadOdDwFK/nj3pjY1+FEdKZpMemU0wlcWjiDF5QHDXs7Kd19BBA==
X-Received: by 2002:aa7:88c8:0:b0:70d:3938:f1a5 with SMTP id
 d2e1a72fcca58-719261e1596mr5273415b3a.22.1726165230012; 
 Thu, 12 Sep 2024 11:20:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090c7306sm4877567b3a.189.2024.09.12.11.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:20:29 -0700 (PDT)
Message-ID: <0f26a231-becc-44f5-b287-da0dc9c8c3ed@linaro.org>
Date: Thu, 12 Sep 2024 11:20:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/48] qobject: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
 <20240912161150.483515-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912161150.483515-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 9/12/24 09:11, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   qobject/qnum.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

