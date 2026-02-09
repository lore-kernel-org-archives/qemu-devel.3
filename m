Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAE9E78D45
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMnD-0004I4-Kb; Mon, 09 Feb 2026 03:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vpMn8-0004Hu-My
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vpMn7-0008S1-5J
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770626324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sIHNyqwtsKHVbDreRiYBrkE3Ym9tQPjQoiFbhsRlGPk=;
 b=al18nm+ttiFwIxbTUyGrwKbR93Tk8alz480eosSUt/6zzqkFuEmRNicLehrrd8q6d5edEI
 37dx+YZPRTasYtwzZ0MYPAcizplI7py0u+nCaPS8DD81erSAb69qYpVFFDhQe84Q7fayuz
 ERYURC0Qo9JB/mlpkVt/vdzIzqvE/Hg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-vk40l2AtM0qSTrEAmBiY5g-1; Mon, 09 Feb 2026 03:38:42 -0500
X-MC-Unique: vk40l2AtM0qSTrEAmBiY5g-1
X-Mimecast-MFC-AGG-ID: vk40l2AtM0qSTrEAmBiY5g_1770626322
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-649aebcce1dso5582633d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 00:38:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770626322; cv=none;
 d=google.com; s=arc-20240605;
 b=dDfSbaWczOcVlYRpcUR1lMAa3JuQSrFm9XddfS0sWnDZNqSsK/t5c28iYPrzwlvOWy
 FfDD8kiIOJF1QuXFQ8W9ybIZVTAukDCuze/8L+n/DySk6UNG+gjaqIU0JDAx7cZ5epcQ
 UHcln8HRYgpuwCMl7YjHz/3uhG5VV4g17y5JYQWZubG88jac1xFcgkqI2GPdbkma+80i
 FkBtJK43jGYl7RYu5/ezCS9++00tfd/99U070/FENrds+iqWpwb/srds81kS4NLGbfIr
 ucC9+ktOuTiVVGelikuFYwqPfwjVK7q8jZN8QOiAiMnhtkDHXuFQl8bxOnM8wYURK0L7
 YGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sIHNyqwtsKHVbDreRiYBrkE3Ym9tQPjQoiFbhsRlGPk=;
 fh=iyEw+kLM9yg7G7ESba8bxVN13lJsr3yO06Lt+SyW2NY=;
 b=kk9HWZDoOu5XNZbMJJ/FP57/jrVZMBikn0w9KyoJLrTrxIIyIoV70mQSrPSYsEF8Qy
 cOnDnpgHG5wLfAthrYBG5dKd1uqifOiK+wHQmQop3n2A1d6UJBPSF21978oUmvnYIfr0
 YWY4pCN76vPBHuEDCD4uU5ZMgKm0OhBgD6XO4Hu5Cp6CDgve4IMHbhVovQoDxwxmKhj1
 ma8FiUN50WHfKeE76+LBu61KiVnWQnlA2p43qE7ae9tXW14GJYMjux0WZ5caPG0AM0pv
 fcxZDNvYXOFRu66MEbsC794fBbLHKN4aaPWZ6M4Fl3JLcL99HZJOp68SweiYXVe5RoGn
 Q0hQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770626322; x=1771231122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIHNyqwtsKHVbDreRiYBrkE3Ym9tQPjQoiFbhsRlGPk=;
 b=GF0mrex9ut9S629WosX+OPpMeO+0L7mJI+X8jPESPzGjAd9zJ3KNeA2lypBYDGJoDW
 wTSeS/ZoHI6mGfs2BOQpJD3dIZJhG3YB4a74TdYrwr4Jk/TJ+tBTwCgeeGmg0rCRQGGn
 Pr9KVzKmsqF97cMDmU7me31EstuJW4H0+0BWbm1+8DZw/u2dQLu4yPovdvPA1cwsWZ1u
 rMQageRlbGGVPN7oS3NRa11p4NrmdkA+Tchu0A+hEGllwQfro8SQqxctXTwlc1ND1Hmb
 LD9/1CfJzLlXwTDMkYNXT1Sdhmb83CyVQO78lREwuZfj9/gR4YeeH+85XjcKNAsVFMF+
 4Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770626322; x=1771231122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sIHNyqwtsKHVbDreRiYBrkE3Ym9tQPjQoiFbhsRlGPk=;
 b=ulK6q8Nxf2XD05hnII95HNDUBL47J5TTE0qBl+vx78chGyk7cEZBq81o9pPURWpFft
 8LwizhJAZxDqZVU9z1/ZBk3dm8jPpejCdSaWoFcMSS5qU7dO2hBEUCttTpNgPxz3bjSB
 nyUOVCCBD9yt760qPpuC1sIUxsOuCYw9+2WqDOwRvcLsFd42ECDzISeyK9YUp2k+VjTD
 z38OXDDOwpkH1Djiic0SF59zSosCoEm112SQj0/yX50g16UJd6zoj7fQR9tIu6+m+ORl
 WmPCudX/Qi7EbqpVAcKSo5uJxIr2LfYzyXt1tPi5oJc7knIgCUKpSavFJCZ3U9+6j2HR
 RQPg==
X-Gm-Message-State: AOJu0Yy596jp4wjmznDGXgILNkojw/qgqz++532CRdynESJdoIsiOLLl
 G7djrvNRFRg7YVEBQjjJgSLZtC/KNvbiojRvp5PxsCXkfA5EJJ3QPwLWPHN6XlmOX+1m06Akt6Y
 uom/jGfEx1Svy2tU/7bsNlK9IOI2FjxWoTgiHvNOzjk0Nqa3cixiyT+ag1liBRiRndrKVehJABq
 A/CY6MRTDE+G3ufFVtM/rbt0X87LFNRLE=
X-Gm-Gg: AZuq6aJyt0FVStSw+ho6oUPOsNG4QXc+VqnWLQVN3WXcMzhOaQpavdUIRef0Nk3o2Pm
 JG1mBoCo4p7swO01ui7afhwEeSWSncTWCRh6o1kBIosoRq1URZYnoxBRjj4KnrBlCLGDOMdy/0L
 brB8LUDNC+cDh1kekbKpNJZP3JXGVPBOA3VhC1/Ich7l9YtismMHVa1VpKR3+Muw==
X-Received: by 2002:a53:ac9b:0:b0:64a:db39:f002 with SMTP id
 956f58d0204a3-64adb39f635mr4819411d50.0.1770626322057; 
 Mon, 09 Feb 2026 00:38:42 -0800 (PST)
X-Received: by 2002:a53:ac9b:0:b0:64a:db39:f002 with SMTP id
 956f58d0204a3-64adb39f635mr4819397d50.0.1770626321754; Mon, 09 Feb 2026
 00:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20260204093758.1250167-1-aesteve@redhat.com>
 <20260204093758.1250167-2-aesteve@redhat.com>
 <87cy2jl2js.fsf@alyssa.is>
In-Reply-To: <87cy2jl2js.fsf@alyssa.is>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 9 Feb 2026 09:38:31 +0100
X-Gm-Features: AZwV_QhSuY-lDndZcnG60Tn7dQ7wF-hEtH_wuBrOZwI0tGoJ9nqTlLGSr9LvoDI
Message-ID: <CADSE00JMCcPZuwcLVPDLPZqLBpTrrpKtSNcfsW_1Ad_BT=u5Ng@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, slp@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 manos.pitsidianakis@linaro.org, stevensd@chromium.org, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, stefanha@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, mst@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 7, 2026 at 8:05=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Albert Esteve <aesteve@redhat.com> writes:
>
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> > +  Upon receiving the message, the front-end will mmap the given fd int=
o the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``.
> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> > +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> > +  must respond with zero when operation is successfully completed,
> > +  or non-zero otherwise.
> > +
> > +  Mapping over an already existing map is not allowed and requests sha=
ll fail.
> > +  Therefore, the memory range in the request must correspond with a va=
lid,
> > +  free region of the VIRTIO Shared Memory Region. Also, note that mapp=
ings
> > +  consume resources and that the request can fail when there are no re=
sources
> > +  available. Lastly, mappings are automatically unmapped by the front-=
end
> > +  across device reset operation.
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds so
> > +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) =
in the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that =
the
> > +  given range shall correspond to the entirety of a valid mapped regio=
n.
> > +  A reply is generated indicating whether unmapping succeeded.
>
> Shouldn't this be phrased like VHOST_USER_BACKEND_SHMEM_MAP above,
> since as we've established replies are only generated if negotiated?

Right, it would be more clear and consistent. The code includes the
check so it is just missing clarification here in specs. I will change
it.

Since the patch missed the recent PULL due to build issues, I will
wait a few days to give time for the community to review and send a
new version with this fixed.

>
>   If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-end
>   sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond wit=
h
>   zero when operation is successfully completed, or non-zero otherwise.


