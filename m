Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CDAC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 07:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUKWk-0000vB-Et; Wed, 25 Jun 2025 03:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uUKWY-0000uC-22
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 03:26:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uUKWW-0003Qa-4Q
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 03:26:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4eb4dfd8eso924626f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750836381; x=1751441181; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSzKtOlkvtm0QiZN/LTbTIpVSTo2J0t+mIpuEuW1t5U=;
 b=bup4F0gY4Xb9NlAWw9Jn6RuKmaqSTBO3zcr88cM5ygw2sQHb199gbFZpPBXe3Z8K5Y
 ziAH+Pt4bZfLT5ACvKhx+KdU/aBfcdcTXLuMiztF7ACN85X3juYqvw+V1HGwMIe6eA4G
 mdkGpTjMCqk149WHWA0S9np0Kqg51moAs1w6qgJl7V9up7qmJ0NkkZlVH53tIDZCujI5
 WEOdPYbPsAzJ1jJgcpykEgGnV6YG1KRbgj4eXgbchTftwxZ+k7YdA97nWJr7H7YZqYwg
 a5Nkx7bc1zZdYKoPHA8I5J1dpkAPRhU3TDdBUXYNtR+PQO08LJxUMxbNkMgmDlS3Qdjw
 jscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750836381; x=1751441181;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YSzKtOlkvtm0QiZN/LTbTIpVSTo2J0t+mIpuEuW1t5U=;
 b=oQQ/JB68RjvhSr0Op0UCf2DAT7BwKI1leEpG3umpptjgbwERtY05rJtFFoQ8m4GThS
 Ejd9z5ZTOV5NA1Dm0JWE9/zO22RLliPH7WEwbVbUO7Q7m+qEOD02jbONMP4CHcK2eyRu
 L6bFGuigf0nX850NOPAVVgiveX9yzR9s6pBDgOjZh0w2nhXDpCVemoyw7SBtTzdyl4Ik
 T/383AvTRVtQn0XTfDvepfbM99G9Q2bviszTrud0Fd4FYusikZjb2C8RB45QOa0FP8L8
 TQY8N2duygs9LV6fhSLC2LKULeA3VQFhGofYCjpjqu5S+z1BtMUdeolbdSWUmiLsAdaw
 xh8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6+ZUyoOX7wdgO0WwwbvmoDURqxiOD9dsh/vL0VRNufBMusbT6vARjczKAu7zFzmME/DxNL393oZ1b@nongnu.org
X-Gm-Message-State: AOJu0YwEiDsdxsKEoZeqTGwt3QIb9Q/+zeYyO32ezIohPhM7aKvCVmMB
 Qj93hMROWwfg8VewwK4GxdXZP+tbzq9SDddtuP3BLtD9GVEMEK3sBb8rL7EYaB9k3dE=
X-Gm-Gg: ASbGncsgbt2fWLvLEFb46PnXodXADdOl1vX0lcEq+X7CznVqqZXwho0StFnorMa3DPu
 UZvKPToiQBk/Wx07Kw9xC5wguFY+ElKxe0uov6AocBLeEOEYj4RD4QtUYUAjG301ojluwKwcrAu
 dT28zRT/s6SqAyoNJTazBYJLLy7rmkAKWsTUdkeM+mp+amI8ToDrBkQr+2ou8KvxHrGKfWLzQha
 EX9+4jyPMXeWezZWdXzEQWxKdIFoQa69EWyMReJ8ujc8hJ7nqQ9S+H1+8D5cXpDZE/iuX7FZLrz
 OugY7eZ7RAMgzzAUsT3ywtYvE5oAAjNNMlSp7F8geoLYH6go1T8TAUuu5h+DTAYs92OBnD8RlzT
 ULCuNmnyXq2xffnT1jp1T9Xa1V+xsQ0OF
X-Google-Smtp-Source: AGHT+IE9Fcx+sQrN+3rf6cneNzg/NOTVVhQnYDct/WLHG1af9B9ieo/IiIwqZJ94W+/pFUP2p0KnkQ==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:eeeb:7e89 with SMTP id
 ffacd0b85a97d-3a6ed608b79mr478799f8f.7.1750836380845; 
 Wed, 25 Jun 2025 00:26:20 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80695efsm3704476f8f.40.2025.06.25.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 00:26:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 09:26:19 +0200
Message-Id: <DAVFP4YNR8KQ.3RYUHSEF34EG1@ventanamicro.com>
Subject: Re: [PATCH 1/2] target/riscv: disable *stimecmp interrupts without
 *envcfg.STCE
Cc: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "Atish Patra" <atishp@rivosinc.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Jim Shu" <jim.shu@sifive.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
 <20250623165329.2759651-2-rkrcmar@ventanamicro.com>
 <0811914e-623e-41a2-a54b-8ce42f45740c@ventanamicro.com>
 <DAUT771C07KV.2JZ4ZCRQ1MEQM@ventanamicro.com>
 <CALw707rf-7ftLs3xM2Btxz9H78E0nDj6D=1N18jWe5jroZ_7Zg@mail.gmail.com>
In-Reply-To: <CALw707rf-7ftLs3xM2Btxz9H78E0nDj6D=1N18jWe5jroZ_7Zg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-06-25T14:24:25+08:00, Jim Shu <jim.shu@sifive.com>:
> Hi Radim,
>
> Does your patchset want to resolve the same issue as my sstc patch [1]?
> My sstc patchset has been merged to "riscv-to-apply.next".

Yeah, I wasn't aware where patches go in the QEMU land.

> Maybe you can review it or check if there is still any issue in the
> "riscv-to-apply.next" branch, thanks!

My patch is doing exactly the same as [1/4] and [3/4] in your series.
I see you also fixed the NULL dereference. :)

I'm withdrawing this series, thanks.

