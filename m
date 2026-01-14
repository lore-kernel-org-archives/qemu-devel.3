Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F0CD29FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfz31-0000YF-MR; Wed, 14 Jan 2026 06:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfz2m-0000UM-Bh
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfz2j-00016t-4E
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768390084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npEeJF9vFqQoupP8982dKGPAIdfwtxnGXFBbQHztvjc=;
 b=KO8PM+uKGapob1RohErPpUIuOm6oVGTWK+6m1K8xxzBlGEhSP5EID9PuXGbwKZYCfK7t8m
 gbKbIDU+KA8Kn4fJm+77f3uzxc4AaOi4qcaeyVoJG/KbxtBha3xmKcW9MHOpooARFZqcBM
 y0Fs05ts5dhH8xOUFN1sOBggMNbB3aQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-HCmcFRiAPpWP6RMLTxHdaQ-1; Wed,
 14 Jan 2026 06:28:00 -0500
X-MC-Unique: HCmcFRiAPpWP6RMLTxHdaQ-1
X-Mimecast-MFC-AGG-ID: HCmcFRiAPpWP6RMLTxHdaQ_1768390079
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858041800371; Wed, 14 Jan 2026 11:27:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C6E18004D8; Wed, 14 Jan 2026 11:27:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D18921E692D; Wed, 14 Jan 2026 12:27:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Reinoud Zandijk
 <reinoud@netbsd.org>,  Ryo ONODERA <ryoon@netbsd.org>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
In-Reply-To: <8bff8d59-7729-4a08-b4c6-e32c2ff35e68@redhat.com> (Paolo
 Bonzini's message of "Wed, 14 Jan 2026 11:54:09 +0100")
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org>
 <8bff8d59-7729-4a08-b4c6-e32c2ff35e68@redhat.com>
Date: Wed, 14 Jan 2026 12:27:56 +0100
Message-ID: <87wm1k303n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/14/26 11:45, Markus Armbruster wrote:
>>> ---- target/i386/nvmm/nvmm-all.c.orig	2024-11-20 22:48:05.000000000 +0000
>>> +--- target/i386/nvmm/nvmm-all.c.orig	2025-08-26 18:32:38.000000000 +0000
>>>   +++ target/i386/nvmm/nvmm-all.c
>>> -@@ -1057,7 +1057,11 @@ nvmm_process_section(MemoryRegionSection
>>> +@@ -984,7 +984,7 @@ nvmm_init_vcpu(CPUState *cpu)
>>> +         }
>>> +     }
>>> +
>>> +-    qcpu->vcpu_dirty = true;
>>> ++    cpu->vcpu_dirty = true;
>>> +     cpu->accel = qcpu;
>>> +
>>> +     return 0;
>>> +@@ -1059,7 +1059,11 @@ nvmm_process_section(MemoryRegionSection
>>>        unsigned int delta;
>>>        uintptr_t hva;
>> That they didn't immediately post the fix upstream is a bit of a
>> disappointment.  Deep in the weeds, I guess.
>
> Eh, it happens. :/  For the future, since Ryo and Reinoud are in Cc, it would have been enough to contact anyone on IRC or reply to the release announcement.

Yes, it happens, especially when you're deep in the weeds.


