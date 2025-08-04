Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65579C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 20:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj24q-0005fh-0y; Mon, 04 Aug 2025 16:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj24o-0005ec-Qr
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 16:46:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj24n-00068X-20
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 16:46:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76bd6e84eddso4685717b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754340391; x=1754945191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/8Xq9WzDvD9kRRu1PHcbdxvZLPuKb7oGtbE0WXx7GE=;
 b=txKnHVlSoPQBVK29DdfaV/87Ay5Ibb8Vv08CSI/1U6V5kQpDQ4ngJ9viFvhV5grhs1
 4liNueBWGS2N/TN0UNgzqkXwGYtEkqPwh+GBL8IaC8t9terHSgXslZDZK3argp8C+gZS
 R7EXf6zSmHiHFRMSBCmILwbofsSComfSuej9YeNS3cudP/oPGAoKWzb+z2/BhysI+5ct
 zHx5KwXibzQDGPjNs2/qAIRU7hcyy05xQ8eGzSM5ErVAcuXfNQuUMGsAVqL4ayN1NJXC
 PUvd2TCNf6MzFLDqNkzKXw8bF4P9ujIQfRTSm6CDw1vvhFNsKDMzb+JsDNIDCpl5NAUd
 OEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754340391; x=1754945191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/8Xq9WzDvD9kRRu1PHcbdxvZLPuKb7oGtbE0WXx7GE=;
 b=kK5mHwDjybxvWcxBIMd32GRd2ZlOVfNMD3FnIQlZ5T6ITPQUx1RSoT3F+9vkM53p4C
 aLAyIb7bfxbLutZyytp8aSlWjHJGMty85Jadmh3+3d8UUVpuNDeWzc7OQ3sVRaj3DAMn
 PgM4Z7sggvola6tsQN6yqzmHNXAN2o/ThCZdB+Fm1/QyjwJEZUwgnrpmjXdQWJ1gnx+h
 HXs76MGma7dmg9wcB5vU+MxwABoGHN4loQr/uauaiTeonscarGh3ZVfn24j3J3m/0ylt
 MPyQtX1PG9X1M65005n/vnMMNvtapYxRmYeUaOvThF2eZkoHfirPaWGypz4b8P3ArJN+
 XlhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEBZfVUsxAnDtyfAgIXyofzE1uSkVST998GDQ4Nb3fdJSTPpWdX5qAmbpO38WiE51Nh3IvzHAU40uh@nongnu.org
X-Gm-Message-State: AOJu0YwZjyq+vDyx20ztloGjP0ixuUseIudFBMrRKdwPRm1A9I7nA8CR
 IIEOBVsHT6S829sW+obBpI9sovXLVmnmShIQt5olQJ3Vm8YoCCaSPZtA0Hk8M9SRGdk=
X-Gm-Gg: ASbGncvdDG4JlfvFazPHIucAlTvno/zYqZgWbn7WcD1eZPuivs9Badw4z7Uy8R96qUx
 tjzvJCISniCcc1E7ngGRFFlOMs9lcDsd3hlbS2QQQJLj203YWIVq8n2HIVzvc50E5U0ujbnIFpi
 aW+bUXforAnKWNnJvpF2uH0wg+cnS6Fg8k9uf+Zou4se3lc6FnzwbhRJjxZi95+nGV3N6HyK78I
 uKEMgr2BWyZBsHzdvyNyC76ph1USbCdfAO4GIL6eizvPXpujtPg5XeOBuB9KOFUnHIMhKPh0my9
 el4FwN4sy5I0Iq3gETKSs8U5v0WF2xpjBLdZENqPoJONPYkwM0kgMV7Z+O92AFY32GpyicUU37k
 lTUiAyG0+Yv4UNrT5/v4QpqJvRYoCKZs5tXM=
X-Google-Smtp-Source: AGHT+IEyHMVmjSi81x+xhFtBw8N6ZkcWKVB6xGQqZsjkbf3eogjExMzX3Ofc6TW1/6pYHCxxt2hzNg==
X-Received: by 2002:a05:6a00:3c8e:b0:748:2ff7:5e22 with SMTP id
 d2e1a72fcca58-76bec333110mr12397182b3a.10.1754340390956; 
 Mon, 04 Aug 2025 13:46:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bfaf78c94sm4634621b3a.19.2025.08.04.13.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 13:46:30 -0700 (PDT)
Message-ID: <ffe8d7d5-793a-4f1b-ab92-4aaab49b2b3a@linaro.org>
Date: Mon, 4 Aug 2025 13:46:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] whpx: arm64: clamp down IPA size
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-14-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-14-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Code taken from HVF and adapted for WHPX use. Note that WHPX doesn't
> have a default vs maximum IPA distinction.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c               | 32 ++++++++++++++++++++++++++
>   include/hw/boards.h         |  1 +
>   target/arm/whpx/meson.build |  2 ++
>   target/arm/whpx/whpx-all.c  | 45 +++++++++++++++++++++++++++++++++++++
>   target/arm/whpx/whpx-stub.c | 15 +++++++++++++
>   target/arm/whpx_arm.h       | 16 +++++++++++++
>   6 files changed, 111 insertions(+)
>   create mode 100644 target/arm/whpx/whpx-stub.c
>   create mode 100644 target/arm/whpx_arm.h

Logic is good, and should be safe on any hardware.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


