Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E621C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMPG-0006gw-CG; Wed, 12 Jun 2024 07:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHMPD-0006gQ-Hm
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHMPC-0002LP-0z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718192681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6S96Rp6J9kKR7F2mL2xm6fdtnBaMl08bY+tB+k1c0Y=;
 b=FR+3W+WXSjQawR1L9oSK/7NNgOWwbPAgXaL1b05V+mOPC3NC3dHoyDIs+mrGa5mvn8WBSa
 mv2vd12vyWl+8CtMqvDBnn5J73ucbvXQEuJsp09SSbjchbTcWtikeu0qGBH6Ytm4xQiWVf
 mmlpS8rTHQjR2bJ/pgTuqdG16qw2Lmo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-0btIiwbDMw2hzmLIJzhUjg-1; Wed,
 12 Jun 2024 07:44:38 -0400
X-MC-Unique: 0btIiwbDMw2hzmLIJzhUjg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0226195608E; Wed, 12 Jun 2024 11:44:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BD4319560AF; Wed, 12 Jun 2024 11:44:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00F2521F4B8B; Wed, 12 Jun 2024 13:44:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/4] qom: allow to mark objects as deprecated or not
 secure.
In-Reply-To: <ZmmFiJY4gBTk8kKk@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 12 Jun 2024 12:24:56 +0100")
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-2-kraxel@redhat.com>
 <8734pifmgv.fsf@pond.sub.org> <ZmmFiJY4gBTk8kKk@redhat.com>
Date: Wed, 12 Jun 2024 13:44:33 +0200
Message-ID: <87ikyee672.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On Wed, Jun 12, 2024 at 01:07:44PM +0200, Markus Armbruster wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>=20
>> > Add flags to ObjectClass for objects which are deprecated or not secur=
e.
>> > Add 'deprecated' and 'not-secure' bools to ObjectTypeInfo, report in
>> > 'qom-list-types'.  Print the flags when listing devices via '-device
>> > help'.
>> >
>> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

[...]

>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 8bd299265e39..3f20d4c6413b 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -163,10 +163,16 @@
>> >  #
>> >  # @parent: Name of parent type, if any (since 2.10)
>> >  #
>> > +# @deprecated: the type is deprecated (since 9.1)
>> > +#
>> > +# @not-secure: the type (typically a device) is not considered
>> > +#     a security boundary (since 9.1)
>>=20
>> What does this mean?  Does it mean "do not add an instance of this
>> device the guest unless you trust the guest"?
>
> Essentially yes. This ties to our security doc where we declare
> we won't consider non-virtualization use cases as being security
> bugs (CVEs) as large parts of QEMU haven't been designed to
> provide a guest security boundary
>
>   https://www.qemu.org/docs/master/system/security.html

Would it make sense to add a suitable pointer to the doc comment?


