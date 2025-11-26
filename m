Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D9BD10F34
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEqL-0002wW-Pa; Wed, 26 Nov 2025 07:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOEqI-0002bB-0n
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOEqF-0003QT-50
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764160909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wYqgSylkBCj0+dBZz5KYyTjBUHFJLZyjG6hsYfolYc8=;
 b=YoVGnJgIwTbVA4FxfKnSJiKWFg3GUCoNKJm+HwxjySiL3QoEXbQkF4NoMSyi5vVkYYM89E
 xuUO0pzSVU0mcVf7WU+yVak8ckHNBG/oziHweYAsJpPvrO00G4Rgu6eLJNzvGnKaWFeDrk
 IhmLXhDQ2i3TzKuXXqSMdWytXonCVFU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-qx4v7SB7NMunQhBXbtw2Ig-1; Wed,
 26 Nov 2025 07:41:45 -0500
X-MC-Unique: qx4v7SB7NMunQhBXbtw2Ig-1
X-Mimecast-MFC-AGG-ID: qx4v7SB7NMunQhBXbtw2Ig_1764160905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8ABE1954B0B; Wed, 26 Nov 2025 12:41:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EB5C195608E; Wed, 26 Nov 2025 12:41:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9DA821E6A27; Wed, 26 Nov 2025 13:41:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Peter Xu
 <peterx@redhat.com>,
 qemu-devel@nongnu.org,  farosas@suse.de,  peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
In-Reply-To: <aSbr--ZbqzKVNDuC@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 26 Nov 2025 12:00:59 +0000")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
 <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
 <c0aa79ad-d6f4-413f-ade6-43e7609e37ac@redhat.com>
 <87ecplc8yn.fsf@pond.sub.org> <aSbr--ZbqzKVNDuC@redhat.com>
Date: Wed, 26 Nov 2025 13:41:41 +0100
Message-ID: <87v7ixarui.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Wed, Nov 26, 2025 at 12:46:40PM +0100, Markus Armbruster wrote:

[...]

>> Don't worry about it!  From my point of view, the process worked okay.
>> A big series got reviewed by maintainers, except for one little patch
>> touching another subsystem, where that subsystem's maintainer (me)
>> remained silent.  The series was then merged without further delay.
>>=20
>> Would I have appreciate a timely nudge on that little patch?  Sure.  Is
>> not nudging me a failure of sorts?  Nope.
>
> The other thing that plays in here is that we actively encourage use of
> g_autoptr everywhere.

We do, and for good reasons.

>                       It is very unusual for "Error" to be a type that
> does NOT want g_autoptr, and thus the mistake is very much on the cards.
>
> I've proposed it before myself & Markus caught it. I also caught one
> other proposals to add it since my attempt. This third time it slipped
> through review. I expect we'll see a 4th attempt to add it at some point.

%-}


