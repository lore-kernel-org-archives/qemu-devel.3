Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC79BEE01FF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDrS-00031c-6g; Tue, 10 Sep 2024 23:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDrR-000319-5H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:17:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDrP-00008w-Kn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:17:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7179802b8fcso4513139b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024657; x=1726629457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hLEKkAG0eXv+nl6wk0HZn/F1cSRHexZwN9mAznn0Xuk=;
 b=e9YG8mZt5sNIfaVIUXxNVy/7keGjEoCnJXNAWabMq3pn5rFXg+y9563hCq51p/qWIZ
 ep1Vcky9TnwEculC/1MMg+blMsDAwv1hoqVa2Ej8Dka/xZGD4PaMYLLvbr13QGFjlzUm
 4h7gLKaF4RNqA6X7i5pDXiNZlsZMx732ntIZWsT5grsEMtD1azguj7Q56T9adP4/IblC
 y7IvrUqe/i52mK1KQebrp8Xw7lD+nguXiVWm5of9WhKLhAZVMDL2petTJLWbj9QoTjL/
 89gInwx59/Vqh3+1mwjPpKIZ9YFWj3FG/olAF6VjdOGcUaQgv8v3qQFiw4I/FrQ6JEfD
 29hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024657; x=1726629457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLEKkAG0eXv+nl6wk0HZn/F1cSRHexZwN9mAznn0Xuk=;
 b=WqauqLmFKf54J8Ozf8vtO2Gh02D6Q/uh4bJKS88N/YCp8oMVh7sR1FKcdK3JsJdXgr
 rqQGvFmVzagtwK1tTcSbG/Zy3r08x0m86bxeBdHe6zglSQaYHPXCzKUbrEh30pB3Nmzv
 A/6q+NE78n0y8YNo78oFUuWQSwZ+eetk14nSaM6o8Z8xK86xO9zhiS3o176BpWmbmtwK
 YJS1+j0kAVyWyTrk4II7A4xu+mfha5ipjT2D7nZkhbAX1vE/G7L57EZh1tHHC2ZK5/a2
 449gZsrs1kx7oJ/W3BqXr55ziKMRf4P9qDOZIU5lX5i9Gq7fuJOPDqszgLlU9sPJcY6Q
 BA9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxMOGjB8d/VdDbTSpVYRpWlx/IZV2aiBMmqM8jksukoaarZ27WqRZQd1Q8XGtdkxDqJkk0b6UmbUNr@nongnu.org
X-Gm-Message-State: AOJu0Yz6r35tcSpDjzp7KfIXnysHvqypQCKprEYZZYhWL19yGKTg/3eH
 k/LA18RfDFEXx2tkGYICNBrsGkBX+ldM47KfydMaN/IJntbQI4rkUm1KZqoojUG2XJrx83CRv30
 y
X-Google-Smtp-Source: AGHT+IG1uardjTiYT3S8l9cTh0K+qKwOCks+0yArVdPB/wtSagBqILxm8imH7R88+zeCGft3JoeqOw==
X-Received: by 2002:a05:6a00:a03:b0:70d:7547:90f7 with SMTP id
 d2e1a72fcca58-718d5e57163mr20857552b3a.12.1726024657546; 
 Tue, 10 Sep 2024 20:17:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc9c7csm2041460b3a.43.2024.09.10.20.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:17:37 -0700 (PDT)
Message-ID: <14d83227-6796-421a-a29d-e3f1ff527f83@linaro.org>
Date: Tue, 10 Sep 2024 20:17:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/39] tests/qtest: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
>   tests/qtest/ipmi-bt-test.c  | 2 +-
>   tests/qtest/ipmi-kcs-test.c | 4 ++--
>   tests/qtest/rtl8139-test.c  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


