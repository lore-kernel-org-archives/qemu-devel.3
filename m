Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BA1E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVs4A-00041g-8j; Thu, 09 Jan 2025 07:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVs3r-0003sG-5F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:54:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVs3p-0008M5-Ln
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:54:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso10920995e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736427291; x=1737032091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+BW7nrZ9Vn3bOI2kbpZ0Vi1Dm8eaHXOSrZKNNXHBz4=;
 b=HkZbdY6ipMeT1lF6tdXc5S1XsS4MtjYgQZeVVaWF7Ek6+WwVJ9MXB8tGuViQbHHy6H
 43dZqTWMi+p4Z654atJvSQ1726d+N1L4QJqyS7TJ3Kty3RxZ4fY+LTVBfNBo5sug8c2i
 RlPur4PX9qDCdFle0XHzkO/Ona0QnMPOIHkexzkNEb/Gs/zFkAVKlzbIYk7vw8JxGLTG
 Ujs9gKFBcyXJWKCl3oC5CwGkhpfiYeyHay6qBhnIzxC4ejfRr7oSptoYY6jOmo0v9pSk
 1rKlMvwduMQictEF2D8FF3JBuiDpaD7Mz4Ydq0RQ3JgDjxno6zZ8sQrEzaslGThpnhfZ
 eklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736427291; x=1737032091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+BW7nrZ9Vn3bOI2kbpZ0Vi1Dm8eaHXOSrZKNNXHBz4=;
 b=LG/u6FuHrkc2BhaC4DMCH4fAbm9eOXKX/jJg+NrsRYG9jNxgbafc0ms6Rm849tCiCn
 04ltierYmCA8iWVKgQqg4FtMyml1Zde3Dq/25Bdv8Er5XY3XvTiKZD1rQoD9/o6gWx0C
 +bx9CWpsypyK1PDoMhqApUc5C7mY5d4JnYIlO9qgDfqMgHHyOIN7lZMq30qYOjMYoN5I
 fC2/UuY/5J/Sk+zslAC7B5wfPO7Sj611fJn/C+gfP+0D/XZ0S8CeNDnsjS/lzCyTynbm
 IcP/itIypjoRq+uytOBZYtxHr/4k2GEmAGlwtmLlnWPr0Oa0TBtYaUNuMtR7kHwmuLTQ
 Haeg==
X-Gm-Message-State: AOJu0YwRqQQN/kDj3pmNVquUt43Mefz4uotT9X151Edny7Mqula9C08n
 DfwhdTq4P+BB7KhJx0OW2gDkJmcz4CJQb7dkms/t0DJi8mfYpuVxw5nb8scnre7eHsJ7LXKF8LL
 TE2Q=
X-Gm-Gg: ASbGncs2Cne5rl+RuVCiX/1TDU62/QE0YUgSHjKB3tqCn8K1IqYnIgpBPDeLo2qax+v
 J00p7t19OnUY4OOvzwdr1Kv2+khCvgPbREJu+4dv18FMmc9fFjZqpVRDzXMKYmcEDhWXJ3Ser/6
 tqo4Y7UpkomCqWgDgqKHy/JBhM4pr9RSdG64KjABO5z8k24BJNgpchXVOHMtHH/gHPNg/n+H6ko
 4EbZ/N6M0jZIaGkiBLXNWmN6ym66KCr0lgiqdXT9mE1PeNHXk3PmQtAtK1FIgPlZW1RFuH+k90j
 6e5R7iOGMT32hJJHmeUwjO+3
X-Google-Smtp-Source: AGHT+IFd5+Iu+d9EtQOQoEVSmoIV5t+2AmjCLvebwO8MhvvJm+ZlOVkpV5hzVxnfZuAdfiwEoG4dSA==
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-436e271bcb3mr68245225e9.30.1736427291470; 
 Thu, 09 Jan 2025 04:54:51 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1e0bsm1729304f8f.100.2025.01.09.04.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:54:51 -0800 (PST)
Message-ID: <2568d2ea-8437-43ef-9d34-1fc1f2ae6242@linaro.org>
Date: Thu, 9 Jan 2025 13:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] hw/ppc: Remove tswap() calls
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241220213103.6314-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241220213103.6314-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Nick,

Ping? (series fully reviewed)

On 20/12/24 22:30, Philippe Mathieu-Daudé wrote:
> Since v3:
> - Addressed Nick & Harsh  review comments
> 
> Remove the tswap() calls on ePAPR, and convert
> them to big-endian LD/ST API on sPAPR.

