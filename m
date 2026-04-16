Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A093F8D762
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDRK8-0000C3-JA; Thu, 16 Apr 2026 14:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRJu-00009l-Mx
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRJn-00027k-LV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776363596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLRJRBioMpMNJiKqNQXQmm873F/Td60HS+WfJHVay04=;
 b=JyG0xcydv9rQyyiVRcfEs9REirxW2dfMmYN6tCPSEEKJmsE3ZAgVi9K27LaH/lv99S8Ih/
 VeusqjIOneW+PtB5+jePiRnV2A06KGXVkGOfsWzIFQjyZ9CdlfcMICIUeBKa9DdpPNfgrF
 Txqe8+wGWCdbh+E6dXHazppQcXaJ7lM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-X94mV-iTM12CjPbbpJvMrQ-1; Thu, 16 Apr 2026 14:19:54 -0400
X-MC-Unique: X94mV-iTM12CjPbbpJvMrQ-1
X-Mimecast-MFC-AGG-ID: X94mV-iTM12CjPbbpJvMrQ_1776363594
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acad256115so144638626d6.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776363594; x=1776968394; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sLRJRBioMpMNJiKqNQXQmm873F/Td60HS+WfJHVay04=;
 b=T6HcHeuHoNAqPYRdiedley+ZHuPlgs2g74P5TS2/Dws/1sfNISwVcynh4VaRRCAWPV
 T5DVcmX5N+5jlof/BhzWBmNf1erxfgQAoqgIj3eDXz4a1RrCFpMiQqJxhw1xNJcPYj8V
 nQHu0ErRWTv7yTBbeYljGWQPjD1O5+t89EYJScvTR13+ZvhLQBtRc4SXPBeJpOnqrgD+
 CW/0Ey3KFj9IMpb8+QPxHave2IdBavNjRPfQe8T5XcEdytrUr/zG3GVKqlNxrjqQWSiy
 80Eh/1BwSN/EyWJ34DDC3jrgDR0kMBoGPRDY4Enu44JozBoZi18x7bysM5zxLNERoGZK
 zLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363594; x=1776968394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLRJRBioMpMNJiKqNQXQmm873F/Td60HS+WfJHVay04=;
 b=bPijPSfjefiectNOoGEBjpYzub0EcQl0Mkdr5T4UCjMp76seiU4sqKf13nFilXzY5s
 Ye6+VfBgSvtkIQq/zUE3UQabI0Lay5Q9TNhkXBVx14fLSR1Dy/BleizB5Z2k2zBg/mY7
 2hrZmO+WtgTgupmO4EZSSDUTWH9sPvaADgPcgH+Ck0gBbq6z4Enj0onOSoOoxz2N2RUT
 ZD87vhsE8ZMNXYp4SQYS5Wqp6wSdaKbi0U/3DPjvKJHvJ6t3GfN19zdjZXQc0Js0CBlo
 4niXMwQwXa64rOIQvsObsuuKmHryWLgLU/T8Dp//8qQz/Y0oALqdg7MbEB4FI43Ym1sM
 pV0A==
X-Gm-Message-State: AOJu0YzUyFvhPUKxzGoOTDn8Wn9KqVJfRMvvJh0Mj6pTnopDyGuiHXbQ
 wO7XCLChDTyGuW+Zu5NaaMfT3SPRw5SMo/gcFqZqTq3fP7XGpymUVDZQF3jZAFP6XpJoAdWZSsq
 ea1lYWFU+SEyd9JFe4IO1oF5c+xTnk8RrQcMicMFWoKB/3prniHPwALio
X-Gm-Gg: AeBDieudhw6J/FjJaSaksQgdbtMnBCT/GHFkWUaNRJbwlYOuJsstqc8IYXPxMOSdjrs
 cA+68WZqtZHPjoIyF7BObYS26ks17tIjPV1knAVEBXNdXWhAZDr+8Z90zcSa9493YsrSwbIbh/l
 hNoCbEFyZYWdUvptCf3g1g6en6gCJOvVvJOKTEZ7CUz4K+NTnnIVeX2b9QRHyu3dWCZ6WiZL6LI
 yUWF74DTiPOUHjnOIRRABVPCiVLiw2Ja3m4tlZeO8Ak/GnK1HLNX3s2/aakB3MICPLUeS3wh7/P
 3hAY4TrcyD1AXLSe4nL6JWE5BnJ36QwArUxwbITgiBb7CC64VhCcd3NOX2/m6/LcWroe0dxjOv6
 J2kzUzHGeUzW2Pd3Y8S5Cv6g80XZxrwJrYvaJV4wtbYdBly6El/b9otPAYw==
X-Received: by 2002:a05:6214:4c8a:b0:8ac:b2b2:b2f0 with SMTP id
 6a1803df08f44-8b025db7f10mr5070276d6.1.1776363593922; 
 Thu, 16 Apr 2026 11:19:53 -0700 (PDT)
X-Received: by 2002:a05:6214:4c8a:b0:8ac:b2b2:b2f0 with SMTP id
 6a1803df08f44-8b025db7f10mr5069766d6.1.1776363593397; 
 Thu, 16 Apr 2026 11:19:53 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c96a165sm43840166d6.15.2026.04.16.11.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:19:52 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:19:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 12/14] migration: Fix calculation of expected_downtime to
 take VFIO info
Message-ID: <aeEoR2mMRqiOpJqP@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-13-peterx@redhat.com>
 <87y0iv4w3b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0iv4w3b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 09, 2026 at 07:17:44PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > QEMU will provide an expected downtime for the whole system during
> > migration, by remembering the total dirty RAM that we synced the last time,
> > divides the estimated switchover bandwidth.
> >
> > That was flawed when VFIO is taking into account: consider there is a VFIO
> > GPU device that contains GBs of data to migrate during stop phase.  Those
> > will not be accounted in this math.
> >
> > Fix it by updating dirty_bytes_last_sync properly only when we go to the
> > next iteration, rather than hide this update in the RAM code.  Meanwhile,
> > fetch the total (rather than RAM-only) portion of dirty bytes, so as to
> > include GPU device states too.
> >
> > Update the comment of the field to reflect its new meaning.
> >
> > Now after this change, the expected-downtime to be read from query-migrate
> > should be very accurate even with VFIO devices involved.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration-stats.h |  8 +++-----
> >  migration/migration.c       | 11 ++++++++---
> >  migration/ram.c             |  1 -
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> > index 326ddb0088..1447316802 100644
> > --- a/migration/migration-stats.h
> > +++ b/migration/migration-stats.h
> > @@ -31,11 +31,9 @@
> >   */
> >  typedef struct {
> >      /*
> > -     * Number of bytes that were dirty last time that we synced with
> > -     * the guest memory.  We use that to calculate the downtime.  As
> > -     * the remaining dirty amounts to what we know that is still dirty
> > -     * since last iteration, not counting what the guest has dirtied
> > -     * since we synchronized bitmaps.
> > +     * Number of bytes that were reported dirty after the lastest
> 
> typo: latest
> 
> > +     * system-wise synchronization on dirty information.  It is used to
> 
> s/on/of/ ?
> 
> I can fix these at merge time.

Thanks, I'll repost and fix them.

-- 
Peter Xu


