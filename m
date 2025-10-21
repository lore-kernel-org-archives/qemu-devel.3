Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B90CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEQc-0002Rf-Dl; Tue, 21 Oct 2025 11:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBEQW-0002OT-4F
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBEQR-0005QB-UR
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761061046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sVBnCX9iGglYltjPY+kimPtobtO6Xzl8Hi21FEAenI=;
 b=HscFQMFMtamre+TfSh37ebEzn2l1AhemEJzUP41I9zql1NTPhNQ6650umH10/PtnmTrsSh
 ne00pe6nqbNOeNWpN7hRnWQHtrs+sAE680533CbJaantZemRMzz3+tVxNKpLQVY4zWUMQQ
 D8ZKyk+qaBNHKAn8KPckWi1zQHUINkI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-LXZvSiCnOtmGF2pfzdPpyg-1; Tue, 21 Oct 2025 11:37:24 -0400
X-MC-Unique: LXZvSiCnOtmGF2pfzdPpyg-1
X-Mimecast-MFC-AGG-ID: LXZvSiCnOtmGF2pfzdPpyg_1761061044
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88ea6169a96so286116085a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761061044; x=1761665844;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1sVBnCX9iGglYltjPY+kimPtobtO6Xzl8Hi21FEAenI=;
 b=KLKgYeL/edCy27mggezWzm0tgKzFK2HkxdzfFfkiHLix15L7q6HEmGw56cic8SMvdU
 PRzP/QD0hXSv7mbbJp3uyAWsGxzjJEcCwLMLRbhsdqloHPsvQXYUJBeqT6mykgZeLiHj
 uLl7hN5nQ7/ipgM3TuTEbYuHVVkdMi2D6sQhMIDXXJBeTj64Ycyl+eA8vzsG3avF4SC+
 TFy/NHJp7vD0OuSHRwbAfYLMCKial7pazhk8zcZvtBeFNIvkcFaN1+vENgZkwg+hxYII
 p+ZIatgyXG0y1cNl3WED3/FwL9zdrUNQBf0rFCEpSVMk0aVZmL4eeDgi/qWKwX419ZUz
 kP3g==
X-Gm-Message-State: AOJu0YyDMs1TGozMtCP9nQapP4IJSKcGUgXdHUcMv+rb/cxR+qSoF9Sg
 IY90Apona3nvb+TILZspxDbXeklqqhUY9geN+UvtiSPX/3T0ckYoH/PLMZFf8EuvbeZ8Ii1KXz1
 j2FHBKF7at5MYku4OEns7aUrUpKEYRIDNJ+khZnLN2z1XYjD3I3lLqct4
X-Gm-Gg: ASbGncthj6THtozdu7tqBpL1gWi2u9FxH6+40COkGRVGaeqodmNMQV0cj9ei4KGjtmv
 10HLLrQtu+YYeA+UbEsLkpgojXIAcMXMQkrp6jaun0tJA8tJod0v842zpTyV4xr1cC/yZ+VXngk
 FS/whOv7gpSmS6rF6SI/AlJZp8GYvPPiXqQcuQiEVs8x8pwmHmVzb30zQKlvDX4zEjii8wz5h2T
 pFEe30A4xZhNnTp63TDygBnrAMrnqBmyMO0zTdvOhn4cMznamxf+i8OZBi/tGa73LijnmJ//ME4
 ylwmEAfb1NFHc0kVV2UTyA+KzNpBeLPeShd6TWPXqwF22Q4Iq7fwcvfA1W2yTqX34Ps=
X-Received: by 2002:a05:620a:4089:b0:82a:bb78:20c4 with SMTP id
 af79cd13be357-8906e2ce6f0mr2004703885a.8.1761061044286; 
 Tue, 21 Oct 2025 08:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBLeps9r35348GfVHRxFPU301PgMFnbNUru0gZHojOXav1xTuCGKsSrQHVnhcxFsfaFsy4YQ==
X-Received: by 2002:a05:620a:4089:b0:82a:bb78:20c4 with SMTP id
 af79cd13be357-8906e2ce6f0mr2004699185a.8.1761061043669; 
 Tue, 21 Oct 2025 08:37:23 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cefba77asm790898685a.33.2025.10.21.08.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:37:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:37:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 23/45] migration: Capture error in
 postcopy_ram_listen_thread()
Message-ID: <aPeosY5_MvfqtiuE@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-24-peterx@redhat.com>
 <CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 21, 2025 at 03:53:11PM +0100, Peter Maydell wrote:
> On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> > to load the vm, and in case of a failure, it should set the error
> > in the migration object.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > Tested-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-23-36f11a6fb9d3@redhat.com
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> Hi; Coverity reports a memory leak (CID 1641390) as a
> result of this change:
> 
> >  migration/savevm.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 34b7a28d38..996673b679 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >      QEMUFile *f = mis->from_src_file;
> >      int load_res;
> >      MigrationState *migr = migrate_get_current();
> > +    Error *local_err = NULL;
> >
> >      object_ref(OBJECT(migr));
> >
> > @@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >      qemu_file_set_blocking(f, true, &error_fatal);
> >
> >      /* TODO: sanity check that only postcopiable data will be loaded here */
> > -    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
> > +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> 
> Here, a failure in this function will allocate an Error
> object and set local_err to point to it.
> 
> >
> >      /*
> >       * This is tricky, but, mis->from_src_file can change after it
> > @@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >                           __func__, load_res);
> >              load_res = 0; /* prevent further exit() */
> >          } else {
> > -            error_report("%s: loadvm failed: %d", __func__, load_res);
> > +            error_prepend(&local_err,
> > +                          "loadvm failed during postcopy: %d: ", load_res);
> > +            migrate_set_error(migr, local_err);
> > +            error_report_err(local_err);
> >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> >                                             MIGRATION_STATUS_FAILED);
> 
> In this brach of the if(), we error_report_err(), which will
> free the error object. But in the other branch of the
> if(), we never do anything with local_err, and so we never free
> the error object.
> 
> I think the true-branch of the if() needs to either
> incorporate the error into something, or else error_free() it.

Thanks Peter, I'll sent patches for both issues raised in the pull.

-- 
Peter Xu


