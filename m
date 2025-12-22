Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F9AE674B0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXfsE-0001PK-6m; Mon, 22 Dec 2025 08:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1vXfsB-0001Os-Ep
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:22:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1vXfs9-0006Zn-RG
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766409768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsN2ky6v8cWwIdyRQRPpTxLIkdJ4PWbC9SoOHO18Y14=;
 b=YDqzvVe5TG5v5IZViWYRW/WiuXHwDiJTOkifoxxwF8w7Du8aHjeZCILbRVB6V+3UU/vnJN
 WtFh+fuvj6E7DPqEB4utc0RJvCQS6eAJ7qeM+Dc7VIDhOVtt3XMqGFU4rUU0zZDulvubM6
 /fJtCyL5eGXPo3pLr7bg53Cqp3Y/g84=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-pdJ05mtqOjCqNLUL5yCEdQ-1; Mon, 22 Dec 2025 08:21:40 -0500
X-MC-Unique: pdJ05mtqOjCqNLUL5yCEdQ-1
X-Mimecast-MFC-AGG-ID: pdJ05mtqOjCqNLUL5yCEdQ_1766409699
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47777158a85so46173665e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 05:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766409699; x=1767014499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vsN2ky6v8cWwIdyRQRPpTxLIkdJ4PWbC9SoOHO18Y14=;
 b=ZR53FELKjNQIBnXcMMRkVcmxfyyZ2B8Cj9ndL41tocyPIc776V1rXWmqcib3x3rnNX
 IJ1U3tUScDCe1s5BO82BqHc46RVay1zW3VVKzN+PCZmpvI640fmQ3B+vgLdSgPvUX5g2
 8XY17Obxo/iTRbxN0T4sS5iE0LHofWFlf1MUQxTnKnb1/CjjhIUrs5vTwR340XMrM09Q
 CRh3814NoBbC/+fLcF48zvuvTIqB23pD64xZyzJo4Irb/sX03iWrcoGKH9OrvxtPJnag
 zT5kKQnEad9x81SfZuFHJda7J+9w/51OTBPQa+hINXLarozmGi8D+PQnahUd87sscN46
 hlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766409699; x=1767014499;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vsN2ky6v8cWwIdyRQRPpTxLIkdJ4PWbC9SoOHO18Y14=;
 b=alEVFBXl3ZgD6dVEHQN2XBOevf4Ao/vcMaxPLdVumo3Ts1pD5l2BIYgn8+Y0oMUnmS
 zYp4gznHzxPhudXsFuinBRS6G/P6p+3HdzwNcL0ntBUfWxxeyhI03qlsRB4IFT5wk9XA
 08nozorGSjKzzYqDeUl3tCxODuMQchrMEO/+JHzbY6PkeOr5tQWQcv2VuCZ8QSJ5g4Gv
 0q3AwPDfyRg60/bVm+1WlaNgHDz+C0u3Kv9zFe5qiR/fZivUK786BO5GamIVsSrwwNzH
 hIFSBpl5jhzUhu2sXi8MN3/Bh3dFFhgajq9WSQg+NH7xDMyta3Zc9ziXWtuf1tRaXQ3T
 MTFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV3n+t1BdqPAXQPhRLLjUAwpX2lLnlkqL0N9PCiQ3QJVEbJYt6T57M/mwHESIYv/BgCrd77lMwpFkS@nongnu.org
X-Gm-Message-State: AOJu0Yz6r7/bhdgsG0PmbtcSuJLORDdcPDhFHFUHtCfamdTc+wII+EHN
 XJM6VUKpVY41Yq6yOhkqouwKwbpE0FKtSJaxAz75HZjhtYyyzk/tX9z0RKQsVqeoXZ6wCJxG6fw
 yuKQ9C1bYv8WoBpGQ3aLhLUPRdha3twebBuWCPS4/wJrcGX4o+/Hl9LQp
X-Gm-Gg: AY/fxX7HLJWK3FKZ3Wm7dCb0frdbPSkPkB9TBlS4+XOZ57xZha4BV210UnY0Y4Fge1C
 kd7snLAuMMagyskUMSDl5nPs2KS0Vj1nn3mP/ztoIwH476Y0aVSuh2LV2nCkXa2c3rYhuR7hTph
 OgNAB+wCoz8HD4Kzi2W0IGx3ovWP5IpKDCXzBLnlItZY4HCTd7f/G2e/nmKAItv5IRHiPkhV6Q3
 0/epXg/h65/pookoOdsCu4qkDgw1d6fPKyogu5kdwhUw5weoTWB0PlV0aWrRdcoyFgbSAUZMHog
 2ndaDXa6JRWP0MIus5O9pRi9446wVe8hleSc7Z6B6ixTPbd7s6cMuZ7EIm6zsnSgWH/+aXZaU1x
 K3YEpc+l+e6Ozka8yfar6LjdIpiOjuDr9YZa6QrRpA2zeMoqjkU78
X-Received: by 2002:a05:600c:450e:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47d195bdffdmr124793375e9.31.1766409698808; 
 Mon, 22 Dec 2025 05:21:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk4gABJm0kYs/03DjxIfHp5ZtGlpI0pFZPigwXL0rMSMHE7rAN50MclLDU52wytNZgUrbnuA==
X-Received: by 2002:a05:600c:450e:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47d195bdffdmr124793155e9.31.1766409698384; 
 Mon, 22 Dec 2025 05:21:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be395d9cfsm100738605e9.0.2025.12.22.05.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 05:21:37 -0800 (PST)
Message-ID: <f38ee951-35fa-4db6-9c3c-ea4e26f65b00@redhat.com>
Date: Mon, 22 Dec 2025 14:21:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] target/arm/cpu: Allow registers to be hidden
Content-Language: en-US
To: eric.auger@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-4-eric.auger@redhat.com> <87ms4aoxg9.fsf@redhat.com>
 <6bbc1612-389c-4fa1-9fbf-354209fb6b1c@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <6bbc1612-389c-4fa1-9fbf-354209fb6b1c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Connie

On 12/22/25 2:17 PM, Eric Auger wrote:
> 
> 
> On 11/25/25 6:04 PM, Cornelia Huck wrote:
>> On Tue, Nov 25 2025, Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> More recent kernels sometimes expose new registers in an
>>> unconditionnal manner. This situation breaks backward migration
>>> as qemu notices there are more registers in the input stream
>>> than supported on the destination host. This leads to a
>>> "failed to load cpu:cpreg_vmstate_array_len" error.
>>>
>>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>>> migration from a host kernel that features the commit to a destination
>>> host that doesn't, fail with above error.
>>>
>>> Currently QEMU is not using that feature so ignoring this latter
>>> is not a problem. An easy way to fix the migration issue is to teach
>>> qemu we don't care about that register and we can simply ignore it
>>> when syncing its state during migration.
>>>
>>> This patch introduces an array of such hidden registers. Soon it will
>>> be settable through an array property.
>>>
>>> If hidden, the register is moved out of the array of cpreg which is
>>> built in kvm_arm_init_cpreg_list(). That way their state won't be
>>> synced.
>> I'm wondering whether the patch description should also mention non-KVM
>> cases (e.g. the bogus reg that was exposed). It might also make sense to
>> merge patch 5 here?
> 
> Actually the AArch32 DBGDTRTX is not "hidden" on destination but rather
> marked as safe to ignore in the incoming stream (so the other category).
> So I don't have any example of TCG usage for this category.
> 
> wrt potiential merge I agree they could. 2nd patch is an enforcement of
> non access so I prefer to keep them separate but will put them
> contiguously in the series. 
Sorry I mixed up with 6/11. I will squash 5/11 in this patch.

Thanks!

Eric>
> Eric 
>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Otherwise, LGTM.
>>
> 



