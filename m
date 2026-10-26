Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D9606A324
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWtyslB/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLD8W-0003GJ-05; Mon, 26 Oct 2026 01:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLD8S-0003Dq-Hb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 01:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLD8Q-0000LU-Q8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 01:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792992035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kj52iLwYUgyIgmemrhnSno7rubz3U4MwOudKZUpa+DU=;
 b=dWtyslB/2UYq9BzsGnluNtQjyaLU21/A3/ERKX1l9oBNR+UXQ15YCOOYkzeV7bIX0tkaZG
 yAsi5lkhUdkbqktLSgWt+RbISjfijSdIv5nEXELl+TUDlkYYdwiMsYstnXdPLRNSQhVJgV
 dtvwJ4zc0w/K2JX7HannAurQdlIgyEo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-UnM0v9qROpCm6c_3XdNRAg-1; Mon,
 26 Oct 2026 01:20:32 -0400
X-MC-Unique: UnM0v9qROpCm6c_3XdNRAg-1
X-Mimecast-MFC-AGG-ID: UnM0v9qROpCm6c_3XdNRAg_1792992032
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2888195604A
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 05:20:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9773A26C
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 05:20:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41D4621E6A04; Mon, 26 Oct 2026 06:20:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] crypto: avoid overwriting Error object erasing keyslot
In-Reply-To: <179278610144.473507.3670274283995738536.b4-review@b4> (marcandre
 lureau's message of "Sat, 24 Oct 2026 00:08:21 +0400")
References: <20261023141303.163893-1-berrange@redhat.com>
 <20261023141303.163893-2-berrange@redhat.com>
 <179278610144.473507.3670274283995738536.b4-review@b4>
Date: Mon, 26 Oct 2026 06:20:29 +0100
Message-ID: <87se1t6ns2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

marcandre.lureau@redhat.com writes:

>> When erasing a keyslot we deliberately ignore some errors and
>> carry on trying to erase as much as possible. This results in
>> overwriting Error objects and triggering an assertion. Don't
>> pass in the &local_err, if errp is already set.
>>=20
>> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4697
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Message-ID: <20261023141303.163893-2-berrange@redhat.com>
>> ---
>>  crypto/block-luks.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
>> index 0926ad28f0cd..8a1df846a146 100644
>> --- a/crypto/block-luks.c
>> +++ b/crypto/block-luks.c
>> @@ -1152,22 +1152,29 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
>>=20=20
>>      if (ret < 0) {
>>          error_propagate(errp, local_err);
>> +        local_err =3D NULL;
>>      }
>> +
>>      /*
>>       * Now try to erase the key material, even if the header
>>       * update failed
>>       */
>>      for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS; i++) {
>>          if (qcrypto_random_bytes(garbagesplitkey,
>> -                                 splitkeylen, &local_err) < 0) {
>> +                                 splitkeylen,
>> +                                 errp && *errp ? NULL : &local_err) < 0=
) {
>
> I think the current code was simpler. error_propagate() will simpliy disc=
ard local_err if errp is already set. It is just missing "local_err =3D NUL=
L;"

Moreover, *errp is wrong without ERRP_GUARD().

[...]


