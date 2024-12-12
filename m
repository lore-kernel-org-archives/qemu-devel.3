Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB2E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkSh-0002Rw-C4; Thu, 12 Dec 2024 09:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tLkSf-0002RH-I5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tLkSc-0004Zk-9T
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734014797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rj3/bj3qiByyq03DEtIoenWqlg7LpEjsdDBIJ///74A=;
 b=d+nCCiaVkcYCfEFYaC40eVp0ikzUNFexxPemiuGbq7y4HyQLdSWP6sHiPkYXZKJ73hZZ3y
 lkzXbIoZRMs2p+m69yBz2h3kcaahpex1HQqy6lRYpBHRlBqzcjvgD6pCeaUO3ZqTkhGhJr
 gxQR5zZ2MII3xmOs5rJEd4mOcYORckc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-PvAlLYKeM9acSycBW-uWow-1; Thu,
 12 Dec 2024 09:46:34 -0500
X-MC-Unique: PvAlLYKeM9acSycBW-uWow-1
X-Mimecast-MFC-AGG-ID: PvAlLYKeM9acSycBW-uWow
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EB8919560B2; Thu, 12 Dec 2024 14:46:29 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06CDE30044C1; Thu, 12 Dec 2024 14:46:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
In-Reply-To: <1fea79e4-7a31-4592-8495-7b18cd82d02b@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <Z1qoa8yXscTSAJ9e@redhat.com> <8734it1bv6.fsf@redhat.com>
 <1fea79e4-7a31-4592-8495-7b18cd82d02b@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 12 Dec 2024 15:46:23 +0100
Message-ID: <87bjxhc62o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Dec 12 2024, Eric Auger <eric.auger@redhat.com> wrote:

> On 12/12/24 10:36, Cornelia Huck wrote:
>> On Thu, Dec 12 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>
>>> On Thu, Dec 12, 2024 at 09:12:33AM +0100, Eric Auger wrote:
>>>> Connie,
>>>>
>>>> On 12/6/24 12:21, Cornelia Huck wrote:
>>>>> A respin/update on the aarch64 KVM cpu models. Also available at
>>>>> gitlab.com/cohuck/qemu arm-cpu-model-rfcv2
>>> snip
>>>
>>>> From a named model point of view, since I do not see much traction
>>>> upstream besides Red Hat use cases, targetting ARM spec revision
>>>> baselines may be overkill. Personally I would try to focus on above
>>>> models: AltraMax, AmpereOne, Grace, ... Or maybe the ARM cores they may
>>>> be derived from.
>>> If we target modelling of vendor named CPU models, then beware that
>>> we're opening the door to an very large set (potentially unbounded)
>>> of named CPU models over time. If we target ARM spec baselines then
>>> the set of named CPU models is fairly modest and grows slowly.
>>>
>>> Including ARM spec baselines will probably reduce the demand for
>>> adding vendor specific named models, though I expect we'll still
>>> end up wanting some, or possibly even many.
>>>
>>> Having some common baseline models is likely useful for mgmt
>>> applications in other ways though.
>>>
>>> Consider you mgmt app wants to set a CPU model that's common across
>>> heterogeneous hardware. They don't neccessarily want/need to be
>>> able to live migrate between heterogeneous CPUs, but for simplicity
>>> of configuration desire to set a single named CPU across all guests,
>>> irrespective of what host hey are launched on. The ARM spec baseline
>>> named models would give you that config simplicity.
>> If we use architecture extensions (i.e. Armv8.x/9.x) as baseline, I'm
>> seeing some drawbacks:
>> - a lot of work before we can address some specific use cases
>> - old models can get new optional features
>> - a specific cpu might have a huge set of optional features on top of
>>   the baseline model
>>
>> Using a reference core such as Neoverse-V2 probably makes more sense
>> (easier to get started, less feature diff?) It would still make a good
>> starting point for a simple config.
>>
> Actually from a dev point of view I am not sure it changes much to have
> either ARM spec rev baseline or CPU ref core named model.
>
> One remark is that if you look at
> https://developer.arm.com/documentation/109697/2024_09?lang=3Den
> you will see there are quite a lot of spec revisions and quite a few of
> them are actually meaningful in the light of currently avaiable and
> relevant HW we want to address. What I would like to avoid is to be
> obliged to look at all of them in a generic manner while we just want to
> address few cpu ref models.

Yes, exactly.

>
> Also starting from the ARM spec rev baseline the end-user may need to
> add more feature opt-ins to be close to a specific cpu model. So I
> foresee extra complexity for the end-user.

For ref cores, it's easier to pick the ones that actually matter for a
specific use case, for arch exts I don't think we can avoid implementing
those we don't really care about. And yes, from the sample of cpus I've
looked at they seem to be much closer to a ref core than to an arch ext.


