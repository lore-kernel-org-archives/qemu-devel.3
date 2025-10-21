Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ECFCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJmX-0006nw-OS; Tue, 21 Oct 2025 17:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJmV-0006m7-82
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJmS-0004tG-0J
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761081630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scawbAkwaNQVFfhaBoIaxxtzQrqcNeqSoWahcFlMXmA=;
 b=R7IUbG5AlAhdHJoCg8QKFgnjzCf1QitIqk6ADyWFmel0ujIJTpAfQHsWG25vJ1I6zEGhib
 HG/nwzQKf8zbHDuN31TSXN4BFC2lTE+DdYxqnUkvYmXL98t74TLp7ITIx2TdWzPBpG2gt3
 uwIZlqoahcdWnRLbCRg7xjfFF+DFQgw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-HBDHDcnEN0-EeNL3wQZXEQ-1; Tue, 21 Oct 2025 17:20:27 -0400
X-MC-Unique: HBDHDcnEN0-EeNL3wQZXEQ-1
X-Mimecast-MFC-AGG-ID: HBDHDcnEN0-EeNL3wQZXEQ_1761081627
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e88947a773so18712261cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761081627; x=1761686427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scawbAkwaNQVFfhaBoIaxxtzQrqcNeqSoWahcFlMXmA=;
 b=nl2bytS53PUaqxwf921P7fcxbrewTg7KuhhqiMpe4KebqLDn9+gTuuiS/2bWYbCQdD
 bi2zCeVDbX1XGT+ZtZoSHosxdQ/R0HdkdjLzj3D38xg/np389I0ME/vYU/oEyH/PMF4W
 sU5niWeCUmaD5jwLcOnh5cLgJs6uF5Xi88VBvoogfeJBgcuDdh9C0mNRZNq270yolpy1
 TB9OE1FE08LCqcZdg4nD+44gnI2FrLRfBjyY0dpewxDB7pOzaLur9z9DPjycaew/7N6Z
 +yJWkoOLFet/pJX2mC82wOVCgsK6C0tTSDSn0nCh4yADIbwTN5/ChEeQbAnwaDhxhZ38
 OqQQ==
X-Gm-Message-State: AOJu0Yza9Fq1bAxGTp4T/WzfpuSmPEo2CFKyKqF2AMGIEHsJZw5CCdRV
 EesaQmtdpnBFibzuKx3ZG7M5CYLWp4so0hEDQbeE5YIw+XOgwP3/cvNx3ANffettxt6MFonnyOT
 ump1FIEjebbISWmrcHVjDUsB9GaZo3xQdpWXb4e3pt2DA6LDg32FATL8c
X-Gm-Gg: ASbGnctopa52rAn+tV5oZRCLtJinQDPoOWbX0ZVd/jUESCzCIUDiZO8Hb4aM54pLY3V
 jBjB5J5uu0b6W8nvtJmaiV0w4RxJG0b+jymfZWWZ/m8qAdV2d6BRKNHJFfiY8tGqQproBoBAqpj
 FZmVSiPZa96BnZ9tKaQ9LzNUlj4q5fM9cK82v5ls/7c2XDs1WXOjpVO3itq6WuL03uOYJFzjOeW
 AI9pGceivmQRr9Fyu9s+aW+PmudclbzKqBCtYKv6Y7CJKGeY0gdkW0+dfXfo42lWtEpAP8tMGQ3
 aiEPQMe46at9kkB4S0ozmBbXsXX1+4UMxKxv2ZB7Y3Zo7BKoQEjSOI9ZTf8rxdjmTMc=
X-Received: by 2002:a05:622a:138a:b0:4e7:224d:30a1 with SMTP id
 d75a77b69052e-4e89d3a472emr250896961cf.66.1761081626754; 
 Tue, 21 Oct 2025 14:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKTzZuwgcjmIpbFPW+QEc0igp6ffxipsjxcFuBdqhl/625rYmI4I4qzhhP8U4psV2ZzaY1Ew==
X-Received: by 2002:a05:622a:138a:b0:4e7:224d:30a1 with SMTP id
 d75a77b69052e-4e89d3a472emr250896581cf.66.1761081626177; 
 Tue, 21 Oct 2025 14:20:26 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8ab0e7370sm81433321cf.28.2025.10.21.14.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 14:20:25 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:20:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Arun Menon <armenon@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 1/3] migration: Fix error leak in
 postcopy_ram_listen_thread()
Message-ID: <aPf5GNWuWwjRLHIo@x1.local>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-2-peterx@redhat.com>
 <87qzuwt25j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87qzuwt25j.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 05:45:12PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > As reported and analyzed by Peter:
> >
> > https://lore.kernel.org/r/CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com
> >
> > Fix it by freeing the error.  When at it, always reset the local_err
> > pointer in both paths.
> >
> > Cc: Arun Menon <armenon@redhat.com>
> > Resolves: Coverity CID 1641390
> > Fixes: 94272d9b45 ("migration: Capture error in postcopy_ram_listen_thread()")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/savevm.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index aafa40d779..635fa2f918 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2136,17 +2136,18 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >          if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> >              !migrate_postcopy_ram() && migrate_dirty_bitmaps())
> >          {
> > -            error_report("%s: loadvm failed during postcopy: %d. All states "
> > +            error_report("%s: loadvm failed during postcopy: %s. All states "
> 
> Do we want to keep the %d for consistency with the way we report the
> error below?
> 
> loadvm failed during postcopy: %d: %s

I thought the string is verbose enough in an error report, but sure, I can
do that.

> 
> >                           "are migrated except dirty bitmaps. Some dirty "
> >                           "bitmaps may be lost, and present migrated dirty "
> >                           "bitmaps are correctly migrated and valid.",
> > -                         __func__, load_res);
> > +                         __func__, error_get_pretty(local_err));
> > +            g_clear_pointer(&local_err, error_free);
> >              load_res = 0; /* prevent further exit() */
> >          } else {
> >              error_prepend(&local_err,
> >                            "loadvm failed during postcopy: %d: ", load_res);
> >              migrate_set_error(migr, local_err);
> > -            error_report_err(local_err);
> > +            g_clear_pointer(&local_err, error_report_err);
> >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> >                                             MIGRATION_STATUS_FAILED);
> >          }
> 

-- 
Peter Xu


