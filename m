Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AB4C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj46K-0003JN-5z; Mon, 04 Aug 2025 18:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj46H-0003Cw-Pu
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:56:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj469-00009q-Fc
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:56:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso2902089f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754348164; x=1754952964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XdpxGk4t+ozvUDgbhAGwDmnLk7TQc5J+/viJMdYyp9w=;
 b=QV/NunbewLOagGC1A+dHfjMXdexE7/5aiUIsxBiFPtsb0Q4L1R2gpBh9yJ3EJAZiIT
 V5Bg32tqCM6Dk2qHCPUHsAhItWQFlSDol/Hc4pmdu8NW3LEIvNMizHu+dfqrYsJ7wzOf
 sXKFlwLKUYqSgJOY+KTeNzAMLO6SrgAGLT8gj4L4BPiSj1zdz51IHfus9p/k4ous+GUI
 HwXZVXXYZcXwmi6+FO+bdV2g8ZCppVJWV7CD6CQcfcLwtSjGCwXgq83/iHK7Nv4uruFj
 ZNaANdlfamHe1rpeyfhCExM/AoulpXWXr5bLfC8HLFNoBqTx1m5ZKKxbYUj7wajtoU39
 npIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754348164; x=1754952964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XdpxGk4t+ozvUDgbhAGwDmnLk7TQc5J+/viJMdYyp9w=;
 b=TdPjwT4QArELtonnPIC9qPvC+Tf2nEmmPbUeVsqXSYw1VpD9XSw/qjbia/cGikJOSL
 QBmiQpIh5tgzlBp1J7ngt8P33WTYbr0863IZDfmM/ePiBtUAaHUkFEp4kHeAolyM/E5A
 hdOiEozp38BKpc3CQCXhcx4wISd5EVzTdGrU9/4pqgdEwvQqTZILSCHJs0Eo4rkQo35J
 yteFE/S1PGpRR+A/8+jR3vdTFZKkbYTePKlohVMvwyq/P86nYKkNFoGvdELgA1cBz+20
 yW2mfPIS3yJODGIcqvWSt9ProvgiCIQF+7p776nxgSdnQXq5241ptVyO9JwcwACRk3sf
 NMNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgiZc4QZsCkt8OwA9GTpBgpx9XGunHo9ExkKLL4V3DyYgjO0NU+OXYAkqDmyZ8/xiZ+hXDM7XytHKP@nongnu.org
X-Gm-Message-State: AOJu0YzHBtBNlSeJOStIMluJu85itn2iEpvyporMUse0qiP2aQ4mDS8q
 7n2xQUL6Wb+eruclVktuwxMs0G+pRAqtJKsdSA9HMX4zQqzwkaJBd2YsChD9rVpe2qM=
X-Gm-Gg: ASbGncu0IDsO4Lel2DDYkeu8v4NAVWY5K6FfMJzNS8CZA4FAzZH5yScmjCWBcWMKMvv
 t9YkhwjuXoqyKFpfieRjn87j9J4scaln9Trkg4BclRIdqv/5sztruonfWJDW4TvmHzCrKFbq9zB
 mguve4yqJUqu3yst2TnebuOF5IJP/A7NdqZc2cP3JBEQ+ilDlY49liAWxT39NEZ4Fa9T7xg32Vh
 eHVxJxTaONHD4rHZS7SZ9Ts9lX6DzVxfxJTu2Ns5cdlSNMnn1ACoE1Qt9lyQiLou8ajum+lNRng
 HDlHEz1JIYG/WxkRzqEaw5SOvfCKNuobYQ2dXgoivPmIv8dbHKdS9U/CDQNzCd9hShjqyU7nWfL
 rxq316mb+I5emvtM7Fm0E56zIpLiKjpjMcEVaEOSOGbEll/D+A2S6POKIIms5lllKSg==
X-Google-Smtp-Source: AGHT+IFznGq01jDCILd6ZulN37dfynflrK1XyeUG3xRI7nT0BJifc4JXD+E7p8Rnxk+wo3foCym9SA==
X-Received: by 2002:a05:6000:2a82:b0:3b8:ebfb:4592 with SMTP id
 ffacd0b85a97d-3b8ebfb45e7mr487660f8f.55.1754348163778; 
 Mon, 04 Aug 2025 15:56:03 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0cd2c90sm12240625e9.17.2025.08.04.15.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:56:03 -0700 (PDT)
Message-ID: <16f2c007-8b84-4b44-b0a2-25b61c7cb3c3@linaro.org>
Date: Tue, 5 Aug 2025 00:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/17] whpx: copy over memory management logic from hvf
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
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
 <20250804142326.72947-11-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250804142326.72947-11-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 4/8/25 16:23, Mohamed Mediouni wrote:
> This allows edk2 to work, although u-boot is still not functional.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c | 201 ++++++++++++++++++++++++++++-----------
>   1 file changed, 147 insertions(+), 54 deletions(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 86750c304d..752a57170e 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -258,89 +258,174 @@ void whpx_vcpu_kick(CPUState *cpu)
>    * Memory support.
>    */
>   
> -static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
> -                                void *host_va, int add, int rom,
> -                                const char *name)
> + /* whpx_slot flags */
> +#define WHPX_SLOT_LOG (1 << 0)
> +typedef struct whpx_slot {
> +    uint64_t start;
> +    uint64_t size;
> +    uint8_t *mem;
> +    int slot_id;
> +    uint32_t flags;
> +    MemoryRegion *region;
> +} whpx_slot;
> +
> +typedef struct WHPXState {
> +    whpx_slot slots[32];

Please add a #define for this magic 32 value.

> +    int num_slots;
> +} WHPXState;
> +
> + WHPXState *whpx_state;
> +
> + struct mac_slot {
> +    int present;
> +    uint64_t size;
> +    uint64_t gpa_start;
> +    uint64_t gva;
> +};
> +
> +struct mac_slot mac_slots[32];
Ditto.

