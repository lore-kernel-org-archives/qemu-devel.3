Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C00EC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 00:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjp1D-000257-3n; Sun, 16 Feb 2025 19:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tjp1A-00024Q-Rw
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 19:29:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tjp18-00045j-Fa
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 19:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739752183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXJNdbq4maba12nquUSj5Dc56qd2/s7ETawfKG9qXSg=;
 b=aR3obX9zdyYNxHLlt9E858JZEZKbwu2dyVz3V5H0UuD3vtH0USszleD+OSRZDXXKMn45Xc
 FktZn3TKcStE8PeIX4aKTQuDUftkrRcoXo4KUBsGIhh1r62HpiCkCimaIH5UfnCX3Qqe59
 StdThYnCJjI2W+cAH9s1v4UpSCV9y2Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Vrnz3Xa_P4ibE7KtcLRgEw-1; Sun, 16 Feb 2025 19:29:40 -0500
X-MC-Unique: Vrnz3Xa_P4ibE7KtcLRgEw-1
X-Mimecast-MFC-AGG-ID: Vrnz3Xa_P4ibE7KtcLRgEw_1739752180
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22101839788so35608395ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 16:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739752180; x=1740356980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vXJNdbq4maba12nquUSj5Dc56qd2/s7ETawfKG9qXSg=;
 b=M55RWN7CuCXYGA8FbJzBR0fXn2dbWxoe6knP7e7DVDUK2d6lt/kQ4jgp7KRCq5QGF5
 IAL03ukfk9Qz1D2kRrZARqCMQcqMoPwOOWxjkTUPyaZznkKLVWOUZ23HUNGmXRTnlNwI
 enRH/j7+2xjx/FM4OIh316thOcnK7ZKFIKESkjNB5KBwGE/2WndeTKwQ1RDuVSkBCuUM
 G9+nk3SEXXR+0uaQqeksamyuLIAaeiWwJ3gTtb6jhQRRjMJmZ2hZRAzutM7gOnt1JTOi
 6nt22v4RkxCt2vRiZqSRtFTA2NNkP1QiYa/IO3h/mGZXpJ51AVyWR0qFYSo6b17kstw8
 wPqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNpu26DnoPfMCfxqRN/HD0BS1yLsM0EXXgRfAnlxIwQjNFrJjTQ+4VSsiBbhVF3ecA54RhFqYy/iEV@nongnu.org
X-Gm-Message-State: AOJu0YygGSlH37VFtmxdI0NouX38Fu5couwaEiya0aD30WOsS4sV4q0l
 sUhf4X7Dpl+t6tumJobq8E5Zmavd+mrx7feC+/Fn2tham+rrgLk06kxKFCXFfc0kF6RPwpeKCm0
 yZdsJZXxAeWrCladB+EbiRMo54jpRZcXxuprHWj+EWZWUIYsS0oGi
X-Gm-Gg: ASbGnctZJdkMSnafb221NZErSxYv3TLpxjp0xfh1RSlE382kTzZ5Wlnfw731JFq+vGl
 w+Kap3aqDQuYnJR5r7YsTYLmrZGmokAFVHrTo21APePJDk1cSqwVxFZdYXQH35cL7S2G0xZICyL
 bjJ1VL0Amx0qij2fJaaRimhVQmsmzoxoUDK/KKQnXI4crbu0gt0z7h7dabM62QdoAgtjCVtguzy
 lZDlOd9ynAifL7lJXV2VwyrQYAUmFvl2yq2F/QMxlKq60H/01S27gIsYq95s7DegSeRrj48SWZf
 rc10zw==
X-Received: by 2002:a17:902:cec9:b0:220:bc9e:ff4 with SMTP id
 d9443c01a7336-22104062cebmr123387365ad.28.1739752179786; 
 Sun, 16 Feb 2025 16:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8Iiq/Z42clWvfadWkyFFA9PHMUM0Hj/NRZoVODo8HG8gV8SluVOUO53FXzfsFVIouXoHmsg==
X-Received: by 2002:a17:902:cec9:b0:220:bc9e:ff4 with SMTP id
 d9443c01a7336-22104062cebmr123387045ad.28.1739752179352; 
 Sun, 16 Feb 2025 16:29:39 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d558527dsm60793765ad.219.2025.02.16.16.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 16:29:38 -0800 (PST)
Message-ID: <b6699187-a720-4fbd-a57c-a7bd86d7621b@redhat.com>
Date: Mon, 17 Feb 2025 10:29:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Improvement on memory error handling
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214095353.00007afc@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250214095353.00007afc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 2/14/25 7:53 PM, Jonathan Cameron wrote:
> On Fri, 14 Feb 2025 14:16:31 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> Currently, there is only one CPER buffer (entry), meaning only one
>> memory error can be reported. In extreme case, multiple memory errors
>> can be raised on different vCPUs. For example, a singile memory error
>> on a 64KB page of the host can results in 16 memory errors to 4KB
>> pages of the guest. Unfortunately, the virtual machine is simply aborted
>> by multiple concurrent memory errors, as the following call trace shows.
>> A SEA exception is injected to the guest so that the CPER buffer can
>> be claimed if the error is successfully pushed by acpi_ghes_memory_errors(),
>> Otherwise, abort() is triggered to crash the virtual machine.
>>
>>    kvm_vcpu_thread_fn
>>      kvm_cpu_exec
>>        kvm_arch_on_sigbus_vcpu
>>          kvm_cpu_synchronize_state
>>          acpi_ghes_memory_errors         (a)
>>          kvm_inject_arm_sea | abort
>>
>> It's arguably to crash the virtual machine in this case. The better
>> behaviour would be to retry on pushing the memory errors, to keep the
>> virtual machine alive so that the administrator has chance to chime
>> in, for example to dump the important data with luck. This series
>> adds one more parameter to acpi_ghes_memory_errors() so that it will
>> be tried to push the memory error until it succeeds.
> 
> Hi Gavin,
> 
> +CC Mauro given:
> https://lore.kernel.org/all/cover.1738345063.git.mchehab+huawei@kernel.org/
> 
> is more or less reviewed subject to some requested patch reordering and
> whilst I haven't checked, seems unlikely that there won't be a
> clash with this series (might just be some fuzz)
> 

Jonathan, thanks for the pointer. I didn't notice there are pending acpi/hest
changes. The changes clash with those included in this series, I will take a
close look.

Thanks,
Gavin

> Jonathan
> 
> 
> 
>>
>> Gavin Shan (4):
>>    acpi/ghes: Make ghes_record_cper_errors() static
>>    acpi/ghes: Use error_report() in ghes_record_cper_errors()
>>    acpi/ghes: Allow retry to write CPER errors
>>    target/arm: Retry pushing CPER error if necessary
>>
>>   hw/acpi/ghes-stub.c    |  3 ++-
>>   hw/acpi/ghes.c         | 45 +++++++++++++++++++++---------------------
>>   include/hw/acpi/ghes.h |  5 ++---
>>   target/arm/kvm.c       | 31 +++++++++++++++++++++++------
>>   4 files changed, 51 insertions(+), 33 deletions(-)
>>
> 


