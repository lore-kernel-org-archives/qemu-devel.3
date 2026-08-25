Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F8C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6n-0000pe-Qe; Tue, 25 Aug 2026 07:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyp6m-0000p8-DY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyp6k-00007P-Pr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787656461;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8cTuUI/M3NLP2OCEpciGBQHnvW9S1hBngiHqUklPR4=;
 b=XZA/vlc7SyF45vXhI0R856s0VI29hATg/58qEueTiuHZlEE/uH/hjwwUfLRa/xb8S0ywp2
 nCp4GlBdF7AKsQhUh6jJKKHugEz4swR/rJPmi//YQX4HSVLBrSm6R6Tl680T3nQMEHb8lp
 pccn0eAm0ULVioSQOXBhm97N/FUup3Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-cleveUJUMuanqX9Y8l5bwQ-1; Tue,
 25 Aug 2026 07:14:18 -0400
X-MC-Unique: cleveUJUMuanqX9Y8l5bwQ-1
X-Mimecast-MFC-AGG-ID: cleveUJUMuanqX9Y8l5bwQ_1787656456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86CEF195DE60; Tue, 25 Aug 2026 11:14:16 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E26D1955F08; Tue, 25 Aug 2026 11:14:12 +0000 (UTC)
Date: Tue, 25 Aug 2026 12:14:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 09/16] python: upgrade to Python3.12+
Message-ID: <ao15Aa0wdf6PVAYR@redhat.com>
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-10-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825051441.1562454-10-jsnow@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 25, 2026 at 01:14:34AM -0400, John Snow wrote:
> With Python3.9 EOL and Python3.10 soon to be EOL (October 2026), and
> with ... no other supported build platform actually using Python 3.11,
> require the use of Python3.12 or later.
> 
> Additionally, as part of this upgrade, remove the use of tomllib from
> mkvenv as it is now standard in the Python stdlib: leaving this
> transitional code in causes a regression with mypy which becomes
> confused about the overloaded use of 'tomllib'.
> 
> Our current minimum requirements as determined by standard repository
> packages on supported distributions is as follows:
> 
> distro            EOS         python3  pip     setuptools  sphinx  wheel
> -------------------------------------------------------------------------
> centos_stream_9   2026-12-12  3.9.25   21.3.1  53.0.0      3.4.3   0.36.2
> centos_stream_9+  2026-12-12  3.12.13  23.2.1  68.2.2      ---     0.41.2
> freebsd           --          3.12.14  23.3.2  63.1.0      9.0.4   0.48.0
> ubuntu_24_04      2028-04-23  3.12.3   24.0    68.1.2      7.2.6   0.42.0
> centos_stream_10  2030-01-01  3.12.13  23.3.2  69.0.3      7.2.6   0.41.2
> alpine_3_21       2026-11-01  3.12.14  24.3.1  70.3.0      8.1.3   0.43.0
> debian_13         2028-08-09  3.13.5   25.1.1  78.1.1      8.1.3   0.46.1
> fedora_43         2026-12-09  3.14.7   25.1.1  78.1.1      8.2.3   0.45.1
> ubuntu_26_04      2031-05-29  3.14.4   25.1.1  78.1.1      8.2.3   0.46.3
> fedora_44         2027-06-02  3.14.7   26.0.1  80.10.2     8.2.3   0.45.1
> macports          --          3.14.7   26.0.1  80.10.2     9.1.0   0.48.0
> alpine_3_22       2027-05-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3
> alpine_3_23       2027-11-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3
> openbsd           --          3.14.6   26.2.1  80.9.0      9.1.0   0.48.0
> alpine_3_24       2028-06-01  3.14.7   26.1.2  82.0.1      9.1.0   0.47.0
> pkgsrc_current    --          3.13.15  26.2.1  84.0.0      9.1.0   0.48.0
> 
> CentOS stream 9 note: python3.12, python3.12-pip,
> python3.12-setuptools and python3.12-wheel are available as optional
> packages in the standard repository. Sphinx is not available, but can
> be side-loaded from PyPI using pip3.12.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  configure                | 11 ++++---
>  python/Makefile          | 10 +++----
>  python/scripts/mkvenv.py | 63 ++++------------------------------------
>  python/setup.cfg         | 17 ++++-------
>  python/tests/minreqs.txt | 41 ++++++++++++--------------
>  pythondeps.toml          |  9 ++----
>  6 files changed, 43 insertions(+), 108 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


