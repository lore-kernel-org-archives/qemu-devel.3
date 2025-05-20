Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB43C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJF6-0000x9-SX; Tue, 20 May 2025 05:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHJF2-0000wR-V4
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHJF0-0002Ym-2Y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747733188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdom4s2g68/2aUxlGAaVlfbhcGOpCsqCpRq5HVJ8dXY=;
 b=K5j93DgNH/WO/iAlOo9DDcs03rEAOskxIxNW8yA+F0H3ktnEDYxhwoaqpVhCvRd4gLjwjB
 rH0g1FGZt6axQzguhI0H0fzBU0N3lmwX5WSHu+HWa73ni5tnrCbvPLI/kUagGAFA9Me/Z8
 2IuL7sa7/KRfOKSOEe5qV9XwU9oDg6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-07UJJnyrOQu4hR6Kwn4mIA-1; Tue,
 20 May 2025 05:26:23 -0400
X-MC-Unique: 07UJJnyrOQu4hR6Kwn4mIA-1
X-Mimecast-MFC-AGG-ID: 07UJJnyrOQu4hR6Kwn4mIA_1747733181
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C824C19560AF; Tue, 20 May 2025 09:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E521C1956096; Tue, 20 May 2025 09:26:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 570BE21E66C3; Tue, 20 May 2025 11:26:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  qemu-rust@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,  Cleber Rosa
 <crosa@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 4/8] python: use 3.9+ builtin type hints
In-Reply-To: <20250519182153.3835722-5-jsnow@redhat.com> (John Snow's message
 of "Mon, 19 May 2025 14:21:48 -0400")
References: <20250519182153.3835722-1-jsnow@redhat.com>
 <20250519182153.3835722-5-jsnow@redhat.com>
Date: Tue, 20 May 2025 11:26:16 +0200
Message-ID: <87wmabab0n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> This patch changes type hints that have built-in equivalents as of
> Python 3.9. The versions we currently use, imported from the typing
> module, have been deprecated since 3.9 and may be removed at any time -
> though to my knowledge, they are not scheduled for removal in 3.14.
>
> The type hints to update are:
>
> typing.Dict  => dict
> typing.List  => list
> typing.Tuple => tuple
> typing.Set   => set
> typing.Type  => type
>
> I performed this change the dumb way (I couldn't work out for the life
> of me how to beg ls-files to exclude subprojects and empty directories,
> desipte it having an option which claims to do precisely that. Suggest a
> nicer way to do this if you'd like.)
>
> git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Dict\[/dict\[/g'
> git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/List\[/list\[/g'
> git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Tuple\[/tuple\[/g'
> git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Set\[/set\[/g'
> git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Type\[/type\[/g'
>
> I then used "git add -p" and excluded changes by hand that weren't
> appropriate. I then reviewed all of the changed files by hand to review
> the imports and update them accordingly.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I'd expect to catch mistakes in the manual parts.  I gave scripts/qapi/
an eye-over anyway, and it looks good to me.

Acked-by: Markus Armbruster <armbru@redhat.com>


