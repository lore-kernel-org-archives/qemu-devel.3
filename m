Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52363D767DB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 15:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6WtA-0007WW-Kk; Thu, 31 Oct 2024 11:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6Wt6-0007U7-TO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6Wt3-0001hO-Ru
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730387700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+2RgRCMsLXEZ91EIrYaInPbo6yFVhrE/6NPOwPJMfo=;
 b=WGMcTHehLvwCayyXJg3eeesz5M80Wxrz5ZPoERYlYHMwYpyZ+VbS/hysWQ5lX38PIs4CIk
 eiUSsjdZS4hxHmMXyGfk2Fs3qojIro98R2vQ/GNfntNf/swYVr7IPt2VpAWhrOmp5hMGlK
 Px8rfvoXKQoZbQlDvn8vXpIRqOvJJ74=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-YsoDrCbdP3iwVbl_3aOLMg-1; Thu, 31 Oct 2024 11:14:59 -0400
X-MC-Unique: YsoDrCbdP3iwVbl_3aOLMg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b19e18cc0aso184678085a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 08:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730387698; x=1730992498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+2RgRCMsLXEZ91EIrYaInPbo6yFVhrE/6NPOwPJMfo=;
 b=p6w8zJWm/6ARA8sdBWKStJEJO5B/zgafIXY1AG/NHGglb1n86h5BI9a8QajCLXdW1D
 l6fFR9ptkEikztpXlcYniKX+uwYUeEF5esqYJcKBL9a8NMA6CKqknNeCwpeUST7fEUfO
 8nf86cSY2X17vqxexDogbqCS7N79+uxv/tz/udNcHVn5hfFoYCOdN5pdRfHFBW4SpimW
 7Flxtik6R/9GIZeX34lT8lIPw/7WBxiwp0Pg6R0gY4YrpB1A11uJYSbsf+TKzqJQSf8r
 aLmipJtbKVbhhXFO48YgLpnw8DLjEmhLXIjUqO2cn0teMm86SnHqNjHbFn49V1qCijcP
 XyZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcp2p6oWq7PDGWG6MXaTXNVx0T5ZR2ocreTv1dVaN8qwXgLJATlE9hObNwDYZsoUY1hzP1RFZr6Siu@nongnu.org
X-Gm-Message-State: AOJu0YykMFOpShY/ipLNOzhwn8RQ4fRjYW0zlKnjbf6q3ThHWRYt62N/
 bmJmGXmg2qGP320NQGqqoDTNzI1aGcOEj+7C8QF2pGqjpn5OgICQaKFsGYPpjx2U3B+5zukMj/H
 OPsiq/33TGlfRCG3p12A+GexK0p7p/t7ppE/1TtqfUa6+w7lQ/fBN
X-Received: by 2002:a05:620a:40d6:b0:7b1:7838:940f with SMTP id
 af79cd13be357-7b2fb9896b3mr1565885a.33.1730387698426; 
 Thu, 31 Oct 2024 08:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8PJsu1SiZYli25B5aFtCoviWaQTvNrx1S2uVulZKYNPjOriSCNN3ddesdZqPfUSaaOUsazw==
X-Received: by 2002:a05:620a:40d6:b0:7b1:7838:940f with SMTP id
 af79cd13be357-7b2fb9896b3mr1561785a.33.1730387698038; 
 Thu, 31 Oct 2024 08:14:58 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39f8fffsm77709685a.29.2024.10.31.08.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 08:14:57 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:14:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/18] Migration 20241030 patches
Message-ID: <ZyOe6RJyWSlx0awf@x1n>
References: <20241030155734.2141398-1-peterx@redhat.com>
 <CAFEAcA_p+LiT6wz2UaPBUs14XBnuCM9x46piOLSJP6WivMMbAQ@mail.gmail.com>
 <ZyOZTDUB-GfyRYo9@x1n>
 <CAFEAcA-HCha9cnKvB8Xh5bQMspcEeyYr65i__MCg=2OsYdH9zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-HCha9cnKvB8Xh5bQMspcEeyYr65i__MCg=2OsYdH9zA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Oct 31, 2024 at 02:52:28PM +0000, Peter Maydell wrote:
> On Thu, 31 Oct 2024 at 14:50, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 01:28:31PM +0000, Peter Maydell wrote:
> > > Hi; this fails to build on macos:
> > >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/8237753019
> > >
> > > ../ui/cocoa.m:40:10: fatal error: 'sysemu/cpu-throttle.h' file not found
> > >     40 | #include "sysemu/cpu-throttle.h"
> > >        |          ^~~~~~~~~~~~~~~~~~~~~~~
> > > 1 error generated.
> >
> > Errr, cocoa.m used cpu-throttle for Speed feature.. so it needs it to be
> > exported.
> >
> > Luckily cocoa.m is only compiled in system_ss.  The simplest fix so far is
> > to only move cpu-throttle.c, not cpu-throttle.h yet in the commit:
> >
> > "migration: Move cpu-throttole.c from system to migration"
> >
> > Fixup patch to be squashed:
> >
> > ===8<===
> > From 68515db81e28832cbd24b1cdbc12aeb618c9de54 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 31 Oct 2024 10:37:29 -0400
> > Subject: [PATCH] fixup! migration: Move cpu-throttole.c from system to
> >  migration
> 
> If you're fixing up that commit anyway you could also fix
> the typo in the commit message: s/throttole/throttle/.

Will do.

-- 
Peter Xu


