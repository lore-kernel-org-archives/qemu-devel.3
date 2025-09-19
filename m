Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0212CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXgq-0008H4-V7; Fri, 19 Sep 2025 05:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzXgo-0008GH-KV
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzXgg-0000Lj-PY
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758275148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oN9Qrl8owBtsZCUDmsVldXGLRQC5qTDLqh/TE7NoBcQ=;
 b=LlOBayMrPKHSuNoU8kRiDG/e90s4+eZ/PqPSvTLBBkKs1sejL86T7OcQ9uoZyQTYBhA5jn
 Zon8kjZCR5SRm2jCqQ8HPaEprtEDw9zGZO4QycHFje/amQZVR3NODhzv8plEsunxbEx9DF
 pAGo9vCYoqA+ks28oNd4E/TKZab0vFw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-pFbQ-MfUMc6Zm2wQ3fQLKw-1; Fri, 19 Sep 2025 05:45:46 -0400
X-MC-Unique: pFbQ-MfUMc6Zm2wQ3fQLKw-1
X-Mimecast-MFC-AGG-ID: pFbQ-MfUMc6Zm2wQ3fQLKw_1758275146
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b042eb3ac03so225680366b.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758275146; x=1758879946;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oN9Qrl8owBtsZCUDmsVldXGLRQC5qTDLqh/TE7NoBcQ=;
 b=m/ZhN8ZU3RuhQeE/xLcCEPJ646pOaBF+NRWbRie67RLUOsYSueNrxiDhTDA6Mta8ag
 Z5HJvWjnPaUvw9ZtWscELZ5bc1HWzuIfNnOMJCYw6y/0QuNpnmDF8Ye37nvelL6fvgRB
 K+A6sOTHZ8Yo2pp14RgD+wLkgfWBcafcHPNWf+2nYYFq7CCmsXopP4VR3OFCGPcRkMqN
 h2v94DOL6742l4gN0FV/kDosxxd4Gea52qIIK396wd9k3qDpPP9Y1KmkVqH0ijACyyQg
 bjcfc0oeSk+V1rf0s3iHOWaB7ua20qpeM86flrAodRAUgYd950Ng+lm9xcHJpEgJZfvb
 kAtQ==
X-Gm-Message-State: AOJu0YwP3SxuiHbkHny8w7pNC3f6CJYxDHzdxn1xg4EPCiu5sqnBIkmx
 oedQbu6OlQ5V7SnBdqZbceJvQqx47Lut8LgAgCwKYXGBhnDCqauzgIjnNz5CoI+VBtDPtpBr9HF
 XZCoaT530ezqiknEt033Fxgf807NmNUzidR6nSkSR/1BhZNEzSiCpXn3/
X-Gm-Gg: ASbGncuW7h1IsHWe1zVN4qs5s+cMk1bDo7Bx+jKyr1lcY7uY7k8AXkn82mavhqqsSef
 M34RqmI2BSjp6ixCXULA8JkdE4CV0S7quVcoMsiybjBRLBi5GcM/sv4DyB7/V03KOQVL+IF9GsE
 g3im4TQ6Bhdof3NW2br2h/6cTpx2XOiKQS4VYfQ+gzB4YIZcPa49qDl1pNq/zEUYPAu9eGx4Ltd
 pZP8yCe6RxTOK2b7dbRhe9KQLu+Sbizvkf64amhbQ/YRLRS4hYgeSaSI5a5s+2rF7QM5EDpiyw6
 wbaK9fXk/Bz0IBSi//5PJe1Sc4tQtz1oImn0dx7i4xS64usCr9EwtfegGtm5AKd386hrIaDbRbB
 hL/+o0zRD5iDH404tp1D0xZFfLxlEBy79DaGAk1wsBfEg/WGn/xirsiptue4Ha+cxeXf4+vvccu
 7HEzcy
X-Received: by 2002:a17:907:70b:b0:b07:e207:152a with SMTP id
 a640c23a62f3a-b24edd536cbmr263302366b.19.1758275145600; 
 Fri, 19 Sep 2025 02:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXoDVkdFZYeeYFmYC0xjrx345tMqGc1mr9FFT1sEgTPovZdWhZZqgae8Nof4PDql1n82lK0Q==
X-Received: by 2002:a17:907:70b:b0:b07:e207:152a with SMTP id
 a640c23a62f3a-b24edd536cbmr263300766b.19.1758275145120; 
 Fri, 19 Sep 2025 02:45:45 -0700 (PDT)
Received: from [10.108.146.123] (93-45-222-212.ip104.fastwebnet.it.
 [93.45.222.212]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b241835e465sm211706366b.33.2025.09.19.02.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 02:45:44 -0700 (PDT)
Message-ID: <b5f23bd5-de2c-4f1f-870a-c74993ea05f8@redhat.com>
Date: Fri, 19 Sep 2025 11:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: avoid -Werror=int-in-bool-context
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250919083612.86546-1-pbonzini@redhat.com>
 <CAFEAcA8BBisMO3VJF=bb0a7oQCK16P4NhtTxcWRNRg0yMTWtwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8BBisMO3VJF=bb0a7oQCK16P4NhtTxcWRNRg0yMTWtwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/19/25 11:33, Peter Maydell wrote:
> On Fri, 19 Sept 2025 at 09:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> linux-user is failing to compile on Fedora 43:
>>
>> ../linux-user/strace.c:57:66: error: enum constant in boolean context [-Werror=int-in-bool-context]
>>     57 | #define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }
>>
>> The warning does not seem to useful and we could even disable it, but
>> the workaround is simple in this case.
> 
> I'm surprised this is the only place in the codebase
> where we treat an int as a bool...
There are some heuristics about suspicious uses.  Examples in the 
documentation include "if (a <= b ? 2 : 3)" and "1 << a" in boolean context.

Paolo


