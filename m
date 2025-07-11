Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF7C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9nn-0006k5-2R; Fri, 11 Jul 2025 05:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9g9-0005Im-U6
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9g7-0007rp-Og
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752224663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AW1mVjXrPoy7/m3DV+ATyYsBKCZIvP45gJK00cNIoeQ=;
 b=ZOpaMEIG2KcGhF/zCGqHTIM82fObmATRt2NnmKqVYFvL5LI4AclncTj+RxPZWQS1r1+D+D
 RlVTGXYubFmYNld0jZbw6d1EwvFDeh2yZCqJhdbOYUgAIxvStQFfntGMQNFlKm/ugLc9h1
 3+wbBCVnMwFxK7CngZ6+M4hiNVqq9Gg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-9M5z6aeWMD6elZ7j5oMBjg-1; Fri,
 11 Jul 2025 05:04:19 -0400
X-MC-Unique: 9M5z6aeWMD6elZ7j5oMBjg-1
X-Mimecast-MFC-AGG-ID: 9M5z6aeWMD6elZ7j5oMBjg_1752224658
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92C66180AC7B; Fri, 11 Jul 2025 09:04:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A306A18002B6; Fri, 11 Jul 2025 09:04:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 255D521E6A27; Fri, 11 Jul 2025 11:04:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Zhao Liu
 <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>,  Peter Xu
 <peterx@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Jason Wang <jasowang@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 00/18] QAPI: add cross-references to qapi docs
In-Reply-To: <20250711054005.60969-1-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:39:47 -0400")
References: <20250711054005.60969-1-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 11:04:04 +0200
Message-ID: <87ple76quz.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Based-on: 20250711051045.51110-1-jsnow@redhat.com
>     [PATCH v6 0/4] qapi: add auto-generated return docs
>
> v2:
>  - Applied a few new transformations I had missed.
>  - Manually excluded those Markus pointed out as being unhelpful.

You missed a few.  Can drop them in my tree.  I also suggested a commit
message amendment.  Can do that in my tree, too.  With that, series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

> Hi, this patch series is a *mostly* mechanical application of QAPI
> cross-references to the QAPI/QMP documentation. I exported all
> cross-referenceable symbols from the QMP QAPI schema and ran them
> through a script that converted any matching words to a cross-reference.
>
> I then used `git add -p` and only added changes that looked reasonable,
> omitting many cases of converting common words like "stop",
> "transaction", "eject", "String" etc when it wasn't immediately clear
> that it was appropriate. I probably missed a few ... in either
> direction.
>
> I'd like to ask maintainers for each subsystem to review the changes and
> confirm that they make sense. To make it easy for you, here's a link to
> each module that was changed, in order:

[...]

> A few benefits of doing this:
>
> (1) It makes the docs easier to navigate for users, being able to just
>     click to the referred data type / enum / event / command / etc.

A *huge* usability win!

> (2) It helps prevent bitrot: if the name of a command / event / data
>     type / etc changes, the cross-reference will cause the build to
>     fail, giving a needed hint that documentation elsewhere needs to be
>     updated.

Can also catch typos.

> (3) Prompting the maintainers to review the generated HTML documentation
>     O:-)

WAT?!?  We're supposed to actually look at the doc we expect our users
to read?

[...]


