Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0514C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC7R-0001yl-EN; Wed, 29 Jan 2025 12:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC7P-0001yC-Of
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:44:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC7O-0004I0-AG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:44:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso75464985e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172689; x=1738777489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPKXhhbwmgmE8VDvhhtPgzCBhAxRSGpK57jHTGk1m/E=;
 b=jlGAONKSXfWs3l7AD6GtaYtdIRsUvFcuYzuwvm0J3rAHDLmFNN3KumT2PtRwOKTfPi
 o77BdQzy2DtkNO0U80aSa5CJ2TVZL5nMX1vON2ESSWWc4P3XX9DgVIQqXbGwqG8ISZPL
 97BwcUXH/CBka8cEzVJu/ZHQxW8vLcVitJ76vShtpIHTN7AxGTz1AaeIu5XZvKCECRLm
 AplcGl7JxvPvj1t0Jn5/rA2hrjaSI2OYRfO9HFSWpthQdLN3pD9McS7qSsbei6PAfgsl
 n/a7Rzf22BXK0mVUP0ITu+cOlk3o/Yx0PIf8duB2w6+wd2l1JL39nfgeQmMQcvi4iPpl
 MoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172689; x=1738777489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPKXhhbwmgmE8VDvhhtPgzCBhAxRSGpK57jHTGk1m/E=;
 b=H2bm+1sVAxZ+gtBastCuaHssVPoMaPvXNcKHkTY3zJ6DP7q3xZxEyKzu2za8kVI6Jb
 My+q2AWVeEomTRYvYcKu/EEF9yi3hHLAyU//2OagUBlSbqogGPgyjFaY98o6c3Shin2f
 whJdmOb1qSusqnJf1eYxOqdXe9LTxtZjTEmbDgm9sZ9YRthz2rEudKkuI0aGeBuVkbec
 Q7gk3ajNJCAQEuwOfkugSjCzTJYmDaOR3QLay59pUJKYVHRQ2UiM03qTx+0il+45EKOr
 M5igxXXjhhPz17gL0aH0UP1/rZvuJUVKiCdCPdIN3XsqPzH0DqgTex4umiDbyEz4x/uF
 eBwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQfU59tPbiFP6R0fUPVmxdOSSPGJ4oHEjKSZY8dSn1noG47l9l55gHtfiJ2v+sibAlFphi9c5CCvwb@nongnu.org
X-Gm-Message-State: AOJu0YwOEH9mSiWID/pJNbHs7mu2XiVcHfeyztszMDGk97njF5Fjp9g5
 NdRUPbdMODnKQZsZoCJo/FK02PO6TSsemqB1w1obgt2Hly1db4Uuidtn61j9Y4Y=
X-Gm-Gg: ASbGncvwPJY0tkIQuIRBZ9wPW65IJ0mQsx/Z4Wb1s+ZGFqbtvmqYWqdu/XRkAigR3Ic
 XRDgOMOefW8b/njfOEwh9LyMfe/Xqqx1VnCypIAX4XoNqisb3GKQG8UxeLDeFYuZZqQI4bEAAf5
 Zk34otLtlYj7FPZVllqMYZyI7PagV3lXnpj5mtldSBU5U0V38tEBacJV7req5TFUpmG08mwlGjC
 o0d1dxcQdPeRFkj4hWY0rFwfsvH0/jGVh4MO0cxICrB2SGzn/JMPSrCiCJ4iZKiFyWQizBYUxJM
 NT8o7hAg0lUTjHTg5fSPo/sE6OvZ6i8GU5+OTNjwl8XxERs4qQsrkc6z3HM=
X-Google-Smtp-Source: AGHT+IFdrwv5yfXCj95asNCvabr7qtSBJiCO81pBHbNdeL1+WoXi1cVG0ORf+kD/LY7ZBrfm8Vvlvw==
X-Received: by 2002:a05:600c:1c91:b0:436:ed38:5c7f with SMTP id
 5b1f17b1804b1-438dc3c38c6mr36478225e9.12.1738172688623; 
 Wed, 29 Jan 2025 09:44:48 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm18094649f8f.69.2025.01.29.09.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:44:48 -0800 (PST)
Message-ID: <bdd10003-ec28-47dc-9f8d-1d309dc5ea54@linaro.org>
Date: Wed, 29 Jan 2025 18:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Extend PPC 40p test with Linux boot
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20250129104844.1322100-1-clg@redhat.com>
 <ed16ce9d-f750-83c5-d2c0-f2fcb4c860b3@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ed16ce9d-f750-83c5-d2c0-f2fcb4c860b3@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 29/1/25 18:34, BALATON Zoltan wrote:
> On Wed, 29 Jan 2025, Cédric Le Goater wrote:
>> Fetch the cdrom image for the IBM 6015 PReP PowerPC machine hosted on
>> the Juneau Linux Users Group site, boot and check Linux version.
> 
> Not related to this patch just by the way, I've noticed that the rom 
> image is loaded from within hw/pci-host/raven.c instead of hw/ppc/prep.c 
> which is odd and unlike other machines. Is there a reason for that?

I agree the cleanup would be nice (probably breaking migration).

> Regards,
> BALATON Zoltan


