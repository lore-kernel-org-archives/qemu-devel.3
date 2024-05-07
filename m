Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B59DC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LUY-0004cK-3i; Tue, 07 May 2024 10:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1s4LUT-0004bR-CY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:08:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1s4LUQ-0007K6-1O
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:08:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41c1b75ca31so23721615e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715090894; x=1715695694; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0eyEN+lN2d89qsiNcCMABN73lgJ74gmZYo/vCmr9XQs=;
 b=SVouY8s36t5crs7ZDxhpAGDIrIEXmbVnythaK3yMhgkyN2RgKFZoz+CWtiDjay+jTM
 BW+WQBBPWb6bd1QX0xnIInEi/r/Brz3GK1JvZya7Ti0dR7AX0on6+jmZghZUfQpa65jn
 +VBuFiQL49NM8TSr3HPcskLwWYbBWA0GipZBPIVPiWHR/KAb5RiQg7GvHpCLnDhaC2Og
 qBssr5/2K9R06zGXkScgDRi4cZGMoRAPE7RslE4C+eyPLkn2b0cp4TpVaMmciwkB5xxH
 6BotII0RnVTX2OR9H8D/ppYurpTlNtPKnNMovuucdHW0SEnXJnlYYJV21GAV30MEc7KY
 EN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090894; x=1715695694;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0eyEN+lN2d89qsiNcCMABN73lgJ74gmZYo/vCmr9XQs=;
 b=NMo2zQ9UUhwld1LHIgM5+HCrPYmfswWqQmgk6qi8093SXRrD/lZEcrDH5mRD7hOycJ
 T2oskDDfgjmGGuBgbCOj5qR25dkZX+RnrO62eR2ncmxDrAB4hDkz8H5kPycP3xAzqOjQ
 5LQvvALeC0ngRXPcoowUI2IOZzg66tbYkSYsYFer7hVlV2T2eRIpYtkyeZHXxN23GHpZ
 dmrLPWrFCdoTfmRwNGBBOutdzmXcSVfQicOqXgwRHjK8FcH5UImWYBcIKbZBv/xpSnm0
 iE/VyTgQ5c39vFpZmu9O/MCXMU8TE4cbw3n9ZgA0YnX0Y8N/9x6d4n+l6SgTBCU5hKsR
 a4XQ==
X-Gm-Message-State: AOJu0YyV+WcNDd/ZVOh6kY/1cyxDWp9Wi6ruxOE5DiYZmCUuLALdlsJ1
 5CZDtTX/5S8u0xaa4DQ8bfxwUT/u9N+521vqyPcJ5SZdsqAsTr+oUvcijAUHawE=
X-Google-Smtp-Source: AGHT+IGlttZAhv8cxhcPYtjzzBgNUplSPLsrotjw472uiYX9hBgEDy4U1tx+b4DPRH24qSwe8q6UIw==
X-Received: by 2002:a05:600c:4f91:b0:41b:9828:f4c2 with SMTP id
 n17-20020a05600c4f9100b0041b9828f4c2mr10448952wmq.3.1715090893728; 
 Tue, 07 May 2024 07:08:13 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a05600c4e4500b0041906397ab7sm19946719wmq.3.2024.05.07.07.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:08:13 -0700 (PDT)
Message-ID: <b1bd1a62a9d3f80f1441648b58794f81abee329b.camel@suse.com>
Subject: Re: [PATCH v2 03/10] backends/confidential-guest-support: Add
 functions to support IGVM
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, 
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Tue, 07 May 2024 15:08:12 +0100
In-Reply-To: <Zh59n3w5Ijfd2uLs@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <1dff8015f9f9cf735de21a16e5dba14371c39155.1712141833.git.roy.hopkins@suse.com>
 <c31dcace-92da-4de7-93e6-631120829a75@linaro.org>
 <Zh59n3w5Ijfd2uLs@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::32b;
 envelope-from=roy.hopkins@suse.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2024-04-16 at 14:31 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 04, 2024 at 10:00:53AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Roy,
> >=20
> > On 3/4/24 13:11, Roy Hopkins wrote:
> > > In preparation for supporting the processing of IGVM files to configu=
re
> > > guests, this adds a set of functions to ConfidentialGuestSupport
> > > allowing configuration of secure virtual machines that can be
> > > implemented for each supported isolation platform type such as Intel =
TDX
> > > or AMD SEV-SNP. These functions will be called by IGVM processing cod=
e
> > > in subsequent patches.
> > >=20
> > > This commit provides a default implementation of the functions that
> > > either perform no action or generate a warning or error when they are
> > > called. Targets that support ConfidentalGuestSupport should override
> > > these implementations.
> > >=20
> > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > ---
> > > =C2=A0 backends/confidential-guest-support.c=C2=A0=C2=A0=C2=A0=C2=A0 =
| 32 ++++++++++
> > > =C2=A0 include/exec/confidential-guest-support.h | 74 +++++++++++++++=
++++++++
> > > =C2=A0 2 files changed, 106 insertions(+)
> >=20
> >=20
> > > =C2=A0 struct ConfidentialGuestSupport {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Object parent;
> > > @@ -60,6 +94,46 @@ struct ConfidentialGuestSupport {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *igvm_filename;
> > > =C2=A0 #endif
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * The following virtual methods need to be =
implemented by systems
> > > that
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * support confidential guests that can be c=
onfigured with IGVM and
> > > are
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * used during processing of the IGVM file w=
ith process_igvm().
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Check for to see if this confidential gue=
st supports a particular
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * platform or configuration
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 int (*check_support)(ConfidentialGuestPlatformTyp=
e platform,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint16_t platform_version, uint8_t highest_vtl,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t shared_gpa_boundary);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Configure part of the state of a guest fo=
r a particular set of
> > > data, page
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * type and gpa. This can be used for exampl=
e to pre-populate and
> > > measure
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * guest memory contents, define private ran=
ges or set the initial
> > > CPU state
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * for one or more CPUs.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * If memory_type is CGS_PAGE_TYPE_VMSA then=
 ptr points to the
> > > initial CPU
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * context for a virtual CPU. The format of =
the data depends on the
> > > type of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * confidential virtual machine. For example=
, for SEV-ES ptr will
> > > point to a
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * vmcb_save_area structure that should be c=
opied into guest memory
> > > at the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * address specified in gpa. The cpu_index p=
arameter contains the
> > > index of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * the CPU the VMSA applies to.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, =
uint64_t len,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ConfidentialGuestPageType memory_type,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 uint16_t cpu_index, Error **errp);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Iterate the system memory map, getting th=
e entry with the given
> > > index
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * that can be populated into guest memory.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Returns 0 for ok, 1 if the index is out o=
f range and -1 on error.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0 int (*get_mem_map_entry)(int index, ConfidentialG=
uestMemoryMapEntry
> > > *entry,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp);
> > > =C2=A0 };
> > > =C2=A0 typedef struct ConfidentialGuestSupportClass {
> >=20
> > Methods are usually a class field, not an instance one. Any
> > reason to diverge from this norm?
>=20
> Agreed, this should all be against the Class.
>=20
>=20
> With regards,
> Daniel

Right, thanks. I'll make this change.

Regards,
Roy

