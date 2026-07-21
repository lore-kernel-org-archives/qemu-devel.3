Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2105C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8Qf-0003DJ-Sa; Tue, 21 Jul 2026 07:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wm8Qd-0003Ci-Gf; Tue, 21 Jul 2026 07:14:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wm8Qa-0000Gb-V3; Tue, 21 Jul 2026 07:14:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45013584307;
 Tue, 21 Jul 2026 13:14:20 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id g06RALH47R4W; Tue, 21 Jul 2026 13:14:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2F5A6584306; Tue, 21 Jul 2026 13:14:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2AE5E584305;
 Tue, 21 Jul 2026 13:14:18 +0200 (CEST)
Date: Tue, 21 Jul 2026 13:14:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Alex Williamson <alex@shazbot.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org, 
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-11.2 v3 01/15] qdev: Clarify instantiation and
 realization
In-Reply-To: <20260721-qdev-v3-1-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <f4f4630f-525a-185a-83eb-1a24e6426cca@eik.bme.hu>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-1-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 21 Jul 2026, Akihiko Odaki wrote:
> The distinction of instantiation and realization was vague in the old
> documentation so this change clarifies it.
>
> The old documentation said:
>> The former may not fail (and must not abort or exit, since it is
>> called during device introspection already), and the latter may return
>> error information to the caller and must be re-entrant.
>> Trivial field initializations should go into #TypeInfo.instance_init.
>> Operations depending on @props static properties should go into
>> @realize.
>
> The first problem with the old documentation is that it is unclear what
> "trivial field initializations" means and why triviality makes
> initialization appropriate for #TypeInfo.instance_init. Another problem
> is that the documentation is not comprehensive enough; for example, it
> mentions @props static properties, but it does not say anything about
> the other properties.
>
> The keys to distinguish instantiation and realization are property
> setting and device introspection. The fact that property setting happens
> after #TypeInfo.instance_init and before realization implies that
> operations depending on properties should go into @realize.
>
> The fact that instantiation happens during device introspection but
> realization does not implies:
> - Instance properties should be added in #TypeInfo.instance_init.
> - Instantiation must not have any side effect not contained in the
>  instance.
> - Any operations without special requirements should go into @realize so
>  that they can be skipped during device introspection.
>
> Note these two facts to guide appropriate instantiation and realization.
>
> We also omit mention of the realized property because it is a QOM
> interface detail, not part of the device API.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> include/hw/core/qdev.h | 52 ++++++++++++++++++++++++++++----------------------
> 1 file changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index e14762234115..aba7072131c4 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -22,27 +22,35 @@
>  * Realization
>  * -----------
>  *
> - * Devices are constructed in two stages:
> - *
> - * 1) object instantiation via object_initialize() and
> - * 2) device realization via the #DeviceState.realized property
> - *
> - * The former may not fail (and must not abort or exit, since it is called
> - * during device introspection already), and the latter may return error
> - * information to the caller and must be re-entrant.
> - * Trivial field initializations should go into #TypeInfo.instance_init.
> - * Operations depending on @props static properties should go into @realize.
> + * Devices are constructed in the following order:
> + *
> + * 1) #TypeInfo.instance_init
> + * 2) pre-realize property value setting
> + * 3) device realization
> + *
> + * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
> + * fail, returning error information to the caller. A device realize
> + * method should handle being called again after it has failed once.

Doesn't the last patch in this series contradict this sentence? Maybe it 
should be removed and say instead that after failed realize the object can 
only be destroyed, no other methods can be called.

> + * #TypeInfo.instance_init should add instance properties but must not
> + * have any side effect not contained in the instance, since it happens
> + * during device introspection already. Any operations without special
> + * requirements should go @realize so that they can be skipped during

You need something between go and @realize such as to or into?

> + * device introspection.
>  * After successful realization, setting static properties will fail.
>  *
> - * As an interim step, the #DeviceState.realized property can also be
> - * set with qdev_realize(). In the future, devices will propagate this
> - * state change to their children and along busses they expose. The
> - * point in time will be deferred to machine creation, so that values
> - * set in @realize will not be introspectable beforehand. Therefore
> - * devices must not create children during @realize; they should
> - * initialize them via object_initialize() in their own
> - * #TypeInfo.instance_init and forward the realization events
> - * appropriately.
> + * In the future, devices will propagate this state change to their
> + * children and along busses they expose. The point in time will be
> + * deferred to machine creation, so that values set in @realize will not
> + * be introspectable beforehand. Therefore devices should not create
> + * children during @realize; they should initialize them (e.g. by
> + * calling object_initialize_child()) in their own
> + * #TypeInfo.instance_init method, and then realize them (e.g. by
> + * calling qdev_realize()) in their own #DeviceClass.realize method.

This complicates devices...

> + * Occasionally a device may need to decide whether or not to create
> + * a child object based on the value of a property. In this case it
> + * will need to both create and realize the child in its realize method,
> + * because the property value is not known until that point.

...and not always possible. So can we relax this so that only children 
that add properties that need to be introspectable and settable has to be 
created in init and otherwise it can be deferred to realize? That way most 
simple devices don't need an init method at all. I'd really say by default 
do everyting in realize unless it needs to be available before realize 
such as properties that change what realize does and avoid splitting 
creating objects between init and realize when not absolutely needed.

Regards,
BALATON Zoltan

>  *
>  * Any type may override the @realize and/or @unrealize callbacks but needs
>  * to call the parent type's implementation if keeping their functionality
> @@ -101,10 +109,8 @@ typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
> /**
>  * struct DeviceClass - The base class for all devices.
>  * @props: Properties accessing state fields.
> - * @realize: Callback function invoked when the #DeviceState:realized
> - * property is changed to %true.
> - * @unrealize: Callback function invoked when the #DeviceState:realized
> - * property is changed to %false.
> + * @realize: Callback function to realize the device.
> + * @unrealize: Callback function to unrealize the device.
>  * @sync_config: Callback function invoked when QMP command device-sync-config
>  * is called. Should synchronize device configuration from host to guest part
>  * and notify the guest about the change.
>
>

