Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E31C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 12:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiupF-0002uI-Am; Fri, 14 Feb 2025 07:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiup4-0002tY-Dv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:29:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiuov-0005OZ-BE
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739536161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVYijGaUmxS18cc7g1Cfzb3XW6EGbHCO6+g5VgAJyqQ=;
 b=ZmBb2hZC+/sekUAzOfSCvuqRhOtcMoGDXLwTFi7ZJBXxfHGClB+YfYWFGHqpP+2P80ORTO
 +wZluNwG7zV5M6ITtRYxQjtm2lrPu+x9k0whBYHyjAgLzAUUDh+5l5UIKc2wmrASY6kmUL
 WErjfK9CiRM79nHUuV8EIie4XMFLvQM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-zVdaH6yQN0KC2YjPhCAMiw-1; Fri,
 14 Feb 2025 07:29:20 -0500
X-MC-Unique: zVdaH6yQN0KC2YjPhCAMiw-1
X-Mimecast-MFC-AGG-ID: zVdaH6yQN0KC2YjPhCAMiw_1739536159
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A2621800878; Fri, 14 Feb 2025 12:29:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BE361955E79; Fri, 14 Feb 2025 12:29:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E6CA21E6A28; Fri, 14 Feb 2025 13:29:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,  gaosong <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,  QEMU devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/loongarch: Add full type support for
 query-cpu-model-expansion
In-Reply-To: <c1f5c4d2-d131-452f-b414-169bb6685f07@redhat.com> (David
 Hildenbrand's message of "Thu, 13 Feb 2025 17:25:08 +0100")
References: <20250213091626.3650603-1-maobibo@loongson.cn>
 <30c1c330-32d1-fa36-c0ca-670c94a06736@loongson.cn>
 <87a5aqhxpt.fsf@pond.sub.org>
 <20250213171705.6dde38cf@imammedo.users.ipa.redhat.com>
 <c1f5c4d2-d131-452f-b414-169bb6685f07@redhat.com>
Date: Fri, 14 Feb 2025 13:29:14 +0100
Message-ID: <877c5s4smd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

David Hildenbrand <david@redhat.com> writes:

> On 13.02.25 17:17, Igor Mammedov wrote:
>> On Thu, 13 Feb 2025 12:48:30 +0100
>> Markus Armbruster <armbru@redhat.com> wrote:
>> 
>>> gaosong <gaosong@loongson.cn> writes:
>>>
>>>> Cc: Markus
>>>>
>>>> hi, Markus
>>>>
>>>> What is the difference between CPU_MODEL_EXPANSION_TYPE_STATIC and
>>>> CPU_MODEL_EXPANSION_TYPE_FULL?
>>
>> the only difference is that 'static' expansion will not report properties
>> not mentioned in hard-codded CPU model definition see: builtin_x86_defs
>> while 'full' will iterate over/report all rw properties of CPU object
>> created from provided model name.
>> 
>>> I don't know :)
>>>
>>> Here's the documentation:
>>>
>>>      ##
>>>      # @CpuModelExpansionType:
>>>      #
>>>      # An enumeration of CPU model expansion types.
>>>      #
>>>      # @static: Expand to a static CPU model, a combination of a static
>>>      #     base model name and property delta changes.  As the static base
>>>      #     model will never change, the expanded CPU model will be the
>>>      #     same, independent of QEMU version, machine type, machine
>>>      #     options, and accelerator options.  Therefore, the resulting
>>>      #     model can be used by tooling without having to specify a
>>>      #     compatibility machine - e.g. when displaying the "host" model.
>>>      #     The @static CPU models are migration-safe.
>>
>> Looking at related x86 code above description sounds like a fiction.
>
> On s390x, which added that interface, that is how it's work.
>
> It resolves to "-base" models that are fixed for all eternity.
>
> x86-64 probably didn't adhere to the description because they were not interested in adding stable base models.

Looks like we made a mess.

Having the same command work differently on different targets is less
than ideal.  I'm sure there were reasons both for the initial s390x
design, and for x86-64 deviating from it later.  I'm not qualified to
debate this.

Regardless, actual behavior should match documented behavior.  If actual
behavior depends on the target, then documentation needs to explain that
in sufficient detail.

Could we get this fixed, please?


