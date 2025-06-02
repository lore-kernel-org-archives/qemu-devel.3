Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002BAC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0Ff-0008QM-8X; Mon, 02 Jun 2025 04:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM0FY-0008Or-PM
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM0FX-0008TT-8q
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748851826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeZt10Jrld74dZiGgnUmuTOTFHinvesEHkPG8HUd3Mw=;
 b=MBsP/MuJBSkI6rQO0fRaHWYzhCCf6SkIVZXYLESmYbHSIAHwbCboJXb4Oqdb8LfWePvT+3
 88YXvQqpP8TkbmiEdT9namba8C9/qAVPd34o2mHAxAvgv6RnHBN1282MmhrxurIrIuYEuO
 4+bi6iyY5ILxE5qwGZKQ1L/LADVTIRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-_END_9DyNRK1pz81y6fFnA-1; Mon,
 02 Jun 2025 04:10:24 -0400
X-MC-Unique: _END_9DyNRK1pz81y6fFnA-1
X-Mimecast-MFC-AGG-ID: _END_9DyNRK1pz81y6fFnA_1748851821
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 423CF1833498; Mon,  2 Jun 2025 08:10:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB5C31955F2C; Mon,  2 Jun 2025 08:10:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F061121E66C3; Mon, 02 Jun 2025 10:10:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Jiri Pirko <jiri@resnulli.us>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,  Peter Xu
 <peterx@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Jason Wang
 <jasowang@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-trivial@nongnu.org,  Gerd Hoffmann
 <kraxel@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,  Zhao Liu
 <zhao1.liu@intel.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Ani Sinha
 <anisinha@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 0/4] qapi: add auto-generated return docs
In-Reply-To: <d594a44b-a2fd-4c58-8738-8a02cef4e7d4@tls.msk.ru> (Michael
 Tokarev's message of "Sat, 31 May 2025 20:33:59 +0300")
References: <20250523182442.54469-1-jsnow@redhat.com>
 <d594a44b-a2fd-4c58-8738-8a02cef4e7d4@tls.msk.ru>
Date: Mon, 02 Jun 2025 10:10:13 +0200
Message-ID: <87jz5umumy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 23.05.2025 21:24, John Snow wrote:
>> v3: rebased on top of python-qapi-linting (v4) pull request;
>>      removed commits that are no longer needed.
>>      Markus: I forget where we left off... shall we refresh?
>> v2: fix multi-return-sections bug :(
>> John Snow (4):
>>    docs/qapi-domain: add return-nodesc
>>    docs, qapi: generate undocumented return sections
>>    qapi: remove trivial "Returns:" sections
>>    qapi: rephrase return docs to avoid type name
>
> I've applied the first 2 patches to the trivial-patches tree.
>
> But the remaining 2 does not apply anymore due to reorg of
> the json files for single-binary.
>
> I tried to fiddle with the patches a bit, but it looks like
> it'd be better if the original author will do that, to avoid
> my mistakes :)

I'd like to take all four through my tree after I reviewed them.

Sorry for the delay!


