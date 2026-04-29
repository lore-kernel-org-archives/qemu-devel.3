Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833EDFF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5sL-0005Y6-Ru; Wed, 29 Apr 2026 10:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wI5s9-0005WZ-Po
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wI5s6-0003Qo-8p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777472797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQGapfFhm+VascVMXlY9hzfYSzdFZRqW36R/ebjTCYw=;
 b=VTlV0QTwx6TI0HOZllh7mf52zjjCv9xpZdPcFTAFTXr1uIFaNZSkZ0jtu12lJR0eAzhT1c
 +HtWwsgkb5iotgjRmRKnaJh4RX0G0BUWkdAubkVLOg9jEwCoJJqbnqlVhryDClVhvqcQxW
 99WezaGrgnwIgYqYxyE3P1sg+GRTxhE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-XfA8HDZMN1uKIpijmfBpzw-1; Wed, 29 Apr 2026 10:26:35 -0400
X-MC-Unique: XfA8HDZMN1uKIpijmfBpzw-1
X-Mimecast-MFC-AGG-ID: XfA8HDZMN1uKIpijmfBpzw_1777472794
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so96368145e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777472794; x=1778077594; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aQGapfFhm+VascVMXlY9hzfYSzdFZRqW36R/ebjTCYw=;
 b=JK4QzJBoj/SHZRUFdrQzIbaj4jG+/ga/cZzOiKKesTlwEqI170RWQTruyCQuxdnuoQ
 hGzy9DnmNwfK7duwYYijXNQ3qWYeV3gVti+txuTIMnGz5aurH8cn0fud+He0Kb7MFuNZ
 DaUkWhZnSq1QV1MeRmyNv4CoiMjVBkQemKV8wR9UIol2Y807pOnebX1D54fxjrBJfHB0
 ah0aTSt0Xo3NUJq1uf95+diW8Rli2ljY0TTFVjmIS533T9FKgS2SYxuBoH7QfuBoKOuw
 pvKgn/ddZKuBkNpjmLNb3YCS5yOWV+gb4jj4emSHtL7k2/eAZxI5eg0QsKmEodahOJjI
 Z9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472794; x=1778077594;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQGapfFhm+VascVMXlY9hzfYSzdFZRqW36R/ebjTCYw=;
 b=g1P+pdfQi2+jdIfuOz14Vbp5TJwLogv+Q0FUz7UFVPjMqG9CoZB7l8bWEqDv2hfhq3
 BOW4Xau4xJxRwFsBSNN2RzeZfnQccDhuR0bwSE4mu5dTr7mQQb9OBvayIeHOJjMqtG+w
 aAHy8V97nO5jXXSNDCEbfqVyf4vqVv44X/DIZgAN8Ai3UxCwdSvSD7FDIsDzTBiJz8rP
 EWD0MUSCYFf83VG/M6tRWr6BrPK0TvNOotrHEpiqWq/IOL/lSZWK6lSj28FPCv2o0Ry8
 iV12M5ZjmngcBnyG5ZbmdzRtSC+WFGh4rVxNoM5av/QG3MyeziNOwYXNflzX/fF+2q0U
 T9pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ioIj1CfHwELFJri66HsW++U+fZnj7ATbp1iLW1CagSEhSdzPsdizAaQKwg6ruNlU4C5R9bIKm9K59@nongnu.org
X-Gm-Message-State: AOJu0YwE2ZsLSG5kSRQWcVsZNzinDtJZ+B+9FvMzEAyzWg64qs48GS7h
 ynckXCxpPQ+Dz0LiBnu824rZIz4TVG2XgIeJedgVPwFnRQsattysJ4y9DYEyb+GjHDPqcaNgJWl
 H0CdGxOt7J9VJpLoiEXkprlHxZF3StSYNbwR4I3W+fA1mui/dDgius5jc
X-Gm-Gg: AeBDiet43Mckp2G2zLQhFAxm8bNpEcmdgsTJsvh7k+8c+46GuD4FkjmCSBx9w0Eg27W
 loK9zCkTO6kF0fjr0IiBOHqAqQ5lQrE366lESCwK2foTyeeEgN2iYtvOEtOmIJrPC1WsM/7eu4X
 ItSaIALBD48BArHYdKnYQJQ1m1Nu64ZHk5WTds4e33S00nCoBD8Ue9Pk3zV6FkpIL3x5ISna/nB
 blEkNU5NZ2Sf/ChcGk4xwSV8m2DzyJgKKZWFYsobESqsP21gYhhrogCnnfXnyAz0TL1T/AlRUuW
 3eoZnG7Cl77ZupXE4ostgMgvpkt2FGTzx6rWPSvbCmz5W8f72VdfgYmMnUA+PuuiJFToe0Nx8Zm
 Zw7m6cB2kpG9irzUoHV1Omr8n/97e+j5ICTdXNew/3/6hjAFuwFrWgs5PHjRaHEGK2ORD+A5oJA
 ==
X-Received: by 2002:a05:600c:3b0f:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48a77b0a507mr122008055e9.15.1777472793591; 
 Wed, 29 Apr 2026 07:26:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0f:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48a77b0a507mr122007615e9.15.1777472793131; 
 Wed, 29 Apr 2026 07:26:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it.
 [87.11.6.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b92adefsm30673255e9.3.2026.04.29.07.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:26:32 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:26:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, hreitz@redhat.com, 
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, 
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <afITtroWfjUkyCaR@sgarzare-redhat>
References: <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
 <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
 <afDClLiylMgvPiUn@sgarzare-redhat>
 <CAJi--PMNCY26wqJiRw1xnAZVvOQUajcz534ocVhQx_Ox4u8GHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJi--PMNCY26wqJiRw1xnAZVvOQUajcz534ocVhQx_Ox4u8GHg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 28, 2026 at 10:19:30AM -0700, Jorge Moreira wrote:
>On Tue, Apr 28, 2026 at 7:33 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Mon, Apr 27, 2026 at 03:48:44PM -0700, Jorge Moreira wrote:
>> >On Mon, Apr 27, 2026 at 3:45 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> >>
>> >> On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
>> >> > On Wed, Apr 22, 2026 at 1:32 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> > >
>> >> > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wrote:
>> >> > > >
>> >> > > > On Tue, Apr 21, 2026 at 2:12 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> >> > > > >
>> >> > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
>> >> > > > > > While starting the vrings on SET_VRING_KICK could solve the state
>> >> > > > > > machine issue, it still won't notify the back-end that buffers are
>> >> > > > > > ready (the driver won't do this). Non-polling back-ends depend on this
>> >> > > > > > kick, especially for queues where data flows only from the driver to
>> >> > > > > > the back-end. Most implementations likely attempt to read from the
>> >> > > > > > queue only after receiving the kick.
>> >> > > > >
>> >> > > > > This is an interesting question to clarify in the spec.
>> >> > >
>> >> > > Yep, which is in part related to what I wrote in the other reply:
>> >> > > "I think the main issue to clarify is what the device should do
>> >> > > when the vrings are configured, but the driver has already been
>> >> > > initialized (which is usually the case after migration)."
>> >> > >
>> >> > > > >
>> >> > > > > Stefan
>> >> > > >
>> >> > > > This is the question that interests me most, to be honest. I'd rather
>> >> > > > have the discussion about when to activate the vrings in a different
>> >> > > > thread and keep this one focused on whether the front-end should send
>> >> > > > the kick or if the back-end is expected to check if there are "new"
>> >> > > > buffers in the vring after restore.
>> >> > > >
>> >> > >
>> >> > > IMO we don't need anything from the VMM. When the device receives
>> >> > > SET_VRING_KICK, it can check if the vring already contains buffers
>> >> > > (and this is the part we might need to clarify) and wake-up the other
>> >> > > threads (or always wake-ups them, as crosvm does IIUC, and let them
>> >> > > perform this check).
>> >> > > After sending the SET_VRING_KICK message to the device, the VMM has
>> >> > > the exact same knowledge of the vring state as the device, therefore,
>> >> > > it's still unclear to me why we need to inject that kick.
>> >> > >
>> >> > > Stefano
>> >> > >
>> >> >
>> >> > Is it possible to activate a vring after it has been deactivated with
>> >> > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
>> >> > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
>> >> > reactivate it?
>> >>
>> >> Hi Jorge and Stefano,
>> >> Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs when
>> >> a VM is paused and then resumed.
>> >>
>> >> You can stress test this by driving I/O using iperf (virtio-net) or fio
>> >> (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
>> >> QEMU's monitor.
>> >>
>> >> Here is QEMU's code for starting (including re-starting) rings:
>> >> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?ref_type=heads#L1341
>> >>
>> >> QEMU does not inject a kick. The back-end must check the rings itself.
>> >>
>> >> I'm not sure that all vhost-user back-ends actually check the rings. I
>> >> think back-ends should do it, but we should also update the spec with an
>> >> front-end implementation note recommending injecting a kick after
>> >> VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
>>
>> Okay, but since, as we've seen, no frontend currently implements this,
>> we need to make it clear that a backend shouldn't necessarily expect the
>> kick injected from every frontend, but should support it in some way
>> since some of them can inject it.
>>
>> IMHO especially new backend implementations shouldn't rely on the kick
>> injection.
>>
>> So, to summarize:
>> - the frontend should also send a kick to restart the queues
>> - the backend should restart the queues after VHOST_USER_SET_VRING_KICK,
>>    but it might also receive a kick
>>
>> >> with implementations that follow the current spec wording. And at the
>> >> same time I think the spec should also be changed to say that
>> >> VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check the
>> >> vring upon processing the message.
>>
>> Yep, I think we are aligned.
>>
>> >>
>> >> That seems like it would clean up the issues without introducing
>> >> compatibility issues or making existing implementations non-compliant
>> >> with the updated spec.
>> >>
>> >> What do you think?
>>
>> LGTM!
>>
>> >
>> >Sounds good to me
>> >
>>
>> @Jorge do you want to propose this change?
>
>You have a much better idea of where and how this should be written,
>it will save us a few rounds of review if one of you makes that
>change.

Okay, I can try, but next week.

Thanks,
Stefano


