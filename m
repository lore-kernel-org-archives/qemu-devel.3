Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F808C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrvKr-0008QR-ST; Thu, 06 Aug 2026 06:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrvKo-0008QE-Rm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrvKn-0004PF-0h
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786012100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mhw1/EUHAkm8HexVtFz8Jxi41Jjd/FjijtMau9/paKQ=;
 b=EW/189ekILdFEXqD+07ZRMEfpzK0y8g/pvBmwH7F4DnqyjRN76ryAXmHIOs0q1nBzu63ls
 M/etkNL357ub1YKKdA6fCKWsJZ5n7Qk/ztE2iQ6ES57a8XwHNsuO6qXqHWhzvY/FQ5JAsl
 AuCAW5Nd3P7bgd/+Cx5c45uUL3fThLc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-gXxMKqaXMUmEsrm304_4dg-1; Thu, 06 Aug 2026 06:28:18 -0400
X-MC-Unique: gXxMKqaXMUmEsrm304_4dg-1
X-Mimecast-MFC-AGG-ID: gXxMKqaXMUmEsrm304_4dg_1786012098
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4740be00302so1628096f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786012098; x=1786616898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mhw1/EUHAkm8HexVtFz8Jxi41Jjd/FjijtMau9/paKQ=;
 b=UOGUW0vQHhqOqIA1qJUDL2Zk9VwX5yXNE/8hIWWmMYhwpBDmxkV20uN53JflsMhuZA
 Z060reW6BqjZb37lGwZxRO09YStqw+PAFJLx+urKNhWb1UVTvwwp9DdryyFF+0M58tIf
 96h3DOTRwsiAlrwJe6oZ95gTIKBGciwwKgsb1Oqopc707Gp3GJtcWox141XxKOlS2F4h
 1HUhNBHtNahH7LEsRcGV8Fn0eVymWqvHCx2NHtYzbBx8372KXddF/+Y5snFp27PZNy/G
 HXW7rc6/IVWxto7O2Be4zValv7sA64/okO7K9GI6/m6JHrFutgWsTOR5F78583MYTAX3
 dR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012098; x=1786616898;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mhw1/EUHAkm8HexVtFz8Jxi41Jjd/FjijtMau9/paKQ=;
 b=dyaszcyT2mHfZHRQx0p6Cw1op8sv7SLJO+WZqrTOSCe7eO0ZH8lGfykNno728zpQap
 KpqPs8hOkCCEEgo0Blt+Ko2gzzckm9TFn6RkCK0B4O7f62xn/rMH+amisgnFET81iU1o
 sQUO5r7F1RdNFqBvAodGNigzrNltRq32cwT7YNj5YvBo1S1zRwmmChEv7dVYdPNzcxGl
 C0db9t9JYTzPoSK+yjExDiC8tLCeU+v6VJu35KHTZm1CaBLhGO/YvFI54H45rUPSmdK5
 g1SEHJZCdZUip7o7ZekSC/j0N6wTpkY7V7iWblrlSOyv9Nr94RgP0OqaBuT6+fJxV7wD
 ZJXQ==
X-Gm-Message-State: AOJu0YyH1Su0irh0RzSIT+7xf7AommKI1aCG7CvDyVnlG+hac6GGW2dV
 NXp9ePLBGZ09sR1fYjUt2JG7sHOC6/NXjLTDWT65uI3nvsWmeDeUXFl7bt7Py1KYIpGWHELoQ6L
 f04leutQNX7NHaOIzASlbmAj6fbQJguWPLVXsufF+diH3MvGmJmrYf72e
X-Gm-Gg: AR+sD11rL6iDqL7UAWZcUxy/91wRY+Y4nLdFrN5Jh9cw+N5MqVt5cMcH+myfr5v8bPI
 QpnjbnWpb8k2u3ZEhk5IvWGr9MHvJI10RB4eViO+WAfguIiD6/6pyok3lw4GVO1vaT2hA86dV96
 RkSx9fs6UCWmwX0G5ZVqou+DZ+b+JlG65t+l5+Iqos+6J8pg2lOyxfmFMmAawaB2NwlKLiMHNkP
 f08ZfCBxgfK1knADDU2Q3hRwmegVdhZLL3tY22xivjGqeM5x5OvYtNLJLaM4akViM6m25ViyWyi
 TmdJo9/bRqgmhYvsiqZ2l4kIhBk6wzwo8XR/Ry471QeVgbieTJeF6mGdqSvbuUyKCLkHotxChUx
 aBYK3G9XGBc2gVNcVm6dsp887RhUJz1M3fsBzr5Vvd89aDxgJsjbsOGaOO5nlmjdqGO7G7rnAqU
 9yT87mR726j1wBtTAc1yIrUI3SnNdU0w==
X-Received: by 2002:a05:6000:1cd0:b0:47f:51bc:efe2 with SMTP id
 ffacd0b85a97d-47fec4f11d9mr17735637f8f.11.1786012097691; 
 Thu, 06 Aug 2026 03:28:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1cd0:b0:47f:51bc:efe2 with SMTP id
 ffacd0b85a97d-47fec4f11d9mr17735562f8f.11.1786012097276; 
 Thu, 06 Aug 2026 03:28:17 -0700 (PDT)
Received: from ?IPV6:2003:cf:d706:f1b0:892a:16ba:c1b8:17c4?
 (p200300cfd706f1b0892a16bac1b817c4.dip0.t-ipconnect.de.
 [2003:cf:d706:f1b0:892a:16ba:c1b8:17c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79a718bsm5586258f8f.5.2026.08.06.03.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 03:28:16 -0700 (PDT)
Message-ID: <738737aa-64ed-479b-bba7-1b0326ef30c0@redhat.com>
Date: Thu, 6 Aug 2026 12:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/15] hw/virtio/vhost-shadow-virtqueue: used handler
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
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
 <20260723-vhost-user-isolated-memory-v1-8-6b97c439eb28@gmail.com>
 <39200a6f-8241-4033-ba7a-5c9bbbdc8ff1@redhat.com>
 <CA+spn3p-Fc_uLO1bwSXC39kmQ-iR-OpB-a6cjMTphb-_Ant-_w@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CA+spn3p-Fc_uLO1bwSXC39kmQ-iR-OpB-a6cjMTphb-_Ant-_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.08.26 04:50, Connor Kite wrote:
> On Fri, Jul 24, 2026 at 4:29 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> The error of the handler that may have left elem stale is ignored here.
>>
>> Regards,
>> Akihiko Odaki
> I have now added in a check that returns on error without setting the guest
> notifier.  So essentially the call is ignored.  Maybe this could be expanded
> on to handle errors more gracefully depending on the error code.
>
> On Tue, Jul 28, 2026 at 8:06 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> +/**
>>> + * Callback to handle a used buffer
>>> + *
>>> + * @svq: Shadow virtqueue
>>> + * @elem: Element placed in the queue by the device
>>> + * @vq_callback_opaque: Used to pass arguments to callback
>>> + *
>>> + * Returns 0 if the vq is running as expected
>> The doc comment should mention what non-0 look like. Are errors reported
>> as a negative errno?
>>
> Yes, a negative errno is expected on failure.  I have added clarification to the
> comment.
>
> On Mon, Aug 3, 2026 at 5:42 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>> On 24.07.26 00:30, Connor Kite wrote:
>>> Adds a handler callback to shadow virtqueues in order to enable
>>> non-default processing of used vring elements from the device.
>>>
>>> Signed-off-by: Connor Kite <connorkite@gmail.com>
>>> ---
>>>    hw/virtio/vhost-shadow-virtqueue.c |  4 ++++
>>>    hw/virtio/vhost-shadow-virtqueue.h | 14 ++++++++++++++
>>>    2 files changed, 18 insertions(+)
>> The avail handler replaces `vhost_svq_add_element()`. I find it a bit
>> unintuitive that this handler does not replace `virtqueue_fill()`, i.e.
>> that it is not a “mirror” of the avail handler; that the avail handler
>> actually handles avail elements, whereas the used handler is “just” a
>> callback on each used element. Was that intentional? (If so, I think the
>> comment should be explicit about this choice.)
>>
>> Hanna
>>
> I implemented it as a more narrowly-focused callback since virtqueue_fill
> needs to be called regardless.  If I instead called virtqueue_fill
> from the handler,
> I would need to pass in the elem index and length via svq->ops_opaque,
> which is a bit awkward as vhost_user defines ops_opaque when registering
> the callback.  That's certainly not impossible to do, but this way felt cleaner.
> For now, I will add a comment explaining that the callback should not be used
> to add elements to the underlying vq's used ring.

Then I personally wouldn’t call it a “handler” if it does not handle the 
element like the avail handler does. Maybe “callback”.

Hanna


