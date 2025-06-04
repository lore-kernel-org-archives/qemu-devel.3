Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1798EC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 14:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMovJ-0006a8-DE; Wed, 04 Jun 2025 10:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMovH-0006Zg-Sn
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 10:16:55 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMovF-0003WQ-HT
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 10:16:55 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-313154270bbso561555a91.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749046610; x=1749651410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=91CSEGpuWTGEwrNZTiP/RIeMSz/gKpPRsK9PPutKk90=;
 b=SjjEyK0XoLbagx9ez1uceHwya+t1kH8xQjZUsd8xVpzK1UqbWoSgC+BEEqYjVdkJs8
 oKmCVWlCtK2XJbPOrd8IC0XW+SkHNyTgL3D9mfgCC92Y8OyZwh+KHutBX5uEPD7r0J0X
 6ivtUbyrXMa/5pwMlLwFFLWPOve8x6XeDlYdszn6hZpt/uPwJoq1H8nlxFqIkiC14iJS
 LoQT5k5S9i8ZDZ2XjpkT8a5/hLkMbrgsv8yfUYkIkf8I25rBKgxg0O39iUXzXpeoKpHH
 NK2wQh3OxDVCjx5dtdjq1mrf+ozIERRDAQrloBU3mMZ2H6QihjLY6CWmnDHi9McjsQRC
 fdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749046610; x=1749651410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91CSEGpuWTGEwrNZTiP/RIeMSz/gKpPRsK9PPutKk90=;
 b=k3/dCSwObtnjR7jysqiOR7r5cws549F8sS2s7ttomnBqggWKyDLVnmSiCpVEE5ckJE
 ODvXF2bJwcK1BpHRYVQwqlW48L6vcwDUS/2PsGKSzVvqrMkomP49EDYzN7vcRydQ8xYP
 ybsAyHTr6f8qBFk119x3aPECKry+bjVntSBCTAnMMkcXQiq5FU8NlGyoHVKsMU+4FKUj
 uIvoG+lksFVCmjOn/ruZqgTeBHzMeRD9xMr4b2xpjMWlRIYEaaozzRyRr6AJJdaDOZud
 bYMqQvBbvLeWuVaSfngg4sDBA+hCeJICnufpFDX4DpRZJc+G3ty1TZHRaWhO4sOB6Fo7
 TS3A==
X-Gm-Message-State: AOJu0Yxc7V5BcIrRnvM5Qsr+/X8S1i5su21oS3zW26tmV7xpb2pb+GfN
 5BBp+ODKcVs/SFKAWnhJ/ljlPNAS7TiF1nDRzUg9QYdAFHK/usovyjPZRtyZlJDkYFnOjUL2EAO
 XAZlPr5Y=
X-Gm-Gg: ASbGncveVKdNc4SYF6ARMPR4u12Y4FcFXZ61YVtX1/2F5+86hh4JK2gWi/ucKvMC7kq
 N9YlLxiDtzR8zWN1bd94DiZm2IFWcXyFEAhBUKb5miQbjuSEGwhGH9moHCnVxvtYFlcyV5/kq/l
 5Ckg3itm6HZa3vPitY8HdI9YbmtzzEcrQTLPQbkNNnXfA+7z1lURSLou0Acih+fIudSvSz8vKtY
 kIMjux47hLJnxUJbU/gkCCPm46vRIx5+1kkB9dFlzowUsWucPWaKzLR5Df3R5fIIJnzq3kGSHD1
 10C4oXF7AD8cBoFCHlmFSmWExuI04VYkQrJgQnSWrEDf8R1JU5A4kuNwUGOAhAy+QnY=
X-Google-Smtp-Source: AGHT+IHkLsxFEVYGWtmffmXCQGKgmqJ5BguFuuzF5k3sp58ADicj0JXCWi+hZ+Q3RAZL3l3vI5bNMg==
X-Received: by 2002:a17:90b:3d8a:b0:311:a4d6:30f8 with SMTP id
 98e67ed59e1d1-3130ccce9c5mr4841233a91.13.1749046610151; 
 Wed, 04 Jun 2025 07:16:50 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313156df664sm1087186a91.29.2025.06.04.07.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 07:16:49 -0700 (PDT)
Message-ID: <4b5f47bd-b9f1-4207-adb0-ab46ef4a25eb@ventanamicro.com>
Date: Wed, 4 Jun 2025 11:16:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu PATCH 0/3] target/riscv: add missing named features
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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

Alistair,


This series is breaking bios-table-test on patches 1 and 2 because we're
adding more stuff in the default riscv,isa and I forgot to update the
bios table.

I'll send a v2. Thanks,


Daniel

On 5/29/25 5:23 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> These simple patches add two missing named features in riscv,isa.  Third
> patch is a doc change I figured was worth doing.
> 
> Drew, as far as Server SoC Reference platform goes, we don't have
> 'sdext'. I guess we'll have to postpone the Server Soc Ref work for now.
> 
> Daniel Henrique Barboza (3):
>    target/riscv/cpu.c: add 'sdtrig' in riscv,isa
>    target/riscv/cpu.c: add 'ssstrict' to riscv,isa
>    target/riscv/cpu.c: do better with 'named features' doc
> 
>   target/riscv/cpu.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 


