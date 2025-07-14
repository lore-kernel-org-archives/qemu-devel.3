Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06175C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 06:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubD0Y-0006Em-Ns; Mon, 14 Jul 2025 02:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubCrm-0007K9-HM
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 02:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubCrk-0005eR-Pg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 02:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752475243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pg2Y/MUlo9Xib/lZN//N9DYnVgxf8k32BwCWsxsiQY=;
 b=FqJ8OlO5MrsPZoFGLId/qIyZarTIIp/HSSFbofxJ9NcgD2jDb7xVAP3jS+sNSFMUnTLW9i
 sW2+IrHUvo83XCOJ1GjVavGf9napxGsDX4hU3UIt0RzrAOuYTxco0e+N/jqgMkvzyY2Vw+
 hrdViTiGFRt0wYlhJS53X4/ns7QUxEg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-LXxT8z1cOUqHOwAxf-VG5A-1; Mon,
 14 Jul 2025 02:40:37 -0400
X-MC-Unique: LXxT8z1cOUqHOwAxf-VG5A-1
X-Mimecast-MFC-AGG-ID: LXxT8z1cOUqHOwAxf-VG5A_1752475235
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8D1819560B6; Mon, 14 Jul 2025 06:40:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 869101956094; Mon, 14 Jul 2025 06:40:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DBEC921E6A27; Mon, 14 Jul 2025 08:40:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Jiri Pirko <jiri@resnulli.us>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,  Jason Wang <jasowang@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,  qemu-trivial@nongnu.org,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Lukas
 Straub <lukasstraub2@web.de>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 4/4] qapi: rephrase return docs to avoid type name
In-Reply-To: <877c0eygpn.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 11 Jul 2025 15:55:48 +0200")
References: <20250711051045.51110-1-jsnow@redhat.com>
 <20250711051045.51110-5-jsnow@redhat.com>
 <877c0eygpn.fsf@pond.sub.org>
Date: Mon, 14 Jul 2025 08:40:27 +0200
Message-ID: <87wm8b6zs4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> Well, I tried. Maybe not very hard. Sorry!
>
> Recommend to explain *why* we want to avoid the type name.
>
>   "Returns: <description>" is rendered like "Return: <Type> =E2=80=93
>   <description>".  Mentioning the type in the description again is
>   commonly redundant.  Rephrase such descriptions not to.
>
>> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> I need to stop here to take care of another series.  Gut feeling so far:
> right direction, doesn't go far enough.
>
> Choices:
>
> * Go far enough.  Too close to the freeze for that, I'm afraid.
>
> * Merge it basically as is, come back later to finish the job.

Let's pick this one, then try to improve on top.

> * Drop it for now, adjust your "QAPI: add cross-references to qapi docs"
>   to enclose the type names not removed in `backquotes`.
>
> Thoughts?
>
> [...]

Acked-by: Markus Armbruster <armbru@redhat.com>


