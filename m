Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CDFCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slOCC-0005l8-1I; Tue, 03 Sep 2024 03:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slOC8-0005kP-A1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slOC6-00027b-8P
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725349395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1AwvxU2FuOYSnLn87kkYf7HRlnU0avXnduIOEZLfLtA=;
 b=M/OUtvAnW9UXPlWESJt+yAnOL46dOZeHwI75L910Soae/79N/sC3+IJLGKnZLIUH4xDT3S
 b9EAQYZxzu/X4+Zhs+QJmAXWh22TRtFf9G5Xahk3JqKWK509jIwdlvhT+5X2w8zB48IOnc
 vTCqHi7Qxi/WsEgn0wR7EhSjHhPUdn0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-WYhOIJKRMKWp7vFyzbX8Jw-1; Tue, 03 Sep 2024 03:43:13 -0400
X-MC-Unique: WYhOIJKRMKWp7vFyzbX8Jw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a868b6d6882so682171666b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 00:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725349392; x=1725954192;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AwvxU2FuOYSnLn87kkYf7HRlnU0avXnduIOEZLfLtA=;
 b=PoaRJez0OmY8WFL6oz55eLw1if45MqTf89xPsHvF3Uc+wohLgCdkaMR6bihV2M+fhy
 aaQkGacXHijHCYarLUoh+p/3YsbNS9Y4uVL1qaFLlmL8autWA/KQfU0Wnb7eCXxbjamm
 P3Kt1v6iw7fPjjO2LNRhmfCNKZKnR9z2uVyRUjjBtAiHawjkvcqWEoWLqatW23Sm8fjJ
 x0LMyY/L23ntSLyL0ie7AuPNgm1M2K+yZNSkE3wtTP6qrliBvlE6RGGZvoNcd3gUBIiT
 8qFEqbQXqC9G0gvJLcA8qT3+WohA11MNXTborVJiWIveV0k6Ng9cVi0TOPX+0Bp5Gbvh
 wi9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsk1/CnwVxrlU1cfsIamqAfiuVPVkk/n+mmz4Jv3yXJqtSDw5jE3EPga/V1SHkSqxd7CUtsNBBcJw5@nongnu.org
X-Gm-Message-State: AOJu0YwD2YGfuUC0NuztNOuFE+GZXnVRohn1lOY8O+VCLmEGIr6fmBjt
 zZKxeGQAaXl9mWV0ie3KJ3mI4O9sgwnpCYYbvPKtkEVszoQYfhHS751VI/KkgPaAa3eWO/7d80z
 Mx+DQZlGByUkgA3V/yIWmh34HbRZzOXi42bP2mrreybTOobI695Xy
X-Received: by 2002:a17:907:9726:b0:a7a:ac5f:bbef with SMTP id
 a640c23a62f3a-a8982833612mr1566267966b.31.1725349392611; 
 Tue, 03 Sep 2024 00:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxAPJPwSoWCLXS336TviAXav/oIrctZZtj/CPGQfhgefyOseoxvyBCRE6rzeKph/2mklaCkA==
X-Received: by 2002:a17:907:9726:b0:a7a:ac5f:bbef with SMTP id
 a640c23a62f3a-a8982833612mr1566265366b.31.1725349392109; 
 Tue, 03 Sep 2024 00:43:12 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a8988feaf05sm651137366b.33.2024.09.03.00.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 00:43:11 -0700 (PDT)
Message-ID: <32332f54-0c20-434c-be43-e4e00bcebe29@redhat.com>
Date: Tue, 3 Sep 2024 09:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm/i386: fix a check that ensures we are running on host
 intel CPU
To: Ani Sinha <anisinha@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20240903071942.32058-1-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240903071942.32058-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/3/24 09:19, Ani Sinha wrote:
> is_host_cpu_intel() returns TRUE if the host cpu in Intel based. RAPL needs
> Intel host cpus. If the host CPU is not Intel baseed, we should report error.
> Fix the check accordingly.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

It's the function that is returning the incorrect value too; so your 
patch is breaking the feature: this line in is_host_cpu_intel()

return strcmp(vendor, CPUID_VENDOR_INTEL);

needs to be changed to use g_str_equal.

Paolo

> ---
>   target/i386/kvm/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11c7619bfd..503e8d956e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2898,7 +2898,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
>        * 1. Host cpu must be Intel cpu
>        * 2. RAPL must be enabled on the Host
>        */
> -    if (is_host_cpu_intel()) {
> +    if (!is_host_cpu_intel()) {
>           error_report("The RAPL feature can only be enabled on hosts\
>                         with Intel CPU models");
>           ret = 1;


