Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33408C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadwm-0004d1-6m; Wed, 22 Jan 2025 11:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tadwk-0004cj-RM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tadwj-0005gp-8s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737564675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KywGUI1I2BtXap8lINR/HCH5ElRlqWGINccpPhIVeC8=;
 b=h9i3/3pY2Z+B1S15tfOX6V7DD0nWLfviOhAMj3EQBRrmLS5qEE7epyNtKAdO9FfstjH4D7
 TZcDxpvRQ9M7Aj7Ej9BX+5Pr50GIjnSauJeSAnR5WLkU9uiAAJJHq0IPfu6mGje/grsYxO
 yL/6bryRgXMyM4c28zbOUtIC7xNcezw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-0p64IeybMkO_jC3C5tLP6Q-1; Wed, 22 Jan 2025 11:51:14 -0500
X-MC-Unique: 0p64IeybMkO_jC3C5tLP6Q-1
X-Mimecast-MFC-AGG-ID: 0p64IeybMkO_jC3C5tLP6Q
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa6a87f324cso717958466b.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564673; x=1738169473;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KywGUI1I2BtXap8lINR/HCH5ElRlqWGINccpPhIVeC8=;
 b=XbACAtu4F90dr075M8GrNDU5X/mOkIG7FueQEDFaU0mqq/mlgqiHGTYxQhXtXdjCN2
 nydafL+Fv5USsAdNp2HAoOI6Q2T8tU8QUys/5+/xrUrQMHaodjsYdoNmGNE50K0gox+6
 Qcgl2RlSrcf1oggM/O35233ICHzU9h7h3sho8Gxt2Ew39oYfRLUXGeTPOMerc+5ajIEz
 O9JEj1F5kVHS4zJQ3Ip5HTdJozcrD5TCWbrgeZqJU9BGq30oXfMZo4rOwVZerNgw+D1E
 Ne6rm5DLZlvOuXWTKy862fZDBgDVndN79uWSU8ls7fyjhe7T21GU9PsOA4WEOXgdQB4/
 fVew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyj/YzvPMLvU5V6Q5ZRj+f53yzEuBySe+VdvOcnX/ZmV5b+AGc0dIwC27Gn+X4NDYmH+dib8DDQO/t@nongnu.org
X-Gm-Message-State: AOJu0YxK0PPmU4oXz7AjnBxtw/c1OuHXT0ibkjmMS5egPX4cYCXIPmQf
 QroF1IcsgmfnD2qKjOMUMWTOWXqfcyRxgCXlRgAK3xf8SJL9HQ8wzv8k/SQvjsc4NZseXdM0Wa7
 yFGtQhceIT+4ALcjgoyOxSFmr1WUEi1fx6PlvVp/q4HGhJ/D/fHZZ
X-Gm-Gg: ASbGncs+05A28q8TyNQcyFaLXCx5r8ivY2r8VvSJ8mqs/5WrSsfe0dSOQiDe81iqDER
 ZMrX1QmazI4masy2lje498v0NpEkQkpvdQrNWNpdbN9kRFlU/lPxetH15nVP+v5ueCfWu0fXxXM
 5ZeKoJ7JCCz/uEtFWwz2TPR5L1r2nYhrkv+UmmSXdSDut9rEl1ihwAkpvs0k5gJxEWOy+CvSPKb
 DnFqGZS9vNRUokYqjMwFUe0tN0QcnxsInIn7GDCEpfFBv7Xrv0yGttbDTZ6SVw7AlL8HnPSubBh
 HgPA1xCO/4cUFpSCcQVGW/ap7Kf7S1ZxdtBRGVSUUiSZuQ==
X-Received: by 2002:a17:906:c001:b0:ab3:9923:ef46 with SMTP id
 a640c23a62f3a-ab39923f699mr1833855066b.11.1737564672675; 
 Wed, 22 Jan 2025 08:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdknIzUN3lh96dfIlPVm5BgFBPviv8ekEtQisaXBKAi11AcVnl20tWjzlCe8t4RqvPQjbCVg==
X-Received: by 2002:a17:906:c001:b0:ab3:9923:ef46 with SMTP id
 a640c23a62f3a-ab39923f699mr1833851366b.11.1737564672024; 
 Wed, 22 Jan 2025 08:51:12 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it.
 [82.53.134.100]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1c26sm947586366b.60.2025.01.22.08.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:51:11 -0800 (PST)
Date: Wed, 22 Jan 2025 17:51:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 22, 2025 at 05:41:15PM +0100, Laurent Vivier wrote:
>On 22/01/2025 17:20, Stefano Garzarella wrote:
>>On Wed, Jan 22, 2025 at 08:59:22AM -0500, Michael S. Tsirkin wrote:
>>>On Wed, Jan 22, 2025 at 02:42:14PM +0100, Stefano Garzarella wrote:
>>>>On Tue, Jan 21, 2025 at 11:00:29AM +0100, Laurent Vivier wrote:
>>>>> In vhost_user_receive() if vhost_net_notify_migration_done() reports
>>>>> an error we display on the console:
>>>>>
>>>>>  Vhost user backend fails to broadcast fake RARP
>>>>>
>>>>> This message can be useful if there is a problem to execute
>>>>> VHOST_USER_SEND_RARP but it is useless if the backend doesn't
>>>>> support VHOST_USER_PROTOCOL_F_RARP.
>>>>>
>>>>> Don't report the error if vhost_net_notify_migration_done()
>>>>> returns -ENOTSUP (from vhost_user_migration_done())
>>>>>
>>>>> Update vhost_net-stub.c to return -ENOTSUP too.
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>> ---
>>>>> hw/net/vhost_net-stub.c | 2 +-
>>>>> net/vhost-user.c        | 2 +-
>>>>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>>>>> index 72df6d757e4d..875cd6c2b9c8 100644
>>>>> --- a/hw/net/vhost_net-stub.c
>>>>> +++ b/hw/net/vhost_net-stub.c
>>>>> @@ -93,7 +93,7 @@ void vhost_net_config_mask(VHostNetState 
>>>>*net, VirtIODevice *dev, bool mask)
>>>>>
>>>>> int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
>>>>> {
>>>>> -    return -1;
>>>>> +    return -ENOTSUP;
>>>>> }
>>>>>
>>>>> VHostNetState *get_vhost_net(NetClientState *nc)
>>>>> diff --git a/net/vhost-user.c b/net/vhost-user.c
>>>>> index 12555518e838..636fff8a84a2 100644
>>>>> --- a/net/vhost-user.c
>>>>> +++ b/net/vhost-user.c
>>>>> @@ -146,7 +146,7 @@ static ssize_t 
>>>>vhost_user_receive(NetClientState *nc, const uint8_t *buf,
>>>>>
>>>>>         r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
>>>>>
>>>>> -        if ((r != 0) && (display_rarp_failure)) {
>>>>> +        if ((r != 0) && (r != -ENOTSUP) && (display_rarp_failure)) {
>>>>>             fprintf(stderr,
>>>>>                     "Vhost user backend fails to broadcast fake RARP\n");
>>>>>             fflush(stderr);
>>>>> --
>>>>> 2.47.1
>>>>>
>>>>
>>>>IIUC the message was there since the introduction about 10 years ago
>>>>from commit 3e866365e1 ("vhost user: add rarp sending after live
>>>>migration for legacy guest"). IIUC -ENOTSUP is returned when both F_RARP
>>>>and F_GUEST_ANNOUNCE are not negotiated.
>>>>
>>>>That said, I honestly don't know what F_RARP or F_GUEST_ANNOUNCE is for,
>>>
>>>rarp is to have destination host broadcast a message with VM address
>>>to update the network. Guest announce is when it will instead
>>>ask the guest to do this.
>>
>>Okay, thanks for explaining to me.
>>So if both features are not negotiated, no one is going to broadcast
>>the message, right?
>>
>>Could that be a valid reason to print an error message in QEMU?
>>
>>To me it might be reasonable because the user might experience some
>>network problems, but I'm not a network guy :-)
>
>I'm working on adding vhost-user to passt[1], and in this case we 
>don't need to broadcast any message.

Okay, so please can you add that to the commit description and also
explaining why you don't need that?

>
>So I don't implement VHOST_USER_SEND_RARP and I don't want the error 
>message to spoil my console.

Fair enough, but at that point, if it's valid to have both feature not
negotiated, IMHO is better to return 0 in vhost_user_migration_done().
Maybe adding also a comment to explain that in your scenario you don't
need to do nothing (like if guest supports GUEST_ANNOUNCE).

>
>-ENOTSUP is an error message for developer not for user.

I was referring to the "Vhost user backend fails to broadcast fake RARP"
error message we are skipping here.

Thanks,
Stefano


