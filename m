Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA34C88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x531A-0005qf-L8; Fri, 11 Sep 2026 11:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x530q-0005op-Vr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x530m-0003DW-Oj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 11:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789139875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfaWqqyO8gvyp3qnq95D5wAfhYF8iSoQljIemyIx7+k=;
 b=Zg0+/friAfpWfJ/DpFb5ZkfFVlHkE/AVMbJkhOM30n6TFbNAExJL89pxj9bq5F9fAivgWN
 OV/ab+8E+w+hwwt8C0H5ybnXISsHRYJkCZPxyAyAshF+GijF7W/4KjiTKcp+DxRyDJHU9n
 +grQQeOAYChiE+ueG2yA9XJYGVuUZuw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-53BJmrL4OzKnJDizIpB1Hg-1; Fri, 11 Sep 2026 11:17:49 -0400
X-MC-Unique: 53BJmrL4OzKnJDizIpB1Hg-1
X-Mimecast-MFC-AGG-ID: 53BJmrL4OzKnJDizIpB1Hg_1789139868
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so2014502a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 08:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789139868; cv=none;
 d=google.com; s=arc-20260327;
 b=XWXYkJAjulMFdx5+an8yQTtM1W6YMDmwFQXznrl++3HW/OZWlk+KhZ1cqoZC0bWJlZ
 ycoWZkKQyo5dP+jOG87Ug6IXrstmp7LWsXwUZPV6X9PPxo/0roPyfS8Jv7H6jQnyY+SJ
 /3l8WEgUKNhZyzmZOiMUDclKbSRMrLp3H16/WpWeHsBn9xW3MYdc+V/VumSexPak0tuJ
 hM3C+7SgoDbqthBdi7XfeZm+bcRA7khkci95CQ4whRFSsOVja7UnBDLwETmPFfymvbqV
 f45x8EQ2kzH8QMpqLo37ZRiCKLrmHlPfVmexcgxGTt+Q65ZfPlSs7nqoXTmoYFFObiNI
 fGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DfaWqqyO8gvyp3qnq95D5wAfhYF8iSoQljIemyIx7+k=;
 fh=kVqT8nwHqHmlaAOviuXKe6zYg+wzAfyLrv1OrbBX+/g=;
 b=LfvNBV2kLR9eWHX+mZAUvMar1o6wdWeJ6mUIg1insgHTUC2LLiBgnb/eLmJNU1Rv9j
 fJ6XDwmmuixFncLAzYu57DrhgKWFFsXyUkBMiA1DaglHs53tidOwW5XwwbewTnOstMOR
 JqlUq613AEUAmsj+Tz7XnQ1EkUxzva+UXZO1tQb0Rs/HUIHs1HYpH1yfdwYh15z/twqI
 jy+CHWaqPgBefD93HsP7m155PcyLAUh2fogmNN7c7h5aLp0rJDWWfFEhwdsFzpAYnZos
 j8mESRDyb3smWYvBuXgLvK8XiM0VthEfJ9/kLIm4oagmAjJvqKTizeG1wtp11ouLzFey
 zQbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789139868; x=1789744668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DfaWqqyO8gvyp3qnq95D5wAfhYF8iSoQljIemyIx7+k=;
 b=Lg6+ISc4NSXYJSTPsBmSVgR5HJLvTsj7WCpC+8JT+HHAmJEHEtROMMk8e6SMsWsoC0
 PXdag8oz+bgzs0mXXkUmsv4Nrn9Uct7EyNCXmRvDC+ymrX0sbv6lMhQ8otItq2bU31NY
 woBwZYquNh4qAhNv7VK7mfD7TaGD3BbRYMYrOEnU+j/4V8P1fVkDY8STXuDuNFoKrMkf
 vlJXpUWsnkHNLUl0BE8wa7jyftWDlkuOvqM5CKHa9Wa9tg3QGqCpIATiLGKB+NP7opHa
 dirGmW+Pr4jaW/zv/O73Qh7WDo/PjK8boLmv54L4Qg64QWqlhH4ZXEigZNB50OppwtZv
 BnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139868; x=1789744668;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DfaWqqyO8gvyp3qnq95D5wAfhYF8iSoQljIemyIx7+k=;
 b=JCvHpvzK6E8W/ttbqKD8B5K/jXuVaQb2VqWL2lt84rWDGD+KpHnvl745SghB/nqTdS
 lbTf4FIFZV154l1EqkXc1PuUzlfjBTuK4H0691FpHKgGZqaQd+oJtkEr8mZ7DaTM6lmw
 XOmCPzEuTCI5Egde/kJNPmGjixa7N1rNY11f2Pipc/YIHA1s3VN/85JvBpYqJQGVhvtS
 JD3q5H5EWUlAxjB+45pExMTQl8LZGZa7iDJ5CF5dX6wayPQ40hEMx3XKfu95QqcqmOX1
 RzTGJI6f8gQgm1Kjv2HwiQtk64u15ZfwskDhhteLSgXZygJ6E6esParkO1qNkOnexiqL
 N3nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTMwabQk6GUsOZQezQCvHbHuhoFwIQzfmYPJJWNhbu8p6GcGZIqlUjfXTgi/8tzvde4P7nXKRXpJZ6@nongnu.org
X-Gm-Message-State: AFuF++kKSUktAKXFx4iWXoKYHvYJ8H2zNd9jwJrI3vrRs/Xz6mbjfwY8
 wxOtec+JH7xNmPr9zJXDn2jmWlE9RKz791UO8nYWxBP5OPF9H5zB+yzK46P2jJpN1lf6nAmH+Cy
 S7sqxkEl3IHIC4lH4teLe/lr2ZxgIsa95dfr1aYDK8J6YQ1hdsAGgtHkse2vubmY4p75+I+xFxW
 BgBKyoyZOODFXveSCTiEcYSfxDO3dB/8A=
X-Gm-Gg: AYBFou03lZjiyBpoNQpARTpE3qGU2bnLc2uK/QG1RQkaXj/7lnm8o5BjGh0BKRHDt0w
 yXF1GLmGYJMcLFwPN2NmGmPTEtbTTOlBkrDD9dCmJym+yB0QxgKaSdBMyu3JdPYpGIWNhUNFeD4
 9GxcGhOkU+Kz3rdGPniVrKQ/dtGmseltdXb5phGTlypjuZxe+b9H4RcRB+AnXJW2jm2lNCIb8Jj
 2vSKvo7vS3JfUQHg5RVkyHbzjxLMMbTo9zCyu0dKnB5yRLyLswp3kg8ohZcKeilDomCffTFUbEh
 2w==
X-Received: by 2002:a17:90b:1d49:b0:398:9be5:b417 with SMTP id
 98e67ed59e1d1-39d9c1fc96emr7639676a91.18.1789139868140; 
 Fri, 11 Sep 2026 08:17:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1d49:b0:398:9be5:b417 with SMTP id
 98e67ed59e1d1-39d9c1fc96emr7639588a91.18.1789139867424; Fri, 11 Sep 2026
 08:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-30-a985f168e938@redhat.com>
 <20260911000458.a11b142b-df-amachhiw@linux.ibm.com>
In-Reply-To: <20260911000458.a11b142b-df-amachhiw@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 19:17:36 +0400
X-Gm-Features: AcwNN1XBs66B27MLcph_OdhuyEajh7LYWfzVPLtSsda0PkcUUW7hqiDLKprRIUo
Message-ID: <CAMxuvaxwu60jQmM4FxaokeVTUj1_brVSOdvEUZBTqdr93ZfiZw@mail.gmail.com>
Subject: Re: [PATCH v4 30/75] ppc/spapr-caps: convert to QAPI-aware property
 registration
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Thu, Sep 10, 2026 at 10:45=E2=80=AFPM Amit Machhiwal <amachhiw@linux.ibm=
.com> wrote:
>
> On 2026/09/04 11:58 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The patch itself looks correct, but the commit message is missing a body.=
  At
> minimum, it should describe what is being converted and why.

Agree, but when you have dozen or more patches, it feels awkward to
repeat the same message. And if you need to fix it, it's a pain. I
added it for this patch.

>
> One thing worth calling out explicitly is `SPAPR_CAP_HPT_MAXPAGESIZE`.  T=
his is
> not a purely mechanical conversion: the old property type string was `"in=
t"`,
> while `spapr_cap_get_pagesize()` and `spapr_cap_set_pagesize()` use
> `visit_type_size()`.  Thus, the property has effectively had size semanti=
cs
> despite the old `"int"` type string.

Good point, I should have made a preliminary commit (like I did for
other properties that are now fixed upstream)

>
> Switching this to `&size_type_info` therefore also fixes a pre-existing m=
ismatch
> between the property's declared type and the visitor used by its getter/s=
etter.
> This seems worth documenting in the commit message so that future readers
> understand that the change is intentional.
>
> The conversion itself, including the switch to
> `object_class_property_add_qapi()` in `spapr_caps_add_properties()`, look=
s
> correct to me.
>
> Thanks,
> Amit

thanks

>
> > ---
> >  hw/ppc/spapr_caps.c | 39 ++++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 0d659e9b0251..e622c79eb52a 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -24,6 +24,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/qapi-builtin-type-infos.h"
> >  #include "qapi/error.h"
> >  #include "qapi/visitor.h"
> >  #include "system/hw_accel.h"
> > @@ -59,7 +60,7 @@ typedef struct SpaprCapabilityInfo {
> >      /* Getter and Setter Function Pointers */
> >      ObjectPropertyAccessor *get;
> >      ObjectPropertyAccessor *set;
> > -    const char *type;
> > +    const QAPITypeInfo *type;
> >      /* Possible values if this is a custom string type */
> >      SpaprCapPossible *possible;
> >      /* Make sure the virtual hardware can support this capability */
> > @@ -725,7 +726,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_HTM,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_htm_apply,
> >      },
> >      [SPAPR_CAP_VSX] =3D {
> > @@ -734,7 +735,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_VSX,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_vsx_apply,
> >      },
> >      [SPAPR_CAP_DFP] =3D {
> > @@ -743,7 +744,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_DFP,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_dfp_apply,
> >      },
> >      [SPAPR_CAP_CFPC] =3D {
> > @@ -752,7 +753,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_CFPC,
> >          .get =3D spapr_cap_get_string,
> >          .set =3D spapr_cap_set_string,
> > -        .type =3D "string",
> > +        .type =3D &str_type_info,
> >          .possible =3D &cap_cfpc_possible,
> >          .apply =3D cap_safe_cache_apply,
> >      },
> > @@ -762,7 +763,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_SBBC,
> >          .get =3D spapr_cap_get_string,
> >          .set =3D spapr_cap_set_string,
> > -        .type =3D "string",
> > +        .type =3D &str_type_info,
> >          .possible =3D &cap_sbbc_possible,
> >          .apply =3D cap_safe_bounds_check_apply,
> >      },
> > @@ -774,7 +775,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_IBS,
> >          .get =3D spapr_cap_get_string,
> >          .set =3D spapr_cap_set_string,
> > -        .type =3D "string",
> > +        .type =3D &str_type_info,
> >          .possible =3D &cap_ibs_possible,
> >          .apply =3D cap_safe_indirect_branch_apply,
> >      },
> > @@ -784,7 +785,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_HPT_MAXPAGESIZE,
> >          .get =3D spapr_cap_get_pagesize,
> >          .set =3D spapr_cap_set_pagesize,
> > -        .type =3D "int",
> > +        .type =3D &size_type_info,
> >          .apply =3D cap_hpt_maxpagesize_apply,
> >          .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
> >      },
> > @@ -794,7 +795,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_NESTED_KVM_HV,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_nested_kvm_hv_apply,
> >      },
> >      [SPAPR_CAP_NESTED_PAPR] =3D {
> > @@ -803,7 +804,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_NESTED_PAPR,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_nested_papr_apply,
> >      },
> >      [SPAPR_CAP_LARGE_DECREMENTER] =3D {
> > @@ -812,7 +813,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_LARGE_DECREMENTER,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_large_decr_apply,
> >          .cpu_apply =3D cap_large_decr_cpu_apply,
> >      },
> > @@ -822,7 +823,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_CCF_ASSIST,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_ccf_assist_apply,
> >      },
> >      [SPAPR_CAP_FWNMI] =3D {
> > @@ -831,7 +832,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_FWNMI,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_fwnmi_apply,
> >      },
> >      [SPAPR_CAP_RPT_INVALIDATE] =3D {
> > @@ -840,7 +841,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_RPT_INVALIDATE,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_rpt_invalidate_apply,
> >      },
> >      [SPAPR_CAP_AIL_MODE_3] =3D {
> > @@ -849,7 +850,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_AIL_MODE_3,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_ail_mode_3_apply,
> >      },
> >      [SPAPR_CAP_DAWR1] =3D {
> > @@ -858,7 +859,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .index =3D SPAPR_CAP_DAWR1,
> >          .get =3D spapr_cap_get_bool,
> >          .set =3D spapr_cap_set_bool,
> > -        .type =3D "bool",
> > +        .type =3D &bool_type_info,
> >          .apply =3D cap_dawr1_apply,
> >      },
> >  };
> > @@ -1069,9 +1070,9 @@ void spapr_caps_add_properties(SpaprMachineClass =
*smc)
> >          g_autofree char *name =3D g_strdup_printf("cap-%s", cap->name)=
;
> >          g_autofree char *desc =3D g_strdup(cap->description);
> >
> > -        object_class_property_add(klass, name, cap->type,
> > -                                  cap->get, cap->set,
> > -                                  NULL, cap);
> > +        object_class_property_add_qapi(klass, name, cap->type,
> > +                                       cap->get, cap->set,
> > +                                       NULL, cap);
> >
> >          object_class_property_set_description(klass, name, desc);
> >      }
> >
> > --
> > 2.55.0.543.g5ebe2ebe4ea8
> >
> >
>


