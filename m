Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F429E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt0xw-0006lG-DV; Thu, 19 Feb 2026 05:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt0xu-0006kY-LF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt0xs-0007GH-OP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771495735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJWtWOij5kqJDGKkuNkM74Y6CD4Ke1WY1t4YFenkbec=;
 b=ITHHCY1Yxjwnhu3JAHTefxj03BYuXv91aB/7h2dXD6gDOqA1hSCrx7Cd4+VEQfr1ZUHb7G
 GaSU+DQ5lUS7JWnZ6lKkb+QD8qHKo+fBnFbxSXDqCBYLqY8OyrSO4rQZaISaXcYuyfU27s
 4j/KBmt4yrc2wVX1JlUoIqVWjIG3sLY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-gbiC7Y9AOxq9_cevmG1lTA-1; Thu,
 19 Feb 2026 05:08:52 -0500
X-MC-Unique: gbiC7Y9AOxq9_cevmG1lTA-1
X-Mimecast-MFC-AGG-ID: gbiC7Y9AOxq9_cevmG1lTA_1771495730
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FDAF195605F; Thu, 19 Feb 2026 10:08:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72553195410F; Thu, 19 Feb 2026 10:08:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EFEAB21E692D; Thu, 19 Feb 2026 11:08:45 +0100 (CET)
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
Subject: Re: [PATCH v6 25/27] util: add support for formatting a program
 name in messages
In-Reply-To: <20260211152508.732487-26-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:25:06
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-26-berrange@redhat.com>
Date: Thu, 19 Feb 2026 11:08:45 +0100
Message-ID: <87ikbt3v0y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

> The error_report function can include the program name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
>
> This introduces support for a "program name" in the new
> messages API, which will be included by default for all
> binaries.
>
> This change tweaks the output of the error_report function,
> adding a space between the program name and the location
> info.

Why?

>       The qemu_log function will gain the program name. This
> can be easily seen with the 'log' trace backend, and how it
> is now more closely matching error_report output.
>
> Before:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*'
>   qcrypto_tls_creds_x509_load TLS creds x509 load creds=3D0x5584e13937f0 =
dir=3Dfish
>   qcrypto_tls_creds_get_path TLS creds path creds=3D0x5584e13937f0 filena=
me=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No s=
uch file or directory
>
> After:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*'
>   qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load cre=
ds=3D0x5584e13937f0 dir=3Dfish
>   qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=3D0=
x5584e13937f0 filename=3Dca-cert.pem path=3D<none>
>   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No s=
uch file or directory
>
> When adding this the '-msg program-name=3Don|off' option is
> introduced, so that the program name (which is enabled by
> default) can be supressed if desired. This could be useful
> if '-msg guest-name=3Don' is being used as a more informative
> identifier.

Separate patch?

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


