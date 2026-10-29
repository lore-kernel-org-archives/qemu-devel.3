Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69591606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJ1agdOk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKTT-0005ER-Vq; Thu, 29 Oct 2026 03:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMKTR-0005Dz-L5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMKTQ-0000Nv-6k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793258574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhgCEKXSkIc5+vp1Ra85+bY7xSp4/WCjdoD7bU7k2T4=;
 b=XJ1agdOktUd11vi1MXEMe7nXN+V5JcVExqPfyBUEKXTvVR1JOIJiDnJyXg5gA5QiX+GVID
 Q4qqCn0r1LmdplHQgnD1o13HphnOWu588bFVL7u9pO0iQLypqW0BU6eqYdIygu5/+VUKgt
 T9nQTfn2GGld/RgbI5fQGFMGqJXbLTg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-GMPkkdeLPAmg0lkJ2RPI8g-1; Thu,
 29 Oct 2026 03:22:42 -0400
X-MC-Unique: GMPkkdeLPAmg0lkJ2RPI8g-1
X-Mimecast-MFC-AGG-ID: GMPkkdeLPAmg0lkJ2RPI8g_1793258561
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F8191954124; Thu, 29 Oct 2026 07:22:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EDCF3000B78; Thu, 29 Oct 2026 07:22:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 662E321E6A04; Thu, 29 Oct 2026 08:22:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Timur Maksimov <gessingate@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Jamin
 Lin <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,
 qemu-arm@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
In-Reply-To: <5d219f231fb1f97c6d90cbef4068e82dff803a18.camel@gmail.com> (Timur
 Maksimov's message of "Wed, 28 Oct 2026 19:20:48 +0300")
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
 <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
 <874ie6ku2u.fsf@pond.sub.org>
 <5d219f231fb1f97c6d90cbef4068e82dff803a18.camel@gmail.com>
Date: Thu, 29 Oct 2026 08:22:36 +0100
Message-ID: <87pkwtezsz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Timur Maksimov <gessingate@gmail.com> writes:

> Hi, thanks for the review.=C2=A0
>
> It was my decision to use such API, I thought it would be okay for a
> test device. I don't think there is a way to expose integer array as a
> single QOM property.

There are ways, but I need to know what you're trying to accomplish to
be able to provide guidance.

> Actually, we can go without this model. I suppose I will rewrite tests
> so they don't use it.

You haven't answered my question on code-provenance.rst.

> On Wed, 2026-10-28 at 11:17 +0100, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>> > + Corey for I2C feed back.
>> >=20
>> > + Markus for QOM
>> >=20
>> > The brute-force solution to expose the contents of the device array
>> > with 128 properties has a slight AI smell. I find it ugly but I am
>> > human :)
>>=20
>> Timur, have you read docs/devel/code-provenance.rst section "Use of
>> AI-generated content"?
>>=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 That said I don't kno=
w if there are better alternatives.

[...]


