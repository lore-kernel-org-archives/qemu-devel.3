Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FACA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG02-0003nK-6p; Tue, 20 Jan 2026 12:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viFzn-0003ge-Gx
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:58:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viFzl-0008Md-55
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:58:26 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso9627375e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768931903; x=1769536703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0SCNEPWHkjdNbaEH9vvndfiaX40ODnQzXtwJJjk6PFU=;
 b=T+RLQ4KxoXsWwKJrp0jHa7ccfcyRYDOjy94Rvq444T/E+jbu917OfFaWQwyRyY3eYW
 kNP4/aApMuWL0+G8C2QFRD21eFz3A2eXZIk57RAzV2Pbg9+yT65+nEfHd1ECVHl4R1lL
 ZLPpcoUnH+ShL0Kaap+NmuJ9kwp4haB3BarUUSjP0Bwsc5X2LRgJ5HgOCXygXml8AsUD
 uGEF81FvmepL95m68+WP4/yQ0xNjSCEjJo3GiatwK43GwKBlnwh2OMxeRiY7RuIBqu77
 P+JdLCvDlVBEI6Gz++UuOwhT4SK3jmTAGFsJKYnsa/vefz1UUYQrxerki85JRQe08PZk
 z0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768931903; x=1769536703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SCNEPWHkjdNbaEH9vvndfiaX40ODnQzXtwJJjk6PFU=;
 b=QuS4OXepG8Rs6CLvTLJSrgwCSUVUbrA8UHruiW31uwRcHmmvPuTltjnCImBINoStCW
 WdBVRok8USn0K71nlwmjysypJ/JTOXTcNq7sO+NvEt29P524vS2R+X+MTPrXrLf0L6Nu
 4lqwvuxwxnEwEdgjxnDkUrlbZGGiNpSE335xpF7gHLigj8CHP6zH9YIA5irL3aTTCpkR
 373zcL4TJpq6LDV32L/Y1ju7AjRROu56G/NiqB/Xgsx4qqe/DXOLvztUtbq5Y3zMFI39
 iIkqS7cKcXaVbKjz2VhMJH9p8BnO89c3mrrwbb4L6KXi8f3u/XPetxKaIvOBI7L45TaD
 QQjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUARmHhqtdmxmfVrEKCiteMPNpK+lriR5pZAPUwCNNoJsABrebU25p7LKmxyuVG084ISRM8xr4uXTOe@nongnu.org
X-Gm-Message-State: AOJu0Yyu3875JWw13vFMYo/CaTEZoSaVgetJjHZcWxr+a1NEGXyRPGFR
 kIiEJMQdq0hA75OLb/6X2dDr05n4w64tQ4KB1u4GxTRhjKav3Sg1fNBO7NzCK8Y2qJA=
X-Gm-Gg: AY/fxX5BadMvxmXa/AHiPXWiOab7mU/gwaYEmG16aQLHZd9iGx/aZ19wTBmXvPh43hm
 DXg/a+bR0AzRbgKmSnZKaqof+cDqxJFyA2H58sUr8mSw9cN/vcEpCIa3WrLj802XARwyWyCJsZW
 pkUJO+Af51TtCZsiPHpkivJ3xF2/3Ep5TlYTw+ngmKRWPEyCHbS2s/Rl/6xcIToXhczpNtnEehL
 fuYN+A8qnsNKrHv2e9Zpmf7oFl6Aamw34Oa+SPn9AGusdxGYmIu5hbcu8WKh7jWFGl8mYZDsJ7G
 eqnp4FhMbxvJShPkq+AUZKRgd34se+IW1sliIf7Entl+El8vqEuMakUkpKNR3g90qRPzhRmlHUE
 XOsf5qJKLIIts7NzQddi3tLXmQukbe2yDVPoFeIEdqPGvrScENNkgCNHmwD+zmgz/LOpAPIRMeL
 wJjZP4WqDIn0FEsUpVc+w3I7pbDTFK4bya3EH8lBDy9Cdl95HC6Dx1oQ==
X-Received: by 2002:a05:600c:83c8:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-4803e7e8555mr38846915e9.19.1768931903181; 
 Tue, 20 Jan 2026 09:58:23 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b83csm314253485e9.3.2026.01.20.09.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 09:58:22 -0800 (PST)
Message-ID: <ea9c3818-e0d5-4bc1-abb0-4443b0219778@linaro.org>
Date: Tue, 20 Jan 2026 18:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-nsm: include qemu/osdep.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com, Peter Maydell <peter.maydell@linaro.org>
References: <20260119120402.284985-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119120402.284985-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 19/1/26 13:04, Paolo Bonzini wrote:
> The file hw/virtio/cbor-helpers.c does not include our standard qemu/osdep.h
> header, add it.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/virtio/cbor-helpers.c | 1 +
>   1 file changed, 1 insertion(+)

Queued, thanks.


