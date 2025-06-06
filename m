Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7BAC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTEg-0003Z1-KQ; Fri, 06 Jun 2025 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNTEe-0003YX-A2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:19:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNTEb-0008AN-Fu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:19:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so15318155e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749201571; x=1749806371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/jjRg3DXAyhvewmM3w3Ou7R7TiUtBBJ4BC4rYF9FSI=;
 b=fVYhrzrmZbgkexi/JW8KYz3nQi95P7NZhcNTrVDNxNuOztjnGkkHMCQ06tCN92s5KN
 4HsLn115N0pvqZ1v5L0nV0XAHQ94ae3z8nxaCCmpJwzMXaAI8FS5Vh/79ybTT5HZjblw
 Na/r4MwSJvitaS7h4EmdhYn50n1PWHP9a6IfMNTQEDRzHc8Mi5O+qAEq5HzpPBIhof8m
 r4EpXhU5YdH0Zp/LQDt8H5GNZ0zh3sI+zJTAozrkS3YSnmpmRKkLP+rf8PYLBHmd6kAT
 2U+vOCZ5zMw9D7jmZaBNDRvD7GETL8leIxaqjXiqwOCpEq/+Uu9IszOiKU776s/c8Gj8
 BN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749201571; x=1749806371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/jjRg3DXAyhvewmM3w3Ou7R7TiUtBBJ4BC4rYF9FSI=;
 b=dv8L4PSKHxYY9jV+w3EnSab2VRBVwyzJAJjKalWmhjXO8BNYu7Ls9QHKwnVjuYxJ0D
 j4HgEDG9NerBM91Cx7BU8fokGaa3+QZSHrBJkPN2KaAtpa3gyi/BKysF9eAhUY792O2e
 jrAoj/yvH9Jkl1a+tt8hALCuUqvIcTmFk5A4DVjxwQ/BezqB78W1B+Ipw0b7k8rycCVL
 biDf8wGce9sJ1y4Cgz+8jmK5/EUdWha7ekVLPXcVX5iWNMdr18qMg/fAXaE/xMPEpd6W
 riGpzWry99O4TgECIXIrzGJodeuxhiJIJd29RQMYUg+raN93FQ0jjZKmP0biZtCoi2WI
 BUMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSNSGR0jVYz5k9OJdahvJdEOmMPxzTDWXSKZiqW8jZWzGKNBXABLd6+/GHGrfzIu0/ZIKNQClU7Veq@nongnu.org
X-Gm-Message-State: AOJu0YynKc07WOnZ/2mOJVdi5HVaaQidRtCBxfZHqxVDDX0XHDz5YLoZ
 Eow27+Qjcq7kkLiNpeXCFUsVwb9GsXqfRI9YGmCu6GWej68C3/xdx8viq5gLeViRfKQ=
X-Gm-Gg: ASbGnctgmbOKRSRyOZjB+GlOMX0C9L4dJGYEvpDLl45A85hA6A+cx6dDDYJnUGxNgKs
 A0CCRu7VefChuOmrnMSoj81/yJ2voYVn17NHwkfQccQLCrBsZsqfmRKQIgOH0CXZ9fgNqXoX+Nl
 nLLu9SJX3v/g61TwAb55YfKxKFzypEEXxW5jMxwwZ2HyDOQRiD56SM+cA0uDmMPGTd9fXSPRD3t
 ak7Nc9SJxLN8fzqRYZKRyQd5CiW/NfVCOMoqOEr9WbDmIYSiCCiKzlzz99zEE3jLjO/matnRiM0
 LSl9k5RuAqe+IUjwNZJx4zHRGObllgqQPfjsAFsA7qFPQnB9BAZSx0k+TZYCy/HLlN1TR8CaOC8
 ryDjpWvVffgZRKc+iULyptuxXiOORM3D7RhOHFm7t
X-Google-Smtp-Source: AGHT+IE4D4d9+/j4RM9kf+exZd2gqrA/MPU/LxwByzaSnYNJi2BmYCeWF3QiRhUReXLsIheaqxK/mg==
X-Received: by 2002:a05:600c:154c:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-451f8469c5bmr64727045e9.4.1749201571170; 
 Fri, 06 Jun 2025 02:19:31 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d3esm17676205e9.6.2025.06.06.02.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:19:30 -0700 (PDT)
Message-ID: <d22baf31-2722-4b89-ae99-475d6c5e4f33@linaro.org>
Date: Fri, 6 Jun 2025 11:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
 <20250602173101.1052983-2-clg@redhat.com>
 <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
 <06903e8d-d729-458d-8157-5a54d324a239@linaro.org>
 <a838e7cc-968e-4ca4-ba60-bbf201d689aa@redhat.com>
 <5fb2a861-26c9-4a48-9de7-6d872ac1e234@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5fb2a861-26c9-4a48-9de7-6d872ac1e234@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/6/25 10:49, Xiaoyao Li wrote:
> On 6/3/2025 10:53 PM, Paolo Bonzini wrote:
>> On 6/3/25 13:26, Philippe Mathieu-Daudé wrote:
>>> On 3/6/25 05:04, Xiaoyao Li wrote:
>>>> On 6/3/2025 1:31 AM, Cédric Le Goater wrote:
>>>>> Use PRI formats where required and fix pointer cast.
>>>>
>>>> Maybe we can make 32-bit build exclusive with CONFIG_TDX? since TDX 
>>>> is not supported on 32-bit host.
>>>
>>> Yes please!
>>
>> No objections, but I'm still applying these first to fix the build.
> 
> Can anyone guide how to implement it? Or directly help cook a patch?
> 
> I'm struggling to learn the 32-bit build stuff and create a 32-bit 
> environment.

-- >8 --
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index eb65bda6e07..b5970f9a1f3 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -13,7 +13,7 @@ config SGX
  config TDX
      bool
      select X86_FW_OVMF
-    depends on KVM
+    depends on KVM && !I386

---

