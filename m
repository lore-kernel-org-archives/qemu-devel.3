Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECBAE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYlK-0007aZ-Mn; Fri, 06 Dec 2024 08:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJYlI-0007a8-Q1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:52:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJYlH-0000m4-0Q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733493170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aaBdmr7NYE7aJPc8IEUNahv+VdVOEEaP0ojB9AjWKp8=;
 b=gBlN02PO4CPI7qr9+THZUaBgi82W5ZU3XKuv3AzICGp/ayFZ/8Qq0VxZNZQYXEOoRFrWkn
 C7WXWDYR9InrHUchYY9fUmMYIvlLkX7LvwFaig88CdMA5Je1Yf9iORIjCCBfyAsOXdWQ4V
 x36cISu+ZuzMDVbFY15AqcVeGmw9gCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-LMIUDE0hMPW3F7GNsuvE4A-1; Fri, 06 Dec 2024 08:52:48 -0500
X-MC-Unique: LMIUDE0hMPW3F7GNsuvE4A-1
X-Mimecast-MFC-AGG-ID: LMIUDE0hMPW3F7GNsuvE4A
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a51e44d0so17214525e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733493167; x=1734097967;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aaBdmr7NYE7aJPc8IEUNahv+VdVOEEaP0ojB9AjWKp8=;
 b=C8qeU+JTILdoQXt4jHNVH5MBYPXD1awyuGjN1pfkDrWKOa3G2RYZ4xHPy02tF9gsj7
 vKFN3ZPKtInwN8opTE00/ngVMAixijfxEyeWsJY4ysKSbVD48aZ+pMltOtI4uc8Ps2lY
 6Py8eJk9IXCBaCIE7fXwChb0jU/zFhRnlJHJuXGkGFxmNuFB5T7rDu83c3niGMgUcSVc
 GN9r0ZFvZhTpi7ZoCtewHGCvD9aE/g6NKToVIIK6JXuTcZLHIZgxWppFIfznm9cuRm0F
 0ot5f/1YBX4T1jKMuszEf/tWJFSWIGDBTWPKlZjAROpeTzjkRPs8tunXYreyEKdhQVy8
 cT5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCURQJBWM12OrRFNzgCRftaQA+JfNL299M03nYvkIajaZN4uwOvaoxCdFOLiYGu9SFxe8pB1Zd6oVi73@nongnu.org
X-Gm-Message-State: AOJu0YwVP375ghdhn39G9mYv7dBhk/2HOlf0BFMVOsyfqRJHhjf5gpvE
 4GrL2RYf8BsjqZxHUPdTyCknCrDzaWaQNuGvSMS1+cpA1OsExZOa4ihjz9OcuHq7JJ62vFVZ3Ly
 QwbUnjeJu9l91gk59+84qTku9ELfLuhm8ZYJWPyBbfZsew3GmzV3T
X-Gm-Gg: ASbGnctMYN5pq/VXlpK+1p0Smha/Sm/wTAr84Zm9aD66gRvXCtH7MmP/PRDmkvyUC6b
 9ibEswnFVouLGdf5WYyuzivfFBCmk57U2B0EQAD3wNPdlU/nZY2vuaa8S8ttNHBAaZD8qP3J8xg
 cD/FkyP1W1haBLUhNIqzeDkfj4RYibhpH6e9PXn+sx9Ys1HLJ9jSgTEfDQLEztKqXoXs5WLNdjf
 NtTXPGaqagBuDL0Bn2pHKsZrUWvYX2qD9cdTMt+wMx7tEe0Oy9dEqsKlfEo6FSkdwd9KEKuvnRZ
 FdV3FQ==
X-Received: by 2002:a05:6000:703:b0:385:f23a:2fe1 with SMTP id
 ffacd0b85a97d-3862b37c37emr2220941f8f.26.1733493166999; 
 Fri, 06 Dec 2024 05:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgi1lX0sFYcJHb1Bav8C1sZ+bC1BTaHIrYuv2j+nAhxAH0JfZrWoCFpd5AuApWzvmRVCZx2w==
X-Received: by 2002:a05:6000:703:b0:385:f23a:2fe1 with SMTP id
 ffacd0b85a97d-3862b37c37emr2220925f8f.26.1733493166597; 
 Fri, 06 Dec 2024 05:52:46 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59cc6fsm4569384f8f.34.2024.12.06.05.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 05:52:46 -0800 (PST)
Message-ID: <0841269b-0ae7-4a03-93f5-b243bd525800@redhat.com>
Date: Fri, 6 Dec 2024 14:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/functional: Introduce a specific test for
 palmetto-bmc machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241206131132.520911-1-clg@redhat.com>
 <20241206131132.520911-3-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241206131132.520911-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06/12/2024 14.11, Cédric Le Goater wrote:
> This introduces a new aspeed module for sharing code between tests and
> moves the palmetto test to a new test file. No changes in the test.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/aspeed.py                   | 23 +++++++++++++++++++
>   tests/functional/meson.build                 |  2 ++
>   tests/functional/test_arm_aspeed.py          | 10 --------
>   tests/functional/test_arm_aspeed_palmetto.py | 24 ++++++++++++++++++++
>   4 files changed, 49 insertions(+), 10 deletions(-)
>   create mode 100644 tests/functional/aspeed.py
>   create mode 100644 tests/functional/test_arm_aspeed_palmetto.py

Reviewed-by: Thomas Huth <thuth@redhat.com>


