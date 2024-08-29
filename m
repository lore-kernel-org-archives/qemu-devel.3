Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E725C7114C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSqw-0000gM-3V; Wed, 28 Aug 2024 20:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjSqu-0000bw-Qr
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:17:28 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjSqp-0005Wp-Pj
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:17:28 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-829e3fbcb87so6345939f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724890642; x=1725495442;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OFOguJdp5ZzDBgYPdTgKZrMdAs0syusavuVRW2bEasw=;
 b=KuEcrUPHerZm99dW01llq5BXHVbE5ImKU+xgXEbTIUhv+NGuC9qKSZ511Ffflyzk3d
 3qkMoifQmxY2XwB0ggZUWHHeAPhZvFvy74Ytsv8xjnXeZh65er/GQtIYHfJ9dYMzdgiw
 ye4IEHRBxQI/LFDTewYi9nvqJAu5hHXyNPHLkORp3jRBCz7ZCApsgfcxzSXTe870ulCu
 gm6C3zTMCaaCk0FpBmWrPpofOn61JkkGd7l5GS6Ezx7Wgj8HHp8Aaq1/joBGwYqE+bqG
 oYi0rpYep4t+0zW8DLxnLOI1PquWGLH39eoqCO+N6ok3cSUjzrEznvwnnmNBTJ8zTdVn
 HK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724890642; x=1725495442;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OFOguJdp5ZzDBgYPdTgKZrMdAs0syusavuVRW2bEasw=;
 b=SCMPT5wgUHkFrzM0APbck+9o/XgHaaUUs3JplPjbELvz1ql1p76DYYityRkbkw9Zlu
 K8T9wzEvLjJlan3c1eMV+8mnO0JTpubV+pGfI9fFtM7Fc0D/+1kugrOQhMWYGkMonuBF
 mw5ZbXAOgXI0APX51C5zFyyxAfoZURYlmiUl+Pn0AYLCKZkDEL+ImOyu0ma+ZUxyXog7
 N8FU+EGoExkAXDHvptqNOgYLEsGkc7mZmgdx0Ctvk338fzcg67Vcu2d2d7Xd+xJXVOEt
 4xTsdiueYt8WSk2To0heu47mRsj45LmE/kPyHYYOO9LG0DZx4zEeA5gJv7IXNy9lKAmK
 2C9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrNoBAyuxUo5G8+/7XDerHav3P9Tevbi6ts8yl2hKCDGEW8mLYwbbdb+PKGVFwdN1qi+n/RinWAaDv@nongnu.org
X-Gm-Message-State: AOJu0Yz3/uoUq156EhUF+wGsg7CZDIc3lwqs11HYArsXO839ULWlGf8q
 CdS0aQyLQzDVTbdCw5MXqx2mPoj0VfXpcWeqZxVOEEYVTUJq1NfkxKSsOgdZUI0=
X-Google-Smtp-Source: AGHT+IFRHwVH485qb77Q+4bLp1tnkooINuBr7YRKFHwP4nqNbExgm0tODXuGe/c8JTWLJyeXezPiIg==
X-Received: by 2002:a05:6e02:2189:b0:39d:248d:c2cf with SMTP id
 e9e14a558f8ab-39f3784f791mr15712905ab.20.1724890641953; 
 Wed, 28 Aug 2024 17:17:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e774725sm66848a12.32.2024.08.28.17.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 17:17:21 -0700 (PDT)
Date: Wed, 28 Aug 2024 17:17:19 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v11 13/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
Message-ID: <Zs++D1WO/G1ntixu@debug.ba.rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-14-debug@rivosinc.com>
 <CAKmqyKPyyupykqc-0yrGm+msZPuf+=jVWvD86yz7mfqjn5MT9A@mail.gmail.com>
 <Zs+2mIsAw2BKODtk@debug.ba.rivosinc.com>
 <CAKmqyKNVA3Y06824XbbsZ+7n2Ach==ah5m-28zxzCn-48En=9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNVA3Y06824XbbsZ+7n2Ach==ah5m-28zxzCn-48En=9g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=debug@rivosinc.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 29, 2024 at 10:03:04AM +1000, Alistair Francis wrote:
>On Thu, Aug 29, 2024 at 9:45 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Thu, Aug 29, 2024 at 09:29:49AM +1000, Alistair Francis wrote:
>> >On Thu, Aug 29, 2024 at 3:49 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >>          prot |= PAGE_WRITE;
>> >>      }
>> >> -    if (pte & PTE_X) {
>> >> +    if (rwx & PTE_X) {
>> >>          bool mxr = false;
>> >>
>> >>          /*
>> >> @@ -1160,7 +1177,7 @@ restart:
>> >>
>> >>      if (!((prot >> access_type) & 1)) {
>> >>          /* Access check failed */
>> >> -        return TRANSLATE_FAIL;
>> >> +        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
>> >
>> >Why is it a PMP error if it's a shadow stack page?
>>
>> A shadow stack page is readable by regular loads.
>> We are making sure of that in `case PTE_W` in above switch case.
>> But shadow stack page is not writeable via regular stores. And must raise
>> access fault. return code `TRANSLATE_PMP_FAIL` is translated to access fault
>> while raising fault.
>
>Ah, ok. It's worth commenting that we are returning TRANSLATE_PMP_FAIL
>as that will be translated to an access fault

Ack.

>
>Alistair
>
>>
>> >
>> >Alistair

