Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7197C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 21:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4I7-0002HT-IR; Mon, 03 Feb 2025 16:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf4I5-0002HK-Oe
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf4I3-00067b-TZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738619251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dq530EX6ospr+5kUajAknQ2rg1B++SJph6Vk+cyBCRw=;
 b=GqmzcIB1COWrS6SLiK8IYwfhgetxdMwp/XNrilQePOOw4j8ZZM6hwWtbSP8kkpyHMjtv7t
 /T2MrTVYBuQfABUUIFRlJE6o3CgDvojJMyDu2xqh3xiidMgGcghCKnwLKcaDEXJ/It7Tmx
 v/J6CSKpQF5DOH+B6onZh9a+o3r8hUE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-6B_sPqbZPGaFXNL4TndXkQ-1; Mon, 03 Feb 2025 16:47:30 -0500
X-MC-Unique: 6B_sPqbZPGaFXNL4TndXkQ-1
X-Mimecast-MFC-AGG-ID: 6B_sPqbZPGaFXNL4TndXkQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8b3173b5bso67101076d6.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 13:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738619249; x=1739224049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dq530EX6ospr+5kUajAknQ2rg1B++SJph6Vk+cyBCRw=;
 b=nrVAdiiiOZd8KfTyEfYQN+HMzz8cjPSgiSaOhMeOfwWxJYSvoi/zxHo08AMB8tcwV3
 AXP57yEbnHnadN+eUDhAK+ykFGL6UYCBBILs9zCdO1PG7l04LulexMM/O0bgti8Z1vpH
 HOCY9yYLAGai6IijItodF+rleRO5PNsn3PipaX52cgxs6Rf4HsGlxc+wIBimjQeMnMQ3
 6rDjmKVrXbZhcO86qgVBhgruivjLIR9sJW6jbn/LwL4zcs/fLOhla4ETKp0eUaVkgjOz
 Mc6Inx1Pfp/+xhVbp3WmRBzE3IPUp/zLIMsxZbxbUHLFqouwSXwKDge6VixeFXDjej6w
 1f7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM10GkNVL/ghm2v0cTEqR5zxn1f77WnGY7CtOZEYTCIdCQrAlgKYDyZ5vl26dMFxHPo3gRj8619eAz@nongnu.org
X-Gm-Message-State: AOJu0YxtyC8S6hJ6tYQYzhSyYBrzolfc1mi71ylmsn5SeID2wFi+IXgn
 UFvqPggShrOkspZYOHw+AT1R9vg2r0vOEx1gp3wOVM5ihQ/BQ28AiGoIxvDOg2dOohL4tgatg/h
 z67oRdnef4dUTX5nsj0tRwCSnAA5GiOccUN7dySgNAUeSRvE8s+zj
X-Gm-Gg: ASbGncuGLPlsHMPx6eNDBNKd/7KJzfv3Y3UtL0kZCH7ZYe/LTBQoilWSFfxS9m4lE5r
 LiJifSijxVfCiM4bNKUN/hsMh6Gtq/2VXV3NHiLax7izR1KB6Y0n5KVrb/T4N6+OAiKgcETZ0Qx
 u/323GVkXWsAci8TEW9/ABLx2JFb1vT4xpxaWbB2o0pajpYpO+eNsqCRVcmGrfwP0aqNzuDXFNF
 cF9uleQ3dbIOfv+Cw5uHVffRiiVAI3LVToQewZF5APk8BK6mzGXAa3un6p6hPGwPlYp/CYM0qRW
 kjgx9QLenLTkvtBc3NQXF5Yvw7J0nWAA3Gfh7Yn7xAH3sevi
X-Received: by 2002:a05:6214:1c83:b0:6d8:9dad:e167 with SMTP id
 6a1803df08f44-6e243c1dc04mr365638626d6.15.1738619249575; 
 Mon, 03 Feb 2025 13:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0oSNdvn3c1uZHQP9lTli1CeMlxIlLlqolggN+YWoITH3ZSGdXu7hm4X0jVHYqMN9yu+yiKw==
X-Received: by 2002:a05:6214:1c83:b0:6d8:9dad:e167 with SMTP id
 6a1803df08f44-6e243c1dc04mr365638336d6.15.1738619249306; 
 Mon, 03 Feb 2025 13:47:29 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e25481446esm54721966d6.30.2025.02.03.13.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 13:47:28 -0800 (PST)
Date: Mon, 3 Feb 2025 16:47:25 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 16/33] migration/multifd: Device state transfer
 support - send side
Message-ID: <Z6E5bTN7thEBcFJK@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <0d277461eb7cb849dc1af03c38275f7c9747f0db.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d277461eb7cb849dc1af03c38275f7c9747f0db.1738171076.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 30, 2025 at 11:08:37AM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> A new function multifd_queue_device_state() is provided for device to queue
> its state for transmission via a multifd channel.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


