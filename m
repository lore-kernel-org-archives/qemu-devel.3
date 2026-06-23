Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24466CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2bi-0005VN-GQ; Tue, 23 Jun 2026 11:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc2bf-0005SP-CF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:00:08 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc2bc-0005Qz-AH
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:00:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c6b67d5fa1so40914465ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782226801; x=1782831601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uQt5jQgMNJ1K9TxTzUJln1doC0qaM/3Kb6DJ60k6FvY=;
 b=wI2mjFDqtB9O26oyiOb7/L6oiZ8HLPqIfZE05YBcP7PbbAD7Zyu7rxcvqCR7eiX52z
 YAeVg51cCvPsPrroHOMo+/JKxkSGjUTVHDSzWyTOIDLWHp2IMpIobF/8wEA4z1A7qNrm
 NYJpzNxUxP0uZ3OpAZhXCXymVo6wy2Ob7KRhrubhiG1ujGJcElf5e7GBN3UiFwHxsnZ7
 yyHwgEwYrbc6ulOOc2Zpb/ZZxILFzoa31ShCoPDia9dTTJXvGWDBn2cbN3FeR0OcnAtZ
 J6z/UIZYpI3Phzg8JR/cLHa3B9kXdMWVFzUvLmRs4lXzu3OWYKQL1dBuUgsL62WGPwlR
 0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226801; x=1782831601;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uQt5jQgMNJ1K9TxTzUJln1doC0qaM/3Kb6DJ60k6FvY=;
 b=pC/UMjawF9tF2sgZB2ubfH8Q5doYVb4/scWKafUdvjeCq+8TBKOrn2ntgJ421hpQqE
 GOu0hpvOxKIHlXJG0ta1eRdUJRW8gvTm4yBvduALBmw6EYxOzG2dmVe0KWpeoU7NpUHe
 WQ3eYXChrAvyIOLGxpmu/nLlzF2MeeNkVmBxhJfZlgGX2Oh2ydgXLnCP73ciYVm4zzu/
 TmGC/EI2XFhr/+8m0/KGnOncEvyzprGIN9vGOBrxbXMYXXtZobV0UtgXzj3/rHczTTy+
 F8TRtnKIEVsrtfTchc9cDqKV4QjeMmDeKiN1s26FOX582zJwYHOX+2OYFI9hboNwQRJq
 wwyw==
X-Gm-Message-State: AOJu0YxMOvmeGU3TRPbiuCit2we+6KK8kk17CS7t1foLIynKbNgz0t13
 rmMA0nLP5MuB7VYttgeObDQbc7iWqqjgvLp6ZvJjOaFprAGuFqu6caQwZIguTrelw3iN3Cnoxbu
 lrxdk
X-Gm-Gg: AfdE7clpyyLWt4dcXbECihhyvmg6faHMSnADglzatUDliTIqjq4X6aOMP4twRX/BZC3
 mgrV4pIvpwxTsRMPdOIKRpXzmYbGCD4I01BEoMvHU/mfY7cY0C0WF3vE/aoJnP8TWbDGVjZsRrj
 dvDJLbyskpvYmh+c6ADLDVvx8S/+4eImMdGhVhHteKWRFib/KF8ZVTZKSu1318xDopx2+htKBvV
 xwUpgoGPUyV14d40jp4qqVDkrXQkHK36+8Uy+9JWsTrhjVYyT5bM7yE4DM+Y8v1H4sqkeupVfoc
 MYTF6T06kKKbyxEd62engvnraOcRIPygdiLj9Lybg+WFhkXYNW4o8NGYaholoDLa2fq6rqJp2Nc
 G+nSldTgbfhrUP2qLty9jc1yH29dSZBZiimFpXcsnCIAhNrTa2NtwSPXYyVSjReed0hm2oApb75
 QtQW9wRVPT20SBgscco7DpXXvuMCbZ9E/EacOGF14BlSmaqKZmajCnB5Hvr/fwWlTzDD3u
X-Received: by 2002:a17:902:ea0d:b0:2c6:abaf:85fb with SMTP id
 d9443c01a7336-2c7c771ddc3mr33756965ad.32.1782226801363; 
 Tue, 23 Jun 2026 08:00:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c74478ff1csm113382765ad.83.2026.06.23.08.00.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 08:00:01 -0700 (PDT)
Message-ID: <be80c6b1-f9bf-4af7-bcfd-23ef9c25abd5@linaro.org>
Date: Tue, 23 Jun 2026 07:59:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
To: qemu-devel@nongnu.org
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
 <e3c93122-d0e5-4868-bf83-d757c0d1e0d4@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e3c93122-d0e5-4868-bf83-d757c0d1e0d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/22/26 14:25, Philippe Mathieu-Daudé wrote:
> Here we want to keep logic parity, in case another RISCV
> accelerator is added:
> 
>          return tcg_enabled() ? cpu->cfg.pmp : false;

tcg_enabled() && cpu->cfg.pmp


r~

