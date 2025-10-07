Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A7CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64D0-0003Nu-MT; Tue, 07 Oct 2025 05:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64Cv-0003NF-6r
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64Cr-0002FA-5C
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759830119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LyUlZAHBQdxHwuRgX9JUkiyiUdNvG5bdVu2wcBpt6a0=;
 b=OcJpHP8llomLqXeLWZGVHRdm6FEGQ6DjJqcbePU/VBEtoBAkOyJvNrzxWH8ntLRn8Vqify
 y/MYecZRmkauQYq0BenuuzHlRi1cjjKrNl/E2VYt+2PgRKwJmGhbjTz4Gilh4FGFyLzq6v
 q+LZkDFX/fO2t3FgiDoDcq5PIH5x5OA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-opya6JVxOESBRuzr23ZtIg-1; Tue, 07 Oct 2025 05:41:58 -0400
X-MC-Unique: opya6JVxOESBRuzr23ZtIg-1
X-Mimecast-MFC-AGG-ID: opya6JVxOESBRuzr23ZtIg_1759830117
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so3078112f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759830117; x=1760434917;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LyUlZAHBQdxHwuRgX9JUkiyiUdNvG5bdVu2wcBpt6a0=;
 b=oD+qB1Jn8i3KN3G3xFiW7GEH90hUnyCwiiwG1UOO8gvM0sUpf0uG79YM8Z6gPWYmqE
 eLS/N5xWSahqGf3RqwUirci+vce8NtppOBU5NqA94igrUu1IwFEF2qj/h7vcYnpbXL6z
 SMBQdmQU9vNOR29xtdZXkLB0BkTUwNEcl5mlmeWTe8IwNbY5zd03ivMelzTgeIRXQtVg
 k2y0RVH7QiE30k6oYjIJaL7oCCp34bD8W6vgCmy10avSVChDCLOLkfOyCm0OuzF0OnOs
 t+0UQKH6tVHqKAsrltvePRFPnZ7g/jkafIzrIUUY4Y45HekVFtiANpbchTuLGg7g9oCH
 DfTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+GdpL8fFJRs2tl+h01r+JqRPenXqsbsk7zE4dj/+M7mz8Qh2kQANzOEBeI2AhBI06VJQD5IbalSgn@nongnu.org
X-Gm-Message-State: AOJu0Ywc56pack/deKp+N17UnjZ+Pu3ZWFZ55TRPkdaDhPYjSAFa9lMO
 HXYf41Rgab+NC60tL5sdL3DNojdVtUN0IzL/3nLr/ZGfXiYjKOAiPa3POUCxxEk7/EPQdI9Lhuw
 czeDJIN+kCV5rcBG7vovMFO5oBQUa9K3hNGCgDGx8KJ4/9ZPR4uH/LIzk
X-Gm-Gg: ASbGncs/kYvxv+VOCYmD1W0yVZFlVNzC9gYmiyW+nq9MRHmeGJtme672TMh36Y1hPqw
 ZNL8YiGWaXhT4HMU52v73fst0Fx5VVlBlbQ2jgJtrpBPNJtkwtHAiIaIEDcGb7ISMgxMxFbMwjh
 1Lehe+mT3cIIBo2c81ix7WtVcpXlMh6al0m/06AUf8TRDviKqjtFk500BRyW4cSGq+NALMTYZAI
 yK2yAUp76zeHPGCCG2p4ZZ7dunsWaVx2cehFFgap4fKrH38s9AnucFef78v737q83+pea7LD/Ap
 ZOLS/pnb2tBswd8/S8T9wEgUpO5jbgATTMYHaJMqM5MWZaMNnVbZ+mw6JDFvilyxZZIY3es=
X-Received: by 2002:a05:6000:420e:b0:425:8bd1:fbb4 with SMTP id
 ffacd0b85a97d-4258bd1fc6amr40893f8f.50.1759830116721; 
 Tue, 07 Oct 2025 02:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAeCkJ7dj26F89nnjhbSQ34FzLtPakywdHbf+WB5BGuWdFWT6YqybEHmrNZ6Y9FivU2cZETA==
X-Received: by 2002:a05:6000:420e:b0:425:8bd1:fbb4 with SMTP id
 ffacd0b85a97d-4258bd1fc6amr40870f8f.50.1759830116293; 
 Tue, 07 Oct 2025 02:41:56 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f011bsm25106664f8f.46.2025.10.07.02.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 02:41:55 -0700 (PDT)
Message-ID: <e4054bc7-e496-4be3-a218-42714b1ef9e8@redhat.com>
Date: Tue, 7 Oct 2025 11:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/28] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-9-zycai@linux.ibm.com>
 <dd3ebdf4-3d80-475b-8739-65b6b771a0b6@redhat.com>
 <aOTfhXQHQ69eG5yF@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <aOTfhXQHQ69eG5yF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 07/10/2025 11.38, Daniel P. Berrangé wrote:
> On Tue, Oct 07, 2025 at 11:34:29AM +0200, Thomas Huth wrote:
>> On 18/09/2025 01.21, Zhuoying Cai wrote:
>>> Introduce new helper functions to extract certificate metadata needed for
>>> DIAG 320 subcode 2:
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
>> ...
>>> +int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
>>> +{
>>> +    int rc;
>>> +    int ret = -1;
>>> +    unsigned int bits;
>>> +    gnutls_x509_crt_t crt;
>>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>>> +
>>> +    rc = gnutls_x509_crt_init(&crt);
>>> +    if (rc < 0) {
>>> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
>>> +        return ret;
>>> +    }
>>> +
>>> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
>>> +    if (rc != 0) {
>>> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
>>> +    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_pk_alg_map)) {
>>
>> gnutls_x509_crt_get_pk_algorithm can also return a negative value according
>> to the documentation, so I think you should also check for "rc < 0" in
>> addition here.
>>
>>> +        error_setg(errp, "Unknown public key algorithm %d", rc);
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    ret = gnutls_to_qcrypto_pk_alg_map[rc];
>>> +
>>> +cleanup:
>>> +    gnutls_x509_crt_deinit(crt);
>>> +    return ret;
>>> +}
>>> +
>>> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
>>> +                                 QCryptoHashAlgo hash_alg,
>>> +                                 uint8_t **result,
>>> +                                 size_t *resultlen,
>>> +                                 Error **errp)
>>> +{
>>> +    int rc;
>>> +    int ret = -1;
>>> +    gnutls_x509_crt_t crt;
>>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>>> +
>>> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>>> +        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
>>> +        return ret;
>>> +    }
>>> +
>>> +    if (qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1 ||
>>> +        hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
>>
>> Since "||" conditions are evaluated from left to right, please check for the
>> boundary first before using hash_alg as index into the array (i.e. swapt the
>> two sides of the "||").
>>
>>> +        error_setg(errp, "Unsupported key id flag %d", hash_alg);
>>> +        return ret;
>>> +    }
>>> +
>>> +    rc = gnutls_x509_crt_init(&crt);
>>> +    if (rc < 0) {
>>> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
>>> +        return ret;
>>> +    }
>>> +
>>> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
>>> +    if (rc != 0) {
>>> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
>>> +    if (*resultlen == 0) {
>>> +        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    *result = g_malloc0(*resultlen);
>>> +    if (gnutls_x509_crt_get_key_id(crt,
>>> +                                   qcrypto_to_gnutls_keyid_flags_map[hash_alg],
>>> +                                   *result, resultlen) != 0) {
>>> +        error_setg(errp, "Failed to get key ID from certificate");
>>> +        g_clear_pointer(result, g_free);
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    ret = 0;
>>> +
>>> +cleanup:
>>> +    gnutls_x509_crt_deinit(crt);
>>> +    return ret;
>>> +}
>> ...
>>> +int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
>>> +{
>>> +    int curve_id;
>>> +
>>> +    curve_id = qcrypto_x509_get_ecc_curve(cert, size, errp);
>>> +    if (curve_id == -1) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (curve_id == GNUTLS_ECC_CURVE_INVALID) {
>>> +        error_setg(errp, "Invalid ECC curve");
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (curve_id == GNUTLS_ECC_CURVE_SECP521R1) {
>>> +        return 1;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>
>> Bikeshedding, but IMHO, if you name a function "..._is_something", I'd
>> prefer if it returns a bool, and not an "int". Otherwise this might get
>> confusing if you read something like this later in the code:
>>
>>     if (qcrypto_x509_is_ecc_curve_p521(...)) {
>>     }
>>
>> The caller could use errp to distinguish between the error case and a
>> simple "false" as answer to the question.
> 
> Overloading one 'false' return value to mean both success & failure
> is an anti-pattern IMHO. We have 3 separate return values we need
> for this function, so using -1/0/1 is the right approach.

In that case, please rename the function to something like 
"qcrypto_x509_check_ecc_curve_p521" or so ... it's IMHO getting
too confusing otherwise.

  Thomas


