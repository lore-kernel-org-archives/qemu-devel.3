Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5109CC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57uO-0007Tu-GV; Wed, 16 Apr 2025 14:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57uK-0007TQ-S4
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:54:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57uI-0002TL-4s
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:54:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso6231367b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829684; x=1745434484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZksWE91hxsAyKcpKc6M9f9Z0MABAMLDkBYdYVl0Lzo=;
 b=wrrYmeUASGZiVWbSZoIeTsAiLJNvYET/QTZGFoYEWkdNZudpLaRgZTaEvTasqYBQQj
 AWRvXsP/9Ft+8h+iSaoU96/yqAv2/TW+f5NFILu/gC1NqaLZOE+4afLCjPJ6mgKqqeam
 rC6zSKQwT5ZzajBXbpER0WW6gyV4rS3YSnAd0JBDK4N0HjnGcnmC/KP1IZt2PfdXilOA
 QJ5Ca+u6iVhq47ia3dIsBT2u8fUldMWVyrq2VzBpviWqLOz/jKWUIQCrU1noG4Cp7g7m
 XwgFVjuINEZsKUe0Nc62ZLixdn0OH9ApOcKaM4VP0EcN9/hwgd0TtIA/J95hw7OWp7xF
 1Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829684; x=1745434484;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZksWE91hxsAyKcpKc6M9f9Z0MABAMLDkBYdYVl0Lzo=;
 b=QcCGFFQtZWPFRUU9VjBt5HRIroASoLQgXr1LyCO6p4COZW9lCTz50XukWvXhtjc9eM
 gqHIkePX6tdeZOWfJDRqXHZS9SJrnIjF+DwgiO0+vO0mVxn1UEY+LLaGDy2r6ywooH3M
 ltDfY+zIk2PhoVzbVqTNUSjiJuDBrzEuSdAsWgkOA+ZKMtHms+TiPBdFwVgmbjvCmzfc
 6s5vbVQbH4WPir/+g/NbkTvHsrta4kBHr/otC24UIoORRPm+Szt8K6D1fzRg2hIetYHs
 78VsXYCU5RfI/JWx0BR0Zf79/CgCb3y4bZ0TB4fL00GFSUf/koKoF/GkosSfxONEovf7
 g1FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUz9ERSnEFIEbJyGQ34jllRtfe+X3p9kfmNbYtXpo/3uMMRL69i6tR/9P3dFdXX7BiXjH1I1FFmfh8@nongnu.org
X-Gm-Message-State: AOJu0Ywnchr0I0da5NnZs7uwPbVGxrxfv3pyWrzyHzflY0Gcrewv9QxT
 6bjwJUKEmygue4gPUrpEz7p1B3S/iyBVkKJkstbbs7+P977AMhM5gr8hw5NwdHzsO7TTjaaOfcD
 f
X-Gm-Gg: ASbGncsTpKcvWnsuuG98sL205xWCH5ImrrBajFSwVt3+auo4JiSdoQuZNdk/AKEuLF6
 RqAx6CKbRzLhfiq1HUceuPJPO+jIYqXH1PCoXjUSRUtPlPad2xcEmFvWV6w+XrCUyJ1TfdhT8nq
 Z88veuDWQBGhs2i11yDKaJTlTYxytLKYLfMSgte9e5XCwV3Arbj0JXZGSzQ7AFodx9fJPZyJVHg
 3DiHPPIg9zYALVapGRTcwMTLF6QAF1ED1ujewHG5EJ/LY4YacjK2WJKeAPtKhlFWm5V1UU8J9W9
 R35+DY40drGoBONvpOlHD8q2e/z+6ZrWniHmnVqLpUmGWFvq0yUsAA==
X-Google-Smtp-Source: AGHT+IGwf/tkohtkZWtmMFBHjSgS3sgPqsjGU2tCnSfkWiyvPJoCRvkUgFEW3vSsGUZ2wO0eQfIqMg==
X-Received: by 2002:a05:6a00:3d13:b0:736:53bc:f1ab with SMTP id
 d2e1a72fcca58-73c26716bfbmr4216373b3a.12.1744829684333; 
 Wed, 16 Apr 2025 11:54:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220c9f01sm1640909a12.29.2025.04.16.11.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:54:43 -0700 (PDT)
Message-ID: <6325c3ef-c44b-4e57-83e8-78f364165fff@linaro.org>
Date: Wed, 16 Apr 2025 11:54:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
To: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
 <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
 <5cac93d4-e5a6-42b0-8f7b-5a273168a450@linaro.org>
 <D96V6HTTNOF1.3DDO2NQ0AUEA0@gmail.com>
 <f8a90e7b-daa7-4c87-9702-e80e9d5b162e@linaro.org>
 <D97QJO5Z909K.368VVIBFA17TA@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <D97QJO5Z909K.368VVIBFA17TA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/15/25 20:16, Nicholas Piggin wrote:

> I don't want to bikeshed it too much, if you prefer not to move it. It is
> nly one specialized case. Adding some comments about the purpose of the
> locks is more important than if you release them here or in the callee.
> 

I sent a patch commenting this:
https://lore.kernel.org/qemu-devel/20250416185218.1654157-1-pierrick.bouvier@linaro.org/T/#u

Pierrick

> Thanks,
> Nick


