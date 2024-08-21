Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0A7C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 06:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgemh-0003iV-US; Wed, 21 Aug 2024 02:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sgemf-0003he-WF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 02:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sgemd-0003nO-4o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 02:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724221525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4HzmemfS5ND5zxpCxn+qCXgOgH5RzDwi8twg24z9Cc=;
 b=Q3KWsdpMT6GGTNk07Wqqb1ExzD+0yZgWHxAxrdYYAOritNmmLjzjghm6pJXcsNBAYk+FTk
 j8bcDp2kjuRpW66gDPSPuKCUltx05gbZcwpmBMVFk/IA94EQ9yCoyRJIPsogL/Aw1OAjNI
 NAiKhYy5MLTbaSc+ljs8NplKo2uQkIc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Fk8Ddr15M--Q5T1Nqk92ww-1; Wed, 21 Aug 2024 02:25:21 -0400
X-MC-Unique: Fk8Ddr15M--Q5T1Nqk92ww-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-690404fd230so104616537b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 23:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724221521; x=1724826321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4HzmemfS5ND5zxpCxn+qCXgOgH5RzDwi8twg24z9Cc=;
 b=Gd27SddpgnnoeksnCxf+w1fFZeL1zs4xEyKatNaQiYImM2k6wbE7rzCkjkf9fEAOT0
 WWf6Ag0EGluCHxQOE3VZW1QUoVfe73r0CpwVGh7pc2XBSR+KutC1j3KUzGefEpbBsHb2
 b2s7GEKCR2Kfs/KWS35OQvfWXQTAlTJ+l5O03+K3YPLA1wVt9N/b0L427RLuEfBvHO6b
 eE2RSZS0qMs6/hBGyUKB+sQPCZDjHLq74hipcUZEHB6mpwwJoVctRqY4Imttyyt4ODEt
 Rs6S4gBkVkqsVm+x3PjIV6v+QakcKInTNzC2ULhrx7xI7aG1o8juABFDyDckCugnJW6R
 xitQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOVUC6VWzzL2koC2iPNqBUIwLMQ6Krb0flbuGgPwWVdBsoBF3Rx3enX0QgZPdo/kVDH/iZO55demSU@nongnu.org
X-Gm-Message-State: AOJu0YyHJjlpt2o0YMPKDMvyn7PHdBcXxglTQ9U7sB533DNFZZOlTTkA
 rGv3ITOIX64Ss5//b/RQ2ZHMrWi1X4IiroXPBec4kT77jIPRY6A32wYrzADHjBdcppteh2lW2QT
 7tt30VYaSwXRaI+U0lL93KJ+UBPdgvNWSXfqPzPVpxjW/UyDzq5gH
X-Received: by 2002:a05:690c:fd0:b0:6be:28ab:d874 with SMTP id
 00721157ae682-6c0f937b514mr12818367b3.2.1724221520623; 
 Tue, 20 Aug 2024 23:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT+UikJ0GLud6Sqi60Gx2naXgdk7Ea0GTtoWox6Olsd4ICMCxj+OZUapa1bzGMkOmU+0RouQ==
X-Received: by 2002:a05:690c:fd0:b0:6be:28ab:d874 with SMTP id
 00721157ae682-6c0f937b514mr12817977b3.2.1724221520109; 
 Tue, 20 Aug 2024 23:25:20 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebbb0598sm810569a91.36.2024.08.20.23.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 23:25:19 -0700 (PDT)
Message-ID: <d2371011-e7a3-42fe-b1a3-a185fbf4a612@redhat.com>
Date: Wed, 21 Aug 2024 16:25:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 17/29] arm/virt: Release objects for *disabled*
 possible vCPUs after init
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-18-salil.mehta@huawei.com>
 <51dc0813-7dc9-4927-a24b-bd718be54e46@redhat.com>
 <6b435c1f2b934867b8d82850d6d866c6@huawei.com>
 <9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com>
 <1252c2d35b3e40ed84d5d5ae454878a7@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <1252c2d35b3e40ed84d5d5ae454878a7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Salil,

On 8/21/24 2:40 AM, Salil Mehta wrote:
> 
> I don’t understand this clearly. Are  you suggesting to reuse only single
> vCPU object to initialize all KVM vCPUs not yet plugged? If yes, then
> I'm not sure what do we gain here by adding this complexity? It does
> not consume time or resources because we are not realizing any of these
> vCPU object in any case.
> 

First of all, it seems we have different names and terms for those cold-booted vCPUs
and hotpluggable vCPUs. For example, vCPU-0 and vCPU-1 are cold-booted vCPUs while
vCPU-2 and vCPU-3 are hotpluggable vCPUs when we have '-smp maxcpus=4,cpus=2'. Lets
stick to convention and terms for easier discussion.

The idea is avoid instantiating hotpluggable vCPUs in virtmach_init() and released in the
same function for those hotpluggable vCPUs. As I can understand, those hotpluggable vCPU
instances are serving for two purposes: (1) Relax the constraint that all vCPU's (kvm)
file descriptor have to be created and populated; (2) Help to instantiate and realize
GICv3 object.

For (1), I don't think we have to instantiate those hotpluggable vCPUs at all. In the above
example where we have command line '-smp maxcpus=4,cpus=2', it's unnecessary to instantiate
vCPU-3 and vCPU-4 to create and populate their KVM file descriptors. A vCPU's KVM file
descriptor is create and populated by the following ioctls and function calls. When the first
vCPU (vCPU-0) is realized, the property corresponding to "&init" is fixed for all vCPUs. It
means all vCPUs have same properties except the "vcpu_index".

   ioctl(vm-fd,   KVM_CREATE_VCPU,   vcpu_index);
   ioctl(vcpu-fd, KVM_ARM_VCPU_INIT, &init);
   kvm_park_vcpu(cs);

A vCPU's properties are determined by two sources and both are global. It means all vCPUs
should have same properties: (a) Feature registers returned from the host. The function
kvm_arm_get_host_cpu_features() is called for once, meaning this source is same to all vCPUs;
(b) The parameters provided by user through '-cpu host,sve=off' are translated to global
properties and applied to all vCPUs when they're instantiated.

       (a)                                            (b)

   aarch64_host_initfn                          qemu_init
   kvm_arm_set_cpu_features_from_host           parse_cpu_option
     kvm_arm_get_host_cpu_features              cpu_common_parse_features
                                                qdev_prop_register_global
                                                  :
                                                device_post_init
                                                qdev_prop_set_globals

For (2), I'm still looking into the GICv3 code for better understanding. Until now, I don't
see we need the instantiated hotpluggable vCPUs either. For example, the redistributor regions
can be exposed based on 'maxcpus' instead of 'cpus'. The IRQ connection and teardown can be
dynamically done by connecting the board with GICv3 through callbacks in ARMGICv3CommonClass.
The connection between GICv3CPUState and CPUARMState also can be done dynamically.

Thanks,
Gavin


