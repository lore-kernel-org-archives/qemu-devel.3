Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC29D1171E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 17:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQUTD-0007KY-2J; Tue, 02 Dec 2025 12:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQUTA-0007KD-IK
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:47:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQUT7-0007JD-O8
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764697635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P40SSjVIxXYkrKP72DMJy2KN4DBYdVQvvv935TwX8cQ=;
 b=dTstyzFxy9QipTfVcR1J2MZqs9X84dfNIyM8aXzKPeUuukZ6vReEuHH6gtkX5oKHvdXQ4+
 coCH9dIgkL8Xl84ZUVopPlZFsE5iDdsWVQyU18eTyHaEJB/u3bjRHT1z5+ehiOKzpQyYzg
 WC9pyEE2HpzGPtNQrNKFKUld3/lczrE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-FUzkvYe5Po-doh0J6VeXtQ-1; Tue, 02 Dec 2025 12:47:13 -0500
X-MC-Unique: FUzkvYe5Po-doh0J6VeXtQ-1
X-Mimecast-MFC-AGG-ID: FUzkvYe5Po-doh0J6VeXtQ_1764697633
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b24a25cff5so1053211185a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764697633; x=1765302433; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P40SSjVIxXYkrKP72DMJy2KN4DBYdVQvvv935TwX8cQ=;
 b=E8uSoVR7BF3YKpiftzug8VebowH6niAj12FkD3JdMC12lsSFEjH90hdPH45xNMJEPe
 Ba3lPt4CaCido2keQeagDOpUcVDIF5cYh+gBBYkFyxCboceYJ1+ZvYhQWUgD4E6uljeD
 M9NFPlHHVob8X14/EVe8Cau86T+rUMtOPQG2I2eBdl95y1t6m7aLZnZHQ0uMR3POWrq8
 DU8Q3T4927p/OkBwi5Lj5PEf9QK1Xo+sjpiA+92AFPJacLrQQLhDBSzQfBO07iyikOP/
 8of6o/Kvd2eWea2AjgrQel6Dxh/2j02qI2GgRFbuaSiYnIIJURGOmEsBB6XRMIi7l4gA
 4gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764697633; x=1765302433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P40SSjVIxXYkrKP72DMJy2KN4DBYdVQvvv935TwX8cQ=;
 b=wWU+xWFnV/+CcFwEcgBzTBCFwk5R9CHytmZ8y+i9qbP5vpqIPnWUSngys8NSR5FGgw
 enkwFySk64/L+EjyX5pt01jJUtCrslpSS9K3MmdU27WLeTi4L28jc5Wl5LGhaVGsZIMj
 uN1vIOMMN1vAzhQltsNg3C35M0Ep0+HVu+hYiW7GUQx3gQ5sXj0fLJIfIEX5zrqV4XLk
 i3atwET11Gtk7aONRTpD9kDuTumHdFqXNgl7SiDIoT2OxzoTG/LPFNeG7TvhaOwxrJVw
 Tg9/HybMHRsMXXL7jP1bnyssqJ5oichlquiR7Q6fIn60qlC0ps5DJJoypWKbcXGDO0v1
 3BjQ==
X-Gm-Message-State: AOJu0YyhkKPFaqUp7KmljcYNGwQOhLCZYVGTWPrAB8f1hsq699V9wNVt
 6Yy57R3/fnUVpwlWNA2lj2v/U6wUOG5Ou7YowbacG9D+06xfZM62B+VBYOZv5uaioVB+hU2SUo/
 LdKw43cxtFd48Ny0P+EClM4grpxjADy35jL5CcS8BAUy9ldGSou13Zxez
X-Gm-Gg: ASbGncuNs7ZSRkZzgJAH4Wo/vpK7L5mjEW/ayQn0qrt5T1aS3o3F+tWSLzNKJSt3HDc
 IpyRrffoKXpPQZ1QIzNu9pn+2oc9CBb0jgWNR3MsrbkIIRU00ANhrdItr65tDcY5WPzB2DduKbL
 NncjQSGIb1wAH60rP1MgMTVHCSvx+tI1Cq+gaOHbPGhVtLA7q/vPXIfqIEeOhiulq6KuI+CBhlr
 3LyVgILRWDss3xvwyPs+YcMJGZAtGy45WGcDLaJyIuEEyaOD39hskAzoaX8bqZnOKrkhLZ+L36q
 GMG/RJGZbQbvh8cGeN1ZczVK7GAqq0jNMn2kRJ+vHpodZ0qCUX2rgckTestiI6UiAZczXcGh9SY
 B8r8=
X-Received: by 2002:a05:620a:4041:b0:892:526b:fa6f with SMTP id
 af79cd13be357-8b5d2f2a958mr33050285a.71.1764697632569; 
 Tue, 02 Dec 2025 09:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrQVljEihox56P3Zo9ac704IuNwdNvBow4v3u1uyMcSLvbU2C7qmqWSOllZm8lZa1uyjawDA==
X-Received: by 2002:a05:620a:4041:b0:892:526b:fa6f with SMTP id
 af79cd13be357-8b5d2f2a958mr33045385a.71.1764697631984; 
 Tue, 02 Dec 2025 09:47:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b529993ca7sm1128871785a.9.2025.12.02.09.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:47:11 -0800 (PST)
Date: Tue, 2 Dec 2025 12:47:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH for-11.0 v2 0/7] migration: Error reporting cleanups
Message-ID: <aS8mHgyDsKSfAB-S@x1.local>
References: <20251201194510.1121221-1-peterx@redhat.com>
 <877bv5aszr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bv5aszr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 02, 2025 at 10:55:04AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Based-on: <20251125070554.2256181-1-armbru@redhat.com>
> >
> > This series is based on Markus's recent fix:
> >
> > [PATCH] migration: Fix double-free on error path
> > https://lore.kernel.org/r/20251125070554.2256181-1-armbru@redhat.com
> >
> > v2:
> > - Added R-bs
> > - Patch 1:
> >   - update commit message on s/accidentally merged/merged without proper
> >     review/ [Markus]
> > - Patch 2:
> >   - Added a new follow up patch here from Markus to poison Error's autoptr
> > - Patch 3:
> >   - Rename migration_connect_set_error to migration_connect_error_propagate
> >     [Markus]
> >   - Add comments in commit log for both migrate_connect() and the rename
> >     [Markus]
> > - Patch 4:
> >   - Rename multifd_send_set_error to multifd_send_error_propagate [Markus]
> > - Patch 6:
> >   - Make migrate_error_propagate() take MigrationState* as before [Markus]
> >   - Remove the one use case of g_clear_pointer() [Markus]
> >   - Touch up commit message for the change
> >
> > This series should address the issues discussed in this thread here:
> >
> > https://lore.kernel.org/r/871plmk1bc.fsf@pond.sub.org
> 
> Thank you Markus for this. It's very helpful to have someone keeping us
> in check regarding the usage of generic QEMU interfaces. Migration code
> tends to drift incredibly..
> 
> >
> > The problem is Error is not a good candidate of g_autoptr, however the
> > cleanup function was merged without enough review.  Luckily, we only have
> > two users so far (after Markus's patch above lands).  This series removes
> > the last two in migration code and reverts the auto cleanup function for
> > Error.  Instead, poison the auto cleanup function.
> >
> > When at it, it'll also change migrate_set_error() to start taking ownership
> > of errors, just like what most error APIs do.  When at it, it is renamed to
> > migrate_error_propagate() to imply migration version of error_propagate().
> >
> > Comments welcomed, thanks.
> >
> 
> I think with this series we could now work to reduce the complexity of
> migration_connect():
> 
> The outgoing code in socket.c and tls.c could call
> migration_connect_error_propagate directly so migration_channel_connect
> only needs to check migrate_has_error() and then exit as early as
> possible. From migration_connect onwards we can assume connection
> success.
> 
> What do you think?

As long as you read commit 688a3dcba980bf and will manage all those, it
sounds like a good thing to try.

> 
> tangent:
> (is it too much bikeshedding if I send a patch doing s/migrat*_/mig_/
> all over the place? it's so annoying having to check the code to get the
> prefix correct when writing emails)

From downstream POV, it'll be a slight burden whenever we need to backport
later patches to "the world before the rename".  It's not a huge deal but
we should consider that.

I'd confess it's likely the best time to do this if you want it for
upstream POV - we don't have a lot concurrent projects ongoing, so if this
lands it can be in the 1st pull for 11.0.

If you have some "vibe coding" tools, maybe you can spend 2 mins to see how
it looks like and decide whether to send a patch.  I would say don't spend
too much time on this (while you're still keep rebasing the options series! :)

-- 
Peter Xu


