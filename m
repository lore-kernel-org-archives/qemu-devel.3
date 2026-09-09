Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F1AC79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmQ-0004F5-Tu; Wed, 09 Sep 2026 16:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmP-00048x-Jb
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmN-0006yz-UG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BwfE8dLDtzSy6V0cWCjgS0GV/WB2MCl1KqE59iKA/I=;
 b=fihfz2BE68Hxt9e0dTrPaRsUsp9q8qgI1mqOm1WO91IG0hmEb0OGQhCJlO7Kc62Nkdl1Vv
 ajirto/v8QpBE6g6yl9Kx/qhdRO8PQRIrD3NEKCAn4ab0puanmD2Cdnh6AnVX+77XjY2RT
 hep04DO77mDXzJGGEXc7m4bNhqcIvK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-p-GsIvFFMaWt5LraP2h3mg-1; Wed,
 09 Sep 2026 16:20:19 -0400
X-MC-Unique: p-GsIvFFMaWt5LraP2h3mg-1
X-Mimecast-MFC-AGG-ID: p-GsIvFFMaWt5LraP2h3mg_1788985218
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2244C1956089; Wed,  9 Sep 2026 20:20:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5155318002A6; Wed,  9 Sep 2026 20:20:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 12/14] qom: report & filter on security status in
 qom-list-types
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
In-Reply-To: <20260909175656.1572689-13-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-13-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517059.2613908.9606481544825990507.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3680;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nEm6hroTBVbg2y1750BCMovxkJPwwjAqlEXWHIS90uQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9WZdgQM/ea10vyCyQSyYkZJld+WzbByhMh3
 5iyBauyy0GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VgAKCRDa6OEJdZac
 5UgGD/9fSi3HppvALwci1Ev2I2YZllZEk4/dlb01xJGu8cUJyd/RUH6zFo7aILQmhpXGDTAAhBs
 P4WswiWYGutyNQh1Dw71H7tjJQmeGvX2cXcqD9ooPyDKxyon4mog12ULEuTfXMVUhBMLOGgLQiQ
 3A94fzUpRkryPoSd/M+TsP0fUY9gSZd6YWxZQxTCqYSMNr5vApOyR3Xth3tZ163wb1dq9g2E+ce
 VA5shh429RsGYmN21CeoWZUHgEw6m+d5mfwRpB5wESj/jji9OTrkY23CrGivkAQkAlG04xSUftb
 myvVRRVXu3WRFEVZZko3RjQVleTeQSHXA9DY8ls0wQ8e78m7UuZhMt40Z9OSE80bDSphL6kRVTd
 o53RgXujtLinLXq0bU7Z+y/4ywElBBzujbqrZv5oQfAQtPxB3jlvb6AFuhy+M7OmKJSJf/A1Te0
 THCpX7VaE/UKcCNzhI7ZwoPfvyMEQWsVdVZpv/VarmWAr2HbqF0Cc3pD9rUdZmM3n6NQqgcdWRr
 7YEXySop8Z+3w0H6eL3WUck+NKfTK6BBlGUPVodf6TIXY7p7Y3KVTd4ElH1PIJ1b2jtPLhI5pX/
 7Yry0b55fYP0g3GtuseiAoEagFgg9GrdMl29pPNVzuIhrjfh8QH14E2MGkciFaRb0n554M729hC
 Sv26Y4wpmyJGAiw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> This adds:
> 
>  * a new boolean 'secure' field to the type info returned by
>    qom-list-types, which will be set if the type provides a
>    security boundary
> 
>  * a new boolean 'secure' parameter to the arguments of
>    qom-list-types, which can be used to filter types based
>    on their security status
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260909175656.1572689-13-berrange@redhat.com>
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 4a9b7f908844..b14f063144b7 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -210,12 +210,18 @@
>  # @abstract: the type is abstract and can't be directly instantiated.
>  #     Omitted if false.  (since 2.10)
>  #
> +# @secure: the type provides a security boundary.  Omitted if false.
> +#     (since 11.2)
> +#
>  # @parent: Name of parent type, if any (since 2.10)
>  #
>  # Since: 1.1
>  ##
>  { 'struct': 'ObjectTypeInfo',
> -  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
> +  'data': { 'name': 'str',
> +            '*abstract': 'bool',
> +            '*parent': 'str',
> +            '*secure': 'bool' } }
>  
>  ##
>  # @qom-list-types:
> @@ -227,12 +233,15 @@
>  #
>  # @abstract: if true, include abstract types in the results
>  #
> +# @secure: if set, filter to only include types with matching security
> +#     status (since 11.1)

(since 11.2)

> +#
>  # Returns: a list of types, or an empty list if no results are found
>  #
>  # Since: 1.1
>  ##
>  { 'command': 'qom-list-types',
> -  'data': { '*implements': 'str', '*abstract': 'bool' },
> +  'data': { '*implements': 'str', '*abstract': 'bool', '*secure': 'bool' },
>    'returns': [ 'ObjectTypeInfo' ],
>    'allow-preconfig': true }
>  
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index b999e9f7238c..9474a1b04ba4 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -153,6 +153,8 @@ QObject *qmp_qom_get(const char *path, const char *property, Error **errp)
>  
>  typedef struct {
>      ObjectTypeInfoList *list;
> +    bool has_secure;
> +    bool secure;
>  } ObjectTypeInfoData;
>  
>  static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
> @@ -161,9 +163,15 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
>      ObjectTypeInfo *info;
>      ObjectClass *parent = object_class_get_parent(klass);
>  
> +    if (data->has_secure &&
> +        data->secure != object_class_is_secure(klass)) {
> +        return;
> +    }
> +
>      info = g_malloc0(sizeof(*info));
>      info->name = g_strdup(object_class_get_name(klass));
>      info->has_abstract = info->abstract = object_class_is_abstract(klass);
> +    info->has_secure = info->secure = object_class_is_secure(klass);
>      if (parent) {
>          info->parent = g_strdup(object_class_get_name(parent));
>      }
> @@ -174,10 +182,14 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
>  ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
>                                         bool has_abstract,
>                                         bool abstract,
> +                                       bool has_secure,
> +                                       bool secure,
>                                         Error **errp)
>  {
>      ObjectTypeInfoData data = {
>          .list = NULL,
> +        .has_secure = has_secure,
> +        .secure = secure,
>      };
>  
>      module_load_qom_all();

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


