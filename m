Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF7C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD286-0004PT-6Z; Thu, 08 May 2025 10:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD282-0004Oc-RP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD280-00029C-OD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746714093;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kiSrQW58eFNaPziWORRpwOQ4lMXT8a4bS9W7ZZ7NHa4=;
 b=Ce8pIyQ5TDQPRGbSmjD1feOBx5bZ6CP4Cxd8Qfvvhe5J1uylwKfyRbh9VQEuQBRJrEk/nP
 J8PCBPkoXyQj6ryt36TWpq+tAydrWTaJ/373unhfHzOC4jURg970zrk8RcnSv2rF2g4MZ3
 iYMC3SLlWhNIlUmqkBXvPVQe4zCV8Zg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-a8o8cdyTOseidK4Ko-Wn4A-1; Thu,
 08 May 2025 10:21:29 -0400
X-MC-Unique: a8o8cdyTOseidK4Ko-Wn4A-1
X-Mimecast-MFC-AGG-ID: a8o8cdyTOseidK4Ko-Wn4A_1746714088
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D9FE1955D60; Thu,  8 May 2025 14:21:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B969A18004A7; Thu,  8 May 2025 14:21:23 +0000 (UTC)
Date: Thu, 8 May 2025 15:21:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 03/13] qobject/qlit: allow to hide dict or list entries
Message-ID: <aBy94N6JSwDj53mb@redhat.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-4-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507231442.879619-4-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 07, 2025 at 04:14:33PM -0700, Pierrick Bouvier wrote:
> We add a new .hidden field to qlit entries, which gets ignored when
> creating the associated QObject.
> By default .hidden is 0, so it means the entry is visible. This way,
> only potentially hidden elements need to be assigned.

IMHO this feels like a somewhat dubious concept to have in the
qobject code, as it is quite specialized to a single use case.
A more general purpose approach would be to have some mechanism
for cloning while applying a data filter, though I admit that
may be more tedious to actually use.

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  include/qobject/qlit.h | 12 ++++++++++++
>  qobject/qlit.c         | 10 ++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qobject/qlit.h b/include/qobject/qlit.h
> index c0676d5daf2..3b66c22013c 100644
> --- a/include/qobject/qlit.h
> +++ b/include/qobject/qlit.h
> @@ -28,25 +28,37 @@ struct QLitObject {
>          QLitDictEntry *qdict;
>          QLitObject *qlist;
>      } value;
> +    bool hidden;
>  };
>  
>  struct QLitDictEntry {
>      const char *key;
>      QLitObject value;
> +    bool hidden;
>  };
>  
>  #define QLIT_QNULL \
>      { .type = QTYPE_QNULL }
>  #define QLIT_QBOOL(val) \
>      { .type = QTYPE_QBOOL, .value.qbool = (val) }
> +#define QLIT_QBOOL_HIDDEN(val, cond) \
> +    { .type = QTYPE_QBOOL, .value.qbool = (val), .hidden = (cond) }
>  #define QLIT_QNUM(val) \
>      { .type = QTYPE_QNUM, .value.qnum = (val) }
> +#define QLIT_QNUM_HIDDEN(val, cond) \
> +    { .type = QTYPE_QNUM, .value.qnum = (val), .hidden = (cond) }
>  #define QLIT_QSTR(val) \
>      { .type = QTYPE_QSTRING, .value.qstr = (val) }
> +#define QLIT_QSTR_HIDDEN(val, cond) \
> +    { .type = QTYPE_QSTRING, .value.qstr = (val), .hidden = (cond) }
>  #define QLIT_QDICT(val) \
>      { .type = QTYPE_QDICT, .value.qdict = (val) }
> +#define QLIT_QDICT_HIDDEN(val, cond) \
> +    { .type = QTYPE_QDICT, .value.qdict = (val), .hidden = (cond) }
>  #define QLIT_QLIST(val) \
>      { .type = QTYPE_QLIST, .value.qlist = (val) }
> +#define QLIT_QLIST_HIDDEN(val, cond) \
> +    { .type = QTYPE_QLIST, .value.qlist = (val), .hidden = (cond) }
>  
>  bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
>  
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index a44f47eaa57..7b372c5ebaa 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -90,6 +90,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
>  
>  QObject *qobject_from_qlit(const QLitObject *qlit)
>  {
> +    g_assert(!qlit->hidden);
> +
>      switch (qlit->type) {
>      case QTYPE_QNULL:
>          return QOBJECT(qnull());
> @@ -102,7 +104,9 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
>          QLitDictEntry *e;
>  
>          for (e = qlit->value.qdict; e->key; e++) {
> -            qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
> +            if (!e->hidden) {
> +                qdict_put_obj(qdict, e->key, qobject_from_qlit(&e->value));
> +            }
>          }
>          return QOBJECT(qdict);
>      }
> @@ -111,7 +115,9 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
>          QLitObject *e;
>  
>          for (e = qlit->value.qlist; e->type != QTYPE_NONE; e++) {
> -            qlist_append_obj(qlist, qobject_from_qlit(e));
> +            if (!e->hidden) {
> +                qlist_append_obj(qlist, qobject_from_qlit(e));
> +            }
>          }
>          return QOBJECT(qlist);
>      }
> -- 
> 2.47.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


