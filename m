Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C65C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyQl-0006lO-8T; Thu, 06 Feb 2025 04:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfyQa-0006Yq-RC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfyQY-0002QA-Qa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738835045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9ySX1Ld54IH2IvrHhtfPcFeSYAdC5loRMDTjgeVxhg=;
 b=UibUWZ6uhNKzH01Bd7mgLACJPUhtzcdIlXGR2maOWHFSj1SdET8IIs6lYAkMb6KVbIB5kT
 AIIXVlMQOe/rga+ON7+KHzbi/STiCgQtZUG3/jhmCIQJMKX8Muf84Yrsws39VLQychgwTj
 aOuNwgsGsFbMuJ8FHD1qE/+QqY2ctNw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-N0U-0GbzNtWQNgG0-kDbhQ-1; Thu,
 06 Feb 2025 04:43:59 -0500
X-MC-Unique: N0U-0GbzNtWQNgG0-kDbhQ-1
X-Mimecast-MFC-AGG-ID: N0U-0GbzNtWQNgG0-kDbhQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA6C61800875; Thu,  6 Feb 2025 09:43:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4CC1800352; Thu,  6 Feb 2025 09:43:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B1BA21E6A28; Thu, 06 Feb 2025 10:43:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Jason Wang
 <jasowang@redhat.com>,  Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Luigi Rizzo <rizzo@iet.unipi.it>,  Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>,  Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Michael Roth
 <michael.roth@amd.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Lei Yang
 <leiyang@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
In-Reply-To: <Z4D_zK-QIN07EXR5@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 10 Jan 2025 11:09:00 +0000")
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
 <Z4D_zK-QIN07EXR5@redhat.com>
Date: Thu, 06 Feb 2025 10:43:51 +0100
Message-ID: <87v7tns90o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jan 08, 2025 at 03:17:51PM +0900, Akihiko Odaki wrote:
>> Accept bool literals for OnOffAuto properties for consistency with bool
>> properties. This enables users to set the "on" or "off" value in a
>> uniform syntax without knowing whether the "auto" value is accepted.
>> This behavior is especially useful when converting an existing bool
>> property to OnOffAuto or vice versa.
>
> Again, to repeat my previous feedback, OnOffAuto is a well defined
> QAPI type - making it secretly accept other values/types behind
> the scenes which are not visible in QAPI scheme is not acceptable.
>
> Effectively this is a backdoor impl of a QAPI alternate
>
>   { 'alternate': 'OnOffAutoOrBool',
>     'data': {
>       'o': 'OnOffAuto',
>       'b': 'bool'
>     }
>   }
>
> except this isn't permitted as the QAPI generator explicitly blocks
> use of alternate when the two branches are 'bool' and 'enum'.
>
> I'm assuming this is because in the QemuOpts scenario, it cannot
> guess upfront whether the input is a bool or enum. This is unfortunate
> though, because at the JSON visitor level it is unambiguous.=20
>
> I wonder if the QAPI generator could be relaxed in any viable way ?

Discussed in review of a related prior patch:
https://lore.kernel.org/qemu-devel/87h6c4fqz6.fsf@pond.sub.org/

Here's the relevant part for your convenience:

    >> parse the value as enum, and if that fails, as uint32_t.  QAPI alrea=
dy
    >> provides a way to express "either this type or that type": alternate.
    >> Like this:
    >>=20
    >>      { 'alternate': 'OnOffAutoUint32',
    >>        'data': { 'sym': 'OnOffAuto',
    >>                  'uint': 'uint32' } }
    >>=20
    >> Unfortunately, such alternates don't work on the command line due to
    >> keyval visitor restrictions.  These cannot be lifted entirely, but we
    >> might be able to lift them sufficiently to make this alternate work.
    >
    > The keyval visitor cannot implement alternates because the command li=
ne=20
    > input does not have type information. For example, you cannot=20
    > distinguish string "0" and integer 0.

    Correct.

    For alternate types, an input visitor picks the branch based on the
    QType.

    With JSON, we have scalar types null, number, string, and bool.

    With keyval, we only have string.  Alternates with more than one scalar
    branch don't work.

    They could be made to work to some degree, though.  Observe:

    * Any value can be a string.

    * "frob" can be nothing else.

    * "on" and "off" can also be bool.

    * "123" and "1e3" can also be number or enum.

    Instead of picking the branch based on the QType, we could pick based on
    QType and value, where the value part is delegated to a visitor method.


