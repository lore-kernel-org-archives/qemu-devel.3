Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BB8C761AE
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 06:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjYZp-0008Je-82; Thu, 29 Aug 2024 02:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjYZn-0008IQ-8X
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 02:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjYZl-0002LM-9S
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 02:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724912644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xV4HPNcOWgH79UxiFsHtRRoFumdDDornEXMJDEJAeM=;
 b=haIQOE/Sd0d13xNEvNv/JupJ55Tohpuqve8+v2n1jFMviBC1NrmO5QfMbqli5ti622RJHL
 YwWWsMlR1RY2JUff/YW8rduKjQnfa6pSFF5U3SJXkXfqq4YtbRh1MY/WUvCql4fDEWBLfP
 kQ8YEL+LCOfVaMWIoiWbMQ4kvMJ9QoA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-C50hnf2FMQen-IdY-WY8sQ-1; Thu, 29 Aug 2024 02:24:00 -0400
X-MC-Unique: C50hnf2FMQen-IdY-WY8sQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7a83fad218so23442666b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 23:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724912639; x=1725517439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xV4HPNcOWgH79UxiFsHtRRoFumdDDornEXMJDEJAeM=;
 b=SMStf6l6ja5sPLr6U+5YrnQt0vSSlouDHT5gWt50nQENGRpdYhGkLcozldVdAOZxre
 r6nSsRmycgbnxtez6dZ97/QxB27tbG3hUXqWaxZOBftlybHp6xx6er2TmsQWag1tJ3Mg
 vrcjyk7yBk57mxYlGeAhd2QNvxkymekBDiDLkatjE+VhATjQuyHE5w90pUj9wLodGZBi
 1I+RdBx4BhPnWCV6JfiC/Nku3jk1gNuob26Ewnw2JiWCSvTrLE/frnAxirIec5zxt9lU
 Bs2xVDf1AGpVKxegyCY4tZCRh+AUI5QLJ6J3I8zCHNb9M6eph+7GoGmA7OoouSR/wS0m
 Ra2Q==
X-Gm-Message-State: AOJu0Yz1eHGyX54AQErWYHpXSz0hzF8seW+U6kNJ2zDyNdN58dCnWv0Q
 fojAK76a5l2eotwhMzVlki/heRL27M6V2RaH6o1arrrM1Gzyd1qKf1sRGXVU0p4fd7b9rJzksbG
 SgQXoQi48ZtlPTpk4+sJnGD29wLQrdZlE5FGzE+ThTh8ObJXrCHo2
X-Received: by 2002:a17:907:3da0:b0:a86:78fd:1df3 with SMTP id
 a640c23a62f3a-a897fad4df5mr120965066b.59.1724912639344; 
 Wed, 28 Aug 2024 23:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFv7AU7qXBNxV4Yq45vfucuxmATx0D08uWthB0ABkstM3Yz5ExPYvdpAos8zLaoJ768s//lg==
X-Received: by 2002:a17:907:3da0:b0:a86:78fd:1df3 with SMTP id
 a640c23a62f3a-a897fad4df5mr120961366b.59.1724912638408; 
 Wed, 28 Aug 2024 23:23:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898909253asm34311866b.93.2024.08.28.23.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 23:23:57 -0700 (PDT)
Date: Thu, 29 Aug 2024 02:23:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com,
 mcoqueli@redhat.com, peterx@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
Message-ID: <20240829021506-mutt-send-email-mst@kernel.org>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240828071343-mutt-send-email-mst@kernel.org>
 <CAE8KmOyyUBSebh62_zdMyXWEZK+uUyx28Pe-aU-0E9d-upOWTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOyyUBSebh62_zdMyXWEZK+uUyx28Pe-aU-0E9d-upOWTg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 11:09:44AM +0530, Prasad Pandit wrote:
> On Wed, 28 Aug 2024 at 16:45, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >  - Place QEMU_LOCK_GUARD near the vhost_user_write() calls, holding
> > >    the lock for longer fails some tests during rpmbuild(8).
> >
> > what do you mean fails rpmbuild? that qemu with this patch can not be compiled?
> 
> * In V1 of this patch, QEMU_LOCK_GUARD was placed near beginning of
> the function. But that caused some unit tests to fail reporting
> TIMEOUT errors. In this V2, QEMU_LOCK_GUARD is placed near
> vhost_user_write() calls, to reduce the time that lock is held.
> 
> * Both (V1 & V2) compile well, but fail at '%check' stage while
> running unit tests (on some machines), ie. rpm package is not built.
> rpmbuild(8) on F40 machine failed, but koji scratch build with the
> same SRPM worked fine. Those scratch builds are shared above. RHEL-9
> SRPM built well on RHEL-9 host, but failed to build on F40 machine
> reporting failure at '%check' stage of rpmbuild(8).
> 
> Thank you.
> ---
>   - Prasad

Weird.  Seems to indicate some kind of deadlock?

-- 
MST


