Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC4E92FCD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHV7-0001Ra-EA; Mon, 29 Dec 2025 12:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHUs-000127-JV
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:57:34 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHUr-0005c1-1v
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:57:34 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so9207934b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767031052; x=1767635852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Xy+8eSeOzDb+k1YRCc4hfaw3xrtM1K2VyUwOhxg/MY=;
 b=Lc9akelTnEcvd0y9hk8Hdi36QBA3uZrJz+b06Wz9myqssHwXHKezKkm2bJvKpMWM1z
 C6EvoywgIMl/4WkU1geWMYMgEop/Yzk1EOjZpnWbWk3Wd1JejFD9zzaxtH97UMjBaEbv
 0yZbWb6V2TWCBJhgXLos1oJ0w+IBmq2aJOXwcJMuYxAdKohbKhpL5UnSG9WvOLS3LozO
 YQ0ucCxR5TBnG9OBoZi1LgWf0hPIksLd7iW8jTnPvbRQ9KINoEZap+/rf3Luf8ODxRz5
 hlnqwSk4aAWroxhLM0MBX5u5/V3qaSZbf19pl1HPMtbWsLRjNDS1iT4pdgYngnH6JjvB
 iPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767031052; x=1767635852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Xy+8eSeOzDb+k1YRCc4hfaw3xrtM1K2VyUwOhxg/MY=;
 b=ZToNlWKIfWpR7fz7lRazULnkvBzIpUZpbFkoBiUfactV7eVscJSWFlj4Nh2/O32eFT
 rtdpFInUY9K/U9iUqhGLwQpkZ+6+D0exnk5xFqV33fn65OfPudW6k/QpVTxp4YHmC2cc
 nFrJjURT0gVrsI55TeYu7Ro1budEcuRpZKV/CtBrU331iUIr2wwTkAs0298CrcJNDd7I
 dOxO793o7kuD6WwDWj2ns3gorImcpcWmr4hHKuQ9ht8VXhPIN3/JLnO461SCJJN4jqF4
 naoOMipuAqL5F6VOyP6G4bX1jg+niU6LQy9FgRVrqKVJ7W9L40Va43Iw6ETo11r0dh6t
 md0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTTtInRMTVO2raLO4Vx7Gb1WZj9TiyKScLMMPrIoOWWbt+0F9UCSXmz9Rs+yrO+iMD+NrMDvVCoRkm@nongnu.org
X-Gm-Message-State: AOJu0YxehRf9RJdteS11759DIhTw6hEFT3km5TBuw5EQD4J5xo4ATYEM
 nOQSFGrcZBQLlhrY5v4RRSe+vCzjFbeSPCErJMlaPt+QwL4iPf+wqaMoL/p8N3b97XuUD/OnFCD
 yZTtU
X-Gm-Gg: AY/fxX67Rnm4IhrL2WKbGPGWFY5Kmw/x4QxQsbmLVU5yUaQCosMlTerk4k9NBeIvqLu
 r4LduIYOsc6Q0sEk2F3R3+E1bGfimFVxR+RZ3juC4Z4tei7fmfCxNMQauJKiTlGci+WNnGkDGbu
 Z2AyEx3z7CEVMU42IS78i7Lq3t35xVtsFGGxB4AWE0Fx4qubUOhvQce7PGSy0EtqRXzwpLVWmv9
 EhlpQcAzVNv5QMPYB05EkeONxNyERQtaIFAQ2h9ekv3Uye2a4EMvo2v+qWk27zUJOTQ02Onm/pN
 rojN1eQWEcQ1ryy149CA/BDbeg7yS1eNjiPrNsRcY5PPV1YFwwq7WPQjsPUmPXh/qX9s8uN1BhS
 mnt5n5FhqfCuY++BBQ8uC36xaNMZHmLYDTM93QTRvfNVnaCpjzlDtSJrMMisftefCevusEgnqtF
 2NHZmPEpVLryPJOdx87herLtSkG/mAu1C3FKb4MXqzAxPZpTRxiPrU6iHG
X-Google-Smtp-Source: AGHT+IErFKWWqm+GLSQDAJjT1aQGL+KgN1/3vWXPXUMO/eDX2d0jFCrmaASWq0eJP9PPGU3CkfNm5w==
X-Received: by 2002:a05:6a00:39a1:b0:7ff:9fe7:9811 with SMTP id
 d2e1a72fcca58-7ff9fe7a134mr25809392b3a.31.1767031051602; 
 Mon, 29 Dec 2025 09:57:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a843a18sm30285572b3a.14.2025.12.29.09.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:57:31 -0800 (PST)
Message-ID: <3dac03d3-e87e-4ad4-9fad-2c247c10cd12@linaro.org>
Date: Mon, 29 Dec 2025 09:57:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 28/28] MAINTAINERS: update the list of maintained
 files for WHPX
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
 <20251228235422.30383-29-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-29-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
> Add arm64-specific files.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


