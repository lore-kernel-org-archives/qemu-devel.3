Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41445E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIri-00075v-Vq; Wed, 11 Dec 2024 04:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tLIre-00075f-Ll
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tLIrc-0001IE-UR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733908715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QAuy5dDtrjwKmaFCDXGaKLpEZ8HoELGNKGirY9U1cfM=;
 b=IZfcceOcJhHzyATIZH56cmHjfxIMz9Gnn+qsXKawyIF4kfloO5IcrfmTwlSoMYV5noKSPq
 69zq5YmKTjy6f32cVM4yMPzpgHRa+Vfq5S5izVp+cxZTlL9x/Frbp7u85QNLDEzLk8eueM
 TkloV2x8NQdKNSCOJF1sVyezUfir/MQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-51Udz7-bNCW0MPiVnUFvcQ-1; Wed,
 11 Dec 2024 04:18:32 -0500
X-MC-Unique: 51Udz7-bNCW0MPiVnUFvcQ-1
X-Mimecast-MFC-AGG-ID: 51Udz7-bNCW0MPiVnUFvcQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11002195FCF7; Wed, 11 Dec 2024 09:18:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E598300018D; Wed, 11 Dec 2024 09:18:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B1B121E66E8; Wed, 11 Dec 2024 10:18:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 09/19] migration: incoming channel
In-Reply-To: <87seqxf42e.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 09 Dec 2024 13:12:25 +0100")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
 <87ser2cfw6.fsf@pond.sub.org>
 <a7eaff5d-0030-445c-a31c-ce645666ecf3@oracle.com>
 <87seqxf42e.fsf@pond.sub.org>
Date: Wed, 11 Dec 2024 10:18:28 +0100
Message-ID: <87o71iwpaz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Steven Sistare <steven.sistare@oracle.com> writes:
>
>> On 12/5/2024 10:23 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>> 
>>>> Extend the -incoming option to allow an @MigrationChannel to be specified.
>>>> This allows channels other than 'main' to be described on the command
>>>> line, which will be needed for CPR.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

>>> Option -incoming resembles QMP command migrate-incoming.  Differences:
>>>
>>> * migrate-incoming keeps legacy URI and modern argument separate: there
>>>   are two named arguments, and exactly one of them must be passed.
>>>   -incoming overloads them: if @optarg starts with '{', it's modern,
>>>   else legacy URI.
>>>
>>>   Because of that, -incoming *only* supports JSON syntax for modern, not
>>>   dotted keys.  Other JSON-capable arguments support both.
>>
>> Not sure I follow.
>> Could you give me a dotted key example for a JSON-capable argument?
>> Do we care about dotted key for incoming, given the user can specify
>> a simple legacy URI?
>
> A quick grep for the usual parser qobject_input_visitor_new() finds

Correction: qobject_input_visitor_new_str().

> -audiodev, -blockdev, -compat, -display, and -netdev.  Beware, the
> latter two come with backward compatibility gunk.  There's also -device
> and -object, also with backward compatibility gunk.

[...]


