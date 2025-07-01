Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C358C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 18:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWfcX-0001LG-Mk; Tue, 01 Jul 2025 14:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWfcW-0001L3-IE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 14:22:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWfcU-0006jV-MY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 14:22:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453608ed113so36937305e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751394132; x=1751998932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Thr6EF6Q1jokrF4quW2IgrC5uW6ZIlo0QLoKP3d5mPQ=;
 b=jmL8H2TzGxaOpE9wWGSIny1O7PE+p7zeNxOhF8fizdBG9RguL8MjHtOmN44xSsma1A
 kDmR9O0BQH/+6LM4M/VD7AoFwzv2epYFEIywtZVyicEMn7nGoTF2Bw3RBkmAqRXi6RsO
 7hQHcsLFf/d1v+J/9fWdwXxRRtvsnZgTDZ1EG5PVNHo1XfOdmCBN3mi0AUkDGGB0vBrh
 XhhnYriwBZxabHMubWtmbmYGd/P+8JNQwd8Gp9152c4gv4rv4fMKbM84k06lKZapooGq
 Wv49ha7AI2JrrhKuNuhWcNs0dHq4VWarnVOJmNNdbtKKFO8/MiLE7dR0PFOdNp1FhXQi
 llMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751394132; x=1751998932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Thr6EF6Q1jokrF4quW2IgrC5uW6ZIlo0QLoKP3d5mPQ=;
 b=j+iBRibbMxvFBzSCwIAjcD3G5L318yuSaRhSBSOZCb4c9Hhc9w99I8naPWcQpdIuVs
 tamFLEeGzUZcqMSim4VTUd7+gZ0CHOtdgCrV+plfbnWtxtzHYlfnzGlRjbVFqQ+dzKKi
 MlWw8ftXJN0HYoEfX8LI04yZ23AvB+ssQg1orIGTyZgcZA+/XkTdlKM5xQfbSHd98vs5
 04jtAUkhpfWo8CxqRab/EYkVXZcC1nkL92QjDUrDx9alG9Br9GHcD8w8IcxaHzs+maRz
 kmZpsh6OtGkooYbJyufN1U3bKPEwwzNBJNP7lUKddlvaMFIZZtW+SZpoSlhFptVgi9Hj
 wG9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYENQ5T6uH7F/q1dP9eDMkOO8/4IXyx/2vbojQp8gdFYC5OfK0UKXsqia1cxYJjDgC7/Ykak01rUNu@nongnu.org
X-Gm-Message-State: AOJu0Yx1ggQR1twbgC1KwinAMAVUYB4msoyckoKO0hFKDDJPge8227ds
 VL+QL2q5Ag4hmbtXkqoXcI53DC4L4kRq3tjtikS4ihz9319w8HL2+8mqvEkYZWLingU=
X-Gm-Gg: ASbGncuX2FrIaQ7q0vCfMcc4B+g4Xx0+zkGK6HNrKROUTnxtnYcOsCKPlyrMaE20/Bo
 82frNF8rlWA8iBfLHD8tgmtGKOp+DsRxqg/SMHpx1OgugQP95AEmnwIHsObyY8NYjmimn5UqA4y
 +2vmOnCiMwLiT/4g2YT+3jX7BtKly8l2VL4mtPYgO9UqUtbzJBF9OokkznKOeXtmNTtBAu0k9Cg
 aev2hA3UvDBwod/L9vzHhQs1JIVR+Js8pWL2XisfkkfxGrHBjnr0tSwj+5h3MYPUNH3R2isGkxL
 6eSP7S4mYFIF2o12C5nL7g/Pi4Uj6LuO7KKz4Tt/6kJ5Dm/5U0OMCRtJJmfM9AdPjqrdzANu4sd
 no3V52oSCoI8riSUSG9gXiIcOKgUfT96VyEEh7OBK
X-Google-Smtp-Source: AGHT+IGXNJLqo+pGQCw0NFuyH/JxIPFIpZ6g6dpQBs0ejg40xmBO/8Gqlg38P2gBrzCMzxo6ilzBLA==
X-Received: by 2002:a05:600c:3589:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-454a367a6d8mr2517895e9.0.1751394131956; 
 Tue, 01 Jul 2025 11:22:11 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453822c6b9fsm202731635e9.0.2025.07.01.11.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 11:22:11 -0700 (PDT)
Message-ID: <8e1e8f28-28cb-4529-ad2d-9cd277f7ccd1@linaro.org>
Date: Tue, 1 Jul 2025 20:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/27] accel/mshv: Workaround for overlappig mem
 mappings
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-27-magnuskulke@linux.microsoft.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250701172834.44849-27-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Magnus,

On 1/7/25 19:28, Magnus Kulke wrote:
> QEMU maps certain regions into the guest multiple times, as seen in the
> trace below. Currently the MSHV kernel driver will reject those
> mappings. To workaround this, a record is kept (a static global list of
> "slots", inspired by what the HVF accelerator has implemented). An
> overlapping region is not registered at the hypervisor, and marked as
> mapped=false. If there is an UNMAPPED_GPA exit, we can look for a slot
> that is unmapped and would cover the GPA. In this case we map out the
> conflicting slot and map in the requested region.
> 
> mshv_set_phys_mem       add=1 name=pc.bios
> mshv_map_memory      => u_a=7ffff4e00000 gpa=00fffc0000 size=00040000
> mshv_set_phys_mem       add=1 name=ioapic
> mshv_set_phys_mem       add=1 name=hpet
> mshv_set_phys_mem       add=0 name=pc.ram
> mshv_unmap_memory       u_a=7fff67e00000 gpa=0000000000 size=80000000
> mshv_set_phys_mem       add=1 name=pc.ram
> mshv_map_memory         u_a=7fff67e00000 gpa=0000000000 size=000c0000
> mshv_set_phys_mem       add=1 name=pc.rom
> mshv_map_memory         u_a=7ffff4c00000 gpa=00000c0000 size=00020000
> mshv_set_phys_mem       add=1 name=pc.bios
> mshv_remap_attempt   => u_a=7ffff4e20000 gpa=00000e0000 size=00020000
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   accel/mshv/mem.c            | 264 ++++++++++++++++++++++++++++++++----
>   accel/mshv/trace-events     |   7 +-
>   include/system/mshv.h       |  16 ++-
>   target/i386/mshv/mshv-cpu.c |  43 ++++++
>   4 files changed, 295 insertions(+), 35 deletions(-)
> 
> diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
> index 6d7a726898..0ffe379601 100644
> --- a/accel/mshv/mem.c
> +++ b/accel/mshv/mem.c
> @@ -20,44 +20,167 @@
>   #include <sys/ioctl.h>
>   #include "trace.h"
>   
> +MshvMemorySlot mem_slots[MSHV_MAX_MEM_SLOTS];

Ideally this should be in MshvState. Just a comment, not asking for
changes... yet ;).


