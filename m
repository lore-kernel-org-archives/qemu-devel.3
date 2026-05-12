Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8788BCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtqs-0007A5-E2; Tue, 12 May 2026 16:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wMtqQ-0006lq-Kt
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:36:52 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wMtqK-0003Sk-RN
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:36:43 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-8be236ce888so47952166d6.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778618199; x=1779222999; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpsAZCSR7wni07d+1v7k4fHD1x0csRe7cXk1TEskBac=;
 b=aMFznEoaQpZDXqdw83c0FYEv3tHIf2aQXQr5W9Gz6aYfoFqcSUJLzJRdvOWlLGIILp
 KFupwjaNbRpKyV2E/78wULRPr4cCM7VYoMNkk0LQaEAGSV5RGnTNlHvt2BE0sIzQj3o4
 DXK9ls/ELCokBY5xhFIh7eAzYNpqCj0uIua+Z6thKIuessFb3uLVkIdcYW5VHGeC9e1S
 BHsKXwTfMlJfMJHKKFhQT9OQdCA1lJ3DM74AzxbzQESZ7xivj0ZjNFoTpRVJTzpfswVg
 GxykSZKpV5FzUlvX/K2NEFdJTKagKisx6hkboAdydi0UgvPIwXsPMb0JN7ONwEJt7uMZ
 OvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618199; x=1779222999;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpsAZCSR7wni07d+1v7k4fHD1x0csRe7cXk1TEskBac=;
 b=C5eUqKvGsKavv5PGAn0sPS+w/0ADycB+91sWxEG0PLpcRhQQ5D9dtlBebtERy7f0W8
 Qiqd/pC4qNHrjTOdj39jX3l88Las+IX4LAvw5Xm4UqYmA433vwcwA256tjYr2lMgHEoQ
 eUpsvNd3Eo2uxswj1n0W7u29thZz7gd5B94c9nZ3ngKlTAT9k0VIFeZxgkNj8gleFoqq
 r1i8QjEOwlg9hg1KF7D6+NeAxDTZr2Vi/DpuGRL1V5UL1K8oWjz7x61TyM6nRZrESblg
 wMoYemcObtqVS8c4J/FvPprVDy9W5NORZglywDyGjmUGXylZ44c4dCqcUtNGVcBGxkTJ
 cWBg==
X-Gm-Message-State: AOJu0YxXf3jObkHfAl8hfzIU62Mif1I8rd0ibfjXOMHycpf7LjjtGGj2
 /2IwnfoaBfE4UkROxv3KVkRGCY5UyUTwZ2BM7WSmpCvjSXB1ippiXT5B
X-Gm-Gg: Acq92OF4lgDWMXbKPBn4GkzCSJGscxvQ6IDKQ0Uqx+7fnXf1U+3TX02vZmhCRY5DlQu
 vvz76+81NMG2oNydb2l3y51Y8JRqWTi1XF7ArQAfhR13GRwIQdVLY1cEd6b2+YcBVM6sgLd9xOX
 K6xmVSBRNzCxSHiiX7ijOMfpeeQC88NaVenoBm6iTOBtQQ3iUYjf+DSMiqtO15CtJUucc2HLpZb
 RS6N4BMIs/HJPqEgHC9zxOEUgDG2eRYoaGh0n03Gh2x9+wbMbV8LaFyafz7knTuFvb1PH6Az8OZ
 wjmDNbucos51FqPniVFnpHlLM1adcg2gHPeIGovr6Y3MO2ia/0N66sXYg2dNtgiCJr6YKVT4N5A
 gWCX5NAZywHmFMRhehQczfAbNlHcpU+zHolrVmwteJewuU18l3TzKWmqa0wTfLnmlXo12XKl6wy
 CLk+jMpdG0E/hl4j2Zww+H+cyvaNP3AppEuucUgmNGOSKkdy37iGFGCcAMbDNibRKIS4+4XVRVM
 lqyn5SNKL75IwQ=
X-Received: by 2002:a05:6214:403:b0:89c:4f67:8d17 with SMTP id
 6a1803df08f44-8c7b8cf5673mr9828956d6.8.1778618198896; 
 Tue, 12 May 2026 13:36:38 -0700 (PDT)
Received: from localhost ([2603:7000:4df0:8300:fdb5:4a2a:97d0:addf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c642e0d75asm34848786d6.41.2026.05.12.13.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 13:36:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 16:36:37 -0400
Message-Id: <DIGZJ3V3TPDK.3LY9W3NAULWWA@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Alexander Graf" <agraf@csgraf.de>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>, "Roman Bolshakov"
 <rbolshakov@ddn.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Mohamed Mediouni" <mohamed@unpredictable.fr>, "Scott J. Goldman"
 <scottjgo@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
 <794CB795-9462-4299-B7EC-528B0E4F1923@unpredictable.fr>
In-Reply-To: <794CB795-9462-4299-B7EC-528B0E4F1923@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=scottjgo@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue May 12, 2026 at 1:54 PM EDT, Mohamed Mediouni wrote:
>
>
>> On 27. Apr 2026, at 21:55, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>=20
>> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> changed hvf_wfi() from blocking the vCPU thread with pselect() to
>> returning EXCP_HLT, intending QEMU's main event loop to handle the
>> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
>> always returns false and the vCPU thread spins at 100% CPU per core
>> while the guest is idle.
>>=20
>> Fix this by:
>>=20
>> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>>   halt_cond in qemu_process_cpu_events().
>>=20
>> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>>   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>   hv_vcpu_run(), which is not called while the CPU is halted. The
>>   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>   vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>=20
>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>   indicates a pending interrupt, and cancelling the WFI timer.
>>=20
>> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>>   transition for any halted vCPU, since the QEMUTimer is per-instance
>>   state and is not migrated. After cpu_synchronize_all_states() the
>>   migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>>   and CNTV_CVAL from there. If the vtimer has already expired by the
>>   time the destination resumes, hvf_wfi_timer_cb() is invoked
>>   directly so the halted vCPU is woken up.
>>=20
>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>
> Hi,
>
> A bit of a side note for reproducing this:
>
> To reproduce this on current master, as far as I can tell you need either=
=20
> -M kernel-irqchip=3Doff or -M virt-11.0 or earlier. -M virt(-11.1) on mas=
ter uses=20
> the HVF vGIC path.

Just wanted to confirm that I re-tested and it seems like you are
correct. This must have changed semi recently? I was just running with
`-M virt` before. Either way, it's good that the defaults seem to work
better now. Either way, I guess the fix still needs to go in for the
non vGIC path?

