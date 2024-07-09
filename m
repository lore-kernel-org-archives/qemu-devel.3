Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755BCC3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRATM-0001CR-0H; Tue, 09 Jul 2024 09:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRATJ-00014l-Rg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRATD-0002e5-TI
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720530082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Du6Od1hWjhWepfbyhXJIxhemny6Uu/GuFkfcOPvqQYk=;
 b=BFq+6Y6+p7iz51jXTBlCcK9SFfjhBK2/MsSVoVNp/bhsbH8StOmLHLcoZ16kHWJEv5oMph
 ZUkops7H37rnhNhDpykt+6EV615E3HnZYHKTMQq0vMQ2O/BazjbFr/M50P52wbalq+p7tT
 ZWDkFzoFsBYvrALDtR34n5JYKExvoOg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-4PGu2CthMH-U4Y-fjefjjw-1; Tue,
 09 Jul 2024 09:01:14 -0400
X-MC-Unique: 4PGu2CthMH-U4Y-fjefjjw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 400E619541BA; Tue,  9 Jul 2024 13:01:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B50A11955DD9; Tue,  9 Jul 2024 13:00:59 +0000 (UTC)
Date: Tue, 9 Jul 2024 14:00:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
Message-ID: <Zo00iKKtRRDTTslY@redhat.com>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 09, 2024 at 02:28:38PM +0200, Paolo Bonzini wrote:
> On Tue, Jul 9, 2024 at 2:09 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >  * what is the actual baseline requirement? We definitely want
> >    to support "using rustup on an older system" (should be no
> >    problem) and "current distro building QEMU using the distro's
> >    rust", I assume. It would certainly be nice to have "building
> >    QEMU on the older-but-still-in-our-support-list distro releases
> >    with that distro's rust", but this probably implies not just
> >    a minimum rust version but also a limited set of crates.
> 
> I don't think limiting ourselves to the set of crates in the distro is
> feasible. It's not the way the language works, for example I tried
> checking if the "cstr" crate exists and I didn't find it in Debian.

Yep, Rust is new enough that it is highly likely that crates will be
missing in multiple distros.

For ordinary users, cargo will happily download the missing pieces
so its not an issue.

For distro packagers, they'll just have to either package up the crates,
or bundle them in their QEMU build. Cargo makes the latter easy at
least. If distros don't want bundling, they'll need to go the more
involved route of packaging deps.

IOW, from a distro POV, IMHO, we should focus on the Rust toolchain
versions we need as the minimum bar.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


