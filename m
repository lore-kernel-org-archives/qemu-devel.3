Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FD4C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VaL-00012F-3q; Wed, 09 Apr 2025 09:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Va8-0000zi-7U
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2Va4-0003ar-No
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744205701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbuGGWMLOlOVvAsuaE+OglBNpJSXgLU8wnEqaqbkVGw=;
 b=LWWPPMnAZpO3Ym3qGPUc1Wc8y73dKR7Zf1Rv8pMVqNWn01VURG+BcsHa1kJpsks/z4bTJI
 n/Yv/4yxiwNA/Krx6m8Xp/3XIMMCZlTXpaHPUc8FWlranY5BwjFdUtqpzyx30ma6GSdin5
 F38pN+BW1CbnN1UZLOSYJgfMAoII1/U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-y0cZlRNBNTGJQLxarQImTw-1; Wed,
 09 Apr 2025 09:34:57 -0400
X-MC-Unique: y0cZlRNBNTGJQLxarQImTw-1
X-Mimecast-MFC-AGG-ID: y0cZlRNBNTGJQLxarQImTw_1744205696
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51A0A195608B; Wed,  9 Apr 2025 13:34:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4EA619560AD; Wed,  9 Apr 2025 13:34:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5449721E675E; Wed, 09 Apr 2025 15:34:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  devel@lists.libvirt.org
Subject: Re: [PATCH V1 0/6] fast qom tree get
In-Reply-To: <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com> (Steven
 Sistare's message of "Wed, 9 Apr 2025 08:42:11 -0400")
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
Date: Wed, 09 Apr 2025 15:34:53 +0200
Message-ID: <87mscp8nlu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 4/9/2025 3:39 AM, Markus Armbruster wrote:
>> Hi Steve, I apologize for the slow response.
>> 
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Using qom-list and qom-get to get all the nodes and property values in a
>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>> of it when starting a new VM, and this cost is a substantial fraction of
>>> start up time.
>> 
>> "Some managers"... could you name one?
>
> My personal experience is with Oracle's OCI, but likely others could benefit.

Peter Krempa tells us libvirt would benefit.

>>> To reduce this cost, consider QAPI calls that fetch more information in
>>> each call:
>>>    * qom-list-get: given a path, return a list of properties and values.
>>>    * qom-list-getv: given a list of paths, return a list of properties and
>>>      values for each path.
>>>    * qom-tree-get: given a path, return all descendant nodes rooted at that
>>>      path, with properties and values for each.
>> 
>> Libvirt developers, would you be interested in any of these?
>> 
>>> In all cases, a returned property is represented by ObjectPropertyValue,
>>> with fields name, type, value, and error.  If an error occurs when reading
>>> a value, the value field is omitted, and the error message is returned in the
>>> the error field.  Thus an error for one property will not cause a bulk fetch
>>> operation to fail.
>> 
>> Returning errors this way is highly unusual.  Observation; I'm not
>> rejecting this out of hand.  Can you elaborate a bit on why it's useful?
>
> It is considered an error to read some properties if they are not valid for
> the configuration.  And some properties are write-only and return an error
> if they are read.  Examples:
>
>    legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not readable> (str)
>    legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory' is not readable> (str)
>    crash-information: <EXCEPTION: No crash occurred> (GuestPanicInformation)
>
> With conventional error handling, if any of these poison pills falls in the
> scope of a bulk get operation, the entire operation fails.

I suspect many of these poison pills are design mistakes.

If a property is not valid for the configuration, why does it exist?
QOM is by design dynamic.  I wish it wasn't, but as long as it is
dynamic, I can't see why we should create properties we know to be
unusable.

Why is reading crash-information an error when no crash occured?  This
is the *normal* case.  Errors are for the abnormal.

Anyway, asking you to fix design mistakes all over the place wouldn't be
fair.  So I'm asking you something else instead: do you actually need
the error information?

[...]


