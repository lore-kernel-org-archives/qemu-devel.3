Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24979C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPgv-000680-Vr; Mon, 24 Aug 2026 04:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyPgt-00067k-Nz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyPgr-0003CE-Nv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 04:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787558756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qyq6kC/kviYMtpN9WWdWZDTLtYVXJoZzQPLXwGKkC+8=;
 b=aYahmNiERxi+kuR18xU/jkafOv0eaJrusu//nDLAzr/lO2FcchZOwH8wrWj/Dw2drd9He8
 aQ1ucsQmS3bhiANdmkGep8orENGPSwRGzmQSMClVGThXgeNdCnV79iIauQzhPZZ6Eh69KB
 xl0DLdJ02N3R1qkXuZResy6PIYXMTo8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-WAUtoqI9MhuLe-usDvL4aw-1; Mon,
 24 Aug 2026 04:05:51 -0400
X-MC-Unique: WAUtoqI9MhuLe-usDvL4aw-1
X-Mimecast-MFC-AGG-ID: WAUtoqI9MhuLe-usDvL4aw_1787558750
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3330D180B5E9; Mon, 24 Aug 2026 08:05:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D6231955F09; Mon, 24 Aug 2026 08:05:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E4B221E6920; Mon, 24 Aug 2026 10:05:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Kohei Tokunaga
 <ktokunaga.mail@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Cleber Rosa <crosa@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH 04/12] qapi: update type hint for types_seen
In-Reply-To: <20260824052859.880475-5-jsnow@redhat.com> (John Snow's message
 of "Mon, 24 Aug 2026 01:28:50 -0400")
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-5-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 10:05:46 +0200
Message-ID: <87ld9wt02t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> In preparation for upgrading Python to 3.12+, adjust the type hint on
> types_seen to prevent mypy from chirping about an unknown type for
> this variable.
>
> Why didn't this trigger earlier? A mystery for the ages.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/types.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index 2bf75338283..b87377c6474 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -34,7 +34,7 @@
>  
>  # variants must be emitted before their container; track what has already
>  # been output
> -objects_seen = set()
> +objects_seen: set[str] = set()
>  
>  
>  def gen_enum_lookup(name: str,

Reviewed-by: Markus Armbruster <armbru@redhat.com>


