Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6825E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7FD-0005Em-1k; Tue, 24 Dec 2024 10:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7FB-0005EL-Jw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:54:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ7FA-0000FY-4k
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735055686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pQPQBK3F62z6akTtDMAEGfDEtkQU09o6OnOmv2Ax/wE=;
 b=C0jbxoKxxhjAZVEnTaYaHEpLU8tD7uuRMlrwJaxnI7lym2oWqvbLP8mKpZ417p6dcyuXOA
 nXq7tJzQ99h1RzhbAn43Wnr3EMNIPR9WypRUwAxIrOJ4cjaz+9ECgeK7jFLXpuxL7POPWw
 UdSi4M5vijZl9yCIWdP2rRaSsFIkiW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-7ZO6eyBAOO2sjzSLK36_wg-1; Tue, 24 Dec 2024 10:54:45 -0500
X-MC-Unique: 7ZO6eyBAOO2sjzSLK36_wg-1
X-Mimecast-MFC-AGG-ID: 7ZO6eyBAOO2sjzSLK36_wg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso2220700f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735055684; x=1735660484;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pQPQBK3F62z6akTtDMAEGfDEtkQU09o6OnOmv2Ax/wE=;
 b=Zti29dsesIqW8nyOw8LTw71lBhGVuKWxbAbx3YBpkCY906BSJm8aBXCHEBPq7SB4Cp
 Ig2vifzfcrBtATM+MmO9YpqYacfcj2CZmLu1G0Lb96ycs4qiuL9i/rcoG49mrxN8N3V6
 BkSumQq2IqTq3D8SaWAjS46QImFrJ13Cp1iNxSwLh/J1os2EPATZS7C+jgLzUzk1yFsu
 i4tagf2XI/q6gfoq9JPSrF0St0+jnr9hFfSvDxsjo5bgW8ZKKruQIDQzTpm9O7ZxG4n4
 CKgmZQyQCVfFctpX+4c1LVNmVw5nCq2fceU30qdYOISTDhcMukbxgsrxSaT3dymmhzyy
 i+ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX8BTRHyPy4ar/s8sFRbCjIxDDtYXZM79VVFfELnpj3/Ll0bSO4FzWxgvWkKhB6PFKF0aGiBGFMhCN@nongnu.org
X-Gm-Message-State: AOJu0YxD9DryP1KDsvxIJj5LvkNZJ2C4qUggYK9F9QjgI8/lcLCRxpjR
 ZgmCZ8a/gb0Bq6awNRbUXKfD+kd5aUH2xDq0KrNYu4RUgndyvixCvz1lvcuBEQE5aQ5O2Bwa4qR
 cRzNwhdAu7EGmnaz3GUvguxciECLYQ2KfdhswEhmiOz0Ngl5WDSAa
X-Gm-Gg: ASbGncsFt1PV410dhK8Tdc28i1AT4ao4NPR6MWUEUUKONN7b4o1LVUnn7ruhYR1zIrE
 d2zN9h4A/RX2y4l3enQnN3dG0K0wT0JM4QTxlnyTHBxXbfS1VV3CxzBP1mFPSkH0vJ7ZsDXO0b/
 6rHvQ4DqrZPs9qiCnmQgtZlvdAnMTBLpvMuZjQXEx4qvrcklvY1XfmmaOWufRbFtVL0RevCGZhV
 aUqp/JaODm8esyDUKqHw7LONBfmShEfwLEUFsRfDMYZfGQxN8aiiNxDoufb
X-Received: by 2002:a05:6000:18a4:b0:385:cf9d:2720 with SMTP id
 ffacd0b85a97d-38a221fb1b4mr13707797f8f.23.1735055684162; 
 Tue, 24 Dec 2024 07:54:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiJ6dOOb2ZXcY8eI4jxEc9RtVJ0acqzKGJNNsIjsvrgCxL/LV/rbybZ2Hmp8mx3SwrhmxD5g==
X-Received: by 2002:a05:6000:18a4:b0:385:cf9d:2720 with SMTP id
 ffacd0b85a97d-38a221fb1b4mr13707776f8f.23.1735055683785; 
 Tue, 24 Dec 2024 07:54:43 -0800 (PST)
Received: from [192.168.10.27] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e69sm14302199f8f.35.2024.12.24.07.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 07:54:43 -0800 (PST)
Message-ID: <5463356b-827f-4c9f-a76e-02cd580fe885@redhat.com>
Date: Tue, 24 Dec 2024 16:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] target/i386/kvm: Replace
 ARRAY_SIZE(msr_handlers) with KVM_MSR_FILTER_MAX_RANGES
To: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-12-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241106030728.553238-12-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/6/24 04:07, Zhao Liu wrote:
> kvm_install_msr_filters() uses KVM_MSR_FILTER_MAX_RANGES as the bound
> when traversing msr_handlers[], while other places still compute the
> size by ARRAY_SIZE(msr_handlers).
> 
> In fact, msr_handlers[] is an array with the fixed size
> KVM_MSR_FILTER_MAX_RANGES, so there is no difference between the two
> ways.
> 
> For the code consistency and to avoid additional computational overhead,
> use KVM_MSR_FILTER_MAX_RANGES instead of ARRAY_SIZE(msr_handlers).

I agree with the consistency but I'd go the other direction.

Paolo

> Suggested-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> ---
> v4: new commit.
> ---
>   target/i386/kvm/kvm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 013c0359acbe..501873475255 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5885,7 +5885,7 @@ static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
>   {
>       int i, ret;
>   
> -    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
> +    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>           if (!msr_handlers[i].msr) {
>               msr_handlers[i] = (KVMMSRHandlers) {
>                   .msr = msr,
> @@ -5911,7 +5911,7 @@ static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
>       int i;
>       bool r;
>   
> -    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
> +    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>           KVMMSRHandlers *handler = &msr_handlers[i];
>           if (run->msr.index == handler->msr) {
>               if (handler->rdmsr) {
> @@ -5931,7 +5931,7 @@ static int kvm_handle_wrmsr(X86CPU *cpu, struct kvm_run *run)
>       int i;
>       bool r;
>   
> -    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
> +    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
>           KVMMSRHandlers *handler = &msr_handlers[i];
>           if (run->msr.index == handler->msr) {
>               if (handler->wrmsr) {


