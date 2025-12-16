Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719FDD64061
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVex7-00014i-58; Tue, 16 Dec 2025 18:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVex5-000149-4q
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:59:35 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVex3-0000yA-O3
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:59:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso38970775ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765929572; x=1766534372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tV91BRNaDK22iZZZaxQn+mozNe/Wg85fwHSi53iOtps=;
 b=qm/kjLCGtK/OL2rL4+L0PNHpdZXgJHL3LjozGdAobHy/c6TCjkhOSOwy+ZRSKnd+W2
 Gf3l9sNhfIVl50HMAlM5M0R3K/pC92xqvnADyqBWkHKTGFWI4UAlZLIQaptO6vKJ8Slk
 DF+WNqKVP2/6AE3N6B+fQDm87N98oVrTEVIOwNyf46lT4X8AORXyx98hiRCE+7klPJiN
 tvtZhL+smUhXk/eQUp1QnDXxezeqRf2vZTg+eG9XqXuQ7uS/k7MtZxWmPIb1fdtqXQ1p
 B8KDvAxiV1kWfVYCxCYdsf2ms34nhc42hi22TxcnXgQbMtfI05XeQbhRLAYOXsgfzrv7
 Dd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765929572; x=1766534372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tV91BRNaDK22iZZZaxQn+mozNe/Wg85fwHSi53iOtps=;
 b=c3+XPS0vXCRr03+6NXnvp+kBr9by2jEaHpZU3fxCXAgq3vbq2q+7Z+PQ+LNakvJdf2
 +nvNCwOZt1pzgQhuuavxHDyKk5FlUjusslSAc7wcimTfqo3NdkueRF1gC5Xb7Rg+YKd3
 tC3H+m77qjNciNrXeeS3dQH8EpjOxrXHvKwiSrMsCuv+vj9EO2F3g8sp4RiMmAirnj/l
 tsRUVcll9GeP1KB6zKfGGYUpu3gdYFNPsVVoV5zB/vpB5V+U7+7K82ipo0gS+YE7Z0Dz
 K94aAtNYrFa3Ip2IYiRO2EqlFzd390DjGAq7DwuZRHMzXH64Arcd94iT4d6jXcCBAPcT
 hZuw==
X-Gm-Message-State: AOJu0Ywwau5RpL1J+pRQoBMjDYarXe121H++LYfETBAvKRX1IuiIyPTn
 j5iZHXzmBK8fBh0PylJ0g/v0pG6YX9Il/RQk6Q2+XlI1QZqSof7WU3mYMNN9rowYEVaGGrbbwdE
 bm9LtSplU+w==
X-Gm-Gg: AY/fxX5Ej/1AIo/04jZdaswtj1o+xwIWQeW3d1qPAEyzSpQC/WX0wYs67Plm5WhwJ0+
 HCiYlZo/43tPbu81al1Jb01/+GMVSq4P1MFtKtkkJ+YhycQO7a6z0lCgju3r5SIJgpU++aoGNbZ
 MBIkKx0//X5MMqeftzVKFGLCxJpaEJnWY+sVq3h6hNChw8vCf7t1Wjh5CCJTZl7sapf+gZ/aYEi
 YrMzKHwmpfDxYspkOmbehvUv2lu4rg9sUdt3OKba3XRa9Lt9EAlvsVNNSA1vKLMi6h3q/pbYscG
 iAe7Nf2o5nodv3PlZM5+wzESgemHGPcRign7TQtQ5yu57IN0XAGKzPpYHGILjUtFDDMJhgetrV1
 vFS66kU10T9xvnzWup1llr9wwRF8OYXbjjmFi/isSNG3UL44P5NXWsRsbEf/41NhdEuTvN1ZvH8
 T5FqE754rmQiL2QyKDu5hKetrx50+EDNd/0KWesyXDlTLRgVP6HLvH1x8=
X-Google-Smtp-Source: AGHT+IHgjYS+1yGT4zK8zxS8yggLTimcchIdE/bhu18IO622bZDSBb70Xbhw21NRQ08ipOrOXWVxnw==
X-Received: by 2002:a17:903:1a2f:b0:297:f09a:51cd with SMTP id
 d9443c01a7336-29f23b456e6mr174088245ad.14.1765929572056; 
 Tue, 16 Dec 2025 15:59:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea01723bsm178230345ad.62.2025.12.16.15.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 15:59:31 -0800 (PST)
Message-ID: <8da88a2a-56ff-473b-97df-1ab1c4462a90@linaro.org>
Date: Tue, 16 Dec 2025 15:59:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/16/25 3:57 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> User creatable SMMU are handled as well for virt machine,
> by setting the memory properties when device is plugged in.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   include/hw/arm/virt.h        |  2 ++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>   hw/arm/virt.c                | 13 +++++++++++--
>   5 files changed, 54 insertions(+), 6 deletions(-)
v4
--

- set smmu->memory property based on plug callback for virt, thus 
removing the need to use global get_system_memory on smmu side.

v3
--

- solved issue with user creatable smmuv3 (found with
qtest/bios-tables-test, subtest smmuv3-dev), which is not created by
board file. In this case, smmu->memory is not set, so just use global
get_system_memory() instead.

v2
--

- Fix rebase on top of master
- rename memory and secure-memory address space with
     "smmu-memory-view" and "smmu-secure-memory-view".
     If someone prefers any other name, I can change it.


