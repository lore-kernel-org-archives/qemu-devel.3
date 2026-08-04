Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F423C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrCvU-00046r-C7; Tue, 04 Aug 2026 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrCvQ-00045E-Ak
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrCvO-0000Ih-Gt
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785841389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPp8clQhujwMsgaTXoGjXN+e/jriPRTsEeqJ2pEtOOc=;
 b=ZMBTSlgMiAoLjNND7DS4dsbCsL7XhW+9CfwfkkdUuASnc4T7OFAHHvQA0LOs55GOJP8dmN
 FMPncz4S+QptWcJg6JOEGI8NoVda3rh00W91o1PNyqZtccTBpc5um6cMQC8EaAH4hsSm+b
 DGSmjoNSsAx2KvjBtPcjKqEvUNWwk58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-dicMlBNeM5uP5C5q0Y16Jg-1; Tue, 04 Aug 2026 07:03:05 -0400
X-MC-Unique: dicMlBNeM5uP5C5q0Y16Jg-1
X-Mimecast-MFC-AGG-ID: dicMlBNeM5uP5C5q0Y16Jg_1785841384
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so960565e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785841384; x=1786446184; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DPp8clQhujwMsgaTXoGjXN+e/jriPRTsEeqJ2pEtOOc=;
 b=M3uil8+ri4AzQE4HTS6X3G/utxcDR8dyufD0N60cl2xe+izWB4C8ii7zbhP6pIO24J
 D0BHtDsTYOM/E8dXGvL8klA4RtrXnnxC9u923MDWcOEYL39gcbxAzExzJ0ry0zgsWc2N
 xqFtcrp1pPumBQ/jOGwLPa2e4d8r4LWT6lc1r65MBCfbq4cPLbjiKsN8SQS53I04TFK7
 /T1e7r7vtjoV+4uP4JiWZ9DW+1WGXkOK0QLPxIj7fqStGO/6Rk8uw3TNksdCyjLF6dzU
 s6CgSj4m4tisjZ45S1mKRYYGDkZI6Kpn/WPsIGWk5/4behpbwbKV5daM1gR0EkRYJUGk
 xScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785841384; x=1786446184;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPp8clQhujwMsgaTXoGjXN+e/jriPRTsEeqJ2pEtOOc=;
 b=MzBll5lWnCewdy6WDNmVkb96zw4wH0OB6GFT6G8/pRvTYAWe1WtOAsAxs2Pd455fBp
 U91g67jxpkFNhmjsmK3yZHuLpmT9zLYnV2dqGinROpwNrCDzA707JINnwKNFdSt2VsUA
 2NQ8WNp1TVwhP/10NCOgJSgwQ3HKk1bdprrO2JROzJKJTfnmHoaGVxYSziKsB0gUkaeO
 haVp0m+MTPUoPAhQYUXNtFwE5GAnmm0hI6Yt8GxneVuZAKdfAMBd65zq+ZWvVdydTWXT
 FPDbqt6g6yHUx2bWkwpla/YMdiiu/lTLeP/W7GG5Q8B4uuqhChjnTVpXsq9OctOUAsnX
 ALCg==
X-Gm-Message-State: AOJu0YyYxlOExY6cwCm6l6i657Dy1MbNaerNJdKnkjfPKuD9hV4cqGxu
 VqEFCYNY/G9i4wWw8yBQfCBN7+d+4XdGISYYXhL42KvykxyCl6ve7XmwwAnTpXljcWXQGp1jPFr
 AOAGu4dXJW63UfOnlL3gjzQO+7wjQrKdwFWpGKT6SYi1c3VpRlpv1qR5A
X-Gm-Gg: AR+sD10InD9ABzE2yJeJAlauZlnkbxOvfKWYRgXoVPyB7jfYFzC7mk4gMR3BVxruo9P
 HiiY6WtMiCYeBCoAcBaswuhuCDfuAS0P/dD8beDyeeX005IaA36dK3Q+kId0EzWLBGHJGaFuznJ
 vlouiLw/SfHqZbSYq5Whw+Dey7NeEdIN/DanZKKZI1wIeDK3VQ/JWMOYFAlCITuf3bzG+LjPSUn
 AnsjvLh8i/1037FRMwVAclIysR1ZEEnWS0KfJxNvwfbQUkWz6dv7O2P8Cp3thvbjjPtgmhAD3Kl
 I4VTl+0HEuXvAx6kfsRkoOL73ohyQBsQzroM+wyxz6M4yfkXBYXqDgpJ1zbuKGrcbCQej7pRsuc
 TgUr82duBpTbx4lNNArBrB/oSTx4iYFJs0DRzphPrDhYG7HP81bwBqemmkg2016cOTjtRiwS50b
 7QJ+wbqSJq/brBs6jFvT8MSA4ictjWFA==
X-Received: by 2002:a05:6000:2211:b0:47f:853d:4768 with SMTP id
 ffacd0b85a97d-47fd72b518emr35619925f8f.20.1785841384369; 
 Tue, 04 Aug 2026 04:03:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2211:b0:47f:853d:4768 with SMTP id
 ffacd0b85a97d-47fd72b518emr35619788f8f.20.1785841383843; 
 Tue, 04 Aug 2026 04:03:03 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:54bb:1189:33b6:6950:ef97?
 (p200300cfd73d54bb118933b66950ef97.dip0.t-ipconnect.de.
 [2003:cf:d73d:54bb:1189:33b6:6950:ef97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd64eef60sm38004874f8f.16.2026.08.04.04.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:03:03 -0700 (PDT)
Message-ID: <fa4a6c1a-6b21-47b7-8d1d-25b71cd70a8e@redhat.com>
Date: Tue, 4 Aug 2026 13:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
 <CA+spn3r9X4WST1c4LYS63xN0EFogkD1dJ6P4omk7ndMDeF9D5Q@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CA+spn3r9X4WST1c4LYS63xN0EFogkD1dJ6P4omk7ndMDeF9D5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 03.08.26 21:31, Connor Kite wrote:
> On Mon, Aug 3, 2026 at 6:25 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>>> +typedef struct IsolationRegion {
>>> +    uint64_t base_addr;
>>> +    uint64_t vring_base_addr;
>>> +    uint64_t size;
>>> +    int iso_fd;
>>> +} IsolationRegion;
>>> +
>> Going beyond Stefan, I would say please document each field with a
>> proper doc comment, and ideally the whole struct, too.
>>
> Roger.  I will comment all fields, except for perhaps size, which seems
> self-explanatory.
>
> ...
>
>> In general: Please put spaces after the leading /* and before the
>> trailing */.
>>
> Roger!  I believe I have this in a few places and will correct.
>
> ...
>
>> Patch 13 adds more variables to this, so I think it may make sense to
>> have a dedicated struct for these fields.
>>
> I agree that some of these make sense to be consolidated. However,
> I think I will keep the svq array outside of the struct as the svqs don't live
> inside of the isolation region.
>
> I guess the alternative would be to have an `isolation_mode_ctx`
> type of struct to hold all of the above.

Yes, that’s what I thought, to have an object that would hold everything 
that is used by the isolation code (and rather specific to the isolation 
code).

>> As Akihiko said, the memset() should come after this, and also...
>>
>>> +        u->iso_memory.base_addr = 0;
>> ...this is just a subset of the memset().
>>
> Yes, the cleanup was not fully baked ahead of the RFC post.
> This is currently fixed on my end and will make it into the next
> rev.
>
> ...
>
>>> +    int num;
>>> +    size_t desc_size;
>>> +    size_t avail_size;
>>> +    size_t driver_area_size;
>>> +    size_t device_area_size;
>>> +    size_t total_vring_size = 0;
>>> +    size_t total_mmap_size;
>> Please do not mix variable declarations and normal code (style.rst calls
>> it “Mixed declarations”).
>>
> Got it!  This will be fixed.
>
>>> +
>>> +    /* Get space required for all vrings */
>>> +    for (int j = 0; j < dev->nvqs; j++) {
>> Why j here and i above and below?
>>
> Most likely this was inside another loop on the initial implementation, and the
> iteration variable name was not changed when the outer loop was removed.
> I will change this for next rev.
>
> ...
>
>>> +
>>> +    uint64_t last_addr = int128_get64(int128_add(u->iso_memory.base_addr,
>>> +                                                 total_mmap_size - 1));
>> I would like a comment why you went for a 128-bit operation here. I
>> assume it is because it checks for overflow, turning overflow into an
>> assertion failure, and it can be assumed `qemu_memfd_alloc()` must
>> naturally return a pointer such that adding the length of the allocated
>> area to it (minus one) will never overflow?
>>
>> The question is, do we even need to check for overflow then. Not that I
>> mind it, in principle, I just find it non-obvious. (The more obvious
>> check (imho) would be to just do a 64-bit operation and then
>> assert(last_addr >= u->iso_memory.base_addr).)
>>
> At the time I was concerned about potential overflow prior to application of
> the -1 operand in case the last memory location was at 0xFFFFFFFFFFFFFFFF.
> However, in that case, the -1 would cause the value to wrap back around before
> any use of the value, so my concern was not needed.
>
> There is a similar 128-bit op in the existing code in
> vhost-shadow-virtqueue.c at
> line 133.  To my eye, that might also be a good candidate for
> simplification unless
> I'm missing some other aspect of the use case.

But that’s a guest-provided length, no? I believe the 128-bit operation 
there is done as a genuine check of invalid guest requests. Whereas 
here, `qemu_memfd_alloc()` already must not return a pointer such that 
adding the length of the allocated buffer would overflow (because it 
guarantees that the whole range from the pointer through the given 
length is valid, right).

> ...
>
>>> +        map = &g_array_index(buffer_regions, DMAMap, i);
>> God, I *really*, *really* hate this, and find it really disgusting that
>> the documentation actually recommends doing this (`&g_array_index()`)
>> instead of just offering a separate macro to get a reference.
>>
>> And existing qemu code does it all over the place, too.
>>
>> So I cannot really fault you for it.
>>
>> Still. Too ugly for me to keep completely silent about it.
>>
>> </rant>
>>
>> Hanna
>>
> Would you typically avoid using g_array / g_array_index?

I mean, in this case, I would have just used a plain C array because the 
size is pre-determined by `nregions`, right.

In general, *I* have not used GArray yet (no particular reason), which 
is why I had not come in contact with the `&g_array_index()` pattern 
yet, which had me stare in disbelief at first. (My main problem being 
that the name `g_array_index` is written in lowercase and thus indicates 
being a normal function, whereas macros in C are generally written in 
uppercase to allow at-a-glance distinction. So it pretends to be a 
normal function, but glib recommends a pattern of use 
(`&g_array_index()`) that would never work with a normal function, and 
that I find a dreadful decision by glib.)

Hanna


