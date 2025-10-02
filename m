Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F4CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Pcq-00079W-8T; Thu, 02 Oct 2025 16:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pcl-00074J-66
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:09:59 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pcb-00029C-9s
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:09:58 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3306b83ebdaso1486900a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435780; x=1760040580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mDoS2pqvQfz1ASfGXThX6DK7RU5e/oCj9Qp62sGvcAM=;
 b=S9lLM3mRCDRtlfe2nNL2cbhANyALzg7A1GX0NsA9H2YvFe4g9soY0D88ZMR01g5wCU
 Gi3B3HWBbBJuRxtTQQ1rxOzdISYrWpP0I3xRImsqcLdwoFLJ6orO+7bJ/1Fuq0OXfHWQ
 zl+FhzJWNCnBp2nYolq5gT9yyyhMlQTIq2qd5JUEqCEi0ljTkUYNbmM8K5uxzafEKLrR
 WeK3TiZbxSsHJxpOES/BFhS+MNLqVoZurF9zrEuOpmEPZ8JNBkC7YEI6DdAY31CX7h2B
 RedLaAIdZ3YynGqyF/yCvrXPpB4DOYi5AbxonhCfR7073dVtH5YZNtmvLwJiErXARYS4
 XvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435780; x=1760040580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDoS2pqvQfz1ASfGXThX6DK7RU5e/oCj9Qp62sGvcAM=;
 b=MAZ6RgwiuR7dY5NVFpeHcvoHyDQgcvUKNbNRgDDlmVMdAq5Yws+KZRzr//Eoy4POuO
 /Uho9kRLbBRPoF1i18vB3MMFvxEUXsAqQBVZjA8oFxKASsB8dPL1M0EQa6reEXnLj8JX
 2tOZ3M8LxEi++W3hDkaPAxatxNodkxyCglc6gUoclG5Qr6A7cxTu/8VG5Go+MN/ip3wS
 YAgQTwNj4hwAre7a0XdL2U14sFk2bTnaTTHd+TT5BDx+4mYGb8MXU0blUR4INd60Bp8O
 gl1K3CbU+O/XkOJOgdUk8ozRP5dh1ZuIv9Zr2GQWAqr22x9xs2WWIjGCOwWXAKrRdt9F
 Z8Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMwTQmDjA+NvYl+wCMug2Fjqfh7tPKCFWZlxKCPW+yCOQ6v5KW7K8/PYXQizn2ozCJAj7AHltpuxSa@nongnu.org
X-Gm-Message-State: AOJu0YzZVIwpyxHq5Xic2tBnmCP5bgAKnyw7f35d1U3KAzBF1Dt/lHXl
 uytad9CAAm1ie4JismFh5+YqjYsACRQaaAqsg9Quazcio2TZ/5lMNM8H1jzD/gdTKoo=
X-Gm-Gg: ASbGnctNraVNFVRrwAmVdYsFHNO2xV97LlZruhwXRa5jXCIEjcFnUCs4gblDPDAia9m
 2XR35YtrpS8YnlRacJLBMsIEySe26xyOGWKllutIVhazrd0RjAdTr1bApBgetohWU2i8nssk+Vo
 lU7QydudGtVb15HVvcu9ZCUtIoT9Otw04Md3dI4PWQeA1qUosLkyUFk1Kc6YCN1PmBlmLXHMBF9
 dwa/cBWQpQEJA+dbhgcHZo2ICDlWYUEOClm2vj7ogtfglbmXSExzGuaO62zJkmWOMGknYAfK0oE
 5rCtboDJCLcFRpa4RrFwC26ioBqWKOrU347kIBL0c9X/LlA7bkFHGXq6ICgd61GkvYWLLS4fQ0j
 BsPZf8SomTRzGTM24Gza1WahYOf5aQ8LeUU5GZZCUHFPtfa7ka3vUT/rYJEJMu3A=
X-Google-Smtp-Source: AGHT+IG4W0mGyJUJexVW/e577I+WaRQYZD1hTTOpiCWBs1OJh+/vtsnrbHn9CsMirCKdK22VK1AS9g==
X-Received: by 2002:a17:90b:3807:b0:334:18f9:8008 with SMTP id
 98e67ed59e1d1-339c276986emr659138a91.8.1759435779717; 
 Thu, 02 Oct 2025 13:09:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b60998052e1sm2645626a12.0.2025.10.02.13.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:09:39 -0700 (PDT)
Message-ID: <b35ddcd5-2b1a-42c3-9076-570b128c3f90@linaro.org>
Date: Thu, 2 Oct 2025 13:09:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/33] target/riscv: Fix size of [m|s|vs]iselect fields
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-23-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-23-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> [m|s|vs]iselect are defined in version 20250508 of the privileged
> specification to be XLEN in size, however QEMU only ever uses at most
> 16 bits of these fields, so fix them to 16.  Update relevant function
> arguments.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     |  6 +++---
>   target/riscv/csr.c     | 32 ++++++++++++++++----------------
>   target/riscv/machine.c |  6 +++---
>   3 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


