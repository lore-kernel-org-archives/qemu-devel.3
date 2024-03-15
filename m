Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0592FC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl72d-0004Ps-RD; Fri, 15 Mar 2024 08:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl72a-0004PA-9m
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl72X-0002qr-Uv
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710507119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JQ8IVbtmJMOlRPYlj0g3UGjs9m3m3Y3pH5nqI9jmyM=;
 b=eGcz08puBw1RumYG5rhKm4kduxb0ml/lcZEMe7k6uIzaXovL88By+dSndcp879uxnSichD
 DlGkxwWBYNWkIdcnu/i0f2kEt7BXXTnlY4igAqEl1zD9cfHSm0vts6qvgI/lc/nEVrkbWB
 z/ZXzy4JLozzPQ7Dp9gAe1/A335Ijwo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-KhKXZIjEPwieK1ZBf3NdSA-1; Fri,
 15 Mar 2024 08:51:55 -0400
X-MC-Unique: KhKXZIjEPwieK1ZBf3NdSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 075DB380671B;
 Fri, 15 Mar 2024 12:51:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 705B61C060A4;
 Fri, 15 Mar 2024 12:51:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E2F221E6A24; Fri, 15 Mar 2024 13:51:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 3/6] qdev-monitor: add option to report GenericError
 from find_device_state
In-Reply-To: <063ad24f-714d-48df-a092-75e9fc693082@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 7 Mar 2024 13:03:04 +0300")
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-4-vsementsov@yandex-team.ru>
 <87sf12cr1z.fsf@pond.sub.org>
 <063ad24f-714d-48df-a092-75e9fc693082@yandex-team.ru>
Date: Fri, 15 Mar 2024 13:51:53 +0100
Message-ID: <87jzm3fyja.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sorry for the late answer.

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 07.03.24 12:46, Markus Armbruster wrote:

[...]

>> I appreciate the attempt to curb the spread of DeviceNotFound errors.
>> Two issues:
>>
>> * Copy-pasting find_device_state() with a false argument is an easy
>>   error to make.
>>
>> * Most uses of find_device_state() are via blk_by_qdev_id() and
>>   qmp_get_blk().  Any new uses of qemu_get_blk() will still produce
>>   DeviceNotFound.
>>
>> Hmm.
>
> Hmm. Right. Wait a bit, I can make the change stricter.
>
> Could you still explain (or give a link), why and when we decided to use only GenericError? I think, having different "error-codes" is a good thing, why we are trying to get rid of it?

We actually got rid of most of them years ago :)

But you deserve a more complete answer.

QMP initially specified the following error response[1]:

    2.4.2 error
    -----------
    
    The error response is issued when the command execution could not be
    completed because of an error condition.
    
    The format is:
    
    { "error": { "class": json-string, "data": json-value }, "id": json-value }
    
     Where,
    
    - The "class" member contains the error class name (eg. "ServiceUnavailable")
    - The "data" member contains specific error data and is defined in a
      per-command basis, it will be an empty json-object if the error has no data
    - The "id" member contains the transaction identification associated with
      the command execution (if issued by the Client)

Note the structure of @data depends on @class.  We documented a
command's possible error classes (well, we tried), but never bothered to
document the @data it comes with.

Documentation deficits aside, this is looks quite expressive.  There are
issues, though:

1. Formatting errors in human-readable form is bothersome, and creates a
   tight coupling between QMP server and client.

   Consider:

    {"class": "DeviceNotFound", "data": {"device": "ide1-cd0"}}

   To format this in human-readable form, you need to know the error.

   The server does.  Fine print: it has a table mapping JSON templates
   to human-readable error message templates.

   The client needs to duplicate this somehow.  If it receives an error
   it doesn't know, all it can do is barf (possibly dressed up) JSON at
   the human.  To avoid that, clients need to track the server closely:
   tight coupling.

2. Errors have notational overhead, which leads to bad errors.

   To create a new error, you have to edit two source files (not
   counting clients).  Strong incentive to reuse existing errors.  Even
   when they don't quite fit.  When a name provided by the user couldn't
   be resolved, reusing DeviceNotFound is easier than creating a new
   error that is more precise.

3. The human-readable error message is hidden from the programmer's
   view, which leads to bad error messages.

   At the point in the source where the error is created, we see
   something like QERR_DEVICE_NOT_FOUND, name.  To see the
   human-readable message, we have to look up macro
   QERR_DEVICE_NOT_FOUND's error message template in the table, or
   actually test (*gasp*) the error.  People generally do neither, and
   bad error messages proliferate.

4. Too little gain for the pain

   Clients rarely want to handle different errors differently.  More
   often than not, all they do with @class and @data is log them.  Only
   occasionally do they switch on @class, and basically never on @data.

It me took a considerable fight to get the protocol amended to include a
human-readable message[2].  This addressed issue 1.

Over the next two years or so, issues 2. to 4. slowly sank in.  We
eventually tired of the complexity, ripped out @data, and dumbed down
all error classes to GenericError, except for the few clients actually
cared for[3].  We also mandated that new errors avoid the QERR_ macros.

Eliminating the existing QERR_ macros has been slow.  We're down to 13
in master, with patches deleting 7 on the list.

This has served us reasonably well.

Questions?


[1] Commit f544d174dfc
    QMP: Introduce specification
    Dec 2009

[2] Commit 77e595e7c61q
    QMP: add human-readable description to error response
    Dec 2009

[3] Commit de253f14912
    qmp: switch to the new error format on the wire
    Aug 2012


