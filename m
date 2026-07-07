Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD20C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2Sj-0001K4-Nl; Tue, 07 Jul 2026 05:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh2SX-0001Bb-M7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh2SW-0003Vp-73
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783417879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7G4iVEHf0Yz9UwBfpYz5idImA09av36dcyFyO+OvueQ=;
 b=g3Vv2C0/g0EjR3wAr3cieN/gOliF5Lr6PNU6vx1cW7you09xjYXx1VW2PBtxrRWKma8HxX
 JFHn4EvhFMLiGn9yqCnUGMQ+1xGGgcfZleIXkCkGEkvX21tWv/tM4DAwQp5nm0rSq249kh
 r8z9QvaWYGRMbnU253k05SMqLAk5fm0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-E4a1BmXFOO6bo_4OKYb7lg-1; Tue,
 07 Jul 2026 05:51:14 -0400
X-MC-Unique: E4a1BmXFOO6bo_4OKYb7lg-1
X-Mimecast-MFC-AGG-ID: E4a1BmXFOO6bo_4OKYb7lg_1783417872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 967B6195419D; Tue,  7 Jul 2026 09:51:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B051B180067A; Tue,  7 Jul 2026 09:51:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, pierrick.bouvier@oss.qualcomm.com,
 jdaley@linux.ibm.com
Subject: Re: [PATCH v15 05/33] s390x/diag: Introduce DIAG 320 for
 Certificate Store Facility
In-Reply-To: <20260704213950.2118823-6-zycai@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
 <20260704213950.2118823-6-zycai@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 11:51:08 +0200
Message-ID: <87echfjfg3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jul 04 2026, Zhuoying Cai <zycai@linux.ibm.com> wrote:

> DIAGNOSE 320 is introduced to support Certificate Store (CS)
> Facility, which includes operations such as query certificate
> storage information and provide certificates in the certificate
> store.
>
> Currently, only subcode 0 is supported with this patch, which is
> used to query the Installed Subcodes Mask (ISM).
>
> This subcode is only supported when the CS facility is enabled.
>
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
>
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
>
> This feature is available starting with the gen16 CPU model.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/specs/s390x-secure-ipl.rst     | 12 +++++++++
>  include/hw/s390x/ipl/diag320.h      | 20 ++++++++++++++
>  target/s390x/cpu_features.c         |  1 +
>  target/s390x/cpu_features_def.h.inc |  1 +
>  target/s390x/cpu_models.c           |  2 ++
>  target/s390x/diag.c                 | 41 +++++++++++++++++++++++++++++
>  target/s390x/gen-features.c         |  3 +++
>  target/s390x/kvm/kvm.c              | 16 +++++++++++
>  target/s390x/s390x-internal.h       |  2 ++
>  target/s390x/tcg/misc_helper.c      |  7 +++++
>  10 files changed, 105 insertions(+)
>  create mode 100644 include/hw/s390x/ipl/diag320.h

(...)

> +    switch (subcode) {
> +    case DIAG_320_SUBC_QUERY_ISM:
> +        /*
> +         * The Installed Subcode Block (ISB) can be up 8 words in size,
> +         * but the current set of subcodes can fit within a single word
> +         * for now.
> +         */
> +        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);

Hi,

I'm afraid this breaks building with clang (as done by the ci; error
messages are from a build of the whole series, which further changed
this line):

../target/s390x/diag.c:576:9: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
  576 |         uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
      |         ^

Cornelia


