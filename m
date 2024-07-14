Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82E5C3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 05:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSraF-0006Zj-TO; Sun, 14 Jul 2024 01:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrZU-0003MG-Fz
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:14:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrZS-0006z1-Vc
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:14:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b5117ae06so2468857b3a.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720934089; x=1721538889;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPrr933RYCSPW+BCefyXXtXKC0z3ENj/lovpQq6C+Sg=;
 b=ynUlMJQq5t8XFCsx3XQ4h6pK5f6vLJJj4WQE/eiQeqU4hiZOV2j14GzWWs3WfWxSKp
 4uCU7TtxtCwhZobs7aMQb5XEtZO+J9OJ7UCvA65XsW6q+g1jUc8+xT2UmM+w++1uBvFq
 RwzF1Gnsnw8OleQ7veN6Qm3CNlGlGnWbzroEckeXcf7XWM7L73nWQbhzeMJTMdWu0Oj6
 5WH25qKmj2Jq9lfZhOoUYHPJBjqbMobkcXV75RIoayEy8p1UQBMaxzOf3+Wh33i0SOgd
 J/fhgVyoeOWQ+V8PjpWuOZ/5aDJM7K9r7aWr+HbkvUKvPt1azl556Jb+F/GTDrtszDcZ
 luUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720934089; x=1721538889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPrr933RYCSPW+BCefyXXtXKC0z3ENj/lovpQq6C+Sg=;
 b=p9Ap5urVXgGDq+ZABxmoM/T3dNv6ItLv/4WLrCLcbE4VqEIYoEirr92YZNPFVR9wVW
 5ohrJ+8bUoEXxmbgh/3Vdt8H1YUR/gbqQZf2hr0RxK0YCEkVz6M0Tkog9gRvmbga82K5
 VqAGcB5fYApnaM+HTk1JdMI/H/BQMGOjsrpMpRrtbbp6TVSYPpz+/8hq0AdOmzLs0my9
 tD5a0tyZnqzSsPyewn2LScvDns6fy8/HvqZoFFxuj6r8nHmsXGozMNe/GASFL6/4S7jU
 pTOOBTi0gX+JVWib/weWpLH1HYANJ1x4Zl6/or4Pexc1aKXQz3LoOh2buOxbco8uABCT
 yqMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsxME6LYLvzEr/RToa2JpEjtV8skgoxiCqFxNT0Kk/hsHZaVLXqJSJuhvl8/felp+b0V5qx24MTPmKEoxHQyhkoVL7jnA=
X-Gm-Message-State: AOJu0Yw/DWxfAxJ48Yl9vUGYfQ4B3d5ET6CjFUXceyNAchxZAG6nTyiJ
 +bsAKOHm6KcKWYietWUjIsHs2fzvVhJf6pbHVS2hmTEOz9kks8O6PUX5RVd9JMU=
X-Google-Smtp-Source: AGHT+IHLb5V61ef7VJzkRQ8QgNJcClIerHym1F2jHVu9uFVP0avL8Vyk+jKMSh4g73axvlwa7JZS0A==
X-Received: by 2002:a05:6a20:2d85:b0:1c0:e629:3912 with SMTP id
 adf61e73a8af0-1c2984c8544mr15472677637.48.1720934089345; 
 Sat, 13 Jul 2024 22:14:49 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedc92bc2sm1928267a91.35.2024.07.13.22.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 22:14:49 -0700 (PDT)
Message-ID: <7b57d5f8-c398-46c7-b317-fa37e8b43dc8@daynix.com>
Date: Sun, 14 Jul 2024 14:14:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] virtio-net: Convert feature properties to OnOffAuto
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
 <CACGkMEsrY84aW9w1zef-6KaTYaKuJ_mBqVxJbLuettORmB7oBw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsrY84aW9w1zef-6KaTYaKuJ_mBqVxJbLuettORmB7oBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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

On 2024/07/09 11:52, Jason Wang wrote:
> On Mon, Jul 8, 2024 at 3:38 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Based-on: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
>> ("[PATCH v10 00/18] virtio-net RSS/hash report fixes and improvements")
>>
>> Some features are not always available, and virtio-net used to disable
>> them when not available even if the corresponding properties were
>> explicitly set to "on".
>>
>> Convert feature properties to OnOffAuto so that the user can explicitly
>> tell QEMU to automatically select the value by setting them "auto".
>> QEMU will give an error if they are set "on".
> 
> Would this be consumed by a management layer like libvirt?

No, as far as I know. I couldn't find any code that consumes the feature 
values and the patched binary worked with rss="on".

Regards,
Akihiko Odaki

