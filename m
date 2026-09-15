Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22A6C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Pl1-0006Q5-Ui; Tue, 15 Sep 2026 05:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x6Pkw-0006Pp-QO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:47:14 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x6Pku-00043O-BT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:47:13 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-8692a856865so3456853b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1789465630; x=1790070430; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SEHlNvaV7zBPMN2KIyZEcotF4I7n8mu4csA8ZMIQPo0=;
 b=l/oF1bfHv2+HN0JjvGCHr0tbsxnjKa/OXrvlJxawk1H/71Ub9GrmdMB8GIUtExOyww
 GzjW0YkwAKHQRZ0m6XO5DfL+WgNNELQdZW4c4yb+fQnYgoHJeYVJszVWj01O+nV9e0ZH
 J/VpqOtNGk56TRomMnDHvnLZJIC+8f9PJPMu4gZPQnuyAuAF+m7eYBrJoYZY/NA4PhyG
 pEj5sEXvgMiOVu69rCG2RDOoHBeZ9a/a4NhJ8WYVK51m74KOdXc0jAIg1mVN+c7uDRro
 C0IQbuv9WH49YqnGE9dNednDjR12ueUE5PEZuhP/9QCHoLErWbCcktAgeJTysFbHPBOG
 Wilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789465630; x=1790070430;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SEHlNvaV7zBPMN2KIyZEcotF4I7n8mu4csA8ZMIQPo0=;
 b=T8aPCdjXeUu4SLTKVjGUSaYs0VZHgSt4pwW7jEUabgp1JwfiAoStVB5PrIcoXdY1Zy
 +NSWr+PEUY+JI58ghZwjUfECPHPhT4loDVYD0vzMDMbngfNmQr5qbB1DVxMmTPMHgbBB
 PX4UyoNn6ThNjMxd4UO9ScSwGeZ83j2IGbESa7y33qfK0zf0FJ9Pi4uij5Tu6EIbYtzi
 TTmAyvv+Emu/dooc3LdKbeyUlP/IzvYktCpCXLid3xKZ5zw1Wv3zKNq5tTQxef9HrQP5
 oYyUV79if6As2XpLqS8fhigsFTaZlQSNcAEmc1G8W6nfiVd1HQEROp48X3ZgmVlXMj/H
 voYQ==
X-Gm-Message-State: AFuF++kIckJVcXPLCVxdkS8BzeHaS8+6JhhsWjIevUdTfm9Kvv7+6GgV
 OGy18MJXDF4qzglCXIYQVk6hH3EX+L9gFRfV9RngwXoGxGEjr6yISIMTZldPwdqkKBw=
X-Gm-Gg: AYBFou0EXEzgkMP8luOLq1Zg6Ond8tg4AS27/qE1EeCdf+t4tbplBSApxvN1bgenGPQ
 dn12+ftDRpeUg90DCnVQfU6OlNqSayoyQw/OrovbWMn4E+k6NecllhIJzgc32tykNxyoXnHTzLv
 kMYTjTnJ5Ql7Wj7Mlyb/yceUKewRD9DedyhbYByIVbUT5acsYhxnY7jF6mKxqIFFP745wt6BH71
 QzdsGBWhxPnboJPm6BExcOX4td3S/dp2HDPOJmR/OVLBuEDw2JYEoC4P+vj5BHOnNYS5jmcOcZT
 1OAqiqK5WZrd/y5TPwNC1OOTXRZWIII5yIKrKgc4UbKBkuvo3mGjrnP3MmY21gOvIFw+Q92cLlP
 4z6wch/aVA1Ux5ijoWR0z5AH2L+8IZzFOHyx8bR6kn6HY1z31p8stFUiAVEHFYoYs+u0D6t8VZo
 8CLV+rg83kb38pjlJhybkuAMiZosQJNkLFqFpPu965cmQoKOoM12iv0+q7UkI2rZ2g1HeV6Ihoy
 HB0Idmf2hKeE/bEaIKA1C47HsEL7biEXw==
X-Received: by 2002:a05:6a00:349b:b0:86a:5a9b:32a with SMTP id
 d2e1a72fcca58-86f839453fdmr14470811b3a.9.1789465630056; 
 Tue, 15 Sep 2026 02:47:10 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b29abc4basm5799242b3a.39.2026.09.15.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:47:09 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:47:06 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 00/11] tcg/riscv64: Fix AUIPC pair range validation
Message-ID: <aqkRjjpRWbbUxtOE@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-09-13 14:08, Richard Henderson wrote:
> Hi Max,
> 
> In v2, the change from int32_t to uint32_t is pretty much
> the opposite of what should have been done, since all of
> these are logically signed values.  I've adjusted all of
> the encoders to take signed inputs and assert in range.
> 
> In the process, I noticed tha the branch range tests were
> off by one.  Now all performed in exactly one place.
> 
> Finally, tcg_out_ldst needed updates for AUIPC as well.
> 
> I've tested this lightly so far; full testing on a rather
> slow riscv machine is still on-going.
> 

Hi Richard,

Thank you for the v3 patchset series.
I’m currently reviewing and trying to test it in my environment.
Could you please let me know what full testing you used to test this
patchset?

Thanks,
rnax

> 
> r~
> 
> 
> Max Chou (2):
>   tcg/riscv64: Validate AUIPC relocation range
>   tcg/riscv64: Fall back when AUIPC pairs are out of range
> 
> Richard Henderson (9):
>   tcg/riscv64: Return tcg_insn_unit from insn encoders
>   tcg/riscv64: Rename sb-type to b-type format
>   tcg/riscv64: Rename uj-type to j-type format
>   tcg/riscv64: Use signed type for encoding immediates
>   tcg/riscv64: Adjust sign of lui immediate in tcg_out_movi
>   tcg/riscv64: Assert immediate in range for [isu]-type insns
>   tcg/riscv64: Return success from encode_jimm
>   tcg/riscv64: Return success from encode_bimm
>   tcg/riscv64: Fix off-by-one in branch range tests
> 
>  tcg/riscv64/tcg-target.c.inc | 230 ++++++++++++++++++-----------------
>  1 file changed, 121 insertions(+), 109 deletions(-)
> 
> -- 
> 2.53.0
> 

