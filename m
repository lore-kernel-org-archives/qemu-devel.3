Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DDCFA373C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 12:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbe1m-0007RH-IG; Fri, 02 Jan 2026 07:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbe1g-0007QW-CO
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 07:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbe1d-0000yD-2b
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 07:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767355979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nW9XwVxBLKwFDNWVC3UTVO/05YMBVA4lPveN0CXYiUc=;
 b=TKM9kPqy9abDGrPtlNuGgT4X0w/jQN+Ts3U0AaChwXRYOIudo5ahZQK+eUlGHrNc6aUbDA
 G6GtBR36WTaKVUFX1FkYJ8awkQnyuVEWer5luEf2LypOpDGuuOlJfXyYGF/u1mT3NFUnMG
 zBEAce/LtPaEZPiOMfmItlLLqQEyop0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-DT-MMMDkNES9ESXkSxCEgA-1; Fri, 02 Jan 2026 07:12:58 -0500
X-MC-Unique: DT-MMMDkNES9ESXkSxCEgA-1
X-Mimecast-MFC-AGG-ID: DT-MMMDkNES9ESXkSxCEgA_1767355977
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso104044785e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 04:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767355977; x=1767960777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nW9XwVxBLKwFDNWVC3UTVO/05YMBVA4lPveN0CXYiUc=;
 b=d79XWJGCVy8LrOWQScCi+vpXRBL7pv899fJ4igQAxbxUgBprz2AmLKWxUgUdUrnsBL
 PuM015UJafryQqafTDrr64aKNSnIlsAPsZb8FDvHjIymMcda3R2la+tmv5uXngLisyJl
 wIyto5s6GCEyx2M0uLUtrMcvoDkAHngbNVJrDtsAO986Gp5540eQhHaSAUgbJd7LQXNX
 YUsjdO8UqXgDwdhmTQL7ET6mY+xsKuzT3TJQb4UBhpQCse5rGNK+jWKP8wYCoEIZ2+ER
 ydNjVgrVabKqFBdDY43nUmASifjMDW2oy56HvBBYHEPilNHqMU5HnMzr4vkLkph0ymm/
 XWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767355977; x=1767960777;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nW9XwVxBLKwFDNWVC3UTVO/05YMBVA4lPveN0CXYiUc=;
 b=fUoqL32TiHwgEkKeSQam1s4WMmwB/3nxByNnNOK1ASG0J7eY2qPla3akA9o7CJc8I8
 Nvi1r2YUZeYuRIcu/dKI3m3XvJdNEpyIVNGyAZGBdadqnP627AshOoF8fwbOxypNqq8E
 6dic+VqHBbyXZ6KElUEJcn+idxTN143dmO8+EHDX8dm+zHU+YP1kvrQ5UOyPDBPDCH0W
 0ssTHAUSTOAutZT8uZ7dNa5ZBz3otZF0DXiH1n/a53bxU0jCucqgB0Zd5urwGkmoyr6/
 cBq5F+Ytw+MjId7XeiblEB+nehpPqYr12JoXQcmv5ZKOmYr+J7DelcrkA9LyxGNz+AMS
 n2Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ou2Uu4QmI8iWAUdge/lzm3WfnDsn+PFEcLyQnGKw56X3re4LgPfLVKSVewRbkrvcyFv9I7efRUM4@nongnu.org
X-Gm-Message-State: AOJu0YzHa17TEm536BQP1HvGLwRF89ygAmQol50TdxLXBgrYmvZtWuHn
 MzJEv+ZY8G+CCo7wnDIKISQxIzP1/Y6qASy2SnvOrXYAcxVbxZxpmqypA2/PzG2tgHGowP/j4TT
 VUiPZqn1VuMQgbDXuUfKdAKsptCLy959h/PT68k7Sn64a6RyMw3ARBZv6
X-Gm-Gg: AY/fxX7CqYGGG9hmtKjpZErbCy+aSnL3U5MG8H4ed6q1boin1T4ITKgnXeOH+fNNEAs
 bkT6K62nE/8+F4MqY7uGvlvAqJi5U+U950Xja8hfvdGIlxGag5PROjHr/j++TpmU2agpcWhl0VZ
 qD6TvHQX66o/TkBMztfpr2SUTdZW+hrBKTouoIolRgiG1ZxBWPdh2D9ZqE2cFOxNGRJYkOo0swd
 Nrh8B0EwHU7NdF6BYWK7G+wdZJlDoNU8BCW5W/Iaw7QSJqoBp9LSkHZF/5sHgjFhr/tZpYk+BmY
 Ftf8e/h1ekMdk+5RL0KSOP/V6GgXyTaNW2GLOIIKgnVKB1RWZhQWryfrHp51VTNmKPa4VqKZ9Jx
 S2MFswpZw6mVww7ljic49kg==
X-Received: by 2002:a05:600c:4fce:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-47d194c659emr475479495e9.0.1767355977164; 
 Fri, 02 Jan 2026 04:12:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXyyd3ggKQsB42zpqL0CS/+fCusJrkkJNzoD10K/ZSkQx5BeQjG3ZQki+ASQ4T6C3vWZ8JCg==
X-Received: by 2002:a05:600c:4fce:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-47d194c659emr475479165e9.0.1767355976688; 
 Fri, 02 Jan 2026 04:12:56 -0800 (PST)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm83469162f8f.22.2026.01.02.04.12.55
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 02 Jan 2026 04:12:56 -0800 (PST)
Date: Fri, 2 Jan 2026 13:12:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?Q?Berrang?=
 =?UTF-8?Q?=C3=A9?=" <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, BALATON
 Zoltan <balaton@eik.bme.hu>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, devel@lists.libvirt.org
Subject: Re: [RFC 01/10] qom: Rename ObjectPropertyFlags to
 ObjectPropertyAccessorFlags
Message-ID: <20260102131253.5b60853b@imammedo-mac>
In-Reply-To: <20251202170502.3228625-2-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-2-zhao1.liu@intel.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  3 Dec 2025 01:04:53 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> At present, ObjectPropertyFlags is used to select accessors and such
> flags won't be stored in ObjectProperty itself.
> 
> So it's not proper to extend this ObjectPropertyFlags for "deprecated"
> or "internal" flags.
> 
> Therefore, rename ObjectPropertyFlags to ObjectPropertyAccessorFlags,
> and then the original name ObjectPropertyFlags can be used for other
> cases.

I wonder if we can  just make existing ObjectPropertyFlags per object as you are planing
and still continue using it for accessor flags.

That basically will lets you use new flags everywhere without rewriting call sites
everywhere.

> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/qom/object.h | 28 ++++++++++++++--------------
>  qom/object.c         | 16 ++++++++--------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 26df6137b911..3f807a03f5aa 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1846,14 +1846,14 @@ typedef enum {
>      OBJ_PROP_FLAG_WRITE = 1 << 1,
>      /* Automatically add a getter and a setter to the property */
>      OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> -} ObjectPropertyFlags;
> +} ObjectPropertyAccessorFlags;
>  
>  /**
>   * object_property_add_uint8_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> + * @flags: bitwise-or'd ObjectPropertyAccessorFlags
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint8'.
> @@ -1861,20 +1861,20 @@ typedef enum {
>   * Returns: The newly added property on success, or %NULL on failure.
>   */
>  ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
> -                                              const uint8_t *v,
> -                                              ObjectPropertyFlags flags);
> +                                        const uint8_t *v,
> +                                        ObjectPropertyAccessorFlags flags);
>  
>  ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
>                                           const char *name,
>                                           const uint8_t *v,
> -                                         ObjectPropertyFlags flags);
> +                                         ObjectPropertyAccessorFlags flags);
>  
>  /**
>   * object_property_add_uint16_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> + * @flags: bitwise-or'd ObjectPropertyAccessorFlags
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint16'.
> @@ -1883,19 +1883,19 @@ ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
>   */
>  ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
>                                      const uint16_t *v,
> -                                    ObjectPropertyFlags flags);
> +                                    ObjectPropertyAccessorFlags flags);
>  
>  ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint16_t *v,
> -                                          ObjectPropertyFlags flags);
> +                                          ObjectPropertyAccessorFlags flags);
>  
>  /**
>   * object_property_add_uint32_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> + * @flags: bitwise-or'd ObjectPropertyAccessorFlags
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint32'.
> @@ -1904,19 +1904,19 @@ ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
>   */
>  ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
>                                      const uint32_t *v,
> -                                    ObjectPropertyFlags flags);
> +                                    ObjectPropertyAccessorFlags flags);
>  
>  ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint32_t *v,
> -                                          ObjectPropertyFlags flags);
> +                                          ObjectPropertyAccessorFlags flags);
>  
>  /**
>   * object_property_add_uint64_ptr:
>   * @obj: the object to add a property to
>   * @name: the name of the property
>   * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> + * @flags: bitwise-or'd ObjectPropertyAccessorFlags
>   *
>   * Add an integer property in memory.  This function will add a
>   * property of type 'uint64'.
> @@ -1925,12 +1925,12 @@ ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
>   */
>  ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
>                                      const uint64_t *v,
> -                                    ObjectPropertyFlags flags);
> +                                    ObjectPropertyAccessorFlags flags);
>  
>  ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
>                                            const char *name,
>                                            const uint64_t *v,
> -                                          ObjectPropertyFlags flags);
> +                                          ObjectPropertyAccessorFlags flags);
>  
>  /**
>   * object_property_add_alias:
> diff --git a/qom/object.c b/qom/object.c
> index 4f32c1aba7d7..85d31bb64b36 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2636,7 +2636,7 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
>  ObjectProperty *
>  object_property_add_uint8_ptr(Object *obj, const char *name,
>                                const uint8_t *v,
> -                              ObjectPropertyFlags flags)
> +                              ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2656,7 +2656,7 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
>  ObjectProperty *
>  object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
>                                      const uint8_t *v,
> -                                    ObjectPropertyFlags flags)
> +                                    ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2676,7 +2676,7 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
>  ObjectProperty *
>  object_property_add_uint16_ptr(Object *obj, const char *name,
>                                 const uint16_t *v,
> -                               ObjectPropertyFlags flags)
> +                               ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2696,7 +2696,7 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
>  ObjectProperty *
>  object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
>                                       const uint16_t *v,
> -                                     ObjectPropertyFlags flags)
> +                                     ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2716,7 +2716,7 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
>  ObjectProperty *
>  object_property_add_uint32_ptr(Object *obj, const char *name,
>                                 const uint32_t *v,
> -                               ObjectPropertyFlags flags)
> +                               ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2736,7 +2736,7 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
>  ObjectProperty *
>  object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
>                                       const uint32_t *v,
> -                                     ObjectPropertyFlags flags)
> +                                     ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2756,7 +2756,7 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
>  ObjectProperty *
>  object_property_add_uint64_ptr(Object *obj, const char *name,
>                                 const uint64_t *v,
> -                               ObjectPropertyFlags flags)
> +                               ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;
> @@ -2776,7 +2776,7 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
>  ObjectProperty *
>  object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
>                                       const uint64_t *v,
> -                                     ObjectPropertyFlags flags)
> +                                     ObjectPropertyAccessorFlags flags)
>  {
>      ObjectPropertyAccessor *getter = NULL;
>      ObjectPropertyAccessor *setter = NULL;


