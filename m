Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC732CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 03:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNizs-0005S9-VK; Thu, 14 May 2026 23:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNizr-0005P4-Ey
 for qemu-devel@nongnu.org; Thu, 14 May 2026 23:13:55 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNizp-00081P-UV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 23:13:55 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so1053455c88.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778814832; x=1779419632; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iYuy30fcEm4dQtmNcPq2/cqKinv+b39fRv7cup+70oo=;
 b=ItjXuQQ7Xv4wSQ4C2rRlpvhvHO7Ipzdgo2co2HDyIZLynKnCNLUCuN/WvIQMG9xDKf
 fMHkNPGyic8L3N9NxzP1Z145LCkhuuPHvMKzS4YzzBIOpShh27Nfnbq4ahWLIB1hsZV4
 x9Q8jzjXrsgiTLB7d/yizflmEB5V8gmPUaLMoZ+u9y+/qWk4g8as38ahfEDun2iRIu3J
 7b9LEvmoJsCP0ok79fEe+iHWywbiqbYQ+OmHVYaCXbsnIi8Wu/Na6/fTuwGiuBtj1RkV
 ecmQVgSZ6SPn+JRLDKWU+diSZvMAnu6sysQ6OleEUY9hKYq7DlM6NnGNWyYeGipf1T1M
 MaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778814832; x=1779419632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYuy30fcEm4dQtmNcPq2/cqKinv+b39fRv7cup+70oo=;
 b=nSN9udFNhp6A/0UHlJZPOpdtnxPoG6738uPI6PNpB5y8h7jfJqax2RYgqcZRYbBGRz
 /B4rPCDyJxBLKl03rvHH9I9Uovq018r3/Z9SDls+xnuoZ4aEyYdJAqzhTuJJnyQfWzbz
 csiPufnAOEfPVPDvO1fB/iFU5/b0BJR7Kq547RKLZbRknCHnKh31j7D2uQAKvQGsDJos
 dt4zWtURrzqAjrFksKg6G7T6pixVhovIr10PgG6xOnFKauAo6sOz2lIU7L7Przuq6y1A
 /p0Y2cMk+2deyEhnaS/FgY7p4X0ww6tdvVn9GH3XXQIvItPlThrkLBsoJDfCs3lC5r3C
 DpoA==
X-Gm-Message-State: AOJu0YxSnL+zR+6kmYNduNHvHQXFgnLUhYRZaLL+3A43JBi5RP3EXRqp
 k2fJiSsMNBB2hp6RBw7UV827Mq+MOZ4Yf3Gsjcyn0iTQbgrxwsHnWLdW
X-Gm-Gg: Acq92OGDyzhPpfhafsfh5lSaibzEhSnPlxLnGAzLPJCgiWW6RxGz4CjBXlq36PEa+RH
 DbJTyqzlRWRGMq2x6/H+fCjuhS/BNHbg1a83oudWMIH5iPs0/Q6XKHlGmGzrl7fvrM4/PVpzaib
 BbDR4E0kAW8TbDADC6mCpf2tQThs7HQ5l5FvhzE7EfVquWs6YzNufTmO0tEsYIIvmddbkYBRiy0
 CoQihp+vE/G6pL3VANRUY/VCqs6iQ8gKi9KIaunVRiJoeoDaTskxdthQHE8Rv37d4nOei1Zdzq/
 OnIeX3qKbrv3t672BHFV57O+KwfpfEy1dkJqRPA7i171v4hNbaTYilmbbmK/QxJiGOmeF6ef7QS
 UH15mjlvlZDwWgf+pBaiL5IQnwFk4xp/TtBz5pWAPzy1HMP94E05EMH9bpQJdcpBlTitzvYSM3r
 Vusbna1nECaXqLtzxblcq3YZZiQPptFJi+V4rt/Hg7bvD3qREFccnmSoHhnWDWr6J/YFyjqWUnn
 Nw=
X-Received: by 2002:a05:7022:1e11:b0:12b:fc21:874d with SMTP id
 a92af1059eb24-1350484e801mr878880c88.19.1778814831925; 
 Thu, 14 May 2026 20:13:51 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([64.186.250.142])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33a618sm7423656c88.12.2026.05.14.20.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 20:13:51 -0700 (PDT)
Date: Fri, 15 May 2026 11:13:44 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com
Subject: Re: [PATCH v6 1/4] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Message-ID: <agaPV8EtLGFnqwZk@ZEVORN-PC.localdomain>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
 <20260514204640.2540054-2-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514204640.2540054-2-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Thu, May 14, 2026 at 05:46:37PM -0300, Daniel Henrique Barboza wrote:
> We want to configure other CPU types to use profiles as an alternative
> to adding every profile extension explicitly, i.e. a profile is nothing
> more than an extension bundle.
> 
> This means that a vendor CPU can set .profile=rva23s64 while having the
> same handling as any other vendor CPU. Same thing with all other CPU
> types.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a81485981c..586683b28a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2863,7 +2863,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>          mcc->def->bare |= def->bare;
>          if (def->profile) {
>              assert(profile_extends(def->profile, mcc->def->profile));
> -            assert(mcc->def->bare);
>              mcc->def->profile = def->profile;
>          }
>          if (def->misa_mxl_max) {
> -- 
> 2.43.0
> 

