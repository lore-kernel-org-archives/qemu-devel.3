Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D28C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZt6I-0008RS-Cz; Thu, 10 Jul 2025 11:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZt6G-0008HS-Ak
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:22:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZt6D-00028F-KT
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:22:15 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b390d09e957so1235250a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160931; x=1752765731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEoTXgRz0r1JXBkuJgTFSZMlBVgFwP4cgpd1NxFdTF8=;
 b=wSbha+/2kMG2bjh9wEk3wuu6kKkYwIscY25oTSXk5t8Bb+CkO4RFE58m1TAhzzF7Ek
 igSE2L1agOuNZ+/sKI2L86x996/AdafyqXfe3MGc60RIlwXWYVcpBrNU7GRlTxof6W8k
 DJrSdiHjDbw+xmC/ze2rv5eKY1bGiCLKQS2ZrI6Q4eXCfejadQUitNZ54W63tCfN88ZJ
 OnJpmu0KD2NNBNOmIdEJgM3GuU1B5I0EGrflwn0UiV28jfNXQq3nRhXaipidGnew+Mmd
 Ulpg6yQwT6Scwt3G0yfFsffZCL5epfgs2Pn0NSXvjmd75CtLq1HeEC87MnNkJZ57OE7P
 eIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160931; x=1752765731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEoTXgRz0r1JXBkuJgTFSZMlBVgFwP4cgpd1NxFdTF8=;
 b=JwyAWLtE2dg5mrNyJR27NwWRVpJThArsEuFRBqhI6wIo9pAqEEVin3f8eIbQ6H7KDZ
 pLPqr51PrHXq7RK/jPf7ANJtNanW53wEszZXN7ZePQn1XuUUbS5DcK9HJDm7/mPJNJ0c
 uB8MN2d0O3jIxen//YHI+m8JYhGNGpWTI+5f07YiPUbO1bgwpK57VmVnmZCEfjGRh/+P
 ALHienDz2LIo2e0XaMeOq8GbjkH8l2BFU/j/k9c1vtECD3QNWoAZJWiYPLg+M17zgX2M
 w4IbpJOHyvJJuzTKYe35FjKnLkYDFx669H/ZZrmHm+4aKxxc1gnDnkbS8A06ajT5eLU1
 crQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8JWmcyNd6okbFQY06kdZPuiVhsY8P7+B0M+YanXNUuwjs81+sZbvGJiqmT3H+d06WV3TxfYqdx2C+@nongnu.org
X-Gm-Message-State: AOJu0YyCZtT+P8UXCTqbfpviyFLCCtRUQWGm4/HO8aGD+D1engd8aYYY
 TzrDjRE5b+qdC+MPPglewxIQ4lSWd4BZ0zeO1bxq1+iFtgoPiAazEvBBuR6zn452hZo=
X-Gm-Gg: ASbGncuP20u0xMYnGBuYj8nwlu8c/IVLOLbLeqDGTpU6IRWG/TlN7w5PCiXSRIIhxJn
 sVR8eBK07T+X2YKxWSblLo4JfjTzZE9MpyC57KobR+vgt9GNDaPDUc1iOZkWaUVTFBJeXvLqCH6
 8HwYX0AgbG+NvQ2horoRZxjIi+EiccDQxgt0FNnvMEBkSWUqKsUFsjOMxqWq+NsvTfen7YrUfk7
 Fr6vX+Ar3MMv8WftkmXn5Y2oI5pOxEVLAZRq28PV63k0bPMjXPeFby5aJ7KelfZeUzaNg2f8ZtX
 XEfKnvk2eS4AbCX3msH6qoEC8He6WJ1JMHC4wyIzizvSWi9mxMEHMERT6MjabYsg0Ww+K0IwNbW
 faTGCBYeaaA6iz8PjCR6zoIjXeJpQWhZrpcw=
X-Google-Smtp-Source: AGHT+IG3RBebeDDtWqMXM731ZLBqB4j1gkb2cHXbW0BGSPJpxXKhOPDbhBpa3YJQqOHQ3humGHsVPg==
X-Received: by 2002:a17:90b:3c01:b0:313:23ed:6ff with SMTP id
 98e67ed59e1d1-31c3eee922amr4502109a91.1.1752160931155; 
 Thu, 10 Jul 2025 08:22:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c368240ccsm4703761a91.30.2025.07.10.08.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:22:10 -0700 (PDT)
Message-ID: <6174cd5a-2024-487a-9218-5cb839009264@linaro.org>
Date: Thu, 10 Jul 2025 08:22:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] contrib/plugins/execlog: Add tab to the separator
 search of insn_disas
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Yodel Eldar <yodel.eldar@gmail.com>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
 <20250710104531.3099313-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250710104531.3099313-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/10/25 3:45 AM, Alex Bennée wrote:
> From: Yodel Eldar <yodel.eldar@gmail.com>
> 
> Currently, execlog searches for a space separator between the
> instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
> use a tab separator instead; this results in a null pointer being passed
> as the haystack in g_strstr during a subsequent register search, i.e.
> undefined behavior, because of a missing null check.
> 
> This patch adds tab to the separator search and a null check on the
> result.
> 
> Also, an affected pointer is changed to const.
> 
> Lastly, a break statement was added to immediately terminate the
> register search when a user-requested register is found in the current
> instruction as a trivial optimization, because searching for the
> remaining requested registers is unnecessary once one is found.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
> Message-ID: <20250630164124.26315-2-yodel.eldar@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/execlog.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


