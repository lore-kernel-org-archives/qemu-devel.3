Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7ABC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZUp5-0005mF-NL; Thu, 01 Aug 2024 08:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZUp4-0005hC-HV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZUp2-0005Dv-Ih
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722514938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JaoE6e+TEMGsazVe0e6xglFk4XYps0+uj6HyIWRNf4=;
 b=CwwtjT0HQLdaYGAshjPRANnsFL76qg2px+8e3I4GuCH50d5BCTRoi81gVbcMEgRvfCHNWi
 yItqJCqT+Kn1DZcv3ijt6P8iErurv3SYETjBESGkpmfLVXLP/X2wIF8yvT6cAfaT/OwM3Z
 C4E5g6k4yZhB8AxXhRYiURyoon6SOHA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-p9zsvhaQM-yMNxgA-RTnGQ-1; Thu, 01 Aug 2024 08:22:16 -0400
X-MC-Unique: p9zsvhaQM-yMNxgA-RTnGQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a9c275447so442500166b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722514935; x=1723119735;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6JaoE6e+TEMGsazVe0e6xglFk4XYps0+uj6HyIWRNf4=;
 b=FocaPgeU5qypw8G8T36KSIa2q53h/5GW3Q/iW6R0WEYn0L1XgsIWbPlRkbWW/WGUPA
 csQSyKxdCEsti37riZIPHNNen3bmviaK8eqbUr2disCKTZ8w9bmKi8V7noMQV6oKZqN6
 5McdwZa5Bd+fw9eYwFsCYId9dEUSI/Av9JVNqTLbUPyzFY3AWtqYa4tRxlMln8FEMvEU
 t14OlVmF6CiogHOuWq8PugS6UTmCZhIH6M4fZ6s/kSdE6f3BuuHiopmXk3yqpjbwBFQf
 JX6Ka23WXxPCE+0LSDO4nN+cJn99GkBNbwIyI/zCPnABCXCDHLpRQcgWClkOo0OUE6V/
 4Pkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4Q0KuxB74+19aXDKq8JtRvZCkueihcxLsC3XWja8I319IQs2g5fzOL63atVM5jHxYe4CFzzOoIqd9Bc3hdwRiLaYfdM=
X-Gm-Message-State: AOJu0YwyBAS3EQciqFC9WSGrr09dF3phWBcBGMlH6h6SyGBGlbIphBii
 J3T7QfQIi/lo1zEx49jnTMoMfGbJJy5q+S1sB5WZkhLMANnfJPzFXPBU/8eqN3SCP80ir696iaR
 W0TjQqUAR473lil2G2ODB2ROVy4093GzH4BSuMai5BOBh6fM02esd
X-Received: by 2002:a17:907:7b88:b0:a7a:8c55:6b2 with SMTP id
 a640c23a62f3a-a7daf4fdc8fmr222809066b.14.1722514935307; 
 Thu, 01 Aug 2024 05:22:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0sXg7g2VGLu+nlP/rvrDYl0dlL7EZFYzU5wM+aezYYD7ZzBdfVOmcAABKna1koGz8m4BS/g==
X-Received: by 2002:a17:907:7b88:b0:a7a:8c55:6b2 with SMTP id
 a640c23a62f3a-a7daf4fdc8fmr222803966b.14.1722514934342; 
 Thu, 01 Aug 2024 05:22:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm887725166b.7.2024.08.01.05.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 05:22:13 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:22:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
Message-ID: <20240801080453-mutt-send-email-mst@kernel.org>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
 <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
 <87h6c4fqz6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6c4fqz6.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 12:59:57PM +0200, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
> > On 2024/07/31 17:32, Markus Armbruster wrote:
> >> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> >> 
> >>> rom_bar is tristate but was defined as uint32_t so convert it into
> >>> OnOffAuto to clarify that. For compatibility, a uint32 value set via
> >>> QOM will be converted into OnOffAuto.
> >>>
> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> 
> >> I agree making property "rombar" an integer was a design mistake.  I
> >> further agree that vfio_pci_size_rom() peeking into dev->opts to
> >> distinguish "user didn't set a value" from "user set the default value")
> >> is an unadvisable hack.
> >> 
> >> However, ...
> >> 
> >>> ---
> >>> Changes in v2:
> >>> - Documented in docs/about/deprecated.rst (Daniel P. Berrangé)
> >>> - Link to v1: https://lore.kernel.org/r/20240706-rombar-v1-0-802daef2aec1@daynix.com
> >>>
> >>> ---
> >>> Akihiko Odaki (4):
> >>>        qapi: Add visit_type_str_preserving()
> >>>        qapi: Do not consume a value when visit_type_enum() fails
> >>>        hw/pci: Convert rom_bar into OnOffAuto
> >>>        hw/qdev: Remove opts member
> >>>
> >>>   docs/about/deprecated.rst         |  7 +++++
> >>>   docs/igd-assign.txt               |  2 +-
> >>>   include/hw/pci/pci_device.h       |  2 +-
> >>>   include/hw/qdev-core.h            |  4 ---
> >>>   include/qapi/visitor-impl.h       |  3 ++-
> >>>   include/qapi/visitor.h            | 25 +++++++++++++----
> >>>   hw/core/qdev.c                    |  1 -
> >>>   hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
> >>>   hw/vfio/pci-quirks.c              |  2 +-
> >>>   hw/vfio/pci.c                     | 11 ++++----
> >>>   hw/xen/xen_pt_load_rom.c          |  4 +--
> >>>   qapi/opts-visitor.c               | 12 ++++-----
> >>>   qapi/qapi-clone-visitor.c         |  2 +-
> >>>   qapi/qapi-dealloc-visitor.c       |  4 +--
> >>>   qapi/qapi-forward-visitor.c       |  4 ++-
> >>>   qapi/qapi-visit-core.c            | 21 ++++++++++++---
> >>>   qapi/qobject-input-visitor.c      | 23 ++++++++--------
> >>>   qapi/qobject-output-visitor.c     |  2 +-
> >>>   qapi/string-input-visitor.c       |  2 +-
> >>>   qapi/string-output-visitor.c      |  2 +-
> >>>   system/qdev-monitor.c             | 12 +++++----
> >>>   tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
> >>>   22 files changed, 161 insertions(+), 73 deletions(-)
> >>> ---
> >>> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
> >>> change-id: 20240704-rombar-1a4ba2890d6c
> >>>
> >>> Best regards,
> >> 
> >> ... this is an awful lot of QAPI visitor infrastructure.  Infrastructure
> >> that will likely only ever be used for this one property.
> >> 
> >> Moreover, the property setter rom_bar_set() is a hack: it first tries to
> >> parse the value as enum, and if that fails, as uint32_t.  QAPI already
> >> provides a way to express "either this type or that type": alternate.
> >> Like this:
> >> 
> >>      { 'alternate': 'OnOffAutoUint32',
> >>        'data': { 'sym': 'OnOffAuto',
> >>                  'uint': 'uint32' } }
> >> 
> >> Unfortunately, such alternates don't work on the command line due to
> >> keyval visitor restrictions.  These cannot be lifted entirely, but we
> >> might be able to lift them sufficiently to make this alternate work.
> >
> > The keyval visitor cannot implement alternates because the command line 
> > input does not have type information. For example, you cannot 
> > distinguish string "0" and integer 0.
> 
> Correct.
> 
> For alternate types, an input visitor picks the branch based on the
> QType.
> 
> With JSON, we have scalar types null, number, string, and bool.
> 
> With keyval, we only have string.  Alternates with more than one scalar
> branch don't work.
> 
> They could be made to work to some degree, though.  Observe:
> 
> * Any value can be a string.
> 
> * "frob" can be nothing else.
> 
> * "on" and "off" can also be bool.
> 
> * "123" and "1e3" can also be number or enum.
> 
> Instead of picking the branch based on the QType, we could pick based on
> QType and value, where the value part is delegated to a visitor method.
> 
> This is also new infrastructure.  But it's more generally useful
> infrastructure.
> 
> >> Whether it would be worth your trouble and mine just to clean up
> >> "rombar" seems highly dubious, though.
> >
> > rom_bar_set() and and underlying visit_type_str_preserving() are ugly, 
> > but we can remove them once the deprecation period ends. On the other 
> > hand, if we don't make this change, dev->opts will keep floating around, 
> > and we will even have another use of it for "[PATCH v5 1/8] hw/pci: Do 
> > not add ROM BAR for SR-IOV VF"[1]. Eventually, having this refactoring 
> > early will result in less mess in the future.
> >
> > [1]: lore.kernel.org/r/20240715-sriov-v5-1-3f5539093ffc@daynix.com
> 
> Here's another idea.
> 
> Property "rombar" is backed by PCIDevice member uint32_t rom_bar, and
> defaults to 1.
> 
> The code uses member rom_bar as if it was a boolean: it tests
> zero/non-zero.
> 
> vfio_pci_size_rom() additionally uses qdict_haskey(dev->opts, "rombar")
> to see whether "rombar" was set by the user.
> 
> Taken together, "rom_bar" has three abstract states: zero,
> non-zero-default, non-zero-user.  The concrete representation uses
> dev->opts in addition to member rom_bar.  This is unusual.
> 
> You propose to represent as OnOffAuto instead, with On for
> non-zero-user, Off for zero, Auto for non-zero-default.  Fine, except
> for the compatibility headaches.
> 
> OnOffAuto is not the only option for encoding these three states.  We
> could also do positive, 0, negative.  Like this:
> 
> * Change "rombar" from unsigned to signed.
> 
> * Change its default to -1.
> 
> * Now 0 means off, positive means on, and negative means auto.
> 
> The change to signed breaks rombar=N for 2^31<=N<2^32.  Do we care?
> Only if we have reason to fear something passes such values.  I doubt
> it.  I'd expect only rombar=0 and rombar=1.
> 
> If we do care, we could create a special kind of property that maps any
> positive value to 1.
> 
> With the change, we no longer reject rombar=N for -2^31<=N<0.  That's
> not a compatiblity break.
> 
> Thoughts?

ack


