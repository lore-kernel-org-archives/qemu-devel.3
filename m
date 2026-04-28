Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC253FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjVN-00041R-Da; Tue, 28 Apr 2026 10:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wHjVL-00040n-3W
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wHjVJ-00070c-1p
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777386813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVhn3Bas0XxWNFNq81Q/o41h6X8ghQ3uHBVk2tXWazA=;
 b=RIRr7DBazMnzvv7FVTwOiZoM8UWNEHauarz4xVEPYLt0puv0jlAHWZ1IgSvWhdyDjC8uFM
 t+Xzef2daRXF3QBDBO9KyLEvQz9T+42htoEpozK9e5Ivj0XfBgjt166A4HvUbH5OfjPTh9
 sTY71QMFniTfj+lQ92Dnp42Vne+IWZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-4_zUEu2UM6CKE8yfqrVWQA-1; Tue, 28 Apr 2026 10:33:31 -0400
X-MC-Unique: 4_zUEu2UM6CKE8yfqrVWQA-1
X-Mimecast-MFC-AGG-ID: 4_zUEu2UM6CKE8yfqrVWQA_1777386810
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a529bc0so7280099f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777386810; x=1777991610; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nVhn3Bas0XxWNFNq81Q/o41h6X8ghQ3uHBVk2tXWazA=;
 b=clWUhlkEsO/r8RtbgepgnhX/CIwXS+XQAWCZneb/uR99JshpY7rLg9RWoqOFh8TnaM
 M9jQDHcEyXBO8d8JQhFUrVtIiH8uyiY8KDdfwoe2B3bg6FVcMMXr+6IVux7mQj864su0
 zBLepPk2V6ICNBfSyVbk0KlOiTXz1xEPF5qPr7eviqgD3eXOvu/gnCUoQW5DkbevIfhQ
 4Oarnl7qjy5Hw8sUkjpyFhSaNIaBTuFcRNBOKCYLOXb+wOuKUXkUvx3f4Pea4fP4lC/b
 BCTYjcTLQQLZhP2hNm+Xf1AlG3wVijD14Tr/tD3YhhUv0QB5x6N+4IDGzUkRQ6JUwbeF
 0fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386810; x=1777991610;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVhn3Bas0XxWNFNq81Q/o41h6X8ghQ3uHBVk2tXWazA=;
 b=oJoOG1Foi01/FFJevzduUxI9hgAUnRWttQGAK5Unh9jXG6iiQMCy/mq5amAZRYwSUt
 k1BBdQgyKPJmb/tIolgdif1NwOvqhuLp0UY2p8BxBRwvri8clefYbqL910OxxTQ+MF7K
 9CcnZDln4Pfg/CXIn4HMXlLuhAB6Bn5DVJFopmjuJfhoQ9KY9iYhB/o7cF8Pdu+leK48
 72dMHMt9qvQshcPDbb0AOMJLlDxs8SWNetfK4yzjKzVlUxhkAAZou4Qw3eSLF+EbNgfx
 FhjfxH+sUXMciSdxs0oXhGB+b3UB8hS9l0cN19AvF1QjTdSgWuiaKckajz+vcEHJl+71
 GVrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NfHfoSxy+vcoHQxOz7frRXtEFXSqVdOdwlsY3qNGSk7DtZyiINGOoqowEtOH+x8DeYLrp4gaNcajY@nongnu.org
X-Gm-Message-State: AOJu0YxkF0pIxhkTBuq7HYkYrIDywzstYLT0RcZwyHM2fLYzxvFxK2CY
 /CYA5lg/Lk3OENX/W6EegZqNrlCPk5DCnE9sCWiRtTLe8zRshqV7heQ/2eEbAlBF6iIZnN9cWZz
 swN8c/FNPUdBkjTDPEXNnRhSL1YJsdbB8yRhqFvqnkq+S4tuHMC1VElzc
X-Gm-Gg: AeBDietAHOHraYiVlW3VcVzEtWRjRhY/0TpYSShlH1Zty2tPhHPOKWzRiogjZFabTBv
 zNfd9VAGEulJp2Xy6WhtDuyTTgSwu7vpu1X213U9XCfBX/SDif33imMumnJzBkUG+xZFNZ6DCSQ
 T4anbJmyXtY3nIu0X2ofH4QopzQ+YjYPSPyOuetSMEntBDX6g3Z2yK1ycJmWyqfNCfUsKWPMYXk
 FMPICy7yiMGFTeSpDjCGKHyy+rTi49v1lRCpdd3WuAr7FSHAI3paTUF6CbX98+pqa1ovPwd8Oac
 JllUAxUa3Bn+WuaGYxWrzfZQSVV7NOzvJGvWsYDAI2ajhxxm2urCfjxqmzmEeJUZNl1x/vHHwZJ
 oZyTXitxagoCfTryVR2WXEBFABwh4K+XSMN3so5v008b1v2Zqkly3GitmizUeuMTVhwaVTTwCAF
 tgFb4eXw==
X-Received: by 2002:a05:600c:1d0a:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-48a77b2051fmr57560535e9.27.1777386809547; 
 Tue, 28 Apr 2026 07:33:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0a:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-48a77b2051fmr57559755e9.27.1777386808925; 
 Tue, 28 Apr 2026 07:33:28 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it.
 [87.16.204.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77b289a0sm52021815e9.12.2026.04.28.07.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:33:28 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com, 
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, 
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <afDClLiylMgvPiUn@sgarzare-redhat>
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
 <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 27, 2026 at 03:48:44PM -0700, Jorge Moreira wrote:
>On Mon, Apr 27, 2026 at 3:45 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
>> > On Wed, Apr 22, 2026 at 1:32 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wrote:
>> > > >
>> > > > On Tue, Apr 21, 2026 at 2:12 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > > > >
>> > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
>> > > > > > While starting the vrings on SET_VRING_KICK could solve the state
>> > > > > > machine issue, it still won't notify the back-end that buffers are
>> > > > > > ready (the driver won't do this). Non-polling back-ends depend on this
>> > > > > > kick, especially for queues where data flows only from the driver to
>> > > > > > the back-end. Most implementations likely attempt to read from the
>> > > > > > queue only after receiving the kick.
>> > > > >
>> > > > > This is an interesting question to clarify in the spec.
>> > >
>> > > Yep, which is in part related to what I wrote in the other reply:
>> > > "I think the main issue to clarify is what the device should do
>> > > when the vrings are configured, but the driver has already been
>> > > initialized (which is usually the case after migration)."
>> > >
>> > > > >
>> > > > > Stefan
>> > > >
>> > > > This is the question that interests me most, to be honest. I'd rather
>> > > > have the discussion about when to activate the vrings in a different
>> > > > thread and keep this one focused on whether the front-end should send
>> > > > the kick or if the back-end is expected to check if there are "new"
>> > > > buffers in the vring after restore.
>> > > >
>> > >
>> > > IMO we don't need anything from the VMM. When the device receives
>> > > SET_VRING_KICK, it can check if the vring already contains buffers
>> > > (and this is the part we might need to clarify) and wake-up the other
>> > > threads (or always wake-ups them, as crosvm does IIUC, and let them
>> > > perform this check).
>> > > After sending the SET_VRING_KICK message to the device, the VMM has
>> > > the exact same knowledge of the vring state as the device, therefore,
>> > > it's still unclear to me why we need to inject that kick.
>> > >
>> > > Stefano
>> > >
>> >
>> > Is it possible to activate a vring after it has been deactivated with
>> > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
>> > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
>> > reactivate it?
>>
>> Hi Jorge and Stefano,
>> Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs when
>> a VM is paused and then resumed.
>>
>> You can stress test this by driving I/O using iperf (virtio-net) or fio
>> (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
>> QEMU's monitor.
>>
>> Here is QEMU's code for starting (including re-starting) rings:
>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?ref_type=heads#L1341
>>
>> QEMU does not inject a kick. The back-end must check the rings itself.
>>
>> I'm not sure that all vhost-user back-ends actually check the rings. I
>> think back-ends should do it, but we should also update the spec with an
>> front-end implementation note recommending injecting a kick after
>> VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility

Okay, but since, as we've seen, no frontend currently implements this, 
we need to make it clear that a backend shouldn't necessarily expect the 
kick injected from every frontend, but should support it in some way 
since some of them can inject it.

IMHO especially new backend implementations shouldn't rely on the kick 
injection.

So, to summarize:
- the frontend should also send a kick to restart the queues
- the backend should restart the queues after VHOST_USER_SET_VRING_KICK, 
   but it might also receive a kick

>> with implementations that follow the current spec wording. And at the
>> same time I think the spec should also be changed to say that
>> VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check the
>> vring upon processing the message.

Yep, I think we are aligned.

>>
>> That seems like it would clean up the issues without introducing
>> compatibility issues or making existing implementations non-compliant
>> with the updated spec.
>>
>> What do you think?

LGTM!

>
>Sounds good to me
>

@Jorge do you want to propose this change?

Thanks,
Stefano


