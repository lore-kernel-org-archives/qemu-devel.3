Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A6606A885
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DaYRB1Mf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoPw-0003wy-A4; Fri, 13 Nov 2026 05:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRoPu-0003rq-LH
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:21:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRoPt-0003Ui-1t
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794565315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDjjtBkEaCI+/MhxlNvpkuwQaygL0znjO61jWbawOow=;
 b=DaYRB1Mf+1jDEouTVE2AW0d11aTznARlQzWGRqBBTdLrCctMpa28ui3ZCsV2L7IlQ/EEHC
 J8hlX8j0SzQ7XCHh4BU6uL6NVeNlM7MSN0VGYKzNHpqVKswB0tdJVAtv5CEA5pojKvdjLn
 ie+Z0c1FgZKOFDDDQY+rS0Y2m/Slae8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-dlzC0BkUOv2NUocO721jaA-1; Fri,
 13 Nov 2026 05:21:51 -0500
X-MC-Unique: dlzC0BkUOv2NUocO721jaA-1
X-Mimecast-MFC-AGG-ID: dlzC0BkUOv2NUocO721jaA_1794565310
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2980180028A; Fri, 13 Nov 2026 10:21:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DDB1195E489; Fri, 13 Nov 2026 10:21:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D27E221E6A04; Fri, 13 Nov 2026 11:21:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 07/48] qapi: report multiple aliases in MachineInfo
In-Reply-To: <avbZD5Frv_Pzbl-k@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 13 Nov 2026 09:31:59 +0000")
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-8-berrange@redhat.com>
 <87o6btxjo0.fsf@pond.sub.org> <avbZD5Frv_Pzbl-k@redhat.com>
Date: Fri, 13 Nov 2026 11:21:47 +0100
Message-ID: <871p8pvxok.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Nov 13, 2026 at 08:41:35AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The MachineInfo struct is extended to report the list of aliases
>> > from the TYPE_ALIASED interface, in preference to the traditional
>> > alias from the TYPE_MACHINE struct.
>> >
>> > Initially we use 'alias' to fill the 'aliases' field in QOM. As
>> > machines get converted to set 'aliases', the first 'aliases'
>> > element will get used to fill 'alias. This provides backcompat
>> > during the transition phase.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>=20
>> [...]
>>=20
>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index 18d9dce849b..c25a492a4e8 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>> > @@ -163,6 +163,8 @@
>> >  #
>> >  # @alias: an alias for the machine name
>> >  #
>> > +# @aliases: a list of aliases for the machine type name (since 12.0)
>> > +#
>>=20
>> How are these two related?  Can one be present, and not the other?  If
>> both are present, does @alias always equal the first element of
>> @aliases?
>
> Yes, both are set, or neither are set. If set, @alias and @aliases[0]
> must always be identical.

Let's spell that out in the description.

>> @alias gets deprecated in PATCH 11.  Mention in the commit message?
>
> Sure
>
>>=20
>> >  # @is-default: whether the machine is default
>> >  #
>> >  # @cpu-max: maximum number of CPUs supported by the machine type
>> > @@ -202,6 +204,7 @@
>> >  ##
>> >  { 'struct': 'MachineInfo',
>> >    'data': { 'name': 'str', '*alias': 'str',
>> > +            '*aliases': ['str'],
>> >              '*is-default': 'bool', 'cpu-max': 'int',
>> >              'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool=
',
>> >              'deprecated': 'bool', '*default-cpu-type': 'str',
>>=20
>
> With regards,
> Daniel


