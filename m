Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6971DD12671
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8GLl-0007ZG-W8; Tue, 05 Nov 2024 04:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8GLj-0007Yf-Td
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:59:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8GLi-0007cN-9v
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730800785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QInjCe2HZxMiS9t3tTItXMpvJOBheXFw8ILfgZfDc04=;
 b=QEaLEvGLpIzWMJAo42yG7fWD+H+opeOskGQuBgolEn9/EOZJhuzDxh/fOMww5R29vKZgjK
 i3zdmybxDnd9wT5zKBU7K7RUEIaW5poKTnKanL+kInCczqzW2UP0Ev/pjlc/Ud7QSo6Gro
 MKoCu6lekb+pNKsRUiKX+eePFVFJHTA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-CxvBg5YBN1-QRwfHWmlgPw-1; Tue, 05 Nov 2024 04:59:43 -0500
X-MC-Unique: CxvBg5YBN1-QRwfHWmlgPw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539f067414fso3113226e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730800782; x=1731405582;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QInjCe2HZxMiS9t3tTItXMpvJOBheXFw8ILfgZfDc04=;
 b=Dz55h4Kw1oGW87qL+Kx23htFwpovARwbu0NYYt8k/2K4KfNJM10GUkWV+X5PNnavLV
 Ji7CVyXwcMwWmdfeecGZfXV0msfrIi2dNwfO83Gw2DBfYsbiP6vg5PPoXCz/FH9QqGb6
 xe3WTatvk9qQQkfkFJ9bIofQdP0tbFvjD4aPP4FZEMGfMCYr75On546XyebkDbHCbENW
 XHnYbenOnLGzGnOPBU2tQH2w1TcSXrPtTchBclqLgKPXWP09jbr43oFP24jHue5TIwHc
 uUoVf7Y15BByLbe4f3ItXZAItd1Hgg6xIOYKjjjrWkunUjix3qmjwVaB+fOT2RjnZUnk
 E2fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfyvmVeJ6QZ8d6TFQIsqAZ0vhmuulI3eWZjntKH+hAfRNzlHpcMCnGoGAqmRqavFzsQi40xXwVNkPK@nongnu.org
X-Gm-Message-State: AOJu0YwQom9mWT48h8h8kEikQm5VKAqgMD/K81ogHMlhCo3gnNiZJzIX
 l/sCOaMtjm4SjYyhuWWWuNC+xuP1nn0c0rkdQMMVWqgkRmQKXdrxegewsmDs+1GzeRzoM9FNqWl
 oIHfkIR2s1hTaaNMP0RAXAG1WPwImAFrp+fteIpSxExLiJg2UDg0h
X-Received: by 2002:a05:6512:3091:b0:539:ea7a:7688 with SMTP id
 2adb3069b0e04-53b348b9130mr16974772e87.1.1730800782274; 
 Tue, 05 Nov 2024 01:59:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzMuWVU/ndch0oUzHzWK5tBEpoZHJkJ1/PzWbUd+f2Le81X2BJN/p+vKXeYJ1oT0Rc+ksAww==
X-Received: by 2002:a05:6512:3091:b0:539:ea7a:7688 with SMTP id
 2adb3069b0e04-53b348b9130mr16974745e87.1.1730800781730; 
 Tue, 05 Nov 2024 01:59:41 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-431bd947c0esm220305265e9.24.2024.11.05.01.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 01:59:41 -0800 (PST)
Message-ID: <f1c7bba2-7b21-4e10-a245-36673e93f8b7@redhat.com>
Date: Tue, 5 Nov 2024 10:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 56/60] i386/tdx: Don't treat SYSCALL as unavailable
To: Xiaoyao Li <xiaoyao.li@intel.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-57-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241105062408.3533704-57-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/5/24 07:24, Xiaoyao Li wrote:
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/kvm/tdx.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 9cb099e160e4..05475edf72bd 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -734,6 +734,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>   
>           requested = env->features[w];
>           unavailable = requested & ~actual;
> +        /*
> +         * Intel enumerates SYSCALL bit as 1 only when processor in 64-bit
> +         * mode and before vcpu running it's not in 64-bit mode.
> +         */
> +        if (w == FEAT_8000_0001_EDX && unavailable & CPUID_EXT2_SYSCALL) {
> +            unavailable &= ~CPUID_EXT2_SYSCALL;
> +        }
>           mark_unavailable_features(cpu, w, unavailable, unav_prefix);
>           if (unavailable) {
>               mismatch = true;

This seems like a TDX module bug?  It's the kind of thing that I guess 
could be worked around in KVM.

If we do it in QEMU, I'd rather see it as

             actual = cpuid_entry_get_reg(entry, wi->cpuid.reg);
             switch (w) {
             case FEAT_8000_0001_EDX:
                 actual |= CPUID_EXT2_SYSCALL;
                 break;
             }
             break;

Paolo


