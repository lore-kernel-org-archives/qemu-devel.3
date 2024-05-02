Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D350FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Swj-0008Ti-Nd; Thu, 02 May 2024 05:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Swg-0008SO-2P
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:41:42 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Swe-0006z7-Aw
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:41:41 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2db101c11beso91501651fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714642897; x=1715247697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZBN7K61S+zFQxOSAuUQ8DQilSYMrFoBYtuItJ1nRbVM=;
 b=VG6LOvDIcFSgyPsu8Zx/4CWeGpclpjS0l1uRm/D93F9fYgHHviOYZ3xpd4kmrxYuFZ
 CXJAFytq0zuRPr6QWVYIkGyTlNu/YyTUGznsVYgOywBp+t5hgou6btGCFWDEINWNqiiR
 LtUuDWdtbT/xUuddDFbM1Q04KjvpGgeEt7/XMBeZ0TI5RTTHtyT+UJGXsPtrhYBziZif
 G56dAiusmYLiYAyX6dCmRp8K71yPv7UR8fhJEFFandtEJAkjWvr2qDMRAGbqPgXBSpr9
 r9hNAcWVE9sFzhAglJLBTUblVss+95mchG4G/v9C5kBLul4/V0Sa+xVYCbQjEK70JaR9
 iOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714642897; x=1715247697;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBN7K61S+zFQxOSAuUQ8DQilSYMrFoBYtuItJ1nRbVM=;
 b=QBlU5FFaD7sV75jtpvvKX7w+MLdoPauFNjVYEXxvY7tNBBQIF3l9YvJfPUfglHHSqv
 tErNoualQeoxvv9Xm9HXsNrvVsjMVAQo8X5J7XW2qM5fXq0AQ6HSbBATS1rPcilKe9uC
 N732aAUt9MZSJmDo6QVSN26M5WTokVGT5hiktdug6X+81uZ8p+JEP9rqX4jhw464CkHw
 rS7B2MdXfR0+RAqaQMf2lJmkVKpEO4JBP1X/dm7gMuh0HnaapPNw36Tx4XEMOUgjYzKO
 OrTuQUw6D2CwivEHz5FziOqYFaHDhhNuFgcPVp98Z1jGZ/04gpTJ9XFO/9Tt6xtELlaN
 xE8A==
X-Gm-Message-State: AOJu0YxgjFivnR3IXO4ykQTk84//G0+SaXxXZiGBjQfdRvSDJVB9cMQT
 i2huQw2xw/BIm52Aj5joNsB2+2FDfPayKJtqauWjn/U3///jvk6lbWujtgsB6kA=
X-Google-Smtp-Source: AGHT+IFUiYpSiPQvSXn1JZNzOeDIrlHWIoV2w0UHNnB8ZK5660u3UwWAnbFsYLSi2TYJaxZkPQ/cfA==
X-Received: by 2002:a2e:bea6:0:b0:2df:ebd2:6fdb with SMTP id
 a38-20020a2ebea6000000b002dfebd26fdbmr3844311ljr.28.1714642897254; 
 Thu, 02 May 2024 02:41:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a05600c0a0b00b0041c097e20f9sm5067014wmp.25.2024.05.02.02.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:41:36 -0700 (PDT)
Message-ID: <bf5ff63e-d91c-4f46-b0ad-d4af85f8ee90@linaro.org>
Date: Thu, 2 May 2024 11:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: Allow building with GnuTLS but without Libtasn1
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240502081144.86599-1-philmd@linaro.org>
 <d67338f5-a13a-4663-b77d-f9dac2b2936c@linaro.org>
 <ZjNOGBnv4UeaFSLI@redhat.com>
 <26211a43-24de-4222-936a-259f22f052d1@linaro.org>
Content-Language: en-US
In-Reply-To: <26211a43-24de-4222-936a-259f22f052d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 2/5/24 11:26, Philippe Mathieu-Daudé wrote:
> On 2/5/24 10:26, Daniel P. Berrangé wrote:
>> On Thu, May 02, 2024 at 10:22:02AM +0200, Philippe Mathieu-Daudé wrote:
>>> On 2/5/24 10:11, Philippe Mathieu-Daudé wrote:
>>>> We only use Libtasn1 in unit tests. As noted in commit d47b83b118
>>>> ("tests: add migration tests of TLS with x509 credentials"), having
>>>> GnuTLS without Libtasn1 is a valid configuration, so do not require
>>>> Libtasn1, to avoid:
>>>>
>>>>     Dependency gnutls found: YES 3.7.1 (cached)
>>>>     Run-time dependency libtasn1 found: NO (tried pkgconfig)
>>>>
>>>>     ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, 
>>>> tried pkgconfig
>>>>
>>>> Restrict the unit test pkix_asn1_tab[] variable to CONFIG_TASN1.
>>>
>>> Otherwise we get:
>>>
>>>    In file included from tests/unit/crypto-tls-psk-helpers.c:23:
>>>    tests/unit/crypto-tls-x509-helpers.h:26:10: fatal error:
>>>    libtasn1.h: No such file or directory
>>>       26 | #include <libtasn1.h>
>>>          |          ^~~~~~~~~~~~
>>>    compilation terminated.
>>
>> I'd say that crypto-tls-psk-helpers.c shouldn't be including
>> crypto-tls-x509-helpers.h at all, as PSK auth does not depend
>> on X509 code
> 
> I agree, I tried the "less code churn" path first :)

test_tls_init() calls asn1_array2tree(),
test_tls_cleanup() calls asn1_delete_structure() and
test_tls_generate_cert() calls:
         asn1_create_element(pkix_asn1, "PKIX1.BasicConstraints", ...
         asn1_write_value(ext, "cA", ...
         asn1_write_value(ext, "pathLenConstraint", ...


