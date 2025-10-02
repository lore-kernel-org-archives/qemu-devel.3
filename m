Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A32DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Pq9-0007QV-JD; Thu, 02 Oct 2025 16:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pq4-0007ME-Pu
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:23:47 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Ppu-0007g8-1g
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:23:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b60971c17acso1307574a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436608; x=1760041408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZQxvnhLF7v6Rrbg/9/1qYZ4fu9TdAE2haXaupyH1PNE=;
 b=gQaTVIG6vp+3epmR3gFnUX+RpubR4ViScOQ86dOzws1wogXZxqDy2umxTQMkmi1YIk
 QagqCaBanwtgTQQvBEE3si6dCDVPEs0iBIgOsqg+ARV/ZcWXMXa5e5eG898XC2k1xJW9
 VggXXfbNstfHMEWv566dU4bPy9GBIcQum25my9Ae+Z/AMxrzL/w+8CMcz+Loc2WzgPbN
 hvjKI2X00D/KiMp7RhPmMxR3uHoXhVkBpZzrv0XrPA01TG4HD8R/Kwzz12kW1nMg2Gmq
 FD23f07gL7wFvM0XbKGhpWcz3mpycKApLVCieN242EWlz3S+Tht5QsS8501kAtlTZEIY
 pHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436608; x=1760041408;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQxvnhLF7v6Rrbg/9/1qYZ4fu9TdAE2haXaupyH1PNE=;
 b=hEkyDNeX5uq0vqmOoFeIVvMsn2+f0tApqKf4jBcpe6ra6AQDXfy8AJRcmK/xQ16TH1
 5DeeoROiHK8OikccygO4FF2ZPGG2PcMvd+spNVCoEeQ7NbOI02DySR/nqu60EYsMGHV3
 49KFRyxhCGDrVzn0aRGAH+izqIwgUtsIJoSh/nK4rdy6z/skHAGrsqPlWF850ECc2APy
 ejWNroK8iYefC4eb2O+J7bbXnt4Tpt9pbjEFfsXm2DZU5pkYSaUn2DB+ewotncRH9m9G
 IVL/lmMA6QIcKzdKT7yi+eEsm9ef5S9RQAmzzm7hYE2zL3l3s6WPIOPjYVGwOPvMX1bW
 TzGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlMt+y63WHahD5ddgFGLMXYJAHclGi8aujXLzaTfldQePX1iAmxMhcF/nHlLalkaKb3zcz1/695OxY@nongnu.org
X-Gm-Message-State: AOJu0YycdXvPlVvsdiyMuqoWpx3QPGpxkBEkUmZ/HE2hMkmkz0lTqqc0
 DG5XdsOnYPALbWWJtZyhvV2pm4FHsn4v8Czuj6XnaL4fBtahr/AxXI1Dfx4tszhzMyE=
X-Gm-Gg: ASbGnct0kVd7HNBdjXk47gEiujdQyN9qETGdvPsrkzHbauVkQkGAmY1qEQuNvgMmri3
 i8t+Xamyx6FEW7eKtUytMVsauN6HoHPmrdaQvzn+8/e8wnznG9lcFhBkWTbCQUHfiYRhB+2B41X
 ttNd8sMnWNQIHTaKx1Vg98OwI+0pHekJslOm4yx3K9ZIwZFVs8mvrBsbMu4wlLG53B7E5vE8vah
 87lg9YKEZGDrl08ZIzF0lsj2UQ15arPjX/rLcOB4NYIn2tOQyl5LY7JBYmXfJxrH9xfL71S9TSV
 rCRZiI2+Mt/3gedm5Jo00NVrOyfHQ+VREkoGp4Mhi5bFBmxsTS2MQbF/KyuiNBsMWTZurQs7uKf
 2cJ3GV33wVNvV3w9r/fzCXgACLMPJMgIr+C4qOuxryfpPg/1r7zzPCSFK9RhUyaNQRn8mjJwVNg
 ==
X-Google-Smtp-Source: AGHT+IGeMOQqLfZwPPIHbpxjuEaRFN9br5mcXdR5ksj12xlySjnMFSpUg2bs/ALQI44F5CajE6wiHA==
X-Received: by 2002:a17:903:2c03:b0:25e:37ed:d15d with SMTP id
 d9443c01a7336-28e9a349aa7mr5981045ad.0.1759436607976; 
 Thu, 02 Oct 2025 13:23:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1267d7sm29295765ad.49.2025.10.02.13.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:23:27 -0700 (PDT)
Message-ID: <385a2f06-0b22-4b74-b31b-112924d0f426@linaro.org>
Date: Thu, 2 Oct 2025 13:23:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/33] target/riscv: Make pmp.h target_ulong agnostic
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-34-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-34-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
> CPUArchState.  CSR declaraions are only used in target/ and are moved to
> csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
> parameter is fixed to 8 bits, similar to previous commits.
> 
> Note, the cpu/pmp/entry and cpu/pmp VMSTATE versions are bumped, breaking
> migration from older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/csr.h     | 12 ++++++++++++
>   target/riscv/pmp.h     | 20 +++++---------------
>   target/riscv/machine.c | 10 +++++-----
>   target/riscv/pmp.c     |  9 +++++----
>   4 files changed, 27 insertions(+), 24 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


