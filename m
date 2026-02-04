Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F79E6E815
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 06:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnWMe-0007kV-NL; Wed, 04 Feb 2026 01:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnWMd-0007kF-LX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:27:47 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnWMb-0007Hp-S2
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:27:47 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so1011084866b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 22:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770186464; cv=none;
 d=google.com; s=arc-20240605;
 b=fp/LBHlhB+dq7KCOTkYU0X5HOwXtXeYAwrDOLU/LrO0rwQEVaL9rL9O/VqeNhavAg/
 wECwILXxHbsvhdT5z+xDA9NaaJvB+Z1OgJbM+oYFwzFMDzHLanpT/8QRFBnVPdG6XrK2
 IsTu/YQeJkUDltJltsSQaS1baUGovjUSZvlBscs0Bl9AKRH3ru94ERz8wWf29AfkrZDo
 nBLQePXRtzIbKmMlgkq2Nd8WofqFNxpBleoyHwXSeen8K2RXc2JRV3RP3XQ/ugPS2Cfx
 93lq3YnbMj8EQ9Gh3sdU6ZZGj+MgOJjsTdLeVxet9MYcsl+vElKZhDr6jh1OWMVgBA2q
 cvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y2wLZ5L3u7zcCg7GHGTYRx6GpyUpuKoPTjraUpLc3HE=;
 fh=aTR85SRgTPgSMFTDK2Kxpm8Yl1newjy/gHNrVLVyJvk=;
 b=ZNkPx/2i+cUw62pS5b256DgiPnG26Z5sIxBJcNnqIorj320/otE/Svv4mHzQ0P4pFq
 NqELF6j/SQBKxtADw7UzlCeBq9nCICFwjK1HSaujfroN9T6qTE1US/s1ivTeVwSk/1QS
 y3zl+amgYzcH6Ene8CuUzsB+panFcaafVVku+dbitrJKzJcGVIr6D9zwLu6GLs5cgmCK
 bGomz2Ru8ewvCoY7aLkMcjF6dd4+jWG3RfbHC+eK9ILV0KCg5Xabb9Xu6YkLuHU1RS7+
 LV9yT6xEiS5n7fmhuFOqhfAa0wsQ5HDQkd4CR3ga/ifzjL9fkVw9A8MD229IJlnohqdc
 q9pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770186464; x=1770791264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2wLZ5L3u7zcCg7GHGTYRx6GpyUpuKoPTjraUpLc3HE=;
 b=Re9NqckclwtGAJ8hiwcjlLCRsAeV6ni3JXc6NmOcJ1wOj8sLvI0dc5nDYHOeeUr6Qj
 10flE6fQcHK4mO63tKoGAKxjsrpCWdbCivn1g563J8IujHOBUNkIQMFPbxuXRZfy60HV
 6RA/orF5JDR2NPVh4xlGn0siSLe0tEozjyckzcCdLji8gAqUOpjlJTGqslPRHzx7V4ib
 NdOTqRCv3vDoBZ+ZyTf33lgMtL2m0VseDa/9iK8kRJUt26UPHCZJE3EhZFpKeIeYZq/r
 ljQ1/vnxAQrdMSBlUhw1EtNTBkIWBJoyuP7mmUG6UJAvj6qWCjrGSLoR0FrY3V+Oah06
 fk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770186464; x=1770791264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y2wLZ5L3u7zcCg7GHGTYRx6GpyUpuKoPTjraUpLc3HE=;
 b=NWa0TOMisH/kOQ/ztu36sfEq3wza6oEeu43DqdthiOl/JqVl1UDc6TSZlrSzHIfBwE
 3j451VAr6jxUA1Xo0/tXd3uaSzt5KjIVPFwdNIc6whOiHOO/ClXZdrMjz7RU1mhPVPSd
 4oEGn1ScdkLtraNhw5wEkZes2PUSdgh2Xnhm/gXHDYOT0kGWe027zetxRzeLjJZTEzQ7
 3NBRKR3Hb7SbL3H95kWNcKYHeigipElROlb7XyKPjZWMr8aslJcziNIjOWBGbR6w+S/O
 n+zoEJBQxeq5ZcecLKsFWZplGbQoVeWyOmB6EaiGnS6GcjuQiRE+0KIU8/OKXK3ien1b
 ozsQ==
X-Gm-Message-State: AOJu0YzbE6YYoFS6k+u73Ra/KuViLCmPSTjWTg1wigtDBD05fBKtHefw
 QprP0C1N7sJJpG1gmncJO6mqyhF1H5iLCoZULWg430iLUwsm+LMGtLchTfXD4mSXt72z78S/Puu
 TEyjeQeCXMNhuuJ/MGirwZKJAv4kfuLt7qFId7ja+ng==
X-Gm-Gg: AZuq6aKFir2zlK41RTUyD1hUf0N5LZxUOTSIwTp9rSk6NRzEVHfWC9x/cJeB79Yq20A
 VQ/UD1CCUo58i62t+TNJFC6RcIVJUdNMkvA87Kz3ZCKoCc+uR0H4FZE16awcnMbFoV/dPXB5FQu
 XGZUfn74W1avEfSIEbelMBGJFdiLWcwgxTNsfC7ACyMekYp6ungiajyUWMz5lGepCnMGEt0svmJ
 7OwTYUzNggRx6vMc7NVBoFRLdvvlfeOT7IlmIESVv7e0QYTxJbNo1EjrnBH3RVYS2nSFbRanw==
X-Received: by 2002:a17:907:842:b0:b88:7568:26d5 with SMTP id
 a640c23a62f3a-b8e9f2c55ffmr121065166b.27.1770186463996; Tue, 03 Feb 2026
 22:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20260202075358.2137740-1-jim.shu@sifive.com>
 <20260202075358.2137740-2-jim.shu@sifive.com>
 <fb85a3b7-5281-45e8-a0df-9c804236324e@linaro.org>
In-Reply-To: <fb85a3b7-5281-45e8-a0df-9c804236324e@linaro.org>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 4 Feb 2026 14:27:32 +0800
X-Gm-Features: AZwV_QieW9mrXM4MdDvL1H7RgIA3SuEzWzuH8LqKtRYn1828kNueF-QejlGhKHU
Message-ID: <CALw707rNVBpdAoiShMdtJZCmg4BEq-YKy+ejT0jc=h_hPx7EPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x62a.google.com
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

On Tue, Feb 3, 2026 at 10:24=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/2/26 17:53, Jim Shu wrote:
> > Pass the access_type so that we could know CPU will do the read or
> > write access. Then, CPU can fill the CPUTLBEntry[Full] of the specific
> > permission (@prot).
>
> This is wrong.  tlb_set_page* is recording data for *any* future translat=
ion.  There is no
> one access_type which is appropriate.
>

Thank you very much for reviewing this patchset!

Considering the target MMU support in QEMU, I think tlb_set_page* can
support RO/RW permission 'CPUTLBEntry[Full]' if the target MMU has
RO/RW mappings.

I have leveraged this idea to support cpu-side iommu translation.
By using the access_type, we can do the following approach if the
cpu-side IOMMU translation returns a different section in RO/WO
iommu_flags:
1. When the CPU does read access, tlb_set_page* will create a RO
CPUTLBEntry[Full] with read section & xlat_offset.
2. When the CPU does write access, tlb_set_page* will create a WO
CPUTLBEntry[Full] with write section & xlat_offset.

When the CPU does interleaved read and write accesses on
IOMMUMemoryRegion, it probably has poor performance
because It will get much TLB miss and go to the slow path create a
CPUTLBEntry[Full] with another permission via tlb_set_page*.
However, I think the functionality is correct.

Do you think this approach has any possible issues?

> I know you're trying to handle cpu-side iommu translation, and that you h=
ave a case which
> requires reads and writes to go to different address spaces (?), but this=
 doesn't help.
>

Yes, for our wgChecker case, reads and writes will go to different
target_as, section and xlat_offset.
When it has RO or WO permission, the success one will go to
'downstream_as' and failure one will go to 'blocked_io_as'

> I think the underlying issue is that, for your case, we're handling iommu=
 too early -- we
> want to be able to defer the translation until the actual access.
>

Currently, we handle the iommu translation early in the cpu-side.
Thus, when IOMMUMemoryRegion changes the translation, we will rely on
the IOMMUNotifier to trigger the tlb_flush() via TCGIOMMUNotifier to
invalidate CPUTLBEntry.
Then, next memory access will call the IOMMU translation function
again in tlb_set_page* to find new translations.

> r~

Thanks

Jim

