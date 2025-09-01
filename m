Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB647CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3O8-0001JT-M6; Mon, 01 Sep 2025 08:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Nx-0001G6-TR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Nl-00069F-Kx
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=8K/7PF8kTHUBRyM/nXizJi/NgukkGaFMN/Vz8TyXTU8=;
 b=O/JLe2wXqcfkx4WygQNBVzhzQxAcM0HrUcjRpaxYAwk+wbQvm5JQWEPCY9GsK8RVGEOtCc
 9vzIpd5UnVhlu1DL69exVNfI+8geMn2vSuGHDWeQUx8594YnpuuXXc7OHTLhTlFghrNa5f
 C6Itj0ePONYZeJqeZ7iO8EEQBKHatiY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-wknFZ8BRPYa2MCqV9pdBtA-1; Mon,
 01 Sep 2025 08:11:20 -0400
X-MC-Unique: wknFZ8BRPYa2MCqV9pdBtA-1
X-Mimecast-MFC-AGG-ID: wknFZ8BRPYa2MCqV9pdBtA_1756728680
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F62C19560B6; Mon,  1 Sep 2025 12:11:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D4C8180028F; Mon,  1 Sep 2025 12:11:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6628121E6A27; Mon, 01 Sep 2025 14:11:16 +0200 (CEST)
Resent-To: vsementsov@yandex-team.ru, devel@lists.libvirt.org,
 qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:11:16 +0200
Resent-Message-ID: <874itm4bkr.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  qemu-devel@nongnu.org,  eblake@redhat.com,
 devel@lists.libvirt.org
Subject: Re: [PATCH] qapi: net/tap: deprecate vhostforce option
In-Reply-To: <66837e31-6751-48bb-b2b0-827dfdec527c@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 1 Sep 2025 12:58:11 +0300")
References: <20250829125429.795595-1-vsementsov@yandex-team.ru>
 <87wm6lcjfx.fsf@pond.sub.org>
 <66837e31-6751-48bb-b2b0-827dfdec527c@yandex-team.ru>
Date: Mon, 01 Sep 2025 13:50:56 +0200
Message-ID: <87v7m25r33.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 30.08.25 11:17, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> This option simply duplicates the @vhost option since long ago
>>> (10 years!)
>>> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
>>
>> This isn't obvious to me.
>>
>> As far as I can see, their only use is in net_init_tap_one():
>>
>>      if (tap->has_vhost ? tap->vhost :
>>          vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
>>
>> Can you take this apart for me?
>
> Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
> (that don't have MSI-X support), you should hav set vhostforce=on
> (with vhost=on or unset).
>
> Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
> for vhost-enabling options logic.
>
> So we simply have redundant options:
>
> vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>
> vhost unset : vhostforce counts, enabling vhost
>
> So you may enable vhost several ways:
> - vhost=on
> - vhostforce=on
> - vhost=on + vhostforce=on
> - and even vhost=on + vhostforce=off
>
> - they are all equal.

So @vhostforce doesn't quite duplicate @vhost: if they conflict, @vhost
silently takes precedence.

>>> Let's finally deprecate it.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   docs/about/deprecated.rst | 7 +++++++
>>>   qapi/net.json             | 6 +++++-
>>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>> index d50645a071..d14cb37480 100644
>>> --- a/docs/about/deprecated.rst
>>> +++ b/docs/about/deprecated.rst
>>> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>>>   The ``reconnect`` option only allows specifying second granularity timeouts,
>>>   which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>>>   +TAP ``vhostforce`` (since 10.2)
>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +The ``vhostforce`` option just duplicates the main ``vhost`` option.
>>> +Use ``vhost`` alone.
>>
>> Would "Use instead ``vhost`` instead" be clearer?
>
> I meant, that user should not use vhost=on + vhostforce=on anymore.
>
> My be just "Use ``vhost``", without "alone"/"instead"?

Suggest

     The ``vhostforce`` option is redundant with the ``vhost`` option.
     If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.

Thanks!

[...]


