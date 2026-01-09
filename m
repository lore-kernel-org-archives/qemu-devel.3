Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48730D1680B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAbj-0006m2-5R; Fri, 09 Jan 2026 06:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veAbh-0006lS-Ec
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veAbf-0000MW-OI
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767957878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qzGO5XJFlW5e5bFUiIr+2jsEq4v5hMFLP4do/aaNYTk=;
 b=fI1670u+ByKaAzwtMruRT5VIJWZY/egxZQeHZdrQfPcfgEutz3EuEDaLrG/46Hvb+1N4cF
 xFCcHlIISKjcrwuZLG1FX7i0A0xOkWYhLCPE+kAkeo74GBEnJEUBxlHWrYioPe217VJTbW
 KcyjvsaeKUiA9XV5xGRwDGmy2w63x3k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-L0QFaVc5PSWke74OLbb5sg-1; Fri, 09 Jan 2026 06:24:36 -0500
X-MC-Unique: L0QFaVc5PSWke74OLbb5sg-1
X-Mimecast-MFC-AGG-ID: L0QFaVc5PSWke74OLbb5sg_1767957875
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b763b24f223so609799766b.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767957875; x=1768562675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qzGO5XJFlW5e5bFUiIr+2jsEq4v5hMFLP4do/aaNYTk=;
 b=RbeUSEQsJo2WRLjcBYkuYyxxdBvKpfW8EDQ7dq+5YGkL67eBxIWUdhV8xE4bqgHzwL
 AmgVojpt8r0fBytb/AhAIVtsoV4IhGmOTPA2r/A73ghTfORKq/j4rQFRqMXMDY52B7uO
 STgS/k7byz+0m1QtuVLsQtwUwoB7Hq7hN8A+aOqlxLK/EC790RetpmL8euoI+EOgAdgv
 nt+qqUIWnE2Tt5hx2ke6bmBlFwTd3FxNKH3p8+xhCuj6HAh8LU2X37ltAVTecOMR7dgG
 X6NsADkFJtkpw3WARqP8+Xv796IsyL1Jv0pYNeNq2+6jO30GNql8H+w3coLeYg3BAuXT
 Tong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767957875; x=1768562675;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzGO5XJFlW5e5bFUiIr+2jsEq4v5hMFLP4do/aaNYTk=;
 b=M9A0uQDe3M5yyFZyMXT5whBbv2r941JgTlodDw/8eUx9Y/eKqZ8mcESXQ8MYKu19TZ
 ZLF+zN8rEvVmNuYL950z+u8FESQRuPfSxPoAHHgbLyYGe7W245RgssL4RJxnRa7lr3uA
 tNeCfkWjEmrcRORbsMIAOq+ASZPZi6+kU63hsdtlc74bP7fTUUuwJ9pJQJUX9o0lJlIB
 LDyI5ghr+YTub9B6Pq5u1tg5W0XwO2DyicTxj61msi3Go6yN24AIFfceVGoXb6gfaDUH
 9XUCZKitRdmmc813X53Lo4uPLFXmxL32S+svl5ZjX2cIygs3olMxWNVHoyCb4nNlxT7Z
 u41A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF5B3uy3dY1NNCEL1WyTo6w/ZnAL8NPq/YjaydS5JX8bFJoFYMAMxVv/gIkRFmCg+FCicqTJ3z7L3k@nongnu.org
X-Gm-Message-State: AOJu0YyBRqm+97EYlXP8SHkhPPT+dpAKx2Dn5n2QOxr9LGNPxcN1HJB6
 U7mKPhKRY9jnDVUgsX2K/h3GTEczNMiefamdB9rQ/ZtocJ5fG9xRtT/Rg8oY8Yeq7iE+cfskXq5
 qvzJrQUAot8cpmoGvcy29o64oP/qoVlez3nHvK82Md+0Q2/pHhJd8UiZr
X-Gm-Gg: AY/fxX5phSIoiHzvO9M3PGa54OC4l4FWX3ujhpnHhDfhXQbuKMSMxmeskmeT6lmz8ig
 fHeBiyScwrD6edOfJ6ZUKBDiGeVHxlfJdMUTmoDr7qd8+PnNNNzT9YNs6+pR0Qwq+4v2jzkK8zv
 Gsy58IUzsQ4qbjHtxGMAnW6GBtcqgzHleSojQyW5G4qU4qeVitpq/dyrnjIMhrXhUxsSHwUdf0d
 lTx5Lp9TTmTa0Aw8Ag/wdgQ7DfL3aVntXKaP03hDSOF5vR8xxI5Zh3jupwJOGr2+RQqXhOXgRCl
 aE2zQ38mgEzmOLdVbmTrRp0oNVPCfRxgleFqescU+4zi3V1kUyPYoQRD8gIi7uXL1xIHyhdmsgL
 1UPew9Ew=
X-Received: by 2002:a17:906:478d:b0:b83:3770:a0e4 with SMTP id
 a640c23a62f3a-b8445337924mr911652566b.34.1767957875324; 
 Fri, 09 Jan 2026 03:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1MCoAwhYguF+cdVL3BUKsQOCK1ivtse090LhF2DRBbFBrRto0cJR7GhrtBB9MOZOoAGZGZw==
X-Received: by 2002:a17:906:478d:b0:b83:3770:a0e4 with SMTP id
 a640c23a62f3a-b8445337924mr911649766b.34.1767957874920; 
 Fri, 09 Jan 2026 03:24:34 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a2bcd30sm1109340366b.28.2026.01.09.03.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 03:24:34 -0800 (PST)
Message-ID: <53a6f846-2a65-49d4-aabb-021e9c2f590f@redhat.com>
Date: Fri, 9 Jan 2026 12:24:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/29] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-9-zycai@linux.ibm.com>
 <9f622221-5012-4f12-8fc2-3a721a0ce111@redhat.com>
 <aWDi7gh4uiwA7JOA@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aWDi7gh4uiwA7JOA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/01/2026 12.13, Daniel P. Berrangé wrote:
> On Fri, Jan 09, 2026 at 12:06:25PM +0100, Thomas Huth wrote:
>> On 08/12/2025 22.32, Zhuoying Cai wrote:
>>> Introduce new helper functions to extract certificate metadata:
>>>
>>> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
>>> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
>>> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
>>> qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
>>>
>>> These functions provide support for metadata extraction and validity checking
>>> for X.509 certificates.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>    crypto/x509-utils.c         | 248 ++++++++++++++++++++++++++++++++++++
>>>    include/crypto/x509-utils.h |  73 +++++++++++
>>>    2 files changed, 321 insertions(+)
>>>
>>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>>> index 2696d48155..f91fa56563 100644
>>> --- a/crypto/x509-utils.c
>>> +++ b/crypto/x509-utils.c
>>> @@ -27,6 +27,25 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>>>        [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>>>    };
>>> +static const int gnutls_to_qcrypto_pk_alg_map[] = {
>>
>> Could you do me a favour and add a line like this at the beginning of this
>> array:
>>
>>   [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
>>
>> and then also set QCRYPTO_PK_ALGO_UNKNOWN = 0 in the enum in the header?
>> That way we can be sure that zero values are not accidentally mapped to a
>> valid algorithm.
> 
> That would be special casing just one enum type in the crypto subsystem
> to have this special unknown value. We've got 1000's of enums across
> QEMU and don't generally add such a special zeroth constant, so I don't
> find this suggested change to be desirable.

I came up with this idea when reviewing the qcrypto_x509_get_pk_algorithm() 
function in this patch which is basically doing:

    ret = gnutls_to_qcrypto_pk_alg_map[rc];

My concern is that if someone ever extends the QCryptoPkAlgo in the header, 
but forgets to fill in as much entries to gnutls_to_qcrypto_pk_alg_map as 
there are entries in the enum, we're in trouble, since the wholes in the 
array will be padded with zeros that then get mapped to QCRYPTO_PK_ALGO_RSA. 
Having a clearly invalid meaning of 0 would help in such cases.
But if you consider this as too unlikely to happen, then never mind my 
suggestion.

  Thomas


