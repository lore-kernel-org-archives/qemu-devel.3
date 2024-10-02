Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472ECF6D36
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw148-0003bi-LD; Wed, 02 Oct 2024 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sw145-0003bL-Uz
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sw143-0004D5-Tk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727882094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1impwNwNKeqViPVK8iwq1dhvRluXddYw0svnf2iE6PU=;
 b=NZsBOIHj1uLm/VQXjDhtAVGGM8PCd1l6oWR3ZepZuF5uoGELtg3Y1XxjitlPPwojjn3Xc9
 qvOjRHBPOWOpYw9Mfzh8X0ALQHVfOdyycHJFH8HmaDDqcwXCjYcuWhbaCG+QB8j2/Oyzhg
 /JhaGWSR+O4R16rEGF6vxfYP2wRu1Vc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-ULWkyC8pN0SSqWn6GtsMew-1; Wed,
 02 Oct 2024 11:14:50 -0400
X-MC-Unique: ULWkyC8pN0SSqWn6GtsMew-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74BBE1955F43; Wed,  2 Oct 2024 15:14:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADA0F19560AD; Wed,  2 Oct 2024 15:14:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0160721E6A28; Wed,  2 Oct 2024 17:14:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>,  qemu-devel@nongnu.org,
 kwolf@redhat.com,  hreitz@redhat.com,  berrange@redhat.com,
 qemu-block@nongnu.org,  den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com,  alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit
 in QMP
In-Reply-To: <a2747d44-9f1d-4bec-a9dd-c7e9f7363575@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 2 Oct 2024 16:58:10 +0300")
References: <20240809161828.1342831-4-eblake@redhat.com>
 <20240809161828.1342831-6-eblake@redhat.com>
 <87wmiqy5rl.fsf@pond.sub.org>
 <a2747d44-9f1d-4bec-a9dd-c7e9f7363575@yandex-team.ru>
Date: Wed, 02 Oct 2024 17:14:42 +0200
Message-ID: <87ed4ywn8d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 02.10.24 16:49, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Although defaulting the handshake limit to 10 seconds was a nice QoI
>>> change to weed out intentionally slow clients, it can interfere with
>>> integration testing done with manual NBD_OPT commands over 'nbdsh
>>> --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
>>> to alter the timeout away from the default.
>>>
>>> The parameter name here intentionally matches the spelling of the
>>> constant added in commit fb1c2aaa98, and not the command-line spelling
>>> added in the previous patch for qemu-nbd; that's because in QMP,
>>> longer names serve as good self-documentation, and unlike the command
>>> line, machines don't have problems generating longer spellings.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>

[...]

>> Are we confident we'll never need less than a full second?
>
> Hmm, recent "[PATCH v2] chardev: introduce 'reconnect-ms' and deprecate 'reconnect'" shows that at least sometimes second is not enough precision.
>
> Maybe, using milliseconds consistently for all relatively short time intervals in QAPI would be a good rule?

Ideally, we'd use a single unit for time: nanoseconds.  But we missed
that chance long ago, and now are stuck with a mix of seconds,
milliseconds, microseconds, and nanoseconds.

I think a good rule is to pick the first from this list that will surely
provide all the precision we'll ever need.

In this case, milliseconds should do.


