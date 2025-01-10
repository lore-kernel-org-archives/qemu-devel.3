Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B659E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEC7-0004e3-I1; Fri, 10 Jan 2025 07:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWEC5-0004bd-6Y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:32:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWEC2-0006aG-QV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:32:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216401de828so31502045ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736512369; x=1737117169;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kpk5Q7Mg4B3jArpTQeujTFbUYPSwPiKxtYgZmtiQjPY=;
 b=Ku327LbXRQLj84M1hHEhTBqtHQNRqUUM7bvoTRcozjUTHFiit6g+rqMeeKIWd3lfwq
 9TUYpHxrJjvQvAyjbfVv2a89wBnmxPkHKjW2kb2GfIKHG6Rehg/B0Jduklg41eY+V4P7
 akbGbMz18LMksW2hlggeVQcDp6LmcK1NVDy3mOtq11dlFqPiinjR9JSUwhAXGI7K+qOk
 zJM+GAVn3dNg3T3cJTHQi4EkCPU7OR9Mu+o5nE9q7kImjYVD/rNpwU5gG6Xx2rgi6rgS
 zC2qk+LcE5UatHW2s1gvB6ZqGsSrvG0G9VsyuuHc461xI9pLJcU3Ivu+rlEbMYqOiGNX
 qPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736512369; x=1737117169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpk5Q7Mg4B3jArpTQeujTFbUYPSwPiKxtYgZmtiQjPY=;
 b=hlK0dSj+WP5T/No5tdC2GNQLMQ6fJZndlpoYRCz29PL7Exfv15dxYPv6SR1PXWS9mO
 Wrej2yTXsYthvM1c0rq2DEwYeEXw8FBgmnhueHvUF8SkK2NWZr1/oCwd5nO5MLrlzZh+
 eXjYsewibmjQ4yB7jU54Xjxs5/edZqbiNFR7EPXvF/GXiwLx2NqASDudxnZdGJWXLWf/
 3+6ntytag3wwqwZDdIWj9HAGeQ/m1/QUDD/4IlWT1tSaH0QaxhFI3XxtVYkgVSxTtRo7
 /6SvDqisa0cqKFLlEMZk39s5cz0YPKym4IhOdzbw5SoAkNs28Mkj+BlsWOWEHKbGn4oI
 aB/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+9FpvWtMIZQuXAKZexuGb0jzPwshtAuWfo15jkeFX/cckpm6jMl4/novFzEL3EcbJx8d/88x6esD9@nongnu.org
X-Gm-Message-State: AOJu0YxRRXHNicGn31vGcPBNAB7lyuS6FqLZSEkQRxrienVI3Y+Renbq
 drt5Q1yndrXXr9Bp8FNXLS8GWc9QvVkrjbeh+noFhu14geVOmz0dci4/1A+duE4=
X-Gm-Gg: ASbGncshd+oxZAkjPhT9RInHXLSw/rmnYwe691l4bwjqPzHFkZ98YqYXWTgCR6tpTa8
 NzQ7PC2AHO+1uIJrOPO6aG6A02JqyQuZZXclCw/cCdl2/V0jM1AVmv8s5FCzNOEb4PUVwLaM8fy
 YYHyLcbLnuGZgUa+jy99MUCTRuR7bkVhLOS6C78YaVnZN0ch5CGbd0w5EGKrM1z9cYOvcIvnj9F
 HGZoyVv2xZx5TzsD5NBRA9ZNkhVI4C7+kAl1XvO7QmCT9kgKU9XTHNY55ZZ8Ggbsjc=
X-Google-Smtp-Source: AGHT+IFzsRCXLZ76u0bp1Au8RzgTKN5PIzLR28Fh5nioWAAPiPNY+yhns5js5Eq//oMCRIt3jb2FAg==
X-Received: by 2002:a05:6a00:854:b0:725:f18a:da52 with SMTP id
 d2e1a72fcca58-72d21f178e9mr15327219b3a.4.1736512369027; 
 Fri, 10 Jan 2025 04:32:49 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4056a766sm1523453b3a.61.2025.01.10.04.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 04:32:48 -0800 (PST)
Message-ID: <2299cb79-f03e-45e6-b536-66dab16830d1@daynix.com>
Date: Fri, 10 Jan 2025 21:32:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> <Z4D_zK-QIN07EXR5@redhat.com>
 <65364ac5-3d8e-4f43-a371-4661bf8b5437@daynix.com>
 <Z4EPuISnjKJ-P0j2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4EPuISnjKJ-P0j2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/01/10 21:16, Daniel P. Berrangé wrote:
> On Fri, Jan 10, 2025 at 08:31:57PM +0900, Akihiko Odaki wrote:
>> On 2025/01/10 20:09, Daniel P. Berrangé wrote:
>>> On Wed, Jan 08, 2025 at 03:17:51PM +0900, Akihiko Odaki wrote:
>>>> Accept bool literals for OnOffAuto properties for consistency with bool
>>>> properties. This enables users to set the "on" or "off" value in a
>>>> uniform syntax without knowing whether the "auto" value is accepted.
>>>> This behavior is especially useful when converting an existing bool
>>>> property to OnOffAuto or vice versa.
>>>
>>> Again, to repeat my previous feedback, OnOffAuto is a well defined
>>> QAPI type - making it secretly accept other values/types behind
>>> the scenes which are not visible in QAPI scheme is not acceptable.
>>>
>>> Effectively this is a backdoor impl of a QAPI alternate
>>>
>>>     { 'alternate': 'OnOffAutoOrBool',
>>>       'data': {
>>>         'o': 'OnOffAuto',
>>>         'b': 'bool'
>>>       }
>>>     }
>>>
>>> except this isn't permitted as the QAPI generator explicitly blocks
>>> use of alternate when the two branches are 'bool' and 'enum'.
>>
>> The QAPI generator specifically blocks the case where the enum contains 'on'
>> or 'off'.
>>
>>>
>>> I'm assuming this is because in the QemuOpts scenario, it cannot
>>> guess upfront whether the input is a bool or enum. This is unfortunate
>>> though, because at the JSON visitor level it is unambiguous.
>>
>> It's probably for the command line and possibly HMP.
>>
>>>
>>> I wonder if the QAPI generator could be relaxed in any viable way ?
>> It will make the interpretation of 'on' and 'off' on the command line
>> ambigious; it can be either of OnOffAuto or bool.
> 
> The ambiguity would not neccessarily matter from a functional POV
> though.
> 
> The consumer of an "OnOffAutoOrBool" field, would likely want to apply
> logic to collapse it into just "OnOffAuto". As such, whether "on" is
> parsed as a enum value or a bool value would have no functional
> difference in the end. The OnOffAutoOrBool is essentially there to
> just make sure we clearly express our input schema.

I think it is worth creating a special type that requires the logic to 
collapse into OnOffAuto.

If we don't have a special type, the QAPI generator will write C struct 
like as follows:

struct OnOffAutoOrBool {
     QType type;
     union { /* union tag is @type */
         OnOffAuto o;
         bool b;
     } u;
};

It's easier if we have a special type that directly maps into a 
tristate. The story shouldn't be different for other possible consumers; 
a special type will make it easy to map QAPI types into 
consumer-specific type systems.

Regards,
Akihiko Odaki

