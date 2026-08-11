Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C2FC5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtks9-0006lc-M0; Tue, 11 Aug 2026 07:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wtks8-0006lB-9L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wtks6-0007pr-IJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786448537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83Z7giIsXRjL+pG88JPHrWsQSLh0SWtxmdOYGdneAnU=;
 b=eCYx7SISujDksirvxmi4HRqGC+0vMKI6tZfj0DciEY7ej5BEZ5OG0FSFOEKw1FTGvsP5yu
 4CaEaLMdlgUKX3bV//T+aS5U5qsct+abTynFoR3Q83wx4lFRuTazrNxBi4u1cKYf5L5KCw
 W5CGWAZiBewsrJSjttNTecDo1zH+asg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-sZWU2c0aP-qp3M38qJ0fQA-1; Tue, 11 Aug 2026 07:42:05 -0400
X-MC-Unique: sZWU2c0aP-qp3M38qJ0fQA-1
X-Mimecast-MFC-AGG-ID: sZWU2c0aP-qp3M38qJ0fQA_1786448524
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso456285f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786448524; x=1787053324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=83Z7giIsXRjL+pG88JPHrWsQSLh0SWtxmdOYGdneAnU=;
 b=HAXX5mQHmMozKcv7p0XQwBIHhsCUCGWK1lZRYYe32NV95u1YvpFeKYe1tsHzmDLuDN
 xOj1X9Toqr7bd+r6ORO2E2HonsR/NN86wJ0klK7sDiPCP+G9K84zNWZmI9t1N1gXgNgZ
 +SmkxJPIS7SEFA61KdjAKbUuGTNdCtf2Zyw/U1vQFMdD2cvLLEt2yqi2vSng3tZSDq+u
 0ORmV24coLUXbcZyg0Ai9AQFaZcUpTEooisQX4nbdbDrst2wC+zheg4TIvpDBn/CzzHZ
 sXtJaRlZ27gIs404ShiCeu0vydQIns5ZrxiIPJPHmgyit/+6FcMfpGcS662zvV2IA12w
 uIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786448524; x=1787053324;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=83Z7giIsXRjL+pG88JPHrWsQSLh0SWtxmdOYGdneAnU=;
 b=f6bCu9cAFsYr2I/HcQMMx+Vj6ZOA3WNguYduY0BrX9tSVpp5Fxqfitkaq8utUS8YGZ
 GX8n96u65/yVYjr+jnBrzwO6fFSuVJx/WnewmbThMr/aHFP4oolg4M3GuYHlFKJOCbr5
 OddF01hlOI1b1GaKfzVMwqImg11hQlXM8C8bdxZIjJNvsMD16WVQYoFxVKBIMd8nvcP7
 7Dzrf1WrAH6W/RG2hy4HRBqo0iXfJd1Eykye4iQsGsw+ZefrsNSxOT4kOwTctZcAglg+
 E2LTCg3qCoD/N5Sbt22Mk5wmvHaNAM+GNL0GInQ76PnEf6Vn/sq8pnmAKvJy9JhF0J0u
 2QMg==
X-Gm-Message-State: AOJu0YxSYvi3sojEiN5vHEzaizldQYYbZQbIEi/IJDerkPmpfdj2nKkI
 bnlYSkJXCQMxP1/6zXIyvuBroV2RpRp9+ctCHcGc45qvo5MECemmcC8zG2zD23OnxRXbTieggrq
 oJVzrbOxgqffsDbJLdKdCAWpS87AYWSc60doKaVOXtUx38VhK6yl8ljji
X-Gm-Gg: AR+sD12h7Qh1hfBINvl54pN4y7ogtQLha3GKyEwT6OhmGOJifhjUNqhUujqXTo5vxKN
 HNwLRVPIKhFjqgHth5TvKLc76NJmFccOAXxVtE2PKeAmadFoWlBCc47sPWI8egWgrGavgwknSFk
 xLaDROyLdpEAO/SJRNrdKfDoiCurFDam4B66K2dMTiw898H4Tf/U3/27fysz/chD0YB5I2CFbuT
 MNYkdYgG3PFPHYCZMNtld0KCgTzhTDvbBfIc0pZELKCm1jdWBFQNT2F9RCFViBk8aGDdcmTLbIf
 LKbpVYc9FUGkPATodPqVpKWXGibsNbRSOaO+Kj6xE5U+VD4WahJT5JwNZ8/9mu6rTlCiO2evDPR
 ffG4ucT8ByNDdcR+LDv4m1fomlfzMzpDH6/9VVuNJw4pEdo+ThL4WtzpKeWtX71tdW/3+CFDD3+
 fEigepfjxc8OZZGrEeBfZGN3W6/T8jVQ==
X-Received: by 2002:a05:6000:60c:b0:481:98d:b24 with SMTP id
 ffacd0b85a97d-4814adbd65amr3736939f8f.19.1786448524412; 
 Tue, 11 Aug 2026 04:42:04 -0700 (PDT)
X-Received: by 2002:a05:6000:60c:b0:481:98d:b24 with SMTP id
 ffacd0b85a97d-4814adbd65amr3736878f8f.19.1786448523950; 
 Tue, 11 Aug 2026 04:42:03 -0700 (PDT)
Received: from ?IPV6:2003:cf:d706:f1cb:272a:2c7d:bb01:94e8?
 (p200300cfd706f1cb272a2c7dbb0194e8.dip0.t-ipconnect.de.
 [2003:cf:d706:f1cb:272a:2c7d:bb01:94e8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a709624sm4220464f8f.22.2026.08.11.04.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 04:42:03 -0700 (PDT)
Message-ID: <c549061c-8e9e-48a6-a149-2da743154c10@redhat.com>
Date: Tue, 11 Aug 2026 13:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues and
 eventfd intercepts
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
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
 <13594665-16ec-47e5-9075-f7bd5552b0a3@redhat.com>
 <CA+spn3r7+pEb7e6=8JixTpk7M3rNhWv=JkGZchj2-3FK9ZQGYQ@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CA+spn3r7+pEb7e6=8JixTpk7M3rNhWv=JkGZchj2-3FK9ZQGYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On 11.08.26 04:32, Connor Kite wrote:
> On Mon, Aug 3, 2026 at 6:52 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>>> +    struct vhost_user *u = dev->opaque;
>>> +    int svq_idx = file->index - dev->vq_index;
>>> +    if (u->user->memory_isolation) {
>>> +        VhostShadowVirtqueue *svq = g_ptr_array_index(u->shadow_vqs,
>>> +                                                      svq_idx);
>> Bounds checking via `vhost_user_get_vq_index()` would be nice. (Same below.)
>>
> Adding the bounds checking outside of the memory-isolation only code path, since
> file->index wasn't being checked previously.
>
>>> +        if (svq->hdev_kick.initialized == false) {
>>> +            int r = event_notifier_init(&svq->hdev_kick, 0);
>>> +            if (r) {
>>> +                error_report("Failed to create kick event notifier");
>>> +                return r;
>>> +            }
>>> +        }
>>> +
>>> +        file->fd = event_notifier_get_fd(&svq->hdev_kick);
>> What if `file->fd` was -1, i.e. `VHOST_FILE_UNBIND`? Should we put a
>> real FD here then or just continue with -1?
>>
> Good point!  I think we need to propagate the -1 to the backend device, and
> run event_notifier_cleanup on the existing svq->hdev_kick.
>
> ...
>
>>> +
>>> +        if (svq->hdev_call.initialized == false) {
>>> +            int r = event_notifier_init(&svq->hdev_call, 0);
>> Do we need to check if the call event FD is already active?
>>
> Do you mean, do we need to call event_notifier_test_and_clear to see if it's
> been set and potentially run the call handler at this stage?

Yes, that is what I’m wondering. `vhost_svq_set_svq_kick_fd()` has this 
comment:

 > event_notifier_set_handler already checks for guest's notifications if
 > they arrive at the new file descriptor in the switch, so there is no
 > need to explicitly check for them.

So it sounds like there is some mechanism that will ensure that when the 
kick FD is set on a shadow virtqueue, it is checked for activity 
(notification), and if it is active, this is… handled? Which I suppose 
means the installed handler will be called.

But it’s entirely possible I misunderstand something because the same 
code in `vhost_svq_set_svq_kick_fd()` also just calls 
`event_notifier_set(svq_kick)`, so… kinda always emulates a kick, I assume?

In any case, there seems to be worry about pending checking kicks from 
the guest in this switch, and so I wonder if the same needs to be done 
for the call FD.

Hanna

> If so, this might be where some of the intricacies of when things happen in
> vhost-user vs in vhost would require some extra care, unless isolation mode
> implementation moved up into vhost.
>
> ...
>
>>> +    /*Modified from vhost-vdpa*/
>>> +    u->shadow_vqs = g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
>>> +    for (int i = 0; i < dev->nvqs; i++) {
>>> +        VhostShadowVirtqueue *svq;
>>> +        svq = vhost_svq_new(NULL, NULL);
>> Patch 15 adds clean-up for this; I would squash it into here, as far as
>> possible. Ideally, a patch series can be stopped at any step and not
>> break anything, so if an allocation is added, the accompanying freeing
>> should come with it.
>>
>> Hanna
>>
> In hindsight I shouldn't have considered cleanup a separate stage in the
> development.  Too easy to introduce bugs that way.  I'll move cleanup up
> and comment in the Patch 15 thread.
>


