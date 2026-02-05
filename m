Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B54CE9126B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 06:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntEb-0001Up-Gj; Thu, 05 Feb 2026 01:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vntEZ-0001UH-AT
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vntEX-0005Qw-R5
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 01:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770274376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWQd6QSFUfpNl3GDcFOR4CivMR1BYTZ0sfNA32/j+ww=;
 b=WMRmUodVcJF14QqxCLNP5YWhbFUkgJO0m6fLbKwd0xctmRE/tllXUQbTGKueLl1IPH8gu9
 TGAakAOlQWre3g5+81qqnGS1m7tVTYma4DNI+cfoECOICMr8PFLyzEN8sZtk6tofRaktLt
 owBRIuaV2IFzBz+o6iWwgt84vCcfXDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-YTIde_t7M6SL1heNcYoUzQ-1; Thu,
 05 Feb 2026 01:52:53 -0500
X-MC-Unique: YTIde_t7M6SL1heNcYoUzQ-1
X-Mimecast-MFC-AGG-ID: YTIde_t7M6SL1heNcYoUzQ_1770274371
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23CE31955F21; Thu,  5 Feb 2026 06:52:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B85F19560B0; Thu,  5 Feb 2026 06:52:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FE8321E692D; Thu, 05 Feb 2026 07:52:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  kvm <kvm@vger.kernel.org>,  Helge Deller
 <deller@gmx.de>,  Oliver Steffen <osteffen@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  German Maglione
 <gmaglione@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: Modern HMP
In-Reply-To: <aYPvN5fphSObsvGR@gallifrey> (David Alan Gilbert's message of
 "Thu, 5 Feb 2026 01:15:35 +0000")
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org> <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org> <aXIWLi656H8VbrPE@redhat.com>
 <87ikctk5ss.fsf@suse.de> <aXJJkd8g0AGZ3EVv@redhat.com>
 <aX-boauFX2Ju7x8Z@gallifrey> <875x8d0w32.fsf@pond.sub.org>
 <aYPvN5fphSObsvGR@gallifrey>
Date: Thu, 05 Feb 2026 07:52:48 +0100
Message-ID: <87ms1nu1fj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

[...]

> I did see you suggesting for Rust for it; which would work - although
> given it wouldn't be performance sensitive, Python would seem reasonable.

Marc-Andr=C3=A9 suggested "Python or Rust (student choice)".

Daniel argued for Rust "as it allows the possibility to embed that Rust
impl inside the current QEMU binaries, to fully replace the C code and
retain broadly the same functionality."

If we're not interested in such embedding, then Python feels preferable
to me, because I'd expect it to get us to the finish line faster.


