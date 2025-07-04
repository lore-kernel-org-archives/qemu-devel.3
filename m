Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9ACC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfRq-0004j8-6r; Fri, 04 Jul 2025 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXfRR-0004fK-Ea
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXfRO-00078X-PN
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751631773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1z+4sjFSIHlw/PG9kfQg+36t++qImB+xfQjhTRu0zF0=;
 b=JIsfrt6DXkPauDr5rUTm5QsKXuvRV10ti6poR8e2qU0PtZpV4O4KJhp9G+O/NwnBUYv+F2
 tJ50DZWrRK4JJLapl1BTFT1ssLTHImoUS4EO+gQfQLG9d7r2gzH8z5szAV7fro5cSZclXX
 7FVhX1GSY+tAUPvVaRiJDX8uXu6aMUs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-5z2hR6YUMZyHJbWvCPWBug-1; Fri,
 04 Jul 2025 08:22:51 -0400
X-MC-Unique: 5z2hR6YUMZyHJbWvCPWBug-1
X-Mimecast-MFC-AGG-ID: 5z2hR6YUMZyHJbWvCPWBug_1751631770
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D99E180028B; Fri,  4 Jul 2025 12:22:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A322419560AB; Fri,  4 Jul 2025 12:22:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E142721E6A27; Fri, 04 Jul 2025 14:22:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH V2 4/5] qom: qom-list-getv
In-Reply-To: <1747057635-124298-5-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 12 May 2025 06:47:14 -0700")
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-5-git-send-email-steven.sistare@oracle.com>
Date: Fri, 04 Jul 2025 14:22:46 +0200
Message-ID: <874ivsno15.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Steve Sistare <steven.sistare@oracle.com> writes:

> Define the qom-list-getv command, which fetches all the properties and
> values for a list of paths.  This is faster than qom-tree-get when
> fetching a subset of the QOM tree.  See qom.json for details.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/qom.json      | 34 ++++++++++++++++++++++++++++++++++
>  qom/qom-qmp-cmds.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 94662ad..dc710d6 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -62,6 +62,16 @@
>              '*value': 'any' } }
>  
>  ##
> +# @ObjectPropertiesValues:
> +#
> +# @properties: a list of properties.
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'ObjectPropertiesValues',
> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
> +
> +##
>  # @ObjectNode:
>  #
>  # @name: the name of the node
> @@ -158,6 +168,30 @@
>    'allow-preconfig': true }
>  
>  ##
> +# @qom-list-getv:
> +#
> +# This command returns a list of properties and their values for
> +# each object path in the input list.

Imperative mood, please: "Return a list of ..."

> +#
> +# @paths: The absolute or partial path for each object, as described
> +#     in @qom-get
> +#
> +# Errors:
> +#     - If any path is not valid or is ambiguous, returns an error.
> +#     - If a property cannot be read, the value field is omitted in
> +#       the corresponding @ObjectPropertyValue.

My comment on qom-tree-get's Errors: section applies.

> +#
> +# Returns: A list of @ObjectPropertiesValues.  Each element contains
> +#     the properties of the corresponding element in @paths.

Again, ObjectPropertiesValues is an unfortunate name.

> +#
> +# Since 10.1
> +##
> +{ 'command': 'qom-list-getv',
> +  'data': { 'paths': [ 'str' ] },
> +  'returns': [ 'ObjectPropertiesValues' ],
> +  'allow-preconfig': true }
> +
> +##
>  # @qom-tree-get:
>  #
>  # This command returns a tree of objects and their properties,

I find this command *much* simpler than qom-tree-get.

qom-list-getv treats all properties the same.  References, whether they
are children and links, are the same: a QOM path.

qom-tree-get separates properties into children and non-children.
Children become nested ObjectNodes, links remain QOM paths.

> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index b876681..1f05956 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -90,6 +90,46 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
>      }
>  }
>  
> +static ObjectPropertyValueList *qom_get_property_value_list(const char *path,
> +                                                            Error **errp)
> +{
> +    Object *obj;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +    ObjectPropertyValueList *props = NULL;
> +
> +    obj = qom_resolve_path(path, errp);
> +    if (obj == NULL) {
> +        return NULL;
> +    }
> +
> +    object_property_iter_init(&iter, obj);
> +    while ((prop = object_property_iter_next(&iter))) {
> +        qom_list_add_property_value(obj, prop, &props);
> +    }
> +
> +    return props;
> +}
> +
> +ObjectPropertiesValuesList *qmp_qom_list_getv(strList *paths, Error **errp)
> +{
> +    ObjectPropertiesValuesList *head = NULL, **tail = &head;
> +
> +    for ( ; paths ; paths = paths->next) {

I'd prefer a separate variable:

       for (tail = paths; tail; tail = tail->next) {

> +        ObjectPropertiesValues *item = g_new0(ObjectPropertiesValues, 1);
> +
> +        QAPI_LIST_APPEND(tail, item);
> +
> +        item->properties = qom_get_property_value_list(paths->value, errp);
> +        if (!item->properties) {
> +            qapi_free_ObjectPropertiesValuesList(head);
> +            return NULL;
> +        }
> +    }
> +
> +    return head;
> +}
> +
>  static ObjectNode *qom_tree_get(const char *path, Error **errp)
>  {
>      Object *obj;

The implementation is simpler than qom-tree's, too.


