Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86FEC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJu4-0006JA-GH; Thu, 16 Jul 2026 07:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkJu2-0006J2-PY
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkJu0-00039b-K1
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784199915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmiRZOCGzK7zG5LqcJYzkc4+CuFH9PCYd5BVxba0Mks=;
 b=Ijy2fCcmRivt5rNolZ/q+ngwocoZulSfgCMNHEp4DWDvkN/Ce1a6BIcdH3BSgq5HRdVvW6
 tvzTi5z+OBWIMpb9PHneBHh6AydcfSaIS0few8UJxixo1LsToxZxbjnHnSos6BsnHjqdI4
 co1hXKxUAzCbFmHw6luY2YQ7rE7nQkg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-AERxVq-RORy08gmLwIz8Ng-1; Thu, 16 Jul 2026 07:05:13 -0400
X-MC-Unique: AERxVq-RORy08gmLwIz8Ng-1
X-Mimecast-MFC-AGG-ID: AERxVq-RORy08gmLwIz8Ng_1784199913
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-475de65009dso2526631f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784199912; x=1784804712; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pmiRZOCGzK7zG5LqcJYzkc4+CuFH9PCYd5BVxba0Mks=;
 b=r+3MNOCDBh5JH4TDTwClR39L9rntREUC2OORgktcJBSRnvwtd7xytpR+6To1re52iZ
 M7+yhPaaT/9n2mEdauPTF9tsTyzniHdtSidwvV14h9xsBke+0DmXaR+7gLHTXLAN68GX
 LWIM6iS2jXKJzUd030ESQAYELCx6QdRd/tj1m5dxIVhGDStnFWVitXZZ/C943dh5XLw2
 7sGs6ZrWJgmwe8FQ8t4YefkSp+T+l3n2vCV7gEHjDizPn+7Qdzn9OTym6jKGcJjfRIxo
 RByTfvLRBsoPJwWwTGQWRm2181Yl/cDYOJwVT33iymEF9ObR38WlweF+z1Cv7EAtnQuY
 ICYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199912; x=1784804712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pmiRZOCGzK7zG5LqcJYzkc4+CuFH9PCYd5BVxba0Mks=;
 b=fCKcta0QeVKHLlaqP1N4OvtKQ8sZ+o45rp/t3sppKhXtI+9pQAEfy/fg/R+Wresu4F
 xDQ9Wak2iuTBjjxyOrVSEZrTiNnhuMgpGxZmONL18nq+9zDQmTOxeRJpDaJFwJm7vnA6
 xXtOtjDdFQBaQwg3AQ5qjGpreZhPQRFVKeaRxtUN7S71QtwWNL3Z9jWi0gUOTl2ensNQ
 jOD8Rgn5QGOOBBZsSP/k/Q8W3tvvdvMaFQRcsbtTjACt4sho6hYq6q7kQb6B31z+HEsh
 sWMcON3P5xVm0Wj7NFb6e3kJvv8fmXTLehEUU1zFtueTSOrSWI5CeX0mNv7Wdi/5ZdD/
 c2zQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrySVKASIpb7VHHE3N0Mr9smYzAHAPyPGwaoKuPVR8CNNVU+RhfMvzd0kYUYTaKaV87ebWFSVgwbGAE@nongnu.org
X-Gm-Message-State: AOJu0YzbYYEzdmZoNHukUrspEnh/u/KeggoUYNwR/dvsyS+uVtCBgMpL
 TjsvFtkt/DCzg2reV1PXldHKHfAxzeJzBrJ/8RvxFPdk/HdFPZupPemOsM2TGqHC2gQn7ap16hE
 KD1i1HUZVJW+FF6+Ujf/xdoRglLTIZpNoqBo1GMt1DSbDABfnX8FDGfKd
X-Gm-Gg: AfdE7cm3lWs8gm6fsN2g4onmd3Z7Nzt5KFsZkOB9bKdp/wBueV368dhvejzIp/PlIZp
 IL+WTExZW31NSd7WaIc4n0WhzjVuzt94+3RphIqfKC9UpFTj9MIACG638ugWN6K+Fb2EqvO9ov1
 HswW/VV5USnC9g85rqy7JMnEt0Dho08O6X6GLywq/r2dPbb9p35xWbksoHfm+SsyqMLSyy1rAdX
 Yi9FOcAf+jZGonF4czLnLVJqNIZJ5cNfthPRG7AWh/SAMQjsIWonV8Ih8+5CtCCV7QJH6/Jws+f
 +W5/4iHvD4FwjdXZAdFLhYdeeB7JYDxVDXaXgyeoO/LHDxNJnpz54Wd0X7exbUDIEjc2v5JvR6y
 oNH24QJqUIL2Ij5ekhxKgoCom
X-Received: by 2002:a05:6000:2612:b0:46e:1815:6a83 with SMTP id
 ffacd0b85a97d-47f2dd1f23fmr29041943f8f.29.1784199912529; 
 Thu, 16 Jul 2026 04:05:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2612:b0:46e:1815:6a83 with SMTP id
 ffacd0b85a97d-47f2dd1f23fmr29041895f8f.29.1784199911998; 
 Thu, 16 Jul 2026 04:05:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c30a9sm22817513f8f.31.2026.07.16.04.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:05:11 -0700 (PDT)
Date: Thu, 16 Jul 2026 07:05:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
Message-ID: <20260716070404-mutt-send-email-mst@kernel.org>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <20260715184145-mutt-send-email-mst@kernel.org>
 <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
 <20260716012417-mutt-send-email-mst@kernel.org>
 <3dd53cb0-b4f9-4f1c-9d47-7fe28a872d52@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd53cb0-b4f9-4f1c-9d47-7fe28a872d52@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 01:39:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.07.26 08:25, Michael S. Tsirkin wrote:
> > On Thu, Jul 16, 2026 at 02:27:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 16.07.26 01:41, Michael S. Tsirkin wrote:
> > > > On Wed, May 27, 2026 at 09:16:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > Hi all. That's a preparation for vhost-user-blk backend-transfer
> > > > > feature.
> > > > > 
> > > > > 07: rebase on master,
> > > > > 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))
> > > > so patch 10 is the fix?
> > > Probably it's too late :/ I don't understand, what do you mean). Patch 10 is a
> > > fix yes. But seems it has no relation to vhost-user-stub.c ?
> > the patchset is big. I am debating with myself when to merge it.
> > Is it possible to just apply fixes an cleanups later?
> 
> But you've already merged this patchset, see commits c549dca2f27..2d5e87062b6 :)

Ugh. Facepalm. Donnu why did I tag it again. Thanks.

> -- 
> Best regards,
> Vladimir


