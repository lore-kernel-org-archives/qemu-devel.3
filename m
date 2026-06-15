Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7FBCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2T6-00016k-TL; Mon, 15 Jun 2026 04:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ2T4-0000wy-WB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ2T3-0002WT-1b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781511288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nMcZv8TGBkIPp76V2vATEU3ePD1PG46ZBygmPNsZNGI=;
 b=f9QEw/ZcB4TH5jptP6WD8radLv/bfDWA1uJN/yPdaDzWxU2hdZLmysEKEX47fPiVzt1wFi
 8QQQ1hsSIUE/B9n8veCX5xoAH3JLeUbI9fVcJXNDllEVurHcW6jeZTWa/8nXrywzGIYT/P
 PjuFuaD2OqD2U2njF5Q2fz/TY9WouDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-Om2IQ_ZrMaSP0YXwbhxwqg-1; Mon,
 15 Jun 2026 04:14:44 -0400
X-MC-Unique: Om2IQ_ZrMaSP0YXwbhxwqg-1
X-Mimecast-MFC-AGG-ID: Om2IQ_ZrMaSP0YXwbhxwqg_1781511283
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95B381956065; Mon, 15 Jun 2026 08:14:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.222])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 930C1180034F; Mon, 15 Jun 2026 08:14:37 +0000 (UTC)
Date: Mon, 15 Jun 2026 09:14:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] qom: Reject temporary object resurrection
Message-ID: <ai-0akg3wd6TRSgD@redhat.com>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-1-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615-embedded-v1-1-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 15, 2026 at 01:11:06PM +0900, Akihiko Odaki wrote:
> If object_ref() is called during finalization, it will temporarily
> "resurrect" the object. Although object_finalize() asserts that no
> resurrecting reference remains before freeing the object, the assertion
> cannot catch the case where the resurrecting reference is dropped before
> freeing the object.

What's the real world problem here ? 

> 
> One way to catch this would be to add a check in object_ref() to reject
> resurrecting references before they are created. However, object_ref()
> is frequently called so it is better to minimize the overhead.
> 
> To avoid adding the overhead, change how the reference count is
> represented and let an existing assertion detect resurrection. More
> concretely, obj->ref now stores the current reference count minus 1. The
> stored count is therefore 0 after object_initialize(), and the final
> object_unref() decrements it from 0 to UINT32_MAX and starts
> finalization. A resurrecting object_ref() will then trip the existing
> obj->ref < INT_MAX assertion.

Please no, this is horribly surprising semantics.

> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/qom/object.h            |  4 ++--
>  block/throttle-groups.c         |  2 +-
>  qom/object.c                    | 15 ++++++---------
>  tests/unit/check-qom-proplist.c |  8 ++++----
>  4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fcd0..c4dcf65dcf7f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1121,7 +1121,7 @@ GSList *object_class_get_list_sorted(const char *implements_type,
>   * @obj: the object
>   *
>   * Increase the reference count of a object.  A object cannot be freed as long
> - * as its reference count is greater than zero.
> + * as a reference remains.
>   * Returns: @obj
>   */
>  Object *object_ref(void *obj);
> @@ -1131,7 +1131,7 @@ Object *object_ref(void *obj);
>   * @obj: the object
>   *
>   * Decrease the reference count of a object.  A object cannot be freed as long
> - * as its reference count is greater than zero.
> + * as a reference remains.
>   */
>  void object_unref(void *obj);
>  
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 4b1b1944c20a..3b2a89f5849d 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -962,7 +962,7 @@ static void throttle_group_get_limits(Object *obj, Visitor *v,
>  
>  static bool throttle_group_can_be_deleted(UserCreatable *uc)
>  {
> -    return OBJECT(uc)->ref == 1;
> +    return OBJECT(uc)->ref == 0;
>  }
>  
>  static void throttle_group_obj_class_init(ObjectClass *klass,
> diff --git a/qom/object.c b/qom/object.c
> index 0ac201de4c15..761eff1337e6 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -497,7 +497,6 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
>  
>      memset(obj, 0, type->instance_size);
>      obj->class = type->class;
> -    object_ref(obj);
>      object_class_property_init_all(obj);
>      obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
>                                              NULL, object_property_free);
> @@ -560,11 +559,10 @@ bool object_initialize_child_with_propsv(Object *parentobj,
>  
>  out:
>      /*
> -     * We want @obj's reference to be 1 on success, 0 on failure.
> -     * On success, it's 2: one taken by object_initialize(), and one
> -     * by object_property_add_child().
> -     * On failure in object_initialize() or earlier, it's 1.
> -     * On failure afterwards, it's also 1: object_unparent() releases
> +     * We want @obj's reference to be 0 on success, UINT32_MAX on failure.
> +     * On success, it's 1: one taken by object_property_add_child().
> +     * On failure in object_initialize() or earlier, it's 0.
> +     * On failure afterwards, it's also 0: object_unparent() releases
>       * the reference taken by object_property_add_child().
>       */
>      object_unref(obj);
> @@ -668,7 +666,6 @@ static void object_finalize(void *data)
>      object_property_del_all(obj);
>      object_deinit(obj, ti);
>  
> -    g_assert(obj->ref == 0);
>      g_assert(obj->parent == NULL);
>      if (obj->free) {
>          obj->free(obj);
> @@ -1329,10 +1326,10 @@ void object_unref(void *objptr)
>      if (!obj) {
>          return;
>      }
> -    g_assert(obj->ref > 0);
> +    g_assert(obj->ref < INT_MAX);
>  
>      /* parent always holds a reference to its children */
> -    if (qatomic_fetch_dec(&obj->ref) == 1) {
> +    if (qatomic_fetch_dec(&obj->ref) == 0) {
>          object_finalize(obj);
>      }
>  }
> diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
> index 89de92b7d91f..b5527dd52afd 100644
> --- a/tests/unit/check-qom-proplist.c
> +++ b/tests/unit/check-qom-proplist.c
> @@ -351,7 +351,7 @@ static void test_dummy_createv_tree(void)
>                                NULL));
>  
>      g_assert(err == NULL);
> -    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
> +    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
>      g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
>      g_assert(dobj->bv == true);
>      g_assert(dobj->av == DUMMY_PLATYPUS);
> @@ -375,7 +375,7 @@ static void test_dummy_createv_parentless(void)
>                                           NULL));
>  
>      g_assert(err == NULL);
> -    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
> +    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
>      g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
>      g_assert(dobj->bv == true);
>      g_assert(dobj->av == DUMMY_PLATYPUS);
> @@ -414,7 +414,7 @@ static void test_dummy_createlist_tree(void)
>                          NULL));
>  
>      g_assert(err == NULL);
> -    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
> +    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
>      g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
>      g_assert(dobj->bv == true);
>      g_assert(dobj->av == DUMMY_PLATYPUS);
> @@ -450,7 +450,7 @@ static void test_dummy_createlist_parentless(void)
>                                NULL));
>  
>      g_assert(err == NULL);
> -    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
> +    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
>      g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
>      g_assert(dobj->bv == true);
>      g_assert(dobj->av == DUMMY_PLATYPUS);
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


