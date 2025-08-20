Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E3DCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uomla-00075Y-8e; Wed, 20 Aug 2025 13:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomlA-0006vD-Di
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uoml5-00007A-C5
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755711477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5gNgZiiCKKGE8U1r9Ayd4R8HQGho1BFh+Q7fLtXnlk=;
 b=IlSUjAfhKXVa2HTbFC3kxn6qVQEnAlws6rMTTY20MSFXJK8YPDZ/+LNBvCjIW0fGBZ1jKi
 g1/PBHuvVeRhbu4YoIMncXU2ObfMJGz++6MHZMCGbbWZQxQq91uMBY/BSTzXNPTGh1XGY+
 v0ReTalMol/+JRGxxBT5XrzMYiSXPRY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-V6hvozyCNn2i0eGBXIFdLQ-1; Wed, 20 Aug 2025 13:37:56 -0400
X-MC-Unique: V6hvozyCNn2i0eGBXIFdLQ-1
X-Mimecast-MFC-AGG-ID: V6hvozyCNn2i0eGBXIFdLQ_1755711475
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-323766e64d5so1219188a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755711475; x=1756316275;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5gNgZiiCKKGE8U1r9Ayd4R8HQGho1BFh+Q7fLtXnlk=;
 b=Jl/Nx6KgTaD4jcrR57WKu8NxSsWjsZxTW+1LPII0YrLMLxvCr+23x2fjSo5Fvgt0cS
 ELqFxehR+mL+BucIYqvkKMS/AVjuI3bPk+P5k6ULu5ooSot3uDwXsoKIQDav0BXR3tSq
 oDQWbqMZm6ErJ9bwuUhClQcmxhnQIlNJM6I31Kfm6jpcKIRPESgoUGvnD68awJaOulUI
 KlXL+j39cFUhB+nF6RrwKUu1wA//ZnS++Xq9H9I/ogK25kMTv/wJ0Lln4da8OiDLrd2P
 0QYd+OOIWVwmXpjKmCyDmu/3muzG5CvVvi6cuUoUmikLT65DZwBzYEKccuaRN+EbFH8r
 nXVg==
X-Gm-Message-State: AOJu0Yx1a353eQW1iB92+ggvb4vv2mD+tvwwH0fmDxcKNo9lyZQ5mALT
 nf08CC4PyaLDh2JkCL/FNicW0g7s9gkxbrzhnm+NtAfyvbAHAF/C9ORmkUgkBUPQtoGipOhCY82
 /FYxKmjJgWXeln78+VLeIF1gFqqayLhwMI66g59sWKsHrEramQukIbgMC
X-Gm-Gg: ASbGncvcDoC3HohmsGK85Dg/T7JRM3JekiqLivBaorTUrhg2YsM/9rb7f8kpnlHid+4
 GAWVT4TRglLZxhLRPvuwqMiLUF70JkdXm39DPhLuKcvdbk45bIzYHKwjOjm2EN1ZtMEJ2GWL1hd
 nyY0z1frAqRZBtOG0N1y/+q78mXusEajUbiktipA+1t2aBwhXobCQQ8gEuoebYVHVE87ARF9tUw
 iE9kLACBIUgW/NRTk2sOEXA8oGKJagdQcS+Em4/l8u4ugDlVSGJzUxd2iB/HlMwB4P4fiblcozj
 nuhKSlubHcHHfpLx42Pe2y7z3fduc7JFFvO/yanZn2n2MwFND88B
X-Received: by 2002:a17:90b:4c11:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-324eb9de67dmr414988a91.11.1755711475181; 
 Wed, 20 Aug 2025 10:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZfafJe55/w1fb8uTpefjNUOkQbaZUnZHLX5oKvhOAB85R29XUYRHnoG1iJ+QuQ60iZ+bwJA==
X-Received: by 2002:a17:90b:4c11:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-324eb9de67dmr414969a91.11.1755711474733; 
 Wed, 20 Aug 2025 10:37:54 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b476408fed8sm2778915a12.36.2025.08.20.10.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:37:54 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:07:42 +0530
From: Arun Menon <armenon@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v11 23/27] migration: Capture error in
 postcopy_ram_listen_thread()
Message-ID: <aKYH5qJ2ont0denZ@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-23-b470a374b42d@redhat.com>
 <875xeoxsr1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xeoxsr1.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Fabiano,
Thanks for the review.

On Fri, Aug 15, 2025 at 04:57:38PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> > to load the vm, and in case of a failure, it should set the error
> > in the migration object.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/savevm.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index de2bce276faa863a0f25deedafb0b784f10559d7..b85620a03654c214f4e771fa3b2bcfdf48661214 100644
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
> >      qemu_file_set_blocking(f, true);
> >  
> >      /* TODO: sanity check that only postcopiable data will be loaded here */
> > -    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
> > +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> >  
> >      /*
> >       * This is tricky, but, mis->from_src_file can change after it
> > @@ -2137,9 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >                           __func__, load_res);
> >              load_res = 0; /* prevent further exit() */
> >          } else {
> > -            error_report("%s: loadvm failed: %d", __func__, load_res);
> > +            error_prepend(&local_err,
> > +                          "loadvm failed during postcopy: %d: ", load_res);
> > +            migrate_set_error(migr, local_err);
> > +            error_report_err(local_err);
> >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > -                                           MIGRATION_STATUS_FAILED);
> > +                              MIGRATION_STATUS_FAILED);
> 
> This should be left alone. Having this patch (git) conflict with
> something else just because of this line would be really annoying.

Sure, will do.

> 
> >          }
> >      }
> >      if (load_res >= 0) {
> 

Regards,
Arun Menon


