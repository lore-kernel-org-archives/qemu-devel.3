Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696E6C369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 05:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Tkb-0004up-Af; Sat, 12 Apr 2025 01:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u3TkW-0004uB-2W
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u3TkT-0006SP-S6
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744436987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=8JCyL/xQn/zfA/TF40+ecVlWomAgun9hIuzqOCnb8xQ=;
 b=EtVSnmcubbr93vdVYpLD8y/rWUtm8w8UmOS/3n/53yPbxtesHOGf9KTtmIOWdPYy5Lszg8
 5fG7hVE/9RZoZBQYh5cx4nbWHOeh95bwzAetZrqymXnOaWUichrbAjLkemRxxZ5dYgYqfI
 EC0J0ucbAzvXdlkjlvfk0EYI3pSFjGw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-XMkHac2mOEmcnfwpINzqpg-1; Sat,
 12 Apr 2025 01:49:45 -0400
X-MC-Unique: XMkHac2mOEmcnfwpINzqpg-1
X-Mimecast-MFC-AGG-ID: XMkHac2mOEmcnfwpINzqpg_1744436984
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB8EE19560BB; Sat, 12 Apr 2025 05:49:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32DC7180B486; Sat, 12 Apr 2025 05:49:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A07F21E66C5; Sat, 12 Apr 2025 07:49:39 +0200 (CEST)
Resent-To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sat, 12 Apr 2025 07:49:39 +0200
Resent-Message-ID: <87ikna2aks.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: Re: [PATCH 7/6] mirror: Allow QMP override to declare target
 already zero
In-Reply-To: <20250411144845.600350-2-eblake@redhat.com> (Eric Blake's message
 of "Fri, 11 Apr 2025 09:48:22 -0500")
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411144845.600350-2-eblake@redhat.com>
Date: Sat, 12 Apr 2025 06:56:37 +0200
Message-ID: <8734ee3rlm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> Qemu's attempts to learn whether a destination file starts life with

QEMU (multiple times).

> all zero contents are just a hueristic.  There may be cases where the

heuristic

> caller is aware of information that qemu cannot learn quickly, in
> which case telling qemu what to assume about the destination can make
> the mirror operation faster.  Given our existing example of "qemu-img
> convert --target-is-zero", it is time to expose this override in QMP
> for blockdev-mirror as well.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json                   |  9 ++++++++-
>  include/block/block_int-global-state.h |  3 ++-
>  block/mirror.c                         | 19 +++++++++++++------
>  blockdev.c                             | 18 +++++++++++-------
>  tests/unit/test-block-iothread.c       |  2 +-
>  5 files changed, 35 insertions(+), 16 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e19..6d6185a336a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2538,6 +2538,12 @@
>  #     disappear from the query list without user intervention.
>  #     Defaults to true.  (Since 3.1)
>  #
> +# @target-is-zero: Assume the destination read as all zeroes before

reads

> +#     the mirror started, even if qemu is unable to quickly learn that

QEMU

> +#     from the destination.  Default false, since setting this to true
> +#     when the destination is not already zero can lead to a corrupt
> +#     destination.  (Since 9.1)

10.1

The "even if" clause is confusing.  How would I decide that "QEMU is
unable to learn"?

According to the commit message, the purpose of the flag is to maybe
speed up things when we know the destination is all zeroes, but that's
less than obvious from the doc string.

> +#

Here's my attempt:

   # @target-is-zero: Assume the destination read as all zeroes before
   #     the mirror started.  Setting this to true can speed up the
   #     mirror.  Setting this to true when the destination is not
   #     actually all zero can corrupt the destination.  (Since 10.1)

>  # Since: 2.6
>  #
>  # .. qmp-example::
> @@ -2557,7 +2563,8 @@
>              '*on-target-error': 'BlockdevOnError',
>              '*filter-node-name': 'str',
>              '*copy-mode': 'MirrorCopyMode',
> -            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
> +            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
> +            '*target-is-zero': 'bool'},
>    'allow-preconfig': true }
>
>  ##

[...]


