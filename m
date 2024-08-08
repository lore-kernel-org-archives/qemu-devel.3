Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79F0C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0lD-00033S-G9; Thu, 08 Aug 2024 06:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sc0lB-00032J-PR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:52:45 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sc0l9-00083F-OU
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:52:45 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cd5e3c27c5so675300a91.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723114362; x=1723719162;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zoysz1qpWPgyaEppwm4JxqxfQwhMN3EWZN0gvTf99lc=;
 b=GxZrqx1xFj7lOdtLx2mtW3K8VVYAvhkq2aW/j1rDrndiWGIgLAxOnMyeuVw4fg7KHM
 0cSqP43r+qJ+YNsXjXcc9LjKkb0r9PIYwwGJ8UxxK14ZAsOZolX6YFDTiCn2xQpTCKaV
 66xs1D/epoB0zOeYlteKEgjUxFiE5p+Xr8F3SfJr0FCN5LQs3W68JvZCavrAhWHQ4dcd
 feqZKoFYVHyK7XLRxyGsRfbYc8KLS0RDaq+UwzNVbHAddufzVaKQ8kfPah3F7x5gV7tY
 hYqw9T0jK7to3KQAmWbktU1n+07fN2zLg6TQwj5Lum+Rfkn0SBBmiElDlMzcyJG/vyMg
 3NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723114362; x=1723719162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zoysz1qpWPgyaEppwm4JxqxfQwhMN3EWZN0gvTf99lc=;
 b=tNb4XD57kd33hSU+6HACk4tRifjqcXrCEB+38yehTLDSkL5Xoef9XQCQpjtlarbd1o
 DIY53OS5nm8qKFeiNkLacvIAnKZ4fKmtmx/W9UbPbYXP7S8jOwkTVVbQWQYAzdr+DRNx
 AN3Qf9L6gpcCVkOkqBO5ipPL3DtE7AIejtK0KBSHTrmCiBfn50fhHoBy42QKrB9hEWr6
 Kpt4YDtzYuwvcpcKbC2URfhNShecHbuO4fH4GyumJUigP0cM/EG6oC+cZppcqNO/X7I0
 MH9KlvLGFdHX6GshZmVV9j2UTQx1XcN0Vuviuk/3FlZLqY9/iPfR1/Ue6LBDfG33p90R
 G5Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgOygacL1rRAO5TZX03xpBGqiYEBWNFjOS2iBC8urNcwjEvxL/oFGvZ5sQWKl00keCqKAlhUWFPmP1gWRfu4icvvxyszA=
X-Gm-Message-State: AOJu0YyxCk0cBMIf8dG0ra2wiNjJC9aqa4udexkhGPnKENEPVWmPeC/j
 cggv60hHC0VRHH2uFcMmBgaOn7L8VEp2/6nNw91lkdv5GJudeh2G6q5undghnZM=
X-Google-Smtp-Source: AGHT+IEbjv6atpJ8q4V+7z0Vcnwx46f2cO9x10LmyBPWGVZjqyB0s+M8B71oVcbGuwK6WYVY1fvvrQ==
X-Received: by 2002:a17:90b:1989:b0:2c9:9b16:e004 with SMTP id
 98e67ed59e1d1-2d1c34747b7mr1570531a91.43.1723114361741; 
 Thu, 08 Aug 2024 03:52:41 -0700 (PDT)
Received: from [157.82.205.232] ([157.82.205.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c64b1fsm884269a91.7.2024.08.08.03.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 03:52:41 -0700 (PDT)
Message-ID: <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
Date: Thu, 8 Aug 2024 19:52:37 +0900
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
References: <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com> <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240806092822-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
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

On 2024/08/06 22:29, Michael S. Tsirkin wrote:
> On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
>> On 2024/08/05 19:08, Michael S. Tsirkin wrote:
>>> On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
>>>> If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
>>>> and restart). QEMU can also migrate across hosts if the user ensures they
>>>> are on the same platform.
>>>
>>> What is so special about checkpoint/restart? I guess we hope that
>>> downgrades are uncommon, but they are possible...
>>
>> Downgrades will not work with cross-migrate=off. Users who want downgrades
>> should use cross-migrate=on.
> 
> We also don't know that upgrades do not disable a feature:
> can happen if e.g. there's a serious bug in the feature.
> Basically, this makes the feature too fragile, in my opinion.

We can do nothing in such a case. Whether it is on a single host or 
multiple hosts, we cannot support migration if features once enabled 
disappear.

Regards,
Akihiko Odaki

