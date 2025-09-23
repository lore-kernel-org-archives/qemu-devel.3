Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04DDCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z7d-0006iO-Hr; Tue, 23 Sep 2025 05:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0z7c-0006i5-7W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:15:40 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0z7V-0001DC-7w
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:15:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so4595392f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758618928; x=1759223728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h5sYBPncHfNYIKzEl91TCZyfkg1Izsh9JbWFCMjXPSY=;
 b=GRHeoT2/5k5uSDr0Gs/gRvcq/Cg/aeRVdw43TE32tnf+hPet4SL8FHyQYv9Nzt1nqL
 6qgHbqXq0agv1gCaIOfEJ05oOM+3rHH9eOqQ3/fIT1KDjs9sFV4o/DeR5Tj7isi8XgjL
 rBVdEPA5b0OKvPG+Hx9tBgjloOSqwEEy4CnplpNZUsZ11Gh8C6H/dZGg9NMaceMHiogi
 f1kulfHSTYSGy0NnnHAVSWtvT/c5uZo7t06DDs4lnQ/y7V/eBtGQo/gYGW4AXkWYwz4+
 xRrWxtWneW2ElbZEIoDeEGmyrlLU6tRThmYDIekm3PcPQc+opdi2Weh3axWzZ4coMONS
 +ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618928; x=1759223728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h5sYBPncHfNYIKzEl91TCZyfkg1Izsh9JbWFCMjXPSY=;
 b=DNHuQQ/w1T/TWrfgKNNmzWiwSVt/jmZR3Zqy6xdfe2gj5pQ++6X0u5wlPrqx+dns9q
 zcy+LajxYALRgxvl1dY81uq4r+WVR/YSvhSF90uuli4TR1nn0RSYUFvpOEKoZ169dlA0
 C+/Wo9t3tN+XXvUjUfVxz82XhGceAMxU45XaF+VY6lRzaM78AqyAMgOY9DhbfqOuI5sG
 mAcco/bA0tcbsGdteuPso10lBW/KhAFrlSaTY/mO0Hg7r+Y1OqWAo07y8aNz+WWnNQJw
 2Me7gEE42dif7QF9e4P/3ptwxcHSiJyBA47kAjbID3Z0q+ELAkVQQP7ZkpT3THTVTfZH
 6Mfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX0aj5EcVfGEckmEXAtjPTRkxzZ3Slz8439kRZVQzAKfIQB8DXbHGr36G80XpZotHZbGpXjmq8elO6@nongnu.org
X-Gm-Message-State: AOJu0YwdWALyp0X8cR/MRMTqIIDt8GUA5r/a70E1nMPYZjW9N7wHg4In
 2vuw0MxhJU9+DtpnmHsSDPSpKLZOeDIzuUfMTB8hKdD/1/A+kMLUPNRebxB4dBTEMfzE02TeWGU
 HCjVdjsz6xA==
X-Gm-Gg: ASbGnct+F6vxIdFKxOJyI0B+I+Y9TfqzNLXyylv5PL6JQgqL8uHl0idLWSvyTBQmILI
 Gm87Zq/W8AnsOg3d8LW65OJeFHHcCZubtqzaUutfoZxmQXp8A2ZT2E6YwWU4qAUV5TLxv2UCyb/
 DWZkDJy706qTTvsiECwyQX6MNqj8hjYzeh4yB1irGOofOaKCIlJFuHRcH9EgILiZFZfv+i4opzR
 i0lmmWloRbEC/aapLFDu9dIzPXsd/BUhV9nl900IjeDHlv52Wwjg7srXjObcTwhYrE3WeUkJbkU
 cbdnvDeVZQu9fATWiDGIUvOgapQusmYyzQ/Ftyue7xsDpVcQuFfX0Rn8TGEJAkKi3yNNRB8JPUE
 KuIKDcFryNKoBA7KAyCpEUghbSF9BRz6M/+IQFKTi/zo1k8ROqnCv/oOGmj0eINmfHoRo/f13OT
 l8
X-Google-Smtp-Source: AGHT+IHMdUVAx9wgQNibeRP04qTcfGT+3F9xfkPPF6etCa5znKhve/spVye8qd4TC56ywbc431TpGA==
X-Received: by 2002:a05:6000:2c09:b0:3eb:c276:a347 with SMTP id
 ffacd0b85a97d-405bc483471mr1704689f8f.0.1758618927609; 
 Tue, 23 Sep 2025 02:15:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fee58e6e25sm6946388f8f.58.2025.09.23.02.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:15:27 -0700 (PDT)
Message-ID: <376461ca-1a20-4ba3-a49b-0e88acbd9939@linaro.org>
Date: Tue, 23 Sep 2025 11:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/9/25 04:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translate-all.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d468667b0d..d7cc346414 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -288,11 +288,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>       assert_no_pages_locked();
>       tb = tcg_tb_alloc(tcg_ctx);
>       if (unlikely(!tb)) {
> -        /* flush must be done */
> -        tb_flush(cpu);
>           mmap_unlock();
> -        /* Make the execution loop process the flush as soon as possible.  */

Maybe keep the comment?

> -        cpu->exception_index = EXCP_INTERRUPT;
> +        cpu->exception_index = EXCP_TB_FLUSH;
>           cpu_loop_exit(cpu);
>       }
>   
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


