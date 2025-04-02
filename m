Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7516CC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 06:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzrp3-0001O1-L3; Wed, 02 Apr 2025 02:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzrox-0001K2-38
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:43:33 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tzrov-0001CL-FW
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:43:30 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso10249241a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743576207; x=1744181007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXizRdW1yXOdzoyHAL6mQwd9HVYQu/VdZUeM7NUrVqc=;
 b=R8N/o++w2JK+WPFMvuPZo5wTSU5+cfOI/igJMWo2TyGBaG75rO8CtjbNw3z349Ft9Y
 YeudWDugW7mr3QzCVV8W/fMCHPgytwqeZuYS7Cc2KUBpHQLRKG0bZWHG7TUJJoAZX8pr
 u73E6OX/VimYS8xknC1+wVBYz6lBEJA7I0hSg9mGrkrpSmpK3oQFk5Sg2pD9jJP3QWxM
 WaAwISqdARd4ReepH8yE4p/DTmmE7mkyZ9Avxi8caaIRmWBzbzYjqxNdTIPLZf7cwLzA
 J/+QnssjZ+cnp2WjpX+/pTc5/t/jlIp9tV2VjbVlomWm86uR/E5DLwbQk+4Gnr54rJhe
 WQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743576207; x=1744181007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXizRdW1yXOdzoyHAL6mQwd9HVYQu/VdZUeM7NUrVqc=;
 b=katEUuB4nWYvUNC7Y5LkIb0w2IV/kS5kfoaZlV62Qr0FGx7W70ZHYxACFncjEUeChk
 GMHeDeY2FzhonK449J0WGuDK/Xu2zRgAMYNqMcz/tVCRomN6+EQKL3wwuPxDiwUCKba0
 wAf5iGIC+fRuV1KMWTHcct9iW1YpXBuIs72QWtA62UJiptr0BTJJJ0dt4AzfvIYwDBUL
 gYakdWXgF1NjncTamqTr+XZreS/vFNgI4+EcHhtcp2Wm2zB8TtJpZxBANcjy7VMB+JRj
 ZqZCAT7AP0YG7DQ2mnPlljUnP+Gq5IUBii46Ixlfo0Qx3YYD0eRvcAN6ooQeCHlVJVuJ
 Yv0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBXH6Yx35wRZ9gdHB31D9Dv10kJZwADukCJ2hirrY28UpsylIOOg9KtViDVOyjh2IovyVhsMpHg4RK@nongnu.org
X-Gm-Message-State: AOJu0Yw8qqCZZPQNBAfnAqT+bkusbmOXZjwtOYc2TRAtSnSLv+efJDWC
 tdDrGncFEjA4FCvNdTQTX9Lp+g2mtU72ba11K7nUA+2GAc5xaQtAkYqpawmLplg=
X-Gm-Gg: ASbGncuTmcN0j2hKAjAsc8ZV32IKpFjvX2s3h+Ru2sWolhdFOnBMGsnM7PvycCb3k7c
 m7Suy0RCamdHRDiPM7Cz8w5pyoYWB81SjsSEGYAiubOSBK/fb2ItU0cP4Ythyq0bEdWOcHd6zft
 2A4vKASaLfD2p0vZHjTiBO/XOCUtHUuy38wEoToiJF9YZBZNPSy8cx/jN07AlPZ786NsMtH8fSD
 huGGFBVPClhdbNzWGAhD0JIfpJGOYTBMWF+BPTSCKl9LYzmEuCe8Aco4Z++iZ3wGubpHNZ7wa88
 Mxk53A+to+FO5SItazCKaoP76PixkaZNaxSDQ6HBI+lXOPBhW9Oz8K+c
X-Google-Smtp-Source: AGHT+IEQi0oIb7eUFZAZkiTOrEnG5ukIYCMDO/o9G+sEwNUPkKP9j8QwV4g0FSBplHvUT8IRC4a99Q==
X-Received: by 2002:a17:90a:f944:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-3056ee23346mr1863741a91.6.1743576207195; 
 Tue, 01 Apr 2025 23:43:27 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ce127sm100666035ad.108.2025.04.01.23.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 23:43:26 -0700 (PDT)
Message-ID: <957f0d3e-0c25-4d88-b935-ddfe7cc75776@linaro.org>
Date: Wed, 2 Apr 2025 03:43:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 2/5] qtest/bios-tables-test: Whitelist
 aarch64/virt/APIC.its_off blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-3-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250331221239.87150-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102c.google.com
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

Hi Phil,

On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
> Prepare for ACPI table change in aarch64/virt/APIC.its_off.

The comment could be smth like:

Ignore APIC.its_off expected table (blob) for now until
we update it later, after fixing the code that generates
this table correctly.

?


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf..bfc4d601243 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/APIC.its_off",

I think this patch should be merged into 1/2, accordingly to my
comment in 1/5. FACP and IORT .its_off files should be added to the
list as well.

Btw, IMHO the name of this header is a tad misleading, because actually
"allowed-diff" means that "we allow the machine's table to be different
from the tables listed in this header", so it doesn't look like an
allowlist (whitelist), it works more like an ignore list?


Cheers,
Gustavo

