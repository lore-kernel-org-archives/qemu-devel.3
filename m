Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B99CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxJRg-0001nT-RS; Fri, 21 Aug 2026 03:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wxJRe-0001nC-Ls
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 03:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wxJRd-0004J9-3f
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 03:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787296419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TlNImEAuP/FvsnNpRpn7Hfz1OYtZHrawb345cljoCKc=;
 b=T5gBRd4PopT2j4FjTA2BpNzPqCOMRM1kRfmp0KWKJRLgpwpsYgO+giLsFqQXt9WnP0eRrK
 6lx0mtJfwQmt5zcrRVVXMjcmhvoiFfQYY0GgFc0ZO6CnYDvVq+gDiSL+iDTv9cEJ79OpD+
 MwF3Q6QN5y4oMYW5CBTPqecKTUOO/mg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-za5Epj2NNZ66CinmjZhlKQ-1; Fri,
 21 Aug 2026 03:13:36 -0400
X-MC-Unique: za5Epj2NNZ66CinmjZhlKQ-1
X-Mimecast-MFC-AGG-ID: za5Epj2NNZ66CinmjZhlKQ_1787296414
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 502DF1956096; Fri, 21 Aug 2026 07:13:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 640BA1800348; Fri, 21 Aug 2026 07:13:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9BC521E6920; Fri, 21 Aug 2026 09:13:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 maciej.szmigiero@oracle.com,  mark.kanda@oracle.com,  bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com,  joe.jin@oracle.com
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
In-Reply-To: <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com> (Dongli Zhang's
 message of "Thu, 20 Aug 2026 10:46:45 -0700")
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
Date: Fri, 21 Aug 2026 09:13:30 +0200
Message-ID: <87a4qg0wv9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>> 
>>> Add a memfd migration transport to the MigrationAddress QAPI schema. The
>>> new transport has no user-supplied arguments because QEMU creates and
>>> passes the backing memfd internally.
>>>
>>> The initial user is cpr-exec, where the main VM/device migration stream can
>>> be stored in an inherited memfd instead of an external file.
>>>
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> ---
>>>  qapi/migration.json | 32 +++++++++++++++++++++++++++-----
>>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index b1eaf7b054..1505c201ca 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -702,9 +702,11 @@
>>>  # @cpr-exec: The migrate command stops the VM, saves state to the
>>>  #     migration channel, directly exec's a new version of QEMU on the
>>>  #     same host, replacing the original process while retaining its
>>> -#     PID, and loads state from the channel.  Guest RAM is preserved
>>> -#     in place.  Devices and their pinned pages are also preserved for
>>> -#     VFIO and IOMMUFD.
>>> +#     PID, and loads state from the channel.  With the @memfd
>>> +#     migration transport, QEMU saves VM/device state to an internal
>>> +#     memfd instead of an external main migration channel.  Guest RAM
>>> +#     is preserved in place.  Devices and their pinned pages are also
>>> +#     preserved for VFIO and IOMMUFD.
>>>  #
>>>  #     Old QEMU starts new QEMU by exec'ing the command specified by
>>>  #     the @cpr-exec-command parameter.  The command may be a direct
>>> @@ -716,6 +718,13 @@
>>>  #     as a file, that accepts all data before old QEMU exits.
>>>  #     Otherwise, old QEMU may quietly block writing to the channel.
>>>  #
>>> +#     Alternatively, use the @memfd migration transport to save
>>> +#     VM/device state to an internal memfd inherited by new QEMU.
>>> +#
>> 
>> Any guidance on when to use @memfd?
>
> My objective is to avoid using disks, or running QEMU with writable storage.
>
> Both guest I/O and networking can go through VFIO, and everything remains in memory.
>
> When I was testing these CPR features, my favorite was cpr-exec because it does
> not require creating an additional QEMU instance.
>
> Based on my understanding, the best approach to live update a running binary is
> to replace only the code section while keeping everything else in memory, i.e.
> guest memory, device fds, and device state.
>
> Unfortunately, device state cannot simply remain in memory across exec(), so we
> need to migrate it from the old instance to the new instance. I was thinking:
> why not use memory instead of storage?
>
> Initially, I added the change only for cpr-exec. Later, I reworked the change to
> make memfd a new migration transport. As a side benefit for me, I also practiced
> how to add a new transport to the QEMU migration code :)

This is why you wrote the feature.  Please work it into the commit
message.

We should also help users decide whether to use the feature.  I gather
it's useful with migration mode cpr-exec.  Any other use cases?  Does it
even work with other migration modes?  If yes, which ones, and what
happens when you try with another one?

>>> +#     With @memfd, the new QEMU command may include '-incoming memfd:'
>>> +#     to load the migration stream automatically, or '-incoming defer'
>>> +#     to load it later with `migrate-incoming`.
>>> +#
>> 
>> Isn't that the same for any transport?  I.e. old and new QEMU must use a
>> common transport, and you configure it for the new one with -incoming
>> right away, or later with migrate-incoming.
>
> Yes, it is the same for all transports. I added the explanation only because the
> memfd transport does not need additional data or a filename, for example, the
> URI is just "memfd:".
>
> Will remove it.
>
>> 
>>>  #     Memory-backend objects must have the share=on attribute, but
>>>  #     memory-backend-epc is not supported.  The VM must be started
>>>  #     with the '-machine aux-ram-share=on' option.

[...]


