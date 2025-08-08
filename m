Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2FC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJTA-0006EJ-D5; Fri, 08 Aug 2025 05:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukJT5-0006Cg-Sk
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukJT4-0001OO-7D
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754645573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gyt+ZWuMTsSb0qeZGeE2m1DrFuVgcd14q5v9AIOOkP0=;
 b=LLsNK9+yDY/HtlxANvza5hpi5NhSd1sq3VSnyKwHDfKxEhtccruZVgaTNdkXXZiEv+Nftx
 yIl7KwsBxUvSuHF5D35tMpABXhXH89kQ3JOYjthS+ZcAeTywyfRdzAH4EApq4nmx3dc3Uw
 GgmLWgiKjvqUu/Afd37Zx4LSFs/0JPs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-WZOIOCQgNRGbXkxogAaepQ-1; Fri,
 08 Aug 2025 05:32:49 -0400
X-MC-Unique: WZOIOCQgNRGbXkxogAaepQ-1
X-Mimecast-MFC-AGG-ID: WZOIOCQgNRGbXkxogAaepQ_1754645568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5060B19560A5; Fri,  8 Aug 2025 09:32:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64A5E1800958; Fri,  8 Aug 2025 09:32:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E69A21E6A27; Fri, 08 Aug 2025 11:32:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 08/12] util/oslib-win32: Revert warning on
 WSAEventSelect() failure
In-Reply-To: <CAMxuvaxjMbvGtwpai6M75zRZMQPVZAusmSX7hs=OeDDThc7-Lw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 8 Aug 2025
 12:22:03 +0400")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-9-armbru@redhat.com>
 <CAMxuvaxjMbvGtwpai6M75zRZMQPVZAusmSX7hs=OeDDThc7-Lw@mail.gmail.com>
Date: Fri, 08 Aug 2025 11:32:44 +0200
Message-ID: <877bzejgzn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
>> NULL @errp as &error_warn.  This is wildly inappropriate.  A caller
>> passing NULL specifies that errors are to be ignored.  If warnings are
>> wanted, the caller must pass &error_warn.
>>
>> I'm not familiar with the calling code, so I can't say whether it will
>> work after WSAEventSelect() failure.  If it doesn't, then this should
>> be an error.  If it does, then why bother the user with a warning that
>> isn't actionable, and likely confusing?
>>
>> The warning goes back to commit f5fd677ae7cf (win32/socket: introduce
>> qemu_socket_select() helper).  Before that commit, the error was
>> ignored, as indicated by passing a null @errp.  Revert to that
>> behavior.
>>
>
> Yes, the potential errors before introducing the wrapper were simply
> ignored. I think we should fix the users or maybe just report the warning
> and drop errp from the wrapper function. wdyt?

Phil's "[RFC PATCH 0/2] system/win32: Remove unused Error argument in
qemu_socket_[un]select()" does the latter.

I doubt warnings are the right tool here.  I just posted

    Subject: Abuse of warnings for unhandled errors and programming errors
    Message-ID: <87h5yijh3b.fsf@pond.sub.org>

[...]


