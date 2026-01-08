Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2090CF6A87
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlk1-0003Tg-59; Thu, 08 Jan 2026 03:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdljz-0003R3-Ce
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdljy-0007M4-1O
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767862292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QJv/LjjzmZL9+mrd3Jsc4z1w5aRLCMtL40pvm+G/rtE=;
 b=cHczookaFb3jhLyboqCWz+6+jf2dopAXlVTs0TjbEEhrifkdzLdoaoTbxtePK8ni/Zg4Gb
 UpzE7hvOY80O0uGO1PRPxAho/DfiBMKat5Ft9FOi/8tdJXIR+SWwS53dQBTOF2flIgHzuG
 op9iYYB+NnHMAhhreGSgevmexqMqbX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-y6O_y6YiNWKOC6lo5WF9OA-1; Thu, 08 Jan 2026 03:51:28 -0500
X-MC-Unique: y6O_y6YiNWKOC6lo5WF9OA-1
X-Mimecast-MFC-AGG-ID: y6O_y6YiNWKOC6lo5WF9OA_1767862287
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so26955235e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767862287; x=1768467087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QJv/LjjzmZL9+mrd3Jsc4z1w5aRLCMtL40pvm+G/rtE=;
 b=l3qVjdZQ9NbbH4/pJ6a0+4CZwLIX+SuzJNF0U3/xK5psJnt+CmjwLxCmxmLxFArZkM
 5U6GcTDYF9gZVxGCJl9TlthFNoys/23hrzqV1rVBkL8z0mOGczVcymm2WfrkZkI1Qp/u
 5I7HaPx4BMIgFqdtkSa+BCiL0njNUCEEUEdwpraGbkOu5la+pzByT0crv2KKWIQZVzez
 iFl8giybHBgLYKIhOJH+6keTmUIah87UI5MxCNIQcCeUXHF/SeOa0mUJNyOiKhXr/6+y
 8iBgsYr+qibEciWen3wuB8p0X1TYym7Dq+P+sHvXyz83kAGLLmzBkEuP5HxmMAa66Dqv
 t9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767862287; x=1768467087;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJv/LjjzmZL9+mrd3Jsc4z1w5aRLCMtL40pvm+G/rtE=;
 b=wPzoY1rWjRz2vNuAoq5eoeKmsIX+h8KCfkHRz8mDdnsX+TXZxX+Ltm9zhmlRzfwS/f
 zM5eqLOzajOYLznKp/lkqFvnP9kAbr+APIEN52Lxz5VO+Yfrfz0VY0PoGDPdSZjcWDBq
 4yqqxXPnFyRNb47IOSdXl3ilLSes2am8ltlulIiamzo/zJas8SG9A2mzCO0mB8gpcRsv
 oxAzZiYXehiv5fGqaw4QIW1HmALmjtHcprBInwEGWXcoaPi+f+XIo7DQ56yfZo6097KG
 dMCsEbXRdHk1FMz9NJKjpQeuI14G3Hz91rrOXLrnd5pO4V1HEe5qkKuC9xELvbarSvON
 cfAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjiwMwSFgZo4yp1QKXVf5imFiD88EnhlyA33ElxDXrSolnIVBYmybVWnIvhhZE+NoiWbAND4jMAEXI@nongnu.org
X-Gm-Message-State: AOJu0YyAVBIXPqSR4fp/r78Qyq7fzHRqbm6Eu9cjZXJaacfRvvW075lf
 XSzSyqdZnQvpzKqeP6BR9KFDCiUW0QYeg0kUx0/1RFgV/9n7sVWvEvqlNA2n8RgY+GPtSHZ61Tj
 f1QcqfzBITs6M4KDFrBSMOfPuu37q9JbP27DmtTe1sIjR5LYEhIO4NPhB
X-Gm-Gg: AY/fxX4n3feF4XvHl5eYZ8fJ7uzbZO28yTxSVseNuei1iJA/lO7nsXRhfv/2sk8Erix
 oOoBG5+NKosT2dsOoZDkUKlzqHxxmnqQ8jDMDapT1PSC2BGjhHqe2wxJ4Y+RV+unb5jYRPIL4oy
 gzcim0zUh9k4hz8Xa1596bOJ+rlFNV4+9AC3di2stz06LnrBSf/IfzjtRu/ivWHXXOBSJtpFSt9
 Zk8XQGsk8t9q/dByZlwTp6xaImhi8nkbyYOmXXrjrVPurk+QO0QYT8Ta4jPJc4AwyoMujHd8j41
 xEWhrUAWSaz1pzhY9B+xwUKYkXJSubWJf1g16NcfUbclFJZ+VeC5js3zVXs9yV8hiUn1i+q84F0
 kVV561fs=
X-Received: by 2002:a05:6000:2511:b0:42f:bbc6:edc1 with SMTP id
 ffacd0b85a97d-432c378a147mr5856904f8f.1.1767862287476; 
 Thu, 08 Jan 2026 00:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo9KV8fAkPIYgjj6WJSsUdLw/h0C92NYmU0T7Rq8gy+eiSBiB45fNtQYX4TsPhaHC54I2a9Q==
X-Received: by 2002:a05:6000:2511:b0:42f:bbc6:edc1 with SMTP id
 ffacd0b85a97d-432c378a147mr5856878f8f.1.1767862287110; 
 Thu, 08 Jan 2026 00:51:27 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacdcsm14965895f8f.1.2026.01.08.00.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 00:51:26 -0800 (PST)
Message-ID: <def072a9-bab0-44ff-919d-a294adc8e03e@redhat.com>
Date: Thu, 8 Jan 2026 09:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/s390x: Un-inline KVM Protected
 Virtualization stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-17-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/kvm/pv.h    | 27 ------------
>   target/s390x/kvm/stubs.c | 94 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 94 insertions(+), 27 deletions(-)

Please add a reasoning as patch description.

  Thanks,
   Thomas


