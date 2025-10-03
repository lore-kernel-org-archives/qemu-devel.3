Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89249CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 07:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4aBN-0002Av-6s; Fri, 03 Oct 2025 03:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4aBF-00029s-2t
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 03:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4aB3-0002nO-PW
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 03:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759476356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAOoG+vGKs/VAvoeIIqDnbq7u9S4SeuHXDsEPfVbHfQ=;
 b=ZNFgagvvPnJ/RED6zsdAO/cahVppdEdJBjAGTHORF+T+YyRZf4UD87Qu4z6xAkbaQCNloV
 /zT9bMUW1yu2olCJZDf2uUD1j0Ac4bgosqgBKGRSf1lpbax+OzFCMdZsvggOChoP3jndX2
 WZmv1UuwOJDE3iO1OqkYd2h95ekoOGk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-aNM4doTQNkqzPS9bH76Djw-1; Fri, 03 Oct 2025 03:25:54 -0400
X-MC-Unique: aNM4doTQNkqzPS9bH76Djw-1
X-Mimecast-MFC-AGG-ID: aNM4doTQNkqzPS9bH76Djw_1759476353
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3fba0d9eb87so767826f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 00:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759476353; x=1760081153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QAOoG+vGKs/VAvoeIIqDnbq7u9S4SeuHXDsEPfVbHfQ=;
 b=oR2GarQvMBNB/tpudVJ0v+UmXaPnwsG8TYzQBtbQ3k1h5UB31NpwUmrSw5C3jR2jZ+
 E4ZzJQ8VttmTplKYn6FYiu7GlR7EglEDjBBtAIxfoR77aTKZjQKY8T5+e+90OmXT8RXU
 MPNBjCyxJREJKMsSOGpLzPqynFmXSsaS1qWAwvKjitcWDhmSBT4KmkuG+S22ZKmZu+9L
 U5pn+YnSrtpmaqRev1048LW9FGyqMcH9PDhbEZ7Uf6bV7TrAk/2A2hQwD/Ho6KUYqYVX
 F88DIIVw299nVPFosPCtVSG2RPrycxYuEJiNNSmlxeOWttIjmkZ7mjCLllVbJGdLvp28
 KnIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/1M6y86FU5QGfIZlQB4VR4wBCQDJSloq6x9664Ji7ICDBPy3/BLpKtaKdLXq0+ZRMFa5/ZuStsrXC@nongnu.org
X-Gm-Message-State: AOJu0YxyLhJ0JgTMW5t0wnl6uigCC//G9HjJfGoyDyTqLzXHyX2MuPjE
 a/c6m4YtilkkkNyroRRIBMZeZkDYw53oqjeBKO8sKsT82cq3srCrnvnYpTP0xbPsxShEcdfXTd8
 rJmO8BmueVuM+tYsEyOYE3qWZkdAcrm0mitTRO2AQ88edB2qqvpTmX/bg
X-Gm-Gg: ASbGncu/Uhg6BvhqXaFc9cZomOtLkdzYHPmPIceyMDOHHpmsteiOtMZ2NDXqdxfS1wq
 /QY89KGe49mwAuXz0Zk1HA8Guq7o5w6/By3z5fJ/jdWFh3tyHhrGH4pQ4UIJ5O62mSoAvlqJhBH
 o2cC7E+U3tC0W0VBl4EM/vevIgeMGmThDqN2qMxkIDRX8skLk6iHn2ZXT1VirLK0fzIVw1VpQBd
 FsrX6In9p1zM+FtOOObqBCQ10IfQDjoMbZgJ1tJ4HIYrA20wkneI1NCHVuWG1cCu7qfWXFTZPO+
 p3k4Ze3RzWTKPYxivAAqDTdAMR0k6GuCr3/jaO7qUONcz0lTFPpgiveJ2DRnSRAnxc3jTHlO+qX
 r6IlVsiV9Lh57RLiQ
X-Received: by 2002:a05:600c:a11:b0:46e:33a6:46b2 with SMTP id
 5b1f17b1804b1-46e71109edfmr13346485e9.12.1759476352935; 
 Fri, 03 Oct 2025 00:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN6aRXZnWy4PDJBAKpRA5uFyF8D9mVVhUeOnY4k8Ev9BmmUp9jbB2HfKlIDB9SQFO4tzv5gA==
X-Received: by 2002:a05:600c:a11:b0:46e:33a6:46b2 with SMTP id
 5b1f17b1804b1-46e71109edfmr13346235e9.12.1759476352473; 
 Fri, 03 Oct 2025 00:25:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723591fcsm17742725e9.10.2025.10.03.00.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 00:25:52 -0700 (PDT)
Message-ID: <b2ae3dc0-9bf0-4e89-a995-b97410d57861@redhat.com>
Date: Fri, 3 Oct 2025 09:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] target/arm/cpu: Add new CPU property for KVM regs to
 hide
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, maz@kernel.org,
 oliver.upton@linux.dev, gshan@redhat.com
References: <20250911134324.3702720-1-eric.auger@redhat.com>
 <20250911134324.3702720-2-eric.auger@redhat.com>
 <0f05a0ec-8b98-a9b7-6e3a-9ef73d0c34e7@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0f05a0ec-8b98-a9b7-6e3a-9ef73d0c34e7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Sebastian,

On 9/18/25 6:16 PM, Sebastian Ott wrote:
> On Thu, 11 Sep 2025, Eric Auger wrote:
>> New kernels sometimes expose new registers in an unconditionnal
>> manner.  This situation breaks backward migration as qemu notices
>> there are more registers to store on guest than supported in the
>> destination kerenl. This leads to a "failed to load
>> cpu:cpreg_vmstate_array_len" error.
>>
>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>> migration from a host kernel which features the commit to a destination
>> host that doesn't fail.
>>
>> Currently QEMU is not using that feature so ignoring this latter
>> is not a problem. An easy way to fix the migration issue is to teach
>> qemu we don't care about that register and we can simply ignore it,
>> including its state migration.
>>
>> This patch introduces a CPU property, under the form of an array of
>> reg indices which indicates which registers can be ignored.
>>
>> The goal then is to set this property in machine type compats such
>> as:
>> static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>>    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>>    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
>> }
>
> One thing worth noting - once this series lands:
> https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/
>
> we might need to add a bit more logic here. Either using the kvm
> interfaces (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2 when the register
> value is 0) or qemu knowledge (only ignore KVM_REG_ARM_VENDOR_HYP_BMAP_2
> when the impl-cpu property is not used).

Effectively if we "hide" KVM_REG_ARM_VENDOR_HYP_BMAP_2 on save/restore
we must enforce the reg is not used by userspace.

One way would be to test whether KVM_REG_ARM_VENDOR_HYP_BMAP_2 is hidden
in kvm_arm_target_impl_cpus_supported() and if it is, report false.
However for every new functionality in qemu it does not sound sensible
to check whether new KVM regs being used are anonymously hidden.

Another way could be to fail kvm_set_one_reg/kvm_get_one_reg in case the
register is hidden. That way in Shameer's series, kvm_arch_init_vcpu()
would fail if BMAP_2 is hidden, ie. in our example for all machines
types before 10.2. By the way adding Shameer.

Thanks

Eric


>
> Sebastian


