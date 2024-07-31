Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E64C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 04:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ1Kv-0005nE-BF; Wed, 31 Jul 2024 00:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ1Kr-0005mi-MP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ1Kp-0006UR-B9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722401589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ui/MNWi8J4o7ekGUkjOHHJHLx0ACcNZD+s1bu7HhSDw=;
 b=gcQtDJT/qupH3C3KDubhjmJsKpyZqcBu+rZk7rRQ9QOv6WT/8ANoNhNU59JEyUCmkxFbUQ
 cfpU7n8zS/+xku12V87oLCrOE2kN1DkVpyKZuWG2ADhu6jQb0PIiTM0pcG9kVVd0vCILUu
 J4L3zJabLIB2ot1fFKzyamU4FD5+yXc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-ENBBsr4iO3yMD1ZAWUJiKQ-1; Wed,
 31 Jul 2024 00:53:05 -0400
X-MC-Unique: ENBBsr4iO3yMD1ZAWUJiKQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EFDE1955D58; Wed, 31 Jul 2024 04:53:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 491013000198; Wed, 31 Jul 2024 04:53:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECE6A21E668B; Wed, 31 Jul 2024 06:52:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: junon@oro.sh
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,  qemu-devel@nongnu.org,
 "Richard Henderson" <richard.henderson@linaro.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Eric Blake" <eblake@redhat.com>,  "Eduardo
 Habkost" <eduardo@habkost.net>,  "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  "Yanan Wang" <wangyanan55@huawei.com>,  "Zhao Liu"
 <zhao1.liu@intel.com>,  "Peter Xu" <peterx@redhat.com>,  "David
 Hildenbrand" <david@redhat.com>,  "Thomas Huth" <thuth@redhat.com>,
 "Laurent Vivier" <lvivier@redhat.com>
Subject: Re: [PATCH] qmp: Add 'memtranslate' QMP command
In-Reply-To: <a2842ec779c036b09dc429f883e28ccc073d0c22@oro.sh> (junon@oro.sh's
 message of "Wed, 31 Jul 2024 00:43:43 +0000")
References: <20240730213432.18074-1-junon@oro.sh> <ZqmBXTVV52qkk9Ed@gallifrey>
 <a2842ec779c036b09dc429f883e28ccc073d0c22@oro.sh>
Date: Wed, 31 Jul 2024 06:52:59 +0200
Message-ID: <87ttg6kvro.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

junon@oro.sh writes:

> 31 July 2024 at 02:12, "Dr. David Alan Gilbert" <dave@treblig.org> wrote:
>
> Hello Dr. Gilbert,
>
>> 
>> * Josh Junon (junon@oro.sh) wrote:
>> 
>> Hi Josh,
>> 
>> > 
>> > This commit adds a new QMP/HMP command `memtranslate`,
>> > which translates a virtual address to a physical address
>> > using the guest's MMU.
>> >
>> > This uses the same mechanism that `[p]memsave` does to
>> > perform the translation.
>> >
>> > This commit also fixes a long standing issue of `[p]memsave`
>> > not properly handling higher-half virtual addresses correctly,
>> > namely when used over QMP/the monitor. The use and assumption of
>> > signed integers caused issues when parsing otherwise valid
>> > virtual addresses that instead caused signed integer overflow
>> > or ERANGE errors.
>> >
>> > Signed-off-by: Josh Junon <junon@oro.sh>
>> 
>> There's a few different changes in this one patch; so the first
>> thing is it needs splitting up; I suggest at least:
>> 
>>  a) Fixing the signedness problems
>> 
>>  b) The QMP implementation of the new command
>> 
>>  c) The HMP implementation of the new command
>> 
>> That would make it a lot easier to review - also, it's good
>> to get fixes in first!
>> Now, going back a step; how does this compare to the existing
>> 'gva2gpa' command which HMP has?
>> 
>
> Good catch, they're definitely the same. I didn't see that was there before, perhaps because of the name. I've been looking for this exact command for a while now, so it surprises me that I missed it!
>
> Since that's an HMP-only command, would it be okay if simply redirected its definition to a new qmp_gva2gpa command so the implementation is all in one spot?

If you have a use case for a QMP version, go right ahead.

> If that's amenable, I can patch in the signedness fixes, then submit qmp_gva2gpa, then changing hmp_gva2gpa to use the qmp_gva2gpa similar to how other HMP commands with QMP analogs are implemented. Just let me know if that works and I'll get on it.

Sounds like a plan to me.

> I appreciate the response!
>
>
> Josh


