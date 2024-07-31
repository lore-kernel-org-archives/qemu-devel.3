Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9032AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ3gC-0003I3-7H; Wed, 31 Jul 2024 03:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ3g9-0003EU-5U
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ3g6-0005qi-LK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722410597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nug2VN2gGRBXd0B3UkSsblwDOysWdZxSO5FtNrujILk=;
 b=aE7ZTf6MHj0rEjlarUlk9N8gvXeOPeqUPs7FLruZvf2WicpP4/rYqTvX2bv1bcN966LFRd
 9C2I5CtPfvR+Pr5+uqvxMT06mGYik89l9ttrS32BQPzhl6TJORfFpo/rlUqL07NRbErQPB
 lNrQrLQypaOivZxB35gV+GHhCDpjEaI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-zhhrRXkFOp25zI8T3M6mSw-1; Wed,
 31 Jul 2024 03:23:13 -0400
X-MC-Unique: zhhrRXkFOp25zI8T3M6mSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42C671955BEF; Wed, 31 Jul 2024 07:23:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F1501955E80; Wed, 31 Jul 2024 07:23:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6366221E668B; Wed, 31 Jul 2024 09:23:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Dongjiu Geng <gengdongjiu1@gmail.com>,  Eric
 Blake <eblake@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>,  <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 6/6] acpi/ghes: Add a logic to inject ARM processor CPER
In-Reply-To: <20240730081610.6390c423@foz.lan> (Mauro Carvalho Chehab's
 message of "Tue, 30 Jul 2024 08:16:23 +0200")
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <7e0c1ae181e9792e876ec0e7d2a9e7f32d7b60ac.1722259246.git.mchehab+huawei@kernel.org>
 <20240729173109.00006911@Huawei.com> <20240730081610.6390c423@foz.lan>
Date: Wed, 31 Jul 2024 09:23:07 +0200
Message-ID: <87le1ija90.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Mon, 29 Jul 2024 17:31:09 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
>
>> On Mon, 29 Jul 2024 15:21:10 +0200
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
> ...
>
>> Markus suggested:
>> 
>> > A target-specific command like this one should be conditional.  Try
>> > this:
>> > 
>> >     { 'command': 'arm-inject-error',
>> >       'data': { 'errortypes': ['ArmProcessorErrorType'] },
>> >       'features': [ 'unstable' ],
>> >       'if': 'TARGET_ARM' }
>> >
>> > No need to provide a qmp_arm_inject_error() stub then.  
>> 
>> (I noticed because never knew you could do this.)
>> 
>> Probably crossed with your v4 posting.
>
> Tried it, but can't figure out how to properly set it up at meson.build,
> as it is basically producing build time errors during qapi file generation
> on non-ARM platforms. For instance:
>
> FAILED: libqemuutil.a.p/meson-generated_.._qapi_qapi-visit-arm-error-inject.c.o 

[...]

> In file included from qapi/qapi-visit-arm-error-inject.h:17,
>                  from qapi/qapi-visit-arm-error-inject.c:15:
> qapi/qapi-types-arm-error-inject.h:18:13: error: attempt to use poisoned "TARGET_ARM"
>    18 | #if defined(TARGET_ARM)
>       |             ^
> In file included from /new_devel/edac/qemu/include/exec/poison.h:7,
>                  from /new_devel/edac/qemu/include/qemu/osdep.h:38,
>                  from qapi/qapi-visit-arm-error-inject.c:13:
> ./config-poison.h:718:20: note: poisoned here
>
> Such error is created by two files generated from qapi, due
> to this change:
>
> 	diff --git a/qapi/meson.build b/qapi/meson.build
> 	index e7bc54e5d047..5927932c4be3 100644
> 	--- a/qapi/meson.build
> 	+++ b/qapi/meson.build
> 	@@ -24,2 +24,3 @@ endif
> 	 qapi_all_modules = [
> 	+  'arm-error-inject',
> 	   'authz',
>
> No idea how to fix it.

Uh, I neglected to point out an important detail.  Sorry about that!

The 'if' condition uses a symbol that is poisoned in target-independent
compiles.  Such conditions work only in target modules.  By convention,
these are named FOO-target.json.

So, you can either change new module's filename to end in -target.json,
or you stick the command into one of the two existing target modules,
machine-target.json and misc-target.json.

Speaking of modules: i'm not sure dedicating a module just to ARM error
injection is a good idea.  Perhaps we could have arm-target.json for
things that will only ever make sense on ARM.  Same for other targets.

But I recommend to first reach consensus on Igor's objection in review
of v3:

    Message-ID: <20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
    https://lore.kernel.org/qemu-devel/20240730131709.10e72c7d@imammedo.users.ipa.redhat.com/


