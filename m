Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC7AC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4nK-000605-W8; Wed, 16 Jul 2025 12:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc4h7-000852-Lq
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc4h4-0002l6-JI
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752682156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWawChLBBVotjkxL09x7pQnrlouLlvEaDlaYImRYDIo=;
 b=cXWo3hv49vm7goNlvjrXGXhIo6i2v/m4yUI7XDZMEuhyPSSxBmwKTbDtg8on5ZQTP/zvTG
 BAteXmshNfEnXOxmWI6yXx5JkvppguaOFAWfTxj3aWNrSkUVECxz3aVFkw2IgxsXpXstKu
 9IHSPcbbqvdJxIWhvJQoW582X/rT9UE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-nJOvjc6IPfmEEVRYzCgjPg-1; Wed, 16 Jul 2025 12:09:15 -0400
X-MC-Unique: nJOvjc6IPfmEEVRYzCgjPg-1
X-Mimecast-MFC-AGG-ID: nJOvjc6IPfmEEVRYzCgjPg_1752682154
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so52895e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752682154; x=1753286954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gWawChLBBVotjkxL09x7pQnrlouLlvEaDlaYImRYDIo=;
 b=paxvYIL8d66KTbZ+HL7FuQwtJIqxB7wENQnIFVaikejEJlc3GB4v8X7O6ecAOTLrEV
 aBJeKXDsncISW1M8pTbMeaV0Qk6rxAGibOSo2rOT+d/SPzoeKBa4yI4Qf/QWi5aRS97H
 gYYQXil28WYdKKgeJYTp6r42mCyZfVmWBRWlacdQTbkwR9QbpBiBRuqXtwq1KTMEIins
 MdRu247Xs61xQNB50cw6joFw+Mp5jtp6cJfgw0eDsXHOms5V3RBOGiSwNdyHBLDFtvcP
 1H0Q0QutcXEhzSSBCWKV2gEk4g5QdvGxkI6Bytt8xWtMDyS96/Q38Tyht62ero5Vm/AJ
 fMew==
X-Gm-Message-State: AOJu0Yz1PU9SizIVX+Djn+CQHBjYfgu338oLjth1aE2vEOBuO6GLDCLd
 9Hi9CspNiN3DkiPaJURrxnAYHcF8jy0VffyEdOMu3RkWMVhTxAN28PhVo8bKKYFF71amWrcA9ju
 4PPYYHCZVhByRwvJiAySEIs9yy0O5cauAX/f0iYrcDT3Wx8XSuK6GUNvw
X-Gm-Gg: ASbGnctue80oP3s0yCCkI6PrQvUCNmti9+8GZLRmbi2UILgiuXovt1oQq7dTyFUYH73
 4JMmLaXzEmFsbgny9GZYQ/6IaOFYp3pBMEaTDGll7UIYsrLuL5y4g2v+Zl3SWxKpy72eEuvOSzt
 tup4hokAqdPTVZKSDOR75a9KFDkIHN03RKmDHm+/gjUSFDbPPgD49zamfMEBgKaNC15DaXac0a9
 RfJprqjIb8D9qHABpJAYyhbpAFBPwdesZ4WJgbEdjYSW2FHS1Ks/yz93KWdPGQi3YwxaBeEMK8M
 JYbr0fSmFLt5UP97PDA0TBZMV+TnsmscmLlodfzK722Nd7cpEMTYAektAHPlyvKMLLeqbDAtl7E
 JbbJvCf+1RWI=
X-Received: by 2002:a05:600c:5253:b0:456:1efa:8fe9 with SMTP id
 5b1f17b1804b1-4562e03a678mr37502125e9.2.1752682153537; 
 Wed, 16 Jul 2025 09:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuXhXeZHmCkJt3vyd8xwh91Aqb9L5GAkBV5W2i2xW//y24qk4hQb+WvE+hW6J8AROf8y4wmg==
X-Received: by 2002:a05:600c:5253:b0:456:1efa:8fe9 with SMTP id
 5b1f17b1804b1-4562e03a678mr37501865e9.2.1752682153065; 
 Wed, 16 Jul 2025 09:09:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e89c308sm25066505e9.30.2025.07.16.09.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 09:09:12 -0700 (PDT)
Message-ID: <5060c2be-40f4-4479-8fbb-fc0156bf9a94@redhat.com>
Date: Wed, 16 Jul 2025 18:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure on top of current git
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
 <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
 <aHfPwaF+uCOG8c+d@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aHfPwaF+uCOG8c+d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/16/25 6:13 PM, Zhao Liu wrote:
> On Wed, Jul 16, 2025 at 05:22:46PM +0200, Paolo Bonzini wrote:
>> Date: Wed, 16 Jul 2025 17:22:46 +0200
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: Re: boot failure on top of current git
>>
>> On 7/16/25 16:44, Paolo Abeni wrote:
>>> Hi,
>>>
>>> I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
>>> commit c079d3a31e.
>>
>> No and I cannot reproduce it.
>>
>> What host is it (processor) and kernel version?
>>
>> Paolo
> 
> It sounds like x86_ext_save_areas[] wasn't initialized correctly.
> 
> I just checked the related logic, in the previous QEMU, for x86_cpu_post_initfn(),
> it initialized x86_ext_save_areas[] first, then called accel_cpu_instance_init(),
> so that KVM's xsave assertion didn't complain.
> 
> But now, when we move accel_cpu_instance_init() to x86_cpu_initfn(), KVM
> checks x86_ext_save_areas[] before x86_ext_save_areas[] initialization.
> 
> I understand, we should initialize x86_ext_save_areas[] in
> x86_cpu_initfn() as well. Maybe we need something like this:
> 
> ---
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index da7d8dca633e..c8fccabeee71 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9619,6 +9619,16 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
>  }
> 
>  static void x86_cpu_post_initfn(Object *obj)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (current_machine && current_machine->cgs) {
> +        x86_confidential_guest_cpu_instance_init(
> +            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
> +    }
> +#endif
> +}
> +
> +static void x86_cpu_init_xsave(void)
>  {
>      static bool first = true;
>      uint64_t supported_xcr0;
> @@ -9639,13 +9649,6 @@ static void x86_cpu_post_initfn(Object *obj)
>              }
>          }
>      }
> -
> -#ifndef CONFIG_USER_ONLY
> -    if (current_machine && current_machine->cgs) {
> -        x86_confidential_guest_cpu_instance_init(
> -            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
> -    }
> -#endif
>  }
> 
>  static void x86_cpu_init_default_topo(X86CPU *cpu)
> @@ -9715,6 +9718,7 @@ static void x86_cpu_initfn(Object *obj)
>          x86_cpu_load_model(cpu, xcc->model);
>      }
> 
> +    x86_cpu_init_xsave();
>      accel_cpu_instance_init(CPU(obj));
>  }

FWIW, I can boot successfully my VM on top of c079d3a31e plus the above
patch.

If the above turns into a formal patch feel free to add:

Tested-by: Paolo Abeni <pabeni@redhat.com>

Thanks,

Paolo


