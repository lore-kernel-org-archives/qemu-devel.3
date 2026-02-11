Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BEEEB596D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4QK-000090-F9; Wed, 11 Feb 2026 02:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vq4QJ-00008L-5d
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vq4QH-00032A-7T
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770794043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTmShxaKcn6HSnmjswXLWft6V1eHfAX6ouHC2YAXc7I=;
 b=IIZgW0dFSdq0/AInAmsAvuxuNOe+eAEroRaYd+3X9FxhLWjGqhoO05I0I8lt16D2EHZWYM
 UcKGx0uVxYDPirb+AD1XNoKHAXfPthO4XgTg15MyhFnw61ZV9R02aoqQ4VnDhzc+Ll46o+
 PM7w+E71QK+DBK6j/UQuNFCRQf4kEVY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-gac2Ly_ZOLy1k11Zcn-EAg-1; Wed,
 11 Feb 2026 02:14:02 -0500
X-MC-Unique: gac2Ly_ZOLy1k11Zcn-EAg-1
X-Mimecast-MFC-AGG-ID: gac2Ly_ZOLy1k11Zcn-EAg_1770794041
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 473BA1955F12
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:14:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05E7319560B0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:14:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F7DA21E692D; Wed, 11 Feb 2026 08:13:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] json-streamer: remove token queue
In-Reply-To: <f7e66270-9d0e-46fb-b465-0b4887287a7f@redhat.com> (Paolo
 Bonzini's message of "Tue, 10 Feb 2026 09:22:28 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-4-pbonzini@redhat.com>
 <87v7g581xh.fsf@pond.sub.org>
 <f7e66270-9d0e-46fb-b465-0b4887287a7f@redhat.com>
Date: Wed, 11 Feb 2026 08:13:58 +0100
Message-ID: <87y0kz3g7d.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/10/26 08:58, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> Now fully exploit the push parser, feeding it one token at a time
>>> without having to wait until braces and brackets are balanced.
>>>
>>> While the nesting counts are retained for error recovery purposes,
>>> the system can now report the first parsing error without waiting
>>> for delimiters to be balanced.  This also means that JSON_ERROR
>>> can be handled in json-parser.c, not json-streamer.c.
>>>
>>> After reporting the error, json-streamer.c then enters an error recovery
>>> mode where subsequent errors are suppressed.  This mimics the previous
>>> error reporting behavior, but it provides prompt feedback on parsing
>>> errors.  As an example, here is an example interaction with qemu-ga.

[...]

>>> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
>>> index 6c93e6fd78d..a1210128ac1 100644
>>> --- a/qobject/json-streamer.c
>>> +++ b/qobject/json-streamer.c

[...]

>>> +        /*
>>> +         * Security consideration, we limit total memory allocated per object
>>> +         * and the maximum recursion depth that a message can force.
>>> +         */
>> 
>> This comment now needs rephrasing: there's no recursion anymore.  In the
>> previous commit if we're feeling persnickety.
>
> s/recursion/nesting/?

Yup.

[...]


