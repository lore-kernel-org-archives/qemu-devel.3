Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94484606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sut/U0Wu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoiw-0001xM-5s; Fri, 13 Nov 2026 05:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRoiu-0001ww-5G
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:41:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRois-0008Lt-Ng
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hlqU1TUNuCr03edqKYVJaoEuotDUY8ojSYPAuEIAKo=;
 b=Sut/U0WuQOYCyB4+JadjTRLhrgMsMUbfiH/6Vyd1Q2so3saog+br2L40IaWLghZsznVAaY
 aX5tFC/Gkn8Ooe1UoykzrPviaFGadJAFwd9n9vP25ghRn1WD9h73akW6a5c4i+3k4uHC78
 WXrRDENfY16Ipwp3rMO2fQELSmzjV94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-a6DTM3eBMmqRmPahYQcJ1Q-1; Fri,
 13 Nov 2026 05:41:29 -0500
X-MC-Unique: a6DTM3eBMmqRmPahYQcJ1Q-1
X-Mimecast-MFC-AGG-ID: a6DTM3eBMmqRmPahYQcJ1Q_1794566488
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F9BE1800559; Fri, 13 Nov 2026 10:41:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDF4B18004FC; Fri, 13 Nov 2026 10:41:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D0C221E6A04; Fri, 13 Nov 2026 11:41:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 35/48] qapi: report target compatibility for machine types
In-Reply-To: <avbaFmxkAKN1tWp4@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 13 Nov 2026 09:36:22 +0000")
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-36-berrange@redhat.com>
 <87fqx5xj3d.fsf@pond.sub.org> <avbaFmxkAKN1tWp4@redhat.com>
Date: Fri, 13 Nov 2026 11:41:25 +0100
Message-ID: <87v761ui7e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Nov 13, 2026 at 08:53:58AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Add a 'targets' field to MachineInfo which is populated with
>> > the list of targets a machine is declard to be compatible
>> > with.
>> >
>> > To avoid reporting redundant information for the traditional
>> > per-target emulator binaries, this new field is only emitted
>> > if no target is currently selected, or the 'all-targets'
>> > flag is explicitly set.
>>=20
>> How much redundant data does this save in practice?
>>=20
>> Is saving it worth the additional interface complexity?
>
> All the arm machine types will report
>
>   targets: [ "arm", "aarch64"]
>
> except for a handful which will be
>
>   targets: [ "aarch64"]
>
> In a multi-target binary (ie what we intend to ship in
> future, along side current binaries), it makes sense
> that we report this, but in a single target binary
> (ie what we ship today), it feels somewhat odd to me
> to be reporting
>
>   targets: [ "arm", "aarch64"]
>
> in the qemu-system-arm binary, given it can't support
> aarch64.
>
> So I wanted to hide the 'targets' output when a specific
> target is selected.
>
> Functionally there is no problem with reporting this
> unconditionally in all scenarios. It just felt odd,
> which admittedly is a weak reason for a technical
> choice.

@targets is described as "a list of compatible targets for the machine".
Doesn't say "compatible targets this QEMU can do".

The targets this QEMU can do are available elsewhere.  Right now, QEMU
can do just one, and query-target returns it.  I expect future versions
that can support multiple targets will provide a query to return them
all.

I'd keep things simple and stateless: list all targets always.  Clients
can easily compute the intersection with the targets this QEMU can do.

>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>=20
>
> With regards,
> Daniel


