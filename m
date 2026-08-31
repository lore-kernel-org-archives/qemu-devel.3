Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13444C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12PD-0003dC-Qz; Mon, 31 Aug 2026 09:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x12PB-0003c9-2h
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x12P9-0003iX-0H
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoTZvmy4jPUbkp6P4GsXHnJjsEPvOhs/+ivdjF0DsTM=;
 b=HZkTuEYr6EhvGvLqafs7PSC8wVLb10iy3mWqw0z5XXxkN2En+8RKxF5tll8LJHy2rp1tgA
 4FFHFBQCckmExnZid4M/h7VzEqFKhMDXJ0bmr18ari5Sbe8hBxSzWEbmgCOlkacvhF9sak
 EIsm+GMpKNd5dAxMijeqUWPgtQHDR8c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-vkSRe0j1MoqBXm7keiMN6Q-1; Mon,
 31 Aug 2026 09:50:24 -0400
X-MC-Unique: vkSRe0j1MoqBXm7keiMN6Q-1
X-Mimecast-MFC-AGG-ID: vkSRe0j1MoqBXm7keiMN6Q_1788184220
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57535195DE5B; Mon, 31 Aug 2026 13:50:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 750891956042; Mon, 31 Aug 2026 13:50:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F002421E6837; Mon, 31 Aug 2026 15:50:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex@shazbot.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 42/43] qapi: convert trivial intro sections for
 machine.json
In-Reply-To: <87pkyye7j1.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 31 Aug 2026 15:36:34 +0200")
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-43-jsnow@redhat.com>
 <87pkyye7j1.fsf@pond.sub.org>
Date: Mon, 31 Aug 2026 15:50:13 +0200
Message-ID: <87ecfee6wa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  qapi/machine.json | 208 ++++++++++++++++------------------------------
>>  1 file changed, 73 insertions(+), 135 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 2d63c1bac3b..3a5c6df9cff 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>
> [...]
>
>> @@ -469,8 +453,7 @@
>>  
>>  ##
>>  # @NumaOptions:
>> -#
>> -# A discriminated record of NUMA options.  (for OptsVisitor)
>> +#     A discriminated record of NUMA options.  (for OptsVisitor)
>>  #
>>  # @type: NUMA option type
>>  #
>
> The parenthesis is questionable.  As long as it's there, this isn't
> "very trivial".

Could move it into the sentence, like so

    # A discriminated record of NUMA options (for OptsVisitor).

But I think we can just drop it.

Neither should be in the "very trivial" jumbo patch.

>> @@ -488,8 +471,7 @@
>>  
>>  ##
>>  # @NumaNodeOptions:
>> -#
>> -# Create a guest NUMA node.  (for OptsVisitor)
>> +#     Create a guest NUMA node.  (for OptsVisitor)
>>  #
>>  # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
>>  #
>
> Likewise.

[...]


