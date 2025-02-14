Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F18C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwRu-0003qT-VT; Fri, 14 Feb 2025 09:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwRp-0003q8-K7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tiwRn-0004N5-M4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739542418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36CjYwTEUcHO4/JbHGS7Xj4yo6RfgXq7p5Y2nepD+XI=;
 b=ELnew1biOINRlEHd7dg2pMroN2Kihc7FbRwOR6FpOgyE8dh89zYFC11KFGKkjJ0+YYJzpy
 4LBp4mMI5A4L8lR2c7p2oTty1SPkTjcexvJYmV+siWFueHwmIgr4k0QHm49LZiAp8kRPzS
 0KF93NBIRS7e1FbskfP3+pfx7lv1iqQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Pp2HsP7UMVCeypMEvAcgTQ-1; Fri, 14 Feb 2025 09:13:35 -0500
X-MC-Unique: Pp2HsP7UMVCeypMEvAcgTQ-1
X-Mimecast-MFC-AGG-ID: Pp2HsP7UMVCeypMEvAcgTQ_1739542415
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f27bddeeeso1750083f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 06:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739542414; x=1740147214;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36CjYwTEUcHO4/JbHGS7Xj4yo6RfgXq7p5Y2nepD+XI=;
 b=JJpO2OSOBzzytD2PPIVA7cocNdyJHEVByo9G3cgCaRvocV28tO+juLzn0x8ni8rUXd
 jAHWbw6Fcyvs7w6m/PN9balXk7ReCRNYZL3l99c9BBOrmJ50CUg+jfYDYCiD7vjj9Dnc
 qGXcD8rATJvZhTo6Ur+V71o8hOaAYNRv4NkBP6u5hxzfbGRCZ8AAsLhRkHWd2PrIIq2z
 K/zcGcerAZunAyPx8QQt8UtEgpadk6zIYxfl8eOyhDpGdntR/qyoJds1QoBcvgpF1tsX
 PRsw43DYTi2o5rgbLrh5DU7UoPcTiriWq4PvlItd0xpLXnxYXLfYjlHb2FYo/NvAB6cv
 jqhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwimiHlvdensy0u4NbvF3AASxW4Cj7mbSjj9vP1qEFWDQA6kAUNO898yVxCyXKe9d1aArFK2UV+oeL@nongnu.org
X-Gm-Message-State: AOJu0Yz3gInEdG9tKOKx/le3CRk6n1bgWsk0cdQ0tByejfOsexY7wKGB
 cN0LwF7YEvWOfH+nhuopsSa7XClcRjDPrbl3unupM/qVJQdC17jW85vloU0wiU/ZnQJUeMDTfa6
 kaVlkuBAduYZUROjoH1q2OScvXH5V646qVHIwsAjP0Jio6xy5wQFN21+mQM/MSLlC06WojlGwVW
 F2FawUa6hD8PzeCApJXCVgToUPQYcXvsXsn+A=
X-Gm-Gg: ASbGncuwHqouSD7TbYWU0cLe7GMZFREcXrjrObyzXYMryCPGyFG6fzc0ta1kC7Q3DuX
 vNxHALQOqRnnq3Rk4omign1MaeAKl510FlYtlo6VfEcxQEsYKEsv5ReXidVG6QYfhEvl0JmkZUe
 Lql0kF3Xtx8qZz/3r5Cyg0lh4OQIfvZv/VAzdf5ddgetnT3th1+qy9Hbvt1MQrhRYk8c+qEkeU9
 CrYd+osAfmfHIDcyi3HCYxB7itXu91tBiOc8eGAEde8qS1Qwj+1bdwXx0O11NAhCfHEoBW8m7D+
 yYWGQifPIIuBxfw8UVqhYopBIcw+oHH/gA==
X-Received: by 2002:a5d:64cc:0:b0:38d:c087:98d5 with SMTP id
 ffacd0b85a97d-38f244da15dmr9371032f8f.8.1739542414044; 
 Fri, 14 Feb 2025 06:13:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+Hdvmxt2BNBI4+7N1fLDBgknT5/OaTas19vFF16kDKbQYDxeAuwo2Ep/3GXzY0aI+oE0bXw==
X-Received: by 2002:a5d:64cc:0:b0:38d:c087:98d5 with SMTP id
 ffacd0b85a97d-38f244da15dmr9370945f8f.8.1739542413456; 
 Fri, 14 Feb 2025 06:13:33 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d9be9sm4807277f8f.79.2025.02.14.06.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:13:33 -0800 (PST)
Date: Fri, 14 Feb 2025 15:13:30 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Eric
 Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <20250214151330.0f0be3dd@elisabeth>
In-Reply-To: <87a5ao3a3q.fsf@pond.sub.org>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
 <87a5ao3a3q.fsf@pond.sub.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 14 Feb 2025 14:54:33 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Laurent Vivier <lvivier@redhat.com> writes:
> 
> > On 14/02/2025 11:06, Markus Armbruster wrote:  
> >> Laurent Vivier <lvivier@redhat.com> writes:
> >>   
> >>> The netdev reports NETDEV_VHOST_USER_CONNECTED event when
> >>> the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
> >>> when it is disconnected.
> >>>
> >>> The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
> >>> (label, filename and frontend_open).
> >>>
> >>> This allows a system manager like libvirt to detect when the server
> >>> fails.
> >>>
> >>> For instance with passt:
> >>>
> >>> { 'execute': 'qmp_capabilities' }
> >>> { "return": { } }
> >>>
> >>> [killing passt here]
> >>>
> >>> { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
> >>>    "event": "NETDEV_VHOST_USER_DISCONNECTED",
> >>>    "data": { "netdev-id": "netdev0" } }
> >>>
> >>> [automatic reconnection with reconnect-ms]
> >>>
> >>> { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
> >>>    "event": "NETDEV_VHOST_USER_CONNECTED",
> >>>    "data": { "netdev-id": "netdev0",
> >>>              "info": { "frontend-open": true,
> >>>                        "filename": "unix:",
> >>>                        "label": "chr0" } } }
> >>>
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>  
> >> 
> >> Standard question for events: if a management application misses an
> >> event, say because it restarts and reconnects, is there a way to obtain
> >> the missed information with a query command?  
> >
> > query-chardev could help but it doesn't provide the netdev id.
> >
> > in HMP, "info network" has the information, but for QMP we had a try with a query-netdev in the past but the series has been reverted.
> >
> > f9bb0c1f9862 ("Revert "qapi: net: Add query-netdev command"")
> > d32ad10a14d4 ("qapi: net: Add query-netdev command")  
> 
> Hmm.  Can management applications use these events without a matching
> query?

Yes, see https://lore.kernel.org/all/20250214095338.344063fa@elisabeth/
and the existing libvirt implementation for NETDEV_STREAM_DISCONNECTED.

-- 
Stefano


