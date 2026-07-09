Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1590CC44503
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 04:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfwk-0005pj-GY; Thu, 09 Jul 2026 00:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfwh-0005pG-Fh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 00:01:07 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfwg-0003mE-2f
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 00:01:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso798176a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 21:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783569664; cv=none;
 d=google.com; s=arc-20260327;
 b=WaXczMd82mehfQ7USMqeNmc174/sWz+knO2BxCSQaafOcoJPn+goNJQZzFEOxhTfib
 nqLCv77c8LwaJlxQHKbq/9DSbYAJpbUXUCGRVKbqpAmw7uvPF5IX/4bmc6pcHz4tzeB0
 VhQxKKbJM9iVbRjbYnXTV16KrsPXXnPOQh8FSZyK79JMOHT9364Bw7xnQwYbEH9vCMbs
 Yt+cfgkrCQyLp4AqIPjZGwggJxWZ1iRQXj46mMC0t42G/4ASSJPbNgUSRVNztur6MFum
 jeZEpayajvDyy5tB5xu5TPw7cuxxz/V/tKnU3pBSNWy8Twfepqezh7JALvLhMqf8Z414
 q+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NaufSfwlWGDsZs9fUfWb+nxF9H5v26Vc5gEVxGRhtP8=;
 fh=AAxaXLiun4T+reItkBLVR0FKKEVGF/kHO9i1dhcwv58=;
 b=BzWc/KG5UEdWPl7KoFc+AwIOigZ4rf+ihD38ZRCAb06cwlVTamYfn/KFV1YiwTRB3S
 rIVM+JQL/NanxuRFlquy5M4YF3PU4DU4fUKy1HP6KQTkyFnEYSirRVajse/+HNZMlIH2
 xsW1FbBjdA2iAbXAHFIAZO/+Wq0dkE0aB0JhF+jHe9QLQgeLZZl3m9o57gQQhz5JDq2/
 rPD8ZFkR8rlrdApk+VXzBpP4KYf7a12L4mUW4lzU9GwgrcAegm4XGDi7X79iixHRhb3h
 Lcc9ybQlydzO2pf5C3LsMWomiAo8PU9OjJCxyKU+ITfrCbPf3Qw/CHNzSynvqsUqD40z
 jnGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783569664; x=1784174464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NaufSfwlWGDsZs9fUfWb+nxF9H5v26Vc5gEVxGRhtP8=;
 b=fSGChr0QpcZyKCg+QoKE1GkSlkXhdwFrJvy7IHvm5/jErWOx2MfCL532i+6dA8ipbM
 8l3KhcLghhbUXFAgjc8eewhsH+25Zja9C5uIyE1iZAytzhukXG+uy4/VgpU0pLMePQhs
 ddFfau3QpPlY6Zyq1vOrJXU+k6eXrsBeGBfgiY1UgtdPpxX0EVsJ03WciHECzGk4GEvv
 9CXWwccj+yQLbpkvWaoDa6Ua687jDviNmuxRdqXZW3/D/YnvJtEPsozKDhaIymyXK7lM
 BRjUCQw5MqUofiPVaHghitQtsjng2zn2KD2Tfc4UnQeQylxe2QJnXZWxjiBnlxUu99xs
 T1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783569664; x=1784174464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NaufSfwlWGDsZs9fUfWb+nxF9H5v26Vc5gEVxGRhtP8=;
 b=H8AJFA20EN01j8DrA2dp2ApyKOsVnqnrQZ0QQCkXJukt9RRWxYqL3QeUJngwqDY2VQ
 bwr4RQJAJXX/Cs3wSQFANjVSOmq3AHYsEBR/eA1jhdlVycucujjIreRmOzgSO1HN01QW
 IguZFbl5uT3TbwtkrBke6XTbQQ7hdHZnrPc7dSjjeb56BTAWy0XJRY7RrKANtuWLhdZj
 ocwd+ViU6SDFXCLuUVW6A5p5iOcssIj9S/W9ISYVilsHbckoRkb0nGLFMb0jA9WOazZq
 5hzhxqMNTgJz/ZPxJdGiNgvxHf0yfi8yIiuwqTCPWVcyFwzdID5NcTW6zjri7nQRV+sU
 2amQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDk8OF254OIPK4lwgyAR3JqODftYegKbmJxk5oUs4hcHoZnUw3riTRQ18JxEHYnCruIXSfh0n5GLZr@nongnu.org
X-Gm-Message-State: AOJu0YwA04IOswghU0cR5e22aA7fTvJ2ed/Z0IniqoD5OSYSXrp8T45z
 CK4qRKxs0zS90l5AwE11b5S/MNXtH/zpw9HaQy3E48rrEovW+K230OuHOL+YARc+25cy/ZXkmT4
 lnYzmRJEFPhsWgp9syDlSwinysxwNrUE=
X-Gm-Gg: AfdE7ckq9+C8y+htN7wEMSVPlxaXVyZhLivvieGH9gH5jVElcC55k3gWFRh51m1+MKB
 y8IIGRkFWLEDSFRFFf5UEg4u7mhh3QECBXvdJ9nL8BxDBNja41HlR2EzhgBz1JR5uea5fLSuYxd
 BZfw9UU+Qcxn88gchvyf7H+wcnr8bnldF1NfrfQLzWmEu45W0D/XxzksWToxcKiQWuzrcgxb9G4
 7+YTsLmuV17k/cS1M9Cz86OGkgq1uLNcLzw/mFVGwjU589UfknVkBdum7EtePVUy7kyLmdCMBsF
 yUaIZN8dml0eRA2lRkzHgP6lRQ4=
X-Received: by 2002:a17:907:a45:b0:c12:c5d2:bf37 with SMTP id
 a640c23a62f3a-c15e744d7admr42721266b.12.1783569664313; Wed, 08 Jul 2026
 21:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260707072610.403595-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260707072610.403595-1-wang.yechao255@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 14:00:37 +1000
X-Gm-Features: AUfX_mzMJK3FhBR5WllfYAmtNYJ3YiWcweJxYLMulahN8aYBA5cvNSAX3Bymv4A
Message-ID: <CAKmqyKP40_Pc9i3HtTCCS9ueHWTE0qgSFyavTJM73S7icm5_8w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] target/riscv/kvm: add extensions after v7.1-rc4
 update
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 7, 2026 at 5:28=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> Expose zilsd, zclsd and zalasr.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index dcdaf7f2b3..e2c6a4b3aa 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -303,10 +303,13 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL)=
,
>      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINT=
PAUSE),
>      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> +    KVM_EXT_CFG("zilsd", ext_zilsd, KVM_RISCV_ISA_EXT_ZILSD),
>      KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
>      KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
> +    KVM_EXT_CFG("zclsd", ext_zclsd, KVM_RISCV_ISA_EXT_ZCLSD),
>      KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
>      KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
> +    KVM_EXT_CFG("zalasr", ext_zalasr, KVM_RISCV_ISA_EXT_ZALASR),
>      KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
>      KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
>      KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
> --
> 2.27.0
>
>

