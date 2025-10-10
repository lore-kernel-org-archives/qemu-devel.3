Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F0CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7HYB-0003yH-MC; Fri, 10 Oct 2025 14:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7HYA-0003xp-5K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7HXy-0006PF-Oz
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760119725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WqeVflMVJhAigr9+1rE/J3DUZWD4bEP3yUtodSIIV1w=;
 b=Q4E465pw3CQwRJXXMca5nVjZzxxffgw9KgfV2jLG5zydE5nh2k7/H02/R76lXLoBQ0jDsf
 zUaBgWVKxOsfY3JNBiZwQ3EBvei3Jci9cOAKQfxp/o88umQssuM/by9QwSRzf19z9U3/NS
 PO1K+iVFubowfTUrMQCUbBNZHc/eFZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-lrWnOg7ONbSN4Xqu2P5mDA-1; Fri, 10 Oct 2025 14:08:43 -0400
X-MC-Unique: lrWnOg7ONbSN4Xqu2P5mDA-1
X-Mimecast-MFC-AGG-ID: lrWnOg7ONbSN4Xqu2P5mDA_1760119722
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42557bdbe50so1923573f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760119722; x=1760724522;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqeVflMVJhAigr9+1rE/J3DUZWD4bEP3yUtodSIIV1w=;
 b=R1y19uUykrWwm2aDifz0446l8PEt/X3DZyptCzaV2IL9jZb41awZgUZ/WKYyeKQDJa
 g9yUzjXWXj+lGECVWf2kuh9V3yif7iVU9stI0W1/i2I1T9eJq+Lhc47bvBKRqQAkHWaU
 3mXkMkEdKtPcNcYrAitXu/XLo9dFMhWEVr2ZCRMK15QcQ9QSTEFkK4lc611qLExAvB8Y
 KMEvX54GTYJTCb4aJv2pMb/gG1ujrWD8h0Fh4nEsq2taKtYI62fCqNy9bqAFUslYvYST
 0Ll0BI5LtIDDZfcmCDPdfNFHH6B7unufAlcwmSc/HkCnWWgEGoGp8VJtlRIg7zPXyali
 H50Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl4Dx1cxTssnwhrGdCRArEW2iTqYXKY0o1rBtwdNR+6+VWFDexd/t2j16Uaktxbg/oQGErQTT7qnM+@nongnu.org
X-Gm-Message-State: AOJu0YwDusAqs4vv/PiLr3HjtGtd1ucIdyErc1U/XBkfLDFqR+3/DwRa
 7kg/SbrKiTxRkUUhf9WPX7PIilhKQuQCxtLGm0+PD0wHygGB5MnJq25FscmLAorYvCTOG02NMHk
 wcgdMBde+lKNr6ws7e+ySnTDn6EJ2bFE+NMTrf+vV8RbKiFYYAt0vQyS+
X-Gm-Gg: ASbGncua1NrUivG6cMfwwIDGgWDbep6VEv1d/HDtIWvh9t0zCyBzadCVcO8iyAZ7IlN
 oGM4fuWkaH7KdH04JfXRb09/l5MEfBbcaGyKLjCLiLaj5XlYB16NSacI2/gTRDuZxfVkouyj4os
 3skwdfxtGU+EhuBypHU0W14aHrymEXUTq7c6qxgwBkmsloI2Ki/Fs2wG48MJN7rcWUtVO8MH9Tg
 Glmh8uncPrM48zYjFeaju2SPG3O7CAtTELhFJK1+XsISD6PmxJ2DWMf1qpMHKKIUjyDwyoq4UrA
 TnlSuBOFXzEfDFQM/ZeGHfqSqBf2qhJ2m/xu9x1yKpERGIw2n2tvBfZV8SzD8XDBd/7SGc9/dKE
 sDOEF
X-Received: by 2002:a05:6000:3101:b0:3e9:b208:f2f1 with SMTP id
 ffacd0b85a97d-4266e7d025amr8375593f8f.29.1760119722018; 
 Fri, 10 Oct 2025 11:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRYmjrEbOW5tZQB5EX1cuQL0R/205GY50m3ZW99WYI9mHGwXiejIfAF7YY5p/oSAAURRNUQ==
X-Received: by 2002:a05:6000:3101:b0:3e9:b208:f2f1 with SMTP id
 ffacd0b85a97d-4266e7d025amr8375561f8f.29.1760119721499; 
 Fri, 10 Oct 2025 11:08:41 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0011sm5216514f8f.31.2025.10.10.11.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:08:41 -0700 (PDT)
Message-ID: <8c43bb15-5aaa-4dd5-8776-686c546a305c@redhat.com>
Date: Fri, 10 Oct 2025 20:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/28] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-13-zycai@linux.ibm.com>
 <9acf7d52-0dc9-4c07-9d74-758682a5c62e@redhat.com>
 <4a05dabf-44cc-43f4-979c-82f6f554cfb5@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4a05dabf-44cc-43f4-979c-82f6f554cfb5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/2025 18.37, Zhuoying Cai wrote:
> On 10/7/25 6:27 AM, Thomas Huth wrote:
>> On 18/09/2025 01.21, Zhuoying Cai wrote:
>>> From: Collin Walling <walling@linux.ibm.com>
>>>
>>> DIAG 508 subcode 1 performs signature-verification on signed components.
>>> A signed component may be a Linux kernel image, or any other signed
>>> binary. **Verification of initrd is not supported.**
>>>
>>> The instruction call expects two item-pairs: an address of a device
>>> component, an address of the analogous signature file (in PKCS#7 DER format),
>>> and their respective lengths. All of this data should be encapsulated
>>> within a Diag508SigVerifBlock.
>>>
>>> The DIAG handler will read from the provided addresses
>>> to retrieve the necessary data, parse the signature file, then
>>> perform the signature-verification. Because there is no way to
>>> correlate a specific certificate to a component, each certificate
>>> in the store is tried until either verification succeeds, or all
>>> certs have been exhausted.
>>>
>>> The subcode value is denoted by setting the second-to-left-most bit of
>>> a 2-byte field.
>>>
>>> A return code of 1 indicates success, and the index and length of the
>>> corresponding certificate will be set in the Diag508SigVerifBlock.
>>> The following values indicate failure:
>>>
>>> 	0x0102: certificate not available
>>> 	0x0202: component data is invalid
>>> 	0x0302: signature is not in PKCS#7 format
>>> 	0x0402: signature-verification failed
>>> 	0x0502: length of Diag508SigVerifBlock is invalid
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> [...]
> 
>>> +
>>> +static int handle_diag508_sig_verif(uint64_t addr, size_t svb_size,
>>> +                                    S390IPLCertificateStore *qcs)
>>> +{
>>> +    int rc;
>>> +    int verified;
>>> +    uint32_t svb_len;
>>> +    uint64_t comp_len, comp_addr;
>>> +    uint64_t sig_len, sig_addr;
>>> +    g_autofree uint8_t *svb_comp = NULL;
>>> +    g_autofree uint8_t *svb_sig = NULL;
>>> +    g_autofree Diag508SigVerifBlock *svb = NULL;
>>> +
>>> +    if (!qcs || !qcs->count) {
>>> +        return DIAG_508_RC_NO_CERTS;
>>> +    }
>>> +
>>> +    svb = g_new0(Diag508SigVerifBlock, 1);
>>> +    cpu_physical_memory_read(addr, svb, svb_size);
>>> +
>>> +    svb_len = be32_to_cpu(svb->length);
>>> +    if (svb_len != svb_size) {
>>> +        return DIAG_508_RC_INVAL_LEN;
>>> +    }
>>> +
>>> +    comp_len = be64_to_cpu(svb->comp_len);
>>> +    comp_addr = be64_to_cpu(svb->comp_addr);
>>> +    sig_len = be64_to_cpu(svb->sig_len);
>>> +    sig_addr = be64_to_cpu(svb->sig_addr);
>>> +
>>> +    if (!comp_len || !comp_addr) {
>>> +        return DIAG_508_RC_INVAL_COMP_DATA;
>>> +    }
>>> +
>>> +    if (!sig_len || !sig_addr) {
>>> +        return DIAG_508_RC_INVAL_PKCS7_SIG;
>>> +    }
>>
>> I think there should also be something like an upper limit for comp_len and
>> sign_len here. Otherwise a malicious guest could force QEMU into allocating
>> giga- or terabytes of memory here to cause out-of-memory situations in the host.
>>
> 
> Thank you for the suggestion. I agree that setting an upper limit would
> help prevent unreasonable memory requests. I think it makes sense to
> choose a reasonable value so we don't have to adjust it too often, but
> I'm not entirely sure how to determine an appropriate upper bound.
> 
> Re: sig_len - the signature length can vary depending on the
> cryptographic algorithm, and I don't believe there's a strict limit.
> (FYI, in a somewhat similar situation, we haven't enforced a maximum
> size on certificate files when loading them into memory, since they're
> assumed to be trusted, as Daniel previously suggested -
> https://lists.gnu.org/archive/html/qemu-s390x/2025-06/msg00049.html).
> 
> If we'd like to set an upper limit for sig_len, the largest signature
> I've tested is 1165 bytes, signed with an RSA certificate using an
> 8192-bit key. Would 4096 be a reasonable upper bound?

Sounds reasonable, yes.

> Re: comp_len - the size of the guest kernel I'm currently using is
> 14,184,448 (0xD87000). When I built a kernel with make allyesconfig, the
> size can reach 261,005,383 (0xF8EA047). Based on this value, would
> 262,000,000 (0xF9DCD80) an appropriate upper limit?
Make it 0x10000000 = 268435456 Bytes, that feels like a round boundary ;-)

  Thomas


