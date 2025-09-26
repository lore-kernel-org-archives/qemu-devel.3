Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3B9CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 04:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20XC-0007np-Mp; Fri, 26 Sep 2025 00:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v20XA-0007m6-8F
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 00:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v20X3-0003Qp-QM
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 00:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758862684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSkjQd3PDBRYXbiVyth/iIFTSC5QCLVgiTvyQtsZToU=;
 b=Z4XDFgL1ZwYWKdus5mJR3iehbLKN2Z75iotYFGoglGSdwH1Mt008LB6fUUdmgOLp62uvFh
 VjcKqWhRL9hIws+zSOTWD259xEL3TaIygB0v29q8pZ8gdVv8aQIsJntNoRWnFD5Bn3Fndx
 bRgBvVdzK9an0v91Yn/D1cu+IdX3p7M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-wa6GtXGIN6KYtOP_pBUMIw-1; Fri,
 26 Sep 2025 00:58:01 -0400
X-MC-Unique: wa6GtXGIN6KYtOP_pBUMIw-1
X-Mimecast-MFC-AGG-ID: wa6GtXGIN6KYtOP_pBUMIw_1758862680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A82301800359; Fri, 26 Sep 2025 04:57:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BDCA1956095; Fri, 26 Sep 2025 04:57:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43E3021E6A27; Fri, 26 Sep 2025 06:57:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,
 thuth@redhat.com,  alex.williamson@redhat.com,  clg@redhat.com
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
In-Reply-To: <20250925174852.1302-3-alifm@linux.ibm.com> (Farhan Ali's message
 of "Thu, 25 Sep 2025 10:48:49 -0700")
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com>
Date: Fri, 26 Sep 2025 06:57:56 +0200
Message-ID: <87qzvtstd7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Farhan Ali <alifm@linux.ibm.com> writes:

> Provide a vfio error handling callback, that can be used by devices to
> handle PCI errors for passthrough devices.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  hw/vfio/pci.c | 8 ++++++++
>  hw/vfio/pci.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bc0b4c4d56..b02a974954 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>  static void vfio_err_notifier_handler(void *opaque)
>  {
>      VFIOPCIDevice *vdev =3D opaque;
> +    Error *err =3D NULL;
>=20=20
>      if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>          return;
>      }
>=20=20
> +    if (vdev->err_handler) {
> +        if (vdev->err_handler(vdev, &err)) {
> +            return;
> +        }
> +        error_report_err(err);
> +    }

This is unusual.

Functions taking an Error ** argument usually do so to report errors.
The rules spelled out in qapi/error.h apply.  In particular:

 * - On success, the function should not touch *errp.  On failure, it
 *   should set a new error, e.g. with error_setg(errp, ...), or
 *   propagate an existing one, e.g. with error_propagate(errp, ...).
 *
 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,

If ->err_handler() behaved that way, it @err would be null after it
returns false.  We'd call error_report_err(NULL), and crash.

Functions with unusual behavior need a contract: a comment spelling out
their behavior.

What is the intended behavior of the err_handler() callback?

> +
>      /*
>       * TBD. Retrieve the error details and decide what action
>       * needs to be taken. One of the actions could be to pass
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index e0aef82a89..faadce487c 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -146,6 +146,7 @@ struct VFIOPCIDevice {
>      EventNotifier err_notifier;
>      EventNotifier req_notifier;
>      int (*resetfn)(struct VFIOPCIDevice *);
> +    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
>      uint32_t vendor_id;
>      uint32_t device_id;
>      uint32_t sub_vendor_id;


