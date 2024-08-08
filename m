Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E08C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6Vq-0006yA-Ni; Thu, 08 Aug 2024 13:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc6Vk-0006cl-KM
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc6Vf-0003qo-Mu
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723136455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gWFMwKH7UVjhM4138EK3zhEWj/z5bEfJVMGYj6k/nA=;
 b=UQtzVcQHwiFw0D2a9umkF0Czeac7o4w119DfuGIkY97Aoqb7JiAGf66pXRUp8zrZkddr1f
 8IhTcMfSOzJIvPK+snc/eP61yPrj1oh62DIERY8bCe+Pd7aRCNLNSVhOrZGz15iWQGuSPV
 kKH09vz9RuP6AHTUCxlH9vElqpTTuWY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-y7zNEOgTN0W9gLHRIb_KSw-1; Thu,
 08 Aug 2024 13:00:52 -0400
X-MC-Unique: y7zNEOgTN0W9gLHRIb_KSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDCE01955D5D; Thu,  8 Aug 2024 17:00:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E30F19560A3; Thu,  8 Aug 2024 17:00:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F34221E6682; Thu,  8 Aug 2024 19:00:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alejandro Zeise <alejandro.zeise@seagate.com>,  qemu-arm@nongnu.org,
 kris.conklin@seagate.com,  jonathan.henze@seagate.com,
 evan.burgess@seagate.com,  clg@kaod.org,  peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 01/15] crypto: accumulative hashing API
In-Reply-To: <ZrTskk2UCzWbmupd@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 8 Aug 2024 17:04:34 +0100")
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
 <20240807195122.2827364-2-alejandro.zeise@seagate.com>
 <ZrTskk2UCzWbmupd@redhat.com>
Date: Thu, 08 Aug 2024 19:00:47 +0200
Message-ID: <87wmkrq79c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Aug 07, 2024 at 07:51:08PM +0000, Alejandro Zeise wrote:
>> Changes the hash API to support accumulative hashing.
>> Hash objects are created with "qcrypto_hash_new",
>> updated with data with "qcrypto_hash_update", and
>> the hash obtained with "qcrypto_hash_finalize".
>>=20
>> These changes bring the hashing API more in line with the
>> hmac API.
>>=20
>> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>

[...]

>> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
>> index 54d87aa2a1..6d7222867e 100644
>> --- a/include/crypto/hash.h
>> +++ b/include/crypto/hash.h
>> @@ -1,6 +1,7 @@
>>  /*
>>   * QEMU Crypto hash algorithms
>>   *
>> + * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
>>   * Copyright (c) 2015 Red Hat, Inc.
>>   *
>>   * This library is free software; you can redistribute it and/or
>> @@ -25,6 +26,13 @@
>>=20=20
>>  /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
>>=20=20
>> +typedef struct QCryptoHash QCryptoHash;
>> +struct QCryptoHash {
>> +    QCryptoHashAlgorithm alg;
>> +    void *opaque;
>> +    void *driver;
>> +};
>> +
>>  /**
>>   * qcrypto_hash_supports:
>>   * @alg: the hash algorithm
>> @@ -120,6 +128,117 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
>>                           char **digest,
>>                           Error **errp);
>>=20=20
>> +/**
>> + * qcrypto_hash_updatev:
>> + * @hash: hash object from qcrypto_hash_new
>> + * @iov: the array of memory regions to hash
>> + * @niov: the length of @iov
>> + * @errp: pointer to a NULL-initialized error object
>> + *
>> + * Updates the given hash object with all the memory regions
>> + * present in @iov.
>> + *
>> + * Returns: 0 on success, non-zero on error
>
> Minor point, this and all the other APIs should be saying
> 'or -1 on error' to follow QEMU's error reporting standards.

Specifically, qapi/error.h:

 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.


