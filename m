Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12232E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEyi-0004P3-NS; Thu, 05 Dec 2024 11:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEyP-0004Hw-6N
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEyJ-0000gf-8g
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733417096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zzdAUU5/+aiXqkJc3x0gC7S8/2cAjMpIOwlUCqs2eA=;
 b=MYx8VdrH/XR0Jl07q0k7SyQlXFh2sWMkYGlRsOeFVx1moR93nje2fdz453ZHreFWEnSEj2
 7g/VNSXJ+VCzrS336j3pULG3AQNiZ1nvdYkb4IhJeW4hZ9NQxrVOpRKQOMkMgYGlo78VEX
 rr/gAkPhcgHRTOr7CVBaX6KhaF0RTAE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Zh0VKtCMPfqRe50kUIn9Mw-1; Thu, 05 Dec 2024 11:44:55 -0500
X-MC-Unique: Zh0VKtCMPfqRe50kUIn9Mw-1
X-Mimecast-MFC-AGG-ID: Zh0VKtCMPfqRe50kUIn9Mw
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-841963a1fb4so174785939f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733417094; x=1734021894;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5zzdAUU5/+aiXqkJc3x0gC7S8/2cAjMpIOwlUCqs2eA=;
 b=h1ecIBIYWSGub3RfjxwF2wBE4InpBgQHKXDNvgcHjRD3wJvZJvkd/w+WTd49rdW8Kd
 Wc51L2A//CjteAcdw/8Ocs4xNqVEUcda7AnbjpaZGt/eDH7z7FIxQpmtr+Owr7fH1UT2
 pT29dQze8U9QZUc6mHRGpkWQD+p3TBVjaoYPM1/lfhfttZRCYYRPEut8MBrVbjn48L+g
 kBFVY+4cyi86B3gCkMjx1b48Ty6fx6hBapS6BMp4rd7i/k7DIEjnzTN+ID4mKBOvRUMh
 sPGAD7UNrkSPzjsmsFLJIECJHspKC9Z1AF800RmbpVktIWLWFH9LwPu6TbZQHMm3kvTR
 +2Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL+h9aaXyxZNq2JfsfITsj+pZbEkqjAVw9canRG3tqV7g6aUcd+j/O5lYAaXBBVRjxbSmxC92ZxwTJ@nongnu.org
X-Gm-Message-State: AOJu0Yzu5PxZL+X5bkwiMlmoBL+pqr5Ua9pSmGbjI0Wr5NZhbQl+EFe/
 uPcAY/8Ytj2PJ+FrQ+x4iG0YDJ23eBlDt4trH10aAayCrs891hMY+Rz6xvw77PvmzjoKHcLD9J/
 m95/eYqES3/YJlquUtGg3e/1Ng0UeTcY/CMbNgPKkGJqV7d+eiktD
X-Gm-Gg: ASbGncvSqcpqOvQZFCGWqQPTiEp9TmQwg2ge1rCBkMUM8puA4XL+ln+rRhDeoxWHwET
 5NkRBenY+jKyDU51b6JjyqpsaFJsfeOKgEf6P8FEHoqzZQBe+F3PLgAYI+minVe++6XtpTMTC4s
 USapLtX4bf0eERk55QYt3wdBG9FqvOI6ZQ7KbrIIsFUqvIica9Gzp+f9LtRJAh/HvmRLjMGZ82a
 6ixb1BbZfyGcBbfRYta6GaN0HgORq4+/OuCVDeLAAaXnvBGPHMwcNmA3ueUtBSP7VtsH0OFfGyb
 qj+j3O1jjkE=
X-Received: by 2002:a05:6e02:17c7:b0:3a4:eca2:95f1 with SMTP id
 e9e14a558f8ab-3a7f9a3b2demr151176345ab.6.1733417094640; 
 Thu, 05 Dec 2024 08:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH8t5v9tGkhUBl6mAD+ihVT3DrA1od5QEURLuzEs2sbfusQiQX/cxpSi4qd74QYBfuepXXuQ==
X-Received: by 2002:a05:6e02:17c7:b0:3a4:eca2:95f1 with SMTP id
 e9e14a558f8ab-3a7f9a3b2demr151176095ab.6.1733417094396; 
 Thu, 05 Dec 2024 08:44:54 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808e29976sm5030215ab.65.2024.12.05.08.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 08:44:53 -0800 (PST)
Date: Thu, 5 Dec 2024 11:44:50 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 15/24] migration/multifd: Add
 migration_has_device_state_support()
Message-ID: <Z1HYgkkVFf50-rdx@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <ca43afdc742ccf8070b1146014ce33c333e85d8b.1731773021.git.maciej.szmigiero@oracle.com>
 <75ce2d3b-9abc-4dcd-a221-48d2935715c9@nvidia.com>
 <5bb862ab-fc15-40aa-9815-2ff7381ab7cf@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb862ab-fc15-40aa-9815-2ff7381ab7cf@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 28, 2024 at 01:12:01PM +0100, Maciej S. Szmigiero wrote:
> On 28.11.2024 11:33, Avihai Horon wrote:
> > 
> > On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Since device state transfer via multifd channels requires multifd
> > > channels with packets and is currently not compatible with multifd
> > > compression add an appropriate query function so device can learn
> > > whether it can actually make use of it.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/migration/misc.h         | 1 +
> > >   migration/multifd-device-state.c | 7 +++++++
> > >   2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > index 118e205bbcc6..43558d9198f7 100644
> > > --- a/include/migration/misc.h
> > > +++ b/include/migration/misc.h
> > > @@ -112,5 +112,6 @@ bool migration_in_bg_snapshot(void);
> > >   /* migration/multifd-device-state.c */
> > >   bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
> > >                                   char *data, size_t len);
> > > +bool migration_has_device_state_support(void);
> > 
> > Nit: maybe rename to multifd_device_state_supported or migration_multifd_device_state_supported, as it's specifically related to multifd?
> 
> Sure, will do.

With that, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


