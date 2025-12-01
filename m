Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601DBD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 17:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ7IO-00005r-ER; Mon, 01 Dec 2025 12:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQ7I0-0008JQ-9H
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 12:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQ7Hl-0007XO-65
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 12:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764608518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lcWzxv/s0i/NZDIgXRoNrr5kB6YSS08kERnXz4VbwxQ=;
 b=EtnBOlWIL/zY5gIyaBWa9ripjNka7PIeuyvVKIXbNrdVzQGKhIPQB0LmcHjYptNXbnpOMg
 yfXMKDYtYroo8s9V8jV7d/ay1MNHzb4+zEIRxuSc6PvAFyJtL20hi20FIQL2Ue0P6nRoCA
 MILm8NW5hxwvoZsZFZyrM6GnJmetI1I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Rpg8uQQwMjmg9iG1wSOI7w-1; Mon, 01 Dec 2025 12:01:56 -0500
X-MC-Unique: Rpg8uQQwMjmg9iG1wSOI7w-1
X-Mimecast-MFC-AGG-ID: Rpg8uQQwMjmg9iG1wSOI7w_1764608514
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-641738a10c4so1083580a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 09:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764608514; x=1765213314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lcWzxv/s0i/NZDIgXRoNrr5kB6YSS08kERnXz4VbwxQ=;
 b=AU3D3L1Ty+dC0MmAIfq6BOOO2UpPskIImVKthWBNJSfsqi2oLpXhvAL+gM+oklsP0U
 To23L0C/0qowfZZrjUbC7Ej0QqOIRhtbliNpJX8OQ9hbe+mhjSLBoT0gkyx29fr8x+wf
 EHDBAlUc7KbQpfCj9ebPCtmm5SHAKEHLMjh6FyN5DS2nhojFDc2Szn7Gy6AGcqguHyTF
 cIBEkGIXwmf9U0Wpb4WygW7FvokJfmBAy/HwZdDfzJNg13tUNKhwGuLy6MEWdejPtkSl
 6TeFvOsOghK0TjkQYhiWd7GINyKsDQwm7g0GqlZplVEL8dI/CiJ5AIIturB3gP51uhyp
 DiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608514; x=1765213314;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcWzxv/s0i/NZDIgXRoNrr5kB6YSS08kERnXz4VbwxQ=;
 b=BUG5aoALDDun53AsYtroMb54eiaWSu8gIlYWAXQLliA4/V8cUOPMQqsckXWiUMkfj6
 sCV9a8n0Z6uuc1eHWuOjXOWtyKKVvp3+QqaWrBK+bv+2F1Ob5t0FWOmQwePSn3TpvkVt
 xG1OfEZ+/MSNcleSV5CfWxlSDQGeIh0flZQTsU8Y1kro1l7iOLQmOjeid+ZC2uBUSweO
 WL3RwQWll3Clj4q0COc0c3O8HtfwR3wGGsTup3h/DHrJr7XDU1PeTEs8Dhd1L6uZ+PTP
 dJPJae4fIRgl+sfTx8xyGpG8oiddwBOYDUtBajq4hzC443RbdufyvonwdPYY4tL9ZhCh
 tluQ==
X-Gm-Message-State: AOJu0YzP9JdLsNhtbGfKMzaV/tBzE/YX2afdLd++H/6YFdcpkdqincW1
 sNefX/GPTyDTeDzbnAdaOrnrlLHAcN9pGpDuGmxy6bD6xwYNpAYHNUbvT9ArRhbhYQQ/hI4N25U
 Qp+QaRYMSITZQxZ7IRic2Yds1VP+Ro8ysglqH3U2hSys1tyP2qIJA/Uxz
X-Gm-Gg: ASbGnctRui9timjsaKqww+oS4Knh4EE+dDTHT9/getOlssH0sk83nFSWf3NuDWXuNBT
 tH5IW21+OEpH/74lkNvOBDbsSDNRFLJ44qkjloqpxRVNB/nZsbAaHcY++OjWIxBXHsR3aARvm8N
 eow2DGnpBI1l1bri8fZlVT1J47BY+FwnyWzhnGIrOSMj6/cNfiIiEG1xAdfZ6JdA3e0IjI+J7ne
 g+cRQdJFXbt9L6sdyxaRh8l+ktl+HspMuukG2TQDPpp8zlKutBJ1EP4xbOSzb8ZXKieojMYuP7j
 PhKNn+2xFMNJD5hn9vw0UniIgPkM7Jxk3BsSTC8VOKQJAt36yJLVducXpiYxSGCg7/qSNssWWQP
 jEyWaz+zQDtxza4N8uUzDD3x/4meov0uBS5e/utHXl+F4JbpLSg+lW5n5foblxKXTllYW0JHweY
 QXL342CjCLoPEuhko=
X-Received: by 2002:a17:907:7e9e:b0:b71:1420:334b with SMTP id
 a640c23a62f3a-b76c546da4bmr2475550066b.8.1764608514145; 
 Mon, 01 Dec 2025 09:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESMffEF++MlIevqwJYsJiZlsygB4BU5rkZZxsHpfBL3PRwP9k4oL7Q7EeDqjABSeuuWqmTJg==
X-Received: by 2002:a17:907:7e9e:b0:b71:1420:334b with SMTP id
 a640c23a62f3a-b76c546da4bmr2475537666b.8.1764608512928; 
 Mon, 01 Dec 2025 09:01:52 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b76f519d883sm1261396466b.17.2025.12.01.09.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 09:01:52 -0800 (PST)
Message-ID: <3103289d-e86c-486d-a3c0-95d7615099c6@redhat.com>
Date: Mon, 1 Dec 2025 18:01:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/23] i386/cpu: Migrate MSR_IA32_PL0_SSP for FRED and
 CET-SHSTK
To: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, Xin Li <xin@zytor.com>, John Allen
 <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
 <20251118034231.704240-18-zhao1.liu@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251118034231.704240-18-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/18/25 04:42, Zhao Liu wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Both FRED and CET-SHSTK need MSR_IA32_PL0_SSP, so add the vmstate for
> this MSR.
> 
> When CET-SHSTK is not supported, MSR_IA32_PL0_SSP keeps accessible, but
> its value doesn't take effect. Therefore, treat this vmstate as a
> subsection rather than a fix for the previous FRED vmstate.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes Since v3:
>   - New commit.
> ---
>   target/i386/machine.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 45b7cea80aa7..0a756573b6cd 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -1668,6 +1668,31 @@ static const VMStateDescription vmstate_triple_fault = {
>       }
>   };
>   
> +static bool pl0_ssp_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +#ifdef TARGET_X86_64
> +    if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
> +        return true;
> +    }
> +#endif
> +
> +    return !!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK);

Can you just make it return "!!(env->pl0_ssp)"?  If all of these bits 
are zero the MSR will not be settable, and this way you can migrate VMs 
as long as they don't use PL0_SSP.

Paolo


