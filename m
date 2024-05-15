Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A8DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Aeh-0005jI-7U; Wed, 15 May 2024 05:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7Aed-0005ir-Eb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s7AeU-0003eD-4Z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715764220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jd4Mb52owwe4Efapxh3xUUL3yVm8OGwRegn93nh4z9U=;
 b=RYatq5xZ+2yRxQywXpY0uyg8W5iZ54M75Yj3UHnFx2Ra8m0cIM/ORR+eQInd0WSlI/BMIu
 DMv0F1lqf+B9rNRu16ixGocnwxAyo58lRgboNINf0+8gUpJMZP3fbKbOVH/7zk36c4c1rs
 nkU22arQOJYjrGxTgASdBRgvJ0ihA6g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-NsridVfWOMmKC9EEO0YrKQ-1; Wed,
 15 May 2024 05:10:16 -0400
X-MC-Unique: NsridVfWOMmKC9EEO0YrKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 703363806714;
 Wed, 15 May 2024 09:10:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF9623C27;
 Wed, 15 May 2024 09:10:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D570C21E668B; Wed, 15 May 2024 11:10:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Ani
 Sinha <anisinha@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Mads Ynddal
 <mads@ynddal.dk>,  Jason Wang <jasowang@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Yanan Wang <wangyanan55@huawei.com>,  Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH 02/20] qapi: linter fixups
In-Reply-To: <20240514215740.940155-3-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 May 2024 17:57:21 -0400")
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-3-jsnow@redhat.com>
Date: Wed, 15 May 2024 11:10:12 +0200
Message-ID: <87msorwidn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Fix minor irritants to pylint/flake8 et al.
>
> (Yes, these need to be guarded by the Python tests. That's a work in
> progress, a series that's quite likely to follow once I finish this
> Sphinx project. Please pardon the temporary irritation.)

No worries; one step at a time.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 8 ++++----
>  scripts/qapi/schema.py     | 6 +++---
>  scripts/qapi/visit.py      | 5 +++--
>  3 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 86c075a6ad2..ac14b20f308 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -27,8 +27,8 @@
>  from .schema import (
>      QAPISchema,
>      QAPISchemaAlternatives,
> -    QAPISchemaBranches,
>      QAPISchemaArrayType,
> +    QAPISchemaBranches,
>      QAPISchemaBuiltinType,
>      QAPISchemaEntity,
>      QAPISchemaEnumMember,
> @@ -233,9 +233,9 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>              typ = type_int
>          elif (isinstance(typ, QAPISchemaArrayType) and
>                typ.element_type.json_type() == 'int'):
> -            type_intList = self._schema.lookup_type('intList')
> -            assert type_intList
> -            typ = type_intList
> +            type_intlist = self._schema.lookup_type('intList')
> +            assert type_intlist
> +            typ = type_intlist

I named the variable after the type.  Suppressing the linter complaint
just to keep that name isn't worthwhile.  I might have picked
type_int_list instead.  No need to change it now.

>          # Add type to work queue if new
>          if typ not in self._used_types:
>              self._used_types.append(typ)
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 721c470d2b8..d65c35f6ee6 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -730,6 +730,7 @@ def set_defined_in(self, name: str) -> None:
>          for v in self.variants:
>              v.set_defined_in(name)
>  
> +    # pylint: disable=unused-argument
>      def check(
>              self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
>      ) -> None:
> @@ -1166,7 +1167,7 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
>                  defn.info, "%s is already defined" % other_defn.describe())
>          self._entity_dict[defn.name] = defn
>  
> -    def lookup_entity(self,name: str) -> Optional[QAPISchemaEntity]:
> +    def lookup_entity(self, name: str) -> Optional[QAPISchemaEntity]:
>          return self._entity_dict.get(name)
>  
>      def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
> @@ -1302,11 +1303,10 @@ def _make_implicit_object_type(
>          name = 'q_obj_%s-%s' % (name, role)
>          typ = self.lookup_entity(name)
>          if typ:
> -            assert(isinstance(typ, QAPISchemaObjectType))
> +            assert isinstance(typ, QAPISchemaObjectType)
>              # The implicit object type has multiple users.  This can
>              # only be a duplicate definition, which will be flagged
>              # later.
> -            pass
>          else:
>              self._def_definition(QAPISchemaObjectType(
>                  name, info, None, ifcond, None, None, members, None))
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index e766acaac92..12f92e429f6 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -280,8 +280,9 @@ def gen_visit_alternate(name: str,
>          abort();
>      default:
>          assert(visit_is_input(v));
> -        error_setg(errp, "Invalid parameter type for '%%s', expected: %(name)s",
> -                         name ? name : "null");
> +        error_setg(errp,
> +                   "Invalid parameter type for '%%s', expected: %(name)s",
> +                   name ? name : "null");
>          /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
>          g_free(*obj);
>          *obj = NULL;

This is mostly lint I neglected to pick off in my recent work.  Thanks
for taking care of it!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


