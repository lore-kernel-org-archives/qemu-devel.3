Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC3DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2Lt-0007gb-Op; Tue, 07 Jul 2026 05:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh2Lq-0007fk-Kd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh2Lo-0001PD-BZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783417462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7a58XN2/tL0iMV6Si8Ljpa0P6eZpvOptsH3al/llCds=;
 b=KRuj4qjwmxI9Xv8GM9QcjmbnZ8YHn28GQ5MnfflT69jLZTITfO24Wq/TXGW2EZy7fsJHii
 Q/Ceh5wpJbu5kxMbQqgoWCREC2NtzJWXrUbxd5aNH/aIMv0Y9Sfk8GoxHSbx3CcPdXh7Qp
 bVrsk8v348b7gPuYJ8WfLUr+3nLPGuc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-2oNfU1w0Nc-dDtFDuztXXQ-1; Tue,
 07 Jul 2026 05:44:17 -0400
X-MC-Unique: 2oNfU1w0Nc-dDtFDuztXXQ-1
X-Mimecast-MFC-AGG-ID: 2oNfU1w0Nc-dDtFDuztXXQ_1783417455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24C931954219; Tue,  7 Jul 2026 09:44:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D67619560A6; Tue,  7 Jul 2026 09:44:14 +0000 (UTC)
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
Subject: Re: [PATCH v15 14/33] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
In-Reply-To: <20260704213950.2118823-15-zycai@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
 <20260704213950.2118823-15-zycai@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 11:44:11 +0200
Message-ID: <87h5mbjfro.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> From: Collin Walling <walling@linux.ibm.com>
>
> DIAG 508 subcode 1 performs signature-verification on signed components.
> A signed component may be a Linux kernel image, or any other signed
> binary. **Verification of initrd is not supported.**
>
> The instruction call expects two item-pairs: an address of a device
> component, an address of the analogous signature file (in PKCS#7 DER format),
> and their respective lengths. All of this data should be encapsulated
> within a Diag508SigVerifBlock.
>
> The DIAG handler will read from the provided addresses
> to retrieve the necessary data, parse the signature file, then
> perform the signature-verification. Because there is no way to
> correlate a specific certificate to a component, each certificate
> in the store is tried until either verification succeeds, or all
> certs have been exhausted.
>
> A return code of 1 indicates success, and the index and length of the
> corresponding certificate will be set in the Diag508SigVerifBlock.
> The following values indicate failure:
>
> 	0x0102: no certificates are available in the store
> 	0x0202: component data is invalid
> 	0x0302: PKCS#7 format signature is invalid
> 	0x0402: signature-verification failed
> 	0x0502: length of Diag508SigVerifBlock is invalid
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst |  17 +++++
>  include/hw/s390x/ipl/diag508.h  |  30 +++++++++
>  target/s390x/diag.c             | 111 +++++++++++++++++++++++++++++++-
>  3 files changed, 157 insertions(+), 1 deletion(-)

(...)

> +    if (!comp_len || !comp_addr || comp_len > DIAG_508_MAX_COMP_LEN) {
> +        if (comp_len > DIAG_508_MAX_COMP_LEN) {
> +            warn_report("DIAG 0x508: component length %lu exceeds current maximum %u",
> +                        comp_len, DIAG_508_MAX_COMP_LEN);
> +        }
> +        return DIAG_508_RC_INVAL_COMP_DATA;
> +    }
> +
> +    if (!sig_len || !sig_addr || sig_len > DIAG_508_MAX_SIG_LEN) {
> +        if (sig_len > DIAG_508_MAX_SIG_LEN) {
> +            warn_report("DIAG 0x508: signature length %lu exceeds current maximum %u",
> +                        sig_len, DIAG_508_MAX_SIG_LEN);
> +        }
> +        return DIAG_508_RC_INVAL_PKCS7_SIG;
> +    }

Hi,

I'm afraid this breaks the build on win64 (as done by the ci):

../target/s390x/diag.c: In function 'handle_diag508_sig_verif':
../target/s390x/diag.c:683:57: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
  683 |             warn_report("DIAG 0x508: component length %lu exceeds current maximum %u",
      |                                                       ~~^
      |                                                         |
      |                                                         long unsigned int
      |                                                       %llu
  684 |                         comp_len, DIAG_508_MAX_COMP_LEN);
      |                         ~~~~~~~~
      |                         |
      |                         uint64_t {aka long long unsigned int}
../target/s390x/diag.c:691:57: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
  691 |             warn_report("DIAG 0x508: signature length %lu exceeds current maximum %u",
      |                                                       ~~^
      |                                                         |
      |                                                         long unsigned int
      |                                                       %llu
  692 |                         sig_len, DIAG_508_MAX_SIG_LEN);
      |                         ~~~~~~~
      |                         |
      |                         uint64_t {aka long long unsigned int}

Cornelia


