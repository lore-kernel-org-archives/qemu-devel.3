Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796BAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1OI-0006J4-JD; Thu, 08 Aug 2024 07:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sc1OG-0006IW-6a
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:33:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sc1OD-0005YA-AE
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:33:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so14210085ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723116783; x=1723721583;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oEGIv/3Rt8oczAqKO5L/kwOxt4tk9XJ41Db24GqK748=;
 b=a3zgsnAYxz4GnhyGmdBKyBvtBEMNc3i0l4LCMxtmuSIMRrbwQsyvOr3mE3GHeewx8h
 lWWYQKpBYvo9J4NQ9nzmhRuCoZOAahZDh+uB0Z0Wsvvx+bfwplN9hNN5XJ0b6pjQIIzh
 1EujGVaFdxeEs9IZ9+W/SZ9V/5smHHBC75xG9UM6105vwRT5Uk6WLi/g7O9EXqnhZJOq
 Ma0J6IZznsCTBOaOnvSisrC6pzRMVJDvgIyCbQID3HC3eG+oo8aA8AVTQAzayyhnQJUK
 NfqOGVpJKHEVpC59W3cDRrSxHmQUFsOKPU0ErJRaREuzEjeG/WsM+rNukOwdr9rUGHdy
 88hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723116783; x=1723721583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEGIv/3Rt8oczAqKO5L/kwOxt4tk9XJ41Db24GqK748=;
 b=YvL1XsfMunW23xpDbk1Bec7OYgf0aEPiFshbwexmRxu8dpUH0jtMfMMQB15yOo7x0c
 DHFiNK72gwO7Qwy4MvcbhbAlgAw2B7gbZ1OHTvJ2ZEEIfGg1prjv6XPPnrmWQt9lMMG+
 kIOozd+ohUTZYpSBpAgElhS2DU+d+hI3ncorGBtZgx9BUqUTE0gAT6MylB9N+gGEOFwk
 yc+1XI9JeryVH0+K1vLlGOTqSwxyXKS8KL6HECOrXvFNdYjNtzAVqXPLWUZcwcIqPkbB
 YKDhH+DApqcggohabZBFR3mzcxPLXVY2GgL+H0MBx3LQlEQ7BDADTgEcBo8yfN9xDWF6
 xDMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCVi3OrPApOUotD+Zia+WXOCutjepHHp8z6fIsqefAnwyUDB8q9fQGEgmVM2s89TKuWLFE63YjDfY7@nongnu.org
X-Gm-Message-State: AOJu0YxMOhF4u01BnCdzdaAKkHpMGFeWTNwqMg5SlR2PJOvvxXlDBXb1
 lU5wkZrGR3vgstDQQ4/WyVZ7pF5LzXIBiU6o1vpq7gWAF5Xb8uq2L8MagF4s39g=
X-Google-Smtp-Source: AGHT+IHLXNLm6Nm+Sa0X/NGyN8yA77KTZbfquwesOA9CpEPM9C7Xwqn3a/spx/OhUvDq26bh0tw0fA==
X-Received: by 2002:a17:903:1c7:b0:200:869c:960d with SMTP id
 d9443c01a7336-200967f6570mr19242515ad.3.1723116782636; 
 Thu, 08 Aug 2024 04:33:02 -0700 (PDT)
Received: from [157.82.205.232] ([157.82.205.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9c6f1sm9644181a12.19.2024.08.08.04.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 04:33:02 -0700 (PDT)
Message-ID: <770300ac-7ed3-4aba-addb-b3f987cc6376@daynix.com>
Date: Thu, 8 Aug 2024 20:32:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240808070912-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2024/08/08 20:12, Michael S. Tsirkin wrote:
> On Thu, Aug 08, 2024 at 08:03:25PM +0900, Akihiko Odaki wrote:
>> On 2024/08/08 19:54, Michael S. Tsirkin wrote:
>>> On Thu, Aug 08, 2024 at 07:52:37PM +0900, Akihiko Odaki wrote:
>>>> On 2024/08/06 22:29, Michael S. Tsirkin wrote:
>>>>> On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
>>>>>> On 2024/08/05 19:08, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
>>>>>>>> If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
>>>>>>>> and restart). QEMU can also migrate across hosts if the user ensures they
>>>>>>>> are on the same platform.
>>>>>>>
>>>>>>> What is so special about checkpoint/restart? I guess we hope that
>>>>>>> downgrades are uncommon, but they are possible...
>>>>>>
>>>>>> Downgrades will not work with cross-migrate=off. Users who want downgrades
>>>>>> should use cross-migrate=on.
>>>>>
>>>>> We also don't know that upgrades do not disable a feature:
>>>>> can happen if e.g. there's a serious bug in the feature.
>>>>> Basically, this makes the feature too fragile, in my opinion.
>>>>
>>>> We can do nothing in such a case. Whether it is on a single host or multiple
>>>> hosts, we cannot support migration if features once enabled disappear.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>
>>> It does not follow that we have to do something, and this is something,
>>> therefore that we have to do this.
>>>
>>> This is just a reason not to handle checkpoint/restart any different
>>> than any other migration.
>>
>> Whethere it is checkpoint/restart or any other migration, I expect platform
>> features won't disappear from the host(s); we can't readily support
>> migration in such a situation.
> 
> 
> We can if we mask the features from the guest before starting VM.
> 
> Or if we didn't, we can fail gracefully.
> 
>> When platform features won't disappear, for checkpoint/restart, we can
>> enable all available features without disrupting migration;
>> cross-migrate=off will instruct that.
>>
>> However, if we are migrating a VM across hosts and the user doesn't ensure
>> they are on the same platform, we cannot enable platform features even if we
>> are sure that platform features already present on a host won't disappear
>> because some hosts may not have features in the first place. We can set
>> cross-migrate=on in such a case to disable optional platform features.
>>
>> Regards,
>> Akihiko Odaki
> 
> 
> This is too big of a hammer. People already use what you call "cross
> migrate" and have for years. We are not going to stop developing
> features just because someone suddenly became aware of some such bit.
> If you care, you will have to work to solve the problem properly -
> nacking half baked hacks is the only tool maintainers have to make
> people work on hard problems.

I think you meant cross-migrate=off, which is the current behavior.

I am not suggesting forcing cross-migrate=on or even making it default. 
I have shown four possible scenarios earlier[a]:

1) Migration everywhere
2) Migration on specific machines
3) Migration on some known platforms
4) No migration (migration on nowhere)

Taking the discussion with Peter, I amend 4) as follows:
4*) Migration on one platform (checkpoint/restore)

cross-migrate=on is a complete solution for 1).
2) is dealt with another proposal of mine.[b]
3) can be solved with the -platform proposal by Daniel.[c]
4*) is what QEMU currently implements.

[a] 
https://lore.kernel.org/all/39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com/
[b] 
https://lore.kernel.org/all/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com/
[c] https://lore.kernel.org/all/ZqO7cR-UiGpX2rk0@redhat.com/

Regards,
Akihiko Odaki

