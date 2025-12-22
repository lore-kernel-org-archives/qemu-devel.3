Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114DAE69166
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 20:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXm8M-00077x-1P; Mon, 22 Dec 2025 15:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXm83-00076l-S3
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:03:41 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXm7y-0008A6-S4
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 15:03:36 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so3782688b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766433812; x=1767038612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok0ugNyWju9TPK6PSDFMdAHHtV5LAbGtjuQGMn5dUdw=;
 b=X2/dHMpTuA8oiTYbJJP4SBmWUXAbPMLaxdL68GupqxZnBv/eclbJnCScMPd0v4Lo5g
 4Zv/IBiaqIk0rRQaiy/PdnzC+SdeteS9MhKqxBl6XzIluHAxn8ZTmQaBov1OJrKrAgI0
 UGULYLZq7vDGEf2/r/Z1/0GmiVhOV1EZHp9JwAct1BcUacIO1ocKJB8eU+EzQIZM3Non
 BfVIBnNyaSpHxdK1dhrMCGcW6Aw7nXJ1eU4A+R9Pdong1dKtKwo9voNlBI4+MZFPsOr2
 eS5LOfJ5/JIay0f6AAyC4L+qcheiX9TRbmS87pmOuAImhl0E0CvlnvMmsBFT4rfUEcCV
 O7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433812; x=1767038612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ok0ugNyWju9TPK6PSDFMdAHHtV5LAbGtjuQGMn5dUdw=;
 b=TMU54fY+jIZRbgWtfX6WzCBheJZkS163omgQXa6taaROmdfu7nxDNVvXgFqfcf4gWf
 YP22/okC4t/VJsKvOQRurlNkjyiod9X+HG2iq5Xy7KdFTO28U9fwSToiTbYM/jMMkDCC
 /rsAkCgveVBi3yRoveVCUI6Dbz9b4VzAhgSWqXFDpGiKFY0mUO37bq9s88QuaSbNuLQp
 j8zaRl9kYggYki/J3FADhKEzQuBzxxb9tGWGZKoFYGvhDPyL+FgUBRn9K4D3TWXHBIqp
 Z0WzKzitFhmmBT/zCKQ+xmtkCsk96R7Z4aOjZfRBUWlsa9qAXj492KgatlWF1N8dBRo5
 JHNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY8f2oOovDP7IPf8X5Snr5uQ2H6B8ZC0rymQ9dflvWAS7oKmLmd0/Ox4oF5dBOlxAI3/hfwhrJmiQk@nongnu.org
X-Gm-Message-State: AOJu0Yx3tXfDku7c6SKlUIdza7X0O5f5mVR7fs76vAYRTKvVjtkHimni
 zQhhFkRgHO9A5zUg8O+z2EQ1Bq8He2Esae+d5xTefvMHZ2IAzsOVbYsxVljfN2PyZe8=
X-Gm-Gg: AY/fxX5Oyw8N+QoMSpotalneOI3w93mwfQo49E4Y71Cg2vtD1OkN0k5CF+Vo1UKfg/x
 yspnqZ/eTayL+p5SzJi7X2MP3lZcypvDk9SG4q3C0I20vYv3XyXVjbigJe4n+byrwe4++9F5cBx
 ZESGJaooP0dIoVxz7AKnMRWSYBEdu/Hg0HLzeYC8lRUDP2QdMTA5IbsKDo1lxJbb7GkSPcoIuA8
 2/xKG0CO5k2vQdT2uXlQM2Zg9qacTJ/L61DXK+KQw5O3SShZceBobNwZZHv/9dpwbpc2EvGacXz
 FnlAEH5I/d90KJmLENBqq/LTZr/8CE3MZxRtjU1+wLma2M9eKk4n7MsOhW0vCxCMSdGauEJDe86
 l1B2E4pl47a/1aETPnyW4AQu9zhhck1WD5NIaf5Xc4RFrEgmLfc+eW7hNZFHDbOY6iwmPnnHtlY
 5VNd/i5/Ls2fPcfgJjRCljk+QCW3h/s9xWCqPbgEyEiWyPTUzZOyvsnxU=
X-Google-Smtp-Source: AGHT+IEPku4UK3TadgSCuycN1UqIebi+VLJnURye5V7TiCuOIsePDeVw8+kd8vejeDFdqacF+vVYmA==
X-Received: by 2002:a05:6a00:1f03:b0:7ae:8821:96dd with SMTP id
 d2e1a72fcca58-7ff648e6113mr11091997b3a.24.1766433811813; 
 Mon, 22 Dec 2025 12:03:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a2e3esm11107066b3a.37.2025.12.22.12.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 12:03:31 -0800 (PST)
Message-ID: <cf1b43db-f6b8-4bf8-9421-e27d32120552@linaro.org>
Date: Mon, 22 Dec 2025 12:03:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] plugins: split init_hook into create and reset
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mark Burton
 <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
 <20251219190849.238323-10-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251219190849.238323-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/19/25 11:08 AM, Alex Bennée wrote:
> We need to move the plugin vcpu_init callback to the reset phase so
> all register information is available to plugins. However so as not to
> complicate the initialisation code we still want the call once to do
> our housekeeping.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/plugin.h      | 19 ++++++++++++++-----
>   include/qemu/qemu-plugin.h |  4 +++-
>   hw/core/cpu-common.c       | 21 +++++++++++++++------
>   plugins/core.c             | 31 +++++++++++++++++++++++--------
>   4 files changed, 55 insertions(+), 20 deletions(-)
 From our conversation about GIC registers not being visible at cpu init 
time, it really seems like the root issue is that we have an external 
component that should not be able to dynamically define new cpu 
registers, and that cpu should deal with it directly when creating its 
own registers.

 From what I understood, those registers are defined dynamically in:
void gicv3_init_cpuif(GICv3State *s)

Any chance this could be reversed in terms of dependency to be 
initialized *before* the cpus, so that GICv3State could be passed as a 
parameter for initialization on cpu side?

Regards,
Pierrick

