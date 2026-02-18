Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D606BE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdlY-0002dt-BK; Wed, 18 Feb 2026 04:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsdlV-0002dX-Kg
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsdlU-0001Eq-4o
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771406555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTlZjec8Xj50tOBIWaRuloxUrOk6quVKUPSrTApi8+Y=;
 b=MgHAhJROam6syDVp8BI24llmRNKtv9XUymkMpJG7QYG+SdQVhrEZN0Fd4M5UgKaQGjKUON
 YfFXN8E/hLcOXsJlXNvhZkE5LSZeJmOhhwTNi/U/XE/ch3yu20fCSHGcp+5CP6kA8JeDvC
 agovjvz2dWhfIRHg2ntspvLOznl3Vls=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-bkfG5EEROLOSXxl39HcyZg-1; Wed,
 18 Feb 2026 04:22:32 -0500
X-MC-Unique: bkfG5EEROLOSXxl39HcyZg-1
X-Mimecast-MFC-AGG-ID: bkfG5EEROLOSXxl39HcyZg_1771406551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E55195608A; Wed, 18 Feb 2026 09:22:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC2C91800361; Wed, 18 Feb 2026 09:22:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C37321E692D; Wed, 18 Feb 2026 10:22:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 03/27] include: define constant for early constructor
 priority
In-Reply-To: <20260211152508.732487-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:24:44
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-4-berrange@redhat.com>
Date: Wed, 18 Feb 2026 10:22:27 +0100
Message-ID: <87342yflt8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Functions marked with __attribute__((__constructor__)) will be
> invoked in linker order. In theory this is well defined, but
> in practice, it is hard to determine what this order will be
> with the layers of indirection through meson, ninja and the
> static libraries QEMU builds.
>
> Notably, the order currently appears different between Linux
> and Windows (as tested with Wine on Linux). This can cause
> problems when certain QEMU constructors have a dependancy on
> other QEMU constructors.
>
> To address this define a QEMU_CONSTRUCTOR_EARLY constant which
> provides a priority value that will run before other default
> constructors. This is to be used for QEMU constructors that
> are themselves self-contained, but may be relied upon by other
> constructors.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I'm no fan of doing non-trivial work in constructors.  We discussed
possible alternatives in review of v5.  This is an opinion, not a
demand.  And Paolo's opinion counts a lot more here.

> ---
>  include/qemu/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1c2b673c05..4c49f52eb0 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -194,6 +194,14 @@
>  # define QEMU_USED
>  #endif
>=20=20
> +/*
> + * A priority for __attribute__((constructor(...))) that
> + * will run earlier than the default constructors. Must
> + * only be used for functions that have no dependency
> + * on global initialization of other QEMU subsystems.
> + */
> +#define QEMU_CONSTRUCTOR_EARLY 101
> +
>  /*
>   * Disable -ftrivial-auto-var-init on a local variable.
>   *


