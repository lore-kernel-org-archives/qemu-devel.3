Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A60606A32D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FB9R7QKD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJEU-0003ge-D7; Mon, 26 Oct 2026 07:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLJES-0003gK-JY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLJEQ-000334-Rh
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 07:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793015473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7JbnTc+Gviorm5yeoE+Jc3DK41YdYSAUR5tB7B2yrw=;
 b=FB9R7QKDX+v3svr+JWMNonXQotUmnsUyCG4KrUu04KIxJ/p5GzE0JpGV+PlXx+EzE8K3nm
 +ym53OKjxBQBRVOR7e2oxLlRmP9R3l6G3cWzjGIUdbyEyzqfsDuF2vhUR30bTIovrDnicf
 uitpT9y9e1vQzAAUdYLPRGN7yQo67W8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-G816QjYyOsqyM5VMEyytBQ-1; Mon,
 26 Oct 2026 07:51:05 -0400
X-MC-Unique: G816QjYyOsqyM5VMEyytBQ-1
X-Mimecast-MFC-AGG-ID: G816QjYyOsqyM5VMEyytBQ_1793015464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D06151954B13
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:51:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FE511800345
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 11:51:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3697321E6A04; Mon, 26 Oct 2026 12:51:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 1/2] crypto: avoid overwriting Error object erasing
 keyslot
In-Reply-To: <20261026111237.660633-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 26 Oct 2026 11:12:36
 +0000")
References: <20261026111237.660633-1-berrange@redhat.com>
 <20261026111237.660633-2-berrange@redhat.com>
Date: Mon, 26 Oct 2026 12:51:02 +0100
Message-ID: <878q3k3ck9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When erasing a keyslot we deliberately ignore some errors and
> carry on trying to erase as much as possible. This results in
> overwriting Error objects and triggering an assertion. Don't
> pass in the &local_err, if errp is already set.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4697
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/block-luks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 0926ad28f0c..277a5110607 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1152,6 +1152,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
   {
       QCryptoBlockLUKS *luks =3D block->opaque;
       QCryptoBlockLUKSKeySlot *slot;
       g_autofree uint8_t *garbagesplitkey =3D NULL;
       size_t splitkeylen;
       size_t i;
       Error *local_err =3D NULL;
       int ret;

       assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
       slot =3D &luks->header.key_slots[slot_idx];

       splitkeylen =3D luks->header.master_key_len * slot->stripes;
       assert(splitkeylen > 0);

       garbagesplitkey =3D g_new0(uint8_t, splitkeylen);

       /* Reset the key slot header */
       memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
       slot->iterations =3D 0;
       slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;

       ret =3D qcrypto_block_luks_store_header(block, writefunc,
                                             opaque, &local_err);

Why not pass @errp here, and ...

>=20=20
>      if (ret < 0) {
>          error_propagate(errp, local_err);

... drop this line?

> +        local_err =3D NULL;
>      }

Suggest a blank line here.


Note for later: @errp may be non-null now.

>      /*
>       * Now try to erase the key material, even if the header
> @@ -1169,6 +1170,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
        * update failed
        */
       for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
           if (qcrypto_random_bytes(garbagesplitkey,
                                    splitkeylen, &local_err) < 0) {
               /*
                * If we failed to get the random data, still write
                * at least zeros to the key slot at least once
                */
               error_propagate(errp, local_err);

If @errp is still null, store this error, else ignore it.

>              if (i > 0) {
>                  return -1;

Stop when erasing non-first key slot failed.

>              }
> +            local_err =3D NULL;
>          }
>          if (writefunc(block,
>                        slot->key_offset_sector * QCRYPTO_BLOCK_LUKS_SECTO=
R_SIZE,
                         garbagesplitkey,
                         splitkeylen,
                         opaque,
                         &local_err) < 0) {
               error_propagate(errp, local_err);

We do need error_propagate() here, because @errp can be non-null.

               return -1;
           }
       }
       return ret;
   }

Nothing is wrong, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>


