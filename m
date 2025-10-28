Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63056CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcY1-000640-OX; Tue, 28 Oct 2025 01:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDcXz-0005zG-4q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDcXw-0003Lv-IY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761630421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjYjUVdz0I6ghKZKvyB9s6ubfgqWF4aJ+zXIpAp5AvU=;
 b=hXbLqL0tqxeMYBDvKS829reU8MLY3LsO52heIo9TK7YER42pGxr24gv+FL94RQ6tLsAL6s
 kgY9jww//Ucb88NN5xLqFqaJCEVDugZgwd3r/P55SqV6smuW5wqgaHRizTFC+QKYd3lRgJ
 vEkmfKgKvThOx6U+RYYBs4n5IGGxcdQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-BDB_Ut1PMJS9w2fr6Ti91Q-1; Tue, 28 Oct 2025 01:46:59 -0400
X-MC-Unique: BDB_Ut1PMJS9w2fr6Ti91Q-1
X-Mimecast-MFC-AGG-ID: BDB_Ut1PMJS9w2fr6Ti91Q_1761630418
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-28973df6a90so41102495ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630418; x=1762235218;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjYjUVdz0I6ghKZKvyB9s6ubfgqWF4aJ+zXIpAp5AvU=;
 b=Om8lDlO+J/tmAKEFIKZ0ALwaM/kXEiNrpYm8Ml0F1kJaxIOMVxuDGbXPYK5uNKYYkE
 Sme5iCFrfPc9VJlgGZgjW390g5g/c4pMCFPkNoANZrTpf+OJhjze0K2r4vc2qGCjwDpD
 PGKxOB/tUYguFNfCFlPv48yUXSu0dzB2FzxQcTQFHYLfVwdNcrL/thuW3TnPJaO18YSd
 nD4Ufi7u0VvYJJMhSSRUsI9yUTEgOytMkvOcQsZvuqsgnxYZc30osbI7fbp1NCyezRrA
 jUys7/B+bazxyx79UmxdzeDMnEFmJCT3M8JT7F6evPoGQKovGxCoi67YnF9P6ZW77Bjw
 RUMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCT5STq/UYELvPg7kcrrhWxjHfr9yJ0ixU6k/yMTQQDsRF8N1AOQZXtwiHRKGdgqtZvzIkWzvgcGtD@nongnu.org
X-Gm-Message-State: AOJu0Yy9z7FH77/Xa/G53Re3NHQ6NJIngITlnGwGjNHV2j+fSb0SrIy6
 8MAvQ4wMnzv7vsDZRRmYHESB11rjBCoDHJ1ob5/rFHWD3dLwPTv9uybSOah5QT6Gv+RXBB9YlFu
 LbFCFiFUkPuQJTy8LMVRErtfbu0jDKvNMgrYiNjlPFtaVL2XePEUnOckL
X-Gm-Gg: ASbGncttvKSs2/DS6QpeQzvUTsLCgX5ySOttUy7dHWlhgb/YhIvQV1GNhLbWV0JSY5T
 FK3FWWoZjQEmETyc+qe7T6RCWgb8AnQymcO76naFOWa5l9eyN7sIGaSGgekhbhFIIhLxbnD+Mcw
 0inuqDHdrx5IZPu/4rySM+UQApbohmJamEg6Uy/wpEJMx6UotiVLdgmPgkFK8YTmkHw5Ozl/Zm1
 LSp9dM6PcfxbCvkl5O/8WsB0K9puPbKTHHG2i+PyLp+xZ0xroIkav3S8MQp1254AX4P8BMi6gRg
 KUbfayKS20WF0qAQlJz9j/bcBmhhmW9W31/kUC0hULzRNCqOldlkvHH23J2M6AFXuOgM7KCDEsV
 4fM70E5Zoecrg
X-Received: by 2002:a17:902:c402:b0:290:b14c:4f36 with SMTP id
 d9443c01a7336-294cb52db11mr32089775ad.31.1761630417884; 
 Mon, 27 Oct 2025 22:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcgNdmhVQ0xZ0I2J5eQesmsZ1WgbnbJ1aghjda9royNxOwzVD2e48WtFuVsLvQDGhW7tOnxQ==
X-Received: by 2002:a17:902:c402:b0:290:b14c:4f36 with SMTP id
 d9443c01a7336-294cb52db11mr32089565ad.31.1761630417528; 
 Mon, 27 Oct 2025 22:46:57 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d0ac07sm102887865ad.43.2025.10.27.22.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 22:46:57 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:16:50 +0530
From: Arun Menon <armenon@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 23/45] migration: Capture error in
 postcopy_ram_listen_thread()
Message-ID: <aQBYyn-xR9mr28fU@armenon-kvm.bengluru.csb>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-24-peterx@redhat.com>
 <CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com>
 <aPeosY5_MvfqtiuE@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPeosY5_MvfqtiuE@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thank you for the review.

On Tue, Oct 21, 2025 at 11:37:21AM -0400, Peter Xu wrote:
> On Tue, Oct 21, 2025 at 03:53:11PM +0100, Peter Maydell wrote:
> > On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > From: Arun Menon <armenon@redhat.com>
> > >
> > > This is an incremental step in converting vmstate loading
> > > code to report error via Error objects instead of directly
> > > printing it to console/monitor.
> > > postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> > > to load the vm, and in case of a failure, it should set the error
> > > in the migration object.
> > >
> > > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > Tested-by: Fabiano Rosas <farosas@suse.de>
> > > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-23-36f11a6fb9d3@redhat.com
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > 
> > Hi; Coverity reports a memory leak (CID 1641390) as a
> > result of this change:
> > 
> > >  migration/savevm.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 34b7a28d38..996673b679 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > >      QEMUFile *f = mis->from_src_file;
> > >      int load_res;
> > >      MigrationState *migr = migrate_get_current();
> > > +    Error *local_err = NULL;
> > >
> > >      object_ref(OBJECT(migr));
> > >
> > > @@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > >      qemu_file_set_blocking(f, true, &error_fatal);
> > >
> > >      /* TODO: sanity check that only postcopiable data will be loaded here */
> > > -    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
> > > +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> > 
> > Here, a failure in this function will allocate an Error
> > object and set local_err to point to it.
> > 
> > >
> > >      /*
> > >       * This is tricky, but, mis->from_src_file can change after it
> > > @@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > >                           __func__, load_res);
> > >              load_res = 0; /* prevent further exit() */
> > >          } else {
> > > -            error_report("%s: loadvm failed: %d", __func__, load_res);
> > > +            error_prepend(&local_err,
> > > +                          "loadvm failed during postcopy: %d: ", load_res);
> > > +            migrate_set_error(migr, local_err);
> > > +            error_report_err(local_err);
> > >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > >                                             MIGRATION_STATUS_FAILED);
> > 
> > In this brach of the if(), we error_report_err(), which will
> > free the error object. But in the other branch of the
> > if(), we never do anything with local_err, and so we never free
> > the error object.
> > 
> > I think the true-branch of the if() needs to either
> > incorporate the error into something, or else error_free() it.
> 
> Thanks Peter, I'll sent patches for both issues raised in the pull.

May I take care of it, along with the fix of passing local Error object
into vmstate_load_state()?

> 
> -- 
> Peter Xu
> 

Regards,
Arun Menon


