Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB427CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJ1n-0005bP-5d; Tue, 21 Oct 2025 16:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJ1l-0005ao-7D
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:32:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJ1h-0006ET-JH
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:32:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso71466915e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761078732; x=1761683532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TMQVGYbBwTPfjpT7yEW5e+oix7imfwHLBURkwy6U+Pc=;
 b=QtPRrA/tpWe+by+IxA0Fg8LcjUbd9boW808La1jnNJJfHRI7/sqdpyEs9K52ogmNRI
 mOUSGUn7RJStjb0p9rsU4tLtIaOvHe2QXoZFlKjUsk61HvvJaHcmC9WLJyTkBRrE1hvn
 NkW8soy2H11id6XOfSkEIlg/OvgA53dgGt/N/5T9fTOaijbeL5DgLnObQT3dCRGlUcAQ
 IA5/9PiJFjyNiEP0zL6gtCGkHq5WlRzPYPLrGFXQowHKOy8+iDjohYzFVqmWlIm6lR9W
 uQQ9N83dGmH04l79PjXt7jVGTUhdeSfE4jq6IfFBJ9Kr4Z4SV9Anz1cOCICp2q8dY258
 XUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078732; x=1761683532;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMQVGYbBwTPfjpT7yEW5e+oix7imfwHLBURkwy6U+Pc=;
 b=ODz0w7yP70cPojUPwXTB73yk7rcwbbn3pdLHxaLq/Oacpb+tssd4E4/ftwzyB3PIuO
 mQ/0bkZikMYKhcomuuAFCm/8kUwTeBOxC+oSTWVffVQvLtUATlJrMw9bS8XFt8cGVzpn
 c3//h08BJcP1LVIb+vIUNYLw087tDugshCt0qmQSNCqgqk3wilU7x5SkbVI9AaXQqVjI
 Nxl+Lj8yTvZerHMwYr+rMIrxY/THjfMrA3YOBK8ehfV3TxRZWW7IK+E0Wql7P/i1OuhA
 +mdVlnMKdNotcYiLVWhPyb7y/oiRvAmcSbIVFtatoyxSQ+oWxHPjEtrKm2+I8kpAM8Vd
 Oj/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiImZT3FdShOln3PDL98FqxKXRmrhSR5VSBvIwnUCSIhETXm3Bz0yfJb/vVfss9rRTpkBSdIqjOze9@nongnu.org
X-Gm-Message-State: AOJu0YwYQBs0FIEzkVwqlXEd9BkYyzkfmpPQVyCtcumoaIwtxS0EaKDE
 1lLPztHijRPIeNS3/OgRgxtqYltbZjR62NMfYKZhJjSnKBPFbYiUocqU/brOPb/WTok=
X-Gm-Gg: ASbGnctENw+HmgEobg+VoaIbFmKd6hkTmMDhq4meIpfqmUXIHhgMBCaC+7tO2MGnZ6M
 +8VuZYeFWjVDF24B8Ugw/YbgB5pUPYAJrqQ/j+HQf9YMRKNPe6vACa86s9ZkGEeCxeg6AnYQcOU
 WYwPSJmVs3wDn11CpW3oh8mDYowMMwwGFIqSJ7G5wV3d2lkBCFHKNfZzwskwNTW5RHy5IqQVZGs
 eS/aAX1bocputUOyPzOEswGitdah9ScVsA9LLryVJs46lSqApj3SNzy21mKX0tIn0RC4EUC0nLW
 D5gfeuxR83+NBHEXttOfug5Dbgdr7Dzb2P99rftCIwb9QAgrCpihgq+1bnk/It9764Kognw4KP5
 Mdn2T5jmA2G5Kzv+IjozRY9y22wbvU44NlzJAOMZBK60veWGt+MBxXW/FQJ0kCk1+PBy5gZGubA
 uqd8DHlKWPNmX8jfrh9DMGlYcRPQbljxzxQgSKbxbvaHg=
X-Google-Smtp-Source: AGHT+IFYOB9UU5ydnY3/Edq8wbAEHG0j1YT+12KSppxWMhpai3G1EDe90HqNzmCGoBLD7R/zfooiWA==
X-Received: by 2002:a05:600c:3e07:b0:46e:4783:1a7a with SMTP id
 5b1f17b1804b1-471178705bbmr137925855e9.3.1761078731740; 
 Tue, 21 Oct 2025 13:32:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c438caeesm8607715e9.18.2025.10.21.13.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:32:11 -0700 (PDT)
Message-ID: <e079b37a-34d9-4ff7-87a9-4dd9de49e49c@linaro.org>
Date: Tue, 21 Oct 2025 22:32:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Cleanup patches, mostly PC-related
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <0e7af78a-6156-437a-b76d-8453898a5b57@linaro.org>
In-Reply-To: <0e7af78a-6156-437a-b76d-8453898a5b57@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 21/10/25 18:07, Philippe Mathieu-Daudé wrote:
> On 19/10/25 23:02, Bernhard Beschow wrote:
> 
>> Bernhard Beschow (10):
>>    hw/timer/i8254: Add I/O trace events
>>    hw/audio/pcspk: Add I/O trace events
>>    hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into trace events
>>    hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
>>    hw/rtc/mc146818rtc: Assert correct usage of
>>      mc146818rtc_set_cmos_data()
>>    hw/ide/ide-internal: Move dma_buf_commit() into ide "namespace"
>>    hw/i386/apic: Prefer APICCommonState over DeviceState
>>    hw/i386/apic: Ensure own APIC use in apic_msr_{read,write}
>>    hw/intc/apic: Pass APICCommonState to apic_register_{read,write}
>>    tests/qtest/ds1338-test: Reuse from_bcd()
> 
> Thanks, except if Paolo/MST/Igor object, series queued squashing:
> 
> -- >8 --
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 67ff52a8b40..d981ca05977 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -29,2 +29,3 @@
>   #include "exec/memop.h"
> +#include "hw/i386/apic.h"
>   #include "hw/i386/topology.h"
> @@ -2352,3 +2352,3 @@ struct ArchCPU {
>          user */
> -    struct APICCommonState *apic_state;
> +    APICCommonState *apic_state;
>       struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
> diff --git a/target/i386/whpx/whpx-internal.h b/target/i386/whpx/whpx- 
> internal.h
> index 066e16bd8e2..2dcad1f5650 100644
> --- a/target/i386/whpx/whpx-internal.h
> +++ b/target/i386/whpx/whpx-internal.h
> @@ -7,2 +7,4 @@
> 
> +#include "hw/i386/apic.h"
> +
>   typedef enum WhpxBreakpointState {
> @@ -46,3 +48,3 @@ struct whpx_state {
>   extern struct whpx_state whpx_global;
> -void whpx_apic_get(struct APICCommonState *s);
> +void whpx_apic_get(APICCommonState *s);
> 
> ---

Also squashing:

-- >8 --
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 077ef18686b..aad253af158 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -1056,4 +1055,0 @@ static void apic_mem_write(void *opaque, hwaddr 
addr, uint64_t val,
-    if (!s) {
-        return;
-    }
-
@@ -1072,0 +1069,4 @@ static void apic_mem_write(void *opaque, hwaddr 
addr, uint64_t val,
+    if (!s) {
+        return;
+    }
+
---

