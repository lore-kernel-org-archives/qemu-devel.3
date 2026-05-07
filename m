Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B0CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 10:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKvnQ-00088F-CV; Thu, 07 May 2026 06:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wKvnN-000885-5s
 for qemu-devel@nongnu.org; Thu, 07 May 2026 06:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wKvnK-0002cx-Uc
 for qemu-devel@nongnu.org; Thu, 07 May 2026 06:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778149045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eOfiND19oCXRf228MCKEHObBnrF0g4bRLJ34iD67W8=;
 b=Up/kd0f9jH7gzJkIVltZsk6Imswa2KQhKLciLjFU4xTLa1FuZ7phibDBhr8/IeQnT63Mte
 SIEfjvRue886+Rmokqc1O6uQNtqiQDnFolBE1vORmH05gMuvRoqYg095DUq151IesppKKa
 znto5OIag1H5cquuNziqdCytffrU8Bg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-5jXSMBEbMUuAUDNI4Or40g-1; Thu, 07 May 2026 06:17:23 -0400
X-MC-Unique: 5jXSMBEbMUuAUDNI4Or40g-1
X-Mimecast-MFC-AGG-ID: 5jXSMBEbMUuAUDNI4Or40g_1778149042
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a548b585cso3883295e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778149042; x=1778753842; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1eOfiND19oCXRf228MCKEHObBnrF0g4bRLJ34iD67W8=;
 b=cot2jiNNxav+n3wOUZ3l4Haa7VVYoYt2/3mzME2gK52+rfbKux/TOCYP9X+Oo9NqfB
 Vgytz9b0A2be/1VbrNTDSoK7n2HIfgbOXDKxt0esIrEli3NQg6rf78xXdj3/XoVa75lO
 YzUjLr9IVN80T0FI4bq/9MHAPOKw8xJZPHYwP3rWLzcu1uU1bMrxwWsafO2SUiWwAAx9
 YC02d/bFmuqaxgAtmXhVSne3o5mr8MQf/6TnaTv8jd3k7lZa32QscrIJgOeipmE1cdxr
 fpTL9uhkqnt9z9hr6meFC5de/+p06d5JH+frGcWV64WY9rvyVrPmaIdfBoV5bVs+ms6C
 NInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778149042; x=1778753842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eOfiND19oCXRf228MCKEHObBnrF0g4bRLJ34iD67W8=;
 b=U0oTS4za8jS6JsSQ/sv0Lke2g/3+GOFqOaI8+/XhZMVdyQi5xxXjmuZ1L4ROyEMXVk
 c3jQMej2dH737BISSoxWCBcd9960WeVKXwgvky8r/PUUvdZaH5KFMzmE7CYwHhBYrQT2
 +R6F+7YdnMirMj3IJ/XqKyyCkM6ca7qQlEqfCWA8X+r6f6P2kXTPd4RKesPZFZo0V4Wo
 OzAp1T7RdgJChtHSS+7ry96E2kvdmktEaXywW4mDH5OPR4g02OfqFQ27x1KJod9jt6p9
 Ut/sXe4tIPdn7QLJ4/48/BQT9fRHptcz59WDQW8Xt5fGMlU710+aei/nN0XoV5WOcHU4
 SFsw==
X-Gm-Message-State: AOJu0YxZg3WxQS+r3YdcaoVWPA/6zMHw3jy7O9aM/+Eyc2mjiOV15XRn
 TmWsSZppx18K6jZX3IqVPyvucfA58NZce2mzopG8SJGodYPqkBfpW8LURKcaPYlsScJcxnjqRie
 xIw7GSN4iMtt/fmP0w5vYOBIeOJ6GAcSrjKmSLQG3/DOXlmi2xnkIJwmD
X-Gm-Gg: AeBDieuceM5dPgXZ0RnEb+kP9+yHBoRdjdPoUqeqU4WR8u/McfDt12naDeW9szoPGhU
 gsolqh7Qomw881Lz6JdqJtvLQDpd3PRMiVbnXU/kk/exph2H7nECt2vsXulQ6i6zCeEuf4lZ1/n
 /IvsarSHqr2L/TNIF/amGALFo5+7Pm+MH2H+2bVoeFcrtUE7oS9oidjNVNx0Fr6IPQcHaRseOGR
 FToByOdEwqfgO/6asFINeB8GMU7jSGi7Gkdv2fevL995imKk5Pb86ZggQ9v2NpsdPXoB3UJOjE0
 QvFVWMXoNfrGl1oqT9Sd40Rg257E5334iYSBPckzGVJrp/rLA1PEz6iASZ/Gi7+8qSdLkvIzo+e
 1L1sN+lhYsjOuMl/dp7la5e/OzayNzQBLXPAQlq/7RGkjrT3OaSCnKuDmAUxBxh9HiIDsb5VAF7
 qVfZ76KS9y
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr118079485e9.11.1778149042330; 
 Thu, 07 May 2026 03:17:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr118078645e9.11.1778149041617; 
 Thu, 07 May 2026 03:17:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it.
 [87.11.6.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b6e9bsm195154175e9.10.2026.05.07.03.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 03:17:20 -0700 (PDT)
Date: Thu, 7 May 2026 12:17:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Jorge Moreira <jemoreira@google.com>
Subject: Re: [RFC] vhost-user.rst: clarify when rings are started
Message-ID: <afxjPwqPAfTz2vzs@sgarzare-redhat>
References: <20260429185504.221124-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260429185504.221124-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Wed, Apr 29, 2026 at 02:55:04PM -0400, Stefan Hajnoczi wrote:
>Jorge Moreira <jemoreira@google.com> pointed out that the ring state
>machine is underspecified. In the discussion that followed, we
>discovered that the spec says one thing and implementations do something
>else. This patch updates the spec to reflect how things are actually
>implemented across widely-used front-ends and back-ends including QEMU,
>crosvm, rust-vmm, and DPDK. Do this while taking care not to make any
>other existing implementations non-compliant by changing the sepc.
>
>The spec says rings are started when a kick is received but the
>implementations actually start rings when VHOST_USER_SET_VRING_KICK is
>received.
>
>Reconcile this as follows:
>- Clarify that a ring can be stopped and then started again. The
>  back-end must resume processing available requests when the ring is
>  restarted.
>- Update the spec to say rings are started when
>  VHOST_USER_SET_VRING_KICK is received.
>- Ensure compatibility by saying front-ends SHOULD inject a kick in case
>  the back-end strictly implemented the old spec.
>- Avoid future back-end dependencies on injected kicks by saying that
>  back-ends SHOULD NOT expect a kick to start rings.
>
>This way implementors have clarity on how things work while still
>allowing compatibility for existing implementations.
>
>Reported-by: Jorge Moreira <jemoreira@google.com>
>Cc: "Michael S . Tsirkin" <mst@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
>This is an RFC because I will update hw/virtio/vhost-user.c and
>libvhost-user once we've agreed on the spec wording.
>
> docs/interop/vhost-user.rst | 24 ++++++++++++++++++------
> 1 file changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index 137c9f3669..72d792930e 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -462,12 +462,24 @@ Rings have two independent states: started/stopped, and enabled/disabled.
> * started and enabled: The back-end must process the ring normally, i.e.
>   process all requests and execute them.
>
>-Each ring is initialized in a stopped and disabled state.  The back-end
>-must start a ring upon receiving a kick (that is, detecting that file
>-descriptor is readable) on the descriptor specified by
>-``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
>-``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
>-``VHOST_USER_GET_VRING_BASE``.
>+Each ring is initialized in a stopped and disabled state.  Rings are started
>+with ``VHOST_USER_SET_VRING_KICK`` and stopped with

In the VHOST_USER_SET_VRING_KICK description we say:

                                    Note that if the protocol feature
   ``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` has been negotiated
   this message isn't necessary as the ring is also started on the
   ``VHOST_USER_VRING_KICK`` message, it may however still be used to
   set an event file descriptor (which will be preferred over the
   message) or to enable polling.

I think we need to clarify a bit more what happens if 
VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS is negotiated. In that case, 
I don't think we can necessarily require the frontend to send 
VHOST_USER_SET_VRING_KICK to start the rings.

What about: Rings are started with ``VHOST_USER_SET_VRING_KICK`` (or 
``VHOST_USER_VRING_KICK`` if negotiated) ...

... A stopped ring enters the started state again with 
``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if 
negotiated) and the back-end resumes processing requests.


>+``VHOST_USER_GET_VRING_BASE``. A stopped ring enters the started state again
>+with ``VHOST_USER_SET_VRING_KICK`` and the back-end resumes processing
>+requests.
>+
>+Note that previous versions of this specification stated that rings start when
>+the back-end receives a kick (that is, detecting that file descriptor is
>+readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK`` or
>+receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated.
>+Widely-used front-ends and back-ends did not implement this behavior and it
>+complicates poll mode back-ends that do not rely on the kick file descriptor.
>+
>+For compatibility with back-ends that implemented the start on kick behavior,
>+front-ends SHOULD inject a kick after ``VHOST_USER_SET_VRING_KICK``.  This
>+ensures that the back-end processes any available requests in the ring.
>+Back-ends SHOULD NOT rely on receiving a kick after
>+``VHOST_USER_SET_VRING_KICK``.

The rest LGTM.

Thanks,
Stefano

>
> Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>
>-- 
>2.54.0
>


