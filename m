Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4351CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBot5-0001tE-2h; Thu, 23 Oct 2025 02:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBot4-0001sz-7K
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:33:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBot2-00010s-Cl
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:33:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475c696ab72so2906055e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761201201; x=1761806001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ff7PfSQ0wkoWpNQv4p5aLpKLKdu8ewPoFgQTZ2hoY8=;
 b=ZDOOKjdLizYar4dlH24/0YBFovMI5Qk4gauofgAvnb5fKq4ykfYbPvriDhhY8S3+GX
 7tpozWWzGrieCY5PziynU6XZDIuQ7eGj3R1Ksb9OewKZez8h4sM+AV8h7hmUEQD0i5Dv
 PxKOZ+Dl8tP9KrHI0KSQE0W35GETKV1mXVhioVrul9ma7FJpTz+zZLrq6D+l9QtAaEqV
 JoYkRNFiEdU7gS8tjWtU7zNT/juUm3HUNkpa+fnF8v5Z9w8k3Zscyf7thFU8lcQyU9Wa
 OzdhAQzAHf2ThuqlzScpgT8o+eVSKG1e9h9kK437LPOhaHwfwvOenatXOMvoROSBNfH5
 1Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761201201; x=1761806001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ff7PfSQ0wkoWpNQv4p5aLpKLKdu8ewPoFgQTZ2hoY8=;
 b=QUhlms703+r0DbeEs6PXg1dXCJPqjRCPc7R5QH79abh240D1JZcEG1nsIlWZcHfxvA
 kfygY76fBtLjYNy+McwPBg6gkzpEZsLMdjucjBtxRRi+VDli7t/TtKDXMm98xTA4I7g2
 aV2aEv7FNmOtcvxKDWrdpO8k3rYuq9yRrKc5xpAwZWEbzoHOCrfoUavnVycMcpLP18Tp
 GxV5zWrTswOVDLwenA2sriQcjM2KIuhDyHuEUjEASbLQw1Tyf4G+Limdly/OVRzjmRRT
 YgomtPkdKisiU89rFdz0Dc/ToXoeJLCZd7WJ2F++aka/l7Gwai0hlaPxLTuFkj4AhsqN
 I+AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtHYwOcTPgOhCJ38gKKI1wENgsawLIGQOZZrE2bivYqrr8J0XYoYeIQEkwQ+mXctIDSr5sa/mfv1y0@nongnu.org
X-Gm-Message-State: AOJu0Yx+rdozbw53mONiOedTLaw5OW3KM/xkhB9CaU4m6MWdI+mVXwqT
 QIiYood+5HYU1xEmRf0uj9W0jn64OEZkPcqW2pMj4q9y0kHJTvqHEpyiKovM886zNlQ=
X-Gm-Gg: ASbGnctncbNUQlZqT6FChjAZShKjpqzCnEIgYDmpFidMRTqdHMCLXet9CPQAZy59sAe
 X630y8RG/cODkpezBN9vv0kjkPJ0JpaKHXcjODxCqBMY2jELQ+5s72eBpwl7FuG6zBUWEnQvMN+
 anlHYzwO1XVwxKvfWrQqctj9W4GubAAybT59e1uap89mkmopDwXv0IGzg5Xi3xp7JLV8yRQXeVF
 WTU9vJ1aHzntbqI98/2/BiGd7LSNVcyaH7Ja4AcrDQNX3JD4o9cug1oiUYmr8vSM/Wv9TWwgzjH
 qkXcGeqh5iPraULEe4Hxkc9PQhGOI0fC5jnE/G4t7h4q3G6eJQdJ9gPkW88c/MgyXfmu8F/x+zI
 nZgnz2nr69MRiZncxATgLeMkuhdvow/Ov8VsuzpRFuLAV6dn2FJCWdS5Xi5xSjmdYeyzJM36WYT
 Vt7fogKxdslaq58p+Zl8bpcRBR7ize8N/5ctbCiYAjntE=
X-Google-Smtp-Source: AGHT+IGbq5fb4QT+zslQbG5MqZR8ogFfVH4hjbhlhQ6lk6rqp/EFinhN1cNJguTTIBijZ7hLFbrecw==
X-Received: by 2002:a05:600c:1d9b:b0:471:1702:f41c with SMTP id
 5b1f17b1804b1-4711791fa29mr175099395e9.35.1761201201567; 
 Wed, 22 Oct 2025 23:33:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c14a26sm52354695e9.4.2025.10.22.23.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:33:20 -0700 (PDT)
Message-ID: <60cd413d-d901-4da7-acb6-c9d47a198c9c@linaro.org>
Date: Thu, 23 Oct 2025 08:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-25-mohamed@unpredictable.fr>
 <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
 <6982BC4E-1F59-47AD-B6E6-9FFF4212C627@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6982BC4E-1F59-47AD-B6E6-9FFF4212C627@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 20/10/25 12:27, Bernhard Beschow wrote:
> 
> 
> Am 16. Oktober 2025 17:15:42 UTC schrieb Pierrick Bouvier <pierrick.bouvier@linaro.org>:
>> On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
>>> WHvGetVirtualProcessorInterruptControllerState2 and
>>> WHvSetVirtualProcessorInterruptControllerState2 are
>>> deprecated since Windows 10 version 2004.
>>>
>>> Use the non-deprecated WHvGetVirtualProcessorState and
>>> WHvSetVirtualProcessorState when available.
>>>
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>    include/system/whpx-internal.h |  9 +++++++
>>>    target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
>>>    2 files changed, 43 insertions(+), 12 deletions(-)
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Couldn't we merge this patch already until the rest of the series is figured out?

OK if you provide your Tested-by tag (:


