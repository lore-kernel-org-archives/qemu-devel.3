Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95615CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 13:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKzl0-0004Gu-3e; Mon, 17 Nov 2025 08:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKzkq-0004G6-26
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 08:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKzkn-0007km-FO
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 08:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763387926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY6EyeHC6xxWSjZ/+6wsu6VjEqvl4sOXMw9JWwZUy2w=;
 b=HM6p767ifbXe0K+0aIyJtCNg7IX7m0DUGKP2tnCu5GZXRLO33Qv6Ps1kkGAJwsYCd27B1y
 1mTneewEfBdcNQDlfN7+Ykio55V5kOkuad0PiOcDWmGManw8Fl2i9uGMQt2eLsyWxWitNt
 idlKhvwdzulV2E0rjA5Gdu8+KfpYMtc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411--FICa-b5N-eHUi5_ZnI5Pg-1; Mon,
 17 Nov 2025 08:58:43 -0500
X-MC-Unique: -FICa-b5N-eHUi5_ZnI5Pg-1
X-Mimecast-MFC-AGG-ID: -FICa-b5N-eHUi5_ZnI5Pg_1763387921
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4549618AB419; Mon, 17 Nov 2025 13:58:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD33F19560A7; Mon, 17 Nov 2025 13:58:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03A3B21E6A27; Mon, 17 Nov 2025 14:58:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Andrew
 Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>
Subject: Re: ebpf functions can fail without setting an error
In-Reply-To: <87sehfsife.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 25 Aug 2025 14:19:01 +0200")
References: <87ectns27j.fsf@pond.sub.org> <aKRWZwvbWzA0QbA_@redhat.com>
 <87sehfsife.fsf@pond.sub.org>
Date: Mon, 17 Nov 2025 14:58:37 +0100
Message-ID: <871plwpxpu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Thu, Aug 07, 2025 at 03:14:56PM +0200, Markus Armbruster wrote:
>>> Three functions in ebpf_rss.h take an Error ** argument and return bool.
>>> Good.
>>>=20
>>> They can all fail without setting an error.  Not good.
>>>=20
>>> The failures without error are:
>>>=20
>>> * All three stubs in ebpf_rss-stub.c always.  Oversight?
>>
>> Opps, yes, we really should have added error_setg() calls for diagnosis
>> if someone tries to use eBPF when QEMU build has it disabled.

Easy enough, but...

> Some stubs exist only to mollify the linker.  They are not meant to be
> called.  They should abort(), optionally with lipstick.
>
> Other stubs are called and should fail nicely.
>
> Can you tell me offhand which kind these are?

If calling these stubs is possible, I'd like to know how I can get them
called, so I can test the errors I add.

If calling is not possible, I'd rather add abort()s.

I tried to figure out whether calling is possible, but it ended in
confusion.  Can you help?

>>> * Non-stub ebpf_rss_load() when ebpf_rss_is_loaded().  Are these
>>>   reachable?
>>
>> This scenario should never happen, and we should add a call like
>>
>>   error_setg(errp, "eBPF program is already loaded");
>>
>> to report it correctly.
>
> Is it a programming error when it happens?

This question is still open as well.


