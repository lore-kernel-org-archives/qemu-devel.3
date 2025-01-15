Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12209C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 09:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzMA-0005J0-FV; Wed, 15 Jan 2025 04:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzM7-0005IH-V2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:06:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzM6-0002IP-52
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:06:31 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283dedso61590985e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 01:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736931988; x=1737536788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wbW9Ql9LSQ+BYyFysXfkEdaR66HSsZogomVzRFjanvs=;
 b=mxxdhT4uATbaS4Kp7+aZHfnuL0CpK+GPsUWRXyvgdbaYoxkH2/yiGUo+wPp5dPc7bl
 2b/F1ikK3vMnvUG0fXJ8Ov7s+Nd53FVjyaNfih+5nXyoB42gRccHP+w0BfbblP+tWz9j
 Zmerj+ArEoXFHrgWqr4flKNYzgLHD58hhF+b1cyvfm/wX6XGvCWECxWzo6pXw5AGtzcn
 Mqx6J+iYMZrK/5SDq82EhlG3bNCjmbqYqfLmzfvW77jgdR33qPzS8zRuf+GY2Ncs3cHK
 ekXXz7+5qntM4c0Q5t3V5KYsbUvLyevUIzE7vsdL4nB/h60/rMqQmrPamkW2Hlv81O5i
 kdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931988; x=1737536788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbW9Ql9LSQ+BYyFysXfkEdaR66HSsZogomVzRFjanvs=;
 b=nZzqzIDqXVeLitaDA6e1RfWV1ZyVIEiPshUSXB9gkZkSBqyuUMQAsrVMf0XZ1YKt1w
 uF3oXOaSWzrfdRU/IEAr76f0ilFhof4DQjB71eri1aeCfzdhAerYSuNmjnCTkvuna3eu
 pmdi03e2FAYEeS7gvGVmsJIPxy3RNWUV5fe/KQEktoHP2j7EQwegB8Qco1guTeH1DgxM
 yCdNO+u9UxcFWTnY/LgIu2AdRXFBFvF0xwcKdKwOG/jMQjd2bQcu3mQsQob75Rw0+ThK
 MCMfFF7mq8xngs5q94d1B43MkTviIBgzkAYaxl6V6DZTy+EP/5l2KGxPOHxd35WFs588
 JpVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX5ru61z8WUeQaV79UbLC9YKd4B3e+hbWN0xWHpoRfmL/ERC5Aq3hD5zeV5NyUrTvg4q5IF1g7cyjN@nongnu.org
X-Gm-Message-State: AOJu0YyvqJk/TxSHggT6T+rpAARyenbhMIFeHNJKAMtirMUof+6OHPNA
 +LVEXfX3vRkcb7DE1tSAwoGggYAR2yNtBE//qdIETqac7czKj42b8hv3o1tRGEM=
X-Gm-Gg: ASbGncsLMzKZvbYISUmaPH+3IQh80VUsrThzjXtBxsu76/kPb51oseCUuhBMYTcvlIH
 z9dE0fjbqPZbEXboLBryGiBmgEGQ8eHGqoK72HNxaBMj/GKW8zV/sNdkn4j1J41h/ok2/Kh5lcb
 47jFJHcAFbRHVrnKMVFTFA9qRPe0j4zB+so07AmZuTk+YBib6XatiLfrTx8J+OIzG3iFjjXtiIV
 oC8510JzXlEnYv1dV5wDxCku9zp1C7SXud9DGV0mG0aXJMtsgsMVyU3VpCvUyI5olpBd6krULD2
 1lKbhRZn7a0y9EsxQ0YE9OfF
X-Google-Smtp-Source: AGHT+IEsqYYFDXcnrO3i9ayFlThsfgTW2As+uadz1m63zQ5fbTUvT9L9xgjBu4pVqhs9ZsbDQAjBlw==
X-Received: by 2002:a5d:47a9:0:b0:385:e5d8:2bea with SMTP id
 ffacd0b85a97d-38a872de5ecmr21823802f8f.20.1736931988260; 
 Wed, 15 Jan 2025 01:06:28 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38b15d3c7a5sm10683100f8f.32.2025.01.15.01.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 01:06:27 -0800 (PST)
Message-ID: <040eea70-e991-4831-a564-bf3f6b917587@linaro.org>
Date: Wed, 15 Jan 2025 10:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-balloon-pci: Allow setting nvectors, so we can use
 MSI-X
To: Reza Arbab <arbab@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand
 <david@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20241216163125.438156-1-arbab@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216163125.438156-1-arbab@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Reza,

On 16/12/24 17:31, Reza Arbab wrote:
> Most virtio-pci devices allow MSI-X. Add it to virtio-balloon-pci, but
> only enable it in new machine types, so we don't break migration of
> existing machine types between different qemu versions.
> 
> This copies what was done for virtio-rng-pci in:
> 9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-X")
> bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
> 62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vectors")
> 
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
>   hw/core/machine.c              |  6 +++++-
>   hw/virtio/virtio-balloon-pci.c | 13 +++++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)


> diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
> index ce2645ba7187..1c2b071eff0c 100644
> --- a/hw/virtio/virtio-balloon-pci.c
> +++ b/hw/virtio/virtio-balloon-pci.c
> @@ -35,11 +35,23 @@ struct VirtIOBalloonPCI {
>       VirtIOBalloon vdev;
>   };
>   
> +static Property virtio_balloon_properties[] = {
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),

You shouldn't use that anymore since commit 5fcabe628b8
("include/hw/qdev-properties: Remove DEFINE_PROP_END_OF_LIST").

Also, this array can be declared const.

> +};

