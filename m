Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F66C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 09:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIP1G-0003JH-0G; Fri, 23 May 2025 05:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIP1E-0003J3-HD
 for qemu-devel@nongnu.org; Fri, 23 May 2025 05:48:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIP1C-0007Ls-Cj
 for qemu-devel@nongnu.org; Fri, 23 May 2025 05:48:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso5204535b3a.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747993725; x=1748598525;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DF+1/2UGlatsssmifiTftNpnvTz1SlCxej3Zm7q4QV8=;
 b=nNVAF2Tjhxhoi52IIqOiG8j6Tcs4cvemFnE/581QNH9x29uqpKRDof8LCxU6wOrFA/
 x2hAqT5C5rRR4DnOCGHEY6oXLu5MNw0Kk7LkV+BjlCpxEnSNq1hl0oXeD++lUr/+yHm7
 TqRZOGIbfhFjIiOa/NTr1FtXjiy2RgxwrgwQWWnUMihaEsrSPkHyRJY2b7RTkVQ/CrfH
 zsonA42lQvHgln6Xm9DKZ/HSvtsTO/O2oa+2Osl4nvb6ZddPVo85Q7pjuQjO8MhSOiUz
 7XfnCGfbNAMzfKThbtZCVhas9maAM1YQh8UNym1MWofMvfydi/Kar2MY/1Vw7PtuGidg
 RapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747993725; x=1748598525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DF+1/2UGlatsssmifiTftNpnvTz1SlCxej3Zm7q4QV8=;
 b=uCGVApzClgxvQk/Fm4dDmm5cuYz7bSKYtq0HT8+SOxQX32nOSTmWE4EwAKgCcJuBD2
 BDZ5aH5/oNWmWY+rwpNd98RiRfkdb+gUdbULQun8bBVWiC2KLRLQQc7sDJ3HInaak++I
 RoJDzjh+d0GogDamj9QRJ4qdg64d6bnpiG78QT1tyNAniuniiGG9A9v3r2njMMHyom+9
 p6H7AGC3ryOxlGaVIK6utTfm9IkkpvEhTSr6g784LtAN8YmhwlDjvpgi8xB+rGweSRyu
 /42WTEA/I9pCGX0VgslDKvaFZDw+G+ugxmCdKUKx+jxBTijJWuOF4TGAdsjlw86pDpp/
 XzPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULRjeNweAobCTD6bYeoiY+AP/ViyHgfDMMAq1iErE5TCdD+TLbzYFbFsYLdeRnUnsy6ivRutV37xJ6@nongnu.org
X-Gm-Message-State: AOJu0YxUj5uXidUJ4pc7/iSVjL0YdV15CfE7xgpIZShnLgFG1fOK/vup
 E37onz6XEIcanlalO2BlLURVlp5pymqFr0a+J5xG0OR5DWWxXLE3uVPeSjms+T89jbQ=
X-Gm-Gg: ASbGnctFyreYFPUuVZ7aBtZbyLm+DtS7qwatGQgKD6Dpjvi7w8o+Ei1EmZELNMQ99lJ
 S9b78KPYbGnaWmdNjRc1ZMeRWjuRw4Qe+EFy5G/gTbb5vACqJnxzsTpyNuStaKzIv5ABJONdBd6
 kYy4jQxU94HScC+hFdGBWJQr8g4KN+MFmmeLQSSycObjO3rpIuZzAwvAxyp+equR/cyAOgxi939
 ARcmiRpdrxJopug6rTfnjaZJfaF5eJoPi9YEWMicu7drILPQS/yAvXSREDnl81cB5JCC5+MWgT7
 6XYMQrcF+0EFGX5W/zgL7R5SEz1D60lkJtqlDeQWLt27J8uCno4MUHRYlwVuTMkaTE9NViUC
X-Google-Smtp-Source: AGHT+IGljd9U5xQIGV9joI+e4PeigNEKBg+NWtC+yhDpy5NA/+o7Kt9iDAL3RC7roswVFtw1sNWJHQ==
X-Received: by 2002:a05:6a00:b84:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-742a97a2752mr43129387b3a.8.1747993724693; 
 Fri, 23 May 2025 02:48:44 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742b6c3989asm11038696b3a.122.2025.05.23.02.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 02:48:44 -0700 (PDT)
Message-ID: <473516b5-d52b-4671-aeca-d02ad1940364@daynix.com>
Date: Fri, 23 May 2025 18:48:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/16] virtio: introduce support for GSO over UDP
 tunnel
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <29808015-f8b3-4e18-8d1d-5280bda4ee3d@daynix.com>
 <5a4579c4-2569-4642-99a2-23ae29aa80c6@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5a4579c4-2569-4642-99a2-23ae29aa80c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

On 2025/05/23 18:43, Paolo Abeni wrote:
> On 5/23/25 9:19 AM, Akihiko Odaki wrote:
>> On 2025/05/21 20:33, Paolo Abeni wrote:
>>> Some virtualized deployments use UDP tunnel pervasively and are impacted
>>> negatively by the lack of GSO support for such kind of traffic in the
>>> virtual NIC driver.
>>>
>>> The virtio_net specification recently introduced support for GSO over
>>> UDP tunnel, this series updates the virtio implementation to support
>>> such a feature.
>>>
>>> One of the reasons for the RFC tag is that the kernel-side
>>> implementation has just been shared upstream and is not merged yet, but
>>> there are also other relevant reasons, see below.
>>>
>>> Currently, the kernel virtio support limits the feature space to 64 bits,
>>> while the virtio specification allows for a larger number of features.
>>> Specifically, the GSO-over-UDP-tunnel-related virtio features use bits
>>> 65-69; the larger part of this series (patches 2-11) actually deals with
>>> the extended feature space.
>>>
>>> I tried to minimize the otherwise very large code churn by limiting the
>>> extended features support to arches with native 128 integer support and
>>> introducing the extended features space support only in virtio/vhost
>>> core and in the relevant device driver.
>>
>> What about adding another 64-bit integer to hold the high bits? It makes
>> adding the 128-bit integer type to VMState and properties and
>> CONFIG_INT128 checks unnecessary.
> 
> I did a few others implementation attempts before the current one. The
> closes to the above proposal I tried was to implement virtio_features_t
> as fixed size array of u64.
> 
> A problem a found with that approach is that it requires a very large
> code churn, as ~ every line touching a feature related variable should
> be modified.

Using an array may be ideal in the end, but for now you may instead add 
a separate field for the upper-half. For example, you may change 
DECLARE_FEATURES() as follows:

#define DECLARE_FEATURES(name) \
     uint64_t name;             \
     uint64_t name##_hi;

Regards,
Akihiko Odaki

