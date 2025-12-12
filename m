Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3985D59D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU7H6-0006db-VC; Fri, 12 Dec 2025 12:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vU7H5-0006dA-CO
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vU7H3-0001IH-To
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765561789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zAmHh+eiusTza03tnJTPzM7spfGtnjfNOZrUe/rjfGk=;
 b=cJlCj3EA81YZNbjw9LnAiGCT1DJXBkwPic/uKs2Z5rKY/LEuVu11CJlblLy/+M+9YzwI3G
 dlbD1EgtgFKYOi9jquaIGEbPEOaUkg2DKlBsMvgbDlVoUNrFR5IdLqG0GzmfatsH4KCEx+
 YWuuSpeem1xsCZ3rNCuyAhw9bq+x/0g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-IGczmDm0Nx-E_Q2l_43svw-1; Fri, 12 Dec 2025 12:49:47 -0500
X-MC-Unique: IGczmDm0Nx-E_Q2l_43svw-1
X-Mimecast-MFC-AGG-ID: IGczmDm0Nx-E_Q2l_43svw_1765561786
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so16844965e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765561786; x=1766166586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zAmHh+eiusTza03tnJTPzM7spfGtnjfNOZrUe/rjfGk=;
 b=VdjPctlg1pWAmsJT8Fgqm/N1uRJky/ocI5nKYEpFPTJZjTMxlbp/VktzPH5u2xoKjN
 pOuwaD9N0leZqhB/YkUy9rTN2PjP6jb3RqI4tjbjIEdsAMGE/Rh9KFK/pYb6R9kExMII
 zDgfC/G4i0gU1Pb75Hkmw+0O7huNQvm92c0xCR54+TD7uQPI/TGv8RAqNcWWaBHHbREv
 NuB2J0eu+KFo1x7AWW0Hpg3CZ8vKt+udFEgXgstLruhFzVHs+MmfpS+14jRIMnEEik4Z
 5iWL+Vnx+IRMxbI6bBPtEwlucYcGvczXVW9j9/G+GsxoxxEzA5wWQ5aulczVDvM65Som
 SHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765561786; x=1766166586;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAmHh+eiusTza03tnJTPzM7spfGtnjfNOZrUe/rjfGk=;
 b=V9sEw5KyJ2cyyrS035t5lK5gYiKY1aBj0ebk6P5dxML/rDZaI2zkdRjDDo3ueZhXyW
 t8OqnbfMq4ijwh+QtXTJ9KD1qNacHeEXn0kerEEH3LYLSrDHSCi3mOha9T14XKv5Y2TB
 QXgAomFPADb8zG6HnwJu9GWUk8FtNCuARMq1siK4ZEqSBg/VmoIMhB3kr9odBIBA2Uyh
 2EkX0ls8fTGS0wBcpqH4aPzRx9ofIv2YmTpyf0qdnIEBR5tT3EVAplibvmV35DgRs+84
 jcx0/WSfIAioUItN69bqRGBIs/tuQBMDKjxqAtAg8DoVRUeaP99Th49wMdbblDd0V0RY
 EWeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4grAFTGLVQ4RoTqnslS1e0z5pUBNcUfEfCPbPLQZoGDxLYlAhsEXc40dqsw5hiK0HWy3oluNmB4yf@nongnu.org
X-Gm-Message-State: AOJu0YwqVcf/4aBO2ARuv6NQ/vx5kDWdqxJJcTqziCNfwNOYr9NFEVfH
 RXeyeJKC1uvo3nkWHjuonPMk93sFtr3MeWoasNV5DiqZhjnba9jqpyGxVELFLqaBKrIsFkE7fI3
 qJ8Z0srUCFFct50WM57895msGjz9sU5ItNg9J2zSO3WICs/KCZhy9ggZEgFEosl1a
X-Gm-Gg: AY/fxX6J1eQ/XxHlyLtyoq1RLK9iEsG+pnYcMlqOJbbkYFKwA7jVUO0da2Cg2q1NNa7
 GqND1KOKf8bk2T/yPFSpEC0tBTAtgp/g87Po4ArcaIgqQY0py9Ewz2Exy35NAu/ilDrF8+ZzFsR
 agXqPdJ7vOl3Rq3PwPmR1hNlra6EdCDRiVtiTdgnNIlSLDAXNgWQhpQU8wQWiI8zXFADrm9D7+m
 QzyJpq/XSgXpMSqjOyC97AqRveeTWbuDnO8xUgZo/m5IPQR/jvHsfvRbHKxvySmf3GVNft2CtdA
 Iqr7LNdzrvo3yJWklx4Pm4CMvEQOPpZk21s+NuG+aqTqKqFCZuO9fGW8QysnBk+mvBRmNUIt6dH
 ++7jvYC31qemMn1OnRAkQwh1iFfd5pQ1HRiNFI8hG6fY1DZ5YYnmkPrRKuMAjxXtIcMYPAYXQes
 CCeIC4I5nD/KkZT5M=
X-Received: by 2002:a05:600c:6290:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-47a8f8cdc9dmr30216195e9.14.1765561786029; 
 Fri, 12 Dec 2025 09:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe6e5jCKdlXhY8Hq2tfIl1ke0rzWQMQte2yQoybqQ/+kfZdMiDZLYQCa8RAV9tqXU/YkYH8A==
X-Received: by 2002:a05:600c:6290:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-47a8f8cdc9dmr30216005e9.14.1765561785668; 
 Fri, 12 Dec 2025 09:49:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8d9d63sm42015625e9.9.2025.12.12.09.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:49:45 -0800 (PST)
Message-ID: <69fdfee5-65e5-436f-8e45-6b59fb47f654@redhat.com>
Date: Fri, 12 Dec 2025 18:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/i386/tcg: add a CCOp for SBB x,x
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-18-pbonzini@redhat.com>
 <46a7f05d-c810-4112-a2a7-84c014e4de22@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <46a7f05d-c810-4112-a2a7-84c014e4de22@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/11/25 20:11, Richard Henderson wrote:
> On 12/10/25 07:16, Paolo Bonzini wrote:
>> This is more efficient both when generating code and when testing
>> flags.
> 
> I guess sbb x,x appears quite frequently in x86 setcc computation, and 
> the testing of the flags is much less important than the straight line 
> code generation?

Yes.  And to be honest, in the most common idioms generated for a modern 
processor the whole computation ends up being dead, so it doesn't really 
matter to have this vs. CC_OP_SBB or CC_OP_SUB.  For example memcmp uses 
it for "(x < y) ? -1 : 1":

                  subq     %rcx, %rax
                  sbbl     %eax, %eax
                  orl      $1, %eax

and this is also common, for "(x < y) ? VALUE : 0"

                  subq     %rcx, %rax
                  sbbq     %rax, %rax     ; could be sbbl :)
		 andl     $0x1234, %eax

In old hand-written assembly it is used more creatively, and having 
simpler generated code can matter if there are memory operations after 
the sbb.  I did this just because it's silly to compute both negsetcond 
and setcond...

Paolo


