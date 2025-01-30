Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE27C0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 14:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdVU1-0006sT-Ug; Thu, 30 Jan 2025 09:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tdVTz-0006rS-3j
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tdVTx-0000SE-Bm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738247122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXPTT1/MPlCjPMkpkTwEDTSKl8MPoKCI3dKlcc6iGqY=;
 b=ISaCN0Z/MpeFc39gRRqKEESMq1YjF+/aIL8XVHVbgBqOcem61fLNc8eDr/oRkc5N2mnoSv
 hWdqlWdpGhzjiQoXgzdqmP68Jj4TEjG2Bx88qFQn0ILRyipide8Dzk6fKGqnZ2dw/Vw3dD
 PyYsEem5Ep/udeR3Lqun3BjaXneBANk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-IByZWIl_Pp2pDxYTFPLUiw-1; Thu,
 30 Jan 2025 09:25:20 -0500
X-MC-Unique: IByZWIl_Pp2pDxYTFPLUiw-1
X-Mimecast-MFC-AGG-ID: IByZWIl_Pp2pDxYTFPLUiw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5CE1801F1F
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:25:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.71])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5C2A18008F4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E5E021E6A28; Thu, 30 Jan 2025 15:25:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/9] util/error: Introduce warn_report_once_err()
In-Reply-To: <20250130134346.1754143-2-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Thu, 30 Jan 2025 14:43:38 +0100")
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-2-clg@redhat.com>
Date: Thu, 30 Jan 2025 15:25:16 +0100
Message-ID: <87msf8xttf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> Depending on the configuration, a passthrough device may produce
> recurring DMA mapping errors at runtime and produce a lot of
> output. It is useful to report only once.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/qapi/error.h | 5 +++++
>  util/error.c         | 9 +++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 71f8fb2c50eee9a544992d0c05263c9793956fe1..b6ea274882b9788b64d4bb213=
c3458d7c674a881 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -448,6 +448,11 @@ void error_free_or_abort(Error **errp);
>   */
>  void warn_report_err(Error *err);
>=20=20
> +/*
> + * Convenience function to call warn_report_err() once.
> + */
> +void warn_report_once_err(Error *err);
> +
>  /*
>   * Convenience function to error_report() and free @err.
>   * The report includes hints added with error_append_hint().
> diff --git a/util/error.c b/util/error.c
> index e5e247209a9e0796074a9794f5598325f22f8d35..b8a211cccaa609a93091b8631=
6144a0ad0a02662 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -247,6 +247,15 @@ void warn_report_err(Error *err)
>      error_free(err);
>  }
>=20=20
> +void warn_report_once_err(Error *err)
> +{
> +        static bool print_once_;
> +        if (!print_once_) {
> +            warn_report_err(err);
> +            print_once_ =3D true;
> +        }
> +}

Any particular reason for the trailing _ in @print_once_?

The first warning suppresses all subsequent warnings, even if they're
completely different.  PATCH 5 uses this to emit a (rather cryptic)
warning about unexpected mappings once.  If we later add another use
elsewhere, these uses will suppress each other.  Is this what we want?

The related function warn_report_once_cond() takes the flag as a
parameter.  Only the calls using the same flag suppress each other.

> +
>  void error_reportf_err(Error *err, const char *fmt, ...)
>  {
>      va_list ap;


