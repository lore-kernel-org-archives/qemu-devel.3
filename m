Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E8DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cf3-00041s-HG; Thu, 03 Sep 2026 14:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Cf1-00041k-IH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2Cez-0000vs-PR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788461973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=burJXO1lgJPvsBdQGS+bw4ido0VILrY1yGSw+k1bRYE=;
 b=RAuVl8ZJud2i3bC+mLVn64D/DnUD0DjBMG8rmbyaPUsu/ciob9u92x77xZsiDXv5d1wA2F
 WtbniIwoIGzCPjwtUrF7tCHfaTRkhONbaD7IRky11hFTy/PlznoHm9oGU5jqDgpFrbKINP
 U6Ppoi+myIJdgdDAsnIXv8fUxcNRN1k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-OS9PMWKwOI6PKJNW6gYkIQ-1; Thu, 03 Sep 2026 14:59:16 -0400
X-MC-Unique: OS9PMWKwOI6PKJNW6gYkIQ-1
X-Mimecast-MFC-AGG-ID: OS9PMWKwOI6PKJNW6gYkIQ_1788461953
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so26407585a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788461953; x=1789066753; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=burJXO1lgJPvsBdQGS+bw4ido0VILrY1yGSw+k1bRYE=;
 b=o2OP0u5BQx66arLiNtlfolLfCKboBWtpLLikr+OQW+QQtnou43qEImHmEtLSmYLj1c
 402bCLwZ6B7/8wb9/qoWwu3oImJtcmC+BNvrRpZP9VCbUCCbRMvKcXSKsjQxNU+Q2eu+
 Ug1FM+4MohHxwS0ug/FUT9xOblopQqOk/Yv+jLotjrGnfuk5xU5pK42VlA5I+MUeJkIo
 qTnkyPUf/47zJXkdqCKKfxd4UbvAHso2V0Wpu2VpiKJBn3FuVdWDcLQPzK2H+B6F2QnT
 09z0W1tIC5WEKfT3REShW97wn7yeopeo0gG4hZ6+KS1r27LmCV6BW/rc0yBRgCDpJKv/
 +QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461953; x=1789066753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=burJXO1lgJPvsBdQGS+bw4ido0VILrY1yGSw+k1bRYE=;
 b=AX36RjeK1DAZdMCvqBYS/M9E+9LhmEH7MDrhlAdbgVZhS95jbpFsz+S0IMs/9Iz3Ad
 CLzwNuwsOIL0qc1TlmHIzFmBxuN5d8ZneKrxEKKPGCKTEeYqxMAJ6ICdXp0PMJxDRF0v
 Ru3218TE7QIf7zYfxXtQ2qPXKwRkbYeOfqZJtH8J0Vn4aFojMOW6IiCjVXjWibuTrKWO
 597WGWFPDxfPJdduSggERzTfozbYfhVUTfBCIBhtrGLuFWBVEGy6V/nOHWq8Amc8rrMy
 nIp+Z+Zq+Us6imXqMPhcdKyui6MGHqEdISNmcUAYwVVwQz7vIZelPaatMrkFdsO4u8Zg
 yORQ==
X-Gm-Message-State: AFuF++kx2uhumPHEc94xeiyae/qHxNo+qk+5Z2LoodcdfDE2Xd4FymId
 dx63mHcYzfiX2MZzkx9P3JmtyPzH5wYD6kytbpGWuMBGqxw6LeQ95+HHHRGMtL6x1B+brwNNjPc
 hei7+HqwKx4X0c9KohXzay9ThVFzgZpqnLzIHvb3o4D80VrVl0XSAMip2pUZZmLJ/WA4=
X-Gm-Gg: AYBFou3fDYYDdd9cTLqn1e8/hxHXYJjEiBMuQuDMhbjmH0lcRD6XBksSaoI1iba8P60
 doC2/2lUuPEI2cy060iIt1q5YnQLGLNGPs8NxcFYgYhyNSWjdqMG6Npv3NC3ZurAQoqtzmyhVq2
 sA0O/Ce4S+Qkdb5q7sR9XBraoIWiC96t5Itaitoa+Q6Odl1L94HoNL+X3yWXEbSqVyVHQXpqCW7
 tkmbkpV4YEtcM6m6FEOaYT7HmDt+RzRl0DICH/rw6CQ3NV0UVXvuRDbMCZQugonj4weSStjALzO
 +5bITnTBZhVUpShcGPVoY4MRQUTx8qemOb8oJwsVrcwTuF7COEjefVrC+Cw/l6zsnlTOVE/Q4PR
 SEJ62m+iyPxCXU+Q61J3dJKaLFrLpLoQQUnUCve0QDt8JObNYZYzdbo3uV0g=
X-Received: by 2002:a05:6214:8403:b0:90d:68e1:125a with SMTP id
 6a1803df08f44-9103eff963amr11651296d6.20.1788461952652; 
 Thu, 03 Sep 2026 11:59:12 -0700 (PDT)
X-Received: by 2002:a05:6214:8403:b0:90d:68e1:125a with SMTP id
 6a1803df08f44-9103eff963amr11650766d6.20.1788461951954; 
 Thu, 03 Sep 2026 11:59:11 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406b1056sm1084576d6.44.2026.09.03.11.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:59:11 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:59:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 10/18] migration: Validate that all params are set for
 query
Message-ID: <apnDfpdyAzo2Vuwc@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 02, 2026 at 07:15:38PM -0300, Fabiano Rosas wrote:
> There are a couple of situations where all fields of a
> MigrationParameters object need to be marked as present: when cloning
> an entire object and when creating the transient object in
> qmp_query_migrate(). The query-migrate-parameters QMP command contract
> requires that all parameters, except block-bitmap-mapping, are present
> in the output.
> 
> Validate that a given object has all has_* fields set to true.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/migration/options.c b/migration/options.c
> index bd7be8f9832..5d17acdd881 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
>  #include "exec/target_page.h"
> @@ -23,8 +24,10 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qobject-output-visitor.h"
> +#include "qobject/qbool.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qnull.h"
> +#include "qobject/qstring.h"
>  #include "system/runstate.h"
>  #include "migration/colo.h"
>  #include "migration/cpr.h"
> @@ -1149,12 +1152,63 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>      }
>  }
>  
> +static bool assert_all_params_present(MigrationParameters *params, Error **errp)
> +{
> +    g_autoptr(QDict) d = migrate_params_to_dict(params, errp);
> +    const QDictEntry *e = NULL;
> +    int i = 0;
> +
> +    if (!d) {
> +        return false;
> +    }
> +
> +    for (e = qdict_first(d); e; e = qdict_next(d, e), i++) {
> +        const char *key = qdict_entry_key(e);
> +        const char *p;
> +
> +        if (strstart(key, "tls-", &p)) {
> +            QString *s = qobject_to(QString, qdict_entry_value(e));
> +
> +            if (!s) {
> +                break;
> +            }
> +        } else if (strstart(key, "has-", &p)) {

Does the qdict contain any has- field?  

visit_type_MigrationParameters_members:

    if (visit_optional(v, "announce-initial", &obj->has_announce_initial)) {
        if (!visit_type_size(v, "announce-initial", &obj->announce_initial, errp)) {
            return false;
        }
    }
    ...

It seems the has_* fields are only used to identify existance of objects,
not converted.

> +            if (qdict_haskey(d, p)) {
> +                QBool *b = qobject_to(QBool, qdict_entry_value(e));
> +
> +                if (!b || !qbool_get_bool(b)) {
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +
> +    if (i && !e) {
> +        return true;
> +    }
> +
> +    /*
> +     * Should never happen, but avoid asserting becase this is
> +     * reachable from QMP.

IIUC as long as this fact shouldn't be changed by any possible user input,
we could still assert.  But I understand you want to be careful, maybe
either (1) directly assert, or (2) change the function name,
s/assert/check/?  I vote (1).

Said that, if the qdict trick didn't work it beats the whole patch.. so
IMHO we can also leave this sanity check for later too.  Your call.

> +     */
> +    error_setg(errp, "Missing parameter. Query output will be incomplete.");
> +    return false;
> +}
> +
>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
>      MigrationParameters *params = QAPI_CLONE(MigrationParameters,
>                                               &s->parameters);
>  
> +    /*
> +     * Validate all parameters have their has_* field set to true as
> +     * consequence of the initial migrate_mark_all_params_present().
> +     */
> +    if (!assert_all_params_present(params, errp)) {
> +        return NULL;
> +    }
> +
>      /*
>       * The block-bitmap-mapping breaks the expected API of
>       * query-migrate-parameters of having all members present. To keep
> -- 
> 2.53.0
> 

-- 
Peter Xu


