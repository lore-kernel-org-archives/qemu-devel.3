Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4258CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNx4n-0003SK-2H; Fri, 15 May 2026 14:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wNx4l-0003Rt-Mz
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:15:55 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wNx4i-0006hz-MT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:15:55 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so142479eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778868950; x=1779473750; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MfEYr69VX+p3o+ExEBAjKctQrdWBca9NV1ZrtOgAuD8=;
 b=Q+pXpGYvCN1mzYNvKPK9ptGMCJA2TKoxLOcaoc7OHgPon4WaKCw3+0zVdJ7+TEFU/F
 lRxAJYgS0XCukn99OTDKTM9ZboIq3bVPC9vUbWPSsT8SyG5ehO4/cnXK7qN2mUNK3HOM
 NE7VA6LK8cgloHEGzWBWUQIJkL4fVEgnQmuHLGe2ZjeKRK7TtlCd0kFGNGoaGZflZtyH
 tV7tUa0VhZ7n3TKZThU8Rs5wRa7wpmkcaeGmlh++anENvB9tu50Zg3PZC8Orjd9AFEEO
 ZQuH5T6PBrxpwhv7K8RtsfBuavUAz5EuuRabHJ2TcYhlbbnDuW9CQy+FbFt64g+jHZLj
 3DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868950; x=1779473750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfEYr69VX+p3o+ExEBAjKctQrdWBca9NV1ZrtOgAuD8=;
 b=ZX9ouf5LFowDTSZffginfiqwnFPp7L/wWpb+N0C/KF6msD5lg4MaTQuc0fhMPFGh+s
 706M11Or0gfkcYq+OjV0akxo1NDQ7Ts4k1QiqB27CnQmdwgyp+8aLbfy7HdvmcvOzNFH
 0oTCIY3I2QJ/BzHjiw2EK+5UIWkzzSfgEaPwzvI3Em79u+tQv/MDmInwknM/tsHEdpJ9
 48arOdhvnrql3V5ME0dSP++QioaSfkF9IMM5ZLoDDXiPZpYvBhkosQlZWgnMlLfIiHIq
 hwamfvu9bsIl+75DTf7ucOQydf0KmA/qzPZWClYD1xongczETgpYKxywcPYZEH6lJwlB
 AZ8A==
X-Gm-Message-State: AOJu0YzOMmoCMHH4koRf+Spmvw0AekjeDxBqvJZiDbFHUH5ZkJWBAuqL
 5ANOZYZRr1polhCsiF2ucasvCEr+9FmTkCvw4lR7YMNdrzh9py0JIBRu
X-Gm-Gg: Acq92OGVhUsdEB7eSHlwVV3+lA2Pyr4CC2v61sUqWLiqxCYzRlL0LX7rOzTHfuxOyUW
 9US71rh3TL/Jq2q7UGlHU6RaFtxcE4aTEpVc6dcdiZ5M1H1mbgl+e2Ct2Swe149YBFsJF8gjMJn
 EcmMfPFDHhqGMv5Qj0k3g39jae6GwaRFxtER9s3u275VttP6QHyQ6KL8vaO/ZSUTq2XbQdHxV/3
 Mp9nMZRCy5mJXSYCf61Cm83K6mivoKzz+OeQYLj/2Zjp212dVA81d7urSs5JKgSBdhcTSerYU8W
 QTQ07fEvHlNOj+1o+oC42mTPx4bBLzB1g7GzAlnAx+ls5qkTzwavagu5CaQFo2Z12QbD0pRsOII
 g7jA0tqzQGCPCtwSaj0v9gjJvzJeLvvsw2s3km6/YJuJpd5uGCv5PPa80MF7a33yKN/Kl//c3Yk
 v55zkU0OewqgjjOd5s1g+eW1LV7AHIwTiIuY02SQJlJQ==
X-Received: by 2002:a05:7301:fa0b:b0:2cf:3de7:22ad with SMTP id
 5a478bee46e88-303986a6856mr2340942eec.27.1778868950315; 
 Fri, 15 May 2026 11:15:50 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm9459872eec.3.2026.05.15.11.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:15:49 -0700 (PDT)
Date: Sat, 16 May 2026 04:15:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v6 2/4] target/riscv: Add server platform reference cpu
Message-ID: <agdgwnLqvEeMoeqk@lima-default>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
 <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=npiggin@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 14, 2026 at 05:46:38PM -0300, Daniel Henrique Barboza wrote:
> From: Fei Wu <wu.fei9@sanechips.com.cn>
> 
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> This patch provides a new "riscv-server-ref" CPU to go along with the
> future "riscv-server-ref" board.

About compatibility, if we get a server platform spec v2.0 that requires
a different machine and RVA28 + Sxxx CPU. Is the plan to update these,
or add a new CPU and machine types? If the latter, then perhaps a
version in the names like riscv-server-v1.0 / riscv-server-v1.0-cpu
would be good.

Non-versioned names could be aliases to the latest one, but I don't know
if that is really worthwhile particularly for non virtualized system.

Thanks,
Nick

