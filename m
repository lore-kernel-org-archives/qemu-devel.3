Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7870FD68BE7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8sX-0007w9-6w; Thu, 18 Dec 2025 02:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW8sS-0007v5-BL
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:56:48 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW8sN-00071t-89
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:56:46 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42f9ece6387so81060f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 23:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766044601; x=1766649401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=viVVRNYaSV8s8DB/EGOJ01v/32csXHNsv58hPF9w6oM=;
 b=M9dvwlzcURKb37WWjs9duHYURjfrBblqLFbZbfBCAJzId0rWkLEyoDw/EtbvBkyPaB
 LmQnqNCTlWd75QnHoTYDBqqVO8wNGR9jU+08+e9pncbyrK/L9GVQgJ+trKtUM+lNAit0
 2b+Kimq4wPTcbEZVrNVCYLRrE7g/H4vUvRNO24HXxklGe+g1pGE+9iscQXu2HAdne5iz
 SCNTANdchfpved8bz730Vqnw+iGxL0InCd3TM1usWvM07UwPcC21rFdxExBKX5qxzj8X
 s0WMT98wTlw1t661Dob37POCH3OX7JmTYGvUF51hP96z5ieiUkCj7NKQjz+pwm/UeFH0
 NQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766044601; x=1766649401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=viVVRNYaSV8s8DB/EGOJ01v/32csXHNsv58hPF9w6oM=;
 b=ovAqpO93kjs8m3EC0PMKt21NcW0inx/ghqNThD5k2ASrxk3AL/ebz3ZAntnDI2IlAw
 udkr5HF8p181Rd/Iq0usx7ZbN5MJgqLAAvGkagPjjlvjXrmOLTzLrAwD36SvZBOrmOFg
 PPO+cvcRZGhILzXyKHAMhDfqFgqgWdiK+CpVJnXl8GBsh0Veu6fpDGcj8SRIre/7/KaQ
 4muarFM5I1EO5Qv4g1Us5OntinA6a2gvWLdD+1FNSLi/+0EyMUD04EIOkCuxEcClJ4hu
 RSspqdwJj4Uw8N6xPp/+weiuEE8KqWViAH5iLP0K+1IApnLtFIYfpq/U576Vj9PPvbvB
 drfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrvEdVP7UgFtP+hpd5542nCjNZGSYc/77nFFmeVkdsRqpRgo9NtK2qU9D4WusTbyizInhjNG31kpJD@nongnu.org
X-Gm-Message-State: AOJu0Yyu6lwiI5Mf6rWBbf9X+cA/3IH0RGV2rAGFe6j7KpBF553kOaMU
 KE0WRNPfHr+l5ZC+jnIf6VeHTqjTgQErAD321c0rRfeX6wwncMKCha4gj28Fc8GOxDg=
X-Gm-Gg: AY/fxX7jDUEV3+R7JNbZz+H3Z6WzSn4oGVgqHMDvI9LH5t1YXjqGqsF2aFoNuIDK6Lk
 GQ0wANIK27xU2S6FbnuuFbeOgi4Bk1gE3RC0Ysr+FfLlyfrAyqj9twCtkrbF1IOU/dauaKaPczt
 LuqgAWdI421WGMMjkkdgAgjrAJqlWo4QIf+uYa/WQCMbNh8tVQXfdobXRUu/pPChqaFv2+aOPIT
 rCt/B4uS/9sjk8bNIVWg/cU9qQDvnJ/jL68Q82IKd6xhBTPw3FyQk5auxiQodtKK8kdr97cDihp
 N807vxO6U66LHMaFaI4hruUNOfnohgJneoInODtNgH8tUOYCaOgQj/0+qO2HzBh9MBI9tWfyJxK
 B2jon+Tc5lLZavt2Nr8YFa5sQFsZCIMNQYGxUthjsthHdAvstRwomr08MqtgUkU+qpSuTRuJVH3
 7+b1EXBP5/mIAqrlGS0P3zwWLp8erCHLsCsHAi095Si0AS2BtEvWTaUA==
X-Google-Smtp-Source: AGHT+IFgj/y0UoncA2SuYLgOPW7V1fLfBWf8573vUy7UWdePFeIpdejWYbssVGau/O3VrPw0WnzfWw==
X-Received: by 2002:a05:6000:2404:b0:431:4fb:34cc with SMTP id
 ffacd0b85a97d-43104fb4e66mr9908819f8f.39.1766044600873; 
 Wed, 17 Dec 2025 23:56:40 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244998ed5sm3207497f8f.35.2025.12.17.23.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:56:40 -0800 (PST)
Message-ID: <80397b14-160b-4a87-a0cf-d828f2974c85@linaro.org>
Date: Thu, 18 Dec 2025 08:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Remove stale comments related to iommufd
 dirty tracking
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com,
 yi.l.liu@intel.com, joao.m.martins@oracle.com
References: <20251218065042.639777-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218065042.639777-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/12/25 07:50, Zhenzhong Duan wrote:
> IOMMUFD dirty tracking support had be merged

[in merge commit dd4bc5f1cfe?]

, the stale comments could
> be dropped.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   docs/devel/vfio-iommufd.rst | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 3d1c11f175..b37098e1b6 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -127,18 +127,6 @@ Supports x86, ARM and s390x currently.
>   Caveats
>   =======
>   
> -Dirty page sync
> ----------------
> -
> -Dirty page sync with iommufd backend is unsupported yet, live migration is
> -disabled by default. But it can be force enabled like below, low efficient
> -though.
> -
> -.. code-block:: bash
> -
> -    -object iommufd,id=iommufd0
> -    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0,enable-migration=on
> -
>   P2P DMA
>   -------
>   


