Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96411C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Oly-0003mF-7b; Wed, 09 Sep 2026 16:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Ols-0003lX-SR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Olr-0006py-8h
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNAIKDhWO1ziELRQCM7vqLse6e62WwSuBzfQUcFNx2s=;
 b=dBVZi3Z33je/CQLu8p+B88n8ORYuImcF6mHEs9e3uAelGORMhsbnbMF8Aryu8iojPZJZhn
 B5ofyV5PffmMCU8903Lip1cZ9UalcnlH4CSyrjSe4cIJ5inb1YmxDtizffZ4esRb6OUC78
 poLqob11Kr0JDWW2hbUQHDjhuRj748w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-brxsv5YZMBmroVVYJmFfdQ-1; Wed,
 09 Sep 2026 16:19:46 -0400
X-MC-Unique: brxsv5YZMBmroVVYJmFfdQ-1
X-Mimecast-MFC-AGG-ID: brxsv5YZMBmroVVYJmFfdQ_1788985185
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC1CE195609F; Wed,  9 Sep 2026 20:19:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1FB119560AB; Wed,  9 Sep 2026 20:19:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/14] qom: add helper APIs for checking object
 security policy compliance
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-4-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-4-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517054.2613908.7956295007949682343.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cOPyaJoZ+jeioVAtQrco9b+RuMtewMWnCN7si8jVcg4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9Vcksxg/bUo4eMv0L3HHqEucO1Wq/CUsa0L
 eZg6BCplueJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5TfND/9iUdP/rJmFhyE8K/J6LN8rDWZFAn7nA8MbG+J/IlS3PdzABnAPH8DXsMr1gguMxMtpJNT
 kscSPyq0jVVgSz/YVa6besn3dFGg06lGVpqsu1fn4adD5z3FfqFX1lMpCQTO092pP/g9jMa9Auv
 hVQwSqh/o9DWq1NU3E/AmgCJ+dx6xERu2pHjbiSl8fq6cI1p63TcQpgk4/K3Ecj/t4cc5hdf5qz
 T10RlDig8jnrajj45g7srRGksx6Bi4doASqWV5UcYPqCagLMJt/hvgiCHlXtmICPklj5gzuhrGW
 bD7Kbp3nrtjqOHuoet7di7LgCCyPTwbBpIpnUTqqxl+tHtR+gxdmA1Ys32gsb8oRGkrIb52YEsl
 hlXO3IuPKXzgjjdLifW1VY+6A9nVGVhLRq6Z+TayDVFim8CIMmG8UQaqG4NY45u/Fwek+0QRrvS
 zXnGAVfl8vOyT02kitSxgyzmeuD1iftw706yiDQYxwQsvoG0KWtxiuSr6T1jTvGfig7XpL42hPx
 REt4I2TC9XN9N3f4ALDLCKgNoZrA5zWHFht0hZy3XWdERoodc1y0d/ZfFZlBVygFp6IigINFzHk
 X/x8kKhUrnp1bOWVDgqLtnWJqd8N+OfZMnTbWG331Id+tkWPlYaO+Y/3M594jzbnsYiTNQP46PQ
 XrJS+cx8Mb+khLg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> These helpers simply avoid a verbose code pattern being repeated for
> many callers.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260909175656.1572689-4-berrange@redhat.com>
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 687ceb6bba00..3b83ceb7b1ff 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2405,6 +2405,32 @@ Object *object_property_add_new_container(Object *obj, const char *name);
>  char *object_property_help(const char *name, const char *type,
>                             QObject *defval, const char *description);
>  
> +/**
> + * object_class_check_security:
> + * @klass: the object class to check
> + * @errp: a pointer to an Error that is filled if not compliant
> + *
> + * Check whether the object class @klass complies with the
> + * currently requested security policy. Reports an error
> + * in @errp if not compliant.
> + *
> + * Returns: true if compliant, false if an error was raised
> + */
> +bool object_class_check_security(ObjectClass *klass, Error **errp);
> +
> +/**
> + * object_check_security:
> + * @obj: the object instance to check
> + * @errp: a pointer to an Error that is filled if not compliant
> + *
> + * Check whether the object @obj complies with the
> + * currently requested security policy. Reports an
> + * error in @errp if not compliant.
> + *
> + * Returns: true if compliant, false if an error was raised
> + */
> +bool object_check_security(Object *obj, Error **errp);
> +
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
>  
>  #endif
> diff --git a/qom/object.c b/qom/object.c
> index 32736a011145..2c93c17802e9 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -23,6 +23,7 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/forward-visitor.h"
>  #include "qapi/qapi-builtin-visit.h"
> +#include "qapi/compat-policy.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qjson.h"
>  #include "qemu/id.h"
> @@ -3149,6 +3150,20 @@ void object_class_property_set_description(ObjectClass *klass,
>      op->description = g_strdup(description);
>  }
>  
> +bool object_class_check_security(ObjectClass *klass, Error **errp)
> +{
> +    return compat_policy_check_security(&compat_policy,
> +                                        object_class_get_name(klass),
> +                                        object_class_is_secure(klass),
> +                                        errp);
> +}
> +
> +bool object_check_security(Object *obj, Error **errp)
> +{
> +    ObjectClass *klass = OBJECT_CLASS(obj);

This should be object_get_class(obj)

I am not sure the helper is really helpful though.

> +    return object_class_check_security(klass, errp);
> +}
> +
>  static void object_class_init(ObjectClass *klass, const void *data)
>  {
>      object_class_property_add_str(klass, "type", object_get_type,

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


