Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1259CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7I7y-0004Xd-Qw; Fri, 10 Oct 2025 14:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I7s-0004U3-LB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:46:01 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I7o-0000qs-AB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:45:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so2191742a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760121953; x=1760726753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=25RI9KVOmh38zKuDV+f4WenEsx936Me1zzoA2HnwVO0=;
 b=C5jAeOeFezjhOuLFGm8KBamcKyiYLgsd8QBLvwMiaThmIW6EEMsA2LO3jr9an1MYwJ
 wLnI/6Hp/JOpn5Fjkxc4/kUKe6ZjHxRsNi1y3Shc4YEWU18fRKesCvHBHCrgHAvlYk6V
 6ubk2NRw5PawqECl/FZq0p1yqbvjQF2Ow+BA9Vn8kVZvQcRqLcBkq8AriCWjW8KjlLWu
 0w/E3fitrHVyvVqtOZYWY+lIvu7n9qYHM3xXd893xlEPdcuo7MNpPeiAoGRw/8TOwGIY
 UIjxFpE2RTMDqAyGHoQ1i/5i7YljyyctaA9J7ylOYzTR4LwDxJQEdoL88ihZgL68ZNmV
 m7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760121953; x=1760726753;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=25RI9KVOmh38zKuDV+f4WenEsx936Me1zzoA2HnwVO0=;
 b=jMVIvWn1B+Bc+hqPOcLj9JqOeTRjrAfneu+ci4U6laeVN5r/h67Pt1lzf8gNcq0izj
 awSdUjhJiI0sV2WTkKYp1sul/sgypJC3xQZNM42ofMaLQzD3pjF3A4tlCOKb7Bq0kVlX
 f/55e+BsunOj+RmiNzzeytWW9NCm1UweFKGno2oTTHSzAC3MzCzdc0JqWQ6HcTjqKMKo
 nZZ9TrxbFXnoKFtly/PZTc7oyVi9XtrWGXoooZnf/pJSX/YeypE1I9NtFA/R3o7GDFfx
 LI7bt9N/WTb8xOUn4X4dd8vnt9v7/vBcN6Ft0501R/yNwdpkuEjG7f8WGQjplY+FOlwP
 WyXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmYvqsVHtCDwD1R41pjgY9vZSV3G5tq4JWchtpObhvgKXKOvFelepKmhdqgE+KmMbooli48g8BAiAh@nongnu.org
X-Gm-Message-State: AOJu0Yxe4VTw64ae7RHw7ifgnFy9Ab6kew2NExmfz50edo3ZUjg9C/56
 k8DOkpEiQ0zLc3Thu7SNd8IJoOt01vChlIewQk8MLFsbGXgXdLx8CRC8ky1Ue7PeIds=
X-Gm-Gg: ASbGncvdfO4ZCXrNCJMP1xiJ2JWVXg/XKccXfPbJRl2TMJMt7ZS9xMRowErNCyRSYfh
 zg5LoUNPUK9vIgFEtJ4sK77uWjms1SPmdZO7p6KmlBUu40IKsbF/FQ8OAjNsYVsyfybMZI1dCW0
 l3ixBA4rR897JbBSxea5+9ZEsaINOxkT5SpHx6RT/JIl6X2YHBXMvvcQqPhNRgvBLYxminlNco7
 RF/+Rr0NO5/K7T+iHA4L/cghohWTMyHro/umBznDHF25Ww0qQH0UjekbCZjS60fj5inw1vV+Iai
 OfBOtGYEmg4lAojXaOx3tp9QgPollpYlFXxMyC1Ev8+1BGymtp+v3BJ3l3LUCRVoJ6uQRnAMi2W
 2qbOqBfVcF5Ko37T/u3gQu/NyuR/dU3dLak+wPZCrZr71+GtfmA7V07d3We0=
X-Google-Smtp-Source: AGHT+IGHV/xdA/AHinjLNLnwu1FdzJ/eULBv+mGugBKoeTHTv3udSyRTL+aP2x0FP8nni0G2Qd/Xow==
X-Received: by 2002:a17:90b:4f4e:b0:32b:6ac0:8633 with SMTP id
 98e67ed59e1d1-33b51149788mr18188638a91.16.1760121953161; 
 Fri, 10 Oct 2025 11:45:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61a3cc5csm4004934a91.10.2025.10.10.11.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:45:52 -0700 (PDT)
Message-ID: <76e1d080-c934-49c1-bfab-13324807185c@linaro.org>
Date: Fri, 10 Oct 2025 11:45:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/riscv: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-3-philmd@linaro.org>
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it in the next commit.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/hexagon); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/op_helper.c                      | 16 ++--
>   target/riscv/insn_trans/trans_rva.c.inc       | 44 ++++-----
>   target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>   target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>   target/riscv/insn_trans/trans_rvi.c.inc       | 22 ++---
>   target/riscv/insn_trans/trans_rvzabha.c.inc   | 20 ++---
>   target/riscv/insn_trans/trans_rvzacas.c.inc   |  8 +-
>   target/riscv/insn_trans/trans_rvzce.c.inc     | 10 +--
>   target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>   target/riscv/insn_trans/trans_xthead.c.inc    | 90 +++++++++----------
>   11 files changed, 113 insertions(+), 113 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

