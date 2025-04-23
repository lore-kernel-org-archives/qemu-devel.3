Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298C0C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7dZk-00034L-FB; Wed, 23 Apr 2025 13:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7dZi-000347-QZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:07:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7dZh-0007ji-5Z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 13:07:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so542165e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745428070; x=1746032870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVkn9u0Te7lFaTCglt6awhTnPI0DbxyfBHDkmx37SfI=;
 b=M5XKX6lK1xoOZGA5QxmyKnkdlJBRdKn+wPx0iQPfchwq+mYMxkDer1fgqIpb3567dG
 WmgqTXq/ZtdnBs+eIn8B6ZD72gfmIZ01JFjbrssIt2Gd40zABPcboESajn4ux2NRJJ5/
 iCqOUjMxh1KUEFkvPrEPRxo5/sOevbp83dF7sBfb58XCApQ6VZ8k7aG7dlZ+mfTXcM42
 q+X4RXYPU0jebBVYsUFhSclarxhyfS+CowsE3CZpUabJsWF9DSJPwfbwFKU3Oke8yHI0
 b9rVubfL5picDKEp8hRx8hOZMrMIn6GN9WoWGKUzDkYxmazeZSKDSAgEvNrvZsxh5Lvu
 +rAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745428070; x=1746032870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVkn9u0Te7lFaTCglt6awhTnPI0DbxyfBHDkmx37SfI=;
 b=tfZdQSzhxqs75pq5AIJRsPyAZdlrK4/8JIrFgnWsOZ7zGtT3RAQenwL1wxAD/ARTkr
 QxNwh9MUDyjY4CZibtQbbVc3dD71eN+UaZaCvi9TFvDBRwl9bdnVKTK7fAGoeHsgpgfZ
 ryBUOhSzm58d6anPDzNN09q7+JxzMQGamIDlTqD769IMArQOWt5nwopO8mhC6aSFht+U
 02Trp/HWGbjH5LmJZults+ZNgrTs+j8CRU6mmoTuywT9277runr3X4s+zXxmF60LfSsy
 /h58/ae9Ns8GsYhI/392HQnoDqZ5bF3vVkvw7BUXPhBn1rZNstKrEN7IZkZhmeWfqjcS
 +3Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV/TQw5KyJvcZJ0mqNI9Znx3aL18zD0ronjOQsx6K+lMW1aKnwBn972vOWxr0MY8ugEMurKBXGHAzS@nongnu.org
X-Gm-Message-State: AOJu0YwJEIwyR7wH4v1EPHrfPqpKZ7yYtyDdMdO45n4c/8FEYOVzNIl8
 qjiy0LMzYwPvTAQMav8K4X4kOvcezTlVIDwqxw+FhpBhOjn4phmkxgX08V/sibc=
X-Gm-Gg: ASbGnctrd7JvGiW3UBt9uXNXVwpL3HT4XMXQRN4zAAoNrBLJLd7Gbyt8Hti5pg5VKOS
 UJXDYdtr9K4jwvvGS6k4OQyU6IIA1k0KTVCf4Iom8SYcAo9UEEq3szBASZdkUhfrmx7cMdFFOKp
 NKNaLVDm1PcFs6C1kCuX+Q9BS3BRU77tfRqtngOemyU1fJRAmHMn5qqABrNfKD1OUS1jB/n1ov7
 W037M02w3KW7g4/FAHQ7TWSt2kNs+7an0p6RvHF8pkMTJ2/XmGz2hXGL4NGswRedJa6hKTs94He
 u6iNZhMVDeZRvdsF7SZJrUBM/qvkzXPpNDffwAswmqHiRkFoc+dy9/sfk6+JoCKGmQ4QNc5kzqd
 Rz4ZUmvMk
X-Google-Smtp-Source: AGHT+IGhslMe7Qm+QQ1xwXLrt+p+SOkmAN0ZsJsmLoPk1PI4mY+lLgwSGzfL7dQvbQWdQOoBRjHXSA==
X-Received: by 2002:a05:600c:4e4a:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-4406abfab66mr172451655e9.20.1745428070147; 
 Wed, 23 Apr 2025 10:07:50 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d22263sm32016015e9.15.2025.04.23.10.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 10:07:49 -0700 (PDT)
Message-ID: <e0a6f58e-caab-4317-80e7-4113319453c3@linaro.org>
Date: Wed, 23 Apr 2025 19:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 06/19] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-7-philmd@linaro.org>
 <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a4a65446-07b7-4048-993a-6d0d7848b163@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/4/25 19:40, Richard Henderson wrote:
> On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:


> extern InterfaceInfo arm_aarch64_machine_interfaces[];
> extern InterfaceInfo aarch64_machine_interfaces[];


> As a cleanup, we really should make all of these const.

I'll see if I can rebase on top of
https://lore.kernel.org/qemu-devel/20250212213249.45574-12-philmd@linaro.org/


