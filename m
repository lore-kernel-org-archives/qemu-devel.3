Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF89D2F7F1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1K5p-00083K-Ju; Thu, 17 Oct 2024 02:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1K5l-000830-1c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1K5j-00025Q-M9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729146873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyeFW8F58eg9bQP7olaA/2+XrDpleTSKUoyCc8mkoes=;
 b=RjAAIXWUnxT0SGMIefs0FNMW/up0Dc08Ps5g8p9YcPF6W1I1yw2m9nrdad/nEC6N8WnjS0
 9U0sHjgsGZW/SuytjR3D0VjtPRB75+DhWAzg7uC64sPzkgiVRZx9GmTFTVoN3AS0corMA9
 nsOx842SUO4WJgBDr3RdIjzBfMfG9fY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-Vk0sqeyRNRCUIOetyJF3oQ-1; Thu,
 17 Oct 2024 02:34:30 -0400
X-MC-Unique: Vk0sqeyRNRCUIOetyJF3oQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2323C1956048; Thu, 17 Oct 2024 06:34:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C879319560A3; Thu, 17 Oct 2024 06:34:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5800A21E6A28; Thu, 17 Oct 2024 08:34:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Kunwu <chentao@kylinos.cn>,  =?utf-8?Q?C=C3=A9?=
 =?utf-8?Q?dric?= Le Goater
 <clg@redhat.com>,  Alejandro Zeise <alejandro.zeise@seagate.com>
Subject: Re: [PULL 07/17] crypto/hash-afalg: Implement new hash API
In-Reply-To: <20241010162024.988284-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 10 Oct 2024 17:20:14
 +0100")
References: <20241010162024.988284-1-berrange@redhat.com>
 <20241010162024.988284-8-berrange@redhat.com>
Date: Thu, 17 Oct 2024 08:34:26 +0200
Message-ID: <87zfn3ck5p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> From: Alejandro Zeise <alejandro.zeise@seagate.com>
>
> Updates the afalg hash driver to support the new accumulative
> hashing changes as part of the patch series.
>
> Implements opening/closing of contexts, updating hash data
> and finalizing the hash digest.
>
> In order to support the update function, a flag needs to be passed
> to the kernel via the socket send call (MSG_MORE) to notify it that more
> data is to be expected to calculate the hash correctly.
> As a result, a new function was added to the iov helper utils to allow
> passing a flag to the socket send call.
>
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Handled qcrypto_afalg_hash_ctx_new() errors in
>          qcrypto_afalg_hash_new()
>        - Freed alg_name in qcrypto_afalg_hash_new()
>        - Reworked qcrypto_afalg_recv_from_kernel()
>        - Split iov changes from original patch ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Semantic conflict with commit 8f525028bc6 broke the build:

    ../crypto/hash-afalg.c: In function =E2=80=98qcrypto_afalg_hash_free=E2=
=80=99:
    ../crypto/hash-afalg.c:145:5: error: unknown type name =E2=80=98QCrypto=
AFAlg=E2=80=99; did you mean =E2=80=98QCryptoAFAlgo=E2=80=99?
      145 |     QCryptoAFAlg *ctx =3D hash->opaque;
          |     ^~~~~~~~~~~~
          |     QCryptoAFAlgo


and more of the same.  I'll post a patch.


