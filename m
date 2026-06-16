Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5AFCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXx3-00057W-U7; Tue, 16 Jun 2026 13:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXx1-000573-D9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:51:51 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXx0-0001mf-1i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:51:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so452308a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781632308; x=1782237108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXaBPyvnHd1RWGc0B5xQB6nNWkmpNqrNl+vzLSCG9NE=;
 b=nkty7HaN3DMF6/0it/2MGEUOuW//dSo5MV7I5gjyadt1HstTERbQfq+MGlYpIjS4mM
 eEG9P27GHUg/0rK3nJ9he46h3Yb0Vmm1yXUww+0fyMx8hwO3LYRjmdzwzPvcFRDnbSRc
 cjJLHOFauuaMRSEmMh4hP1xXwEUblNhwaM0PBfXYWcNGxxIWkePKKHdnOnmYofDncTco
 SFzmTOGSXZ1lU7WLu3n6wT86cvQ2EsNo/V69wMzLNJsu9D4Z2nmMDUwWoHoqeHMQu1bK
 6e/xssOtZ6SikDimAZ2q98ZVXFJV6bfmOT2Hioqay7z35XM9S+XSj+8DfSsZQ58Y+lfE
 0Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632308; x=1782237108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXaBPyvnHd1RWGc0B5xQB6nNWkmpNqrNl+vzLSCG9NE=;
 b=FzSban35nWVAorqjIWudUTe1VFy5tjjeZtbBcJYKVDhSB/cmNtGmI/DSQymFXT/8ZF
 tE06ObShmN+OcNXthENdHbxGOjmnDDIstZ6Te/2Jm+3PkiuGeMbReRm+vDQYK97Y8UoK
 GFwU0333aDkVhY3PLTvFcPDLqwZ2whRkTJN58jp87o6OaR+oTiL7j0QKezLX6gt0AAwz
 bBIcy89xGhOYxFhSk7PVgLYtlxA6NBhzRWgCX5GWPzQvHULYq2lS0uS8ioJ4LBVDbVUz
 Tzh0oYhIJNmgTjTUrB5Y9GZtIYQfj/0/ZUIeSxSCmGJ3dY7y6u8PxDYIV1zPbQZeZX6b
 PbIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tgoMJYMRII4ygUvi9dDGE0hNJma5mJUSDTAK9+gQBkpNkXYNBEfcY19fGHCwzWEaq30ngh0rn9J4F@nongnu.org
X-Gm-Message-State: AOJu0YzpnDAk9CcSPZ1mBTPD2Ch4Kk9Tal5/kJXeTGv+eit1yB4ASk1F
 POgDwms0Vi9oNtJB+AriZzixn699kn+zW+NMSfvFq7rAkCMolGdBQ5unUGTfnH+bBbQ=
X-Gm-Gg: AfdE7cllRM0hG/2aWvTYZ2+rOrPMVT57PLe+jV68dSfPyWr/nyq99G6wUE3hfyeYnkW
 Sc+ub18KLSVTl93b9RIm4PsMtmTrbmuGc3DBbw9jJfo69KgGlP/g3bOCDvXCrjLClXAhCC8TWBP
 Ryu1t+JRxa2iF5U2S1q6+nezCg0jh9ZX0/DpPjq3Xdri7XyL2TWfM0Z0F4OnfQPto66tpn0rB2t
 KCasvdlMdp+RecaU0BNiH6oL2iaK8d/5lDS2f83K+9MenguQapKHT4KhHfVczqiemCvRvTOqaWO
 /JNEgxktYkpAeF/OiTZzXN7BkjqD5Ci1+zIR/LfwLYXjB+Epd75qutnmaaKTh8owNuXSwAnz2be
 Bis8PHKZzlGbueUFVEZOi47HVuxXGqog2n7Bt+7rjrm9XLkOKcfDpe04awB7FKCUq8Uy264FuLD
 5XrFrtmFup4Ae92UdcoIBJ2eoKjKu/UJm9Uvyl8YfnD4XdrWT9DUwfHKgkSQbrS+Ogif6F
X-Received: by 2002:a17:90b:3b87:b0:372:94b9:76d8 with SMTP id
 98e67ed59e1d1-37c9dbb45d7mr70735a91.6.1781632308242; 
 Tue, 16 Jun 2026 10:51:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ae7d1sm3414262a91.3.2026.06.16.10.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:51:47 -0700 (PDT)
Message-ID: <b6e7d0c2-8d25-4f25-9d50-b0454a0caae2@linaro.org>
Date: Tue, 16 Jun 2026 10:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/ppc: Restrict TCGTBCPUState to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
 <20260616153432.92939-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153432.92939-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/16/26 08:34, Philippe Mathieu-Daudé wrote:
> TCGTBCPUState is a structure used during TCG translation,
> therefore not needed when TCG is not available.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/ppc/internal.h    | 5 ++++-
>   target/ppc/helper_regs.c | 3 ++-
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

