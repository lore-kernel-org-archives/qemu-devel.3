Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8DEC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPpj-0004sG-0C; Tue, 04 Jun 2024 04:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEPph-0004re-PK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEPpf-0008L6-EV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717490870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iYMov8+MVZFvylV1Ui1pFu3uDiFuy66PwQ1u7k9mBPQ=;
 b=AuC9Boa8H3/YQsd/JjWWGDew8rnLofQWEm0CBOPO0NkkSfjkQCBvrvx5ZgtsFO2U8Cm50+
 9smlkkJfgvExc7BnRPJAvEnjG+vdpU8aAZiUAJG6X2rzunkoePfxt6aJEQ31Ih/VdUx/Ry
 cK5OBMuLeNPNqD9EFv8Xv9dEeV+HgeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-GPX7FAV8NsCwEKc_CtdJIw-1; Tue, 04 Jun 2024 04:47:46 -0400
X-MC-Unique: GPX7FAV8NsCwEKc_CtdJIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A64D68007BA;
 Tue,  4 Jun 2024 08:47:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6228921982FF;
 Tue,  4 Jun 2024 08:47:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8729D21E6687; Tue,  4 Jun 2024 10:47:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo
 Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Sia Jee Heng
 <jeeheng.sia@starfivetech.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,  Dapeng Mi
 <dapeng1.mi@linux.intel.com>,  Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 1/7] hw/core: Make CPU topology enumeration arch-agnostic
In-Reply-To: <Zl7RbLrYUN0cg+t4@intel.com> (Zhao Liu's message of "Tue, 4 Jun
 2024 16:33:48 +0800")
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-2-zhao1.liu@intel.com>
 <87plsyfc1r.fsf@pond.sub.org> <Zl7RbLrYUN0cg+t4@intel.com>
Date: Tue, 04 Jun 2024 10:47:44 +0200
Message-ID: <87zfs19jrj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Markus,
>
> On Mon, Jun 03, 2024 at 02:25:36PM +0200, Markus Armbruster wrote:
>> Date: Mon, 03 Jun 2024 14:25:36 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [RFC v2 1/7] hw/core: Make CPU topology enumeration
>>  arch-agnostic
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Cache topology needs to be defined based on CPU topology levels. Thus,
>> > define CPU topology enumeration in qapi/machine.json to make it generic
>> > for all architectures.
>> >
>> > To match the general topology naming style, rename CPU_TOPO_LEVEL_SMT
>> > and CPU_TOPO_LEVEL_PACKAGE to CPU_TOPO_LEVEL_THREAD and
>> > CPU_TOPO_LEVEL_SOCKET.
>> >
>> > Also, enumerate additional topology levels for non-i386 arches, and add
>> > helpers for topology enumeration and string conversion.
>> >
>> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index bce6e1bbc412..7ac5a05bb9c9 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>> > @@ -1667,6 +1667,46 @@
>> >       '*reboot-timeout': 'int',
>> >       '*strict': 'bool' } }
>> >  
>> > +##
>> > +# @CPUTopoLevel:
>> 
>> I understand you're moving existing enum CPUTopoLevel into the QAPI
>> schema.  I think the idiomatic QAPI name would be CpuTopologyLevel.
>> Would you be willing to rename it, or would that be too much churn?
>
> Sure, I'll rename it as you suggested.
>
>> > +#
>> > +# An enumeration of CPU topology levels.
>> > +#
>> > +# @invalid: Invalid topology level, used as a placeholder.
>> > +#
>> > +# @thread: thread level, which would also be called SMT level or logical
>> > +#     processor level. The @threads option in -smp is used to configure
>> > +#     the topology of this level.
>> > +#
>> > +# @core: core level. The @cores option in -smp is used to configure the
>> > +#     topology of this level.
>> > +#
>> > +# @module: module level. The @modules option in -smp is used to
>> > +#     configure the topology of this level.
>> > +#
>> > +# @cluster: cluster level. The @clusters option in -smp is used to
>> > +#     configure the topology of this level.
>> > +#
>> > +# @die: die level. The @dies option in -smp is used to configure the
>> > +#     topology of this level.
>> > +#
>> > +# @socket: socket level, which would also be called package level. The
>> > +#     @sockets option in -smp is used to configure the topology of this
>> > +#     level.
>> > +#
>> > +# @book: book level. The @books option in -smp is used to configure the
>> > +#     topology of this level.
>> > +#
>> > +# @drawer: drawer level. The @drawers option in -smp is used to
>> > +#     configure the topology of this level.
>> 
>> docs/devel/qapi-code-gen.rst section Documentation markup:
>> 
>>     For legibility, wrap text paragraphs so every line is at most 70
>>     characters long.
>> 
>>     Separate sentences with two spaces.
>
> Thank you for pointing this.
>
> About separating sentences, is this what I should be doing?
>
> # @drawer: drawer level. The @drawers option in -smp is used to
> #  configure the topology of this level.

Like this:

##
# @CPUTopoLevel:
#
# An enumeration of CPU topology levels.
#
# @invalid: Invalid topology level.
#
# @thread: thread level, which would also be called SMT level or
#     logical processor level.  The @threads option in -smp is used to
#     configure the topology of this level.
#
# @core: core level.  The @cores option in -smp is used to configure
#     the topology of this level.
#
# @module: module level.  The @modules option in -smp is used to
#     configure the topology of this level.
#
# @cluster: cluster level.  The @clusters option in -smp is used to
#     configure the topology of this level.
#
# @die: die level.  The @dies option in -smp is used to configure the
#     topology of this level.
#
# @socket: socket level, which would also be called package level.
#     The @sockets option in -smp is used to configure the topology of
#     this level.
#
# @book: book level.  The @books option in -smp is used to configure
#     the topology of this level.
#
# @drawer: drawer level.  The @drawers option in -smp is used to
#     configure the topology of this level.
#
# Since: 9.1
##


