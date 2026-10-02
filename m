Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28ACCA5FCE
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 01:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCRiS-0007eY-Pa; Thu, 01 Oct 2026 21:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCRiI-0007dg-DK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCRiC-0002EZ-WF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790903119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfzSr9M4NonLeNy7xs2adYXrLZZ6EwDKmwFESBpV9/o=;
 b=BRxLjL2Gw4rNalNK86mAfBl5f4jcaCIUso5XfvmgIu+zWJGh4wghCFw1831j6XO40gK8U8
 PYw5Rsz1bFJT0DeCis0eXoaqiJUZ2uAmD91h/242YqT60+fpOxP8VxWKjRuPuguAv4p9Qh
 H1tBYKdwyADnGvhg8n6tAeogtJms8J8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-57GuK0l3NLyHeagLzsFnUQ-1; Thu, 01 Oct 2026 21:05:17 -0400
X-MC-Unique: 57GuK0l3NLyHeagLzsFnUQ-1
X-Mimecast-MFC-AGG-ID: 57GuK0l3NLyHeagLzsFnUQ_1790903116
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e3f521346so7409183a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790903116; x=1791507916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YfzSr9M4NonLeNy7xs2adYXrLZZ6EwDKmwFESBpV9/o=;
 b=sehUm2se0nGYA97inAMMz/Km4iq2YfXRPXG2+EiiNET3TBRyQIcBvDpw74tTmWQZ92
 nblc+b486rgcw/1nJNhnMjxkYwlA5HFDNoCDWLfjIeFJBM++f/zPcT+mMqL6Uh5gFs7L
 yMEHpsiPRrMieVn5lC9i5gCWMbDgBTpsubSTjZ3rFQR8PjpEg+yQQThYDJK9Ugz/dcpH
 G4ueVIC8wb1dUPICq64thLzS0Pczd1m2KBqX/NNfv8fJ6m9PBhqf+OdY1VBYAZRLBrIj
 WrzMftwj+vtnLhqDbimZdvK3O8gypGb6rDfuQoo+ofXn/r9GoSFfcsNJyiXHfoYTnYmX
 0XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790903116; x=1791507916;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfzSr9M4NonLeNy7xs2adYXrLZZ6EwDKmwFESBpV9/o=;
 b=P4IN6CJj87L+zCDvw7piBel19TXv6dFX8e8yDQXAevPkmerbkoY9IiolHjtyBwC7qu
 XlAs3j6qiMN9anppC+z7icZvHCxGQGBFbLsN+InvThWMTIwhgdN49tAYR7X59V4j1jD2
 tR4ZWIzIbqWQKTKumVLp6BbVUi7Y9d7jxuId4BGRhgKRfVAWN6m6V/UdEb18x4prA5GU
 rhgup11jL4ifsw6+0tC5QKyiY9Jj4n7ONyWwjJ1H89bO7h1AdUcgQwv7nlu4xJrpQCIX
 jme0jo6p1OeTdfF8628lyxk2a0FDHzwRVxyBcrpRZt4HeK/lT/E33RKxovoAHuVrGdbP
 6/2A==
X-Gm-Message-State: AFq9FYIT4aGATrwAZTqImWhAhuuLfAwvHMATaDGrnkmr6ldmoiPg1+tT
 BLgg6P5pE3W5fF2zkk8pTeyW+1ryeqmE4GdFlclqd4N9PA3XmBTqyDMubuawff6ZIR4uyHPiFqr
 mLf6eBi2umzzZ1ntoJcMSzcnPdsuoLzN2UD0o8sy925IdsITX1GQTqNW6
X-Gm-Gg: AYBFou09iKjQtU6Awu0qBBdLbJEVx/oYfk9MmgiIHeCmw6q5JmTu13WefK/DWyt008n
 xXrPT46coVC7Cpcmq2zl+Pvv0CVuDfiN3+1+tCxAXKjp3IOlNwnQtmmgTHOfJeEgkNEy2tg0nDV
 hXKjyHrMncH+qY1MabvO3rQ8LrCBqLQyCuLlksObldsbGW2XMQar3PgKBv6rLfJa0y9HgNS+lvU
 Jmsua1IdtOMMMOxj4HZs3jtNPi4fJ6WwUfsJm22GxlP13ygdQRzvGH8JnoDALa4jDiPeWZEjUGZ
 2aEUDx2CgGMR+p/Dvm4j+hP9/w+zAQM+e8BH/2PU5bH0Rv5ekOX+Hca4nsjJY78igCKIz2yhGII
 FbQ+lPQKSzM7Xyzy4Jrc2JckIMLfQk9XN7XJH/+FlXg==
X-Received: by 2002:a17:90a:dfc6:b0:3a4:eebd:2410 with SMTP id
 98e67ed59e1d1-3a6ce993df6mr1096503a91.37.1790903116265; 
 Thu, 01 Oct 2026 18:05:16 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc6:b0:3a4:eebd:2410 with SMTP id
 98e67ed59e1d1-3a6ce993df6mr1096480a91.37.1790903115746; 
 Thu, 01 Oct 2026 18:05:15 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6e7401d04sm198743a91.14.2026.10.01.18.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 18:05:14 -0700 (PDT)
Message-ID: <d04fe4a6-4418-48b9-b2ed-cce6278e0081@redhat.com>
Date: Fri, 2 Oct 2026 11:05:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-8-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a Realm is requested, create a scratch Realm VM by setting bit 8
> of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> for the guest PA size.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4c6da1fb9f3..d86e66e056b9 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>                                         struct kvm_vcpu_init *init)
>   {
>       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> +    MachineState *ms = MACHINE(qdev_get_machine());
>       int max_vm_pa_size;
> +    int vm_type;
> 

@vm_type can be initialized when it's declared.

        MachineState *ms = MACHINE(qdev_get_machine());
        int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
        int max_vm_pa_size;

   
>       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
>       if (kvmfd < 0) {
> @@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
>       if (max_vm_pa_size < 0) {
>           max_vm_pa_size = 0;
>       }
> +
> +    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);

() aren't needed.

>       do {
> -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
>       } while (vmfd == -1 && errno == EINTR);
>       if (vmfd < 0) {
>           goto err;

Thanks,
Gavin


