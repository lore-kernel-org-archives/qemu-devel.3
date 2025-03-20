Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630EDC36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 01:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv4Fo-0006HI-Mj; Wed, 19 Mar 2025 20:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tv4Fn-0006HA-LI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 20:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tv4Fk-0006Mj-En
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 20:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742432357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZUgLpT3WdFY8+/nEGE8chzeWaHVl1yfnrrSavcStZ4=;
 b=IB3dB655x980TMGj1svwvqMIHKREzOhslMPHXE4/WIQaoBJntxnMM+DKlzUAOEwbumck2P
 udxT3BOyLE9JO8TMdtq1P42c55fRmMK9G7sDUuJ9XSFHoWXyXnApFasA7vNaxUrdmsi8Z2
 lQKUbqZ0o2DEsl+gB9ubxmDRN7PdSmM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-xp8o_jG-M-yhfi7tKkCc0g-1; Wed, 19 Mar 2025 20:59:12 -0400
X-MC-Unique: xp8o_jG-M-yhfi7tKkCc0g-1
X-Mimecast-MFC-AGG-ID: xp8o_jG-M-yhfi7tKkCc0g_1742432351
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c90so421725a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 17:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742432351; x=1743037151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZUgLpT3WdFY8+/nEGE8chzeWaHVl1yfnrrSavcStZ4=;
 b=Q5RPpOUh8bqYt/D5T6loJiYe6kFEWNaDQ8MeXGiAu9OqkvRwlZ3dk6L+evypt9TVUP
 3c+x+7jJMMpZu23984MOLG+9riSd3O4jfiV9WttvoZARfrV3S5pMyYqsJ75jrwXFyFME
 OTRPFW4JaYFFbkrFwBIZjwL+MD9wm5Q63y2yKiMm3Le/0oxwTL2fMnn05125qiAiFknT
 7Gl5B/3+/00EmKEWX0LFfuelGSxxdtXve5WPFS6xDLtYQ5VA4bLNPj9yWB8ZaAElDo9C
 64PLDwBceyZKRFIXH+34xz39i26RdiJEfKOaC3T1Iqodga5odbczEEGBk7SdP6Gct5Gf
 2eYQ==
X-Gm-Message-State: AOJu0YwxiphHL1tlSwrPKTaNAWTeS5y49O86tTI3TBWNBhfK+XN20est
 IkjQm9Yl/was5TDwahCyOZbAWxFol1rVYUzIvRw4/CTP/+ALdHY6ElGkC/vtivzGzPDy3jCjw5l
 degVVD/Af43a8g40o1DdFt0pDUa9Kka6vNlklDES1emhjuESwa8cUmKG0jwc9cxsJmgD9TKGest
 qPtixQeSRRX/XopbZGTRRHR1sxAi0=
X-Gm-Gg: ASbGncu44Z+6HO6ifrJlD9OFqeNORh/0msPgnsFU0n4fKDR6/pZvBG0Wedl1UbIMW2I
 K5NWRNrjQeYZdnAGHtpQbcZv/xE/2AteEcFyz9V3UdAbCPnnCJtJ8p1MSrGa9b9ExSMv6N0h6TA
 ==
X-Received: by 2002:a17:90b:54c6:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-301bde4c26cmr6314431a91.3.1742432351357; 
 Wed, 19 Mar 2025 17:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkaLS5B+0koy+GYT2tzPFLEff6FKlEX9ehWftripgjaP2nmmHx+L9GbSJVqiUkcZLMqVe5AfPvCrctkLubbZg=
X-Received: by 2002:a17:90b:54c6:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-301bde4c26cmr6314410a91.3.1742432350969; Wed, 19 Mar 2025
 17:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
In-Reply-To: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Mar 2025 08:58:59 +0800
X-Gm-Features: AQ5f1JrADWh-6hnIzPEH7H6e2c-uuUZ8Ew4nGKPAmq-inn2-Oes4TocwzPvAgas
Message-ID: <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>, 
 eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Adding Cindy and Eugenio

On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> I=E2=80=99m observing a problem while testing VDPA with Nvidia ConnectX-6=
 (mlx5)
> on s390.
>
> Upon start, virtio_net_device_realize() tries to set a new MAC address
> by VHOST_VDPA_SET_CONFIG which doesn=E2=80=99t do anything.
>
> Later, the VM gets started and learns about the old address from
> virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG
> returns, unless it's "6 zero bytes", in which case it instead returns
> the desired new address (and the problem is avoided).
>
> Then QEMU again tries to set the new address from vhost_net_start(), now
> by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC,
> VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is
> successfully programmed into the NIC, but the VM doesn't know about it.

Have you enabled shadow virtqueue? If yes, does it work if you don't do tha=
t?

>
> As the result, the VM now sends packets with a source address on which
> the NIC doesn=E2=80=99t listen.
>
> Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
> =E2=80=9Cdeprecated=E2=80=9D, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must be=
 the right
> method, but it=E2=80=99s apparently called too late.

VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
necessarily there.
VIRTIO_NET_CTRL_MAC_ADDR_SET requires the shadow virtqueue as well as
the CTRL_MAC_ADDR support.

Neither of them seems robust.

> Or maybe
> virtio_net_get_config() needs to always return the desired new address
> and not the old one from VHOST_VDPA_GET_CONFIG?
>
> I=E2=80=99m looking for an opinion/direction from someone who knows this =
code.
>
> As it is, the only VDPA scenario that's working for me is:
> 1) Avoid specifying the MAC address in the "vdpa dev add" command (which
> will create the "6 zero bytes" condition on the first launch).
> 2) Keep using the same MAC address for every subsequent VM launch on the
> same NIC "virtual function" (so that the old and new addresses are the
> same).

This is the way we currently use it. Is there any limitation of this?

Thanks

>


