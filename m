Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE1CE92FCA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHP8-0004QI-Ol; Mon, 29 Dec 2025 12:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHP4-0004L3-Mw
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:51:34 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHP2-0003sw-BW
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:51:34 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7f0da2dfeaeso9957588b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767030690; x=1767635490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p+436XRNbTzJRavV5d66W2uNYOAK8m1ou4UvIqQXOdM=;
 b=McLITGYuPpnQauxcTFwDI5OQjZBZYxAenOvLtduWQoUx9VoRXT6Uat45gJup1fKB9W
 vPg6VMFyDQNrc5Jj/QMflJrlChdNy45snmmoy080x+dUsoYm9vW3n7P00i2T2RonUR7Z
 1FBq9RQWXAw/2SX5aDOneiMEBIrdFCSYtNzB+CCagdgM8GzYOrGoj6LzesXETw91dBX+
 +CYWJLMK5jYuxU3GdfGgW9iKMozJVDY0YqucCTh5DEs2TuyZsI0ogaCG8a0xOKvjFjfQ
 cYu0rACapxm/FTQXsU1XWWfuvyDRXe8L9swNPdOgEJJyxC0Zx/DM6UuqBp/w6Zo5bVmb
 xxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767030690; x=1767635490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+436XRNbTzJRavV5d66W2uNYOAK8m1ou4UvIqQXOdM=;
 b=DIejYy90SUDU1kmrd3+IhrTwH7bvRyWViNVcUE5NfcQgW2LRhWjcBL2bYzN0fvpicU
 gPR8N8RFSM3+Xj7jcv5rlUIEI/+KBX2iTKlE2z60ZoTp5+rJo+NY5lcGjPUVKMos8YU1
 mv2G8ZAZnpS1ZO9GPFp+bxMH4WaRRLJHV1VplT15qL5jarvOCq34N4idHUMdzz9Vfszt
 b6i0WjNc4V5D5AJYKS7ehx8Unbq/OELU1fJubQTjp48QRuASJp/yeQKQhJS9ADZ3ukhM
 FnhDncXrIpcw6OPXC5OQx87ijbq/r82VZ6VuzxaU58CWrsEc4nxL/Jr7g5JuDYDDk3K4
 vRJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC/cw89ACCyrr+AmJkSWQb33vyc2xdesjPQ13VtxJd2mh9wwlLir0Qqab2qTNFocqd1n0K4aQ86MAo@nongnu.org
X-Gm-Message-State: AOJu0YygRkpIjQd7awRGqU6WWlmBokRdL9Ug+uoYde93OVgnIP28JuxV
 GPTD+vUIMzfMINZV9qk6QaS04SlHnzaPlrBoNTb6ZwptbnyQi/zf3bbNgKSY5RlpLJA=
X-Gm-Gg: AY/fxX6pFcaxSqlDsoWPJr+2P0Ft4XVddDNRJOmo/XdpszMLYcocOS12cgKhNnF7ssH
 9PQLiH3thcvirgoV+l5c53vMth75o3PMVaQU0suARAQ8gAOoRPDemHVO4AqA5CCToGybl9t0Dxf
 T7qOPQ5Ha2wRFW1h2EJwkAxA8h3tnhLmVnDPPfPjF128jcI9zz7vaCx5bE+dAEb6APl3iN3kwxf
 FAdsxcrYbvazDhq44gznr+pqgVnNvbQHKYaWzs97KGB2r3E0ZRaB7heQ912AzZ/UDyyotd07I7+
 ea5HNhuhf79vcWqwSYpTD2KKVu8N2laXhTBVabTfE//lXmUlz0TEwAkyNZn7dPVwZO9kMA+z0cz
 kLkmEQgFE7KM7Zxv4nhsXS7MbpRmdVvtQ4Ho+tdlHqQlYAKx3ipew+Bzno608WEeuN5MJPm0qYb
 oVa4hOYilH3KwxFQI2g7jFL1sGShAZCxBSFHAzW1/WSvMSdLo0crDB5BtawKT0sQkHFho=
X-Google-Smtp-Source: AGHT+IEu0SutJzP+BJb9bkVvZemWlptXnQ4xXCFNyljFOneNGXzzI2JU3qSyIt8+37F0+y1bh+ecyQ==
X-Received: by 2002:a05:6a00:44ca:b0:7e8:43f5:bd11 with SMTP id
 d2e1a72fcca58-7ff66f5a163mr30881735b3a.38.1767030690360; 
 Mon, 29 Dec 2025 09:51:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e792b65sm30541530b3a.58.2025.12.29.09.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:51:30 -0800 (PST)
Message-ID: <f597965d-feb6-4ecf-958f-b299632811f6@linaro.org>
Date: Mon, 29 Dec 2025 09:51:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/28] hw/arm: virt: cleanly fail on attempt to use
 the platform vGIC together with ITS
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
 <20251228235422.30383-7-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
> Switch its to a tristate.
> 
> Windows Hypervisor Platform's vGIC doesn't support ITS.
> Deal with this by reporting to the user and exiting.
> 
> Regular configuration: GICv3 + ITS
> New default configuration with WHPX: GICv3 with GICv2m
> And its=off explicitly for the newest machine version: GICv3 + GICv2m
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt-acpi-build.c | 15 +++++++------
>   hw/arm/virt.c            | 46 +++++++++++++++++++++++++++++++---------
>   include/hw/arm/virt.h    |  4 +++-
>   3 files changed, 47 insertions(+), 18 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


