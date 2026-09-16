Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC01C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6oO0-00055p-U0; Wed, 16 Sep 2026 08:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6oNv-000510-OY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6oNt-0005hx-Ab
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789560303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6m152CHRqoa067avL/8cN9UAHfnwOMC0f6f14crK74=;
 b=iNsdae6KlH88/1vQEYIaWHyrNL//51WUKOIJNN9VQTIIkFTaTMOxPzbzecaWbsYY9Z6orp
 6nIbs/nK1g6h7jBmlVkD3H8DXIsrnn1ccERis4k512LgO0Izv+Ilk7uW9XSV+gd7xqrOKs
 Vu4IvXJHErek992i4db7Qg0IhGeQee4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Zin6AZXfMlG7NWbYx74gQQ-1; Wed, 16 Sep 2026 08:05:02 -0400
X-MC-Unique: Zin6AZXfMlG7NWbYx74gQQ-1
X-Mimecast-MFC-AGG-ID: Zin6AZXfMlG7NWbYx74gQQ_1789560301
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c293e9cd02fso640000866b.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789560301; x=1790165101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q6m152CHRqoa067avL/8cN9UAHfnwOMC0f6f14crK74=;
 b=AVFmHD/Z++UE+HhNRieG6W32BgLALbehdF2t9BG1q0tNADH3X+0lU92jNl3D1CcX4B
 Z3hnQtuI8/6TlIudrj0edHGKJcRut+/XWfbAoKlNfDNwafW6N0qShrQxngBuFr0cbWQs
 xZeI+Zi6Vmlq3pmX3NTcBepWt36prlBB6sh5pOCjesXQ1FAnmGQIk6q1CwFp1A/7Gaq3
 BdCkF+Edz6l9kVNRb8x+GkKrJ1ajeXS9ogR9v/or3cxu8vMMnzcTX1fkG9Boa5hG3HNn
 MzgAEZISwWTjfLcWcwf9GrOJ5VdYn5VJmgMnnPJCNU+k00zVvnk5JFOhjWNjRJRJRgMT
 KoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789560301; x=1790165101;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q6m152CHRqoa067avL/8cN9UAHfnwOMC0f6f14crK74=;
 b=l1QHGcSyuH/vIyg5Q2Md78y7PXbL9LGH8ohJmW8suXLaYwy7F9rDyz1Jyi/51XcFDI
 cluoVEYNK/ozDpRb30y7JzQu7LYid+f/55iY3nZt+2jOSKTU5WP+hLEkToGhZpcnD3XI
 3wqkLREhPFupwZzKxJ8ubUulMkUJ8JuycPHExpEoSE+NizkHD188KRVR9WY+y2wN4miG
 Q3N8E/igPmtuqro9SuZa5X1tOwuxoCKrjEEVDY44CKP72vUjk3LDNRJoBON1uHzeaQ0r
 cZUnFyliMavuoFFI2JLhNTUt9C+uvwtvfUPJCPlhGbHj7bVsVlxbNH/YmjSWcVO54nQA
 MJsw==
X-Forwarded-Encrypted: i=1;
 AKwUvByT5DMTKE6UtXTjiNm4luvdjivUAvYzgpsDh3ElsyrUwevJGnd+J5w7nbdKYu9u5VbdZjnOXKwBsVW/@nongnu.org
X-Gm-Message-State: AFuF++l6DfSkTzeSu4XQygVj35d2W1axktsguk/isJ01l8NUyqffr3iX
 EeMd6o4C7sPTTwKtWQPHmZ2qEKt8/NOLOFyiJq+nshj7XpX45fM7iVo5XHpcwW2MCKHgDPBvpPn
 olonJlNQpqy66O0lVf0AjZxmqKXdqKaOFCYR0CAHeeNBKILIFB/11UOaT
X-Gm-Gg: AYBFou2w9XWQK1jDOEHIibltVFjYgfLZVv8/qWRBD2yCxbNw0iy5wB4RKdzeOOhBtBw
 uiaWsTeahhj6KpXNRoWRPsqdhX2C9h1YFa4KuCD+wT8Ivv+1/hgldYgpbPSajWDIvAC4oaoLy6H
 3QcvfOHPj2leXa8btQ/ZU87c4xfj9GU8PfWPpsf5ts3iVunvb39SLNXMV+MJKGnpOdM/klJGAch
 QVBb2q0auAKW0aMtOIZnwIHyz7W3wIwK4S/FchZANexxYqVUWl9B2Q5bVZrLQ50bNTZoa9B+T+P
 ECyhbUIH6O9VojUzxPipzven+WyabV23SSgXciuFsaJiA+OgoWyXVdcjv4C6cQaETKHmF/WlkPM
 Gbu/IWHPvhkriZWzUYDZwQTzOM51JOaqjgIP1VB9LupLCFD8FjRDyFoywacHbBsqNAMYTUuJfkk
 pA7FKXr30/nNMjsck7oGQryCzK83o=
X-Received: by 2002:a17:906:6296:b0:c26:1dc7:bc42 with SMTP id
 a640c23a62f3a-c29e521bf1amr151824966b.22.1789560300783; 
 Wed, 16 Sep 2026 05:05:00 -0700 (PDT)
X-Received: by 2002:a17:906:6296:b0:c26:1dc7:bc42 with SMTP id
 a640c23a62f3a-c29e521bf1amr151822466b.22.1789560300258; 
 Wed, 16 Sep 2026 05:05:00 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de0898bdsm128096466b.5.2026.09.16.05.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 05:04:59 -0700 (PDT)
Message-ID: <ccada8d9-b94b-469c-9602-1d1085fdba47@redhat.com>
Date: Wed, 16 Sep 2026 14:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
From: Hanna Czenczek <hreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com> <20260903142359.GD825275@fedora>
 <28da45c4-51ce-452c-b7d7-a18b68d2dd1e@redhat.com>
Content-Language: en-US
In-Reply-To: <28da45c4-51ce-452c-b7d7-a18b68d2dd1e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16.09.26 10:14, Hanna Czenczek wrote:
> On 03.09.26 16:23, Stefan Hajnoczi wrote:
>> On Mon, Aug 31, 2026 at 03:52:02PM +0200, Hanna Czenczek wrote:
>>> When a request finishes with a higher latency than a predefined
>>> threshold, emit the BLOCK_IO_DELAY event.
>>>
>>> Note there would be an alternative, more precise solution: We could 
>>> keep
>>> all active cookies per BlockBackend in a list and repeatedly iterate
>>> over it in a background coroutine (woken on a timer so it would wake
>>> always exactly when the next request would time out, so it generally
>>> stays asleep until there is actually a timeout). This way, we could 
>>> emit
>>> the event exactly when a request crosses the delay threshold, while it
>>> is still running; and we could hypothetically even take actions like
>>> pausing the VM until the request is done so the guest operating system
>>> is shielded from extreme latency spikes.
>>>
>>> In practice, this is very complicated because latency cookies are
>>> created and finalized all over the place, so it is very hard to
>>> guarantee that every `block_acct_start()` is matched by the right
>>> finalization to ensure that cookies are properly removed from the list
>>> when they are done. Even if we fix all non-matching places now, 
>>> there is
>>> hardly a guarantee this will be kept in order in the future.
>> I think this patch series already couples the accounting so closely with
>> BlockBackend (i.e. adding the offset field into the cookie struct and
>> adding a BB pointer into the stats struct) that we might as well fully
>> integrate the two. Then callers don't need to manually manage cookies
>> because BlockBackend does that internally and the concerns about
>> lifetimes go away.
>
> I don’t follow how integrating them into BlockBackend automatically 
> solves the problem.
>
> Are you suggesting that blk_* I/O functions should do the accounting 
> instead of the device emulation code?

The thing is, AFAIU, doing that would cause changes in behavior, because 
the hardware device requests don’t always line up with the BB requests.

What I could do would be to abandon the cookie-based approach 
altogether, of course; instead creating a completely different tracking 
object in those BB functions and put those into a list. And then we 
could decide at a later point if we want to integrate cookies with that. 
The only downside I see is that this would mean the latency reporting 
would not line up with the requests reported in the stats, or the histogram.

Hanna


