Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4A4C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2PE-0007MX-OO; Mon, 17 Aug 2026 14:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww2PB-0007L4-FP
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww2P9-00051X-Ot
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786992589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JfpP/5gGcIzLfnvgQuKmPtsXfaxrCfwf+s3VC6maenI=;
 b=ZbSqBqznC/ZN/7vw+2S65vUSflK0JWnyCHDx2FyzVtm6IGQvrLHD32eqYWVWHrRjAaS6E3
 NoSB4u+oIyupLLJmPD+Z0qE9PsQSFEV8dcyYVBGofG8KkE12ChYnOdhYHeg7ABK0tEDa6V
 1BRTcVuZNG3lJLZeeDGj6QbcFOfqLtY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-4qQFif7_NT2QDE8ffFZ3UA-1; Mon, 17 Aug 2026 14:49:46 -0400
X-MC-Unique: 4qQFif7_NT2QDE8ffFZ3UA-1
X-Mimecast-MFC-AGG-ID: 4qQFif7_NT2QDE8ffFZ3UA_1786992586
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8e934385db1so42024846d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786992586; x=1787597386; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JfpP/5gGcIzLfnvgQuKmPtsXfaxrCfwf+s3VC6maenI=;
 b=QEAcyubnnldUmCJDHawyh3+jWyf0XFiY79/JjXHCKNQlyqLWpZJ2r0y9CCNwjfKYe2
 yRXBuyH1uKmnomGXHGU+DeahrwcUXXufVVYLkNZ3lrG3AO/q1OJJFOCYT5atlQpKE9MX
 pQrR4o1VlwS3VqEWOLLnwvT/ZoZMZFPSnodseEsl9vA1nD0rxKBWZtYXkXPNJ11SI4uF
 f8Gepmsz49OMax6X+En+rreKNKfo11xT73E2/CBb6jWi7p1Aa24dHDLYSepSntfvMR0v
 JoXcT2vm69+466d0focElPZOXu5XT3ooQsL1gSwLXCX/jWd5bCPF1R1JndkYpLe8ebhd
 yklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786992586; x=1787597386;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JfpP/5gGcIzLfnvgQuKmPtsXfaxrCfwf+s3VC6maenI=;
 b=HH2Atj6i8tI8xmYR+ESlZyJKdAB4cw7I3mGUgIITO9xCpHN0Zk38APt+ZRjEohKOCs
 eVmUhcCYjBRtxvc5zubYp+erNDPKJSYAtpTS9skw6BocsESPp5rQVDb/ek/cEhAtILne
 2Hpdiza0Xs34eJVUJiRhqYkWIxwN2dlvu+EaqhDJQGzRj0Sl43albUpF/Ql2PGQeGME8
 qy8bG4myjyiK35GBOEdSlh8qNEcHHtMvsNkERye51vL8UmiEZiGUP00AS1zM8y70pyaC
 S5uYL9F37DS+XqWOBJ72Son/FHcHWTAowVxUY/4SZeGqgDGWStJ5eSloRUrEK0jzlQhM
 HMMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxRhHZsKNC1pol4oXlf6WKkdDjMV11PT8GT0tKgx0hny04oyU39FuJnmnYCzruIorU3X/+eWbFUTrH@nongnu.org
X-Gm-Message-State: AOJu0YxZJyEn5ej9d3fhfH0e92EwpNfAfV505BMCEsgNuBpKVMvSJK90
 6b+mZSrE0fonKJ7b6ncVl5oU/X+YYIufIdGI/uVPbDJaxDJb98raBhf+PilY3MmpInVZ5yX+lhF
 lOmQVF1eehi7C73yPM7izfvcbioueZV7AeILuLVAk8SKFzGanycl2UJ8B
X-Gm-Gg: AR+sD10148wGYeA3cwBQ3XIqpXmN+xe47HihLVrJERkC1VVNhZCjl3+jZJq27uPxPd6
 dDFNiT4oKY4ycIXkXlna4lr3Vra6MkO8WXc9GEMV8XaHfa3qQaNBBtsAPxVaR9eniT620i/Dr6S
 oxmGr7UuHklme9nwarIHFsXwQabQMKVkKHvTPCQjIZBeLgQNwDuvmbgjTr7Ct1V4IUgKbpHYeuu
 vq8It4mjy0LfUno7z2e21lDaulUTlACGbwunpJ3z0Hi/eFTgQvoDGCyC3abXLPGuehgrQnPFBXE
 SfaOiVX3C5mG8TK79+uXqIk8T1C/r3S4IGZYM+Udy0XqMIedgdjYZIe+1NuRz/+jXhtY/gF3Lhc
 YGzYvjTZPpv9Y4Yu4yK8jUkEyjo+3eopOWd+XbMv0Ij4pyP52ga7EO5BAXbw=
X-Received: by 2002:a05:6214:4808:b0:908:a729:73a4 with SMTP id
 6a1803df08f44-90c4b2d8589mr33238116d6.5.1786992585751; 
 Mon, 17 Aug 2026 11:49:45 -0700 (PDT)
X-Received: by 2002:a05:6214:4808:b0:908:a729:73a4 with SMTP id
 6a1803df08f44-90c4b2d8589mr33237716d6.5.1786992585326; 
 Mon, 17 Aug 2026 11:49:45 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4594db55sm15566736d6.34.2026.08.17.11.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:49:44 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:49:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v20 10/15] migration/channel: check that transfer is UNIX
 socket when "local" set
Message-ID: <aoNXx0cjLgIP7RBg@x1.local>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-11-vsementsov@yandex-team.ru>
 <amoJoAyhymPgvyTR@x1.local>
 <b9957dda-c0ee-4081-8938-ecc5a50aae3c@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9957dda-c0ee-4081-8938-ecc5a50aae3c@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 17, 2026 at 09:15:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > We only need to touch migration_capabilities_and_transport_compatible()?
> > It should work for both, and fail QMP commands directly might also be
> > slightly better.
> 
> 
> Hm. Actually, migration_capabilities_and_transport_compatible() only sees
> the parsed MigrationAddress, before any QIOChannel is created. At that
> point we can't call qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS),
> because there is no ioc yet..
> 
> So, at least, we can't check, is passed from user fd is a UNIX socket
> for SOCKET_ADDRESS_TYPE_FD case.

Maybe have one extra step for FD with socket_sockaddr_to_address()?

-- 
Peter Xu


