Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8924AD29DF0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaKC-0004Dh-46; Tue, 13 Jan 2026 04:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfaK8-0004Af-G5
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfaK7-0005SG-3g
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768295062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8Bj1cPBbkXfFCwtKKTyzWwDQn6lMBjXkZH37hqQwH0=;
 b=FRJpv6oy49zUZOF9fLqjunK/IBMr5G+YKamkzPG1Lq5DDldB7CbbTvAlx9AnybJhrBHZLj
 OCM8Z/FK/XRgDEWb9JlVXvUu92iPc8bHT6Hydun6s7DM8utyPzkQnnQI4d+qdWMb2ifRBD
 EWtF6lD26rwmGvWM6gHCJ4/VaZKnROo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-f9zTZFoJO_SmINoWE69ojg-1; Tue,
 13 Jan 2026 04:04:16 -0500
X-MC-Unique: f9zTZFoJO_SmINoWE69ojg-1
X-Mimecast-MFC-AGG-ID: f9zTZFoJO_SmINoWE69ojg_1768295055
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79BB318005BD; Tue, 13 Jan 2026 09:04:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C5FA1956048; Tue, 13 Jan 2026 09:04:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6E5621E66C9; Tue, 13 Jan 2026 10:04:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Manos
 Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Stefan Weil <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 02/24] include: define constant for early constructor
 priority
In-Reply-To: <6e60a89f-6798-4ea5-bbd0-553130786cec@redhat.com> (Paolo
 Bonzini's message of "Fri, 9 Jan 2026 13:09:23 +0100")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-3-berrange@redhat.com>
 <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
 <aWDqie0eYZ8GeQHF@redhat.com>
 <6e60a89f-6798-4ea5-bbd0-553130786cec@redhat.com>
Date: Tue, 13 Jan 2026 10:04:10 +0100
Message-ID: <87h5spc29h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/9/26 12:46, Daniel P. Berrang=C3=A9 wrote:
>> IMHO the root problem is that it is pretty dubious for us to be
>> spawning the RCU thread from a constructor. Constructors should
>> be limited to minimal initialization of state.

Yes!  Discussed in review of v3:

    https://lore.kernel.org/qemu-devel/87frck1dds.fsf@pond.sub.org/
    Message-ID: <87frck1dds.fsf@pond.sub.org>

>>                                                Spawning threads
>> is outside the boundary of what I'd consider reasonable for
>> a constructor todo. I didn't want try to tackle refactoring the
>> RCU thread creation though, hence this gross workaround.
>
> I see.  Maybe we could (just as gross but smaller) do the RCU constructor=
 late.  Not something that you need to do now, of course.

Could we use an old-fashioned initialization function instead of a
constructor for RCU?


