Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9955ACA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1qj-0002ck-SI; Wed, 30 Sep 2026 17:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xC1qg-0002c0-En
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:28:23 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xC1qe-0001Er-Df
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:28:22 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d2c37b0bso2323112a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790803699; x=1791408499; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MwEzyUNOr27ZMDBP+RFezFt1qNZElj+swSdeoVzKmfw=;
 b=TAUxjNE59wMRiNkysyVczy/aMMSCDcY88rVwMXTTFacFZVwhFRueJY730T33U94iT/
 KImvrKnYzNe0v6VWZ6C2ZNsPO0MQnI0hbHIbFuihcc0mhaczVrLO4wYC6ZGQkMydbQgz
 YEnQjgD0ZG7fJ7ZLtBDkwZGcDhP7mh5JdBwjTKz32iesUYZjTS23GQthPb/FGpZ5MNJ2
 ykSyB8yTs3h8jS8YAULLBfe8RnKl2gn6sX17cMzA/zE2ddnTPo2WeRudA4ZFnfdMlOA+
 3t2M5yZOXcK3j4d3iKasLJtpT2s7gQ4U9z4FlW35kBohOtCbDCJUf76iSluFs4fxa28u
 SCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790803699; x=1791408499;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MwEzyUNOr27ZMDBP+RFezFt1qNZElj+swSdeoVzKmfw=;
 b=SicJ5d471fpac97wNTtl9S+dg98U9O9gkeaLOB9zcaQsdOrzlMgSopk9K8EAs2kDOR
 waNSCiD1/meOVRkM0pNaxrcetveypUxJy5kHYAG6biYvm9hvAiARMyXnydoTAt45ug+J
 ZixhJugHON9pKwv1RBspNhtNTb8qXLSDhr/MxLkumUeB5D1yD/qvaBXgixZIxmsy/xZt
 AiWNonui7uq1Z1e8S/RT/GgRalLkXnN4zOqZFSr2gE12FVQ8LZod+OsmxEBODqJmPWEM
 TNiZrxZ/wuKMS9L9s2+Yz9ArPzwcDsWqhni1ZSippmgzkc45alp06WhNFuzPmbfnxeHS
 lE4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz29adKgBg5raffY/ls9p/bMM9WEbQ/1wFH4auNG8yyefdbo39x/ws54CynmgciM7l5WyJ88O15/rue@nongnu.org
X-Gm-Message-State: AFq9FYJ9FprHfi9WTTyDaA9K31Rkk3L3GNlD5uROeUoBjYV5Lq48fJsm
 kxPUlePBOkExQ23TMbrpLM3IgmR+Rwf5oNnCN6qRZhWBMpLTujPQVeoJAzG5vZM8aUk=
X-Gm-Gg: AYBFou0LHqkECU6Bta2V5A0DQNMCxZowH0f8kkCBq3z5T+zXhUWcgst0nsI0HbZtF5R
 bDUoA/qsVXqcIRd0WdReyonFV/qB7XwIqGeHCWdneprh/JlJTsQQmOTTZrgFjD4IQ1WRb1gUCH3
 0fgV9D3O7jNTqg3AvyMbfyQFTs8idHFMGlHZhmM0RIW2VQ6hSxgHdaRH1RDarkMGCUXwMLOdzDG
 SQynryxC+xIVTrcUeFfNjioDeYRFZ1Jm58XZdmal9BJ9w5n2e1KEsO+6Pov7inB+wC/P3qNVcfe
 zEUTzSmuPDkkUkMm1e2edZ/oimDwf+daR3gVjNUE95JfTHcsDOINIn2XwMHfZB6SkL5XLSf1mVU
 qllDgqbGX9HfsrP3GKA46FR846V+adtSioXNe0ZtXY5/BrVaaD2vlh48fOJxKA+Rq2vGF657WSb
 XZ8kN8Ph+dfgvQGChPYBxot/D1dPaG4pE3nqeJ98nS7TKmPXSWiobJwg4mTeVFuBs1EUavfgWA
X-Received: by 2002:a17:90b:2681:b0:3a0:9640:8028 with SMTP id
 98e67ed59e1d1-3a4f931c875mr254245a91.59.1790803698766; 
 Wed, 30 Sep 2026 14:28:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f5b4:4d0e:70d:9fba])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e306c3cb2csm192855ad.83.2026.09.30.14.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 14:28:18 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:28:14 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Michael Roth <michael.roth@amd.com>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <ar1-7iyCq8Re3htU@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> On 09/22 10:01, Lorenzo Pieralisi wrote:
> > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > 
> > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > passing on the command-line:
> > > > 
> > > >   -M virt,confidential-guest-support=<id>
> > > >   -object rme-guest,id=<id>
> > > > 
> > > > This is only the skeleton. Support will be added in following patches.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >  docs/system/confidential-guest-support.rst |  1 +
> > > >  qapi/qom.json                              | 13 +++++++
> > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > >  target/arm/meson.build                     |  5 ++-
> > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > >  create mode 100644 target/arm/kvm-rme.c
> > > > 
> > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > index 562a7c3c2852..abb56923ad13 100644
> > > > --- a/docs/system/confidential-guest-support.rst
> > > > +++ b/docs/system/confidential-guest-support.rst
> > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > +* Arm Realm Management Extension (RME)
> > > >  
> > > >  Other mechanisms may be supported in future.
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index 776b13027fd8..52997c29a32d 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -1288,6 +1288,17 @@
> > > >    'data': { '*pretty': 'bool',
> > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > >  
> > > > +##
> > > > +# @RmeGuestProperties:
> > > > +#
> > > > +# Properties for rme-guest objects.
> > > > +#
> > > > +# Since: 11.1
> > > > +##
> > > > +{ 'struct': 'RmeGuestProperties',
> > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > 
> > > Just FYI, based on input from Markus I'm planning to drop this
> > > ConfidentialGuestSupportProperties base type from my series
> > > since it's probably only SNP/TDX that need to be able to switch
> > > it on/off, whereas this series appears to use/require it from
> > > the start.
> > > 
> > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > were based on v2 you'd instead probably just do the following in the
> > > instance_init function for your rme-guest instance:
> > > 
> > >   cgs->allow_convert_in_place = true;
> > >   cgs->convert_in_place = true;
> > > 
> > > rather than exposing it as a cmdline option.
> > 
> > Yep, it won't be an option for CCA Realms anyway since that will be
> > the baseline.
> 
> IIUC, in-place conversion requires RAM backed by a shared/mappable
> guest_memfd. If in-place conversion is always enabled for CCA Realms,
> could QEMU also select the equivalent of
> 
>   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> 
> automatically for the default RAM, so that specifying the RAM size with
> `-m` is sufficient?
>

I'm almost done crafting a new revision that will be based on V20 of the KVM
patchset.  I will look into your request for the revision after this one.
 
> Thanks,
> Kohei
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks,
> > > 
> > > Mike
> > > 
> > > > +  'data': {} }
> > > > +
> > > >  ##
> > > >  # @ObjectType:
> > > >  #
> > > > @@ -1346,6 +1357,7 @@
> > > >      { 'name': 'pr-manager-helper',
> > > >        'if': 'CONFIG_LINUX' },
> > > >      'qtest',
> > > > +    'rme-guest',
> > > >      'rng-builtin',
> > > >      'rng-egd',
> > > >      { 'name': 'rng-random',
> > > > @@ -1427,6 +1439,7 @@
> > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > >                                        'if': 'CONFIG_LINUX' },
> > > >        'qtest':                      'QtestProperties',
> > > > +      'rme-guest':                  'RmeGuestProperties',
> > > >        'rng-builtin':                'RngProperties',
> > > >        'rng-egd':                    'RngEgdProperties',
> > > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > new file mode 100644
> > > > index 000000000000..42e1d1e7b859
> > > > --- /dev/null
> > > > +++ b/target/arm/kvm-rme.c
> > > > @@ -0,0 +1,42 @@
> > > > +/*
> > > > + * QEMU Arm RME support
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > + *
> > > > + * Copyright Linaro 2026
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +
> > > > +#include "hw/core/boards.h"
> > > > +#include "hw/core/cpu.h"
> > > > +#include "kvm_arm.h"
> > > > +#include "migration/blocker.h"
> > > > +#include "qapi/error.h"
> > > > +#include "qom/object_interfaces.h"
> > > > +#include "system/confidential-guest-support.h"
> > > > +#include "system/kvm.h"
> > > > +#include "system/runstate.h"
> > > > +
> > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > +
> > > > +struct RmeGuest {
> > > > +    ConfidentialGuestSupport parent_obj;
> > > > +};
> > > > +
> > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > +
> > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > +{
> > > > +}
> > > > +
> > > > +static void rme_guest_init(Object *obj)
> > > > +{
> > > > +}
> > > > +
> > > > +static void rme_guest_finalize(Object *obj)
> > > > +{
> > > > +}
> > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > --- a/target/arm/meson.build
> > > > +++ b/target/arm/meson.build
> > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > >  arm_common_system_ss.add(files(
> > > >    'arm-qmp-cmds.c',
> > > >  ))
> > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > +  'hyp_gdbstub.c',
> > > > +  'kvm.c',
> > > > +  'kvm-rme.c'))
> > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > >  
> > > >  arm_user_ss.add(files('cpu.c'))
> > > > -- 
> > > > 2.43.0
> > > > 
> > > > 

