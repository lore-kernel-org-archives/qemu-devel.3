Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33921ECE58A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlxo-0005yH-Ie; Mon, 09 Sep 2024 17:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snlxn-0005xa-Fg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snlxl-0004QN-JJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725917419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgV63vA7puC+VcliaXWMAbNn3/pczEaAaNvUhihvjMg=;
 b=eSWiNLZBgKmlyVyZl8YTKhmJBNC6tu1p2kdna1SSG21Ilulbti4jjVLFliUPwytIKrh4CA
 aidZjoJksueg1p9zh4U0pEqYRnXRRYGT0kTqRV0kxgh0Dk1UiKvzenDQYzvQ2bt6+P9Ie8
 O2B81HJnut17kZ9thp07Gz1Wx/geH4w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-DILpyT3HOIGoN84hxMpyZQ-1; Mon, 09 Sep 2024 17:30:18 -0400
X-MC-Unique: DILpyT3HOIGoN84hxMpyZQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a9a653c6cdso439303985a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 14:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917418; x=1726522218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgV63vA7puC+VcliaXWMAbNn3/pczEaAaNvUhihvjMg=;
 b=O53C7GhZXvX84328Nq9tr2PQojcl2AmtmwD2IigvZAHB8cstoggRvhbH1mUk7/oTS5
 fQdFqUovoxHzTmIkTyHHA5WvHCtIaBSyCimajA4MOUaWFQBqMk2vnlw6tv6Qb0uDw7Um
 JAZ8qEB2rxMKmUy396gO4smPZ1t83WSx9hM1ShKn0lbtZUNebDroWY95BHaa+8J/awDt
 oJb5oDZVcm50UIBqvURUhbrADXZOlC1ESu3sXc52wIoqBEWC7pxjn6Gxd3VOZvwzn0xS
 0jokGdESpUoPFtyX8zxB18Vgpb7e8THMBCdBiBUCpnw3+zUaZW0By6rEebBcJsC8NBfZ
 cJKg==
X-Gm-Message-State: AOJu0YxB+3AcuDrMWoFVmufmZinT1yKcxUZqnU2w29g0reAWqKVX6UU4
 V92+m4SVRa5D9rS5vXrfX6TSXkZg/o/8yuZ7jt9PhxHOz8977akqpkgt1N2pNMyiVtSYi/Tgkzp
 WoJNUpekJn71a1JDU1DNp8JBaTGjfAmzssb2riJ+5+BZ0sz3zVrGm
X-Received: by 2002:a05:620a:3916:b0:7a2:e2e:31c6 with SMTP id
 af79cd13be357-7a9bf988bebmr165164785a.21.1725917417689; 
 Mon, 09 Sep 2024 14:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHts6tzaB1GdzaF5V2VVLx9ZuMtbE8H2lLn1liS6yZFZVGf0Djz0x3ELN+LDO9Pxdjl7iQ9Zw==
X-Received: by 2002:a05:620a:3916:b0:7a2:e2e:31c6 with SMTP id
 af79cd13be357-7a9bf988bebmr165160885a.21.1725917417312; 
 Mon, 09 Sep 2024 14:30:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a79456a1sm254780785a.22.2024.09.09.14.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 14:30:16 -0700 (PDT)
Date: Mon, 9 Sep 2024 17:30:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND RFC 03/10] qapi/migration: Introduce periodic CPU
 throttling parameters
Message-ID: <Zt9o5r1ZWOxnjctC@x1n>
References: <cover.1725891841.git.yong.huang@smartx.com>
 <0bbcdfd86f35830e0a398220663aac5afd8b7e1e.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bbcdfd86f35830e0a398220663aac5afd8b7e1e.1725891841.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 09, 2024 at 10:25:36PM +0800, Hyman Huang wrote:
> To activate the periodic CPU throttleing feature, introduce
> the cpu-periodic-throttle.
> 
> To control the frequency of throttling, introduce the
> cpu-periodic-throttle-interval.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Considering that I would still suggest postcopy over auto-converge, IMO we
should be cautious on adding more QMP interfaces on top of auto-converge,
because that means more maintenance burden everywhere.. and it's against
our goal to provide, hopefully, one solution for the long term for
convergence issues.

Postcopy has a major issue with VFIO, but auto converge isn't anything
better from that regard.. as we can't yet throttle a device so far anyway.
Throttling of DMA probably means DMA faults, then postcopy might be doable
too.  Meanwhile we're looking at working out 1G postcopy at some point.

So I wonder whether we can make any further optmization for auto-converge
(if we still really want that..) to be at least transparent, so that they
get auto enabled on new machine types.  If we really want some knobs to
control, we can still expose via -global migration.x-* parameters, but then
they'll be all debug tunables only, perhaps that can at least reduce
burdens to QMP maintainers and Libvirt side.

Thanks,

-- 
Peter Xu


