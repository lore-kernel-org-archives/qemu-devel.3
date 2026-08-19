Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB14C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlWH-0003Hs-8b; Wed, 19 Aug 2026 15:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlWF-0003HS-8X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlWD-0000Ry-NA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787166008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6eoQEeLN9JJZVtYFymbMxT1he09S/kVH3UQ9udyBrw=;
 b=OSXmc56W8bAxlJpAKk6Px3O7N6nmCeGKcIT0Z0Fdib0ph+/KOaBOGqQoyEucLsQgkSD0Fj
 VFiHLTRqcirdO/e4zlIBSq0TlG1jj6IcdWFjnty7m80ifm9Gg9bOlX8zJCHs0eKs21IaTW
 Cb53/z2Tp7aopGXZzqhuw8qb2fbuJIg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-Teks_Pa5MiKF7hnnDU3AmA-1; Wed, 19 Aug 2026 15:00:01 -0400
X-MC-Unique: Teks_Pa5MiKF7hnnDU3AmA-1
X-Mimecast-MFC-AGG-ID: Teks_Pa5MiKF7hnnDU3AmA_1787166001
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f113592bf3so25823656d6.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787166001; x=1787770801; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y6eoQEeLN9JJZVtYFymbMxT1he09S/kVH3UQ9udyBrw=;
 b=QD60eVjZ0rYVVnyoJyls54Xpg+MDvyS0rnvSBcpDapCEcslpeQpmUDIy/NPWlD+s1B
 oFF6V7NuZ1Rq5A/PwGoZdFgy2KIFCV2IbYmPATjNmh4A/fMOJEgsQfm9pofiFy/MAoke
 uHaua/Fg9yphG9VP7Ri5TnJroqshW1M9oGhy8Te1vm+rSmtD0cLsDg1u8oU3KuXcj/NM
 3MHeY78mWXHqH6Tjv9YalimCvt7Kox9xMqX2qcVECZzQzYb0E/hG0u712VwQZ0aqOgDn
 xWcaQbpS/FtmBcht2qqScWCp2NKJbK6vi38pWYKCnZqEyhL6OZE0j11CS+b6dBeaR0dp
 kQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166001; x=1787770801;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y6eoQEeLN9JJZVtYFymbMxT1he09S/kVH3UQ9udyBrw=;
 b=axGns7i0gEUsr4g9YmtJLkU1iooH2KUAQkAchk2V55GAbUeKgl2HG5qrwWnOk0msIx
 6w1M7b13vH3aiYJ3XhJgSt2F8DqN2H5aqW94Qs7Y53pgWMmtZzmS+CQBSffsuAYSy793
 I8hnfLkVITSLDH3BJsxxIJDXkvIrEHFp7v5IJWKQJmwFbUe2qhrrqoaeLaBqBBCclJeD
 qWQYCzK9x1ZtYCAVk8mBLWwE6mpfrktVAyqS6dNso2eZT6pkk/zT2dVMgSr3jcSO+kEF
 FJ7iiyGuJuRJyLblUKrhOanAEzglojeCG9rU+5tXGbiJ+8onjt5pdWhjA4DWHzHjS2E0
 mbtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRarhv/Cm8juUgM5QZFKQA3i9l26i9Ls6zPo/PsuN2vlcg/Z4bPfTKTDX4kHI+1Oe/c/QaH5fgROlU@nongnu.org
X-Gm-Message-State: AFuF++lpVIL0JMVXYKKEWbbKUSeZESTJVKHawx3bK5m19NiJKlpYkSpW
 ft4rAmgG+iEBlp2UMFameWFkFjNQ+WnELJPaq9wfY1sTOXz632/Jhc1EYIjJKsy7BBxYsfKdklD
 Odur1/Se9qbmKKbO/3rJotR8Aa8Ia3f0mVJWHbaqY9nOvdn1pIPdbDT/t
X-Gm-Gg: AR+sD12ybeWBsJ53yR1O0lDNB8F7mMrPE3hCDttr6KzDytVLmPXHMID7Xb9rOHg14JR
 +vEIIrSLteq1Yxm2pzajD3ossnjKcY4F9uP59uSllVaIjLWzG7vnURet1v4pxSpsCOr4HjqQm4h
 hsY0eIge7tQBQhSUQ0WPM2f9LDRk7PI64hFKDrS/n7wKsnFBxP1fCThb/hWNyAsa7vxvAXWWEe0
 eL3pnKEjMP8+d++o19XWEvHjiAi+RGQ3Gp35ZqEPQLiPFl3QZ0/Li0R9z6OYTcpp3fAfVIcjBk6
 zt0+YVAjLh/UASlCLCpxW+i6T0GxWL9vASzRgarA/iLb4exBWmesSJ2mZNmaM5DOXn2N
X-Received: by 2002:a05:6214:5b86:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-90c5eb1e052mr70127176d6.23.1787166001007; 
 Wed, 19 Aug 2026 12:00:01 -0700 (PDT)
X-Received: by 2002:a05:6214:5b86:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-90c5eb1e052mr70126686d6.23.1787166000398; 
 Wed, 19 Aug 2026 12:00:00 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b5c7dsm20987806d6.47.2026.08.19.11.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:59:59 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:59:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v21 12/16] migration: check that transfer is UNIX socket
 when "local" set
Message-ID: <aoX9LJi0dXOnA2Fy@x1.local>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
 <20260819180201.1970193-13-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819180201.1970193-13-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 19, 2026 at 09:01:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> As documented, for "local", the migration channel must be direct UNIX
> socket connection from source to target (except for CPR_EXEC mode). We
> can't check for it being "direct", but let's at least check that we deal
> with UNIX socket.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I slightly prefer sticking with socket_local_address() to avoid invoking
the syscall directly, but I understand your point, likely about unnecessary
allocation.  It's OK too,

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


