Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5F9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4v9-0007jh-3y; Wed, 31 Jul 2024 04:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ4v8-0007ga-Bv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ4v6-0003XD-RM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722415372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6s7ClsJ2DKLcy/84CoFLT/gUrVMTGlM5VvNrcIpjRRY=;
 b=GNIP87UMZRDLlgklcIoU8z0MyH80el+tQJRwX5SUX0AsnZ5P6ZSiz6W+Twiku3I4EyxL77
 geoRZs0OlHr8va1Od5u+gmZ2aCzHmSqSZ364Mv7aijTMHiNOLCfBNlwmmfttdGsuaERTqi
 uxCv/fiO90vbECvejMP6uHnvqNW/wXM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-EgeKoRbaOwGaJZmTEiw40w-1; Wed,
 31 Jul 2024 04:42:47 -0400
X-MC-Unique: EgeKoRbaOwGaJZmTEiw40w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2FE719560BF; Wed, 31 Jul 2024 08:42:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E45B19560AA; Wed, 31 Jul 2024 08:42:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BEDB21E6690; Wed, 31 Jul 2024 10:42:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  berrange@redhat.com,  eduardo@habkost.net
Subject: Re: [PATCH v2 2/2] qom/object, accel-system: add support to Accel
 globals
In-Reply-To: <20240731-b34061e3e3d7ce4c3d76f481@orel> (Andrew Jones's message
 of "Wed, 31 Jul 2024 09:41:39 +0200")
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-3-dbarboza@ventanamicro.com>
 <87bk2ekr8p.fsf@pond.sub.org> <20240731-b34061e3e3d7ce4c3d76f481@orel>
Date: Wed, 31 Jul 2024 10:42:43 +0200
Message-ID: <87ttg6hrzw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Andrew Jones <ajones@ventanamicro.com> writes:

> On Wed, Jul 31, 2024 at 08:30:46AM GMT, Markus Armbruster wrote:
>> I apologize for the delay.
>> 
>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
>> 
>> > We're not honouring KVM options that are provided by any -accel option
>> > aside from the first. In this example:
>> >
>> > qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>> >     -accel kvm,riscv-aia=hwaccel
>> >
>> > 'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
>> > option that set 'riscv-aia' to 'hwaccel'.
>> 
>> The way you phrase this, it sounds like a bug.  But as far as I know,
>> -accel is meant to have fallback semantics: we use the first one that
>> works.
>
> The fact that some (most?) parameters have override semantics and some
> have fallback semantics makes our complicated command line even more
> complicated, especially since there's no way to know which is which.

We traditionally tramsmit such knowledge from guru to disciple.

We certainly made an unholy mess of our command line.

> IMHO, always having override semantics and then providing new parameters,
> e.g. -accel-fallback (or a property, -accel fallback=on,...), would go a
> long way to bringing some order to the universe.
>
>> Perhaps:
>> 
>>   -accel has fallback semantics, i.e. we try accelerators in order until
>>   we find one that works.  Any remainder is ignored.
>> 
>>   Because of that, you can't override properties like this:
>> 
>>       qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>>           -accel kvm,riscv-aia=hwaccel
>> 
>>   When KVM is available, 'riscv-aia' will be set to 'emul', and the
>>   second -accel is ignored.  When KVM is not available, neither option
>>   works, and the command fails.
>> 
>> Why would you want to override accelerator properties?
>
> Testing. Many properties are only available to allow the user to force
> non defaults. The example above isn't exactly what triggered this. The
> real use is, '-accel kvm' is the default used by libvirt and when
> riscv-aia=hwaccel is possible, it will default to hwaccel. In order to
> test riscv-aia emulation support using libvirt (which doesn't yet allow
> selecting anything riscv specific), I attempted to use the qemu
> commandline element to override -accel with kvm,riscv-aia=emul.

Ah, that explains why -global solves your problem, too!  Thanks!

I recommend to start the commit message with the use case, then describe
the solution.  Mention other solutions last, if at all.


