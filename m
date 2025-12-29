Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA55E92FCA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHQY-0004sD-43; Mon, 29 Dec 2025 12:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHQS-0004kI-FT
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:53:03 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHQR-0003xO-0q
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:53:00 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so98771595ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767030777; x=1767635577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JXVKq/HEthezyNMxbCgoWKubtztbF9R/uCreixEgfcU=;
 b=P4+8qSpM1BX4q/gpPXe+Kh5KKfV2D4CR+qsnhPjoh21qqkjUWxxQ2Jrej/pl1Tf7KN
 4BffeiGfTe+UT63itvZewrr/XrrVns5QASpYh3u96aMl8cHzoPK4zPlvrF0ULLNq3bV8
 xG4Gnl1QXnSY/bfTR8eglGWuU8We/DdNtW9zW3fUjaluB7i1l/JBL7DE3HMJlzTN66Iq
 TJftjCk44AeJfR+QH4ywuFJ3bL0vYaj4sl/K540OTi06JCt34sGLVgaatre6b7K1uYtT
 54T28OksmeStzEptfqk5dl0KfY4qIIBzUI3/kPXRBwPSaaEixqn7zDMwqgve+1QwYVCf
 ehYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767030777; x=1767635577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXVKq/HEthezyNMxbCgoWKubtztbF9R/uCreixEgfcU=;
 b=dz1BRj4bI3lYmaBC5yLsDjUhJf1qGojENk/xqmBn3GiDjP5rj1zuJpl/uoqyghy6S7
 0mAouS/NI4JteLPZxqez90KMzIHVCPOUylssDX5XK64u9w1bvV2ieib0SK+Bjqzn2s3i
 hnc9npweaLj4EpUH/jSFcHHZjbQv1coekSbcy5FGngHOEx2n+TL05BeV93DT5KQ/Lo71
 s/yuNPlTSYUXZoMDYqjlmv7Q4bAHTyfXXCUXfmJpJePNPYQCnsxkTVec4ysCQvshuoUV
 YR8ZQbvn02qp34MQiuFxBEtA8QIukOcahe8z4vAS7O+KOF9MbwkesxH7/VvjJzqOszm9
 +KvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUny/C0iavOmdqIq1Ci0xaZlCUO22QZ/bHsbh6x1cNqQfdh1M8VxijUqo5tInuuMoRqSYwGzX1oCFJ1@nongnu.org
X-Gm-Message-State: AOJu0YwlDmYJxC88j1ZcY9cB4taYO/CcETQjJZ33iAvkkddjXVmbUejm
 U6t7FeZBol0y4eRlbjSMjEhXCaSyl1aDWcSm5/lTmAAh/ZsC97Y90TMThX8W4z3/u9M=
X-Gm-Gg: AY/fxX4FjZes5KBgaykpndt0lhJioxj1dfhIKt+NPjnaeMgyyJ3l4LA2VTtZiovSS1L
 IiAJ4nAMC995kbS3TOONIkSMSn81wTeaud3VmQC4ccOX+IgoYMPrhJk2o41g1vwL2YlJgjPWnEE
 QtlSLKwY/8MUbhoeRnZ5dqHjBQDnectVEmYthMOrMuKQBfkGr4ostfm8VNsE7CVbio5m+yOu2O/
 cSNkARf+X2mkv1Lly4TYzTePwR/7yo/b6unZSBYjrrSxwDZWgXvXrO1V/B0sbgS2vJHW19ogJTO
 fPMVpkuqcVSzhtHoO3sCf+aWKDUeYlz0mocPitAzY11f3ea5YM29Bd2T0By/KjM955trzdYiwAV
 fk8pxO4ocEU4+rwJTWIahJGZQbFiPwW3+oCNQdD2SCOALN5M/phzVi2Zf2A2ufqAsQuXnlLiZzJ
 ta2ufIJ92PLOmPzuDqIUd2jGNZ6TwYE5NLAc9w9/bwGFOMvKhacv/20lbc
X-Google-Smtp-Source: AGHT+IE8OINlogN+WfsdC+idVXsEeRftu34+jwS7SuX9GeIq8z0GhKxIEvVbbEonrNhYvUm6LW37KQ==
X-Received: by 2002:a17:902:f70f:b0:29e:9387:f2b9 with SMTP id
 d9443c01a7336-2a2f232bab4mr277428275ad.24.1767030777287; 
 Mon, 29 Dec 2025 09:52:57 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a322d76a19sm229092615ad.101.2025.12.29.09.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:52:56 -0800 (PST)
Message-ID: <bf7b5707-2b4d-4153-9aa9-155b677b6c44@linaro.org>
Date: Mon, 29 Dec 2025 09:52:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/28] hw: arm: virt: rework MSI-X configuration
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-8-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-8-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> Introduce a -M msi= argument to be able to control MSI-X support independently
> from ITS, as part of supporting GICv3 + GICv2m platforms.
> 
> Remove vms->its as it's no longer needed after that change.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt-acpi-build.c |   3 +-
>   hw/arm/virt.c            | 112 +++++++++++++++++++++++++++++++--------
>   include/hw/arm/virt.h    |   4 +-
>   3 files changed, 95 insertions(+), 24 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


