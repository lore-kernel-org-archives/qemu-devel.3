Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B5C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 09:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx0nn-0004bK-39; Tue, 25 Mar 2025 05:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tx0nk-0004ah-Tf
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tx0nj-00082r-Ac
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 05:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742895745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZUOQqLEbeJ9S5Rx9ZqPSg6QwVeKr/ln3BeMl5DMxoo=;
 b=iqay9eVX4OfaQkgIaWtE2TfdYofiXJbX2gL1SFuitoi1HElSKhCrIxcJ9c8OL2sXpPlTwl
 WpCGvzb4tQA8ZOTR89BTXn7JRDDvoj1T6Ys/Y3Lgy45uwv7xzo3dsCBrExr1SiHJr/pi2b
 YXg2vl0cecXzeOCuZA6IQPBOE5MZLYs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-rgsi5pIzMlmnTsKyfj1Sng-1; Tue,
 25 Mar 2025 05:42:22 -0400
X-MC-Unique: rgsi5pIzMlmnTsKyfj1Sng-1
X-Mimecast-MFC-AGG-ID: rgsi5pIzMlmnTsKyfj1Sng_1742895740
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2A951956071; Tue, 25 Mar 2025 09:42:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA0BE1801769; Tue, 25 Mar 2025 09:42:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A525A21E675E; Tue, 25 Mar 2025 10:42:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Peter Xu <peterx@redhat.com>,  "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Lukas Straub <lukasstraub2@web.de>,  Fabiano
 Rosas <farosas@suse.de>,  Eduardo Habkost <eduardo@habkost.net>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  qemu-trivial@nongnu.org,  Jason Wang
 <jasowang@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Peter Maydell
 <peter.maydell@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,  Yanan
 Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  qemu-block@nongnu.org,  Zhenwei Pi
 <pizhenwei@bytedance.com>,  Mads Ynddal <mads@ynddal.dk>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 3/4] qapi: remove trivial "Returns:" sections
In-Reply-To: <20250322010857.309490-4-jsnow@redhat.com> (John Snow's message
 of "Fri, 21 Mar 2025 21:08:56 -0400")
References: <20250322010857.309490-1-jsnow@redhat.com>
 <20250322010857.309490-4-jsnow@redhat.com>
Date: Tue, 25 Mar 2025 10:42:13 +0100
Message-ID: <87bjtpmop6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> The new qapidoc transmogrifier can generate "Returns" statements with
> type information just fine, so we can remove it from the source where it
> doesn't add anything particularly novel or helpful and just repeats the
> type info.
>
> This patch does not touch Returns: lines that add some information
> (potentially helpful, potentially not) but repeats the type information
> to remove that type.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

This is a clear improvement for the generated docs.  For instance,
blockdev-snapshot-delete-internal-sync goes from

    Return:
       "SnapshotInfo" -- SnapshotInfo

to

    Return:
       "SnapshotInfo"

However, I see that *triplicated* in my testing.  I observed similar
issues with the previous patch, so let's discuss that there and ignore
it here.

The impact on schema file egonomics is less clear.

This patch removes a bunch of "Returns:" sections that make the
generated docs look bad.  How can we stop people from writing such
sections?

Developers tend to refer to the schema file instead of the generated
documentation.  Information is spread across doc comment and schema
code.  Both describe the syntactic structure.  Only the schema code has
types, optional, and such.  The doc comment describes semantics.  In
practice, skimming the doc comment is often enough.

Except for the return value.  The doc comment's "Returns:" section is
optional.  When it's absent, the generated docs are bad (but this patch
fixes that).  Moreover, the doc comment doesn't fully describe the
syntactic structure then.  Unwary readers may not be aware of that trap,
and miss the return value.

The inliner you posted before needs to know where the inlined stuff
goes.  Obvious when there are argument descriptions or a "Returns:".
For the cases where we have nothing useful, you proposed an explicit
marker "Details:" (how exactly it's spelled doesn't matter here, only
that an explicit marker can be necessary).  Could removing "Returns:"
make the marker necessary more often?  Can our tooling reliably detect
the need for the marker?


