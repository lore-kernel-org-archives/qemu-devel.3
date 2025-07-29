Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D6EC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugeh1-0001BB-BD; Tue, 29 Jul 2025 03:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugegw-00015s-Iu
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugegu-0005Ov-En
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753773842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHqYiBR2lHKkcFCPTuG/AOHJ3KGybCWzjccvvL9QiGQ=;
 b=eeGPQEbyUAeIa9MwV90J+C3E/5G5PlUmc5HT0bSrNfUT/TNm78p8lCDydtb6lULGoy3Znu
 EHloLLlhVfeuWNGuC4ebzmBPHmDqp7G9Sae9AJVm4Qjw8VVaJ9oMq3kEeYYAgTdybe4CGt
 a3Y8Ypvhp9gxgP45zsS4jqTxLlNq2qY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-P0oFr0znOsqzoxpee7qubw-1; Tue, 29 Jul 2025 03:24:00 -0400
X-MC-Unique: P0oFr0znOsqzoxpee7qubw-1
X-Mimecast-MFC-AGG-ID: P0oFr0znOsqzoxpee7qubw_1753773839
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-74913385dd8so8624228b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753773839; x=1754378639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHqYiBR2lHKkcFCPTuG/AOHJ3KGybCWzjccvvL9QiGQ=;
 b=AHbKysHR0i/Cfl28Gf05xuHcihw2bKIjW9RMmS/XFJaYaF2La3PKkSxPenVDd0KohB
 nLsD8KfIeedIRXj9XyM7wSIdnjxUoUWLgdMX8FtGtyGeXEbSEwHSb1tNSZNkvOpIlprs
 jp2osVpoNIqq6TsOOnYJt5Hui+3SFBpNe/9j5ML+zUSb3rDw+Mi69VhMROd96Y503Ds1
 54LAy3eDYCHgalrI3E8fuDEvDOlzOnyP859b6sitY7S2FUPyk0niAHIDsB1UJI9Binro
 Rs9Rj/nivLRN1g0bKFtoBf21JzwcjP8UZ2KCxAO8pAe/e23KXXzBpJwtqwLismQ8js6Z
 SaXQ==
X-Gm-Message-State: AOJu0YwzxBQ0+cHopNJgfKHnioS7AS56+TI/UndKMgYVTFWBufnHbAbH
 msy5vCmFBtPx2vCG8rfZ/I4k0uJ0oy7msZ1eCvsHNSTznhGt/mKys0zMqo7Bqq7QC+uU+jYE8hr
 v+F5nXVTV4w9S50xtx9BHvaoWLstg3iVKJdrPz9JC8Ibu2OP6P06c8RV0
X-Gm-Gg: ASbGncslLUKqGhdcF7zUMzmpUIwbsKBPU6lVuj1PrxlSwV9qlbUprOC4kilRWBwzIGB
 7gEYJuyG3V09xRiaM+4I9n4TWN0EbGWVTDhksLsHB+WrRsTPjRtzypWel9QcnuahqRGsjbj5SVg
 qHPh8m+xfFxIFg2uvxQgoa7C6H8/Lr87ozQTb3yFTSNQNmCFYQyWM+kjTyBmEB/EDbVi5317uL9
 dkMaf7eLlVQXf/4F91MV1LEi2Ea3x196XlWpiMXueFGIaojQjxDB+1/V1B6MSpVY6tDeL/ydF7g
 rOUZu7wF1q+k6YcLr5rj013dMugV6XiFdOW9aq6MYs/IQac+30g=
X-Received: by 2002:a05:6a20:9150:b0:23d:40b6:3f9 with SMTP id
 adf61e73a8af0-23d7001472emr25589806637.13.1753773839449; 
 Tue, 29 Jul 2025 00:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTV48179HR5MFUtSXlj39tYk4e8rDuS3Cq0GGOZEDBKf+TcYwjIa7z8jAJXILPflgPXXyHQg==
X-Received: by 2002:a05:6a20:9150:b0:23d:40b6:3f9 with SMTP id
 adf61e73a8af0-23d7001472emr25589780637.13.1753773839082; 
 Tue, 29 Jul 2025 00:23:59 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.71])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b3d3d5esm7255693b3a.110.2025.07.29.00.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 00:23:58 -0700 (PDT)
Date: Tue, 29 Jul 2025 12:53:44 +0530
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
Subject: Re: [PATCH v7 01/24] migration: push Error **errp into
 vmstate_subsection_load()
Message-ID: <aIh3AOLHE8pyniMX@armenon-kvm.bengluru.csb>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
 <CAMxuvaznYbcpxc7dtDP5yVBzVcDJpVWVXHeWxB1zo0bfdBuw2g@mail.gmail.com>
 <CAMxuvawsX6ePZV=ek7d0rDwpJYQJmNwiFKhTetLW6u1PW6cTbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawsX6ePZV=ek7d0rDwpJYQJmNwiFKhTetLW6u1PW6cTbA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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

Hi Marc-André,

Thanks for the review.

On Mon, Jul 28, 2025 at 12:44:53PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 25, 2025 at 5:46 PM Marc-André Lureau <
> marcandre.lureau@redhat.com> wrote:
> 
> >
> >
> > On Fri, Jul 25, 2025 at 4:19 PM Arun Menon <armenon@redhat.com> wrote:
> >
> >> This is an incremental step in converting vmstate loading
> >> code to report error via Error objects instead of directly
> >> printing it to console/monitor.
> >> It is ensured that vmstate_subsection_load() must report an error
> >> in errp, in case of failure.
> >>
> >> Signed-off-by: Arun Menon <armenon@redhat.com>
> >> ---
> >>  migration/vmstate.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> index
> >> 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f2747906ddf9aca891b
> >> 100644
> >> --- a/migration/vmstate.c
> >> +++ b/migration/vmstate.c
> >> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>                                     void *opaque, JSONWriter *vmdesc,
> >>                                     Error **errp);
> >>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription
> >> *vmsd,
> >> -                                   void *opaque);
> >> +                                   void *opaque, Error **errp);
> >>
> >>  /* Whether this field should exist for either save or load the VM? */
> >>  static bool
> >> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>          field++;
> >>      }
> >>      assert(field->flags == VMS_END);
> >> -    ret = vmstate_subsection_load(f, vmsd, opaque);
> >> +    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> >>      if (ret != 0) {
> >>          qemu_file_set_error(f, ret);
> >>          return ret;
> >> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription *
> >> const *sub,
> >>  }
> >>
> >>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription
> >> *vmsd,
> >> -                                   void *opaque)
> >> +                                   void *opaque, Error **errp)
> >>  {
> >>      trace_vmstate_subsection_load(vmsd->name);
> >>
> >> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>          sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
> >>          if (sub_vmsd == NULL) {
> >>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> >> "(lookup)");
> >> +            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
> >> +                       idstr, vmsd->name);
> >>              return -ENOENT;
> >>          }
> >>          qemu_file_skip(f, 1); /* subsection */
> >> @@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const
> >> VMStateDescription *vmsd,
> >>          ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
> >>          if (ret) {
> >>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> >> "(child)");
> >> +            error_setg(errp,
> >> +                       "Loading VM subsection '%s' in '%s' failed : %d",
> >>
> >
> > extra space before ":"
> >
> > other than that
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> 
> Actually, almost systematically when you introduce an extra **errp
> argument, you should ERRP_GUARD() in the function (see include/qapi/error.h
> doc). Was this discussed before? Can you update the following patches too?

I see. Thanks. I shall add ERRP_GUARD() whenever errp is dereferenced or used with
error_prepend().

> 
> 
> >
> >> +                       idstr, vmsd->name, ret);
> >>              return ret;
> >>          }
> >>      }
> >>
> >> --
> >> 2.50.0
> >>
> >>

Regards,
Arun


