Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68527D4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgf3s-0006D2-1P; Fri, 16 Jan 2026 03:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgf3q-0006Cc-IP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgf3o-0000jd-SU
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768551600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4y58swJ8SEaUb3Okk1L6cXS1m2gBdcM5UQ6hxS9jcig=;
 b=au9cXuR9RcDj/oVfTzY42Fs8UEO3fe2jClTpvhG8XS6RR3aA3Y8LxmM/bQpkjHaqIAU8kT
 5JsmDAR+5NLMYVdaGE1UlhdlK3gx867vkMmRKBemvGeMqOVN6G0wiCl8xLpMv5iyZ/qxR5
 +/IgXtePrYIa7P1cD4tUVWZQGLbQI/s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-VLaqVavPMjyoUHEpVurMIQ-1; Fri,
 16 Jan 2026 03:19:57 -0500
X-MC-Unique: VLaqVavPMjyoUHEpVurMIQ-1
X-Mimecast-MFC-AGG-ID: VLaqVavPMjyoUHEpVurMIQ_1768551596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE9A019560B3; Fri, 16 Jan 2026 08:19:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142201955F67; Fri, 16 Jan 2026 08:19:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79B1621E692D; Fri, 16 Jan 2026 09:19:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: JAEHOON KIM <jhkim@linux.ibm.com>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  pbonzini@redhat.com,  stefanha@redhat.com,
 fam@euphon.net,  eblake@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  dave@treblig.org,  sw@weilnetz.de,
 devel@lists.libvirt.org
Subject: Re: [PATCH RFC v1 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
In-Reply-To: <20260115110532.27cb1516.pasic@linux.ibm.com> (Halil Pasic's
 message of "Thu, 15 Jan 2026 11:05:32 +0100")
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-4-jhkim@linux.ibm.com>
 <87qzrs4oud.fsf@pond.sub.org>
 <eb891295-5ffd-4613-bc37-56d8a07d1fff@linux.ibm.com>
 <87ikd3xrkc.fsf@pond.sub.org>
 <20260115110532.27cb1516.pasic@linux.ibm.com>
Date: Fri, 16 Jan 2026 09:19:52 +0100
Message-ID: <87sec6rmtz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Halil Pasic <pasic@linux.ibm.com> writes:

> On Thu, 15 Jan 2026 08:28:51 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I understand that you're mirroring how @poll-grow and @poll-shrink work,
>> but let's ignore that for a minute.
>> 
>> Compare four possible interfaces:
>> 
>> 1. Optional @poll-weight defaults to 2.  Values <= 0 are rejected.
>> 
>> 2. Optional @poll-weight defaults to 2.  Value 0 is replaced by the
>>    default value 2.  Values < 0 are rejected.
>> 
>> 3. Optional @poll-weight defaults to 0.  Values < 0 are rejected.  Value
>>    0 makes the system pick a value, namely 2.
>> 
>> 4. Optional @poll-weight defaults to 0.  Values < 0 are rejected.  Value
>>    0 makes the system pick a value.  It currently picks 2.
>> 
>> The difference between 3. and 4. is that 3. makes "system picks 2" part
>> of the contract, while 4. doesn't.
>> 
>> 1. is the simplest.  Is 2.'s additional complexity worthwhile?  3.'s?
>> 4.'s?
>
> Isn't there more options? Like

Yes :)

> 5. Optional @poll-weight defaults to system-default.  Value 0 is replaced
> by the system pick the system default value. Currently the system default
> value is 2. Values < 0 are rejected.
>
> That would mean:
> * current value inspectable
> * system default not part of the interface contract
> * interface offers a "please go back to value not user specified:
>   operation
>
> BTW I like your approach with explicitly listing and evaluating the
> options a lot!

Thanks!


