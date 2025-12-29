Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEA0E92FCD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHV5-0001K7-0Z; Mon, 29 Dec 2025 12:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHUj-0000mh-AE
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:57:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHUg-0005Yb-N1
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:57:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso67638225ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767031040; x=1767635840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ptmPtl9PHyVjyFIR9fDjL8hxPyC+ceFfam3bNYTak6I=;
 b=wz+5AYlcFLijUQdnJXB293BXtAxCepRAQhuVIZ2BNz7aNohKgtM6hIA7H/dmW/SyeJ
 zmKKjRZbKRHOuavg4BSJDrETOUvplkOA7zG/5xjUrFWjLznkfLKatuvQdiiGfblrlFtK
 EtGeNcuIXcvVCLfq5Ro8uhIopn4Tb7EN2K0eKcVXfI5Uo4WTDC80uCX0Vq2cfYeaCLZA
 Br3vJvN58wXKHrHV5ELFpV5bg7uPiuez+YaGehZVhpgNApVUnZhZ0z1+PdaO6j7uNkGC
 0mxcvGBLkAhPRHfUb3FyddC41dxbyV94UQUwRez+XSdliyEvEmXToftXbMhwFeGJAlwT
 6AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767031040; x=1767635840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptmPtl9PHyVjyFIR9fDjL8hxPyC+ceFfam3bNYTak6I=;
 b=ES7N+ioS4q9Urc9/HzabJtZgH4s+RoLiwv17eWMa+0UYWTMP5gMm2lgzlNt8ofIcr0
 4+Dk1qT++HX5nWcaktQAtNK7DP4onoZ/JzzJb8Ev2j9Tfu0qvksFyq+zjjhrwUnSZhC7
 ZSWRWAKjvzFTQMt69rzBnIvmNcJkJ1m20a9EWvL7QrMqhQYmxlPOtDY0MEELOjbhg4xp
 bgRxT/aDioP6DgPOBh5dhYYoPZ2OB+Zuvbrf6k4gVVpyEn8lVk88jWCuuN9Cgz8LuOjs
 L2RRNLlRXAPSxP6RlWXoW0povTpQTqF7JSvV3LsF+ukEmhHyu/ZfiydlzN4epB7guHJO
 ROjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcG3G/gY1K9J4+C53G/yoTI0ifCTMPZo2cEHAYwR2r9wewUmpyv4tKzw+Pu/L7hm1sOXbhBCYqHXjl@nongnu.org
X-Gm-Message-State: AOJu0YzfP/BMu7yOykZsMghRCTq2rT2a7RcmSM2jTXyEgjnDX1GyQEhR
 wZEgZTkLjvqrzE/WqDfXLFWIaxWxYEyIYqVXivf1iw/j9w44UMwtsvoPQnYe3uNblmg=
X-Gm-Gg: AY/fxX5e5Ev7ylEH+Hig88XbmLHBAEA2HWehFkUouN5VLtVCtsAxrIEW9vLYJBhSrMg
 K8eZrYndmsHEYTEWnaUL2Dvj/7jAZVNjHRXI0sTuOOaC0Lv4+Pa5E7t4VNjErSQGN0pDcwEOsXy
 hNdhOjjn2r0HFWXvb1vdH294VuwDMZnTykYh7OBJlb+Ywt3zU04ov9A97MieJ/wePUznFlGQBo/
 OoBFEqHXN8cgTJ6DDB0Hqq+f2RmH5aDhsQoM9vl9ZWTSu9q3h1dOqPWy7vabGBQ9hlEsckWkuZ4
 34LCYN+InMY0Of5GQCqDLWoLvF1gf5+AD7ephDoktEf+beJLAGlo0t5cJTooi6YSvfkAKBAtXPT
 TXgwetlm7FEMReCvIJlkb5nGKPEIRMnAMIyMaxuqb+nixq/4kjFBHk/6Wa7wfXkldlY3RagOa79
 8cnytwE7r9ZySUl/g5MPGJIcdCy/NcpFG9KVHAxS2B5p0iWHKlxXMjfbRj
X-Google-Smtp-Source: AGHT+IGTwUkOJN/s6/eauxTisj2JxoFXKlUcBqUfGxRUgkjrOrbsTX0al3QtAi934g4EBJJoQS5haw==
X-Received: by 2002:a17:902:ecc5:b0:2a0:e7e0:1d31 with SMTP id
 d9443c01a7336-2a2caab9181mr388381665ad.11.1767031039524; 
 Mon, 29 Dec 2025 09:57:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e7720b52esm13647124a91.7.2025.12.29.09.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:57:19 -0800 (PST)
Message-ID: <04228bf4-fdcf-4f4c-b2dc-3279ae5d2e9a@linaro.org>
Date: Mon, 29 Dec 2025 09:57:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 27/28] whpx: arm64: add partition-wide reset on the
 reboot path
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
 <20251228235422.30383-28-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-28-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> This resets non-architectural state to allow for reboots to succeed.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   include/system/whpx-internal.h | 2 ++
>   target/arm/whpx/whpx-all.c     | 2 ++
>   2 files changed, 4 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


