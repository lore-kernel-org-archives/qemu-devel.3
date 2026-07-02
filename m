Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC370C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKid-0006OI-89; Thu, 02 Jul 2026 12:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKib-0006O1-S9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:56:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKia-0006ef-0D
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:56:53 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c82538b6b0so16961245ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783011410; x=1783616210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0yXqWSav02NxMHzDJClLmLOneTxzDlJLqoluzEcKTto=;
 b=s6HVvMI3Eg7aE5zJDfj7RTjk0gG0ZtvV10W85tQleOqlCT1SDb7ONIyMdFk9ba0pKh
 z6UxnpAXOcrC2WBcSwN5f2bQ11kJ/D0ZVH6xzt74WvgEpgj/a1ouvOz00Mj6fXlHcuuI
 0nTKF0axv8WvUM/XZ4wCeGU789aEYgPp0e28d2NjOp0bqSKiB+aBz4AUnHiX4Wiu2KeI
 whLu7DYMlmC8BS/Q163WkN8Ccojq1+xF9bzF3xaIhhD2ozdB667OrGO42vGDSpD90xqM
 /Q2YCERJu7LkKxuoGbDtwl+IpS0i69NZboD8ScSOHJCE/VBBdZpa7jtrr6yk3fLX7NhV
 Lwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783011410; x=1783616210;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0yXqWSav02NxMHzDJClLmLOneTxzDlJLqoluzEcKTto=;
 b=NB4a2ZTu/G5cEpb4aJnnvPHuh2bUSYzC1nk6qPxc7xdw2wzTCulr8IorZIShl6XR/Q
 3TliJ1cENcjoniR519oxk9ag7yuzzEVqbcFIyh/hxzujQ+uf1mOx3ELp00mu4tD2Ynfy
 yj4yKUazR/ddnfsM1fCNrmzFvDIhMUTVit6JNpXsdfstcCM71jTZGmxw0VvpWNeHbl0s
 obSUczDFdoUE2X5SHbL2trwlrI6dtxmckwnBDtzcI7o14+Jc7wsZrkavNibAoakgCf/s
 KUH0BQXEfdB+oKO746jIjmzESMVPqV83lRafRSUvIvpG0+6NhS2DE4ZWXK47HlqMZA1p
 hzQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcQ+rELicYGVtBm48s0/IWMXFztXMmAv5AbAcAVzCSz8LGKPsLE0UUASOGZ0MZJ2eoYLhh0K+M47Zo@nongnu.org
X-Gm-Message-State: AOJu0YzTJwLYhuL2tExSWd2P3RJBXCdXU5VR/NceD/Uu578LpHJ1rv0l
 ja7IEnRxERcm/KJgnDMefbXyfGDsRGBY0gKvlbGjCGRSbNVz/hDv9ZHA1C/VPP0EZwM=
X-Gm-Gg: AfdE7cn5rfN81sNhjTWsPEntkclqSsBPAtKTQJmeuAqzsR+oqxek6BRD6Po/ubxU1fD
 srVeFFeHAH9MNAy87YNSnFpQyJTjRAYPk5p3GPbEGAo8Hy2VHcoGDe8RwjS70ZQIUovC3whF1+d
 tqbuov/MTP+pE0LtB2sRXNB6ObZ79kB/6ZyyoGJooU5CNNfb37OI6dZvTt6nNXB1mVAZ0DJMh+m
 077pn44XyhNkHd6RxuMs9G4GQ85dJYZ7uyt5fE4X2n1Ub71uhCYn1VOd6OzqMLkrthd1GyiqLyQ
 ah2oKIC2/S5GY//ym2BKf27Teke6woNmYhgnuBU7/Y6Fve8RwSU04v/qx4CSLSG3Gnlqm1n4ljZ
 lq7mj8/YGU2jEvRcLJ17wzvpoe6HzGE6RtnDHzPMyuytHRtmTs0MBPTuajlFVH4PkHmaAbxI0v5
 JT/qnlMJQxmOlQ3P91L1nwZWOGNVch6/5qfGcuhJWndr64xBGzxH4BGLPrLk/S2vZjYfG2
X-Received: by 2002:a17:903:19ed:b0:2ca:594f:feb8 with SMTP id
 d9443c01a7336-2ca7e942459mr73888365ad.47.1783011410092; 
 Thu, 02 Jul 2026 09:56:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9aa0b7e9sm16456145ad.81.2026.07.02.09.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:56:49 -0700 (PDT)
Message-ID: <4ac69742-14b6-4560-a458-f484fba95ceb@linaro.org>
Date: Thu, 2 Jul 2026 09:56:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> No need for accel-specific @dirty field when we have
> a generic one in CPUState. (Other accelerators already
> did that in commits 6f13a0ada01..36ab216b81d).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/system/mshv_int.h   |  1 -
>   accel/mshv/mshv-all.c       | 18 +++++++++---------
>   target/i386/mshv/mshv-cpu.c |  6 +++---
>   3 files changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

