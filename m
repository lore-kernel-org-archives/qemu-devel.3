Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E12CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDh1Q-0003fl-U8; Tue, 28 Oct 2025 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDh1O-0003f5-Md
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDh1J-0003mo-RV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761647616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrbSJcaZdJCciFUGXyyYCLqoy9Y4yz1dwZ04+cM1MVU=;
 b=dCihNkyet6TrV+AWDQHpyuUXuJFX6kLuv7AGPxu9x1lMPIqJeFhapYYU+g5coIQ9l3VK1u
 HJHklwcJCJ7gRaL720G/63ygAmyKN23+NKgraR+rvCkT5JwTbnjQb8ravWk7sirlVmc04b
 b4Yys+pmV/CeCZR4fFZFMhdD7nmY9O8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-JhTmQUEiOSihvnhuJlsfRQ-1; Tue,
 28 Oct 2025 06:33:35 -0400
X-MC-Unique: JhTmQUEiOSihvnhuJlsfRQ-1
X-Mimecast-MFC-AGG-ID: JhTmQUEiOSihvnhuJlsfRQ_1761647614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2FA51800673; Tue, 28 Oct 2025 10:33:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42B30180044F; Tue, 28 Oct 2025 10:33:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A23C521E6A27; Tue, 28 Oct 2025 11:33:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  philmd@linaro.org
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
In-Reply-To: <58177628-7349-4450-a4c0-58bd44b39586@redhat.com> (Paolo
 Bonzini's message of "Fri, 24 Oct 2025 09:05:25 +0200")
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
Date: Tue, 28 Oct 2025 11:33:31 +0100
Message-ID: <87qzuniadg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/22/25 12:14, Markus Armbruster wrote:
>> qdev_print_props() retrieves a property's value from its legacy
>> property if it exists.  A legacy property is created by
>> qdev_class_add_legacy_property() when the property has a print()
>> method or does not have a get() method.
>>
>> If it has a print() method, the legacy property's value is obtained
>> from the property's print() method.  This is used to format PCI
>> addresses nicely, i.e. like 01.3 instead of 11.
>>
>> Else, if doesn't have a get() method, the legacy property is
>> unreadable.  "info qtree" silently skips unreadable properties.
>>
>> Link properties don't have a get() method, and are therefore skipped.
>> This is wrong, because the underlying QOM property *is* readable.
>>
>> Change qdev_print_props() to simply use a print() method directly if
>> it exists, else get the value via QOM.
>>
>> "info qtree" now shows links fine.  For instance, machine "pc" onboard
>> device "PIIX4_PM" property "bus" is now visible.
>
> It's been many years, but I think the original idea was that dc->props_ would be replaced with walking QOM properties.
>
> I'm not opposed to the patch, but it would put the plan in the coffin so I thought I'd point that out.

I'd argue that legacy properties are a questionable hack to preserve a
specific solution to a problem.

The problem: PCI addresses are integers in C and in QOM.  Makes sense.
But "info qtree" has always displayed PCI addresses in the form DEV.FN,
which also makes sense.

The pre-QOM solution: qdev property method .get() returns the integer,
.print() formats it for humans.  "info qtree" used the latter.

Aside: "format for humans" may well be more widely applicable, if we
care.

The current QOM solution: QOM has no concept "format for humans", it has
only .get().  Instead of introducing the concept, we added "legacy
properties" whose .get() method wraps around qdev's .print() instead of
qdev's .get().

This created yet another accidental external interface.  Fixable the
same way as other accidentally exposed properties: add the means to
restrict access to C.

How legacy properties work and how they're used is less than clear.
Evidence: I was rather confused, and had to dig through quite a bit of
code to unconfuse myself.  I guess that would also be fixable to a
degree with comments.

My proposed solution: bypass QOM, use qdev directly.  Quite a bit
simpler.  No need for additional comments, I hope.  Kills the accidental
external interface.

A possible future solution: add the concept to QOM.  Then we could walk
QOM properties instead of dc->props_.  So, it's not quite the coffin,
more like the freezer.

> In the meanwhile I queued patch 1, which is an obviously good idea.

Thanks!


