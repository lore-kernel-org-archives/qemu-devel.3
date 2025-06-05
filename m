Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7DAC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 20:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHfQ-0000Io-F7; Thu, 05 Jun 2025 16:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNHfL-0000IQ-Qc
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNHfK-0002Ho-BU
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749157100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVCWZsfJfKBSl9K1qAhBAXsdnvBBuUTW1UdVE2Kn/mw=;
 b=X8iy7CitDB2BopEOnGTQ34kiV+K1fh/2+2iE+jD7AUdaG2wEuCQx/ku6qGC+0+/J8LwxPj
 JBDVtQDgpXguQhpqQ2CE/6FcO85iscfQAsL+y6oRets9mkCVGh4IxmkttKGyORfCT8XUZi
 fDIL7n0q8CGJDqYIkTVZ5zgmqZQVUQI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-vwnNKyyzMXuENWH-JiZrIQ-1; Thu, 05 Jun 2025 16:58:19 -0400
X-MC-Unique: vwnNKyyzMXuENWH-JiZrIQ-1
X-Mimecast-MFC-AGG-ID: vwnNKyyzMXuENWH-JiZrIQ_1749157098
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c7c30d8986so403956585a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 13:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749157098; x=1749761898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVCWZsfJfKBSl9K1qAhBAXsdnvBBuUTW1UdVE2Kn/mw=;
 b=k0gzgh2NO/3i62z7QKNlFIKEwQ8yG3f8BUBRh0yt9n8u6rRW7N/ePF/Dn/F0cCTw1Y
 PiFtLSqlEv402bn3zOM8xdd/NeI+TiLa0XTMl2AEPM+EGGMtSTSEHMLcj63dxoUr51HU
 dCL4AszeaX2COcYuGNsLej1GvLstN8ZJVZfrgYWYxrDlWrS1jl3ioxTy2i9f/tHEnfVO
 OGQwFnLidsQ5CdebLW3HAmtrhExGpGJwY+fbXI+/8F2hl/N4MVOTWJNr9s5JtwvOFkXN
 vbGwQjtJPlURDiG8eam2lg6aunz7RkSU2j6nNsfsYvN+Qz1m/FeWRC+IQI5NlqARPbqA
 46bA==
X-Gm-Message-State: AOJu0YwRh8j9KJrsv3WsFsphcMOHUwgfD86SNHR+3t5KJL7DnY0JteH3
 BZ9MWwV3AH1LVD8WgJ7NMroyjVFKovhxf/zAp3GLcxeWfyl/kAAXscjoNtdLXl9wT0ZyYp7PhDv
 2kw+kIDWUi/eQyhS6vHDyw2FDzFRuAy/PuQuSTWnPwoYuhmiKI8WjgA5B
X-Gm-Gg: ASbGncuVxrwR97Ogxz2IVSGIexS3vCWnCs5g9dS4ajo3/J7cFp0Kh3pKFTqFLYH3B3C
 Fv1GzCQNNv+fTqE1Wz+cvNAwmcj71W++LocEGoqWJ0GOvkIoCrBa42zQqjh1ojBT0LYA+vkWzNv
 8ikZozvUBnQjMX/3VJX2eovfBMd+ASoUCIyQxbmJYxTnkAC0F1NGOGnw+kMJRXFVxtdcQ0TeoEl
 tUMxBHG38sP27C0cSTAZdepIjlzh/Ql1WUO7CMoRc2iSXcPF7y+fv71wBHixO9GHxK02SahNAYC
 irITNoXM8794gQ==
X-Received: by 2002:a05:620a:2894:b0:7d0:9909:ebe9 with SMTP id
 af79cd13be357-7d22987fdf0mr172780485a.20.1749157098627; 
 Thu, 05 Jun 2025 13:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3sptOuPWpwgi+S1q2/5Ell21wS4AbULxGr51Lzii/idlrkpNtZ18RwY6ZyHHGyqWaeIS55g==
X-Received: by 2002:a05:620a:2894:b0:7d0:9909:ebe9 with SMTP id
 af79cd13be357-7d22987fdf0mr172777885a.20.1749157098308; 
 Thu, 05 Jun 2025 13:58:18 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b2a276sm448096d6.97.2025.06.05.13.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 13:58:17 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:58:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 02/21] migration: Remove MigrateSetParameters
Message-ID: <aEIE514VCBhytbgu@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 02, 2025 at 10:37:51PM -0300, Fabiano Rosas wrote:
> Now that the TLS options have been made the same between
> migrate-set-parameters and query-migrate-parameters, a single type can
> be used. Remove MigrateSetParameters.
> 
> The TLS options documentation from MigrationParameters were replaced
> with the ones from MigrateSetParameters which was more complete.
> 
> I'm choosing to somewhat ignore any ambiguity between "query" and
> "set" because other options' docs are already ambiguous in that
> regard.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

It's like some wish is going to come true..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


