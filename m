Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CBCCD98F0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbV4X-00086x-1f; Sun, 21 Jun 2026 23:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbV4V-000830-PE
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:11:39 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbV4U-0000hi-CB
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:11:39 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so5293859a12.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782097897; cv=none;
 d=google.com; s=arc-20240605;
 b=NAgqSLI5r4VKLCfRlsjBd/hm70oStjCJnU/DJWVXjbSBjcs6mCShOAemBCjnmmvEzi
 rngmLjcwqkDHAfF9C6eNpajbIbYpMzeKZE0tZP8rKTbf6VvrgtlQgWYj20/sh9Z76en5
 +HFj0Cc3r9R9C3N2zxA3FYk8edbjUxM6yCrYbvoCe8ZJ6Av4thfMdcjF2moss0IwtY6j
 viibK5hpnnOSIRWfRaNhuvL0zsFGNQ6q8gqQL+5BlbSuGAlY57DK/4DlslfL0P0P7ZFK
 Kb098ZZggkHsKa43f/kJU5avsews3KcXNeid5nTfhMCt/aFmIM+8a1VnjAU63eO4E75b
 PJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JntfJ9F2eN41l4wu2CNj4Q/zrKqMuZSbKBUV2DfKoSE=;
 fh=WK0BsCEZEQlogeERbC1lHfr5MNipu8gWwkpoG5WzhMM=;
 b=APlnmiyJhByS+LXsOtGSZjEyY5ufemTyET3MQ94m8OkEOSlIGr/sVgjVOn54p51ZCn
 V6oEQYuw2eI5LBlj5/ZXt2GTye0TRafHequuGVkAgEadc7OXIZIt65lHTKD8963fDNaf
 JcQ5OrIS09+OxyNxzXjmAT3nI6MTNYR0NDXVa1nVAnDkQFX9uWOL5ERNhhledhGOzQeu
 z5u82QwyZP1i9kWio/Bri6KgIYYTzlGQs+Q+UoGVCAuFoaaAdb4lNuemQymiJRdsPBWi
 dF+klkHOF/SSo7MCeFKWb0OPX3iJoN/UMbMp+zZ+ZwbHDnhHS/r6my8UAuOjn6LzjvF9
 lQ7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782097897; x=1782702697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JntfJ9F2eN41l4wu2CNj4Q/zrKqMuZSbKBUV2DfKoSE=;
 b=WdIWQ8PWhkizbEWJBAexg0CefpS30Aa5XnJo+7D6V1zF0hJbz1ybTJIc0D1zSCcKs4
 T3UHPnRmHBOJixpJjSEB36hXHQrUqol1J1Jznxx/HswXXti5hIqHRnYsXt/irCHVDEnN
 yyNEzGscIZwGqYsprtsWUyGdxe4j77pp3O6mGd9cEXZV+4ysfncVCKADOAnJ0UfUkic2
 R0tC6tr6xtspQlpU0rse3AkW/Pk4lmZ/NAh+pkDxASez8T20TucuhCjLbG+hgtH/EWAP
 S6BMRyhCXle19QwhOmYN+X+J0mNCf2Q1ZjFAn6te6h7YWUWZm+kghATHrdf/Abigh3Ck
 uR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782097897; x=1782702697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JntfJ9F2eN41l4wu2CNj4Q/zrKqMuZSbKBUV2DfKoSE=;
 b=GZa44P4qQL4oTWN7MZkTFQwbWkbKL7c+8n6YGdK3TefN7hxPxUREdu1nHwXBPATirr
 zneoOHzVdQH2/OyvfBW8lyQLToKByKdRFfF7IvuOl0FmAElvoW/9wXFzMYGKFScO2W4g
 SlIUDcmFi2pUUWUiv07sGCEMpMyQ5GBW9hULXdl5BNeGG9VJYCWN39k6HTFNet8vhvlN
 JL8iaBL+7HOKLfE1f3V3JLMcJTsWfTzYAlPQGEzdHeXJ673xGCTst541lGtYZplgUFfc
 bGEdCbu/sxjYBbg0iB34N10851Pu/cDNueb3d0UjTnMnRBI3636wIw3CqFHRcHA6bm+F
 WLMw==
X-Gm-Message-State: AOJu0Yzund0IX/QEpnDxfo0utDLo6//mzVLy8LlPmftxQxQMp809pMyR
 p+USa0wxxY8HtXWxjeBcrpkaW1fnrJqpn5Ief1zI62rPSTCBrsaX51NGUOYHmkxo7I2chOs2L63
 ouaSf99v94MXhlrYiCRWnu4/yMYXVvXo=
X-Gm-Gg: AfdE7cn2bk46THpiqO/FMnHdwwyzlLUXIy4vjOuHVUoXR1EZj9FEDY+MFma9XLn6EQk
 gDChxdq0gInwNJayvKkiXicGzT7Hurw7eEo5KhlzKulN/axipdpH5DyOErCp1FjxZLTj476hjkS
 Q67TeREEOyMM4atwNy+L7MXl+BAbI7cMADp3srdS6tSc56UkYF6hnWHZZZgEbhZcO1rx440PGmp
 1brgHj0W3rkBMAUuJLKJfixOOrk1qEov02gk4nhonxWDzfbHoQmCatXLyNYXFgrbVkZHfK4f2iS
 1Xi9xvlIVO+7RuXigoV7hGj2EkQbhejJ9qgTBw==
X-Received: by 2002:a05:6402:4583:b0:692:4a58:a93 with SMTP id
 4fb4d7f45d1cf-696e5221636mr5208378a12.21.1782097896742; Sun, 21 Jun 2026
 20:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260617063630.111472-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260617063630.111472-1-wang.yechao255@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:11:10 +1000
X-Gm-Features: AVVi8Cf7wgTR1twmBGUAmC46kFmN40MdxhNMez-z_NGn_rKwZCSGMFqqY0JkjWg
Message-ID: <CAKmqyKPiaYO6Q0F4YG94M1uN5587DMTppW2w+-Vf_EwpZzDGSQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: add extensions after v7.1-rc4 update
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 17, 2026 at 4:39=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
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
> index 53d88339c1..6bebbaf7d4 100644
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

