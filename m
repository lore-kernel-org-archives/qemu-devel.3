Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1BCE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt15u-0000mu-SI; Thu, 19 Feb 2026 05:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt15r-0000kN-BN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vt15p-0008MX-HR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771496228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNbkZ2GAB+qliN/AEGyE0l6Bc+7o17g2sPOW7LT8/Bs=;
 b=L/HLUzUGmHHBbfAZgTquWSwyrYVV8FXr1JfKBerTPr8NPHNXNF6ya5YPPMQhlz9MEyIWuV
 MvGJbZhZ27Suo2pu35+jZjL1iVFV9x8uJOC7gH4aLPQgu7bn9JIciNOIxUoO2vs7N53IHv
 wJO9DlAp2Muce0jr3gSLISkIiyVEiFg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-rAP4gi25M_W4Zo62fmuGeg-1; Thu,
 19 Feb 2026 05:17:05 -0500
X-MC-Unique: rAP4gi25M_W4Zo62fmuGeg-1
X-Mimecast-MFC-AGG-ID: rAP4gi25M_W4Zo62fmuGeg_1771496223
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47E0C195609E; Thu, 19 Feb 2026 10:17:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB4C1954111; Thu, 19 Feb 2026 10:17:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB7B021E692D; Thu, 19 Feb 2026 11:16:59 +0100 (CET)
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
Subject: Re: [PATCH v6 27/27] util: add brackets around guest name in
 message context
In-Reply-To: <20260211152508.732487-28-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:25:08
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-28-berrange@redhat.com>
Date: Thu, 19 Feb 2026 11:16:59 +0100
Message-ID: <87a4x53un8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> The message context can optionally include the guest name if the
> argument '-msg guest-name=3Don' is given. The formatting, however,
> does not look good if the guest name contains whitespace. Change
> the output to include square brackets to demarcate the name.
>
> Before:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*' -msg guest-name=3Don -name "fish food"
>   fish food qemu-system-x86_64: (1146846:main): qcrypto_tls_creds_x509_lo=
ad TLS creds x509 load creds=3D0x55657e94e690 dir=3Dfish
>   fish food qemu-system-x86_64: (1146846:main): qcrypto_tls_creds_get_pat=
h TLS creds path creds=3D0x55657e94e690 filename=3Dca-cert.pem path=3D<none>
>   fish food qemu-system-x86_64: (1146846:main): Unable to access credenti=
als fish/ca-cert.pem: No such file or directory
>
> After:
>
>   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 'trac=
e:qcrypto*' -msg guest-name=3Don -name "fish food"
>   [fish food] qemu-system-x86_64: (1144713:main): qcrypto_tls_creds_x509_=
load TLS creds x509 load creds=3D0x5604ada2c950 dir=3Dfish
>   [fish food] qemu-system-x86_64: (1144713:main): qcrypto_tls_creds_get_p=
ath TLS creds path creds=3D0x5604ada2c950 filename=3Dca-cert.pem path=3D<no=
ne>
>   [fish food] qemu-system-x86_64: (1144713:main): Unable to access creden=
tials fish/ca-cert.pem: No such file or directory
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/message.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/util/message.c b/util/message.c
> index 9bf640c8c4..73af8e8ca4 100644
> --- a/util/message.c
> +++ b/util/message.c
> @@ -29,8 +29,9 @@ void qmessage_context_print(FILE *fp)
>=20=20
>      if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
>          message_workloadname) {
> +        fputc('[', fp);
>          fputs(message_workloadname, fp);
> -        fputc(' ', fp);
> +        fputs("] ", fp);

Again, I'd go for

           fprintf(fp, "[%s] ", message_workloadname);

>      }
>=20=20
>      if (message_format & QMESSAGE_FORMAT_PROGRAM_NAME) {


