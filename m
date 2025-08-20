Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78724CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uomhZ-0003lv-3h; Wed, 20 Aug 2025 13:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomhX-0003jp-ET
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomhV-0007hL-OY
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755711257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAYPmRjLK2JT8OxqEmRXZOdxCH50AT3017fdk1SrtmQ=;
 b=O850Jny8BrDnnKmdpAblg9PpxYBTWDErQHa6Fm7FbGpQhvxupU4HMVCSdIL7pvucGxVbTK
 VOdbW8mPn1OM3mCSnGHWaPs0ab3GlwZ9TyEg8uIhggDFKl6VNFvdUNf5IiaglwrzY8Anwa
 AqkPAW26mqt0vsfj0dPnuQkbzAI5w5s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-kFTQqTB_NXidzL4au1Pc1w-1; Wed, 20 Aug 2025 13:34:15 -0400
X-MC-Unique: kFTQqTB_NXidzL4au1Pc1w-1
X-Mimecast-MFC-AGG-ID: kFTQqTB_NXidzL4au1Pc1w_1755711255
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b47174b3427so31200a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755711254; x=1756316054;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KAYPmRjLK2JT8OxqEmRXZOdxCH50AT3017fdk1SrtmQ=;
 b=NEPb+Z8W7M85NbjQgOxQdySANqoxAXxG/cnjy1zxEAz/blVQ3kyG0xhgB712JrTZSP
 9XS8kt/Z+qwHi+vEaFjuGkFGN0CY0WG/It0cFX0VuxywApFXVUFLO8Hy9yEPRsLe5fYA
 jXa5c7oD+s/Hnu7wld6F+A41df3aRrK37355mkjIGkUtwc4xDBAyU1C9WeQqjkCitFP1
 e3ameWnXZHv/ZlAVH0Vosw14nucgr1tS+Af2r0TFqgX2hw/HuIByO1WEV+uHsG0gfGYE
 KguIVIqHby65Wxr+9C//zskLdWGF+WHSKYg1OfCKrpjAdIbU2MEfShMDkjGTcY0h+WuB
 b+hg==
X-Gm-Message-State: AOJu0Yx0JVpz1kS/Tmrj0jziZKgFgsBzyilkb/KRkKUw8VWGmuanTZsL
 giHFLaU2io2kugFdwryCLkqzLgdx5dEYolRg7T6XQmslNO4ZemdgKh5i3xTFFpEzm68DX3k0l3l
 KAFf0jR3G69ZWUG4oYaEHU+PnsnTJRg59HE6kzUVsSp/C72vkoHRpQ/9FoI+yZ3qD
X-Gm-Gg: ASbGncuCoKow/dbT09QqXgPixKT4WaluwaObE9U7x1wR8J/1h7NIdi3Hz70zzytkmee
 N+IOLfiZFmKFSP3ky3iylXmbv+RDOhP3YHjhytaSzA9exRXX+J94hXug4v96h8cSUiLgpaqj+dB
 VEV9AnFiF+DQfmlhDbqaRr4XSdMp5gqQyBZt+OpenN4HaIWdgNZQ8LRWdn4LUDG9IcLtvNwg0c6
 kusZmGzPI70VCAIFdr7Bh1ukSMqzOzENJIotHuUaxFR0VHjcfZyOnefh1qFpAYsvO2TslqKZuuP
 p7iAT81Xmbeta0/2y7j1HqAZSe9w5HIfrby0Soxm00/DcV0GpAz+
X-Received: by 2002:a17:902:db09:b0:240:a05:5b79 with SMTP id
 d9443c01a7336-245ef264741mr49730845ad.44.1755711254537; 
 Wed, 20 Aug 2025 10:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEggirgiDE1gEOu8HKe1pyOk4Jpv3kW9nGcd073MRR9aOl758SHjytrzYp1p81xjFP8oHtqCQ==
X-Received: by 2002:a17:902:db09:b0:240:a05:5b79 with SMTP id
 d9443c01a7336-245ef264741mr49730515ad.44.1755711254086; 
 Wed, 20 Aug 2025 10:34:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed537978sm31823855ad.152.2025.08.20.10.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:34:13 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:04:01 +0530
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
Subject: Re: [PATCH v11 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
Message-ID: <aKYHCX74CMtYbRRJ@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-11-b470a374b42d@redhat.com>
 <87y0rkxtrr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0rkxtrr.fsf@suse.de>
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

On Fri, Aug 15, 2025 at 04:35:36PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_section_part_end() must report an error
> > in errp, in case of failure.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/savevm.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 77408347c1f1ca7eb3a04f8f130c20a5a81f6db2..ff2e4f75e070d0f452414f28435905928b1480a7 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2806,21 +2806,20 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
> >  }
> >  
> >  static int
> > -qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> > +qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      bool trace_downtime = (type == QEMU_VM_SECTION_END);
> >      int64_t start_ts, end_ts;
> >      uint32_t section_id;
> >      SaveStateEntry *se;
> >      int ret;
> > -    Error *local_err = NULL;
> >  
> >      section_id = qemu_get_be32(f);
> >  
> >      ret = qemu_file_get_error(f);
> >      if (ret) {
> > -        error_report("%s: Failed to read section ID: %d",
> > -                     __func__, ret);
> > +        error_setg(errp, "Failed to read section ID: %d", ret);
> >          return ret;
> >      }
> >  
> > @@ -2831,7 +2830,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> >          }
> >      }
> >      if (se == NULL) {
> > -        error_report("Unknown savevm section %d", section_id);
> > +        error_setg(errp, "Unknown savevm section %d", section_id);
> 
> Drop "savevm" please.
yes, will do.
> 
> >          return -EINVAL;
> >      }
> >  
> > @@ -2839,11 +2838,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> >          start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> >      }
> >  
> > -    ret = vmstate_load(f, se, &local_err);
> > +    ret = vmstate_load(f, se, errp);
> >      if (ret < 0) {
> > -        error_report("error while loading state section id %d(%s)",
> > -                     section_id, se->idstr);
> > -        warn_report_err(local_err);
> > +        error_prepend(errp, "error while loading state section id %d(%s): ",
> > +                      section_id, se->idstr);
> >          return ret;
> >      }
> >  
> > @@ -2854,6 +2852,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> >      }
> >  
> >      if (!check_section_footer(f, se)) {
> > +        error_setg(errp, "Check section footer error, section_id: %d",
> 
> This became not very grammatical, maybe drop the "Check" word.
sure, will do.
> 
> > +                   section_id);
> >          return -EINVAL;
> >      }
> >  
> > @@ -3112,7 +3112,7 @@ retry:
> >              break;
> >          case QEMU_VM_SECTION_PART:
> >          case QEMU_VM_SECTION_END:
> > -            ret = qemu_loadvm_section_part_end(f, section_type);
> > +            ret = qemu_loadvm_section_part_end(f, section_type, errp);
> >              if (ret < 0) {
> >                  goto out;
> >              }
> > @@ -3136,9 +3136,6 @@ retry:
> >  
> >  out:
> >      if (ret < 0) {
> > -        if (*errp == NULL) {
> > -            error_setg(errp, "Loading VM state failed: %d", ret);
> > -        }
> 
> Good. Could have been mentioned in that patch's commit message, or even
> a /* temporary */ comment in the code.
Yes, I shall add it in the commit message.
> 
> >          qemu_file_set_error(f, ret);
> >  
> >          /* Cancel bitmaps incoming regardless of recovery */
> 
Regards,
Arun


