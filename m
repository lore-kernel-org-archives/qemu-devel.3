Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF244107BCCC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Mr-0004Sg-Gz; Fri, 13 Mar 2026 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w15Mo-0004SO-Px
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w15Mm-0008R5-7N
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773419279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dZ4ahfEdsN1/cO7MOlfzAYWoMq5q8WbafwlUN2pZ+E=;
 b=RF1Hqa8MYErcKvgw4dDZEqEi8SofuAdwKkowzFnbehr+46Ho7ZF1DuBMwBmZ+7KJEZtQtw
 0quYkiRAcRnE7M+MN+XNHIxW1JISa9d3pMELUMNseQOQhlsPoZwmZcuFM8QakAauqe11AD
 oZgR7qwPSEfwErSJuYPGgKh9Jm1Zog8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-NhsegLrFMqGPiFgDhEaHbQ-1; Fri, 13 Mar 2026 12:27:57 -0400
X-MC-Unique: NhsegLrFMqGPiFgDhEaHbQ-1
X-Mimecast-MFC-AGG-ID: NhsegLrFMqGPiFgDhEaHbQ_1773419277
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aece14b507so9145735ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773419276; x=1774024076; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5dZ4ahfEdsN1/cO7MOlfzAYWoMq5q8WbafwlUN2pZ+E=;
 b=IrURF27lL0SRC9WTEk5zAHvmJYPSxx7MOWNGzO1EFC2IMrIgS12oR/0ksl0BWKtdtI
 bXijAb+JcspAddTehjhirU51/kR6FKHEPq8rk634bEL5HhosrPEIwVt6YYqaDZ8JI782
 bgJVH6H4sWZOheuPnzaQe/nUsK7vTkrrvKRBONlZ4NAaxVpfy0MpLXWVzqde8JmlWoCV
 k0xGIDKQ4F+Oq/l02A2REDCC/mlhKVD8Gr8pcXtUAsihsdtAnJA9M9lEddFR6d91D+O5
 fqi5PdPYKg8/zoaHOlrVbdnrQ32WLcfq3LRYJ9RN31Q95PeYnQBiRi1Dk2r2VNIwTLAY
 TTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419276; x=1774024076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dZ4ahfEdsN1/cO7MOlfzAYWoMq5q8WbafwlUN2pZ+E=;
 b=FyJW3dCN3tom4wxv4/0McDqcWiPGXYl4ijsRdSYkqxWnGMmUZ+2AMd/NoOsq+7YmmV
 nlYr7F0+r6hOIdip2YwEY9usTMWkiR5sR7CsajFSj4c5+ts5el6ksy35ail1nD8yhq2I
 4nxeGuESC4N7TRTCxSnE1/yMoQ1kuvHHbAZ5CPQnkFJh/uhiY80uBfEt9CC5FJMrAnwT
 /HnGqm6I5kf24PsJkH7ypK4h92wDse3W9jg9RwCrHDM9vpJ1Z0XBpIW2qp7FzlBOfFqu
 TMujbo4LFjc3/VqCBm69343VH6qQr+nUJ3FzmMGp3+CucNpSQVDMgA1lPl0rihYYIdKJ
 Ns9A==
X-Gm-Message-State: AOJu0YwviCpoB2risCM5QYjpU0LEhGREEU+71J3QB30Q1EhnrKaX/eIf
 Ory4A+0cmVdsC8ax58KTGwn+D5kYUeeGcaKyXwSeQ65ejZ51O8e/jdHsIcxzcTVPmh5cGgzscd7
 H5b/nim5dOCqEHWdlwojkvI7aIFOje3s2eiiDJHE7Qkm92EwlrKnPh4SxIaVoWOpn
X-Gm-Gg: ATEYQzyiTsSsPfqJ5SEfJh1AdKggRNrct8lFSv+O6PXpILps7jkVEtwk4qTtUyqXLvC
 Y+9oBl1mqi8YcvVNM1e9iHbvnO/kJRvwGPpXqNkIli5km7z6mntVaxwpe7AkODkx+EM8Ua7BE1+
 ovx8Vndu/b7vfd+4UCFEO/D19E/BraOlsqx6fpkogPD4d5OrMRK9GuQvL4fSiOIFp6i1JslE7XO
 C9syTKYN0oYrEFEGNGZF7RyySm1LV6HTPCRTjicNZxOWExxmRQ7sMQ7894IaFuxbrS7ohsC4rnF
 TstLqdTGPzNEZYZv/p7V5J54VAdFWmP1d0CvtFsg51SyHrAI94v8j4LArI376SIz3rUt3SZ0KtY
 SC0I8t2KO5E07Zw==
X-Received: by 2002:a17:903:174e:b0:2ad:ab2c:d258 with SMTP id
 d9443c01a7336-2aeca927705mr35227555ad.14.1773419276509; 
 Fri, 13 Mar 2026 09:27:56 -0700 (PDT)
X-Received: by 2002:a17:903:174e:b0:2ad:ab2c:d258 with SMTP id
 d9443c01a7336-2aeca927705mr35227285ad.14.1773419276032; 
 Fri, 13 Mar 2026 09:27:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece60e6f6sm26380185ad.28.2026.03.13.09.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:27:55 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:27:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v4 1/8] migration/vmstate: introduce
 vmstate_{load,save}_field helpers
Message-ID: <abQ7CLuJsWRLwoe5@x1.local>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
 <20260313141221.359503-2-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313141221.359503-2-alexander@mihalicyn.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 13, 2026 at 03:12:14PM +0100, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Let's introduce vmstate_{load,save}_field() helpers, they will
> be used in next patches to support fully-dynamic arrays with NULLs.
> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Feel free to rebase to Vladimir's series here, Fabiano already queued it:

https://lore.kernel.org/all/20260304212303.667141-11-vsementsov@yandex-team.ru/#t

These codes weren't touched that frequent, it's interesting to see such
coinsidence happens. :)

> ---
>  include/migration/vmstate.h |  4 ++
>  migration/vmstate.c         | 84 +++++++++++++++++++++++--------------
>  2 files changed, 56 insertions(+), 32 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 62c2abd0c49..5d7dfe70643 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1240,8 +1240,12 @@ extern const VMStateInfo vmstate_info_qlist;
>          .flags = VMS_END, \
>      }
>  
> +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
> +                       const VMStateField *field, Error **errp);
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, int version_id, Error **errp);
> +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> +                       const VMStateField *field, JSONWriter *vmdesc, Error **errp);
>  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, JSONWriter *vmdesc, Error **errp);
>  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7ba..8d192bcaa27 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -131,6 +131,32 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
>      }
>  }
>  
> +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
> +                       const VMStateField *field, Error **errp)
> +{
> +    int ret = 0;
> +
> +    if (field->flags & VMS_STRUCT) {
> +        ret = vmstate_load_state(f, field->vmsd, pv,
> +                                 field->vmsd->version_id,
> +                                 errp);
> +    } else if (field->flags & VMS_VSTRUCT) {
> +        ret = vmstate_load_state(f, field->vmsd, pv,
> +                                 field->struct_version_id,
> +                                 errp);
> +    } else {
> +        ret = field->info->get(f, pv, size, field);
> +        if (ret < 0) {
> +            error_setg(errp,
> +                       "Failed to load element of type %s for %s: "
> +                       "%d", field->info->name,
> +                       field->name, ret);
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, int version_id, Error **errp)
>  {
> @@ -203,24 +229,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                      inner_field = field;
>                  }
>  
> -                if (inner_field->flags & VMS_STRUCT) {
> -                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> -                                             inner_field->vmsd->version_id,
> -                                             errp);
> -                } else if (inner_field->flags & VMS_VSTRUCT) {
> -                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> -                                             inner_field->struct_version_id,
> -                                             errp);
> -                } else {
> -                    ret = inner_field->info->get(f, curr_elem, size,
> -                                                 inner_field);
> -                    if (ret < 0) {
> -                        error_setg(errp,
> -                                   "Failed to load element of type %s for %s: "
> -                                   "%d", inner_field->info->name,
> -                                   inner_field->name, ret);
> -                    }
> -                }
> +                ret = vmstate_load_field(f, curr_elem, size, inner_field, errp);
>  
>                  /* If we used a fake temp field.. free it now */
>                  if (inner_field != field) {
> @@ -427,6 +436,29 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
>  }
>  
> +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> +                       const VMStateField *field, JSONWriter *vmdesc, Error **errp)
> +{
> +    int ret = 0;
> +
> +    if (field->flags & VMS_STRUCT) {
> +        ret = vmstate_save_state(f, field->vmsd, pv, vmdesc, errp);
> +    } else if (field->flags & VMS_VSTRUCT) {
> +        ret = vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
> +                                   field->struct_version_id, errp);
> +    } else {
> +        ret = field->info->put(f, pv, size, field, vmdesc);
> +        if (ret < 0) {
> +            error_setg(errp,
> +                       "Failed to save element of type %s for %s: "
> +                       "%d", field->info->name,
> +                       field->name, ret);
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                           void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
>  {
> @@ -528,19 +560,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
>                                        i, max_elems);
>  
> -                if (inner_field->flags & VMS_STRUCT) {
> -                    ret = vmstate_save_state(f, inner_field->vmsd,
> -                                             curr_elem, vmdesc_loop, errp);
> -                } else if (inner_field->flags & VMS_VSTRUCT) {
> -                    ret = vmstate_save_state_v(f, inner_field->vmsd,
> -                                               curr_elem, vmdesc_loop,
> -                                               inner_field->struct_version_id,
> -                                               errp);
> -                } else {
> -                    ret = inner_field->info->put(f, curr_elem, size,
> -                                                 inner_field, vmdesc_loop);
> -                }
> -
> +                ret = vmstate_save_field(f, curr_elem, size, inner_field, vmdesc_loop, errp);
>                  written_bytes = qemu_file_transferred(f) - old_offset;
>                  vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
>                                      written_bytes);
> @@ -551,7 +571,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  }
>  
>                  if (ret) {
> -                    error_setg(errp, "Save of field %s/%s failed",
> +                    error_prepend(errp, "Save of field %s/%s failed: ",
>                                  vmsd->name, field->name);
>                      if (vmsd->post_save) {
>                          vmsd->post_save(opaque);
> -- 
> 2.47.3
> 

-- 
Peter Xu


