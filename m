Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094C7C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 16:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkRA7-0002Sf-Q5; Wed, 13 Mar 2024 12:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkRA3-0002RR-Bb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 12:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkR9z-0004K8-2n
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 12:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710346134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ANZ4Oa/768CJHSgIxvx9posSESQUnZNntbG2HJdQKcw=;
 b=h4mdbssFhqMy50B8aQg/cep/6dX72rU71wn7cYe4392ikFQzRCdFHhNrK2GzV6jwW95egb
 4ozpdw+jBM9k5IUK3ipb6c4old+N5Bu1DPKQrREe4lSxDR9e8O/44uIR13VBEGVHe+buvu
 FU74onHW/zAoJ5Y7YHq+fECAWRGQNzo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-boV0wKvrMe6oGBMToAbrOg-1; Wed,
 13 Mar 2024 12:08:51 -0400
X-MC-Unique: boV0wKvrMe6oGBMToAbrOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17D7E1C41A2B;
 Wed, 13 Mar 2024 16:08:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5744A3C23;
 Wed, 13 Mar 2024 16:08:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C5EC21E6A24; Wed, 13 Mar 2024 17:08:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 xiechanglong.d@gmail.com,  wencongyang2@huawei.com,  hreitz@redhat.com,
 kwolf@redhat.com,  jsnow@redhat.com,  f.ebner@proxmox.com
Subject: Re: [PATCH v4 4/5] qapi: blockdev-backup: add discard-source parameter
In-Reply-To: <20240313152822.626493-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 13 Mar 2024 18:28:21 +0300")
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
 <20240313152822.626493-5-vsementsov@yandex-team.ru>
Date: Wed, 13 Mar 2024 17:08:48 +0100
Message-ID: <87o7bicdwv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add a parameter that enables discard-after-copy. That is mostly useful
> in "push backup with fleecing" scheme, when source is snapshot-access
> format driver node, based on copy-before-write filter snapshot-access
> API:
>
> [guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
>    |            |
>    | root       | file
>    v            v
> [copy-before-write]
>    |             |
>    | file        | target
>    v             v
> [active disk]   [temp.img]
>
> In this case discard-after-copy does two things:
>
>  - discard data in temp.img to save disk space
>  - avoid further copy-before-write operation in discarded area
>
> Note that we have to declare WRITE permission on source in
> copy-before-write filter, for discard to work. Still we can't take it
> unconditionally, as it will break normal backup from RO source. So, we
> have to add a parameter and pass it thorough bdrv_open flags.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1874f880a8..2ef52ae9a7 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1610,6 +1610,9 @@
>  #     node specified by @drive.  If this option is not given, a node
>  #     name is autogenerated.  (Since: 4.2)
>  #
> +# @discard-source: Discard blocks on source which are already copied

"have been copied"?

> +#     to the target.  (Since 9.1)
> +#
>  # @x-perf: Performance options.  (Since 6.0)
>  #
>  # Features:
> @@ -1631,6 +1634,7 @@
>              '*on-target-error': 'BlockdevOnError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
>              '*filter-node-name': 'str',
> +            '*discard-source': 'bool',
>              '*x-perf': { 'type': 'BackupPerf',
>                           'features': [ 'unstable' ] } } }

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


