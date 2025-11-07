Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7F2CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHM7X-0004no-Lz; Fri, 07 Nov 2025 08:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHM7U-0004n5-5v
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHM7Q-0002bT-4x
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 08:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762520587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3CaksWcNtYQQ2utmlw27VXs3qOaOKDzID4oywmVrq4=;
 b=Y1Swu86p9BTx3NCP/N1Sj4WRALqcstqENpRPpaij91Gr+sQrr08bFs6LgqXkmBxRbIZyHi
 YUhZmSNlQPJm2lMu4amdnBGqkkSx108IzymozNOXIN0nu2jR1CukPdHMXTzsrAeXZ6M2IG
 RsVNnPrlig4QNRun6ZgySnZ6g3lbSN0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-cZ1sZ1n0Oo6XIqCKXmS7Rw-1; Fri,
 07 Nov 2025 08:03:06 -0500
X-MC-Unique: cZ1sZ1n0Oo6XIqCKXmS7Rw-1
X-Mimecast-MFC-AGG-ID: cZ1sZ1n0Oo6XIqCKXmS7Rw_1762520585
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02DDC180A252; Fri,  7 Nov 2025 13:03:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C8C230044DB; Fri,  7 Nov 2025 13:03:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD35121E6A27; Fri, 07 Nov 2025 14:02:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  philmd@linaro.org
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
In-Reply-To: <87qzuniadg.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 28 Oct 2025 11:33:31 +0100")
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
 <87qzuniadg.fsf@pond.sub.org>
Date: Fri, 07 Nov 2025 14:02:58 +0100
Message-ID: <87cy5u9erh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Markus Armbruster <armbru@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 10/22/25 12:14, Markus Armbruster wrote:
>>> qdev_print_props() retrieves a property's value from its legacy
>>> property if it exists.  A legacy property is created by
>>> qdev_class_add_legacy_property() when the property has a print()
>>> method or does not have a get() method.
>>>
>>> If it has a print() method, the legacy property's value is obtained
>>> from the property's print() method.  This is used to format PCI
>>> addresses nicely, i.e. like 01.3 instead of 11.
>>>
>>> Else, if doesn't have a get() method, the legacy property is
>>> unreadable.  "info qtree" silently skips unreadable properties.
>>>
>>> Link properties don't have a get() method, and are therefore skipped.
>>> This is wrong, because the underlying QOM property *is* readable.
>>>
>>> Change qdev_print_props() to simply use a print() method directly if
>>> it exists, else get the value via QOM.
>>>
>>> "info qtree" now shows links fine.  For instance, machine "pc" onboard
>>> device "PIIX4_PM" property "bus" is now visible.
>>
>> It's been many years, but I think the original idea was that dc->props_ would be replaced with walking QOM properties.
>>
>> I'm not opposed to the patch, but it would put the plan in the coffin so I thought I'd point that out.

[...]

> My proposed solution: bypass QOM, use qdev directly.  Quite a bit
> simpler.  No need for additional comments, I hope.  Kills the accidental
> external interface.
>
> A possible future solution: add the concept to QOM.  Then we could walk
> QOM properties instead of dc->props_.  So, it's not quite the coffin,
> more like the freezer.
>
>> In the meanwhile I queued patch 1, which is an obviously good idea.

Paolo, are you okay with the freezer?

[...]


