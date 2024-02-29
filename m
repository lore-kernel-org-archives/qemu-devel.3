Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036F1C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhic-0005Md-NM; Thu, 29 Feb 2024 09:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfhia-0005LB-Iy
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfhiZ-00036i-0T
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709218141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zL6fNA71UFnemaMzAizJTtTicZ5wrARKUIQFe0GtXDo=;
 b=CBatx22cAj5g7WIQG2J3lHyZjuaVDbx4PD/9qSCNpVq141Xd3NMrV/hKoaKJtcRu85Zl2k
 oo1EL3eEU7HusgZstzOdeIpuXBUgF55XInNR7jDLz20ywdQUcGTJrGQ9hyHMapSiWCuzLq
 bjc+Uvbmy/huntbPadNno/o1cz9uyH8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-bbUTcuwaM5iMYkkwHsUBgg-1; Thu,
 29 Feb 2024 09:49:00 -0500
X-MC-Unique: bbUTcuwaM5iMYkkwHsUBgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7196E280A9A3;
 Thu, 29 Feb 2024 14:48:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 486DD1C060B1;
 Thu, 29 Feb 2024 14:48:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BF9621E6767; Thu, 29 Feb 2024 15:48:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Michael Roth <michael.roth@amd.com>,  Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 16/16] hw/core/qdev-properties-system: Fix missing
 ERRP_GUARD() for error_prepend()
In-Reply-To: <20240228163723.1775791-17-zhao1.liu@linux.intel.com> (Zhao Liu's
 message of "Thu, 29 Feb 2024 00:37:23 +0800")
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-17-zhao1.liu@linux.intel.com>
Date: Thu, 29 Feb 2024 15:48:58 +0100
Message-ID: <87frxbuy05.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@linux.intel.com> writes:

> From: Zhao Liu <zhao1.liu@intel.com>
>
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
>
> * =3D Why, when and how to use ERRP_GUARD() =3D
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
>
> ERRP_GUARD() could avoid the case when @errp is the pointer of
> error_fatal, the user can't see this additional information, because

Suggest "when @errp is &error_fatal"

> exit() happens in error_setg earlier than information is added [1].
>
> The set_chr() passes @errp to error_prepend() without ERRP_GUARD().
>
> As a PropertyInfo.set method, the @errp passed to set_chr() is so widely
> sourced that it is necessary to protect it with ERRP_GUARD().

"sourced"?  Do you mean "used"?

Are you trying to say something like "there are too many possible
callers for me to check the impact of this defect; it may or may not be
harmless."

> To avoid the issue like [1] said, add missing ERRP_GUARD() at the
> beginning of this function.
>
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>      ("error: New macro ERRP_GUARD()").
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/core/qdev-properties-system.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index 1a396521d51f..545c3ceff7c9 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -242,6 +242,7 @@ static void get_chr(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
>  static void set_chr(Object *obj, Visitor *v, const char *name, void *opa=
que,
>                      Error **errp)
>  {
> +    ERRP_GUARD();
>      Property *prop =3D opaque;
>      CharBackend *be =3D object_field_prop_ptr(obj, prop);
>      Chardev *s;

Commit message could use a bit of polish.  Regardless
Reviewed-by: Markus Armbruster <armbru@redhat.com>


