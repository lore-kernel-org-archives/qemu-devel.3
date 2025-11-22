Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE7CFC51E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 09:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMk8D-0000bU-Sm; Sat, 22 Nov 2025 04:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMjfw-0000E4-GB
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 04:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMjds-0001nT-Vk
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 04:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763802633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIpR1SurOkU1O/kBj2foITn4sY0/467WwD78EKKytYc=;
 b=MqH/7KPrJA7V7Nfy7qEX2/fI4Li6BrIieMcAiSTN8bibuZy0eIn7kFStOpyy8etn0SDDYZ
 89LUB5U7xe4Nzk2CWDQKI9ro73N7BiW5Nc5Tgap+gXGzsVvaPo4Qb734oA48hr9d06gKag
 QO7AjTs0CDlnMMYqhB5fS3KAh46lVMg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-IbBrsXMbM1aNI2YKylw59w-1; Sat,
 22 Nov 2025 04:10:29 -0500
X-MC-Unique: IbBrsXMbM1aNI2YKylw59w-1
X-Mimecast-MFC-AGG-ID: IbBrsXMbM1aNI2YKylw59w_1763802628
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4BEF19560A3; Sat, 22 Nov 2025 09:10:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48FEA1940E82; Sat, 22 Nov 2025 09:10:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B30A021E6A27; Sat, 22 Nov 2025 10:10:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  philmd@linaro.org
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
In-Reply-To: <87cy5u9erh.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 07 Nov 2025 14:02:58 +0100")
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
 <87qzuniadg.fsf@pond.sub.org> <87cy5u9erh.fsf@pond.sub.org>
Date: Sat, 22 Nov 2025 10:10:24 +0100
Message-ID: <87v7j2qvpb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 10/22/25 12:14, Markus Armbruster wrote:
>>>> qdev_print_props() retrieves a property's value from its legacy
>>>> property if it exists.  A legacy property is created by
>>>> qdev_class_add_legacy_property() when the property has a print()
>>>> method or does not have a get() method.
>>>>
>>>> If it has a print() method, the legacy property's value is obtained
>>>> from the property's print() method.  This is used to format PCI
>>>> addresses nicely, i.e. like 01.3 instead of 11.
>>>>
>>>> Else, if doesn't have a get() method, the legacy property is
>>>> unreadable.  "info qtree" silently skips unreadable properties.
>>>>
>>>> Link properties don't have a get() method, and are therefore skipped.
>>>> This is wrong, because the underlying QOM property *is* readable.
>>>>
>>>> Change qdev_print_props() to simply use a print() method directly if
>>>> it exists, else get the value via QOM.
>>>>
>>>> "info qtree" now shows links fine.  For instance, machine "pc" onboard
>>>> device "PIIX4_PM" property "bus" is now visible.
>>>
>>> It's been many years, but I think the original idea was that dc->props_=
 would be replaced with walking QOM properties.
>>>
>>> I'm not opposed to the patch, but it would put the plan in the coffin s=
o I thought I'd point that out.
>
> [...]
>
>> My proposed solution: bypass QOM, use qdev directly.  Quite a bit
>> simpler.  No need for additional comments, I hope.  Kills the accidental
>> external interface.
>>
>> A possible future solution: add the concept to QOM.  Then we could walk
>> QOM properties instead of dc->props_.  So, it's not quite the coffin,
>> more like the freezer.
>>
>>> In the meanwhile I queued patch 1, which is an obviously good idea.
>
> Paolo, are you okay with the freezer?
>
> [...]

Paolo, we have a (minor) bug, and two fixes, this series, and
Marc-Andr=C3=A9's "[PATCH] RFC: qdev: add legacy properties only for those
print()-able"
Message-ID: <20251015105419.2975542-1-marcandre.lureau@redhat.com>

Would be nice to get a fix into 10.2.  I'll post a pull request for mine
unless you tell me not to bother.


