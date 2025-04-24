Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD18DC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85I3-0007N0-LI; Thu, 24 Apr 2025 18:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85I1-0007MS-Lo
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:43:29 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85I0-0003Kf-2d
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:43:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224191d92e4so17916175ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534606; x=1746139406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DO1iLRdXS8iCrUyV8+03uKliCI06TJM2KzdUytJO0Bg=;
 b=yO/r1DIzeVm76RPaRoTPtAFLkT0dtpRDhG1fRgWiihfl0zOxi6w47XCp/d7h7y6sFb
 VD7kU54jMIq73tbJzsxR+GLIEZSa9eRtMio3sKScZKnRK2eyJbmPOjxVgR5fkaTbc3E+
 pzVixgkbhZHSDsLIUds3lbZU6c2oikQXNAwmEFT9tyYbSTzeAtrJGoZt7IMO7YC5hhVU
 HNykvOK2Zr980u+LkfsdMFQjB98YPWB0ECE0BC34RisYSLwAnktQgm0UQCUANdUsSD69
 2OeRFVpEy3vBDjOMQGgN6RzWG80U7C+M59T6ZvzCsI3V2xGxNSl1Gqb+X908UbAs/bVI
 +U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534606; x=1746139406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DO1iLRdXS8iCrUyV8+03uKliCI06TJM2KzdUytJO0Bg=;
 b=OeEDbupJSUKgYj/sDXNNOQWZqIzxWS0iikZZmV1K7RVlGR9nusivVkACqZWMYYioY8
 Km8S/QoiCAqbOQhsv8FNCYw4OlIkt4Qp4J7T6j3IhdqDIN/K1tTtGfzsMmn3iMnXrRiS
 hZ46nL6qdirndMYNJdgZf/T7JJV5bEORLzPVtb3gc8FnUrISrw9PipYrTrgmwj+Hnj6T
 I/gGc3/yYsUYkPMnWq1jcXg3DPAQduHZFUqT2IuOrnkX7wtuh6MJjggVQsYnGGfvMdRi
 1i3tcGDXBPKA6qN9laYfglqrDlysVhEay2BNIIIRjuJw/9JLm0xaQsoQ3L5fcc2HLysD
 jUPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK1kq2SG7E91aZt6IpdWYTW0J988evmebjYKzveLv0U/lwccRiVWT8y9lbry+Ds966wB/WzQiu1NW2@nongnu.org
X-Gm-Message-State: AOJu0YyxK9GFxIuqYPLJUpChPSXsXBodFBE3vdyyvLwQovfZ7pLBcYH2
 b/XvUwuxJnqmBbS2s6B+KTksslgk8Di4IOgmJVOaCHTqzVJOBSuMe+fB/Pegzts=
X-Gm-Gg: ASbGncup/3nHnPVsgiYUDEhq6jtj+3KowZO6E93S0vFP9YbhnqmPotzaVo0ZWeFizYU
 6GSZHdbjZkAWwlwvjPcnlYrBVAJREj5TrPvL8dpQWSEvAuQrIa8km9GwmkwGaiLUy9YgSJ3c8X6
 6xRXkYeBlVbC3zFR9Mm5qODdrYedS2gpIege+ttneY/0L439bmMES59g/l2BWHMpnCmoqLy/+bi
 DN36wWXvN9jN9nNHPaAaRYu0vAcuf2/1gdovJQWY1abPQ9RGhrIuO3agR+M6Z+3ALbJbZaI2zZ2
 jf6UuY9J6UveEwqmlpu+WA9QVvSMYs2CeXNZPDsKztNNiqM7zTUaxw==
X-Google-Smtp-Source: AGHT+IHqdHs3jGVFdjjCEotm1wTeUfRU5zxy+t6hcVXbZRyRrOOLtzNsHcTXOgXA08H8X2K6XahSGw==
X-Received: by 2002:a17:902:cf09:b0:224:f12:3746 with SMTP id
 d9443c01a7336-22dbf5f3d2cmr754565ad.30.1745534605963; 
 Thu, 24 Apr 2025 15:43:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e752asm19091245ad.158.2025.04.24.15.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:43:25 -0700 (PDT)
Message-ID: <9a77bac8-9b14-408a-988e-a27a52892803@linaro.org>
Date: Thu, 24 Apr 2025 15:43:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 14/21] hw/core/machine: Allow dynamic registration
 of valid CPU types
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424222112.36194-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/24/25 15:21, Philippe Mathieu-Daudé wrote:
> Add MachineClass::get_valid_cpu_types(), a helper that
> returns a dynamic list of CPU types. Since the helper
> takes a MachineState argument, we know the machine is
> created by the time we call it.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h |  4 ++++
>   hw/core/machine.c   | 26 ++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 3573907d597..700e4f4ccf3 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -259,6 +259,9 @@ typedef struct {
>    * @smbios_memory_device_size:
>    *    Default size of memory device,
>    *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
> + * @get_valid_cpu_types:
> + *    Returns a list of valid CPU types for this board. May be NULL
> + *    if not needed.
>    */
>   struct MachineClass {
>       /*< private >*/
> @@ -306,6 +309,7 @@ struct MachineClass {
>       bool ignore_memory_transaction_failures;
>       int numa_mem_align_shift;
>       const char * const *valid_cpu_types;
> +    GPtrArray *(*get_valid_cpu_types)(const MachineState *ms);
>       strList *allowed_dynamic_sysbus_devices;
>       bool auto_enable_numa_with_memhp;
>       bool auto_enable_numa_with_memdev;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed01798d37c..0901a92b32a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1581,6 +1581,32 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
>                   error_append_hint(errp, "\n");
>               }
>   
> +            return false;
> +        }
> +    } else if (mc->get_valid_cpu_types) {

Since we'll keep both valid_cpu_types, and get_value_cpu_types, instead 
of doing a full replacement, would that be possible to add an assert here?

g_assert(!mc->valid_cpu_types);

and

g_assert(!mc->get_valid_cpu_types) in branch above.

This way, we make sure only one is defined.

With that,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

