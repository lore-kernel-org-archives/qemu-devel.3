Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AD7D3A69D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5t0q-0007oO-03; Tue, 29 Oct 2024 16:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5t0o-0007oG-NX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5t0m-0003sD-Sf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730234419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdldiipfeeF+KVOhmESg1QZ9qdH3OpJ2VsfVGSIgNN8=;
 b=DRUEo6Jfo/VkViS2CrYCtHXmhK1nDB9qvIzIOwrHDzo2sO+fbVlW9Lt1O4S29e0BmgNd7m
 l3cYVe1Eonyx6kIukOua2+03Rsk/GUvnLaz+6RHU4PjU2pWlNsAMfaKVSbrjIofD6QaQBy
 N/bevgDL8J4yIQ3pdR5F9fWDgTp7GTk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-PVTS1Y4cMbiW_N-LGj-Mdw-1; Tue, 29 Oct 2024 16:40:18 -0400
X-MC-Unique: PVTS1Y4cMbiW_N-LGj-Mdw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b14f5ca413so972559285a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730234417; x=1730839217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdldiipfeeF+KVOhmESg1QZ9qdH3OpJ2VsfVGSIgNN8=;
 b=dcq8Dhnvu21BVmbjuEfHD7giYE/6mTdhxdZ5+MIhgjgeaxO6ENixvf0nbrlzejz79X
 +WdOwvXqt13j6TQ342C5ycPlTPpHZYAFDkuyeqQivgEePoTIGsK7AMt/Mt3tI1s9nYV1
 lv6y4ccEQ+Qx+Le/0+a3xX6LmkTFB1hZ/2Jecns1D2qpjvqeMve3hyNaapl8HHMwHEr/
 I85Hj/pZTModKSlxHkvaUDNP+XKbyzqyj/Nf4dGKzt+b0O7p+RiqC7JaijAkYIpqtAWI
 N+KvespCyi1Qu4oNCZkCYr9dlMBHoZ3xM/apNdzFNTAg8kGU0fenSs+5yPVIAY5uuekr
 XHLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgVIHeEtkHv6nYKukjwRu5fte4lwK+exIR/rvH3AHlv62U1uodgfY4S6pRuESPGDiuUii++HvuJjSQ@nongnu.org
X-Gm-Message-State: AOJu0Ywz5sCnIHGCNmPTVEyty67AZW4fW3psVHMsdmxm5LidewSyA/Xd
 dPSf7NEU/AhdYi+mgYUJ/+KNf7UMe4dCzXtvuC+gncFnA5XpYYpcgkhWTjaUi5WT/Clg3qEDknT
 yIkwTMH8g9EaMRDSNa/4u7Rsm/VlUHxl7fG8vUILEkG6Gu8DKFCPQ
X-Received: by 2002:a05:620a:4720:b0:7b1:440a:fde5 with SMTP id
 af79cd13be357-7b193f76ed7mr1796872585a.66.1730234416954; 
 Tue, 29 Oct 2024 13:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvHFtm2Ufj46UbKnVgLZt+SVtM3wKXM+FLXZ1yhcaUJGescSMvogCqyQ7o4Bvun/8ga2qUUw==
X-Received: by 2002:a05:620a:4720:b0:7b1:440a:fde5 with SMTP id
 af79cd13be357-7b193f76ed7mr1796870785a.66.1730234416658; 
 Tue, 29 Oct 2024 13:40:16 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d294926sm451576485a.45.2024.10.29.13.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 13:40:16 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:40:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] Trivial patches from multifd device state transfer
 support patch set
Message-ID: <ZyFILpY21mLNBIDv@x1n>
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730203967.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 03:58:12PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> A new version of the multifd device state transfer support with VFIO consumer
> patch set is being prepared, the previous version and the associated
> discussion is available here:
> https://lore.kernel.org/qemu-devel/cover.1724701542.git.maciej.szmigiero@oracle.com/
> 
> This new version was originally targeting QEMU 9.2 but such schedule proved
> to be too optimistic due to sheer number of invasive changes/rework required,
> especially with respect to the VFIO internal threads management and their
> synchronization with the migration core.
> 
> In addition to these changes, recently merged commit 3b5948f808e3
> ("vfio/migration: Report only stop-copy size in vfio_state_pending_exact()")
> seems to have uncovered a race between multifd RAM and device state transfers:
> RAM transfer sender finishes the multifd stream with a SYNC in
> ram_save_complete() but the multifd receive channels are only released
> from this SYNC after the migration is wholly complete in
> process_incoming_migration_bh().
> 
> The above causes problems if the multifd channels need to still be
> running after the RAM transfer is completed, for example because
> there is still remaining device state to be transferred.
> 
> Since QEMU 9.2 code freeze is coming I've separated small uncontroversial
> commits from that WiP main patch set here, some of which were already
> reviewed during previous main patch set iterations.
> 
> This way at least future code conflicts can be reduced and the amount
> of patches that need to be carried in the future versions of the main
> patch set is reduced.
> 
> 
> Maciej S. Szmigiero (4):
>   vfio/migration: Add save_{iterate,complete_precopy}_started trace
>     events
>   migration/ram: Add load start trace event
>   migration/multifd: Zero p->flags before starting filling a packet
>   migration: Document the BQL behavior of load SaveVMHandlers

I queued patch 2-3.  Patch 4 is ok to be merged even after softfreeze if
it's a doc only change, but we don't need to rush either..

Thanks,

-- 
Peter Xu


