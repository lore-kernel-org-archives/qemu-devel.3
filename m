Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D148C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 15:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukOeQ-0003EA-Rp; Fri, 08 Aug 2025 11:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukOeP-00034x-03
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukOeI-0001ZI-A0
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754665487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gjOmnp7eiB9Ai3VQj9rnj4WA5/tZZnddH75KQaZsFI=;
 b=djSMI19K8tCyrKwT1SJad1qns7sXXnzZMaO7nvNy9DkYVGrW5uQdv1wcdI4/1lr2wcLiu2
 KMB/Lg3udKVMLckK7OFm7y7Wq1qGxlRn5xSvEPkuYZmHozMcK3Ril0Blxw0KT5Qtnumi+V
 wRR24S15+UNtxf0lwrkIShSwToogd38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-FMHvCo4JMbeDJcn5gL3d-A-1; Fri,
 08 Aug 2025 11:04:44 -0400
X-MC-Unique: FMHvCo4JMbeDJcn5gL3d-A-1
X-Mimecast-MFC-AGG-ID: FMHvCo4JMbeDJcn5gL3d-A_1754665482
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1EB719560B4; Fri,  8 Aug 2025 15:04:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B1AA19560B0; Fri,  8 Aug 2025 15:04:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91BBE21E6A27; Fri, 08 Aug 2025 17:04:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp,  marcandre.lureau@redhat.com
Subject: Re: [PATCH 04/12] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
In-Reply-To: <045c76ae-684e-4920-8d25-74cd3afd87e6@oracle.com> (Steven
 Sistare's message of "Fri, 8 Aug 2025 10:48:09 -0400")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-5-armbru@redhat.com>
 <6d876750-9d7b-4556-a1e5-06f7c7487eb0@linaro.org>
 <aee57c51-b7e5-4c11-b8bd-222251c4ce91@oracle.com>
 <87a549dgc6.fsf@pond.sub.org>
 <045c76ae-684e-4920-8d25-74cd3afd87e6@oracle.com>
Date: Fri, 08 Aug 2025 17:04:38 +0200
Message-ID: <87h5yhc0s9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 8/8/2025 10:43 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>>=20
>>> On 8/8/2025 9:55 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 8/8/25 10:08, Markus Armbruster wrote:
>>>>> qapi/error.h advises:
>>>>>
>>>>>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>>>>>   * exit(), because that's more obvious.
>>>>>
>>>>> Do that.
>>>>>
>>>>> The error message starts with "internal error: ", so maybe this should
>>>>> assert() instead.
>>>>>
>>>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

>>>> My 2 cents, I'm not sure this information is more helpful than a plain
>>>> assertion (at least for users). No objection for this change.
>>>
>>> The message gives more information.  It has helped me debug
>>> problems in the past, in concert with enabling cpr traces.
>>
>> Is it a programming error?
>
> Yes.
>
>> If no, then "internal error: " is wrong.
>>
>> If yes, then exit(1) is wrong.  I'd use assert() myself, but you're the
>> maintainer here, and if you want this message rather than the one
>> assert() gives you for free, we just replace exit(1) by abort() or
>> assert(0) or, if we're feeling particularly fancy
>> g_assert_not_reached().
>
> I would like the full message.
> I have no preference on how to exit.

Will adjust v2 accordingly.

Thanks!


