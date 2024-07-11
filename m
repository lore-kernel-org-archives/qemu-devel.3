Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81C9C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsDl-0001jC-NM; Thu, 11 Jul 2024 07:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRsDb-0001h6-VQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRsDZ-0001LG-Ka
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otBOAFz3tqAa9bdmN+8Fz71SKEjalhMyVrnoivwIn+E=;
 b=HfgjaVDju6Zw0jUnjR6z5uuYOJm3W9IZNu4JQR8bhbk+j8tXs7VC+MEAAum1FxT4wl14mp
 +Y/LnEPicUOcuI5t9ch04DunzJajXwylVUI84VtVFUU2k2n/yLb4EMYHtTKYBcxsRNfs3A
 P7aYZKbeF1gsksH/zlTTvg3x6XoCtkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-cfnEzuJZO_mLdJLNruk2Kw-1; Thu, 11 Jul 2024 07:44:04 -0400
X-MC-Unique: cfnEzuJZO_mLdJLNruk2Kw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c6e28b151so806125a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720698238; x=1721303038;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=otBOAFz3tqAa9bdmN+8Fz71SKEjalhMyVrnoivwIn+E=;
 b=JakXaysfVLh646k2WW8Nfp7C4EYwGx5cz7FdqIIghTdRNkzY0QZh1iqYUXmL+nPJSv
 5/BisAbSpSsiI9otNjul5UTpRwcU/P5EXT6fcwewIamOFKNP71qlhMggigzWy1fkFI67
 74zMIlVXQ5ur8+nA8K5OO+pA6xGytszsxIygAN4VcRuZcNx+mlgjsW+SDVri598r0CnB
 7Y4BPx4IDG3iUmwo79x+FtBNF0LVxUR4jgxJ9Y47wqG8nFRHZAPjX8R0btlt6Cbcx0C7
 s+qaHHlHbElN2fDD7xvV4R1/lQTPD6rIYEbVNer88dER1MkF1Xloc8UtiKcf2MAFZYGC
 qx6w==
X-Gm-Message-State: AOJu0Yztt8Cfw3i7Fh+NP7M2FL41hlc1fwANm9K8PilKDNBstObiAWyw
 lDygNk0xrE+3w6fhAhp9TwVog+qdiUPd4h6biHzizKiscHvHnvzrwZETMmblV+lXEqZLJy26VAi
 dZDXnNhuWDWRX/KbyZlCbS0CgKmvJ0qanjU4lZtQtaIYOQ8AUoWmo502+XXsJ
X-Received: by 2002:a05:6402:5cd:b0:57c:fd20:352c with SMTP id
 4fb4d7f45d1cf-594bc7c8337mr6411062a12.34.1720698237884; 
 Thu, 11 Jul 2024 04:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3pEQW6kcrDi7oUPsaLBRXAsR8n7WBnr6Fr18j8ouNai3fV5JxtopbUueZKe2eRltdLQtMQ==
X-Received: by 2002:a05:6402:5cd:b0:57c:fd20:352c with SMTP id
 4fb4d7f45d1cf-594bc7c8337mr6411037a12.34.1720698237166; 
 Thu, 11 Jul 2024 04:43:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d?
 (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bbe2cf60sm3362378a12.26.2024.07.11.04.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 04:43:56 -0700 (PDT)
Message-ID: <206a4ad7-53f2-415a-8756-b369c05d0338@redhat.com>
Date: Thu, 11 Jul 2024 13:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH] virtio: Always reset vhost devices
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20240710112310.316551-1-hreitz@redhat.com>
 <Zo6PKHFzM0+VLdBg@fedora>
Content-Language: en-US
In-Reply-To: <Zo6PKHFzM0+VLdBg@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.07.24 15:39, Matias Ezequiel Vara Larsen wrote:
> Hello Hanna,
>
> On Wed, Jul 10, 2024 at 01:23:10PM +0200, Hanna Czenczek wrote:
>> Requiring `vhost_started` to be true for resetting vhost devices in
>> `virtio_reset()` seems like the wrong condition: Most importantly, the
>> preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
>> up in `vhost_dev_stop()` (through vhost devices' `.set_status`
>> implementations), setting `vdev->vhost_started = false`.  Therefore, the
>> gated `vhost_reset_device()` call is unreachable.
>>
>> `vhost_started` is not documented, so it is hard to say what exactly it
>> is supposed to mean, but judging from the fact that `vhost_dev_start()`
>> sets it and `vhost_dev_stop()` clears it, it seems like it indicates
>> whether there is a vhost back-end, and whether that back-end is
>> currently running and processing virtio requests.
>>
>> Making a reset conditional on whether the vhost back-end is processing
>> virtio requests seems wrong; in fact, it is probably better to reset it
>> only when it is not currently processing requests, which is exactly the
>> current order of operations in `virtio_reset()`: First, the back-end is
>> stopped through `virtio_set_status(vdev, 0)`, then we want to send a
>> reset.
>>
>> Therefore, we should drop the `vhost_started` condition, but in its
>> stead we then have to verify that we can indeed send a reset to this
>> vhost device, by not just checking `k->get_vhost != NULL` (introduced by
>> commit 95e1019a4a9), but also that the vhost back-end is connected
>> (`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).
>>
> I am not a native speaker but I think the commit message could be
> rephrased to make it clear. This is a minor comment so feel free to
> ignore it:

Thanks!  I don’t mind restructuring, I just wanted to be verbose on 
what’s happening.  Honestly, I’m also not 100 % sure about my reasoning, 
which is why I put a lot of indefinite fluff in there, i.e. purposefully 
was not clear.

I wonder what exactly you find to be the problem with it, though? Too 
much fluff, too much detail, weird sentence structure?

> Before `virtio_reset()` is invoked, `virtio_set_status(vdev, 0)` for
> vhost devices ends up setting `vhost_stared` to false thus resulting in
> `vhost_reset_device()` being never reached during a reset.

It’s before vhost_reset_device(), not virtio_reset() (all of this is in 
virtio_reset()).  Also, the “`virtio_set_status()` for vhost devices” 
sounds a bit strange and too detail-less to me; (A) it makes it sound a 
bit like it’d be only called for vhost devices (easily solvable by 
moving “for vhost devices” back after ”false”), and (B) I would like to 
have the detail in there how vhost_started is cleared by the set_status 
call, because it doesn’t seem obvious to me.  Also, I find the “never 
reached during a reset” strangely abstract; we can be very concrete 
here, so why not be?

Maybe

When a vhost device is reset, we want `virtio_reset()` to call 
`vhost_reset_device()`.  However, `virtio_reset()` begins with 
`virtio_set_status(vdev, 0)`, which, for vhost devices, will end up in 
`vhost_dev_stop()`, clearing `vhost_started`.  This makes the subsequent 
`vhost_reset_device()` call unreachable.

> `vhost_started` is not documented, however, from `vhost_dev_start()` and
> `vhost_dev_stop()`, it seems indicating that there is a vhost back-end
> and that the back-end is running and processing virtio requests.
> Resetting should not rely on whether the vhost back-end is processing
> virtio requests, instead, reset must happen if there is no processing
> request. This is what `virtio_reset()` does, it first stops the backend
> and then sends the reset.

I find this unclear on how vhost_dev_start()/stop() indicate what 
vhost_started means (it’s because they set/clear it).  I cannot stand 
behind “reset must happen if there is no processing request”, because I 
don’t know for sure.  I just feel like it makes more sense this way, 
hence me saying “probably”.  I miss context to “it stops the backend”, I 
would like to be clear that it’s through virtio_set_status(0) that the 
back-end is stopped.  I find it important to be concrete here because I 
asked myself whether e could pull vhost_reset_device() up before 
virtio_set_status(0), and this paragraph is intended to convey that that 
would be wrong; I want to be clear that the concrete call order in that 
function makes sense to me.

I also miss a connection to why this paragraph is focussing on 
vhost_started now.  Maybe I’m a bit slow at making connections, but in 
this rephrased version, it is not 100 % clear that vhost_started is a 
condition for vhost_reset_device() (unless one looks at the code 
simultaneously), so its importance and why we need to know what it does 
isn’t clear here.  The very start of the original message however did 
stress that the vhost_started condition seems wrong, so it’s clear why 
it’s important at this point.

So maybe

Requiring `vhost_started` as a precondition for `vhost_reset_device()` 
is also semantically questionable: While undocumented, it being 
set/cleared by `vhost_dev_{start,stop}()` indicates that it shows 
whether there is a vhost back-end, and whether that back-end is running 
and processing virtio requests. The latter should not be a condition for 
doing a reset, on the contrary: A reset should preferably happen when 
the back-end is stopped.  Thus, the order that we have in 
`virtio_reset()` (stop the back-end via `virtio_set_status(vdev, 0)`, 
then reset it) makes perfect sense, but checking `vhost_started` does not.

> To trigger a reset, this commit drops the `vhost_started` condition and
> checks that the device is running (introduced by 95e1019a4a9) but also
> that the vhost back-end is connected so it is possible to send a reset
> to the vhost device.

This seems incorrect: First, we decidedly no longer check that the 
device is running, that was the point of the previous paragraph. Second, 
no such check has been introduced by commit 95e1019a4a9. That commit 
just introduced a check of `k->get_vhost != NULL`, i.e. whether this 
could even theoretically be a vhost device.

So I’d just keep the final paragraph as-is from the original patch. It 
isn’t much longer, just quotes more code.

Hanna


