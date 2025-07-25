Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03842C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCZi-0008M4-4U; Fri, 25 Jul 2025 03:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCZM-0007zw-D0
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCZJ-0003ab-JJ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbbPJn6DlJsNfOdYZQ1GStS2AkcYCY3hQrM0Cu62WVI=;
 b=D00nQBW+6yedhkZigB9e/2NavNTiyMEZ8985vBiHXmxB8HRBLEsA1N6418hdEObmc/S4nO
 TIgW5tNt78ojF5S6Rd9JZb0u/4ifQv4KDGuymejWtSjeljE24O6sF6Kk61GHjDkd2qj0qe
 U0AH+edoJRml+7P1lUYvqioU3qmpywM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-8jMTnSCzMmWg56BYoFgk1g-1; Fri, 25 Jul 2025 03:10:11 -0400
X-MC-Unique: 8jMTnSCzMmWg56BYoFgk1g-1
X-Mimecast-MFC-AGG-ID: 8jMTnSCzMmWg56BYoFgk1g_1753427410
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-74b185fba41so1791638b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427410; x=1754032210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbbPJn6DlJsNfOdYZQ1GStS2AkcYCY3hQrM0Cu62WVI=;
 b=vIEcDdEDRzyAqCaoeZBGXKLLoZmNsQFViGtGLHsRLFBvcgd31U5Pj/u0o01hlfFo3a
 aybtNwViM8hBqqzNxSKANN5ChbmiaGWjVWjcciRh2FNB8Rv0d0Hty0MVW/8cIAHRel8b
 nowL7FESAHyoAEmtfgMNftNEXmqJbXx0zlBPy6aUuDDWZpknLnh3TQDENv6hwVaYrkHP
 66274DjoCfcVWYnzmVujYk0b49NVL+zpYDS0D6Zchf3vHTI0Ma0LMbd6ObTdwQiMcF0q
 AxcYu0l3ltWVi35aGacRYEALDwNmvh9uGtMKGugz6X35rin+9sxsZf0WbOqkn/Vx/jv/
 D51A==
X-Gm-Message-State: AOJu0YyOX5Ea2OaMG3Y0rwYj5Zxri6tscl2eCJVdyNwJz+h48f88crQp
 LNPTcdkjbtzOHmB9N5K7RQdHEZafQBIrTZ+q6AwEU4avy/+k3q0Fv3SL8d0w5zq9vWOnxMa3NLU
 4nwN3xp7b/qAd+kbo+Jq70pD4xXJo6LdK1XF3xEhyQXrtUb8+s+2G+zjf
X-Gm-Gg: ASbGncsIx0Jp1Lwt7Z6CH7v3NnHJ/s5cnggqD3++R/iYE4qrbGYXWxN1TIVllA8UA7w
 Zff8giN6RoDIVj02orGvFRPKb2Cjx8CuvRN2vOYfGfAtFdM3T1UQBOOToKzwIT+QkXeFY0c+jIt
 hZBkabWkZ9UdUz0zZ1RKFwdtdfUHTlzQGwJp7e2MdWdMzvWQMdvT5Ov2klB6Hig8q+8ITd5y89Z
 MmZHKuL0Q6M99Zt7GvHI2x5VrzhXD/ETtnLDbmTAKfac5EXmkNvnyFPg5lTgF8yixrnwi/FYhH/
 zqZg5K6R8HXg/V6Dq9HJ7LwzfXDs1AGZn+tiIYx4DiQwH0zfgAj6
X-Received: by 2002:a05:6a00:992:b0:74d:3a57:81d9 with SMTP id
 d2e1a72fcca58-76336a37577mr1700520b3a.8.1753427409711; 
 Fri, 25 Jul 2025 00:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF5BznroyWwRgyqXxYpmwhsHIsBSak086+hLpPbViM0J/SX7ix5AhGcN2vNp1jufcW6KNbJQ==
X-Received: by 2002:a05:6a00:992:b0:74d:3a57:81d9 with SMTP id
 d2e1a72fcca58-76336a37577mr1700461b3a.8.1753427409270; 
 Fri, 25 Jul 2025 00:10:09 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b062717asm3194242b3a.126.2025.07.25.00.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:10:08 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:39:57 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	y@armenon-kvm.bengluru.csb
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
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 01/24] migration: push Error **errp into
 vmstate_subsection_load()
Message-ID: <aIMtxStaxifsxkWr@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-1-fef740e15e17@redhat.com>
 <bf321448-6fe2-429e-a36a-9f9e0fb6bec5@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf321448-6fe2-429e-a36a-9f9e0fb6bec5@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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

On Mon, Jul 21, 2025 at 09:10:21PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that vmstate_subsection_load() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/vmstate.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 5feaa3244d259874f03048326b2497e7db32e47c..129b19d7603a0ddf8ab6e946e41c1c4d773d1fa8 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
> >                                      void *opaque, JSONWriter *vmdesc,
> >                                      Error **errp);
> >   static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> > -                                   void *opaque);
> > +                                   void *opaque, Error **errp);
> >   /* Whether this field should exist for either save or load the VM? */
> >   static bool
> > @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >           field++;
> >       }
> >       assert(field->flags == VMS_END);
> > -    ret = vmstate_subsection_load(f, vmsd, opaque);
> > +    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> >       if (ret != 0) {
> >           qemu_file_set_error(f, ret);
> >           return ret;
> > @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
> >   }
> >   static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> > -                                   void *opaque)
> > +                                   void *opaque, Error **errp)
> >   {
> >       trace_vmstate_subsection_load(vmsd->name);
> > @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> >           sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
> >           if (sub_vmsd == NULL) {
> >               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
> > +            error_setg(errp, "VM subsection '%s'  in '%s' does not exist",
> 
> There are two whitespaces before "in" but I think we only need one.
Yes, missed that. Thanks. Will amend in the next version.

> 
> > +                       idstr, vmsd->name);
> >               return -ENOENT;
> >           }
> >           qemu_file_skip(f, 1); /* subsection */
> > @@ -608,6 +610,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> >           ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
> >           if (ret) {
> >               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
> > +            error_setg(errp, "Loading VM subsection '%s' in '%s' failed : %d",
> > +                       idstr, vmsd->name, ret);
> >               return ret;
> >           }
> >       }
> > 
> 


