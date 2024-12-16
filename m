Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EFEE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFJ8-0007oQ-7S; Mon, 16 Dec 2024 12:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNFJ7-0007o0-Ab
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:55:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNFJ5-000680-Ar
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734371696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+afSfH+kaJM5EHjOmLFDofGQ5WbKp48HLxRfwG0NX+o=;
 b=hqMh306kkHGMiGY9wpkScBpwHkMwYZrbAjTKflOXraXBGnV1mAt0n02o1hRzyBtpXLadLF
 0OcMMSqmmHcDndIxhHxAl4bq+ZB+z5MeeHBhNhJ3hkS0MvS7gfFsFEWjrLo7WvQrOgqGOY
 et9cwi7xUfGLdw//4qpzeIYsrI2LgtQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Ano4NFTmNKKwj_rN6O-orw-1; Mon, 16 Dec 2024 12:54:50 -0500
X-MC-Unique: Ano4NFTmNKKwj_rN6O-orw-1
X-Mimecast-MFC-AGG-ID: Ano4NFTmNKKwj_rN6O-orw
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a9d303a5ccso89393955ab.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734371690; x=1734976490;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+afSfH+kaJM5EHjOmLFDofGQ5WbKp48HLxRfwG0NX+o=;
 b=UmHJrYXnxCYZzqgSkc7jR2YAMHmvAgIzDuguwUd2baGbE+sdIN/+wr7cOST8eNV3rO
 vSBZHeuJluecBKxFS/oDlFpuRDbJ3OJDpjXJGyr5pxWeIDdFPnMYPHtfYpdTVumq5bpy
 J6EKWczVADAtLM1YGSFrYvbVIeJPi5j0SLGzswhxCcGFhOi2DqrNrDNjHUkv+iTgBbrd
 dttnoGaN3ocOKmWVc9jMv4RUpoSOFtRbyg0YO09FEiCL1O1JUAqyXh+zGHLl13CQh1Nm
 JbB4CEv+unsdQA/tL0Wk9vJBcoDghjHuAH4B3iz/Qtxa+nxX8/IFbp1F8o2yOAgWcxQC
 NbvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuLKKuSWXz1vvHBndN1szH++/EyrXWAFT9jaoVY6pBfGLfEdzU/S4eNtneJyXTSofglfbn0Iq8DLi8@nongnu.org
X-Gm-Message-State: AOJu0YwZi+O+UaLhVPGzchr+RaJ6q+F89dj7oWa6EmGnA93LBn1dLv0w
 Oaaz3bQSHk3HjUF/SjrSEbO/rCpmtssAGFAfGz09sNYRIY8u/eObTWpUhhcDyrKK2TFxlSkUbEk
 aaTxIqeG7LKg/2BO91wObzBk9UMyipYmFbNQISvHIBlSGo/p4wEnB
X-Gm-Gg: ASbGncvhwQP7Mt64v998VMiLndz8883qT0gew0sqaLaVQxMKhczQiXQ8UvC6pcvVG+j
 RdNfqKJAaqZnWUwr7pDXnu7+yLxWNUvL0FeZicx3tXLdM6Y86XUHV0drlgUh9JSaIxRaErHwFNP
 CYpj0igpktfAoonxVCuCJeEV38KGdJ/riD5ezSYdU/Zeuphk/aL6T1XNt1HS12Ydac1OVnSnnd+
 poJlFx8XKUItp7JyH9c4J/QtS8n/pdXw1RtBriV0dkuScMMKaowNyRQTOkvXPgi0nUFrrE1chVs
 tC3HiRTugKsyVw5caw==
X-Received: by 2002:a05:6e02:2407:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3aff7f16c74mr129322955ab.17.1734371690160; 
 Mon, 16 Dec 2024 09:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMSfYt16ya4/iZsZiENyJDI4z2PWjCCgoXX0X8MeKn7iYg6oKQpgG4sbl7qAeT9JsJbswKVg==
X-Received: by 2002:a05:6e02:2407:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3aff7f16c74mr129322745ab.17.1734371689814; 
 Mon, 16 Dec 2024 09:54:49 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e3782406sm1296050173.121.2024.12.16.09.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 09:54:48 -0800 (PST)
Date: Mon, 16 Dec 2024 12:54:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
Message-ID: <Z2BpZ-Re8ctQPQiC@x1n>
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-2-peterx@redhat.com>
 <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
 <Z2BfhvPfYNYoHA5Z@x1n>
 <CAPMcbCq6bU_L3xgj1tC9hDpDSG5_ppHgxRYO8qww49PSAGdCWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCq6bU_L3xgj1tC9hDpDSG5_ppHgxRYO8qww49PSAGdCWg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Mon, Dec 16, 2024 at 07:28:19PM +0200, Konstantin Kostiuk wrote:
> On Mon, Dec 16, 2024 at 7:12 PM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Dec 16, 2024 at 04:56:33PM +0000, Peter Maydell wrote:
> > > On Mon, 16 Dec 2024 at 16:14, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > QEMU uses g_mkdir_with_parents() a lot, especially in the case where
> > the
> > > > failure case is ignored so an abort is expected when happened.
> > > >
> > > > Provide a helper qemu_mkdir_with_parents() to do that, and use it in
> > the
> > > > two cases in qga/.  To be used in more places later.
> > > >
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  include/qemu/osdep.h     | 7 +++++++
> > > >  qga/commands-posix-ssh.c | 8 ++------
> > > >  util/osdep.c             | 6 ++++++
> > > >  3 files changed, 15 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > > index fdff07fd99..dc67fb2e5e 100644
> > > > --- a/include/qemu/osdep.h
> > > > +++ b/include/qemu/osdep.h
> > > > @@ -828,6 +828,13 @@ static inline int
> > platform_does_not_support_system(const char *command)
> > > >  }
> > > >  #endif /* !HAVE_SYSTEM_FUNCTION */
> > > >
> > > > +/**
> > > > + * qemu_mkdir_with_parents:
> > > > + *
> > > > + * Create directories with parents.  Abort on failures.
> > > > + */
> > > > +void qemu_mkdir_with_parents(const char *dir, int mode);
> > >
> > > Don't put new function prototypes into osdep.h, please.
> > > It is included by every single C file in the codebase.
> > > There is always somewhere better to put things.
> > >
> > > QEMU shouldn't abort on things that are kind of expected
> > > OS errors like "couldn't create a directory", so I'm
> > > a bit dubious about this function.
> >
> > That's what qga/ is doing right now, rather than a decision made in this
> > series, though.
> >
> 
> I think we need to fix this behavior in QGA and report the real error,
> instead of wrapping the `assert` into some function that will make
> it not so obvious.

Even if we want to do that, we can also do that on top, btw.  As this patch
is as simple as a cleanup to dedup two chunks of code.

But if this patch is not liked by most from different angles, we can simply
drop it.. together with patch 2, as in my previous reply.

Thanks,

-- 
Peter Xu


