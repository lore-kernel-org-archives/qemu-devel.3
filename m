Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D37C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6tPg-0002p9-LS; Wed, 16 Sep 2026 13:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6tPd-0002ow-Vl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6tPZ-0003RR-86
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789579625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ng2IdW+pB8EePTRuJPWT//ujRaFwzSAJUvaFPpN8pY=;
 b=FH5kZ63CeEIzYNLFhLGoYumWxpwGZeWT8fO3tX+EJYy7nVE2Rml8Tpsh1dTbvimHs5saI4
 Ngn2LSaEaCPhNFzXosUiM6rZeisGYszMBxsET/RlsNYT0JQGnP9Jg0ZrgifWkl/ymnDtLN
 hoQ2+bXEvKtgOioiFdvehpUkvOEZzJ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-hIXIh2VlNO6PkUmtxOeOYA-1; Wed,
 16 Sep 2026 13:27:02 -0400
X-MC-Unique: hIXIh2VlNO6PkUmtxOeOYA-1
X-Mimecast-MFC-AGG-ID: hIXIh2VlNO6PkUmtxOeOYA_1789579621
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17B951954AFF; Wed, 16 Sep 2026 17:27:01 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 818801956095; Wed, 16 Sep 2026 17:26:58 +0000 (UTC)
Date: Wed, 16 Sep 2026 18:26:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 01/14] qom: add tracking of security state of object
 types
Message-ID: <aqrRXzMYG2CJpDRI@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910103628.2326622-2-berrange@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 10, 2026 at 11:36:15AM +0100, Daniel P. Berrangé wrote:
> This introduces a new flag "secure" against the Type/TypeInfo
> structs, and helpers to check this against the ObjectClass
> struct.
> 
> If an object is considered to provide a security boundary to
> protect against untrusted code, the "secure" flag must be
> explicitly set to true.
> 
> If it is set to false, or left unset, this indicates that
> the object does not intend to provide a security boundary.
> Bugs related to this object class will be ineligible for
> CVE assignment.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qom/object.h | 13 +++++++++++++
>  qom/object.c         |  7 +++++++
>  2 files changed, 20 insertions(+)

Enabling the experimental Rust support flags an omission in this
patch, so I'll squash in the following trivial change when sending
a pull request:

    diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
    index bbb485e2cfd..81449eeefad 100644
    --- a/rust/qom/src/qom.rs
    +++ b/rust/qom/src/qom.rs
    @@ -651,6 +651,9 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         /// Whether the object can be instantiated
         const ABSTRACT: bool = false;
     
    +    /// Whether the object provides a security boundary for untrusted access
    +    const SECURE: bool = false;
    +
         /// Function that is called to initialize an object.  The parent class will
         /// have already been initialized so the type is only responsible for
         /// initializing its own members.
    @@ -687,6 +690,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
             },
             instance_finalize: Some(drop_object::<Self>),
             abstract_: Self::ABSTRACT,
    +        secure: Self::SECURE,
             class_size: core::mem::size_of::<Self::Class>(),
             class_init: Some(rust_class_init::<Self>),
             class_base_init: Self::CLASS_BASE_INIT,
    

> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 7ecd0f210f..687ceb6bba 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -453,6 +453,10 @@ struct Object
>   *   function.
>   * @abstract: If this field is true, then the class is considered abstract and
>   *   cannot be directly instantiated.
> + * @secure: If this field is initialized to true, then the class is considered
> + *   to provide a security boundary. If initialized to false, the class does
> + *   not provide a security boundary. If uninitialized (and thus implicitly
> + *   false) its status is not yet defined.
>   * @class_size: The size of the class object (derivative of #ObjectClass)
>   *   for this object.  If @class_size is 0, then the size of the class will be
>   *   assumed to be the size of the parent class.  This allows a type to avoid
> @@ -487,6 +491,7 @@ struct TypeInfo
>      void (*instance_finalize)(Object *obj);
>  
>      bool abstract;
> +    bool secure;
>      size_t class_size;
>  
>      void (*class_init)(ObjectClass *klass, const void *data);
> @@ -1074,6 +1079,14 @@ const char *object_class_get_name(ObjectClass *klass);
>   */
>  bool object_class_is_abstract(ObjectClass *klass);
>  
> +/**
> + * object_class_is_secure:
> + * @klass: The class to check security of
> + *
> + * Returns: %true if @klass is declared to be secure, %false if not declared
> + */
> +bool object_class_is_secure(ObjectClass *klass);
> +
>  /**
>   * object_class_by_name:
>   * @typename: The QOM typename to obtain the class for.
> diff --git a/qom/object.c b/qom/object.c
> index b1834a57cc..32736a0111 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -67,6 +67,7 @@ struct TypeImpl
>      void (*instance_finalize)(Object *obj);
>  
>      bool abstract;
> +    bool secure;
>  
>      const char *parent;
>      TypeImpl *parent_type;
> @@ -122,6 +123,7 @@ static TypeImpl *type_new(const TypeInfo *info)
>      ti->instance_finalize = info->instance_finalize;
>  
>      ti->abstract = info->abstract;
> +    ti->secure = info->secure;
>  
>      for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
>          ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
> @@ -1144,6 +1146,11 @@ bool object_class_is_abstract(ObjectClass *klass)
>      return klass->type->abstract;
>  }
>  
> +bool object_class_is_secure(ObjectClass *klass)
> +{
> +    return klass->type->secure;
> +}
> +
>  const char *object_class_get_name(ObjectClass *klass)
>  {
>      return klass->type->name;
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


