Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6941ECF45DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 02:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfUKi-0008Fj-CX; Mon, 12 Jan 2026 21:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfUKg-0008CT-SZ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 21:40:34 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfUKf-0003PA-5B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 21:40:34 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso3967761a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 18:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768272031; x=1768876831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMI8lCSI2fMvLpzDFEhPaTzQFVHNd6Yp5HxlIfX0uaE=;
 b=mfEru5+EPV+WwjRYAHde+pOjJkO2bQzBZ9M7ICyg59aSRX6KvmEvHfj7AP8rui04fx
 TeHuWbsjho7rGvzNCDrRN4F1kcrsLMHB5BoDoxbvYpD0X6umHouZYXlN6k8RKLd9kyXX
 Q3Fk0Zo/36vj2Jm8ExIRf6yHkbmUriqxxU/OrVYPBUvejvHwfj8saU6wg5X+a85ksnB6
 EgQHYuoy8Ci+y0+mzTjtkmHA+AV3AbR2kCg3FhIDGTZP2zgk44fv824GmfQ6RSakAw+B
 qftSKNugzdrgGCJ7w/ZSV8xonJuyk6udFIsM1v3RSn74K8eOJTXbPQy6kdEGABXLT59o
 bsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768272031; x=1768876831;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMI8lCSI2fMvLpzDFEhPaTzQFVHNd6Yp5HxlIfX0uaE=;
 b=X+Yf0g8g21D1hqtNGaukJuuRM+CYw2B5Aq7Iyb56DfyQVzATw/llAxm+6E6NQ7LJm6
 l6nLmHO69nnNLcTLZVSTdBmqgEH7urlLAaR/T9cALTOBSEBS93CzqAjiTHKmzvYXfEx/
 MJtuznW8hCR/fHpX+28fEElVJzzHmbg72ZusoACtwOd/nValuo/gO0kDZza9smgqMDc/
 3Fqc43cGM/G4z/FL3ui5WCHPbmNkAwsD0UjQra3mHk1C12L8GpWAWdfcTr/dsZremPJ2
 Yo4Z6MXhDEBmAqT8rGBAS2/fLWCZq7Gw+Pfzo9VVETFvTPyKu/itXM8oHjufa232Kofc
 HgEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDek7PfrTcoFxm1avcmH9NuF679Bst7VE4lVHfWNnr3bNKDDmznzo743+IrGBmDrhzRtQVISdL1Jbl@nongnu.org
X-Gm-Message-State: AOJu0Yxh8DbQqQZjXV/Geh9zvAuWGbnXobadTe9NGkiWBb+afkeHy5hX
 BNZnq54SdbJZIkYwhr/MBRn6n3InXPEN7IHhAxiVnKzUnC3aZ+5EgQiLSlbkbhCAFY5da34EsC9
 ZnCngc0M=
X-Gm-Gg: AY/fxX6lbhElGhBw2d5FCClPBl6hzoD5D4i7/C6iCYQoxwD8B64j9LldQWRtdVZIz1D
 YT2Uwf1s5TSQJqOoL6pSo04cr8/tRhsPEw6rlkyBwms+lhP3DwUWe2yXUBk4wm/LsnGp/hno9mZ
 NP79Noxe7u5NgzS4w4NZE1jJhOJjxUQOknmtw1ePo8kB9fw0X1hz23DpM7TNKC+4+LFGfWNRt+R
 kiw4Tcnb1eiptMD/MkxtbiutzR6e6ZFji7FNpl+Zawh4VeyLnr2MFrtKqhpxcNBxfHpUyhDjoyd
 j0JHErBuhIjc7LT98c0Ln6eNOOsPKSw4H3Vbt1pWW+FFy72odCTYfLX9nYZazfqC0juFnfUxR8Q
 IUNBxub6qNikA84OTESj31Om4M2MFPSEQ88ToyBwa1I/PKWXrxwk5vh4sl7DrdCfOY1vI8xD2AA
 QMdlEnbBusa8H3DVpUo+ryXrv7GZI=
X-Google-Smtp-Source: AGHT+IEKP2Uk9CUrKDkddfqS7ec05R4rKQaRl1mDeEPofo6crsJtRux/LFHp/P1nFesoBsmk869FCg==
X-Received: by 2002:a17:90b:4d87:b0:340:99fd:9676 with SMTP id
 98e67ed59e1d1-34f68c281d9mr17435532a91.10.1768272030871; 
 Mon, 12 Jan 2026 18:40:30 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f8b1526sm18534955a91.14.2026.01.12.18.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 18:40:30 -0800 (PST)
Message-ID: <a17bd66f-155b-489a-9edf-7a3355880046@linaro.org>
Date: Tue, 13 Jan 2026 13:40:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/61] Misc single binary patches for 2026-01-12
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260112224857.42068-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/13/26 09:47, Philippe Mathieu-Daudé wrote:
> The following changes since commit 81f1fc471c053c9d3915c3e1f8b37503bd9a9cb7:
> 
>    Merge tag 'pull-loongarch-20260112' ofhttps://github.com/bibo-mao/qemu into staging (2026-01-13 08:23:10 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/single-binary-20260112
> 
> for you to fetch changes up to f445b4a4b6fa5b03503bc8fdfa4c336e13afc48f:
> 
>    target/arm/gdbstub: make compilation unit common (2026-01-12 23:47:57 +0100)
> 
> ----------------------------------------------------------------
> Various patches related to single binary effort:
> 
> - Endianness cleanups in memory core subsystem and for various targets
> - Few cleanups around target_ulong type
> - Build various compilation units as common

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

