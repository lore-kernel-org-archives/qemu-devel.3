Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F972C61CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wykrG-0000z6-Tw; Tue, 25 Aug 2026 02:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wykrF-0000ys-ST
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wykrE-0002GU-Bh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787640122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvJzgKEXkLQBeQw9rRPHTaqz0POzJq073AaKPoTBdlA=;
 b=YDstVCg8FiUJSB2+zHn5zicFVtJaIcqU3tLbRP6NDkQi0iDmglsmt4NB2bN9IMmlo1f9Nk
 +r5otkbPIMLHnu0HYB0rj8UtBrOulck6u93gjESPrOyOdDw8O7M2rvZk5AnV4c2kT0AfGJ
 mPrVBlc794XMX3MnywKbByg6psnX3QU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-HnSdXt3pPYCcAGgPFfe5zQ-1; Tue,
 25 Aug 2026 02:41:59 -0400
X-MC-Unique: HnSdXt3pPYCcAGgPFfe5zQ-1
X-Mimecast-MFC-AGG-ID: HnSdXt3pPYCcAGgPFfe5zQ_1787640117
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E3CD185FEF7; Tue, 25 Aug 2026 06:41:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E0C6422; Tue, 25 Aug 2026 06:41:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2DC721E6920; Tue, 25 Aug 2026 08:41:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@mailo.com>,  Warner Losh <imp@bsdimp.com>,  Kohei Tokunaga
 <ktokunaga.mail@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Reinoud Zandijk
 <reinoud@netbsd.org>,  Kyle Evans <kevans@freebsd.org>,  Michael Roth
 <michael.roth@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 01/16] tests: update vm tests to prefer locally-built
 QEMU
In-Reply-To: <20260825051441.1562454-2-jsnow@redhat.com> (John Snow's message
 of "Tue, 25 Aug 2026 01:14:26 -0400")
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-2-jsnow@redhat.com>
Date: Tue, 25 Aug 2026 08:41:53 +0200
Message-ID: <87v78ypuq6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> In 05e4982, we updated our QMP tests to prefer `-object monitor-qmp`,
> but this requires a sufficiently recent and modern version of QEMU to
> run correctly.

So, some tests run incorrectly, and this patch fixes them.  Which ones
and how?  What broke them?  Commit 05e4982?  Is it worth a Fixes: tag?

> Update the "make vm-run-xxx" targets to use the runscript that will
> naturally prefer the locally built version of QEMU so that these tests
> launch successfully once more.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/vm/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 0a53dc9fdd6..0ec1b47e63e 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
>  VM_PYTHON = $(SRC_PATH)/vm-venv/bin/python3
>  VM_VENV = vm-venv
>  else
> -VM_PYTHON = $(PYTHON)
> +VM_PYTHON = $(BUILD_DIR)/run $(PYTHON)
>  VM_VENV =
>  endif


