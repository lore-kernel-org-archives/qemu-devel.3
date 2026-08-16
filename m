Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660B3C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wved1-0007o0-QD; Sun, 16 Aug 2026 13:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wved0-0007ns-U2
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:26:34 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvecz-0006vZ-BF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:26:34 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so2279621a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786901192; x=1787505992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y/MQ+I5S5KZ/CN/oH7i8M9qvkmbYjv9na8QrVWbcC/g=;
 b=ZcEsHy9lLVIzASJVs3OSGBjK0zTVB4QMMGNvwaKEofT2oZ4EDgSxbADSYVCc9Z8Qx/
 UxU8ULoRzS7esLNoN1r3gLCqU1VwqWmwbYHdEzE47zS9uoHR68H2i8y6EHlrtPTqOtqs
 40TCTDqV+6sPQSRdEFS4z3gtE+0ts65JHiZVfpSbU/bCB4EUrN/FudkdgI/szBt0o5ER
 tTX4SK4aG3nTgujp6MOzsH7tIpvcr3bEmTW1IaW7Etmf4/v0Lv4Re63e/sQ7WQn00ZiY
 lXXpbuC5ZHJM2pOKr10BSCIREAaxzkwXa9wYYRi32ni86GACQsK25kDuFBWJH/SHB9UK
 WeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786901192; x=1787505992;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y/MQ+I5S5KZ/CN/oH7i8M9qvkmbYjv9na8QrVWbcC/g=;
 b=fhrNqvbmA6CpYEsj/nm6oR7446O10ulJR4hSHdllsVKpvHVe+IBaLIOyPPmZca14+8
 2Uy5in2h3kI1L79Q8wNR4uMKArOdlbUjC+6fGhdLh9KCe1tVdqLaRQRpHgfe1InW9ixD
 TrwwUQK1pVbeuyxlY/F4B1LNpBL/7Jhk8XXhDq4c4AApadlOfcfmSBsb8fuBkW6hgL9A
 RokPysDDtWPc3SUCjRSNgiT0wB+1tseNtpo2AuWVzKlS1Pq0jB90VglDA27K2X+ByNn0
 DsbeG6k8gRzny1BLI6fdjLp2fqZlAxI1sxhB33lsG453FdQISk35w7hjel/R+4xwG6/A
 kW0g==
X-Gm-Message-State: AOJu0YwwY5EH7ouyr+vPM5FRXoju1HHD5o2QA0fjiPaV35p0esSNhlMI
 Jzq1+qicN3fkiCaF9Prpgt7JV59rauSr3kLjwyfk4h1wxvulP9WOiwCLlyai2dYOVj6hKYmo05B
 GL8M8
X-Gm-Gg: AR+sD11XCtQacBOU9hya7imIkAfdPlc3KdT0hl6uk11txnWcoNUU6RdCIRwOAib1+gH
 Knx8uFbroOUoBuJ68ar6/Cgg+bERwKMDS28KBJ5AaSwPskwGKSAL5WDhu3lFDWDOAvQ3MoDYbFw
 He2r79cxn/XXupagbDaxQW1xTTW6oL2tSGAeqY1caB/7SKJ2qwKV3c9tNhCUSe/+U/+WaMlYOfo
 jcOIWS/tX3hcQLc3lXlT3WmZLa6BtlZEP0Vsp1FpN6H1/pd96SDj+7jnpO+K6MrMQQlAvFsiK8i
 Df//RawwgxtMHm12ZPiiA8pnKz8I6xzAdOtbSFQDGq0ImWok0EXNNi6vun9/MPsmZTVGtnEavlD
 2/uPqYz7F/Si+0dc/jyc9pg9jkoJnTPK81y4zUTWWO39UaKCWivjKX123Yt83DjfXvItm1E//IJ
 WPH8PrlP75egOB1+Na2rkRCM8OuNkfuKNQK21aE43rAx+Rgrtxvytrlz0uaWDGWxQZkoF9P5O5O
 F2togN2SP7Qwj583ZZjdugqvvNqkIxoBkJ9gk0=
X-Received: by 2002:a17:90b:264d:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-3933b93e1aamr21587831a91.14.1786901191549; 
 Sun, 16 Aug 2026 10:26:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e84244sm2005797a91.6.2026.08.16.10.26.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 10:26:30 -0700 (PDT)
Message-ID: <9dd38bc0-3db5-40cd-9ade-e2a1374afc64@linaro.org>
Date: Sun, 16 Aug 2026 10:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/56] Misc HW patches for 2026-08-16
To: qemu-devel@nongnu.org
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/16/26 07:44, Philippe Mathieu-Daudé wrote:
> The following changes since commit af06b5df2610fe5de6c02d17c17bced9e9f0d47d:
> 
>    Merge tag 'qom-qdev-20260814' ofhttps://gitlab.com/mcayland-ntx/qemu into staging (2026-08-14 08:44:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20260816
> 
> for you to fetch changes up to b409523587c49a08b1ddadd51212a320092347b1:
> 
>    hw/core/machine: Move EHCI migration compat properties to 11.1 (2026-08-16 16:35:27 +0200)
> 
> ----------------------------------------------------------------
> Misc HW and Monitor patch queue
> 
> - Bug fixes
> 
>   . Reinstate x86/pc 'xenfv' machine alias
>   . Defend against malformed ELF headers to prevent underflows
>   . Restore ROMD mode after migration for Intel PFlash (CFI01)
>   . Fix VLAN tag handling on incoming packets on RTL8139 model
> 
> - Refactoring (Monitor, common CPU, NMI)
> 
>   . Add missing inclusions and remove unnecessary ones
>   . Use qdev_is_realized() consistently (no direct field access)
>   . Remove deprecated DEFINE_PROP_DMAADDR() macro
>   . Renaming churn around cpu_{exec,common}* helpers
>   . Simplify NMI API hanlding
>   . Move QMP handlers (physmem, nmi) to appropriate subsystems
>   . Replace container_of() casts with HMP typed accessors
>   . Rename @mon to @hmp in MonitorHMP for clarity

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

