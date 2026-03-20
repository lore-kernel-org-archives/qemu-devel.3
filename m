Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A89109878A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3b9Z-0005MX-TS; Fri, 20 Mar 2026 10:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3b9P-0005Lx-UW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3b9L-0006vY-CZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774018108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zd0Dq6GFNiubdSSXsQKDRMdABfAtqb+M1HviNvlCQGw=;
 b=R4vslS4AihIhWEM+T9XPAvIZROrMtqRGs7NwXZO8EY6LzX77NWZwG+BJMjTGCUnUSmOgXi
 Ehz4QrBwEyuuEdOISATQmp0iPkmK+0iaiLbGjXGBl/eaSlkXeTi2xa2dgtbnmwwA2k9J2T
 nj/6Ofr5H1J1o1bcj3J/06KaKnWxuBg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-8nEsee1HPVidgZ0gMIZtJA-1; Fri,
 20 Mar 2026 10:48:27 -0400
X-MC-Unique: 8nEsee1HPVidgZ0gMIZtJA-1
X-Mimecast-MFC-AGG-ID: 8nEsee1HPVidgZ0gMIZtJA_1774018106
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A04EC18005B8; Fri, 20 Mar 2026 14:48:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C622330001A1; Fri, 20 Mar 2026 14:48:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D5A621E6937; Fri, 20 Mar 2026 15:48:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,  Giuseppe Lettieri
 <giuseppe.lettieri@unipi.it>,  Paolo Bonzini <pbonzini@redhat.com>,  Luigi
 Leonardi <leonardi@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
In-Reply-To: <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com> (Tommaso
 Califano's message of "Fri, 20 Mar 2026 15:25:01 +0100")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <87tsucvw3k.fsf@pond.sub.org>
 <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com>
Date: Fri, 20 Mar 2026 15:48:22 +0100
Message-ID: <878qbm4kw9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tommaso Califano <califano.tommaso@gmail.com> writes:

> Il 19/03/26 13:31, Markus Armbruster ha scritto:
>> Tommaso Califano <califano.tommaso@gmail.com> writes:
>> 
>>> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
>>> limiting development and testing to users with specialized server
>>> hardware. This makes it hard to validate SEV guest behavior, like
>>> OVMF boots or SEV-aware software, on common dev machines.
>>> A solution to this is the emulation of SEV from the guest's
>>> perspective using TCG.
>>>
>>> This change begins this process with the exposure of the SEV CPUID leaf.
>>> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>>>
>>> case 0x8000001F:
>>>     *eax = *ebx = *ecx = *edx = 0;
>>>     if (sev_enabled()) {
>>>         *eax = 0x2;
>>>         *eax |= sev_es_enabled() ? 0x8 : 0;
>>>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>>>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>>>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>>>     }
>>>     break;
>>>
>>> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
>>> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
>>> to satisfy this check with minimal changes. In particular this allows
>>> to bypass all the sev_enabled() checks for future features.
>>>
>>> Since KVM hardware isn't available, override the QOM's kvm_init() and add
>>> a conditional confidential_guest_kvm_init() call during machine_init() to
>>> set up emulated confidential support using the ConfidentialGuestSupport
>>> structure.
>>>
>>> With this change it is possible to run a VM with the SEV CPUID active
>>> adding:
>>>
>>>     -accel tcg \
>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>     -machine memory-encryption=sev0
>>>
>>> To the QEMU start arguments.
>>>
>>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
>> 
>> [...]
>> 
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c653248f85..35cda819ec 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json

[...]

>>> @@ -1241,6 +1254,7 @@
>>>      { 'name': 'secret_keyring',
>>>        'if': 'CONFIG_SECRET_KEYRING' },
>>>      'sev-guest',
>>> +    'sev-emulated',
>>>      'sev-snp-guest',
>>>      'thread-context',
>>>      's390-pv-guest',
>> 
>> Please insert before sev-guest to keep things more or less sorted.
>> 
>
> I'll do it, but I don't understand the convention. I'd organized them
> by object derivation hierarchy, so what is the expected sorting order?

It looks alphabetical modulo lazy mistakes to me.

[...]


