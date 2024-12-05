Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E96E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAbT-0004CT-BE; Thu, 05 Dec 2024 07:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJAbP-00046J-CZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:05:03 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJAbN-00043Z-Ik
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:05:03 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e5db74d3so475863f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 04:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733400299; x=1734005099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HOiS8hYlsV6WtZTOHrqLk0OHsgx5pj2URzo3Gus3rc=;
 b=PQw+ps01AOLAmxM/JOI+9ugUyCtENexs6KahfpXFa7eAv5lbk5kKnFpsMmQZ/3SiT+
 1ojcPxyl+QMbRwc2jjdMQbCaCGo8uZtFdQa2HB4G3s/Q8uKGYXaU2GSuI6D8KEvBzML/
 41uks+Qp332lo8KlrJWsQFUK0DDNqQjEfZFWWuNQXQ5/3tGchEpR1vxjGsW007mqYbhR
 1GkzTB0l9yjiRRjk569+n6nJWbVxQ2RUl9+5l8RwnhvC0Pwnekv2YpFHyEmkKa0DhPF0
 xiN8/UR70xj77rTt7aKSkNtoKzgiq2Kq3PpLRumFv4nYR2tt7aYNFI6o2yKRqVIgRcWe
 EJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733400299; x=1734005099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2HOiS8hYlsV6WtZTOHrqLk0OHsgx5pj2URzo3Gus3rc=;
 b=rhp1FaPBjItPmG6hddKshL8OJUtkekNgq1bolLGm+ty5sg7u8mhGHCTNKh/Kj+5+Sq
 vR3I6plwJbgbgiqKEORKB1jmav/Px4CPNA7ocOpsqM8mG1KlpAL3FlzJ7hN9BYSiX+T6
 eRoPRP721nxFU95uNHGWSLBoj8HJhm4zrArh60lkZBVRA2b4z54SRqwTqUzh1xm9qetX
 au107HNHJbamRn0uk/z4G3rFdE+c/+xCwlaHObctHMW/CgDDp492gVXduR8Oe9Qg2pFd
 EzwIHghhwkthHIVVc9LACd5FMN/1HSLRNNoxxzTcerMuYP2MC202qIcSwtQc9v3/Jdz9
 ykDA==
X-Gm-Message-State: AOJu0YxvAw1cxUt+MFREUOAgBD2gXHLFCYKRdj+uVItgt9Wy/8Cj1iht
 b884axZeJ6CVSAvQj+yp0GUURNEwkZqHk3h5f8uaM2r9BPklLGJYxKBb28f29pg=
X-Gm-Gg: ASbGncsg2go7BBhns7RhaJ5sh73sPYFWQEI6ffCdHL+nXtytnno1VkwSbTWPbg4t5x8
 Zs7HrKaLxkg0YrGV5KJvcuV/YPsYTPoskDaUURnrzp1puzYZZJ12tILK2lGXqt50Mz3I2evOWRM
 xM0rkcu/gpDdDscut3jPxrKAHUi8V8+cA9m34Cw0QwBJQ8MtHzqJtpY78SxDFTXWbz4BrCY/OV8
 ydKQg3V1OOs5Dc54c28VrmQEnP3tRVrJMxPk/zywxF2nSIESjw5OxAMkGNUuv1BqSyyb4o+Rkmf
 Pih5WtguiT1o4qHK5A==
X-Google-Smtp-Source: AGHT+IGrxTLre+sFQlhn7qwJN4kwHSNTWS1uRqpLAipEULPpmlRmX1O62j2ZZ5XSJVi9GqJtATiUWg==
X-Received: by 2002:a05:6000:490a:b0:385:f821:e97e with SMTP id
 ffacd0b85a97d-385fd3c5a6emr8507629f8f.9.1733400299570; 
 Thu, 05 Dec 2024 04:04:59 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526ac03sm60893605e9.4.2024.12.05.04.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 04:04:58 -0800 (PST)
Message-ID: <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org>
Date: Thu, 5 Dec 2024 13:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241205060714.256270-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/12/24 07:07, Zhao Liu wrote:
> HPET device needs to access and update hpet_cfg variable, but now it is
> defined in hw/i386/fw_cfg.c and Rust code can't access it.
> 
> Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
> allows Rust HPET device implements its own global hpet_fw_cfg variable,
> and will further reduce the use of unsafe C code access and calls in the
> Rust HPET implementation.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/i386/fw_cfg.c        |  4 +---
>   hw/timer/hpet.c         | 16 +++++++++-------
>   include/hw/timer/hpet.h |  2 +-
>   3 files changed, 11 insertions(+), 11 deletions(-)


> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> index d17a8d43199e..dbf709251a8f 100644
> --- a/include/hw/timer/hpet.h
> +++ b/include/hw/timer/hpet.h
> @@ -74,7 +74,7 @@ struct hpet_fw_config
>       struct hpet_fw_entry hpet[8];
>   } QEMU_PACKED;
>   
> -extern struct hpet_fw_config hpet_cfg;
> +extern struct hpet_fw_config hpet_fw_cfg;

Could this field belong to the (yet unexisting) HPETClass?

>   
>   #define TYPE_HPET "hpet"
>   


