Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C52D637B2
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJjQ-0006Ob-Et; Wed, 13 Nov 2024 15:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJjN-0006OL-NM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJjM-0005sP-E0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731528766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEAC3rkHrc/DkVzOl8qT4GRO1rW6UY0LaQvjhDiCffw=;
 b=c94DkahK7EqUkVcu8xdScsHCd44MQXIZbapz9Ly5rF4vy3IK4nIJp5yvEiRsTQkdZZiRzB
 8bTj/8CTf8pvM+KCQvnBXKMvKbeJYoSh9bmNc8MF/TXkzg3pwGji1zXXBIyClcC/XNEdNq
 HNgcoDxm/XJVW+JCqDdml5zOGEqelLU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-zaKR3nvWMEmN3LAydTiqkQ-1; Wed, 13 Nov 2024 15:12:45 -0500
X-MC-Unique: zaKR3nvWMEmN3LAydTiqkQ-1
X-Mimecast-MFC-AGG-ID: zaKR3nvWMEmN3LAydTiqkQ
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a6b963ca02so75955925ab.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731528764; x=1732133564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEAC3rkHrc/DkVzOl8qT4GRO1rW6UY0LaQvjhDiCffw=;
 b=eM4MeVaOBCZ4ydIFseRMcdRSYqXWjDBY6IvIOQOgAlB7rCfmv3p2zuoEMm/UMbLUi6
 PrH4zmjhKT9WIfa+3AFS+LoDFxy5Stv8icjeHcMS/UxxW081wX1jkXHfu4Flv6Vee8au
 rhjmeD5f3+td2Y5fcmeLbCPD0DCmFHbiadNbQgMHvuQprHaWFAeUPY41lEFdRpuqk5eE
 s6k08YT8gAgG1X761cybGPKfnpxzT4VkKE0DY0ZKdvB60SZIjMIgAaqea5RORh9Lyf+S
 KPTFa+0BnIlkFoCHTu6XiTVglsknI/m7kdvVomcd3NBBL/5K7CN5eMDx+FUUHO0dKT9F
 InJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYKwufbGiC2F3YYU/f/8lzBZwPmyVubiKUr9V1mY8hkbD5jGvci013/IZDZNIXIwUhCwF/06vUnW9s@nongnu.org
X-Gm-Message-State: AOJu0YwFohiE+IGBrKHZAGR5UOlqhhXot1OoRggCVXaLuZ2VGFm0nYdC
 nqOYERCXVOfoj77nFDPoMOL/3eR3H2QNTOri3JZh0FTmWN2B+TCkRXHyi9VdD1I8DiIHmkkuisd
 TKwgxi1M9ZBrD62y1aDJYANQS67b6+8c9z4kLJfUIaGpAj5PnsFe1
X-Received: by 2002:a05:6e02:218a:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a7156dc344mr45692775ab.3.1731528764458; 
 Wed, 13 Nov 2024 12:12:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFxJoj+sX5XuoC/sHhiXGuJdZWFO8AjCOVI+NtDxJjlwom9NnNM+9CVyvOX9xsxIBF0ci55Q==
X-Received: by 2002:a05:6e02:218a:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a7156dc344mr45692375ab.3.1731528764004; 
 Wed, 13 Nov 2024 12:12:44 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f987e20asm30995265ab.56.2024.11.13.12.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:12:43 -0800 (PST)
Date: Wed, 13 Nov 2024 15:12:40 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Message-ID: <ZzUIOFPtvHKDJPei@x1n>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com>
 <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On Wed, Nov 13, 2024 at 07:49:44PM +0100, David Hildenbrand wrote:
> I think I had precisely that, and I recall you suggested to have it only
> after the initial sync. Would work for me, but I'd still like to understand
> why essentially none of the "discard" was effective -- all of guest RAM got
> touched.

Yes it'll be interesting to know..

One thing I'm wildly guessing is dirty_memory_extend(), so maybe after the
ramblock is created nobody yet to clear the "1"s there for each of the
client, including DIRTY_MEMORY_MIGRATION.  Then it'll be synced to ramblock
bmap only in the initial sync, once for each qemu lifecycle.

-- 
Peter Xu


