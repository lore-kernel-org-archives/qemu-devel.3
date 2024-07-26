Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292A2C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKLY-0006yA-8p; Fri, 26 Jul 2024 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXKLV-0006rw-8y; Fri, 26 Jul 2024 08:46:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXKLT-0000fx-DQ; Fri, 26 Jul 2024 08:46:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVnXJ0JGsz6K5nd;
 Fri, 26 Jul 2024 20:45:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0F4EB14065B;
 Fri, 26 Jul 2024 20:46:48 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 13:46:47 +0100
Date: Fri, 26 Jul 2024 13:46:46 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240726134646.000046e3@Huawei.com>
In-Reply-To: <87bk2lreeb.fsf@pond.sub.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <87bk2lreeb.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A few quick replies from me.
I'm sure Mauro will add more info.

> > +           'tlb-error',
> > +           'bus-error',
> > +           'micro-arch-error']
> > +}
> > +
> > +##
> > +# @arm-inject-error:
> > +#
> > +# Inject ARM Processor error.
> > +#
> > +# @errortypes: ARM processor error types to inject
> > +#
> > +# Features:
> > +#
> > +# @unstable: This command is experimental.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'command': 'arm-inject-error',
> > +  'data': { 'errortypes': ['ArmProcessorErrorType'] },  
> 
> Please separate words with dashes: 'error-types'.
> 
> > +  'features': [ 'unstable' ]
> > +}  
> 
> Is this used only with TARGET_ARM?
> 
> Why is being able to inject multiple error types at once useful?

It pokes a weird corner of the specification that I think previously 
tripped up Linux.

> 
> I'd expect at least some of these errors to come with additional
> information.  For instance, I imagine a bus error is associated with
> some address.

Absolutely agree that in sane case you wouldn't have multiple errors
but we want to hit the insane ones :(

There is only prevision for one set of data in the record despite
it providing a bitmap for the type of error.

> 
> If we encode the the error to inject as an enum value, adding more will
> be hard.
> 
> If we wrap the enum in a struct
> 
>     { 'struct': 'ArmProcessorError',
>       'data': { 'type': 'ArmProcessorErrorType' } }
> 
> we can later extend it like
> 
>     { 'union': 'ArmProcessorError',
>       'base: { 'type': 'ArmProcessorErrorType' }
>       'data': {
>           'bus-error': 'ArmProcessorBusErrorData' } }
> 
>     { 'struct': 'ArmProcessorBusErrorData',
>       'data': ... }
> 
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index e7bc54e5d047..5927932c4be3 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -22,6 +22,7 @@ if have_system or have_tools or have_ga
> >  endif
> >  
> >  qapi_all_modules = [
> > +  'arm-error-inject',
> >    'authz',
> >    'block',
> >    'block-core',
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index b1581988e4eb..479a22de7e43 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -81,3 +81,4 @@
> >  { 'include': 'vfio.json' }
> >  { 'include': 'cryptodev.json' }
> >  { 'include': 'cxl.json' }
> > +{ 'include': 'arm-error-inject.json' }  
> 
> 


