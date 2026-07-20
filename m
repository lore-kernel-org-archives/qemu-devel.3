Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BD8C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljhY-0004Q8-Nc; Mon, 20 Jul 2026 04:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wljhV-0004Or-G2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:50:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wljhT-0004No-JL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:50:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84a3e5ca66eso1248061b3a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784537410; x=1785142210; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zpvwf6XG3PE14rYErPFv+buEkaHBcr9h2qTqBtJkkoU=;
 b=b5OdbE/doiiqSawXjHjHvsiPBHKSWuMbcjnFjL63WnQZmO818MyWBkgVguyEQZAFob
 dhyA05Lfq3n51i+JkP9LIXXrtfoIuvcbHZlkP1JcVjgFeKtpYAjThj/ZGixcoA8gHToR
 sWzv4ktt5V9hJCfnKMsEbcuSRovOUItYyyPNELRK8SYuZ1Ggvhx8ZuM/f99Lwzh5Qp4h
 IyeJ0YfaNXTg4N3hVKRs7A8g4r/1qP8znkW22MJt36p8PoN2Elkg9gFHMlOaktahLM0k
 faPOEGmuIgsOdfpbdSh11TnQnnR4AD9wbkCAjXstkt9YDlCCjzVRxT3uKlW/Zretyfyq
 RWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537410; x=1785142210;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zpvwf6XG3PE14rYErPFv+buEkaHBcr9h2qTqBtJkkoU=;
 b=dqiWrXti5LxXmbYTX9aHlXTZRHAPFV4pqMOJUsPnbwh70BviZ1fSXOOOvF9tGN3f51
 t+8IA9n/XGWx+wBN44jN93+nHn/O6zQCuePNW6rtwAJrRKvxDs4YM6wMsXazwdsj8pNh
 9H8eLi1HiliKo4iQp4jEVlt4ALAewotnljVD2VqdnttYiXXCmH475ruL1Z+73mjVLtTu
 ftvi2Cg23oF4pLNiOIA99R9cfLyJvpr1QVJ/3T793r7xJ+JSF9o3Q0wQ6Y/oRlCWO3xk
 4EGTOV7g7zsXk/ZwZwFosZIcrDlzBXfYq4UEGgBG4FHUaSA/Uz5C6Wse7TLiXe9etgFp
 VU0Q==
X-Gm-Message-State: AOJu0YxUtxusNHnByEWpkBYlV7f1ID+8HbF+3w21+zT4Zl1fiZ9GEfRF
 oUhmWVMRJZ2Q9Qqout+0OaLaetQXLEuzeYC/7j6cXvqGpzBoqz1CoOM0
X-Gm-Gg: AfdE7ckBxtP3eSIG/kCnsDsOv/U25zmaByjru/a2mTzYu2a2Ng50BN7jIl2KxZnIvdH
 OdGOmEwWO7RuR4rBj8gZQ3GDdRJg2EU4IKLklrxjQc2syTwrCAYqxZKynJbBkZQDyjHzOiZsGhW
 24ZKxRsxrxMwxIdTZnmY3F7jOr46mi1hR/VlB16VJTqdAaUY7jwPeZrXEGDpvoQqI65SmRI6n26
 Cb4Zg2BqcILcTITJwhXoUlfP5KIdjh7En74vLm7Yfjs6epDQAo5fWaza6GMI8+OKKpEfIyD0Xzp
 FAUS95Z7AcCOPJ9MdV+923yNajpmd1QrYoX2HDz5lNre7IaareEXrZ6OyL+qIcj+St8GY321ATf
 nW3uBjAtY8k7kcydwyC4WmsSb1vYDe4j4FoDuYDNuful90K88L7LbZrmDaKZ48TIO9il6R+1nqe
 /jQ2AFiNHSMA/8aW6oloCbH+fibw==
X-Received: by 2002:a05:6a00:278d:b0:848:3dbd:5cb0 with SMTP id
 d2e1a72fcca58-84c29444e58mr9047785b3a.2.1784537409634; 
 Mon, 20 Jul 2026 01:50:09 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2af331e0sm5179239b3a.28.2026.07.20.01.50.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:50:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v2] target/loongarch: fix data race in CSR_ESTAT
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <3613f855-8b22-2e94-fa14-339acec997ed@loongson.cn>
Date: Mon, 20 Jul 2026 16:49:53 +0800
Cc: qemu-devel@nongnu.org, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Xi Ruoyao <xry111@xry111.site>,
 b4-sent@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <185FB2BE-2645-45CF-BA2B-316F67495FF5@gmail.com>
References: <20260716-loong-race-v2-1-01e68e4b850f@gmail.com>
 <3613f855-8b22-2e94-fa14-339acec997ed@loongson.cn>
To: Bibo Mao <maobibo@loongson.cn>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pf1-x42e.google.com
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

Hi,

> 2026=E5=B9=B47=E6=9C=8820=E6=97=A5 16:34=EF=BC=8CBibo Mao =
<maobibo@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 2026/7/16 =E4=B8=8A=E5=8D=884:48, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> The CSR_ESTAT register of a CPU can be read and written by both the
>> CPU thread and other threads (e.g., the interrupt controller thread).
>> Currently the possible readers and writers of CSR_ESTAT are:
>> - Readers
>>   - tcg generated by trans_csrrd(, CSR_ESTAT)
>>   - loongarch_cpu_has_work()
>> - Writers
>>   - tcg generated by trans_csrxchg(, CSR_ESTAT)
>>   - helper_csrwr_estat()
>>   - helper_csrrd_msgir()
>>   - loongarch_cpu_set_irq()
>>   - loongarch_cpu_do_interrupt()
>>   - loongarch_cpu_exec_interrupt()
>> The access from the CPU thread is not synchronized with the access =
from
>> other threads, which may lead to data races. The above readers and
>> writers shall all run on the corresponding CPU thread except for
>> loongarch_cpu_set_irq(). To fix this, the access to CSR_ESTAT in
>> loongarch_cpu_set_irq() is moved to the CPU thread by using
>> async_run_on_cpu().
>> The data race has been identified while running the test cases from
>> dracut, which is using QEMU to boot a LoongArch guest. By running the
>> tests repeatedly (about 30 times) in the following conditions, the
>> guest will hang in the middle of booting:
>> - Host architecture: LoongArch64 or Aarch64
>> - Guest kernel: 7.1.3+deb14-loong64
>> - Number of vCPUs: 1 or 2
>> - CPU Features: max, la464,msgint=3Doff,ptw=3Doff, or =
la464,msgint=3Doff,ptw=3Don
>> - Accelerator: tcg
>> When the guest hangs, the guest kernel log shows various errors =
related
>> to RCU stalls or other Soft Lockup or Hard Lockup issues. When =
running
>> with 1 vCPU and the guest hangs, the guest kernel directly hangs =
without
>> any messages and stucks at idle_exit.
>> With this patch, the guest can boot successfully without any hangs
>> during repeated runs of the test cases.
>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>> Changes in v2:
>> - Simplify the changes to move the access to CSR_ESTAT from the only
>>   unsynchronized loongarch_cpu_set_irq() to the CPU thread using
>>   async_run_on_cpu() to avoid the race condition.
>> - Link to v1: =
https://lore.kernel.org/qemu-devel/20260714-loong-race-v1-1-54111549c95e@g=
mail.com
>> ---
>>  target/loongarch/cpu.c | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index =
fb03424ffa8cd5e5d250531cc2a36fa789fc25a9..126c3ad276cc44311942542e086bcabe=
41d91b63 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -57,12 +57,27 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
>>  #ifndef CONFIG_USER_ONLY
>>  #include "hw/loongarch/virt.h"
>>  +static void do_set_cpu_estat(CPUState *cs, run_on_cpu_data data)
>> +{
>> +    CPULoongArchState *env =3D cpu_env(cs);
>> +    CPUSysState *sys =3D env_sys(env);
>> +
>> +    int irq =3D data.host_int;
>> +    int level =3D irq >=3D 0 ? 1 : 0;
>> +    irq =3D level ? irq : -irq;
>> +
>> +    sys->CSR_ESTAT =3D deposit64(sys->CSR_ESTAT, irq, 1, level !=3D =
0);
>> +    if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
>> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>> +    } else {
>> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>> +    }
>> +}
>> +
>>  void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>>  {
>>      LoongArchCPU *cpu =3D opaque;
>> -    CPULoongArchState *env =3D &cpu->env;
>>      CPUState *cs =3D CPU(cpu);
>> -    CPUSysState *sys =3D env_sys(env);
>>        if (irq < 0 || irq >=3D N_IRQS) {
>>          return;
>> @@ -71,12 +86,8 @@ void loongarch_cpu_set_irq(void *opaque, int irq, =
int level)
>>      if (kvm_enabled()) {
>>          kvm_loongarch_set_interrupt(cpu, irq, level);
>>      } else if (tcg_enabled()) {
>> -        sys->CSR_ESTAT =3D deposit64(sys->CSR_ESTAT, irq, 1, level =
!=3D 0);
>> -        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
>> -            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>> -        } else {
>> -            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>> -        }
>> +        async_run_on_cpu(cs, do_set_cpu_estat,
>> +                         RUN_ON_CPU_HOST_INT(level ? irq : -irq));
> This is a good method with async_run_on_cpu, there is one small issue =
with irq =3D=3D 0 interrupt injection where -irq/irq are both 0.

Since according to Section 7.4.6. of Loongarch Reference Manual Vol1,
bit [1:0] stands for the software interrupt SW1 and SW0, I expect that
these two irqs should not be manipulated by hardware sources and thus
the irq here should be larger than 2. Can you further explain under
what condition the irq line 0 and 1 of a cpu core would be connected
to external outputs.

Cheers,

Miao Wang



