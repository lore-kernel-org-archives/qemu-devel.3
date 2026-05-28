Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2198CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 17:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSeZp-0004hW-KY; Thu, 28 May 2026 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSeZn-0004hG-Nu
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSeZl-00017s-B4
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779989480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0MvIsOMtx2WQpp0fYhvBDybCxrQLnoGgi8za0wNTLo=;
 b=T5iq1aoe813NJeS+g0061RQrRhvvIVUoOwY1AA7C71NWIdjowwpr3oFH13W1cHN84+qGUw
 iXwTuJL7pBv2IlExzBU6WbN68PgVd6XV3VzxjYIRwsj/BFtSzrERtTMFS62b5vfc6a3mHB
 jwDAujKNEWiAGRYfVj6xe7ArpOw3fAw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-vICBehStObal-SfKoiK30w-1; Thu, 28 May 2026 13:31:18 -0400
X-MC-Unique: vICBehStObal-SfKoiK30w-1
X-Mimecast-MFC-AGG-ID: vICBehStObal-SfKoiK30w_1779989476
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45e2f74da10so12093468f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 10:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779989476; x=1780594276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0MvIsOMtx2WQpp0fYhvBDybCxrQLnoGgi8za0wNTLo=;
 b=exdXIswV8TGHt71sE2vIaxjcsCLGxWDXOQoCNhk85vTEA4pxH6xS0ReirjkoNOHR3y
 OriOAu2+3DYehb3U0tW3FE//vdh9GB8yp/L1wjmrr2j+XP8vLqXu62oCKJYzPByt4JZ0
 oUTJhxCyTc+gCmEBbdxO3Zk0d1DZJw/hXlM3z9V1zYCikLS1j1c6iKFh1w0Bv+zcWUuu
 3InFZqnUGnEiXApEkcLPuFmx6HnlqRVWr97CBVlYLwUbst74RrCCGQAbgxW/28rM521n
 RqNPrDVc6pfFFqGpFo4bg3FqS4IDs5dpkYgri/YRj8SsgNbx29vsB7pkv9+uorM65UbV
 DZ+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7fScXJ9/RTXMCEpSrqKPgn/gk5rkWNsxDDKBCvfvIhceWKmSvUoZqmnJszkO6L8IRzQ5czsH08/B1@nongnu.org
X-Gm-Message-State: AOJu0Yz088b+xpy9lFjAS4yqOwKNKIFJhEqLExu3Kp/5/Itjhiaf40pA
 8yxryGA00N3TXMncboPFMvhNFva3J8i3+lraHyb7VKWi1INa4JCEIMMRjEIvbY/1v2dQLM+eQzE
 vh2qcUhyZ1nDnGvwdl2s+jSNhd9ghQAjbRsty9zJY2fDZM919rMdScY3y
X-Gm-Gg: Acq92OHHGsYi51pTZuDzuaR/e0GZ6qf8HAVRR3qKGZ2ycVfzy+bGZPQR970aSSs9uhs
 UbhtRrUHMDaZycgru/SwiF2hRmaSOhN5PyUUf61ouZ9SEVqrR/yvYaZhj87wiOrzlk6+EDBcDZW
 sOa+ws++UloUPhKcGmPlbnxmproqUrgBch1cTJ7j8+2Sb0kXyKTMVwtClSk0/HsE6muy2i37SBJ
 d/O5VZvpGPUxIYucpwjlwYusm3c+HwVQDx8ifs5BYCmFYuhjYSZugeVznh0nuMh91tSkwmEAlSH
 UbWqedybJWaQjkvL3a4rrprz94XGbcGK9XdXtwUlCmIisQLV0mbFSEykJyfH6dDJUntlnSfeEnD
 xHvsK3cSHaiQBsMvj+7SuyoU6CMm0NdXmG4ZRer1Log3CpgVYsdub5W2lUXPnuafDclZL+k2Z7f
 H5QnYk
X-Received: by 2002:a05:6000:4698:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45ef02895dcmr144932f8f.3.1779989476321; 
 Thu, 28 May 2026 10:31:16 -0700 (PDT)
X-Received: by 2002:a05:6000:4698:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45ef02895dcmr144891f8f.3.1779989475906; 
 Thu, 28 May 2026 10:31:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b2bbfsm15454279f8f.32.2026.05.28.10.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 10:31:15 -0700 (PDT)
Message-ID: <ad70e8f8-0dbb-407c-828e-96b9da188974@redhat.com>
Date: Thu, 28 May 2026 19:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/18] target/arm/cpu: Expose writable ID reg field
 properties on the kvm host vcpu model
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-17-eric.auger@redhat.com>
 <30F66A6A-E26B-486C-81D1-8E1B2CCB558A@nutanix.com>
 <6c14a58a-60ab-419f-9395-ca3489f6cff8@redhat.com>
 <CA136979-E0CC-420E-9271-63CF27CD7DA5@nutanix.com>
 <2fd2057d-c74b-4bbe-b2d0-cb9ed092a37d@redhat.com>
 <6F6ECB0E-82A8-4FFA-8687-2D6E243A2096@nutanix.com>
 <8ee2b611-ef48-4805-aaf0-087856dc30f0@redhat.com>
 <7737B413-51C1-49FA-AC0C-31DCEE1FD45E@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7737B413-51C1-49FA-AC0C-31DCEE1FD45E@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 5/28/26 7:29 AM, Khushit Shah wrote:
>
>> On 27 May 2026, at 10:50 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> My reasoning was:
>>
>> arm_cpu_post_init
>> ---> kvm_arm_add_vcpu_properties
>>     ---> set_sysreg_prop set the new value in cpu->isar.idregs
>> arm_cpu_finalize_features
>> ---> arm_cpu_sve_finalize
>> ---> arm_cpu_sme_finalize
>> ---> arm_cpu_pauth_finalize
>> ../..
>> those fonctions do some subsequent isar accesses
>>
>> So I think in general id reg field settings are applied before composite
>> legacy options
>>
>> Thanks
>>
>> Eric
>
>
> Nope, kvm_arm_add_vcpu_properties, just adds KVM specific properties.
right, wrong copy/paste. kvm_arm_add_vcpu_properties just registers the
props
>
> Right now, set_sysreg_prop are called along with legacy props during
Yes options are applied in order but the difference is ID reg field
props settings directly touch the isar array while others are stored in
some temporary field in either machine or cpu code and analyzed later,
for what I see in arm_cpu_realizefn(), either in
arm_cpu_finalize_features() or directly in the body. So isar access
related to compositive functions should be done after those related to
new SYSREG_REG_FIELD props. However I acknoledge the requires a case by
case check and testing.

Thanks

Eric


>
> The call stack is:
> machvirt_init
> ----> set cpu specific machine_props (has-el2, has-el3, mp-affinity)
> ----> dev_realize(cpu)
>   ----> set cmd cpu props (prop set in order they appear in cmdline)


>
>
> Warm Regards,
> Khushit


