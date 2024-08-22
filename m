Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED2C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgwBh-0001a2-UY; Wed, 21 Aug 2024 21:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgwBZ-0001HT-HE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 21:00:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgwBR-00070w-Kx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 21:00:18 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d3d0b06a2dso208199a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724288408; x=1724893208;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qMdmxQOGyw6PErkjYFwkTQirAJd7LNzgw5JdGrolsn4=;
 b=2sMkaXAmkl5Dy2Hal4BScNMLgsWyqU9HDxyZF2h44y8UfvJhlNj+lIDmBptWdOLz+F
 06VBRzGEdSzi1kcpO99Keh4Rdtx59qX9gGAstXZvmUdcqY6LFQFo95B4n+rQt6dEidFe
 PqaA3poTe9CjgRHFsAwLyGRbojSnMwOrmNPrckPAIgCv87x/aEhoUWULT/KA0bwj8FXo
 GazY7sKLrdWaUz5pqG6gDTxlMJ/Idf4y4m8BNaSLOK9k/rJz5/MVQolpRNsGv4RHroMw
 xrnt5rdcGdbEyDEXqRkaiGRCLmoZlnskLy3LjOXpsJJk/10HCucas33/ADemeLgX+riF
 91ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724288408; x=1724893208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMdmxQOGyw6PErkjYFwkTQirAJd7LNzgw5JdGrolsn4=;
 b=YMW8+G3j8fyzr7sq2J4e9kiGo3D1ExMcb+UTaC0ZujIFgBqZDhpdEjHsKMdUpf0Wc5
 vr5IL7vkyMZwe3z+2ZSrYxTt9Q37epEKdw+w8ldL7kzqgLzISGHUpqrVJadAmlycIDDY
 b9wYp9pyiDDTpJD190pZ6ZCBpyCNUZKH6K5V45E1BvUkSlHPYZC++7BoesAu4+UN45iv
 IEXRpAI0Jhj+KDRwBGM/GwDJMy84jSEUCJjErpqnZVDKf5waej3JLJCZWDUM4Mj98Nzg
 eFxh/lddJqkq4TMuGRzi/sO6TNkUtLxrO+a+fvC97Vyj2y4S2ceQJDZAYaxWufQCilrC
 7cqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzjGf5kQA1wLgtfeY5WMRxlBAOkNmlc/zNnu2NLBYaUJOrQns5vuzOOzDDie22w8SiIdBg2mGuRKfp@nongnu.org
X-Gm-Message-State: AOJu0YxxbsQX8PJ9OeyxZLZxdhziIbjMFc6Llm6GFreO60YmGKSbhCUR
 iTs/ptf0UASxM1Y36VVVPb7FC++jb/vqEa+V8CMKXlZane8Mx7q6kg7/oaicFNA=
X-Google-Smtp-Source: AGHT+IF8I9vwhAVbfEYS10tvo9EG6pvMUxNrhhq5td7QTOc5kcfttX3VNjBMp5NSVbMSk8dkKMurSg==
X-Received: by 2002:a17:90b:3758:b0:2d3:ccaa:453 with SMTP id
 98e67ed59e1d1-2d61728e756mr322991a91.35.1724288408128; 
 Wed, 21 Aug 2024 18:00:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5eb8cf61bsm2621312a91.9.2024.08.21.18.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 18:00:07 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:00:04 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v6 13/16] target/riscv: implement zicfiss instructions
Message-ID: <ZsaNlBC2Ye1R9MIy@debug.ba.rivosinc.com>
References: <20240821215014.3859190-1-debug@rivosinc.com>
 <20240821215014.3859190-14-debug@rivosinc.com>
 <85deb108-cac1-492e-89be-0997510fde0b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <85deb108-cac1-492e-89be-0997510fde0b@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 10:57:10AM +1000, Richard Henderson wrote:
>On 8/22/24 07:50, Deepak Gupta wrote:
>>--- a/target/riscv/insn_trans/trans_rva.c.inc
>>+++ b/target/riscv/insn_trans/trans_rva.c.inc
>>@@ -18,6 +18,8 @@
>>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>>   */
>>+#include "exec/memop.h"
>>+
>
>Why?  This will have been done long ago, within the includes of 
>translate.c, the parent of this file.
>

Leftover from early versions. Thought I removed it.
Will fix it.

>>+static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
>>+{
>>+    if (!ctx->bcfi_enabled || a->rd == 0) {
>>+        return false;
>>+    }
>>+
>>+    TCGv dest = tcg_temp_new();
>
>dest = dest_gpr(ctx, a->rd);

Ok.

>
>
>
>r~

