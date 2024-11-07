Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02EED43366
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t93LI-00033r-0q; Thu, 07 Nov 2024 09:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t93LF-00033g-8t
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t93LD-00053o-5q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730989109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYN/iBRp7p/S5Xr5lDN/GWGCz1c2OWXMN16CeMOpKSE=;
 b=cB8QE+qk00LI21FKovD9dhsJzbvc4tjl3H8DGx+SgZdl4wsHo65qRic7e3FAOS+kf6Ak8t
 6sRrUvUucLXViBeAsr85sf85WAhnMDll1PZV4xn7eA0Q/mRiu/HAzQisjkKg5l/Byd6T6T
 cwJFxiAwVWeWhabV5xVI4b5nas22uGE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-aim9iY9oNxeCG3NTOMZPyw-1; Thu,
 07 Nov 2024 09:18:26 -0500
X-MC-Unique: aim9iY9oNxeCG3NTOMZPyw-1
X-Mimecast-MFC-AGG-ID: aim9iY9oNxeCG3NTOMZPyw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DDB1955F42
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 14:18:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3ACC1953880
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 14:18:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41B2621E6A28; Thu,  7 Nov 2024 15:18:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  John Snow <jsnow@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [RFC PATCH v2 0/8] qapi: add generator for Golang interface
In-Reply-To: <Zyy7XGTRuCS0yGgI@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 7 Nov 2024 13:06:36 +0000")
References: <20220617121932.249381-1-victortoso@redhat.com>
 <ZyyZugciNAYmVjeP@redhat.com> <87r07njk4e.fsf@pond.sub.org>
 <Zyy7XGTRuCS0yGgI@redhat.com>
Date: Thu, 07 Nov 2024 15:18:23 +0100
Message-ID: <87zfmbi0uo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On Thu, Nov 07, 2024 at 01:36:49PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]

>> > TL;DR: I think you can re-add the documentation comments to
>> > the Golang code generator, declare the resulting code as being
>> > "MIT-0 AND GPL-2.0-or-later".
>> >
>> > In the README.md file we need todo two important things:
>> >
>> >  * Document our interpretation of the "combined work" license
>> >    situation for applications consuming the project.
>> >  * Declare that *ALL* manually written code contributions
>> >    are exclusively MIT-0.
>>=20
>> What code do you have in mind?  Can you provide an example?
>
> I don't have any particular examples. Perhaps 100% of the .go code
> in the repo in question will be auto-generated. I can't predict the
> future, so there's a decent chance we might end up with some basic
> scaffolding and/or layered framework code that is manually written.

Yes.

> If such a situation arises, it is important to have anticipated this,
> to make clear it is intended to be under a specific license.

Makes sense.


