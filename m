Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED89C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 07:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjkQ-0003Dn-MA; Tue, 13 May 2025 03:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEjkN-0003Ct-Cm
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEjkK-0005qZ-3t
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747120089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iw5z9Rznei1fH4XcL4DBoBaD4UqM7WmuhuZMJRlWDs0=;
 b=i0a0lrCuVIqVRoZAsggAwK9SdlGeSUpsXK276X9HOswlg7xa46F9ZyDQDZNeMBE/UPUign
 YU1TdzhYhh+L7U+XUPyzC79760WzGa5rQg/+hx0tqoWmSpjqzj4w7Ky+qhrDuf6TN8Jn9l
 DSVcK2mysR/DwdHLG2EvJ7GGGLLR73Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-1gwwMHe2Pyix-Iq5CCiuYA-1; Tue,
 13 May 2025 03:08:05 -0400
X-MC-Unique: 1gwwMHe2Pyix-Iq5CCiuYA-1
X-Mimecast-MFC-AGG-ID: 1gwwMHe2Pyix-Iq5CCiuYA_1747120084
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CB33180087B; Tue, 13 May 2025 07:08:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7210319560A3; Tue, 13 May 2025 07:08:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D23B921E66C3; Tue, 13 May 2025 09:08:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 alex.bennee@linaro.org,  stefanha@redhat.com,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  pbonzini@redhat.com,  jsnow@redhat.com,
 philmd@linaro.org,  thuth@redhat.com,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
In-Reply-To: <cb2adbec-d098-4211-8781-c3027de59e69@linaro.org> (Pierrick
 Bouvier's message of "Mon, 12 May 2025 17:36:49 -0700")
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <aBzCXNTebh8B5sQ_@redhat.com> <87msbl0x7f.fsf@pond.sub.org>
 <cb2adbec-d098-4211-8781-c3027de59e69@linaro.org>
Date: Tue, 13 May 2025 09:08:00 +0200
Message-ID: <87h61phttb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

> On 5/9/25 11:57 PM, Markus Armbruster wrote:
>>> The build system would need generate an input document for the
>>> QAPI visitor that defines whether each constant is set to true
>>> or false, based on suitable CONFIG/TARGET conditions from meson.
>> 
>> I think the conditions that are evaluated at build time in handwritten C
>> code (with #if) should also be evaluated at build time in generated C
>> code.
>> 
>> Certain conditions are evaluated at build time in target-specific code,
>> and at runtime in target-independent code.  Again, I think handwritten
>> and generated code should work the same way.
>> 
>> Thus, to eliminate target-specific QAPI-generated code, we either
>> evaluate them at runtime, or simply eliminate them.  Elsewhere, we've
>> come to the conclusion (I think) that the latter should do at least for
>> now, likely forever, so we should try that first.
>>
>
> I'm not sure if you mean you'd prefer to eradicate #if completely.

I do not!

> We have to keep in mind that some config host #if have to stay there, or 
> they expose things that the rest of QEMU code is not supposed to see 
> (hidden under those same CONFIG_ ifdef also).

Letting people configure their QEMU build is useful and must stay.

We provide this via conditional compilation, of complete source files
(done in meson), as well as within source files (#if in C and 'if' in
QAPI).

> So we would need both if and runtime_if.

I don't understand the need for runtime_if.  Can you give an example?

[...]


