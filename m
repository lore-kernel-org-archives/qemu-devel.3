Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD7EC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MSr-0003q6-Hf; Mon, 14 Apr 2025 12:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4MSp-0003pe-Ks
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u4MSi-0001Es-Eg
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744647305;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NVS5qRAf9oXldc5/DZALc+aohaGCAkevolsgsbWit0=;
 b=RJ/DvZhpsAjx80hmIRNyH7bxL+huXPoEPp/TodcCVvw1xr7lD0fw6pVbe1vl7CSr5r4H2i
 7v5QZRVRQ1ZIobX3uB8vpfzGFUB08909aHe2QCl5vH4NyxGixCDq33+mQOCYSYMN5cDv+f
 eEYLWpGXz/gW5WNGWcJu+JZFphtRog0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-TaFcndToNgezXlhI17AO-Q-1; Mon,
 14 Apr 2025 12:14:59 -0400
X-MC-Unique: TaFcndToNgezXlhI17AO-Q-1
X-Mimecast-MFC-AGG-ID: TaFcndToNgezXlhI17AO-Q_1744647297
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1506E1955DCF; Mon, 14 Apr 2025 16:14:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 489D31808867; Mon, 14 Apr 2025 16:14:53 +0000 (UTC)
Date: Mon, 14 Apr 2025 17:14:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [RFC 0/2] python: integrate linter tests natively with meson
Message-ID: <Z_00erYFFJ0EPMFa@redhat.com>
References: <20250224191152.2123003-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224191152.2123003-1-berrange@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Ping: would like to hear John's thoughts on this series.

We're likely to eliminate usage of avocado for functional testing
in this dev cycle. That leaves python testing as the main outstanding
bit of QEMU that is not natively using meson's test integration and
also still pulling in avocado as a dependency.

On Mon, Feb 24, 2025 at 07:11:50PM +0000, Daniel P. Berrangé wrote:
> It seems everytime I post some new patches which touch python code I
> end up forgetting to run the extra non-default 'make check' target from
> the python/ subdir.
> 
> IMHO, if we're going to pick up on linter failures in review feedback
> (which is a reasonable thing to want to do), then we should be running
> these linters by default in 'make check'.
> 
> This RFC is demonstrating a possible strategy to achieve that, by making
> the python tests use meson in the same way as everything else, instead
> of being stuck in the old 'make' world. In keeping with our work to
> remove use of avocado for functional testing, this also removes avocado
> for python linters since IMHO it adds no notable value over what meson
> provides already.
> 
> See last patch for the interesting stuff, and the various caveats about
> this initial PoC.
> 
> Being a PoC this is minimally tested beyond 'make check' on my local
> machine.
> 
> Daniel P. Berrangé (2):
>   python: be more selective in hiding mypy subclassing warning
>   python: integrate linter tests natively with meson
> 
>  meson.build                   |  1 +
>  python/meson.build            | 43 +++++++++++++++++++++++++++++++++++
>  python/qemu/qmp/qmp_tui.py    | 12 +++++-----
>  python/qemu/utils/qom_fuse.py |  2 +-
>  python/scripts/__init__.py    |  0
>  python/setup.cfg              |  8 -------
>  scripts/meson.build           |  9 ++++++++
>  tests/meson.build             |  1 +
>  tests/python/meson.build      | 17 ++++++++++++++
>  9 files changed, 78 insertions(+), 15 deletions(-)
>  create mode 100644 python/meson.build
>  create mode 100644 python/scripts/__init__.py
>  create mode 100644 tests/python/meson.build
> 
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


