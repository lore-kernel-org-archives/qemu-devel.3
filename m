Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A972EE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrGx-0005Ed-68; Thu, 09 Jan 2025 07:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrGt-00059G-6i
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:04:19 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrGr-0003jT-LC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:04:18 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862a921123so546834f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736424254; x=1737029054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a+R6pBhsZXgc3wkYvoH6TSplCUmeXxZ7KzHdQ8M9T0s=;
 b=W3MnFn7Hi8XP8VYPgOSz8LzYYPl5nW6GwIllJEeudYfxzyNKiK5bC61X2MBHOw99NY
 ZoP/tjDsF5r3qkQrwarUKrJwzBm82lSmlpiNEvoMK3/RxCc6D/k5G5kCOm8GWyQBly8I
 xoL9VaqlUJnkHFwuNonc7GGQCR1meHKJOrG/dPDEFw157pRa8c7MbATTYtwWWw5YXRYY
 Vyhi8LncdvmQSlAAePgcCRI+BhGawXDfdMF143t40wXmGGJXQkfx2Bc5b06oL28B6Xoa
 fbG9p/rTfkw5/1D8U8rItfGNloJvO1FDwEa3taLM/nRtt0qoA5tEQtLU4Hlpn6Z1TZ8Q
 1IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736424254; x=1737029054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+R6pBhsZXgc3wkYvoH6TSplCUmeXxZ7KzHdQ8M9T0s=;
 b=Pm9TQM2hhYEt1LwJgga9sW8fXcXfK8ZhEAgMNJLZ+aYkylq1rb2X+WezIYFlpr9c+A
 exq2WYdR+Z2Qp26NOvguCEzHiVoeaoIzK0D4MMFP88iOU0dZtd/6rpZtHL7VL1aGvc2f
 36R6V8sxIhpdpE5XuVp+rt19iNJnmVuGSCa0aC7eENWfcge7r/Xu51LTbIK/brhEv4cP
 bydNvMdV/pbTUY8XeXyazQCGjtKRGyGAtVxiZT1ENJoyqNaFd3wRNcGsKFynysyybvE6
 AKqFcq/2iXt/0Bz+l6hCg7U1fhgNbf0XknMo5mh4C7bu6qlQxvB6O1WzHzDFx/OpHvs8
 3xkg==
X-Gm-Message-State: AOJu0YyAJ6CwtxUO03uOvt5mDX9LEjWT6m2SYuMXOVJwEOQCXFiHssIh
 K302nHG6nZs6Yn5dEwijO+y1Kk/7MHtOS7CoFCCvuyicykKYFoEmBL0EVEQirWA=
X-Gm-Gg: ASbGnctJVhvIMApKCNHbvc19ksGbsL6IzD3pK1uB5v5Dke99Ydi9qkXsLdDdp7DbEWv
 +0MBeVgLmUX/SVrhkrMTZdJ8cSrUCRpEnWhtR1RSkfmA95BEjaCq0E0SdZY/DT+uzRcdg4YvrnH
 lbJ9fjGuNZZvGgwtdZo+T0aJizULkJoL3cltfoGg724qwmZPDNBI0oHB4pbcSVlfcEjODFc1XLB
 AEajLO/DVm91Hkcl61W6XnTW3JV+046zJuxv+3c+7hJ6jiPl0V7Dz9cEF5yg0OOqHzeWVI7ek+3
 RPY6jE8w2zyVQJJ75VJkM083
X-Google-Smtp-Source: AGHT+IGCCOQCfOC+65Igpl/F6iWwsNqmG8s+W2yby2ce0ERRc5wQc95DYOger47fAyWlOFRgdtgOfA==
X-Received: by 2002:a05:6000:4b0a:b0:385:fae2:f443 with SMTP id
 ffacd0b85a97d-38a87313975mr5686184f8f.34.1736424253858; 
 Thu, 09 Jan 2025 04:04:13 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92f60sm52480405e9.40.2025.01.09.04.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:04:13 -0800 (PST)
Message-ID: <86efce30-2727-4581-963c-3424dddf46e2@linaro.org>
Date: Thu, 9 Jan 2025 13:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/14] hw/pci: SR-IOV related fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 9/1/25 07:29, Akihiko Odaki wrote:

> Akihiko Odaki (14):
>        hw/pci: Rename has_power to enabled

>        hw/pci: Use -1 as the default value for rombar
>        hw/qdev: Remove opts member

I'm queuing patches 1,13-14 which are generic, hoping
it helps you not carrying a bit less over respins.

