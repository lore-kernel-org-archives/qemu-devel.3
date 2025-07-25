Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2FFC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCc3-0005F3-7o; Fri, 25 Jul 2025 03:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCc0-000508-6c
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCbx-00048M-LX
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNIs5TWJGkvuBF6wX1BCsXRUbgLPWwFp34p2oUwLyeo=;
 b=gO2Rvul95YgMWfb7w6bvlQ3Z07c+O49rmJRkr2GxZaj0Z6Zgl59nuLIE83DRQCkvcxhyYW
 GSlnKcIaKQZidcJr+ZtX8HzwyKMzDj+toQl+lIQluk+sLJ93KENxqb07J25R7LJVVnjWHd
 wxKUOR2REDvbkcZ8VJ40knku8WzZ7S4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-tyf2-SeYM2yg2K144zunDg-1; Fri, 25 Jul 2025 03:12:54 -0400
X-MC-Unique: tyf2-SeYM2yg2K144zunDg-1
X-Mimecast-MFC-AGG-ID: tyf2-SeYM2yg2K144zunDg_1753427574
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-311e7337f26so1843283a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427574; x=1754032374;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNIs5TWJGkvuBF6wX1BCsXRUbgLPWwFp34p2oUwLyeo=;
 b=VoYBmrjUYdM/qjjNkfZ+bhDdMHf8nUAQwsfiCM46b4WFAYYkQH8Jr2Gu8lFEmlmGWA
 IcuAuqkmG8U6ilxrdwPoZS9RoMGtvyq2jqYYX0B481bREBqqt+Xq4TUMtdJ05YgpArlP
 v6RN/7eD2C6Yv9VGc6GKXbTCNhLZHkY6EQQv0ZrIctAGcD2X/u91Wd7YBZbDUW12eNDf
 4p6kD+yaTbnCtfWj482TBHCsucWFe90nKQImHYm5qQ1Q2nIAOcpH9jB4ZqJc9vXuubod
 GnJsEMTqNuKawLI8gCSPLgmQt3Hl/MP7FkPPAppQrDWu2xo8jLskVA8SDhekLNtS/j8r
 2Wig==
X-Gm-Message-State: AOJu0Yyu+Ko6CiJ4DU+l4ANdQlzDzrgjX/ZbbkhBLuVhp8J1ecEPUKS7
 onjyWEFL4NeE9ZrbRMWBADp0kiqS2Dp9SPayEXYFf3/P0ZD+PebiiMjSkc8eLvuu+ytKkzTj+8z
 7CUc344ix8Q20+cnM+EUOd05PfO0payKnKZ+GHQ66nj0anHWUY4viQRdI
X-Gm-Gg: ASbGncu3JxcbzBi3nhyT2cMcsvkw9vkn8sT6spdRsHIabUxoe8jd/Vjx3O33IEwsPDL
 g7Ldx6Yq1A/S9172phmJ0fo8xPjGxysYn6XoCUIG4wH5rie3GVBb7ExGaHDF2WcTympNt9xUaZf
 Wy5WQAHXPN1anq9GJVPssge6x3j7YagXGt8FHB+zgu9Z6VylqOFpVzc/8xc97zzl/boDC/sWTYg
 VZaCtbGMIkqUIMePXruJsU1ZqMAzgT/tATSHNLRV9/9nlQW5o06ojOQ6TeFUZVZQGFXiy4gueGj
 blPStVG6LDhjLUnU65lcxa/G2CO5XavTjuCrqKNq98qC5OOv1gCI
X-Received: by 2002:a17:90b:4a0a:b0:31c:b243:2f69 with SMTP id
 98e67ed59e1d1-31e77a14400mr1267149a91.29.1753427573777; 
 Fri, 25 Jul 2025 00:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxeTfAnJpXxonz+1GMdv4Bd6xZb+pLd8RB291kfovGUqkyaeMuqmBUiDrky+iklyqMGguopg==
X-Received: by 2002:a17:90b:4a0a:b0:31c:b243:2f69 with SMTP id
 98e67ed59e1d1-31e77a14400mr1267090a91.29.1753427573207; 
 Fri, 25 Jul 2025 00:12:53 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662e0105sm2836669a91.31.2025.07.25.00.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:12:52 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:42:41 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 03/24] migration: push Error **errp into
 qemu_loadvm_state_header()
Message-ID: <aIMuaQ2L4lSMLp0v@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-3-fef740e15e17@redhat.com>
 <CAMxuvayhm4aos_JDyu+92t==EX3Nr6JDn8L=3agu7k6rHQ-tag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayhm4aos_JDyu+92t==EX3Nr6JDn8L=3agu7k6rHQ-tag@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

Hi,
Thanks for the review.

On Mon, Jul 21, 2025 at 04:34:12PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 21, 2025 at 3:30 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_state_header() must report an error
> > in errp, in case of failure.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/savevm.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > ab947620f724874f325fb9fb59bef50b7c16fb51..162fb05933fae5993eeef107811f97cb08726ac3
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2814,35 +2814,42 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> > type)
> >      return 0;
> >  }
> >
> > -static int qemu_loadvm_state_header(QEMUFile *f)
> > +static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
> >  {
> >      unsigned int v;
> >      int ret;
> >
> >      v = qemu_get_be32(f);
> >      if (v != QEMU_VM_FILE_MAGIC) {
> > -        error_report("Not a migration stream");
> > +        error_setg(errp, "Not a migration stream, "
> > +                   "magic: %x != %x", v, QEMU_VM_FILE_MAGIC);
> >          return -EINVAL;
> >      }
> >
> >      v = qemu_get_be32(f);
> >      if (v == QEMU_VM_FILE_VERSION_COMPAT) {
> > -        error_report("SaveVM v2 format is obsolete and don't work
> > anymore");
> > +        error_setg(errp, "SaveVM v2 format is obsolete and no"
> > +                   "longer supported, file version %x != %x",
> >
> 
> As Akihiko said in patch 2 review, better "not to have line breaks in
> string literals" .. here, there is a missing space now.

Agreed. I am going to amend all the commits once and check for these kind of
breaks. However, I do not want to have the line too long also (more than 100 chars).

I will try to find a way in which I can use minimum breaks, while keeping in mind
that a grep search should be able to find the line in the codebase, if that is ok.
> 
> +                   v, QEMU_VM_FILE_VERSION_COMPAT);
> > +
> >          return -ENOTSUP;
> >      }
> >      if (v != QEMU_VM_FILE_VERSION) {
> > -        error_report("Unsupported migration stream version");
> > +        error_setg(errp, "Unsupported migration stream "
> > +                   "version, file version %x != %x", v,
> > QEMU_VM_FILE_VERSION);
> >          return -ENOTSUP;
> >      }
> >
> >      if (migrate_get_current()->send_configuration) {
> > -        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
> > -            error_report("Configuration section missing");
> > +        v = qemu_get_byte(f);
> > +        if (v != QEMU_VM_CONFIGURATION) {
> > +            error_setg(errp, "Configuration section missing,"
> >
> 
> here too
yes
> 
> 
> > +                       "%x != %x", v, QEMU_VM_CONFIGURATION);
> >              return -EINVAL;
> >          }
> > -        ret = vmstate_load_state(f, &vmstate_configuration,
> > &savevm_state, 0,
> > -                                 NULL);
> >
> > +        ret = vmstate_load_state(f, &vmstate_configuration,
> > &savevm_state, 0,
> > +                                 errp);
> >          if (ret) {
> >              return ret;
> >          }
> > @@ -3119,7 +3126,7 @@ int qemu_loadvm_state(QEMUFile *f)
> >
> >      qemu_loadvm_thread_pool_create(mis);
> >
> > -    ret = qemu_loadvm_state_header(f);
> > +    ret = qemu_loadvm_state_header(f, NULL);
> >      if (ret) {
> >          return ret;
> >      }
> >
> > --
> > 2.50.0
> >
> >
Regards,
Arun


