Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80426F01828
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyT5g-0000K3-Qj; Fri, 06 Mar 2026 06:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyT5d-0000J6-Uv; Fri, 06 Mar 2026 06:11:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyT5a-0006O3-6N; Fri, 06 Mar 2026 06:11:28 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS3bs2nZfzJ46ZJ;
 Fri,  6 Mar 2026 19:10:33 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B0094056A;
 Fri,  6 Mar 2026 19:11:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 11:11:10 +0000
Date: Fri, 6 Mar 2026 11:11:06 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 01/65] hw/core: Permit devices to define an array of
 link properties
Message-ID: <20260306111106.0000023a@huawei.com>
In-Reply-To: <20260223170212.441276-2-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-2-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:01:08 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Currently we allow devices to define "link properties" with
> DEFINE_PROP_LINK(): these are a way to give a device a pointer to
> another QOM object.  (Under the hood this is done by handing it the
> canonical QOM path for the object.)
> 
> We also allow devices to define "array properties" with
> DEFINE_PROP_ARRAY(): these are a way to give a device a
> variable-length array of properties.
> 
> However, there is no way to define an array of link properties.  If
> you try to do it by passing qdev_prop_link as the arrayprop argument
> to DEFINE_PROP_ARRAY() you will get a crash because qdev_prop_link
> does not provide the .set and .get methods in its PropertyInfo
> struct.
> 
> This patch implements a new DEFINE_PROP_LINK_ARRAY(). In
> a device you can use it like this:
> 
> struct MyDevice {
>     ...
>     uint32_t num_cpus;
>     ARMCPU **cpus;
> }
> 
> and in your Property array:
>     DEFINE_PROP_LINK_ARRAY("cpus", MyDevice, num_cpus, cpus,
>                            TYPE_ARM_CPU, ARMCPU *),
> 
> The array property code will fill in s->num_cpus, allocate memory in
> s->cpus, and populate it with pointers.
> 
> On the device-creation side you set the property in the same way as
> the existing array properties, using the new qlist_append_link()
> function to append to the QList:
> 
>     QList *cpulist = qlist_new();
>     for (int i = 0; i < cpus; i++) {
>         qlist_append_link(cpulist, OBJECT(cpu[i]));
>     }
>     qdev_prop_set_array(mydev, "cpus", cpulist);
> 
> The implementation is mostly in the provision of the .set and
> .get methods to the qdev_prop_link PropertyInfo struct. The
> code of these methods parallels the code in
> object_set_link_property() and object_get_link_property().  We can't
> completely share the code with those functions because of differences
> in where we get the information like the target QOM type, but I have
> pulled out a new function object_resolve_and_typecheck() for the
> shared "given a QOM path and a type, give me the object or an error"
> code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi Peter,

Looks good to me, but I'm not confident enough on this stuff to give
tags.  A couple of trivial things inline.

Jonathan

> ---
> I want this specifically for the GICv5 interrupt controller device
> I'm working on.  I'd like to be able to pass in links to the CPUs
> connected to the GIC, so that we don't have to have the code assume
> that it's connected to CPU numbers 0,1,2... the way the current
> GICv3 code does.
> 
> I think Phil also had a proposed series a while back that wanted
> to do something similar with one of the existing devices.
> 
> I figured I'd post this early for review, though obviously it's a
> little unmotivated until I have my new GICv5 code into enough shape
> to submit. This is tested, but with my work-in-progress code.

You probably want to update this set of notes given it's in your
GICv5 set now!

> diff --git a/include/qom/object.h b/include/qom/object.h
> index 26df6137b9..48fdbf353e 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1750,6 +1750,25 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
>                                              Object *val, Error **errp),
>                                ObjectPropertyLinkFlags flags);
>  
> +
> +/**
> + * object_resolve_and_typecheck:
> + * @path: path to look up
> + * @name: name of property we are resolving for (used only in error messages)
> + * @target_type: QOM type we expect @path to resolve to
> + * @errp: error
> + *
> + * Look up the object at @path and return it. If it does not have
> + * the correct type @target_type, return NULL and set @errp.
> + *
> + * This is similar to object_resolve_path_type(), but it insists on
> + * a non-ambiguous path and it produces error messages that are specialised
> + * to the use case of setting a link property on an object.
> + */
> +Object *object_resolve_and_typecheck(const char *path,
> +                                     const char *name,
> +                                     const char *target_type, Error **errp);

I'm not sure why you went with this wrapping. I'd combine the first two lines.

> +
>  /**
>   * object_property_add_str:
>   * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index ff8ede8a32..90b8f3461e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1895,26 +1895,13 @@ static void object_get_link_property(Object *obj, Visitor *v,
>      }
>  }
>  
> -/*
> - * object_resolve_link:
> - *
> - * Lookup an object and ensure its type matches the link property type.  This
> - * is similar to object_resolve_path() except type verification against the
> - * link property is performed.
> - *
> - * Returns: The matched object or NULL on path lookup failures.
> - */
> -static Object *object_resolve_link(Object *obj, const char *name,
> -                                   const char *path, Error **errp)
> +Object *object_resolve_and_typecheck(const char *path,
> +                                     const char *name,

As above.

> +                                     const char *target_type, Error **errp)



