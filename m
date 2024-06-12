Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D080C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLpb-0002r2-IZ; Wed, 12 Jun 2024 07:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHLpZ-0002ql-LT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHLpY-00035e-1N
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718190471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8JrKjxbCNt/NsCLBVeRR02SaLM2ac6UnYXQNhMmeHU=;
 b=jAnMkqK/wdiLH7v2aARDrn3CX0XhIZPS2A7HHi5FqDa+KsNPOgDQrfHDqkJzIyMl16SFRd
 yuyWc+tT4Rk9/u8bqR6wOosLEI5NwVK/HVPGPEeFcLeJgrs4YRJIvyU8cMylzp3382MUaJ
 gBx05zQ96wFSlt4CJIIBaBR73KGCy0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-JwsjJxsaO8KW2NgzjlCR_Q-1; Wed,
 12 Jun 2024 07:07:49 -0400
X-MC-Unique: JwsjJxsaO8KW2NgzjlCR_Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E13DB195608E; Wed, 12 Jun 2024 11:07:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A60E19560AF; Wed, 12 Jun 2024 11:07:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C3A7E21E6682; Wed, 12 Jun 2024 13:07:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v3 1/4] qom: allow to mark objects as deprecated or not
 secure.
In-Reply-To: <20240606143010.1318226-2-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Thu, 6 Jun 2024 16:30:07 +0200")
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-2-kraxel@redhat.com>
Date: Wed, 12 Jun 2024 13:07:44 +0200
Message-ID: <8734pifmgv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Gerd Hoffmann <kraxel@redhat.com> writes:

> Add flags to ObjectClass for objects which are deprecated or not secure.
> Add 'deprecated' and 'not-secure' bools to ObjectTypeInfo, report in
> 'qom-list-types'.  Print the flags when listing devices via '-device
> help'.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qom/object.h  | 3 +++
>  qom/qom-qmp-cmds.c    | 8 ++++++++
>  system/qdev-monitor.c | 8 ++++++++
>  qapi/qom.json         | 8 +++++++-
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 13d3a655ddf9..419bd9a4b219 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -136,6 +136,9 @@ struct ObjectClass
>      ObjectUnparent *unparent;
>  
>      GHashTable *properties;
> +
> +    bool deprecated;
> +    bool not_secure;
>  };

Ignorant question: should this be in struct TypeImpl instead?

>  
>  /**
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index e91a2353472a..325ff0ba2a25 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -101,6 +101,14 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
>      if (parent) {
>          info->parent = g_strdup(object_class_get_name(parent));
>      }
> +    if (klass->deprecated) {
> +        info->has_deprecated = true;
> +        info->deprecated = true;
> +    }
> +    if (klass->not_secure) {
> +        info->has_not_secure = true;
> +        info->not_secure = true;
> +    }
>  
>      QAPI_LIST_PREPEND(*pret, info);
>  }
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 6af6ef7d667f..effdc95d21d3 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -144,6 +144,8 @@ static bool qdev_class_has_alias(DeviceClass *dc)
>  
>  static void qdev_print_devinfo(DeviceClass *dc)
>  {
> +    ObjectClass *klass = OBJECT_CLASS(dc);
> +
>      qemu_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
>      if (dc->bus_type) {
>          qemu_printf(", bus %s", dc->bus_type);
> @@ -157,6 +159,12 @@ static void qdev_print_devinfo(DeviceClass *dc)
>      if (!dc->user_creatable) {
>          qemu_printf(", no-user");
>      }
> +    if (klass->deprecated) {
> +        qemu_printf(", deprecated");
> +    }
> +    if (klass->not_secure) {
> +        qemu_printf(", not-secure");
> +    }
>      qemu_printf("\n");
>  }
>  
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e39..3f20d4c6413b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -163,10 +163,16 @@
>  #
>  # @parent: Name of parent type, if any (since 2.10)
>  #
> +# @deprecated: the type is deprecated (since 9.1)
> +#
> +# @not-secure: the type (typically a device) is not considered
> +#     a security boundary (since 9.1)

What does this mean?  Does it mean "do not add an instance of this
device the guest unless you trust the guest"?

> +#
>  # Since: 1.1
>  ##
>  { 'struct': 'ObjectTypeInfo',
> -  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
> +  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str',
> +            '*deprecated': 'bool', '*not-secure': 'bool' } }
>  
>  ##
>  # @qom-list-types:

I dislike booleans named "no-FOO" or "not-FOO", because they lead to
double-negation.


