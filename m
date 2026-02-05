Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E3E91283
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 07:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntSw-0004nb-Hx; Thu, 05 Feb 2026 02:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vntSu-0004nM-F3
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vntSr-00022S-Ud
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770275263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0VPvmEwBad5lS36eO9V5wZj7P8JpKq8667gE1Y8/SM=;
 b=VPGulFl0c5QmEDV2OJ5n4otAS2OP5092Qp59GzJXNAA5X1hoaJzJMjr4q0fCUgmyMXKpxm
 XVGbdHJ1eYtWhDJ+znvF9vFbhY7/G3tM/N1YnCKgvhLr5Pn955U1Qbc8OO5xgvCMjFxymi
 APSMpJTEjGcBcAoPEZjqvCcSknEDKLA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-d3igbw_eOta4E3oJPh3Vlg-1; Thu,
 05 Feb 2026 02:07:40 -0500
X-MC-Unique: d3igbw_eOta4E3oJPh3Vlg-1
X-Mimecast-MFC-AGG-ID: d3igbw_eOta4E3oJPh3Vlg_1770275259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8007D18003FC; Thu,  5 Feb 2026 07:07:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDE881800464; Thu,  5 Feb 2026 07:07:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5444421E692D; Thu, 05 Feb 2026 08:07:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com,  mst@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  thuth@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  farosas@suse.de,  zhao1.liu@intel.com,
 wangyanan55@huawei.com,  philmd@linaro.org,  marcel.apfelbaum@gmail.com,
 eduardo@habkost.net,  davydov-max@yandex-team.ru,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,  leiyang@redhat.com,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com
Subject: Re: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
In-Reply-To: <aYOAAfzZQ3PeKf4q@x1.local> (Peter Xu's message of "Wed, 4 Feb
 2026 12:21:05 -0500")
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-4-vsementsov@yandex-team.ru>
 <aYOAAfzZQ3PeKf4q@x1.local>
Date: Thu, 05 Feb 2026 08:07:34 +0100
Message-ID: <87ecmzu0qx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Sun, Feb 01, 2026 at 07:19:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>  # @migrate-set-parameters:
>> @@ -1004,6 +1005,13 @@
>>  #     is @cpr-exec.  The first list element is the program's filename,
>>  #     the remainder its arguments.  (Since 10.2)
>>  #
>> +# @backend-transfer: Enable backend-transfer feature for devices that
>> +#     supports it.  In general that means that backend state and its
>> +#     file descriptors are passed to the destination in the migraton
>> +#     channel (which must be a UNIX socket).  Individual devices
>> +#     declare the support for backend-transfer by per-device
>> +#     backend-transfer option.  (Since 11.0)
>
> I still think it'll be nice to either have "local" in the name of parameter
> or at least document it with crystal clear terms.
>
> I used to suggest fd-passing, but maybe you wanted to emphasize there's
> more than fds to be migrated at least for tap? Then it can still be
> "local-backend-transfer", because nobody stops a device to transfer backend
> states in a remote migration either.. so "backend-transfer" seems to also
> work for remote migrations, but it is not.
>
> Or at least mentioned explicitly in the comment, saying this is a local
> migration / upgrade.

Documenting the restriction is a must regardless of naming.  The
proposed text does document it, but only indirectly: "(which must be a
UNIX socket)".  Could be improved, I guess.

Capturing the restriction in the name might help.  But it also makes the
name longer.  Feels like a matter of taste to me.  You guys decide :)

> If you could at least update the doc on the locality attribute for the
> migration (one way or another..), feel free to take:
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> If you decide to rename, that's even better.
>
> Thanks,


