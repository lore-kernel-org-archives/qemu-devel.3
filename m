Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC2C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IIO-0002AA-5Z; Tue, 22 Apr 2025 14:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7IIA-00027U-JA
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u7II8-0000zT-09
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745346257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiP4Z59uglifvspSfEjDHmaS7BcIG+SSHUyv+yx0ZU4=;
 b=VO6F2IY98hvSScLZgR+tdTU2KH7+0/KPE6VuZsXlshZEtAzy5mmc+aaqKZjtuvpC9mb/2t
 hA1oXLm9ieVH7rzWC1yArtLK0IAc2RxvYCTomiIhGYJeB07zJxvGrOx9UvBm7MksJC+snu
 U5z+BC6rZk3GVLcc1hDc84gshrkO/rM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-IWVtEktrM8mpeM3tP6cffg-1; Tue,
 22 Apr 2025 14:24:11 -0400
X-MC-Unique: IWVtEktrM8mpeM3tP6cffg-1
X-Mimecast-MFC-AGG-ID: IWVtEktrM8mpeM3tP6cffg_1745346250
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1962018001D5; Tue, 22 Apr 2025 18:24:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ECAA180045C; Tue, 22 Apr 2025 18:24:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0034E21E66C2; Tue, 22 Apr 2025 20:24:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Anton Johansson
 <anjo@rev.ng>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 13/14] qemu/target_info: Add target_aarch64() helper
In-Reply-To: <f5e7f82e-4a97-47e1-bcf5-67a9c72d9572@linaro.org> (Pierrick
 Bouvier's message of "Tue, 22 Apr 2025 10:50:47 -0700")
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-14-philmd@linaro.org>
 <41c9061f-ffd8-47a8-b2e8-7c4b2a2c2fcf@linaro.org>
 <ff7cdc09-f11c-43ae-b1e4-668c39db3efe@linaro.org>
 <3242cee6-7485-4958-a198-38d0fc68e8cd@linaro.org>
 <87tt6g91fq.fsf@pond.sub.org>
 <f5e7f82e-4a97-47e1-bcf5-67a9c72d9572@linaro.org>
Date: Tue, 22 Apr 2025 20:24:06 +0200
Message-ID: <87y0vsxdfd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 4/21/25 23:04, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>> [...]
>> 
>>> At this point, I would like to focus on having a first version of TargetInfo API, and not reviewing any other changes, as things may be modified, and they would need to be reviewed again. It's hard to follow the same abstraction done multiple times in multiple series.
>>>
>>> Regarding your proposal for target_system_arch(), I understand that you tried to reuse the existing SysEmuTarget, which was a good intention.
>>> However, I don't think we should use any string compare for this (which qemu_api_parse does). It has several flaws:
>> 
>> qemu_api_parse()?  Do you mean qapi_enum_parse()?
>
> Yes, sorry for the typo.
>
>>> - The most important one: it can fail (what if -1 is returned?). Enums can be guaranteed and exhaustive at compile time.
>>> - It's slower than having the current arch directly known at compile time.
>>> As well, since SysEmuTarget is a generated enum, it makes it much harder to follow code IMHO.
>>> QAPI requires those things to be defined from a json file for external usage, but it's not a good reason for being forced to use it in all the codebase as the only possible abstraction.
>>>
>>> To have something fast and infallible, we can adopt this solution:
>>>
>>> In target_info.h:
>>>
>>> /* Named TargetArch to not clash with poisoned TARGET_X */
>>> typedef enum TargetArch {
>>>      TARGET_ARCH_AARCH64,
>>>      TARGET_ARCH_ALPHA,
>>>      TARGET_ARCH_ARM,
>>>      TARGET_ARCH_AVR,
>>>      TARGET_ARCH_HPPA,
>>>      TARGET_ARCH_I386,
>>>      TARGET_ARCH_LOONGARCH64,
>>>      TARGET_ARCH_M68K,
>>>      TARGET_ARCH_MICROBLAZE,
>>>      TARGET_ARCH_MICROBLAZEEL,
>>>      TARGET_ARCH_MIPS,
>>>      TARGET_ARCH_MIPS64,
>>>      TARGET_ARCH_MIPS64EL,
>>>      TARGET_ARCH_MIPSEL,
>>>      TARGET_ARCH_OR1K,
>>>      TARGET_ARCH_PPC,
>>>      TARGET_ARCH_PPC64,
>>>      TARGET_ARCH_RISCV32,
>>>      TARGET_ARCH_RISCV64,
>>>      TARGET_ARCH_RX,
>>>      TARGET_ARCH_S390X,
>>>      TARGET_ARCH_SH4,
>>>      TARGET_ARCH_SH4EB,
>>>      TARGET_ARCH_SPARC,
>>>      TARGET_ARCH_SPARC64,
>>>      TARGET_ARCH_TRICORE,
>>>      TARGET_ARCH_X86_64,
>>>      TARGET_ARCH_XTENSA,
>>>      TARGET_ARCH_XTENSAEB,
>>> } TargetArch;
>> 
>> Effectively duplicates generated enum SysEmuTarget.  Can you explain why
>> that's useful?
>
> In terms of code, it doesn't change anything. we could reuse SysEmuTarget.
> I just think it's more clear to have the enum defined next to the structure using it, compared to have this buried in generated code that can't be grepped easily.
> (git grep SYS_EMU returns nothing, so people have to remember it's converted from a Json, and that naming is different).

Yes, that's unfortunate, but we don't duplicate other QAPI enums because
of it.

> IMHO, DRY principle should not always be followed blindly when it hurts code readability.

Treating DRY as dogma would be foolish.

> That said, my editor is able to find the generated definition as well, so I don't really mind reusing SysEmuTarget if we think the code readability is not worth the duplication.

It's not just the duplication, it's also the conversion between the two
enums.

> However, I think it's a problem to compare strings to find this, when it can be set at compile time, in a file that will have to stay target specific anyway.

Converting from string to enum at first practical opportunity makes the
code simpler more often than not.


[...]


