Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA7BC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0dW-0001Dd-FV; Tue, 13 Aug 2024 19:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0dV-0001Ac-K3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:09:05 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0dT-0003iw-VE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:09:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-710e39961f4so2540378b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590542; x=1724195342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xn6E4oJWn302X9vEnzafwpqvhMsV5tsNRey8WhwxQsI=;
 b=Pw21vCqru1eQvmTA7Kx+FLqsF7xBGtgHXHsR4TjRd0mSYAujNlwfTQnVHvp80V4lLv
 MQqpShd2fizcGEI/5SQzZoQHQCRIB3fDIvsYiDare004tNpUCjsplLKtJIV1exMC2+2c
 uNcCCg3IMfzeQVZIFLC4rF+IO6b9ZhPvOpNRIUtlG8rgltYlzSle+9aKQv0gi/kgT4mT
 WVRH6JBTT4EbTofkIVVcmd5QpZHsCIE900GRHtbKCwh+bMiYZT4YnM5fE9xsl5b5AKSO
 FbnuFJnu8amt+GMNhoIxVE16tM09tURWOkuHkSAgsYkz5vJj6mnGj4PpGztMiU59m1Qh
 Ilfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590542; x=1724195342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xn6E4oJWn302X9vEnzafwpqvhMsV5tsNRey8WhwxQsI=;
 b=mYi/2Lu+ZE9m0jcoB9PRlfNUErQcu/cWFb94SDIqgaycuyXT7R6ppd7ctJUNsg3dTp
 69VPcBUTMMcWE2H1+eRf+fCSyamjywjegsXcX5+nXk6jbwLTe8rq+OAk1W/i3IJrz4uN
 miCq06N1BjxqIKmPF5Hdx+SMy9+cYVDfPNh/XRbahv+o5Ij9/mgUYgXysqCFbD0/twhf
 NmYqfFB+ljwROqkVizNz898GaBRsJ0nW6rPTsQxQY0MDWg2345ISMSUyxOSxnyAZ+U/z
 kyYI1CS37gdC/1m/OvOzDzTDd8NGz6e1uzcUfGYCj7s8EXce0VczQrS1i1ZGO4UqKql8
 UACw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi0m4e21GJ09EJ8lMhGdqJrgAAH8AQ9LvQrx8iWCpDzLExm8tlOyz4kV/J8s9/kI05W0IfNSWfAraO@nongnu.org
X-Gm-Message-State: AOJu0YzOOSp5cuuk0Ykcs8IRKhIiHOS6TKNaoPzWi6QuI/I21AccA/MB
 aIgrdmqVEmyO6H0vAjgNuYsh4rJfW7fhSkaXHBlZ8y+bAgEioAr7GnM9Txs4qxQ=
X-Google-Smtp-Source: AGHT+IFYYeYpr0UFm9rUIc/1UKQD1Qosw2ESLb19w8pTtpHgEPikZ0FJEjdmj4pvBVjTXHbGki5SUA==
X-Received: by 2002:a05:6a20:c6c2:b0:1c6:a83c:d5db with SMTP id
 adf61e73a8af0-1c8eae97feamr897972637.31.1723590541932; 
 Tue, 13 Aug 2024 16:09:01 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1a9403sm18488535ad.151.2024.08.13.16.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:09:01 -0700 (PDT)
Message-ID: <21b3278e-dae1-4411-9144-efe4310a4d8c@linaro.org>
Date: Wed, 14 Aug 2024 09:08:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 05/10] hw/dma/xilinx_axidma: Use semicolon at end
 of statement, not comma
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/14/24 02:52, Peter Maydell wrote:
> In axidma_class_init() we accidentally used a comma at the end of
> a statement rather than a semicolon. This has no ill effects, but
> it's obviously not intended and it means that Coccinelle scripts
> for instance will fail to match on the two statements. Use a
> semicolon instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/dma/xilinx_axidma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

