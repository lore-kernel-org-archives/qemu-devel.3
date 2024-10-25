Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE545D0C5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4FwL-0003v1-IJ; Fri, 25 Oct 2024 04:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t4FwJ-0003uL-2r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t4FwH-00056m-Bi
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729845895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfJVmL3lLksXD4E1ckSgunbi5oYZu/7oMqwZ1czZnzs=;
 b=AZYRmyIDQGKdHaOAJMNNR8h8h5Ebdm3r/kL8Fw3f011JHWjhJbBzblz1t38Wp2ME0LGsm5
 vDhvK+42a96hePADMAQMiV3ulZKjrUuj1dLfeN/DRP/Q6pG62SukWyL357cb613Y5MnrE8
 iVF/j1vnvirfC8lV+GvLP6voFNL+TE4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-pqyuXYzrO1GDigJq6IE8Ew-1; Fri, 25 Oct 2024 04:44:54 -0400
X-MC-Unique: pqyuXYzrO1GDigJq6IE8Ew-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7181285c746so1991187a34.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 01:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729845893; x=1730450693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfJVmL3lLksXD4E1ckSgunbi5oYZu/7oMqwZ1czZnzs=;
 b=xA/iM2xI4ZSPb/Bbhpd3d8h2rrWWce/ISx7UBW9uINyELcLAj9JCA7R148+vGR4z/K
 iXCBlfJokSQobKbla2K2g2P5YhwoGKwU02V2CH5HWq5LHwRMP+hF3tYbcdPQxiyYtAyU
 DPkTAbw4xpDkZsBeUrJf19BlMbvaA735e2EuvLDBptrK51P0Aw2IdwdvawdAs1efOQ32
 3DodbvrZu9Znxf9z4tjOw9jmAQhxCu4m4YSagrvDwzXHjwoJh1YRapeitsjhdSCg9JMy
 riLsxNPfLAMWA6TNql7exp7otceAKtTW1T2syrfvykKYfPwJJV0SoXDj3klM8Psjnkc8
 X1ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB/6hJ1uysVcsxv/dhZXbXNuf/To8Ngg3FKdHHo8wVbvdt55J2JzPQpDWkkMYiTq2OUWAVNEGHMc76@nongnu.org
X-Gm-Message-State: AOJu0YxAjUZeGR19MrcFeUh5imLh2skBNO5V/VVRZeIZWFrQFzNzNzwX
 iO6Tl7SbCD12Xl0gQVPo5yE8Njs1cdpPqRzbKfIQQ9OJxUaKZ5PTc3YMMN39pCcjYkl0LCloPsp
 JOJzYSga93JZsPJwzQyNTvkn01hGUepLsdMwWYc1vS03PBCkje0UJh0z83q61Xh43767muopgoN
 N4YVdSwThR0Oy5pKqxBqMJDpxnUeQ=
X-Received: by 2002:a05:6830:3881:b0:718:162e:7712 with SMTP id
 46e09a7af769-7184b2c09c3mr10935750a34.14.1729845893454; 
 Fri, 25 Oct 2024 01:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH05ISFYixTlQNtuXWu2AU44Jn53+4pVWuQnfLwvVBNu4fB8XhLgRXFW0juIb0Oj0hmOQQCi6ynhVTlEUVjR4U=
X-Received: by 2002:a05:6830:3881:b0:718:162e:7712 with SMTP id
 46e09a7af769-7184b2c09c3mr10935728a34.14.1729845893108; Fri, 25 Oct 2024
 01:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241022-load-v1-1-99df0bff7939@daynix.com>
 <20241023040059-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241023040059-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:44:42 +0800
Message-ID: <CACGkMEtKBdwkd9LDaMAga0YoJgBj5Pj_rL7ii8C3_SCC3XnPPA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues before loading them
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 23, 2024 at 4:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 22, 2024 at 03:49:01PM +0900, Akihiko Odaki wrote:
> > Call virtio_net_set_multiqueue() to add queues before loading their
> > states. Otherwise the loaded queues will not have handlers and elements
> > in them will not be processed.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizin=
g")
> > Reported-by: Laurent Vivier <lvivier@redhat.com>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Jason, your queue?
>

Yes, queued.

Thanks


