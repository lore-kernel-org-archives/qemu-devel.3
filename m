Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D6CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uomje-0005iX-3D; Wed, 20 Aug 2025 13:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomjc-0005hP-3f
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomjZ-0008CB-Gl
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755711384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDows8f/8yyJvMd7MW0Iaj/M3rJNeiQTBtvdhcjCCq8=;
 b=FgkrAxmBrqB31wkbuBgPqQLO+CF0CaVBccMXITuQa/ogB6ETyxw/RYvhkIueCDsbtKcfdV
 RkX0SzNBVRsqhM2XNNlOeWXCgxv/2obqQUlzyakFUMQfkRnQSL4SGNDTPe8gif1JZkSnkP
 gWLSdgb3/oO3MhWb+I5uosD5NHEPaCM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-OXTORFVhO3e2_wxZR2gmsQ-1; Wed, 20 Aug 2025 13:36:23 -0400
X-MC-Unique: OXTORFVhO3e2_wxZR2gmsQ-1
X-Mimecast-MFC-AGG-ID: OXTORFVhO3e2_wxZR2gmsQ_1755711382
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b47610d3879so45210a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755711382; x=1756316182;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDows8f/8yyJvMd7MW0Iaj/M3rJNeiQTBtvdhcjCCq8=;
 b=ZK9ySfyxe+4KTYAPZ8XBBOGTveg9mS3dP8iKoMdGDR7kVCpYCRuDaxuZPGzNv2dMgh
 Eo9JW+IGnahh2fSUVyXDgGthAzwlPFqJ4BzFMht5ovSnL2yh59mUHSrSedSG2FcFe136
 WhslJ9fyoJTdDnm5XEBoECt/gQk1al3jAE7rNT4lJ1YKb6Xmcm6zkBu6idET7lnKOzEX
 nEDtPTR6Likabo8nTrsLM0aWgvEFDeDjUNtMGuS/sNEKBh0Lb3Ou+OudJNJGRdkmvVRc
 Wakoi2d2yIN6+FYj3U03lNAATGbPJGSi2ZxIUxr79s4aWLEPzALvR7zgoS+RTo5Vwl1t
 8UXg==
X-Gm-Message-State: AOJu0Yz1wpHaeMmxSijNZdVH1jBiNrUiag7xoiDblQMHl6PfuxwvUuXN
 ijAzAoERTpNx1EdWvJCu04hCB1p7yO9GhFBbTeW/tbpf82EeLeV3jWW0MtIl3ZT/y1TR4TKz3yJ
 WcPzWb+k5XK/ejCxy7WuvXq1Tlcf0JBXOIY/fAc78rkAoEY2cF76EBGDz
X-Gm-Gg: ASbGncvWb/2GuhknQ+jCxJtGb69MR3LkPSsh6uODwbzil7uEQLBGk6dlHj/0UNjPVQr
 qIshhMnWa9p6mvAX0U5irX4ledqINiHeasVJcWhI7fqGn+vr1V+nE3FGGUo/gh9unvc/LTUpZ3c
 vMhQGz1M+dn0hPEkny2LRb27vGHM919T9rM2/teM1KXziZ3Ch40GQwz7qBN4UEIlrngzHKhvpzi
 PGrm9pgZ6nvWmQqODuVTKyrT78v72hJbaAdduzuXTtW1b1zUaCgExXGAUzRsXnUB0/W1Dvaf6uv
 pZrVA8V1P0zPWBRydpSwj4snARK2Tunpf/rLSm0BrT4e5X4F9kBv
X-Received: by 2002:a05:6a21:6da6:b0:240:6dc:9162 with SMTP id
 adf61e73a8af0-2431b92264amr6015039637.40.1755711382397; 
 Wed, 20 Aug 2025 10:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBBYoA3qtaeKpqcTHUdpuHS7Lzle5P8pz0BwtcvtTc84c4XIb01BxQ7XIz9z8zTeWYuQywAQ==
X-Received: by 2002:a05:6a21:6da6:b0:240:6dc:9162 with SMTP id
 adf61e73a8af0-2431b92264amr6014944637.40.1755711381581; 
 Wed, 20 Aug 2025 10:36:21 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4764003537sm2786943a12.25.2025.08.20.10.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:36:21 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:06:09 +0530
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
Subject: Re: [PATCH v11 08/27] migration: push Error **errp into
 qemu_load_device_state()
Message-ID: <aKYHib2H4OXe2uSS@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-8-b470a374b42d@redhat.com>
 <877bz4za1h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bz4za1h.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 15, 2025 at 03:58:50PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_load_device_state() must report an error
> > in errp, in case of failure.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/colo.c   | 4 ++--
> >  migration/savevm.c | 5 +++--
> >  migration/savevm.h | 2 +-
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index e0f713c837f5da25d67afbd02ceb6c54024ca3af..0ba22ee76a13e313793f653f43a728e3c433bbc1 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -729,9 +729,9 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >      bql_lock();
> >      vmstate_loading = true;
> >      colo_flush_ram_cache();
> > -    ret = qemu_load_device_state(fb);
> > +    ret = qemu_load_device_state(fb, errp);
> >      if (ret < 0) {
> > -        error_setg(errp, "COLO: load device state failed");
> > +        error_prepend(errp, "COLO: load device state failed: ");
> 
> This will say: "COLO: load device state failed: Failed to load device
> state: %d"
> 
> Just remove it.
sure, will do.
> 
> >          vmstate_loading = false;
> >          bql_unlock();
> >          return;
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 05dc392bdf4e19f340bc72bf66ba0543d56868a5..70e021597d884030c4a0dc2a7bc27d42a7371797 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3263,15 +3263,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
> >      return ret;
> >  }
> >  
> > -int qemu_load_device_state(QEMUFile *f)
> > +int qemu_load_device_state(QEMUFile *f, Error **errp)
> >  {
> > +    ERRP_GUARD();
> 
> Is this needed here?
Not needed. Will remove, as we are not using error_prepend()
> 
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> >      int ret;
> >  
> >      /* Load QEMU_VM_SECTION_FULL section */
> >      ret = qemu_loadvm_state_main(f, mis);
> >      if (ret < 0) {
> > -        error_report("Failed to load device state: %d", ret);
> > +        error_setg(errp, "Failed to load device state: %d", ret);
> >          return ret;
> >      }
> >  
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index b80770b7461a60e2ad6ba5e24a7baeae73d90955..b12681839f0b1afa3255e45215d99c13a224b19f 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);
> >  int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> >  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> > -int qemu_load_device_state(QEMUFile *f);
> > +int qemu_load_device_state(QEMUFile *f, Error **errp);
> >  int qemu_loadvm_approve_switchover(void);
> >  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> >          bool in_postcopy);
> 

Regards,
Arun


