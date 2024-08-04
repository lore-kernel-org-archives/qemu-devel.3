Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA73BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 06:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saV40-0005st-R9; Sun, 04 Aug 2024 02:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saV3z-0005sI-3M
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 02:49:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saV3x-0002Ni-18
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 02:49:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso8097009b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2024 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722754191; x=1723358991;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wj4EVxyUoRzw0HQz08c0g7FKsbw5thhRThjxFf7YxrM=;
 b=VZsLoPr+Ce3GwkxSjtMWURXzBZGm7j8EhOCBv5l+JETeEX5w865D/mnL9LUWpaJo5s
 8iUk4X0rfF+OBkPi/UHghGNHLQ7kkXm0xp7ld9rPaw+FzIBQ58Rdk8yr3BUCl884lbgw
 5e2jCWPKpYRwJCNoj9eWS/6hFQLjG2OSSfxe/hFYbYBubXmjebEkMWutiQ3wpsLIAfMh
 Rbh0VSEE8YVlwshC+LdgEqnZ/MDwTJyyGP4XwIgtLD58IEL2UW/Zcx254OKEL8MPV/NQ
 0LtvqjcdXqwm93ZUemi0QE9nLPQkpK+KJEYmdcB/ZUJZQ67IyZ4xgDBsLHIilmhsKMni
 xIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722754191; x=1723358991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wj4EVxyUoRzw0HQz08c0g7FKsbw5thhRThjxFf7YxrM=;
 b=ekH9U1SZ5e4TwZuOeeqi1cNvFJkKXN6qLkplzoiQNI5eeEb0lZJBo5K7yjPjUEhucg
 Amrxni1Lq++Vbg3SOsEJBBT7a3SITT/vD3ksbcRyshqc39x0WSj5kdVtDMm/9LwdLEay
 VlxHh/bvzEv3CaTbesMXdHvvtuDMDYqGdiq33YU0xz6LCwkWsCfUlu7o+I4MIy6y5qSa
 9kDN8adJVwZnrOKJ8x+aUbRh+LCaRHmD8RCkAkQVmN3JfZ5RMsBZ8msrThI+IN9+BQ44
 J97NryyiDHNTxTJoWDbmQEjict7LsH/UvHtIzOM7ufk4IisWqGd8xAKkSCZmrpMsJ/2o
 WKRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3tZBM+0n9H8HWqeMwdlfCJKz/s9o+foqdzPFbjBfhtrZZtph6U0BHixcGredVvFVsjh8N7a8PQRNaaVV48fc9fswDKM8=
X-Gm-Message-State: AOJu0Yy4vaFNLiSMZ/V8JFuOWNQD6nNsFRlb9WWOWoFu7D+DIjLO/aa/
 eG8ozYn/AzgOSPoZ0lJgPIsj6cC0cp7Oh+/Las/bk5x1erHHP3BWxw+vxD72I2I=
X-Google-Smtp-Source: AGHT+IEiLTJ9Itj9o1uwFN0J6WWGNEnmmfHTI82n2YheXXFL37VbeIpkt0U5BrQUDtlMK3b9zEkPLw==
X-Received: by 2002:a05:6a20:7529:b0:1be:2e2e:5ae8 with SMTP id
 adf61e73a8af0-1c699657987mr8872024637.40.1722754191138; 
 Sat, 03 Aug 2024 23:49:51 -0700 (PDT)
Received: from [133.11.54.73] (shio03.csg.ci.i.u-tokyo.ac.jp. [133.11.54.73])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b764fba58bsm3005977a12.72.2024.08.03.23.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Aug 2024 23:49:50 -0700 (PDT)
Message-ID: <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
Date: Sun, 4 Aug 2024 15:49:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com> <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com> <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com> <Zq0IrhV-DgStpJtk@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zq0IrhV-DgStpJtk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/03 1:26, Peter Xu wrote:
> On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
>>>>> I'm not sure if I read it right.  Perhaps you meant something more generic
>>>>> than -platform but similar?
>>>>>
>>>>> For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
>>>>> "perf" or "compat", while by default to "compat"?
>>>>
>>>> "perf" would cover 4) and "compat" will cover 1). However neither of them
>>>> will cover 2) because an enum is not enough to know about all hosts. I
>>>> presented a design that will cover 2) in:
>>>> https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
>>>
>>> "-merge-platform" shouldn't be a QEMU parameter, but should be something
>>> separate.
>>
>> Do you mean merging platform dumps should be done with another command? I
>> think we will want to know the QOM tree is in use when implementing
>> -merge-platform. For example, you cannot define a "platform" when e.g., you
>> don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
>> connected to virtio-net devices. Of course we can include those information
>> in dumps, but we don't do so for VMState.
> 
> What I was thinking is the generated platform dump shouldn't care about
> what is used as backend: it should try to probe whatever is specified in
> the qemu cmdline, and it's the user's job to make sure the exact same qemu
> cmdline is used in other hosts to dump this information.
> 
> IOW, the dump will only contain the information that was based on the qemu
> cmdline.  E.g., if it doesn't include virtio device at all, and if we only
> support such dump for virtio, it should dump nothing.
> 
> Then the -merge-platform will expect all dumps to look the same too,
> merging them with AND on each field.

I think we will still need the QOM tree in that case. I think the 
platform information will look somewhat similar to VMState, which 
requires the QOM tree to interpret.

> 
> Said that, I actually am still not clear on how / whether it should work at
> last.  At least my previous concern (1) didn't has a good answer yet, on
> what we do when profile collisions with qemu cmdlines.  So far I actually
> still think it more straightforward that in migration we handshake on these
> capabilities if possible.
> 
> And that's why I was thinking (where I totally agree with you on this) that
> whether we should settle a short term plan first to be on the safe side
> that we start with migration always being compatible, then we figure the
> other approach.  That seems easier to me, and it's also a matter of whether
> we want to do something for 9.1, or leaving that for 9.2 for USO*.

I suggest disabling all offload features of virtio-net with 9.2.

I want to keep things consistent so I want to disable all at once. This 
change will be very uncomfortable for us, who are implementing offload 
features, but I hope it will motivate us to implement a proper solution.

That said, it will be surely a breaking change so we should wait for 9.1 
before making such a change.

By the way, I am wondering perhaps the "no-cross-migrate" scenario can 
be implemented relatively easy in a way similar to compatibility 
properties. The idea is to add the "no-cross-migrate" property to 
machines. If the property is set to "on", all offload features of 
virtio-net will be set to "auto". virtio-net will then probe the offload 
features and enable available offloading features.

Regards,
Akihiko Odaki

