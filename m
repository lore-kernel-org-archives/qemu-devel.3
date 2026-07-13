Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB836C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCKw-0008W9-11; Mon, 13 Jul 2026 04:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjCKt-0008Uy-S4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjCKq-0003cf-Tb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783932500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qMDuP99hm05XASl30clnhd/u3iIISBQAVW4YZaf2S2M=;
 b=Oi1djaqMRO5hp4Yv9HeCqeSYM1W3ZhQ2GAVgwrqQ8cdfAXpvPyA2hLlynVQEeHBf5se6Lw
 3rpOPxNi7PP7wjxNIIy8sHFq9UJGa+5gvm5ITLkCw682AUPaEXlokXErWnwLMgvEBX+2s9
 aYmtwRuEQfY4JpvkRz94pQ4482ftnBM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-e5c9qKsSNf6YDubF-Ca3gg-1; Mon,
 13 Jul 2026 04:48:15 -0400
X-MC-Unique: e5c9qKsSNf6YDubF-Ca3gg-1
X-Mimecast-MFC-AGG-ID: e5c9qKsSNf6YDubF-Ca3gg_1783932490
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1638618052FE; Mon, 13 Jul 2026 08:48:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 139703000B4C; Mon, 13 Jul 2026 08:47:45 +0000 (UTC)
Date: Mon, 13 Jul 2026 09:47:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Song Gao <17746591750@163.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Jan Kiszka <jan.kiszka@web.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jared Rossi <jrossi@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
Message-ID: <alSmLv3qq6kl3o2i@redhat.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260711223707.42139-2-graf@amazon.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, Jul 11, 2026 at 10:34:54PM +0000, Alexander Graf wrote:
> We already have two ways of creating a QOM object with a parent set
> from birth: object_initialize_child() for objects embedded in the
> parent struct, and object_new_with_props() for heap-allocated objects
> that also want a list of string properties applied.  What we do not
> have is the plain heap-allocated dual of object_initialize_child():
> create the object, add it as a child<> of a given parent under a given
> name, and hand the reference to the parent.
> 
> Board and composite-device code that heap-allocates children today
> therefore either open-codes object_new()+object_property_add_child()
> +object_unref(), or skips the parenting step entirely and lets
> device_set_realized() dump the object into /machine/unattached.
> 
> Add object_new_child(parent, id, typename) as that missing primitive.
> The reference created by object_new() is transferred to the parent's
> child<> property, so on return the sole reference is held by @parent
> and the caller does not need to unref.  Later patches build the qdev
> and per-bus creation helpers on top of this.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
> Assisted-by: Kiro

QEMU does not currently permit contributions assisted by AI
coding tools.

There is an open discussion about altering the policy but that
is not conclude with agreement yet.

> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  include/qom/object.h | 25 +++++++++++++++++++++++++
>  qom/object.c         | 13 +++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fc..ce6a23b5a1 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -632,6 +632,31 @@ Object *object_new_with_class(ObjectClass *klass);
>   */
>  Object *object_new(const char *typename);
>  
> +/**
> + * object_new_child:
> + * @parent: the QOM composition-tree parent
> + * @id: the child<> property name; the object's canonical QOM path
> + *      becomes @parent's path plus "/" plus @id
> + * @typename: the name of the type of the object to instantiate
> + *
> + * Create a heap-allocated object and immediately add it to the QOM
> + * composition tree as a child of @parent.
> + *
> + * This is the heap-allocated dual of object_initialize_child(): use
> + * this when the child is a pointer member of the parent, and use
> + * object_initialize_child() when the child is embedded in the parent
> + * struct.  See also object_new_with_props() for the variant that
> + * additionally sets a list of properties.
> + *
> + * The reference returned by object_new() is transferred to the child<>
> + * property of @parent, so the object has a reference count of 1 held
> + * by @parent, and the caller does not need to unref.
> + *
> + * Returns: the newly allocated, instantiated and parented object.
> + */
> +Object *object_new_child(Object *parent, const char *id,
> +                         const char *typename);
> +
>  /**
>   * object_new_with_props:
>   * @typename:  The name of the type of the object to instantiate.
> diff --git a/qom/object.c b/qom/object.c
> index f79b2cf361..b4d181b617 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -718,6 +718,19 @@ Object *object_new(const char *typename)
>      return object_new_with_type(ti);
>  }
>  
> +Object *object_new_child(Object *parent, const char *id,
> +                          const char *typename)
> +{
> +    Object *obj;
> +
> +    g_assert(parent);
> +    g_assert(id);
> +
> +    obj = object_new(typename);
> +    object_property_add_child(parent, id, obj);
> +    object_unref(obj);
> +    return obj;
> +}
>  
>  Object *object_new_with_props(const char *typename,
>                                Object *parent,
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


