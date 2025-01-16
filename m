Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94400C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLSn-0005kd-Tj; Thu, 16 Jan 2025 03:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYLSk-0005kQ-PV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:42:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYLSj-0006gP-7n
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:42:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so5401205e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 00:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737016967; x=1737621767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oeVnZZxDZCC6UIiWdDDXFU4rImc3pg6DoahRCAJfVvA=;
 b=CT15vnmB+93C9/Fe13TJ4TqoCJ0/g88MEW1YnPhpYLB446J21NcD+SwSqFvUOZ1I9M
 8pI7fXeFB+KsYurnEigeYNWH/VfvDSS09iwE8a77lKjU+YOuetB8tZgBwYd5OlY3McND
 mmi8LgFVSyW3bEGy6IBC8Atpn8Pjk85vJFUCjzGaQGVMAjTZQRLoxx5oXVQB/8+N4zhM
 4ohXgI3hAS66nXvcBmWwZqBpheuTaKtJsGplKBPnmcFuYBk1MuZbJeq0XXgKnmQHiEDT
 pkE8BCsMrOdZINqfZDI/ThDrumEljSEyFicQtBWAIWt05J5GcUPALJcv2rehGRuRDrup
 tleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737016967; x=1737621767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeVnZZxDZCC6UIiWdDDXFU4rImc3pg6DoahRCAJfVvA=;
 b=LRf9WgNRIwiVXvf5T1zeCagExURD8KF5w3vGm2/3RRx27tE91TTd65KQnK9rah0L8l
 KJ7R1DKXwWP9NjaSZc2nCp2uyELQ1TjOhisFT3FK2HoQUdK2GsktfiC+9WjmQnRviS3V
 zc3WgAk6voohtjLpCld1UlsMhuaD7JA9oVLDHZu5ytZucVNVpMvgOZDdTepDNc1RdG7H
 J+IweXzJx1se8aovutTXcotQPx9R8yQ0DvZQVv8LiGl8C88q4fNNlro9d+BqS/RVWA+T
 3c/QrXxKQiMeuR/ped1RowV42XL1btbnZhMnbJcRiQhVrzCwaG2P7A54cSdsowKJnG2j
 RbLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmDLwDXdjdMdjn9fuDxOWqjCNiiOu+9DbnyrE5gp+Xb1sv4o5WwCBvLo3kNC+iaaeissvZMqu7JfrH@nongnu.org
X-Gm-Message-State: AOJu0Yx/3WuJeg7SLztCmRfGlY3SPTU2eyntqP/9gIyw/iupIKXZ+/ms
 5U9PfkrjVhxljFq/rCByWQLHqGwhTRLlgj24SlGhjh/pOBMuqnyrswp07CH2toU=
X-Gm-Gg: ASbGncsIP3Rh81CLu+jdcz0UZrRDksSXIuhqdMKTq3zhIu0qWb1D79TGyblNfk30Kkf
 e0uTJrKhlmkcG8xCFHwtI3a1mOlzAr+SsHyatq/mFi+BGRPY4yY2RrJIaNm+1D0U3YLQcfoGH1A
 EECcx8QVC8zN9ykTA8ZD3E6AXv8hljHb/7T99rTjipsDPtNbH+H8m1H9W7E53D+l/f/OsZHaVhS
 6sBrTPv7pc9KoTIrDvEVJczPXfFF5DOV1WmNQyDvlenmmEwMMgLWbe8YqW/kXtfSv/g//zDIhhe
 3Y6yFyJaLn654lRRMZRk58kz
X-Google-Smtp-Source: AGHT+IGiWMeDv9PAhtkzL5eh97DdicfTmJjHLEjfCxeovVvq9YP+8CYwByY73IkNSHBMYxIi5dExvw==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id
 ffacd0b85a97d-38a8730d55cmr33585638f8f.25.1737016967628; 
 Thu, 16 Jan 2025 00:42:47 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm20144699f8f.97.2025.01.16.00.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 00:42:46 -0800 (PST)
Message-ID: <c79554e7-3308-4f9c-9aa3-c6b2116e0705@linaro.org>
Date: Thu, 16 Jan 2025 09:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Remove myself as Avocado Framework
 reviewer
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250106055024.70139-1-philmd@linaro.org>
 <41e195c3-7dbd-4e39-aaeb-0a40119cc5b0@linaro.org>
 <94b3ae30-e6ab-4c8a-a5e0-21544c6bfe34@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <94b3ae30-e6ab-4c8a-a5e0-21544c6bfe34@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 16/1/25 07:40, Thomas Huth wrote:
> On 15/01/2025 20.58, Philippe Mathieu-Daudé wrote:
>> On 6/1/25 06:50, Philippe Mathieu-Daudé wrote:
>>> While I was very enthusiastic when Avocado was presented to
>>> the QEMU community and pushed forward to have it integrated,
>>> time passed and I lost interest. Be honest, remove my R: tag
>>> to not give fake expectation I'd review patches related to
>>> Avocado anymore.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   MAINTAINERS | 1 -
>>>   1 file changed, 1 deletion(-)


> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> I can take it with my next functional testing pull request if nobody 
> else picks it up before.

Thanks :)


