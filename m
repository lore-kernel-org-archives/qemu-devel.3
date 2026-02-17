Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A300E68141
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsG6a-0002uL-BG; Tue, 17 Feb 2026 03:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsG6X-0002u6-2y
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsG6U-0007Y3-QQ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 03:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771315600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJMOm8uAaLo9jAW3zbn7H0s9cOErrB5lDYx/COACt0Q=;
 b=WfDzh0y9qgFEV+5/1Y1oq6tA7apCtkI1+xxAYhlNmIv4QPfjNudPMVQeHlTs1nQ7uiFb7Y
 GTkxppqp0OM1C+HqNf0sdiZ/KCNuUjjZdNPBgXYT1WqZCrxBCtwX4Bk2q4ELk5iGMkCtZe
 RI7jOXIxKyWevLg0jxmESBWnUkPvW5o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-as1H0aVZMLWTRTwwuaUm8Q-1; Tue,
 17 Feb 2026 03:06:37 -0500
X-MC-Unique: as1H0aVZMLWTRTwwuaUm8Q-1
X-Mimecast-MFC-AGG-ID: as1H0aVZMLWTRTwwuaUm8Q_1771315595
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 051011800454; Tue, 17 Feb 2026 08:06:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AA3F180034A; Tue, 17 Feb 2026 08:06:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D34921E692D; Tue, 17 Feb 2026 09:06:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,
 david@kernel.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 alifm@linux.ibm.com,  brueckner@linux.ibm.com
Subject: Re: [PATCH v8 21/30] s390x: Guest support for Secure-IPL Code
 Loading Attributes Facility (SCLAF)
In-Reply-To: <20260212204352.1044699-22-zycai@linux.ibm.com> (Zhuoying Cai's
 message of "Thu, 12 Feb 2026 15:43:42 -0500")
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-22-zycai@linux.ibm.com>
Date: Tue, 17 Feb 2026 09:06:32 +0100
Message-ID: <87cy23pzef.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> The secure-IPL-code-loading-attributes facility (SCLAF)
> provides additional security during secure IPL.
>
> Availability of SCLAF is determined by byte 136 bit 3 of the
> SCLP Read Info block.
>
> This feature is available starting with the gen16 CPU model.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst     | 19 +++++++++++++++++++
>  target/s390x/cpu_features.c         |  2 ++
>  target/s390x/cpu_features_def.h.inc |  1 +
>  target/s390x/cpu_models.c           |  3 +++
>  target/s390x/gen-features.c         |  2 ++
>  target/s390x/kvm/kvm.c              |  1 +
>  6 files changed, 28 insertions(+)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 82dd8b847a..e7a93806f6 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -109,3 +109,22 @@ operations such as:
>  
>  The guest's kernel inspects the IIRB and uses the certificate data it contains
>  to build the keyring.
> +
> +
> +Secure Code Loading Attributes Facility
> +---------------------------------

Does not build:

    docs/specs/s390x-secure-ipl.rst:170: WARNING: Title underline too short.

    Secure Code Loading Attributes Facility
    --------------------------------- [docutils]

Please test with configure --enable-docs.

> +
> +The Secure Code Loading Attributes Facility (SCLAF) enhances system security
> +during the IPL by enforcing additional verification rules.
> +
> +When SCLAF is available, its behavior depends on the IPL mode. It introduces
> +verification of both signed and unsigned components to help ensure that only
> +authorized code is loaded during the IPL process. Any errors detected by SCLAF
> +are reported in the IIRB.
> +
> +Unsigned components are restricted to load addresses at or above absolute
> +storage address ``0x2000``.
> +
> +Signed components must include a Secure Code Loading Attribute Block (SCLAB),
> +which is appended at the very end of the component. The SCLAB defines security
> +attributes for handling the signed code.

[...]


