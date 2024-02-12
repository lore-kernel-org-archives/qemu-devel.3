Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C507C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSL8-0004n1-3B; Mon, 12 Feb 2024 04:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSL5-0004fp-63
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSL0-0003Br-89
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83FP90jEJsa8DUTH0QfC3uT95maAF8W0lvDecItwpN8=;
 b=ccxhOqHhU5vpdELA575j6D1+vccV6fqD2L3t35K+IJau+/qGCquGNBR43cZIK/dMOKTlLc
 i5384H2AQ5IrpyboESzooE6/XaBGltIsIYHJw8QIi2jIgQfYyauEqTDEVg+33OpRlg0h1T
 smNm48qqMY/SYmSb6ZmV3j1zVehakK0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-B3dWTonbPyebcOjNo-AzEQ-1; Mon,
 12 Feb 2024 04:10:46 -0500
X-MC-Unique: B3dWTonbPyebcOjNo-AzEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 530E33C0F360;
 Mon, 12 Feb 2024 09:10:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 294F91C7624F;
 Mon, 12 Feb 2024 09:10:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F245A21E66D0; Mon, 12 Feb 2024 10:10:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  arei.gonglei@huawei.com,  eblake@redhat.com,
 eduardo@habkost.net,  fan.ni@samsung.com,  farosas@suse.de,
 hreitz@redhat.com,  jasowang@redhat.com,  jiri@resnulli.us,
 jonathan.cameron@huawei.com,  kkostiuk@redhat.com,  kraxel@redhat.com,
 kwolf@redhat.com,  lukasstraub2@web.de,  marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com,  michael.roth@amd.com,  mst@redhat.com,
 pbonzini@redhat.com,  peter.maydell@linaro.org,  peterx@redhat.com,
 philmd@linaro.org,  pizhenwei@bytedance.com,  qemu-block@nongnu.org,
 stefanb@linux.ibm.com,  wangyanan55@huawei.com
Subject: Re: [PATCH 06/15] qapi: Require member documentation (with loophole)
In-Reply-To: <ZcM_54CNKzemVb4-@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 7 Feb 2024 08:31:35 +0000")
References: <20240205074709.3613229-1-armbru@redhat.com>
 <20240205074709.3613229-7-armbru@redhat.com>
 <ZcM_54CNKzemVb4-@redhat.com>
Date: Mon, 12 Feb 2024 10:10:42 +0100
Message-ID: <87jznadp4d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Feb 05, 2024 at 08:47:00AM +0100, Markus Armbruster wrote:
>> The QAPI generator forces you to document your stuff.  Except for
>> command arguments, event data, and members of enum and object types:
>> these the generator silently "documents" as "Not documented".
>>=20
>> We can't require proper documentation there without first fixing all
>> the offenders.  We've always had too many offenders to pull that off.
>> Right now, we have more than 500.  Worse, we seem to fix old ones no
>> faster than we add new ones: in the past year, we fixed 22 ones, but
>> added 26 new ones.
>>=20
>> To help arrest the backsliding, make missing documentation an error
>> unless the command, type, or event is in listed in new pragma
>> documentation-exceptions.
>
> If we want to really annoy people we could print a warning to
> stderr during docs generation, for each undocumented field.
> The many pages  of warnings would likely trigger a much quicker
> series to patches to fix it to eliminate the annoying warnings :-)

Heh.

Let's give not annoying people that much a try.  Can always escalate
later :)

[...]


