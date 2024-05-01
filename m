Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A6AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s243C-0000yo-Lm; Wed, 01 May 2024 03:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s243B-0000yd-09
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:06:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s2439-000673-78
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:06:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so13241485ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714547201; x=1715152001;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KPSTrIfQLlKlE2Y5kcC1q5aZAAoFOn80Cx2b2G9gn0c=;
 b=cW0BUsUtzyCdSu4kJ1Je5TadVvQh+P7Xgl0N878KMbESw8+k8QwnOM06HXooc0URZB
 nItmv3+sdeh/BKN3kepngchq7FgKwc3fHnDQFG1u2yvpOjSTkn9EgC50hbkMAlJad4Aw
 O1zX3eRmvEGhryLL5kpWbitaQ7NcGOElK1a8BZ1EQjcLoSbE4nyQpaHw9TfId9vDP+c9
 9W/sRMdr7EtjxBl2aVwWlw6tKySBjjSME8vhFNIzVTiJhRSsTBdg5BtqZ/x60SR6nqdt
 xK6VUgjFohh50Je6tnO2Npb05D3H9gCw6Uget1/pb8cPVIPFsLnw3ut3mwfwXKICe+Jj
 ENMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714547201; x=1715152001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPSTrIfQLlKlE2Y5kcC1q5aZAAoFOn80Cx2b2G9gn0c=;
 b=dSe6ic052BFgXLUdna/7kxUk9maE1S7qNUl0V/7A+UOYP9DGRv/L4St9d7GQmNpvcX
 U1YKXsS0SB4glHkePuv+bQxi4A1zTHriX9BWLe3jZ/eZsRXPVXg0gQiUA8uRgSUGjWkE
 9LnbPUzClcwzFXQvIsq0g8IxvH5k+Q2m0d3GV6wf2BsPWLAvRdsCAreglpJVa1SbR1cK
 oN8zBDPW8dJmVOSjZptCukfkNU3EF9aMGIvusDW2zEj/aPGQsrLma8U2Sh1LhM4gbCjD
 etusg6ebZag2I2e2AT5klV6YjSF0RkkYj0mvBhks3w8CRBgxuZEKYqvLqEcj2wiECV/r
 6L1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV75Chmgcpin/ok6VcBc2Jgjtx0Vs5pf7BakmFaIewJw9TPb2JMXv7qHi6uRXYp2ddwqvLPpfSOKMLouu/FRA+jltF8GeE=
X-Gm-Message-State: AOJu0YxIHLwQq/VkYhIblojbdKwn47O5egnzhn9YxwgLzmAwckZAag1S
 xpxjbC2Z/3pBmUmVz3RAMs5MEkdeIkunivLCBKKajVCk6hL4Oie4aoAhaYI3aMM=
X-Google-Smtp-Source: AGHT+IENJE2MqYYegAErVTUgJk4cpXG5Fyx4iU0rfmmLPTAeN133tVtRQJu+U5k3sTgwcuwsAn1C3w==
X-Received: by 2002:a17:903:124d:b0:1e6:7700:1698 with SMTP id
 u13-20020a170903124d00b001e677001698mr1701339plh.35.1714547201590; 
 Wed, 01 May 2024 00:06:41 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a170903244800b001ea9580e6a0sm11842684pls.20.2024.05.01.00.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 00:06:41 -0700 (PDT)
Message-ID: <3c0aef43-2460-4a32-90ff-295ca3558449@daynix.com>
Date: Wed, 1 May 2024 16:06:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] virtio-net: Convert feature properties to OnOffAuto
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
 <20240428-auto-v1-2-7b012216a120@daynix.com>
 <CAOEp5OcvLRvCVsGcC=8Y-P1tzJ4Tn+21Y6rJe_2ZVK-cDzePxw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OcvLRvCVsGcC=8Y-P1tzJ4Tn+21Y6rJe_2ZVK-cDzePxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

On 2024/05/01 0:02, Yuri Benditovich wrote:
> Question:
> How will libvirt (as an example) work with this change. In the
> existing semantic of libvirt profile the "on" means "on if possible"
> and using existing profile after qemu update will still use "on" with
> meaning "force"? > Typically this is solved by machine type - if libvirt uses
> 'machine='pc-q35-8.1'' this will be backward-compatible.
> How will this change be accepted?

The reasoning here is that this patch only changes the configuration 
validation and, once the validation passes, QEMU can load the state of a 
machine created with an old version of QEMU.

It is still a good idea to add a compatibility property. I'll do so in 
the next version.

