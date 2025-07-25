Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C8C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCdf-00085D-NR; Fri, 25 Jul 2025 03:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCdI-0007do-Tg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCdF-0004Qg-FR
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYgfeus5mgYX8jR5gXexmL1P8soToDDWahTkSB0J/pw=;
 b=Hgck40chmj0ggzvf/8k1nMu3iDnpLen+unpvkjkald6VnRv/jE9M5poK6mr58owoln2jQs
 muKtEbwiLNCAHaL+Ey8mAB4l5Wug3DZXUwk48d5gsExiCjQhJrGdHQZQYwHLbV3rJBlGW5
 lERj26ANLtvNrRb3640HoJHM/n3Gs0I=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-CDuCaJAUOG6E9dPEwfy3Ow-1; Fri, 25 Jul 2025 03:14:14 -0400
X-MC-Unique: CDuCaJAUOG6E9dPEwfy3Ow-1
X-Mimecast-MFC-AGG-ID: CDuCaJAUOG6E9dPEwfy3Ow_1753427653
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-74ea83a6c1bso902420b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427653; x=1754032453;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYgfeus5mgYX8jR5gXexmL1P8soToDDWahTkSB0J/pw=;
 b=obiXHPn+zfCCDBuN9+HepRIdY84jBxsi00kOGbm4tPn4BOpAlc56O/gCyr2zoQEm2q
 bCoDf/FN2dzSPiiWrNa1ZZHdTZVvmn1L23hE1fAJzQZ2BmxiW8BePzs3alnZACeBVyH0
 fxQikT0D8KiM0xeTqcfqCG/kaGdBSF0fYnQPAjTJ6mHMCXF6EO7NVq1Hcd6zBf8oKZ6p
 RwcDc/lwiIi0JzYluFq9QtwTeYytno+P6KwpniJyVFWb1T4TDepzMQ5gr9s4EqMIRwHS
 /4M6dmP1IER7C+gpDdYhPmlsoWTF93RVsDiHo2YqVcQnAswisq32usr1BmGusauW54sT
 RoyQ==
X-Gm-Message-State: AOJu0Yw4jzsff4ca0GTJq4DvG8/HNIuk8vEzipdzSsM6aAUzxdx0fDrz
 fHKA7Ma7XNg4tFSdTxw0kyHF6STCREdocTsX6+W2XwPq3GiNGtiRDmFa5pgskcjNIjAiKeRI4RY
 /pRw8tpK0zuSLJSxlnmxhDOiUCKS20x5oxkDWXrBpHe6rVOWOWz2KIHkq
X-Gm-Gg: ASbGncsGg0VD/pstQzKFIlOxTyWYXKHIKBs0bSk++iPKFCbCRS6fLq2EhsrWBXP41zh
 yZ3snepICTh6QsP9bDAmEA8/FsKjHlkX1twA3baICTm4fX4TbkMc4QWs8e9kN3SpIYaYfWo42f3
 Y11aVt4Y0gm/ImZ3d7XC7kZCJddX2CHGpApbWkUtwWxbU0kzq0b1Q4ECefToic+2v3blT6NFBp1
 kn4pvZ3K0V7qhXUzug5hdfU9lPkrQTfgD9i0Vyzh1MZ+QohhqGxuCG53b5UuhB5ExjwMEIDM76J
 9AomfiC0H0ZICFAN7z+w/WHYxY1t0q9OZJ/925RxCnrZeH0K9Pdh
X-Received: by 2002:a05:6a00:992:b0:74d:3a57:81d9 with SMTP id
 d2e1a72fcca58-76336a37577mr1718589b3a.8.1753427653287; 
 Fri, 25 Jul 2025 00:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6dwJ3FMJhmdNxSx0XUxaljPHlNAqcEpb95FX2YhpcPDaXkyDgE6fmpVyy1309pwluw7KKeg==
X-Received: by 2002:a05:6a00:992:b0:74d:3a57:81d9 with SMTP id
 d2e1a72fcca58-76336a37577mr1718556b3a.8.1753427652837; 
 Fri, 25 Jul 2025 00:14:12 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b05fad03sm3152078b3a.102.2025.07.25.00.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:14:12 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:44:01 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v6 11/24] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
Message-ID: <aIMuuLU45pWXE_Mz@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-11-fef740e15e17@redhat.com>
 <ba4ca7d3-efb9-47a9-a84e-95394fe8bfff@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba4ca7d3-efb9-47a9-a84e-95394fe8bfff@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

Hi,
Thanks for the review.

On Mon, Jul 21, 2025 at 09:43:30PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that loadvm_postcopy_handle_advise() must report an error
> > in errp, in case of failure.
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/savevm.c | 39 +++++++++++++++++----------------------
> >   1 file changed, 17 insertions(+), 22 deletions(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 6b8c78bfb9bde2a8e7500b0342cd386b0d12db97..4a3db9498678a19597257e683029cd3f6c8d1a65 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {
> >    * quickly.
> >    */
> >   static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> > -                                         uint16_t len)
> > +                                         uint16_t len, Error **errp)
> >   {
> >       PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
> >       uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
> >       size_t page_size = qemu_target_page_size();
> > -    Error *local_err = NULL;
> >       trace_loadvm_postcopy_handle_advise();
> >       if (ps != POSTCOPY_INCOMING_NONE) {
> > -        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)", ps);
> > +        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy "
> > +                   "state (%d)", ps);
> >           return -1;
> >       }
> >       switch (len) {
> >       case 0:
> >           if (migrate_postcopy_ram()) {
> > -            error_report("RAM postcopy is enabled but have 0 byte advise");
> > +            error_setg(errp, "RAM postcopy is enabled but have 0 byte advise");
> >               return -EINVAL;
> >           }
> >           return 0;
> >       case 8 + 8:
> >           if (!migrate_postcopy_ram()) {
> > -            error_report("RAM postcopy is disabled but have 16 byte advise");
> > +            error_setg(errp, "RAM postcopy is disabled but have 16 "
> > +                       "byte advise");
> >               return -EINVAL;
> >           }
> >           break;
> >       default:
> > -        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> > +        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> >           return -EINVAL;
> >       }
> > -    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
> > -        error_report_err(local_err);
> > +    if (!postcopy_ram_supported_by_host(mis, errp)) {
> >           postcopy_state_set(POSTCOPY_INCOMING_NONE);
> >           return -1;
> >       }
> > @@ -1967,9 +1967,9 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> >            *      also fails when passed to an older qemu that doesn't
> >            *      do huge pages.
> >            */
> > -        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
> > -                                                             " d=%" PRIx64 ")",
> > -                     remote_pagesize_summary, local_pagesize_summary);
> > +        error_setg(errp, "Postcopy needs matching RAM "
> > +                   "page sizes (s=%" PRIx64 " d=%" PRIx64 ")",
> > +                   remote_pagesize_summary, local_pagesize_summary);
> >           return -1;
> >       }
> > @@ -1979,17 +1979,17 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> >            * Again, some differences could be dealt with, but for now keep it
> >            * simple.
> >            */
> > -        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
> > -                     (int)remote_tps, page_size);
> > +        error_setg(errp, "Postcopy needs matching target "
> > +                   "page sizes (s=%d d=%zd)", (int)remote_tps, page_size);
> >           return -1;
> >       }
> > -    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
> > -        error_report_err(local_err);
> > +    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
> >           return -1;
> >       }
> > -    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
> > +    if (ram_postcopy_incoming_init(mis, errp) < 0) {
> > +        error_prepend(errp, "PostCopy RAM incoming init failed ");
> 
> Nitpick: s/PostCopy/Postcopy/ for consistency with other error messages.
> 
Good catch, thanks.
Might as well amend it while working on the new version.


Regards,
Arun


