Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979BCC02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 06:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgHP1-0001ji-8N; Fri, 07 Feb 2025 00:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgHOz-0001iR-HM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 00:59:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgHOx-0000av-1J
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 00:59:45 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21ddab8800bso24133305ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 21:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738907981; x=1739512781;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QTyWN6OjRupwK+lmVmzE9YpQ0JF5OJgfPZGVkPzfKWM=;
 b=ePAubFdGXjuvd5vl9nbEynTqpwDYWaH0UcAg1hTOQSGmKLhX0Ka7oCPclbhug7ZTQ1
 JH+Q/YaXXYyFj0eozVuOy5HtrCxY8kfBYShYAEnZJYpeWvyVHqVcbL9jpx7bPWo+OBFO
 dUuR0r17x4JI3BgDvACWUSBM1wMLbtItV8Yb+pPDZJrUVCiKaRU3Y35dRgJdUkFGwlQi
 HEu3vA1hXfSfG7supXwQNpX81cJHd/PLpdnZ62SgIQymdPGx7NqT/dPrvO7iIefNqP5f
 IcWvvMtm5ulo6O0f4rsdeVj1OTQ0PvSlrb5iuJaUDIy9j4wn9NjsxLIMxKDof3ZVb7QB
 BWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738907981; x=1739512781;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QTyWN6OjRupwK+lmVmzE9YpQ0JF5OJgfPZGVkPzfKWM=;
 b=H5bgMABFU18edsmwG9YrZurssd96ILvXqYV241V1pV0Z/FEAKNtQQ1RdnsM9s6ZaLb
 u9d8mvxXX/js7R+TFNhKeQmyg8oLR66EPzlS+09MetFlhIT5JufqkEPsFEF7d/H7WCqV
 zCEuZYsGMegC0QJmVH1J5F5Fsq8eVVmM3AHzRadDEwNpLRtxa6gT37NEvVT5/jgpiSJC
 gi+ekzgwvhI507xocZxLAX9FmL0qMsmwzB2ekP2Av7k+C8lYe7RlQuY8MzyuksyFOyzq
 0II3Za/hRR6W9lZalDuQiNBUlv3BjzgOxQT6BQb0+FbliF4hnD2Y0b+GZEygQFRJKRhR
 f4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjdRGb1LRfBcvPBB4fQUB8yJ9XYe1vgOojNlDbuuNZuncHhjSFg+8u/hNkYL63lOfVWLkv9P6cUhiP@nongnu.org
X-Gm-Message-State: AOJu0YyKFtkpb1apbPJsElh8fZB5Zu6X6MdsORZwDBCT22Gtg96PDLsg
 pLO0tmMONd15zam4lnKqkwr+ruvv9cmGMYo2HP24CmmkkDUNsw/n8TeVVxTlbSw=
X-Gm-Gg: ASbGncunZnQYBv4IL/2mFWaqejDqR2EXOADwEGWAoevGtY96SP9U5VOTWgTzRGIVp8w
 ImaQkIlz/blrgW5R3o38YaBz+XVSJt01DGPd5c0xT/3cKxqlcfUmG/TS7nnbnxuHwdXfPXeIQCc
 eQVwq3WgPIHb/Iy/T6fHqkJGPDRxIYhZEcmh98x0yHFeK0FPEj44KknvpzjY3KiUKnqYqp9S+uA
 mR9EllmhLxcIPiGUXLVBKabdV4D521w8qh3E8keSOaCiSDpXVpxnustSVh/pDQzdQ/t/WGn5UPX
 bpnMw0mzv/nx+8QtT5Ro52/ke6Vz
X-Google-Smtp-Source: AGHT+IGNUmwPQsrg7829k8NzCuRBwXHkUL8puz8Qvd83Ug9EpjMoR3i5kTYOVdDyPSoEjBwMjyjp5w==
X-Received: by 2002:a17:902:c949:b0:21f:4144:a06f with SMTP id
 d9443c01a7336-21f4e6acffcmr28132895ad.13.1738907980802; 
 Thu, 06 Feb 2025 21:59:40 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653c997sm22372515ad.78.2025.02.06.21.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 21:59:40 -0800 (PST)
Message-ID: <79fea08e-21d0-46ba-923d-8892eef3ce8e@daynix.com>
Date: Fri, 7 Feb 2025 14:59:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com> <87cyfwxveo.fsf@pond.sub.org>
 <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
 <87r04bs8sj.fsf@pond.sub.org>
 <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
 <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4363863f-3ba3-95b3-61ec-6fade162218f@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2025/02/06 22:23, BALATON Zoltan wrote:
> On Thu, 6 Feb 2025, Akihiko Odaki wrote:
>> On 2025/02/06 18:48, Markus Armbruster wrote:
>>>>                                              This problem can be solved
>>>> using an existing mechanism, OnOffAuto, which differentiates the "auto"
>>>> state and explicit the "on" state.
>>>
>>> I guess you're proposing something like this:
>>>
>>> * auto: on if possible, else off
>>>
>>> * on: on if possible, else error
>>>
>>> * off: off (always possible)
>>>
>>> Which one is the default?
>>
>> I converted on to auto and off to false in a following patch.
>>
>>>
>>>> However, converting bool to OnOffAuto surfaces another problem: they
>>>> disagree how "on" and "off" should be written. Please note that the
>>>> disagreement already exists and so it is nice to solve anyway.
>>>
>>> Yes, converting bool to OnOffAuto is an incompatible change.
>>
>> Not just about conversion, but this inconsistency require users to 
>> know whether a property is bool or OnOffAuto and change how the values 
>> are written in JSON accordingly. This somewhat hurts usability.
> 
> Worse than that, the help text is also confusing.
> Excerpt from -device virtio-gpu,help
> 
>    blob=<bool>            - on/off (default: false)
>    busnr=<busnr>
>    disable-legacy=<OnOffAuto> - on/off/auto (default: "auto")
>    disable-modern=<bool>  -  (default: false)
>    edid=<bool>            - on/off (default: true)
>    event_idx=<bool>       - on/off (default: true)
> 
> For bools it says on/off yet expects true/false. Wasn't originally true/ 
> on/1 and false/off/0 accepted for bools? Where that got lost? I think 
> getting back that behaviour would be easiest for users. Users don't care 
> if OnOffAuto is an enum internally and can't (or don't want to) remember 
> if bools are written on/off or true/false so accepting these as synonyms 
> would help users.

The help shows another problem: it mixes two different syntaxes. I sent 
a patch to fix the inconsistency in the help. Please review it for more 
detailed explanation and actual fix:
https://lore.kernel.org/qemu-devel/20250207-bool-v1-1-5749d5d6df24@daynix.com

Let me go back to the discussion of the bool/OnOffAuto problem below:

The values the command line syntax accepts are on/yes/true/y and 
off/no/false/n.

For the command line syntax, you can always use on/off whether the type 
is bool or OnOffAuto. In my opinion, it is still not good to reject 
yes/true/y and no/false/n for OnOffAuto; why do we suddenly reject them 
when the property gets the "auto" value? As you pointed out, the usage 
of enum is our internal concern and should not bother users.

The situation is worse for JSON as there is no common literals that are 
compatible with both of bool and OnOffAuto, which forces users to 
remember the type.

So I think this patch makes sense in terms of usability. Accepting 
multiple representations for one value is ugly, but it is better than 
exposing the ugliness to users. We should deprecate the representations 
except one if we really hate the ugliness.

Regards,
Akihiko Odaki

