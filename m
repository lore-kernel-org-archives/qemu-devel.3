Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25574C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA1g-0006SB-K8; Fri, 11 Jul 2025 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaA1d-0006Ik-ID
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaA1Y-0005F6-EW
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752225991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imHdRp2AM/9z+IDszBmvWXGpIybLT8YZAVnFcDjyKY0=;
 b=Luo4GUn4RqvItouClFpy1WZ76uuehPSeoROeRdkO+i4hYXtNDK82Gc/K/JhSM2IGGLb9Cw
 crJ2IbHjb2k/RYOGbWe+g7v5DDvFZfnDX9KTb2gQQ7SAxDLgw8I1I+9FK+gVffgcjjl00G
 u2dsvX0mTKDYWDGs8dkMA+f93gTaKRk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-H39QmBmwNbqAQ0MDe-hDEg-1; Fri,
 11 Jul 2025 05:26:26 -0400
X-MC-Unique: H39QmBmwNbqAQ0MDe-hDEg-1
X-Mimecast-MFC-AGG-ID: H39QmBmwNbqAQ0MDe-hDEg_1752225984
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC26719560B2; Fri, 11 Jul 2025 09:26:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B4601800285; Fri, 11 Jul 2025 09:26:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E638021E6A27; Fri, 11 Jul 2025 11:26:19 +0200 (CEST)
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
In-Reply-To: <87ple76quz.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 11 Jul 2025 11:04:04 +0200")
References: <20250711054005.60969-1-jsnow@redhat.com>
 <87ple76quz.fsf@pond.sub.org>
Date: Fri, 11 Jul 2025 11:26:19 +0200
Message-ID: <874ivj6ptw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> Based-on: 20250711051045.51110-1-jsnow@redhat.com
>>     [PATCH v6 0/4] qapi: add auto-generated return docs
>>
>> v2:
>>  - Applied a few new transformations I had missed.
>>  - Manually excluded those Markus pointed out as being unhelpful.
>
> You missed a few.  Can drop them in my tree.  I also suggested a commit
> message amendment.  Can do that in my tree, too.  With that, series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

One more thing: docs/devel/qapi-code-gen.rst needs an update.
Specifically:

    Use ``@foo`` to reference a name in the schema.  This is an rST
    extension.  It is rendered the same way as ````foo````, but carries
    additional meaning.

Let's do that on top.


