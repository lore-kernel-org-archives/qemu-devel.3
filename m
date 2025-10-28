Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50950CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDe12-0001fD-AS; Tue, 28 Oct 2025 03:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe0z-0001er-S0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:21:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDe0x-0003Nh-LP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:21:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso40951925e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761636064; x=1762240864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N7nu7PK90YXI5ougHYdnUc2XCygZqpqlYRNaiEeDPYw=;
 b=blFeToO3Q7y6QpwDHeGzrrwNXmTrgannL4duWXzA4903wpSJsZLF3NLi/rnemnz6Xy
 mpiUS9sy+1xOsz06Fpv0KNKWngFTcVPP9Zcv8Ndg8jeYj9xLKNblJrIasl4nFBP2GCbJ
 G7iFf7VZl2R666z0tEc+dxULVX4lyfzfjPxHvhpM5ohK+y3ULZJSz0eI9MAFyDlvXN3X
 Ez5bv5wn7hdPNsdjiK6RoqKSYJaUWBWy3ulxmvYF2NE6p3J8P5QsYP1JCrRr8EGNiESr
 /vyzjuTZCtikfbHwdbS8Fd4SEOuhkI5/RreH3B6tXjOQCfov9UgGQHp6r7aLODYGMb5E
 jbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761636064; x=1762240864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7nu7PK90YXI5ougHYdnUc2XCygZqpqlYRNaiEeDPYw=;
 b=Q2/P/29VYKWZRTiBUnY65SBL5OaL9HImqaJOuOqnqfuhRcnp7tM9eQIktNjJS3VFK7
 Xk//3AbRKgs4OPao+1CF3UtZiNgadBOxfOjm4/pUPRy/dKuWHYokw/QMhUrD80KD8gxS
 gK3/Ryg0NA+lMayka8HQR7D1xd4slvf5gZCQwFBK8gN0FlPkmB/140HHO8VKVDGYDoG8
 4f7bIVZetPj0klSCgQPj8joBGx1vMMrO+EYQTqkH53l2mlZdDnwXFemi0CoBjg+8nufK
 Z8Fn6WW8sfzBvTAh7NNd86LRbRm08uqjiUhzxVEZdVg+L0j0tlbCT4pQO1lEu7I+4P7T
 OWew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXehb/bqrkmyxRU4t2u6JOU7gb1DlBNmquUfsqMaGfZFbiF/OVS18IPZmDAAiTdOr8Q6OrIn7+09gKS@nongnu.org
X-Gm-Message-State: AOJu0YzaKiopRbizg/GaZJeVCRuz8Oz46DRu4ks1httcktADP6tjFNLQ
 /bs0FwuE83pKCDw7U1PlYzmvft2+4vxly0nihSWaqArGEXZH2EZGcT4K/Zs1XOoymCo=
X-Gm-Gg: ASbGncuHzMRmxpC+K2w2bFbkgMAlKQ3l/r4FnN0Jl9g64OHJ4y3aBVm39seUtbT00Gr
 ebtS/6vAc37SdaJ4r+SIaKmGcLHollGFwqnaQRk7i+ayrsp73OSANcB60ytnTNFt2OvNV6p8VIV
 DjHShDxddabsUIbzaL77bIFYxRaHi3H+5g9qyCGysadSJB2tAkwg7wQYnrHMUwUzXh4Dm98m6jH
 YP7UpVaZEZoVvpCnK+rLwiZueSCjHhVBRuBc0SlqUFGxATw7hexFg72tspSUfo88Uz+gbP/ye/o
 zgQ6Bh6u3duKqD19qoz2Z2B91Hk6tRA1HuqC8qqB3Apnyt9eUfi1k0ppLw3sBOV0to2tQD4U4Ty
 bzRak4d3bRMKQ4VD+SntPOtadxkWMhwTZJ7igbBKzhMFUM8VLbjAgSmqqvpsjuLrpQPsarRljKo
 gl3Qwt0sof31Ol26i18SG4XSnt6oqUnuKfjY7uivwuJ3OnHRuU
X-Google-Smtp-Source: AGHT+IFGp3z8A1qloCBRFDt0s9TNFrsZhhWyCHiiYmh6iUDB4yZEniPh0QbY4Yk/cLMVmxpgQ7mlFA==
X-Received: by 2002:a05:600c:46d3:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-4771a46941fmr9051465e9.7.1761636063871; 
 Tue, 28 Oct 2025 00:21:03 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718427409sm14116455e9.1.2025.10.28.00.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 00:21:02 -0700 (PDT)
Message-ID: <d86bebc2-2c97-4dd2-8132-441020d21376@linaro.org>
Date: Tue, 28 Oct 2025 08:21:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] hw/pci-host/raven clean ups
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <cover.1761232472.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1761232472.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/10/25 17:26, BALATON Zoltan wrote:

> BALATON Zoltan (13):
>    hw/pci-host/raven: Simplify creating PCI facing part
>    hw/pci-host/raven: Simplify PCI facing part
>    hw/pci-host/raven: Simplify host bridge type declaration
>    hw/pci-host/raven: Use DEFINE_TYPES macro
>    hw/pci-host/raven: Simplify PCI bus creation

Queuing reviewed patches, thanks.

