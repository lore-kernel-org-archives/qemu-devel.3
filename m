Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687A5CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBOa-0003d2-Bu; Mon, 01 Sep 2025 16:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBOQ-0003bu-PG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:44:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBOO-0002Rz-WB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:44:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b869d35a0so14620285e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756759482; x=1757364282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcZfKdcFHefoyEz//AKrw7jXkUxORpy87LYcpYGQTAE=;
 b=FtZmDnGVf6Iz5ds+L4CxNEOqevw3RJ1pKMgsxO2AWmDmNquaQApvy7JGRfLpZzoUh3
 tuBBHEvUyKMcNFCbdYhfBpxhH1gvw21swCRQpKJ7O+TZ1sJ03a1WSy1gzAC4ujcOXqd0
 wjNRskegpI0/5oVPucufoOSZWXU+Dzqq0TOvSZk/7mYuZkhH3J0oSPfyKnkXaa1PDdaU
 kyHHWulwafYgnpfWsawUnu9VCURcn3hdrdP/5o6zSmrL1pk7oNLz/ieEvAn9yps4iZWh
 SjpwNt/912ATaaw/9R9RWVQJxv3PUXn2yhlK5zlmTzLzNoAzWLOw50YkiWkZnh0ZCz9K
 Je1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756759482; x=1757364282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lcZfKdcFHefoyEz//AKrw7jXkUxORpy87LYcpYGQTAE=;
 b=LOxdZ6K22wu6n2AdMK8tSxsyQO/+Zr0xgiMFFHi/B1uQ7QrS2tlKM2fmqLM2sUktxb
 /2vDKsX/n27STWu5FijakO96D953/BsjK+9JHtPerWWdmyUOe50Huy8CNVzIgw3lZpU4
 6Gjx4Ok1DehR+kv7nH2c5T6Yg/6Ia0fpyIYJjQ0/9OkgJDDaq0r4Ycy9/vkOBJ8bjMoY
 ZuVQ2T/ysv1OdGaCuqgIYYewQOgBIVaKZNnUZf3I2tLu0m2Xx837fhXGk590MD7r25jp
 C6wa6O+ZMc19VXRpFGuRJh3irrvPgVpfeDuRBYXgcJkpn6ECstc73afqY5shBnSfwdrc
 ft3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQWD9jvXddOLJscK4TPyEkZc29ICcH9fGDe4CVLZKm7Iri/OEExh8zqDq+2RJKC0iEyQmsFkG/3T7R@nongnu.org
X-Gm-Message-State: AOJu0YxtWmO9LwWfYmFgHHHpQVHp9qQ3NidnO2AHolYRoAwREmtH4l+u
 F+IOrQqxyduUyZgmIylsCk0BrcTroYqp7FAFFIVAVY36sqsAZSMw1G/HCm7pK45zMJQ=
X-Gm-Gg: ASbGncsOUMDfk5HWSN9qGevMFDDHFASA1mZ/QMpASgbcSWsrY9p0kqVX6sMneANWYRU
 WT+jf0ZcQXsyhic+gVIQ+yV6+EjXxrOX3Md5Vps5WOhLJkU1fsmHY0560/+RdJEuHIrd9Qr6RDF
 CruG/6zFKvTkJ+xCmea1DV7DWxuCw4J0bvYTL+JVwesUzlWqQVxIcoXMwuh0XsXiMNdH02tUmqP
 CcOcG256voi3JSLGDvbYSZfleeEmUk4FhLo1ioN5dwa5eNOdbJYQT0vVfypoy9K/etGD8/RRcxV
 TzYmo+x2nWqigMAcFnszEkHSaiZTLUug3QPDsmtVNOa0I7vl5TauSDzndvoqTzUNG3QVVEBLkNz
 IoI6fXJgDur0vBrAzxA0+qLuG2gzan91ZnOWBrfhzfreJIdoZsJSfsytMzf9OIXRnwQ==
X-Google-Smtp-Source: AGHT+IGsdp1dwv2wMAk/hGj6z1bdTY+7kDCLh6+liJ3mdj6kwDLaEzxSH9GjMaUsHqgAQFwjCmq6Hg==
X-Received: by 2002:a05:600c:354f:b0:459:d6a6:77c with SMTP id
 5b1f17b1804b1-45b855add8bmr67244545e9.33.1756759482349; 
 Mon, 01 Sep 2025 13:44:42 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7a938e75sm115073865e9.4.2025.09.01.13.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:44:41 -0700 (PDT)
Message-ID: <c66c746b-9ecf-406b-932c-b516ecc927aa@linaro.org>
Date: Mon, 1 Sep 2025 22:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/i386/pc_piix.c: remove unnecessary if() from
 pc_init1()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, armbru@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250901203409.1196620-1-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901203409.1196620-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 1/9/25 22:31, Mark Cave-Ayland wrote:
> Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
> (phb) object is now always set in pc_init1().
> 
> Since phb is now guaranteed not to be NULL, Coverity reports that the if()
> statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
> along with the phb NULL initialiser.
> 
> Coverity: CID 1620557
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> v3:
> - Add Coverity tag suggested by Markus and tweak commit message
>    accordingly

Queued, thanks!

(I had v2 queued with tag added but now using v3)

> 
> v2:
> - Add R-B tags from Peter and Phil
> - Remove phb NULL initialiser


