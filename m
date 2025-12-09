Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A69D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSx0Q-0005Cw-Fu; Tue, 09 Dec 2025 07:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSx0O-0005Bx-8s
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:39:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSx0M-0000rq-Mr
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:39:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso27983595e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 04:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765283984; x=1765888784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbzwGNlx+WnSyG513dRIcBU2FTp3QcMKnlBOw/z2YyE=;
 b=UZmKiMAzufnanmRuRFjUc/EOWWRCq6XADlF4HO89MMSmzCg6U9Hver3Hgi4LSFxNOq
 hpJ7uJ98ry4s0qkg5eAJCqN7Hgpa0uAinHl7X0oz48zzCOURI5D/8W0l2adZjU32MelW
 /ZnEAOExYO65p0mRfpEwT8xyimIbwOWUU8HIvQq1Kf+uY6XMa8zqTwbEgmXrRt/cYpum
 0jU1qM6DEaUdtRCOGhTdKVLaItjc+0WkbL2tOm04F5XLqT0zEQjJaca5+QhFALlgNQQD
 fFH40VQe4hxIgw8vyEKrs+alIgDAnq3HfzYHuiU2JT0mUO5qWIT0/JOTyfFQXE4oW4wi
 zL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765283984; x=1765888784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbzwGNlx+WnSyG513dRIcBU2FTp3QcMKnlBOw/z2YyE=;
 b=K6bAcf/vzlgUJVKZaigYyblqGeKEK1iqUQbfsGbPpdfCLV2V6afjvon97x98hIMLC7
 T89TIxB8MYoljFfh3SqrTFW+Orjz/Lwnt/akta5r9NxREcm88txBZgoOoihXaCeY8S9d
 c5E33x6s27AunBrv65D9rgeFi1OrkaBXSv5sXCuZLML5Aumkne16SVzEXFm8eCVwUH6b
 no8yfwgmEPpdpprgHgY5/lN8tKIxXXG7FvQwi3cPKwpT4lZJyJNdlsOlZ8xREL/ITUaG
 O851n2q4GLzQwBNK5DVDwNFhrGMdLDeMqiexPwS6C1EuJwwg2HhPqrFeHCgfhgG7e9OC
 aB+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg+cHjtN0bVSVM7Iox6wcUKls6A0xOXoLPAZEeufP783qAW2tPqKKH78jTQfy50vhsw94DiBlV19Dy@nongnu.org
X-Gm-Message-State: AOJu0Yy+vRlvyrojzk5pBOlgM/rHrFIgwSn3o+0DRzOb8LQ6htFOUPjt
 O0FMyjk5IIzIWtcwvyD8twZ80nfqTQo6UbgRys76mzitswkx3hWBmNny4VM9wSiRrl2QuY0uIT0
 Xb+H199M=
X-Gm-Gg: ASbGncsFqnKrNKmAuDW4KoJXBnVDFbtG2BVR9rK2HSp3ZJxZh7kxyAVN1pw0ZNaE6kL
 GqFkFC1sTwVexiye+pqIQG0W+b9LbMbPjRWrux3XWxPGtjA9KBqIIOY7UpDn4mQq1657kpolKfy
 COslzhKkziUcihGNJJ2v5l60ImpTGDm2x3vvJ/rjrd1cj9ErSFiGKsGd87XV9ZfNw+NgVTdi792
 gKXm/GmqGlb8ZWBeaCKVVbRadWqZcK2h77u5pyNbPsf5P/I9D+QC6elQ9CC1g+sHlWQ7m2Zlwuh
 vrgjC8kZP8f5dyhvG2mJfkFe+upRZ3XAcvLy4CbNB0CRDOJXXd3igqKBoW51j23IfKRVYUcVgBO
 z7o9ByRX47GT7eNNg19t2lELbpGe1ik92JZto4InpwBB/2TdLReXnsS233ozyQ/xYIczTetY3X/
 a/nxwtiRztR6qUsSgUIfZy8V+tpk8gERZIWyC0edaLiAdHRzIhZ1155A==
X-Google-Smtp-Source: AGHT+IGWQuYqCfmwcguyDiJJ0s8TQ1osDE6v7gUbaZZ7QWlN1ZggpvaXLX30eoFi7XRCaqY+tTdShg==
X-Received: by 2002:a05:600c:4586:b0:477:7658:572a with SMTP id
 5b1f17b1804b1-47939e27924mr100693305e9.20.1765283983786; 
 Tue, 09 Dec 2025 04:39:43 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8fdcsm31588524f8f.6.2025.12.09.04.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 04:39:43 -0800 (PST)
Message-ID: <b68ec589-cc1f-4fc6-98a1-dd321a96a42a@linaro.org>
Date: Tue, 9 Dec 2025 13:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: Treat kernel_start_addr as vaddr
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251209123135.22534-1-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251209123135.22534-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/12/25 13:31, Anton Johansson wrote:
> Changes kernel_start_addr from target_ulong to vaddr. Logically, the
> argument represents the virtual address at which to load the kernel image,
> which as a fallback gets treated as a hwaddr if elf/uimage loading fails.
> 
> (Note: callers of riscv_load_kernel() currently pass in a hwaddr as
> kernel_start_addr, so I'm not 100% if hwaddr or vaddr is right here.
> Please correct me if I'm wrong.)

IMHO they need to be updated, i.e.:

-- >8 --
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index a17f62cd082..bc4f409c19c 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -521,7 +521,8 @@ static void 
microchip_icicle_kit_machine_init(MachineState *machine)
      uint64_t mem_low_size, mem_high_size;
      hwaddr firmware_load_addr;
      const char *firmware_name;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
      uint64_t kernel_entry;
      uint64_t fdt_load_addr;
      DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
---

> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/boot.h | 2 +-
>   hw/riscv/boot.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


