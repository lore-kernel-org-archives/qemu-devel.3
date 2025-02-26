Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9A4C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 06:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBLW-0003hF-8d; Wed, 26 Feb 2025 01:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tnBLU-0003gw-40
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tnBLS-0005Y4-Ah
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740552996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXHq/VsznhwhZ79bk3SCXggo60RrHTjxbjHEu18HB5s=;
 b=FzEgxRseeqm0aJmqGQvfAvpjEKWZw4cJTqMoSCbi51okznwViLAhgKMlCseWLfXvDX0LB7
 9zNHc3PyftUl1C+5wxHhufN+4+//MLz8xOP+UM4bXoT8BqmqhMgmp733aMEv5Tq9O6NUgM
 5++kMsBi9zwlcCJCVhUXbygwEHtfURk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-aMTIS3SHPHiDEvoLcbVRuQ-1; Wed, 26 Feb 2025 01:56:34 -0500
X-MC-Unique: aMTIS3SHPHiDEvoLcbVRuQ-1
X-Mimecast-MFC-AGG-ID: aMTIS3SHPHiDEvoLcbVRuQ_1740552994
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-220d6c10a17so10979065ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 22:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740552993; x=1741157793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXHq/VsznhwhZ79bk3SCXggo60RrHTjxbjHEu18HB5s=;
 b=vLn0ISMNySO9ofSLDzJAwX7f6vsWhb2h8TqO9EUPqmcFk8GSW/O+pit8AfJaqcmi8P
 K2+956bS5HfQcHdOiXsFlKs2cXHZpzBEEWCDOYfzKFfg6p+NohL6dvmFP6Sf49nE//rY
 7NaMx4Ead98SUxoDIfw354oXmxf8CNxgw+yN7cYFSHGEGXRfjD8+RCo/MYazsSogsdPs
 e2FCSmRd4S47Ph0mherCn1BL7qmN8gSlGL/kJhBlFif8RSbNc5TsT7O7qWNduPsyp7m9
 t18mcDd5dHSoBqh+NQfBFOHZLY+TGFE6ejGyVrznGRUz8G7tXb9FH9Izn4rwMiDk/Qth
 HVuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVOnEKv6DH6DPkzPXDOogqThnlLGIRXUFzQ2Bf8FWZ86JxrrA/ba+FVnSLljhKFgZY7a3Eya4NVGox@nongnu.org
X-Gm-Message-State: AOJu0YzN65lVguJSEN8oJuJhm/l9gGS3vkjrua160wdh+HExI7qUJQ+8
 iuskHkKrCHf2tC/vlfiI+L/fFgx0yhlbFo+Eg8W6fH05O6PSWVTIEBzd8B/IghBSQWWulUGwbL1
 qD7Rut854BuqKF+jGeRIzNFcu4Ly/8tBkdQlBItnyLNvIvgwk5NSX
X-Gm-Gg: ASbGncv6MNXy7CeD1Z8VwZW9Y7D0EdGv3oLBEtRtpZZBPa10CYHdfHLgJka/tVXNv9M
 U7jLu8m7+t+dgOQdGeZQvXhMdsp/H0IXNfuWrxlyUTJfXeQOekRLUG/nsoVUXMbjaXoyIsPYwDF
 jeFtSiEr0zVCpNtGL2VbM8xTKVb+SzcC8002TsvZGqOXGTrvnnJs1lzU9gHk2ZJbPF54FFaEnaP
 z0qlIolweEq2ii06LLaOQfZ1bYpjWhpDCyB6lEwc1fSv4nJC0dyrPNlMSFDrw3vIwWY+XePuNh2
 JFPfWb9o2b3G26xsQQ==
X-Received: by 2002:a05:6a00:2e14:b0:730:9637:b2ff with SMTP id
 d2e1a72fcca58-73425ca201fmr32964800b3a.7.1740552993547; 
 Tue, 25 Feb 2025 22:56:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZfLb5iodUJNnj00HmW4WrR85VwoKsi0WAN0vRxsENOQjIgQ6qgkxSWWKzzpBSVUXYFRV6dQ==
X-Received: by 2002:a05:6a00:2e14:b0:730:9637:b2ff with SMTP id
 d2e1a72fcca58-73425ca201fmr32964782b3a.7.1740552993122; 
 Tue, 25 Feb 2025 22:56:33 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a839abbsm2806052b3a.173.2025.02.25.22.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 22:56:32 -0800 (PST)
Message-ID: <f14e5c46-8205-41b4-aca7-cdcb3456c7ac@redhat.com>
Date: Wed, 26 Feb 2025 16:56:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/arm: Retry pushing CPER error if necessary
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214041635.608012-5-gshan@redhat.com>
 <20250219185518.767a48d9@imammedo.users.ipa.redhat.com>
 <7caa54df-abe1-4833-bb59-cb83f8241962@redhat.com>
 <20250221110435.00004a3b@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250221110435.00004a3b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/21/25 9:04 PM, Jonathan Cameron wrote:
> On Fri, 21 Feb 2025 15:27:36 +1000
> Gavin Shan <gshan@redhat.com> wrote:

[...]
   
>>
>> I would say #1 is the ideal model because the read_ack_register is the bottleneck
>> and it should be scaled up to max_cpus. In that way, the bottleneck can be avoided
>> from the bottom. Another benefit with #1 is the error can be delivered immediately
>> to the vCPU where the error was raised. This matches with the syntax of SEA to me.
> 
> I don't think it helps for the bottleneck in linux at least.  A whole bunch of locks
> are taken on each SEA because of the novel use of the fixmap.  There is only one
> VA ever used to access the error status blocks we just change what PA it points to
> under a spin lock. Maybe that can be improved on if we can persuade people that error
> handling performance is a thing to care about!
> 

Right, it doesn't helps for the bottleneck in guest kernel due to @ghes_notify_lock_sea.
With the lock, all existing GHES devices and error statuses are serialized for access. I
was actually talking about the benefit to avoid the bottleneck regarding the read_ack_regsiter,
which is the synchronization mechanism between guest kernel and QEMU. For example, an error
has been raised on vCPU-0, but not acknowledged at (A). Another error raised on vCPU-1
can't be delivered because we have only one GHES device and error status block, which
has been reserved for the error raised on vCPU-0.  With solution #1, the bottleneck can
be avoided with multiple GHES devices and error status blocks.

   vCPU-0                                           vCPU-1
   ======                                           ======
   kvm_cpu_exec                                     kvm_cpu_exec
     kvm_vcpu_ioctl(RUN)                              kvm_vcpu_ioctl(RUN)
     kvm_arch_on_sigbus_vcpu                          kvm_arch_on_sigbus_vcpu
       acpi_ghes_memory_errors                          acpi_ghes_memory_errors   (B)
       kvm_inject_arm_sea
     kvm_vcpu_ioctl(RUN)
       :
     do_mem_abort
       do_sea
         apei_claim_sea
           ghes_notify_sea
             raw_spin_lock(&ghes_notify_lock_sea)
             ghes_in_nmi_spool_from_list
               ghes_in_nmi_queue_one_entry
                 ghes_clear_estatus                 (A)
             raw_spin_unlock(&ghes_notify_lock_sea)

Thanks,
Gavin


