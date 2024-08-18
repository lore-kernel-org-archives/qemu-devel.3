Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935E6C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 05:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfYDf-0000n1-EA; Sun, 18 Aug 2024 01:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sfY5m-00005F-Qa
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 01:04:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sfY5j-0006p6-Px
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 01:04:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2021c03c13aso5171045ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723957474; x=1724562274;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sZ+LIAc3QMZqw0yyNXj1qvsR8K2wANH+hx/jLi8jpdA=;
 b=wqW3syI/JTYv0alrTLGRbX382LW+aD+n2wdezNhEKjn/6r/fwsO05Nmhf/2FKzq8X4
 KuZq2caq/DXK4LR3Vr1Uv3ceB04PcihAyqzUyTvsIJwvK98PBTkR+Vjdl+vLW2rH0cAz
 rB51wQI/cbQH1/n1au5/RCfY5urLYgUaKJy7/KvVEmsw1qInrcWsm8BnJiA7LMeBrlDT
 HR7T11nCKjmjbxYTGtsypo7iwCpPJMbXHabKchiJtUN7y9Q27TaojJZCEnqsEuhGBfnY
 nFU808ERPJ0Gvl8pHwIiIFwV//3XL6H7CR8qSbOVBWOcC8kKJVVBpy9dNrx4W+3iZ2a/
 FmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723957474; x=1724562274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZ+LIAc3QMZqw0yyNXj1qvsR8K2wANH+hx/jLi8jpdA=;
 b=W6BkRyw0t01obsqpsBSnGUk39uqHIHovNTXrjQ+qyiZpm0QU/nIs9RyTYBywcog+it
 AEwql+s9ze4W+1O7aH9we2o8pHwH6jr3Ufrms4jWmKkYP7DckqwouTG9m3/13CHO27Z2
 wiSY5B/SAzTPU6EzkRHT6C173JFiDKIaDsbzQ6daVXRnod+oGCAWNNQD4XtJyxZItDT6
 ZuG6DCWSCQItX7Wsf8++Yj6/IT16eRtTsfvcnGhhptY5pEDNiFiLisG0Fb139WJC1RjI
 dR9Bf3JOD6axiW6wNVMkXZkhpAjrIZXnU6CKFubGqwc7lG11L+Apj8I0Rs6+14DkDNC1
 qaXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV82pj95/2E0OwnVXN1ejzLvn6AGdLZhw/zDwtYTCjjGLK8QfvmROQJONBZjaUUhZ3zcZX+9OOd2JpbQZHc7Fu+Im2iO0Q=
X-Gm-Message-State: AOJu0YzzfBtZWbKxO0wq2vc7l9gjwdcoEEe3ajkDe2SEyjzlUAArmrVh
 KiVi/Zn500o7LdnK+d/luyPQjc4aQlAUyYkBDsrULwfSQGRNryTox4ztYhCbU1c=
X-Google-Smtp-Source: AGHT+IGzT8MNqspNsGp1r8jmFlivRMMiDS+OMgMAW4DdV4/sjHBundR4JbBQbJMkgW9y+yVwZvrA8g==
X-Received: by 2002:a17:902:c94c:b0:1fd:8dfd:3553 with SMTP id
 d9443c01a7336-201ee4b6272mr174887185ad.18.1723957474282; 
 Sat, 17 Aug 2024 22:04:34 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f0375725sm45766635ad.132.2024.08.17.22.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 22:04:33 -0700 (PDT)
Message-ID: <7a330bb1-ca53-41b5-ae97-aec8694fc325@daynix.com>
Date: Sun, 18 Aug 2024 14:04:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, devel@lists.libvirt.org
References: <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org> <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org> <ZrTjaZPyjDuJZK36@x1n>
 <8734ndhncb.fsf@suse.de>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8734ndhncb.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/09 21:50, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
>>> On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
>>>> On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
>>>>> This is too big of a hammer. People already use what you call "cross
>>>>> migrate" and have for years. We are not going to stop developing
>>>>> features just because someone suddenly became aware of some such bit.
>>>>> If you care, you will have to work to solve the problem properly -
>>>>> nacking half baked hacks is the only tool maintainers have to make
>>>>> people work on hard problems.
>>>>
>>>> IMHO this is totally different thing.  It's not about proposing a new
>>>> feature yet so far, it's about how we should fix a breakage first.
>>>>
>>>> And that's why I think we should fix it even in the simple way first, then
>>>> we consider anything more benefitial from perf side without breaking
>>>> anything, which should be on top of that.
>>>>
>>>> Thanks,
>>>
>>> As I said, once the quick hack is merged people stop caring.
>>
>> IMHO it's not a hack. It's a proper fix to me to disable it by default for
>> now.
>>
>> OTOH, having it ON always even knowing it can break migration is a hack to
>> me, when we don't have anything else to guard the migration.
>>
>>> Mixing different kernel versions in migration is esoteric enough for
>>> this not to matter to most people. There's no rush I think, address
>>> it properly.
>>
>> Exactly mixing kernel versions will be tricky to users to identify, but
>> that's, AFAICT, exactly happening everywhere.  We can't urge user to always
>> use the exact same kernels when we're talking about a VM cluster.  That's
>> why I think allowing migration to work across those kernels matter.
> 
> I also worry a bit about the scenario where the cluster changes slightly
> and now all VMs are already restricted by some option that requires the
> exact same kernel. Specifically, kernel changes in a cloud environment
> also happen due to factors completely unrelated to migration. I'm not
> sure the people managing the infra (who care about migration) will be
> gating kernel changes just because QEMU has been configured in a
> specific manner.

I have wrote a bit about the expectation on the platform earlier[1], but 
let me summarize it here.

1. I expect the user will not downgrade the platform of hosts after 
setting up a VM. This is essential to enable any platform feature.

2. The user is allowed to upgrade the platform of hosts gradually. This 
results in a situation with mixed platforms. The oldest platform is 
still not older than the platform the VM is set up for. This enables the 
gradual deployment strategy.

3. the user is allowed to downgrade the platform of hosts to the version 
used when setting up the VM. This enables rollbacks in case of regression.

With these expectations, we can ensure migratability by a) enabling 
platform features available on all hosts when setting up the VM and b) 
saving the enabled features. This is covered with my 
-dump-platform/-merge-platform/-use-platform proposal[2].

Regards,
Akihiko Odaki

[1] 
https://lore.kernel.org/r/2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com
[2] 
https://lore.kernel.org/all/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com/

