Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E46C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXRC-0000H0-Du; Wed, 07 May 2025 01:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCXRA-0000Gq-M4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCXR9-0003Cs-3m
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746596116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4x+1/5Eo/Y7WQtRO2ysyT2YXhKNX42md/QhevOUiBg=;
 b=FcqIi4kBdCzjjlgHGGLPUzdkSKBLO0a+m+nuLPlXVHXVIMYxEMHfe6ZyOZI5wOgyw4l03e
 Wpnlsj8AhCcOamvHX7eXxAW5WfZZ9aIec51pZnl3yYPqxel3ORyMkXiX+nrvhZj/Pmq0zN
 vs6JcRqNvlw13jtoxsstrpg0PeoV3qQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-KKpcIGWAP6CAiIGX1raixg-1; Wed,
 07 May 2025 01:35:13 -0400
X-MC-Unique: KKpcIGWAP6CAiIGX1raixg-1
X-Mimecast-MFC-AGG-ID: KKpcIGWAP6CAiIGX1raixg_1746596112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B5251805ECE; Wed,  7 May 2025 05:35:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B23C61800368; Wed,  7 May 2025 05:35:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33CB221E66C9; Wed, 07 May 2025 07:35:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Michael
 Roth <michael.roth@amd.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] Drop support for Python 3.8
In-Reply-To: <CAFn=p-Y3xOo95XMRNC-pSrcoD6858bkzu0cpCUqXn1MZs1vAmA@mail.gmail.com>
 (John Snow's message of "Tue, 6 May 2025 15:49:38 -0400")
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
 <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
 <875ximdj2i.fsf@pond.sub.org>
 <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
 <67ceeed9-75e1-489d-a750-dcf1beac703f@redhat.com>
 <CAFn=p-Y3xOo95XMRNC-pSrcoD6858bkzu0cpCUqXn1MZs1vAmA@mail.gmail.com>
Date: Wed, 07 May 2025 07:35:09 +0200
Message-ID: <87wmatm19u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, May 6, 2025 at 10:17=E2=80=AFAM Thomas Huth <thuth@redhat.com> wr=
ote:
>
>> On 06/05/2025 00.49, John Snow wrote:
>> ...
>> > If there are no objections to moving to 3.9 as the minimum, I certainly
>> > don't mind. Go right ahead and I'll clean up afterwards as part of my
>> > "delint qapi" series in which I'd like to fix quite a few other things=
 that
>> > are currently wonky. In fact, moving to 3.9 as a minimum might make al=
l of
>> > that much easier for me and allow deeper cleanings.
>>
>>   Hi John!
>>
>> It has just been merged:
>>
>
> Yay! Thanks a lot for doing this. I lost my appetite for arguing for Pyth=
on
> version bumps, but when other people do it, I am always cheering :) Sorry
> to have been MIA while you were submitting this.

I'm cheering, too!

Supporting a wide range of Python versions has been costly.  Most
recently, it made John write docs/sphinx/compat.py, which looks like
every line of code there was bought with blood, sweat, and tears.

[...]


