Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70622D44D64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gL2-0004Z9-Fb; Wed, 06 Nov 2024 08:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8gKt-0004YB-RR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8gKq-0004E6-8n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730900674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CXaqAZwvApsDWLaa72JlzC5oGvwJVA5zQvF73LU0Ii8=;
 b=G2dA+R6VKaaPAdEf5MGkWbWQHquT+bH62IdrOxJsC5DtQbvhABQVw6Da9rnDEs4xiTaXfA
 8OermvQ951ndAAhuv6e4B69cwsWF8y3su6/flq1KqKAfTihSTFiZpZSq8m+EZswu+0nxmf
 u9iiWmwi8owIz9liGcuyaQtC42lYc9M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-1HWysyfoN5W-le6Q7MKD_g-1; Wed, 06 Nov 2024 08:44:31 -0500
X-MC-Unique: 1HWysyfoN5W-le6Q7MKD_g-1
X-Mimecast-MFC-AGG-ID: 1HWysyfoN5W-le6Q7MKD_g
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso5561565e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900670; x=1731505470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXaqAZwvApsDWLaa72JlzC5oGvwJVA5zQvF73LU0Ii8=;
 b=FqDNIBnD/NPbSwVrWhJ15oE5P/xJcpYrkqVS8McPGEvp846eqdBuTW0C8sqqamt624
 yKO45CU+G7YBCQvU9YQvFYgFwuHAKdbzH1ToHa45861IbxFIvi6CMzC0F3/Tz2l8SUWO
 z/6XDSIofoUKAeBL2hHLRq2zppjfDQjHkXVLTVdGhSIcVQ5jVOdUMlbG2LqkMQD7HHsg
 9gZM4cpWs+h9UGlxKsELUyuIjn0nLQmqBs7UuHybmni2SFvJehMaMlJx7oO6m/6eukbQ
 c9G1ZFAFOOsdOXP2Dob50IMcn2cLdJdrCBEPC7dTxRRFC011Jndxkacy8DNvVKQ+rYKs
 h7eA==
X-Gm-Message-State: AOJu0YxEWZroNClhycJI9sWLR3wI0n+91IcMZuuuwS6oDxtoDcUhTG8V
 R39bqbXBI2RCdsJO4rwJvXl9zuW3zYfbSpo9U0NekvGQvk88gnv658pntMQqEka7uGAWdqYiulQ
 jtH9NUXHcOwio51NjibQpVYiXOdb2jTa51HXCf1eh7rrKzKr0dTAG
X-Received: by 2002:a05:600c:4e94:b0:431:5226:1633 with SMTP id
 5b1f17b1804b1-432a9a8d278mr23799365e9.6.1730900669959; 
 Wed, 06 Nov 2024 05:44:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGPkwseivCgpsihYoSZVC1rFa96TSrZRjmqAahocokVA0FNj3trwHOXY6djAutd5BRk465zA==
X-Received: by 2002:a05:600c:4e94:b0:431:5226:1633 with SMTP id
 5b1f17b1804b1-432a9a8d278mr23798815e9.6.1730900668652; 
 Wed, 06 Nov 2024 05:44:28 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a1d8sm24052645e9.27.2024.11.06.05.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:44:26 -0800 (PST)
Date: Wed, 6 Nov 2024 14:44:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
Message-ID: <oulj7a7lh35ffh5qbm5idq4vtawhps4ixknauvfkjicjsvjhbr@rfr6ttpvfjwy>
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
 <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
 <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
 <ez2fb2yg7zha6ccdey47zxhaxcgwim7f6p4zzj4ucrgjnbavyk@mrnhs47uyx5e>
 <CAE8KmOy48HPqW4VLJmf+ofZq+K1nM3tza3Sp4nX6sAreV0bxOg@mail.gmail.com>
 <p4ryblk3o63lao45cplo2ws6l5thcmt52phue63benvwhjrdud@53ta327k6mhj>
 <CAE8KmOy+VM6o7F08vgkCs3HQK5_j8dW-wbLz-4tew6UqoSVRFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE8KmOy+VM6o7F08vgkCs3HQK5_j8dW-wbLz-4tew6UqoSVRFg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 06, 2024 at 06:04:59PM +0530, Prasad Pandit wrote:
>On Wed, 6 Nov 2024 at 17:31, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> For vhost_set_iotlb_callback() that is true because for now we go to
>> that label only if the callback is defined, but this is not the case for
>> hdev->vhost_ops->vhost_dev_start().
>>
>> Anyway if in the future we add a new step that need to go on that label
>> we may forgot to remember that, so since it's not a hot path, I'd add
>> both checks as we do in vhost_dev_stop().
>
>* Okay.
>
>> IIUC in vhost_dev_stop() we already call both of them with a 'false'
>> parameter, so that functions should be already prepared or am I missing
>> something?
>===
>static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>{
>    ...
>    if (started) {
>        return vhost_user_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                                          VIRTIO_CONFIG_S_DRIVER |
>                                          VIRTIO_CONFIG_S_DRIVER_OK);
>    } else {
>        return 0;
>    }
>}
>static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
>{
>    /* No-op as the receive channel is not dedicated to IOTLB messages. */
>}
>===
>
>* vhost_user_dev_start and vhost_user_set_iotlb_callback() don't seem
>to do much when called with 'false' parameter.

I think we should be agnostic here about what a specific backend does.
For example VHOST_BACKEND_TYPE_KERNEL doesn't even define that callback, 
but IMHO we have to call it anyway here, like we already do in 
vhost_dev_stop().

If we miss something in that callbacks, when they are called with 
`false`, then it's another problem that we need to fix regardless of 
this patch.

Thanks,
Stefano


