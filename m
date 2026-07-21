Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C65C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8pE-0007mf-RS; Tue, 21 Jul 2026 07:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm8pA-0007ht-Ia; Tue, 21 Jul 2026 07:39:48 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm8p5-00048x-Bj; Tue, 21 Jul 2026 07:39:47 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66LBcs8O034877
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 20:38:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dsTeSqYWTYADJOM7BiePIs7wfqK/ddc2rDvYyi7bi4M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784633934; v=1;
 b=cYGo7UiUoH+BAnFFY5ITNeUoluogYSiJe2rT9WUbQTmm+Ljed5z0AoQeKGCdxckT
 LMtC5NM2oXictwvdCSWknky2EJkzSmVAyueD6Nh1XVvn0+wu/ZI+I04jMz9mn6PG
 dTkgV9vaWyWj4iVR2KkJL1gVgb6GOa6Xi57Z/tWXdjZHGQ1K9NF9JrisS61T1fzy
 wriigE9bLcPpgWykbj5zyy3bGU3Qv3kSyOg/iu3iEVIQXiilqX/5pyuT/khx9tU4
 XIcXE2NpT75EUQqY20YtzRDHdmLi/585CZkvkueGe7g+07zUOEtN/hS18hkUgeAz
 w2tRAkEe9JwgCEaVvrI0Jg==
Message-ID: <64bc4a38-f1d2-45ff-8f4c-c941d6a41e18@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 20:38:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 01/15] qdev: Clarify instantiation and
 realization
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-1-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <f4f4630f-525a-185a-83eb-1a24e6426cca@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f4f4630f-525a-185a-83eb-1a24e6426cca@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/21 20:14, BALATON Zoltan wrote:
> On Tue, 21 Jul 2026, Akihiko Odaki wrote:
>> The distinction of instantiation and realization was vague in the old
>> documentation so this change clarifies it.
>>
>> The old documentation said:
>>> The former may not fail (and must not abort or exit, since it is
>>> called during device introspection already), and the latter may return
>>> error information to the caller and must be re-entrant.
>>> Trivial field initializations should go into #TypeInfo.instance_init.
>>> Operations depending on @props static properties should go into
>>> @realize.
>>
>> The first problem with the old documentation is that it is unclear what
>> "trivial field initializations" means and why triviality makes
>> initialization appropriate for #TypeInfo.instance_init. Another problem
>> is that the documentation is not comprehensive enough; for example, it
>> mentions @props static properties, but it does not say anything about
>> the other properties.
>>
>> The keys to distinguish instantiation and realization are property
>> setting and device introspection. The fact that property setting happens
>> after #TypeInfo.instance_init and before realization implies that
>> operations depending on properties should go into @realize.
>>
>> The fact that instantiation happens during device introspection but
>> realization does not implies:
>> - Instance properties should be added in #TypeInfo.instance_init.
>> - Instantiation must not have any side effect not contained in the
>>  instance.
>> - Any operations without special requirements should go into @realize so
>>  that they can be skipped during device introspection.
>>
>> Note these two facts to guide appropriate instantiation and realization.
>>
>> We also omit mention of the realized property because it is a QOM
>> interface detail, not part of the device API.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>> include/hw/core/qdev.h | 52 +++++++++++++++++++++++++++ 
>> +----------------------
>> 1 file changed, 29 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
>> index e14762234115..aba7072131c4 100644
>> --- a/include/hw/core/qdev.h
>> +++ b/include/hw/core/qdev.h
>> @@ -22,27 +22,35 @@
>>  * Realization
>>  * -----------
>>  *
>> - * Devices are constructed in two stages:
>> - *
>> - * 1) object instantiation via object_initialize() and
>> - * 2) device realization via the #DeviceState.realized property
>> - *
>> - * The former may not fail (and must not abort or exit, since it is 
>> called
>> - * during device introspection already), and the latter may return error
>> - * information to the caller and must be re-entrant.
>> - * Trivial field initializations should go into #TypeInfo.instance_init.
>> - * Operations depending on @props static properties should go into 
>> @realize.
>> + * Devices are constructed in the following order:
>> + *
>> + * 1) #TypeInfo.instance_init
>> + * 2) pre-realize property value setting
>> + * 3) device realization
>> + *
>> + * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
>> + * fail, returning error information to the caller. A device realize
>> + * method should handle being called again after it has failed once.
> 
> Doesn't the last patch in this series contradict this sentence? Maybe it 
> should be removed and say instead that after failed realize the object 
> can only be destroyed, no other methods can be called.

The last patch updates it.

> 
>> + * #TypeInfo.instance_init should add instance properties but must not
>> + * have any side effect not contained in the instance, since it happens
>> + * during device introspection already. Any operations without special
>> + * requirements should go @realize so that they can be skipped during
> 
> You need something between go and @realize such as to or into?

This is another existing quirk, but we can fix it now.

> 
>> + * device introspection.
>>  * After successful realization, setting static properties will fail.
>>  *
>> - * As an interim step, the #DeviceState.realized property can also be
>> - * set with qdev_realize(). In the future, devices will propagate this
>> - * state change to their children and along busses they expose. The
>> - * point in time will be deferred to machine creation, so that values
>> - * set in @realize will not be introspectable beforehand. Therefore
>> - * devices must not create children during @realize; they should
>> - * initialize them via object_initialize() in their own
>> - * #TypeInfo.instance_init and forward the realization events
>> - * appropriately.
>> + * In the future, devices will propagate this state change to their
>> + * children and along busses they expose. The point in time will be
>> + * deferred to machine creation, so that values set in @realize will not
>> + * be introspectable beforehand. Therefore devices should not create
>> + * children during @realize; they should initialize them (e.g. by
>> + * calling object_initialize_child()) in their own
>> + * #TypeInfo.instance_init method, and then realize them (e.g. by
>> + * calling qdev_realize()) in their own #DeviceClass.realize method.
> 
> This complicates devices...
> 
>> + * Occasionally a device may need to decide whether or not to create
>> + * a child object based on the value of a property. In this case it
>> + * will need to both create and realize the child in its realize method,
>> + * because the property value is not known until that point.
> 
> ...and not always possible. So can we relax this so that only children 
> that add properties that need to be introspectable and settable has to 
> be created in init and otherwise it can be deferred to realize? That way 
> most simple devices don't need an init method at all. I'd really say by 
> default do everyting in realize unless it needs to be available before 
> realize such as properties that change what realize does and avoid 
> splitting creating objects between init and realize when not absolutely 
> needed.

I remember that there was a similar discussion regarding the timing to 
call memory_region_init(), and I don't have a strong opinion here, so 
I'll relax this requirement unless someone suggests otherwise.

Regards,
Akihiko Odaki

