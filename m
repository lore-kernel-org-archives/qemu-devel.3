Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055FD66B86
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 22:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG4Rv-0005iq-N3; Tue, 26 Nov 2024 17:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG4Rt-0005iP-5D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 17:54:25 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG4Rr-0005l3-Ek
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 17:54:24 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f1e73033cbso1280398eaf.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 14:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732661662; x=1733266462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O38pWA9cK+5InTtRisO791sL7WKwS0W+bWyB2Anfg/I=;
 b=ZEh8zuL/d8SQRZ9RkGf9ntHmR+85t9T6K/5831qzDZPlh2SrLVEbJ89DEGkIGzuRPU
 JpcdlS8DTAcgZ4JCDIU5A8hoyZ9sDIIniO3j7KXEednBZwj9lDRYHagV3YOGKuAk1hzP
 1aGdi+2PZidfkFV6jwpR80YVy6jXSNAwz6z3bubT1oi8CO4Owg2NYVVPqBHKnkEg5b9W
 IjJrSGvO42AiE6ct25IocbE4lyRZ4YIFMRh3z9Rb8wUtCjrtp89MtORSpqNUDz1B7AsO
 +29+/LqW7iwLZ+cdSn7vkiMScRKoBYndPxBgJkJa8w5pu5BV0cfN5PNzLC4JZ9NhiLyZ
 xmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732661662; x=1733266462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O38pWA9cK+5InTtRisO791sL7WKwS0W+bWyB2Anfg/I=;
 b=tMmA4/fqoL8TBYYxQ8yL0qY5ZHdZq/QYoj8EBuLyH1b9T5a8zurBVG5Ll2zGFzoL6V
 yp5xfjcOKBwGhGDBk+i1S8N9SrTh9Vf7LAHvpA8z5mrrSioRz+fQRIA8rIg97IjJHAk8
 1bgog3rDTSeBmP8UG4duw7yq3wITcXs+g1TJBobh2paQohAzyIklKMYYpCUVtmKuYHet
 6IdphwVWft7lQaSbkuyJXG1FPK3707WfyIvVTix3pO4stTM/CYtnwjPCMWRFPftxvcOZ
 IlIpsvbN+VPkTNo6qRnL8BiaafKyyPKrgwqCddlSrM3WCxHn8ZGFIQP9u0ID58C/lC7o
 gkPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcblY3Kh0kdiQDnNinQk/zjb53psbIHj3+qp/F9K/4J+Ne9HqSS1A0BTuZU6f+1qQwrUSZ9A9N5Mn7@nongnu.org
X-Gm-Message-State: AOJu0Yy5ALTdafXNVytKb66XAxdBJLy0kMwfpFSDO/uVn/D33Q06Jl5L
 h+k2WkmYCgBP6VcHcfK28bdz7e1v8eVHzKfKCcOdywnkflSVPp42PWIQEs190j8=
X-Gm-Gg: ASbGnctHSreBN7qiMEj5PfQIoIIsr8s3dJThB5YLkx0A6TgJ/W+xSNx87Q01sHaeiId
 1AY6wUdqkQqYcKLy7aqpCmjAmN8RGh5ix9O1VxaeyDkaDtdHVJf+I7adCN1zw47UPEIDz6VFG/t
 dQYD28YM6axP5iUO9ifWN8xVIzu53dcTh57GvwP1rYQpweCwPfuLgifTP0QhQw3D0SPfqcUxitR
 7JypK0cQX6R/5opP1rSe03SfYtSG+glvlwkS0En8vytYINIdj4REjAqZviY4y1j7ta4y1FqBmwC
 xIwtxS2p2tzQbTtY7QZ4g9dBT1ET
X-Google-Smtp-Source: AGHT+IFAglJk+yRi7vyPt8HITqOAHE0c6MsfDfBjnYg7j6gOeBVAYAmp6bRd5ozhzZ7tbIzUmmZhKg==
X-Received: by 2002:a05:6820:990:b0:5f1:d944:a1da with SMTP id
 006d021491bc7-5f20a260420mr1044039eaf.8.1732661662046; 
 Tue, 26 Nov 2024 14:54:22 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f1d621368asm2057346eaf.1.2024.11.26.14.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 14:54:21 -0800 (PST)
Message-ID: <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
Date: Tue, 26 Nov 2024 16:54:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/26/24 11:52, Thomas Huth wrote:
> I think we want to continue to maek failing downloads as test failures, otherwise we'll 
> never notice when an asset is not available from the internet anymore (since SKIPs just 
> get ignored).

I disagree.  Download failures are not rare.


r~

