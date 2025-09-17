Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39096CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqnt-00081k-6a; Wed, 17 Sep 2025 07:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyqna-0007q4-LE
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyqnX-00052h-CK
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758110285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GLbcYhOmZLOkQI2riqXN1sQU5QUildnLa02awuxxLvA=;
 b=Wc+VemoZm8DujJyN0e1pjtIgYpNY4gBcZDYETIrsyT+PvVrKbLU+JoanWiud4oieNnKBZL
 pu+EGrOK22tCtlGd/8e6pAqImkBHRqYjlucHJrl2pt7ACEoe2ZbsdBAgdLjnWXo+71+FKE
 FxgPdsIMcgEj794AJzvnfYydL+WDJMg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-vfRmwMIKMIKOyYB0nkQjsQ-1; Wed,
 17 Sep 2025 07:58:02 -0400
X-MC-Unique: vfRmwMIKMIKOyYB0nkQjsQ-1
X-Mimecast-MFC-AGG-ID: vfRmwMIKMIKOyYB0nkQjsQ_1758110277
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6588195608B; Wed, 17 Sep 2025 11:57:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8976C19560B8; Wed, 17 Sep 2025 11:57:35 +0000 (UTC)
Date: Wed, 17 Sep 2025 12:57:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/7] Do not unparent in instance_finalize()
Message-ID: <aMqiK5SaeBJlSa_h@redhat.com>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 17, 2025 at 07:13:25PM +0900, Akihiko Odaki wrote:
> Based-on: <cover.1751493467.git.balaton@eik.bme.hu>
> ("[PATCH v2 00/14] hw/pci-host/raven clean ups")
> 
> Supersedes: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
> ("[PATCH] docs/devel: Prohibit calling object_unparent() for memory region")
> 
> Children are automatically unparented so manually unparenting is
> unnecessary.

Where is automatic unparenting you're referring to being done ?

> Worse, automatic unparenting happens before the instance_finalize()
> callback of the parent gets called, so object_unparent() calls in
> the callback will refer to objects that are already unparented, which
> is semantically incorrect.

IIUC, object_property_add_child will acquire a reference on
the child, and object_property_del_child (and thus
object_unparent) will release that reference.

The 'object_finalize' method, and thus 'instance_finalize'
callback, won't be invoked until the last reference is
dropped on the object in question.

IOW, it should be impossible for 'object_finalize' to ever
run, as long as the child has a parent set.

So if we're in the 'finalize' then 'object_unparent' must
be a no-op as the child must already have no references
held and thus no parent.

IOW, the reason to remove 'object_unparent' calls from
finalize is surely because they do nothing at all,
rather than this talk about callbacks being run at the
wrong time ?

> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v3:
> - Added patches to remove other object_unparent() calls in
>   instance_finalize().
> - Dropped patch "qdev: Automatically delete memory subregions" and the
>   succeeding patches to avoid Ccing many.
> - Link to v2: https://lore.kernel.org/qemu-devel/20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp
> 
> Changes in v2:
> - Added a reference to "[PATCH] docs/devel: Prohibit calling
>   object_unparent() for memory region", which does something similar to
>   patch "docs/devel: Do not unparent in instance_finalize()" but I
>   forgot I sent it in the past.
> - Fixed a typo in patch
>   "docs/devel: Do not unparent in instance_finalize()" and
>   "[PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()".
> - Dropped patches to move address_space_init() calls; I intend to
>   QOM-ify to fix memory leaks automatically as discussed in the
>   following thread:
>   https://lore.kernel.org/qemu-devel/cd21698f-db77-eb75-6966-d559fdcab835@eik.bme.hu/
>   But the QOM-ification will be big so I'll send it as a separate
>   series.
> - Rebased on top of "[PATCH v2 00/14] hw/pci-host/raven clean ups".
>   https://lore.kernel.org/qemu-devel/cover.1751493467.git.balaton@eik.bme.hu/
> - Link to v1: https://lore.kernel.org/qemu-devel/20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp
> 
> ---
> Akihiko Odaki (7):
>       docs/devel: Do not unparent in instance_finalize()
>       vfio/pci: Do not unparent in instance_finalize()
>       hw/core/register: Do not unparent in instance_finalize()
>       hv-balloon: hw/core/register: Do not unparent in instance_finalize()
>       hw/sd/sdhci: Do not unparent in instance_finalize()
>       vfio: Do not unparent in instance_finalize()
>       hw/xen: Do not unparent in instance_finalize()
> 
>  docs/devel/memory.rst  | 19 ++++++-------------
>  hw/core/register.c     |  1 -
>  hw/hyperv/hv-balloon.c | 12 +-----------
>  hw/sd/sdhci.c          |  4 ----
>  hw/vfio/pci-quirks.c   |  9 +--------
>  hw/vfio/pci.c          |  4 ----
>  hw/vfio/region.c       |  3 ---
>  hw/xen/xen_pt_msi.c    | 11 +----------
>  8 files changed, 9 insertions(+), 54 deletions(-)
> ---
> base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
> change-id: 20250906-use-37ecc903a9e0
> 
> Best regards,
> --  
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


