Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73148D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZywl-0001ha-7y; Sun, 28 Dec 2025 17:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZywj-0001h9-7b
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:09:05 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZywh-00038q-Nn
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:09:05 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fc7893c93so54471827b3.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766959742; x=1767564542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q9AcDac+MmW6NxNnIlSv8XyAIxHc+6KyWU+PcV0DW8M=;
 b=gqXJlY9dmAetMLHogtG2rS7++GMU44jQr6pTyxYfEDKPlC+2i96tWo79dI+c8N00zv
 NtZWxCOu3jOFgIYXw5g+UPcZRUUwXO4cCIOsY4e2MLXhKPLAoJkwgh2WHfQF3Ir7m/gK
 PivgWNfp4bo/Mu0ftReEAz1jnpaHiBA1ufr4+ronDJGboVHV0IGs5eP9TpC7XtEldWqx
 e06hZjIXCsXRQKPjXtNzMfpdAiq02jh3hSZQtVjPB2zDzmdV4eRGcYFxyqUW2pJ9R284
 CS7uUUWPa44G9nLM5kC+Jr9FN+P+ZtDwsWg+vLtI7idBhVmyHl5ghLGkJZwD1KPfDJy1
 oGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766959742; x=1767564542;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q9AcDac+MmW6NxNnIlSv8XyAIxHc+6KyWU+PcV0DW8M=;
 b=B0WvAm2GSExBUDdZTLo8pA7vmffpc0b5gm4nJM+wawC3LmikoJDR8k/BynWEQsnUXk
 V9VQoaq03fSUmWtABzW67yNAW2rTpMTIPcxN9mLnZ4tCdJEymn1ywDmfUIBTeGH1PhfS
 SUwYJ5K3SqNFfvMSqbKxAyvaRVMSrRncdp44BQdJaMtj4aAiE5sDHnqBqIt+st+XKoMv
 8FSAv6wPfdJq/U8hr307H71fO6txu7byIcpCAa22+Eg8tcU2k3V8d/EO1bjiz0rSbjqd
 38/UyfJl2Qdgvrf7js6iHI7nAJDvgBVdjuRbL+uI/Jhs7SS8mrEBozBKblEblw5bNWCV
 xDFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5eV/B7rXQ+KnOQ0zo0JSDZc0Azqz+SeoFR9d6JHU9KQzoFYixyR1s8MPpZ9Q5RVIEMMAy9647318J@nongnu.org
X-Gm-Message-State: AOJu0YzuauCXiBDTv8IJ9uqgBw5FbVsyxDl/59khPPP6d9zKwoMfdy59
 bTgnsYouIHfCHsxSCkO70FKx+aQcVB6HuZMZNJImHxCaTt90ocFbwsyEZgppNSBuRbg4FL1Mk6G
 ZdtwV
X-Gm-Gg: AY/fxX5DXtWd6ji1NFbdVuGIsIJIuWFTrwj5paOErqX5bGUWPtaWfgZcqYVFF75MTAr
 Zwn3/tSscTTFVrZShFLDcNfVBwUX5PeAsLC/3wp7rQyA03EtHsHHREMIEFVMiXqhMue7jLnw4ku
 oancq7AQhHbDwhPEBYo/ICGXa4nqvk1MkYtSpO4tnpBmMD95cvqbPhvE7MDUN7hCt5fJ/ca23TB
 DuABgjYWEBtRzXfPy2ojl94H/Jd1gXssgEwfoTpDFjYVaOKV1WekKMsuBr6LVvHLYWmuZ9CD7hC
 pXOaOZsbfFFAB4jDqkJipMKyGAEjEJdkNdBwiHhcEE+e6no6SDbBW+R6i22fED2ePEAS9E/YHI4
 jI+NBpjiNPz8XfPpJMhj5nxKv1HKBM3Ws/fEBWarym8ySiu24oldvQsCOVFHQIXfG20EsNKTLL5
 KfeG4IbeimEjzxRRlLyHQpTApFpBA2eej7qvc/k6T7aHtbieTKpCAX
X-Google-Smtp-Source: AGHT+IEMAU3DcSPIZ7ghoepGldo4C8+J3hACHbcsAdjAWFTmkC6t/gpgno4vV5Eot3JITQ6PjznSBw==
X-Received: by 2002:a05:690c:2606:b0:786:68da:26d6 with SMTP id
 00721157ae682-78fb3efd2f6mr214495597b3.2.1766959742561; 
 Sun, 28 Dec 2025 14:09:02 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb44f0d4csm108552307b3.37.2025.12.28.14.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:09:02 -0800 (PST)
Message-ID: <6c3ffe8b-3dc1-47bf-b3d5-b21f34c02bb8@linaro.org>
Date: Mon, 29 Dec 2025 09:08:54 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Hppa updates qemu v11 patches
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>
References: <20251223155031.7110-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/24/25 02:50, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:
> 
>    Open 11.0 development tree (2025-12-23 14:45:38 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-updates-qemu-v11-pull-request
> 
> for you to fetch changes up to b2c2d00f48cc5f4486cfba33b505ff86d79cb137:
> 
>    target/hppa: add 64 bit support to gdbstub (2025-12-23 16:41:56 +0100)
> 
> ----------------------------------------------------------------
> Please pull fixes and updates for the parisc architecture:
> 
> - New SeaBIOS-hppa v21 mit fixes for 715 machine
> - ncr710 fixes for NetBSD and HP-UX on 715 machine
> - 64-bit gdb support


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

