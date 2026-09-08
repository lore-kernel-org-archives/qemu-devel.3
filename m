Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2698EC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3s98-0000qf-1O; Tue, 08 Sep 2026 05:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3s96-0000oY-JW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3s94-0006Ja-K5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788859777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfgA8aa/yGaVOBw14R1U0cQ0FrDVTK6BJ23gxPGOANU=;
 b=h8ihUavprjMuZJusDkO0zc4kpKl1QwUZmtJ8l16eVZTKnRg4Gg3uFaP0BmQnZLYC+J3vz6
 A8lqvwNLS5nOqxLWdr7K/dADjGH9B7MdPKYP581MLwv4U5esqjeoHwnejZXhNBp5o2mez2
 TtCYvSRgxNB/09pwyL2HBqi2c/zmycc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-kmiWJsBEObSmXxMF3qJmLA-1; Tue, 08 Sep 2026 05:29:35 -0400
X-MC-Unique: kmiWJsBEObSmXxMF3qJmLA-1
X-Mimecast-MFC-AGG-ID: kmiWJsBEObSmXxMF3qJmLA_1788859775
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso41209795e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 02:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788859774; cv=none;
 d=google.com; s=arc-20260327;
 b=a9XvKR+6VXJdIp1GxAFDrJ5nNiKITI2zGxPuh19i/SzpSKn98kvw9Mzd74RhuHVW0w
 WB4WBEuBGfwTx06JfoniUytN59AnzDYJbqEmrhhSUQfTlePW+SS/KAaHcBnzKA4Hbrb9
 snViz/sf/lkA1YvOmgRv8G6nCub59BJv08mtMHaDDHlcyiaKzwWi5VVUCPNdSoEA9mef
 XNQtIfdnqKciez/8PIJMgt9dwHm3xz50//ZzyAI/qe2/1npo0qhMt6A/wi3ZGsg2mBAa
 A2jfaV0veokyOnwQfQV8UyDzbLcrUIsnjUckyTyKiOLER1bymzsp9zx+vyYofWVBNVaw
 D5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xfgA8aa/yGaVOBw14R1U0cQ0FrDVTK6BJ23gxPGOANU=;
 fh=RZB1IYSmZ5sMBtJbiq9zjMYU5L/WpKEgxUm5akNH6jk=;
 b=XktA1tgcJDvl+jABzHmj0zxorh6LZRFsWIHkPXXwLFyvmSc0xD/viyHBft3deBQuzX
 EGDIay3/z4oOUMlZBTzHXyUULSR8Hasn++apRkwpMZtXuzBUaaxSpYLwfmz9OFhisRrW
 xzklT+PC0HWA79zJ4zC7KQ9su3exXNOTwmHgsjRwTzFVzMPvXX2av+ikRxDq2G1HFtqk
 FrCQkW0/z03SiSk6L+1MV9h3fDEjY7c4fjuYCJp4IBB8Co1xLXLRSoqWUEr+VZbd5ARX
 +T0toGteMoCB6aW65qPz0j/WC/BFlkFy+U7BkAoSc8WWHN6EDzW64id40/HTQvAERiCS
 gybQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788859774; x=1789464574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xfgA8aa/yGaVOBw14R1U0cQ0FrDVTK6BJ23gxPGOANU=;
 b=cEtRQw0oo1c0k+jV321uxw5NuiVfYTzoBFeKwIJYp+7hm/2mD3l8xmWakLkwIdMocC
 rxaYl1bAqyrUgE5N2w6XGMOBE0LEU/HBBPwdcN4owjJOtKyvb5slU8zlmea+azSZfx+l
 AAI8l59QK3LClMtFT99MiBcpopTTwf5XN2xEtiTkG08SYZ/HTAk11Z3BmVn2xd8ivI9N
 iXykw507DHyR2t4AEXSKS/dnUvtwp2vrIx617cFiY3BKrpRm2g/LduWn1NbAdG0piBl4
 3G7budYJUktkzQ9iv8/F5pedurSFNGv5WVNpIXhr3hw7Z3TDXJlLJzQmi2Kzw6H0d9o/
 TYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859774; x=1789464574;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xfgA8aa/yGaVOBw14R1U0cQ0FrDVTK6BJ23gxPGOANU=;
 b=j0/KYE2xbNxRFgEXG5XeGh5j9OOR8HmykDbdKcYPzhYnDP30AxHjODbnCGZaGPTH8h
 TMD+zN5FFD35ytiq4uuliIw3UNaGQVolUbvGLhdG54ktH41pXpVp1vtKg6ftj0t4CZni
 QnkVw1lGCFEmt9J00tJXnmduF5JQH/4ah41uIhw9S3mVqXcxfn3aTI5+AUs/vP585JJg
 7ip8Xo2kKpFab/ho859ZLkn9q6lYy4s6urihDXHJm8pAX4pB2i19f5hb0mX7DG4OQEJ5
 YZxYRQyHxuCiCfKBO/K0zHqcdzAUC0AmvmOLC4AzQBzgkhndy+K07D4A8dytj7SUyb4h
 cHpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRymeh/DyhgpvvX7fD2Zoorxb6Qz/bYYW4+nCz9mbdWxOkpRpTG5rGpp7VXfeP0yYsAG8VArQ9G+u/@nongnu.org
X-Gm-Message-State: AFuF++l87maQKL3o+VQPZ10C+khAgkVbLsRukVFsZuKm4iPz11m4LJRp
 xqHjkZxLuThA4pe2x1WlAhWvz9j1AHsmfbZrOHuz+4j88lxhY3WEM/8xE4SOnGfN3e2zXxmSEl/
 ilA3j5tpdrY8cj+4xGaCZXtf0lxkPTc+pWbAzmaBGeIyGEPaHmjDSodgiy8BP69BzbEgvwpfxDO
 wVDszFDGMOCI9OO9X4Kz6tbd4VeuIVNlI=
X-Gm-Gg: AYBFou3VDHp0Zk0y+JHAKqkQTFpd1HgFQYbwj49gF21Rg/V2CERzV69ICuqryVJdfCb
 dLLZyH2FpRPxt3HOx6MW04nE4rxU5ZX7puIsQMpJKIU9IuUtr9zmvtcyLx/NvixNWxjvbfh593X
 9N8tbVWWnVZePOgV6TRXvEGL8WRnnz8SFQCCEdjlcoxhKt2lnLyxe8ykllkQ0FMi+8H0VqFAqeO
 gvUoSKHScpo4RqwIMAtJo2BEVIPKuyDfgX/RYVxoBJ52fz0GFCPQQGaEW3M0w==
X-Received: by 2002:a05:600c:5488:b0:49d:1cc7:5ec3 with SMTP id
 5b1f17b1804b1-49d1cc761afmr20558645e9.9.1788859774576; 
 Tue, 08 Sep 2026 02:29:34 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:49d:1cc7:5ec3 with SMTP id
 5b1f17b1804b1-49d1cc761afmr20558215e9.9.1788859774135; Tue, 08 Sep 2026
 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
 <7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com>
 <5aba99f7-5310-4cd3-a38c-3e9b922c8b05@redhat.com>
 <CAFEAcA9tz=Br3dRe3mN1fPkjm4y36eRSWUMs=bU8zDbKczCCsg@mail.gmail.com>
In-Reply-To: <CAFEAcA9tz=Br3dRe3mN1fPkjm4y36eRSWUMs=bU8zDbKczCCsg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Sep 2026 11:29:22 +0200
X-Gm-Features: AcwNN1W_NGC8plnEvOk-6gM3fivJmbRtNPbUZ4BJI7iAS0S1x9EmpiRhvoabE98
Message-ID: <CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 8, 2026 at 10:40=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 7 Sept 2026 at 22:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 9/2/26 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> > >>> On the other hand, if we do have the BQL in exec_halt
> > >>> then why is the x86 implementation explicitly taking
> > >>> the BQL when it calls apic_poll_irq()?
> > >
> > > Trying harder, my understanding is apic_poll_irq() only requires
> > > the BQL for the apic_update_irq() call, not apic_sync_vapic().
> > >
> > > So maybe only apic_sync_vapic() belongs to process_async_events(),
> > > leaving apic_update_irq() to transition_halt_to_exec().
> > >
> > > Paolo does that sound like going in the good direction?
> > Unfortunately not, because apic_update_irq() is needed to call
> > cpu_interrupt() and break out of halt.
> >
> > By the way... cpu_has_work_after_processing_async_events() is a bit
> > long, what about simply cpu_poll_while_halted()?
> >
> > Answering Peter's question above, the way in which the code is protecte=
d
> > against the BQL is basically two-fold: 1) kicking the CPU out of
> > whatever it's doing, for example in tcg_handle_interrupt, 2) changing
> > what other conditions affect cpu_has_work() only in the vCPU thread,
> > e.g. with run_on_cpu.
>
> Ah, so it is called without the BQL held? That's quite unusual
> for CPU methods, so we should clearly document that.

I agree.

> I bet also that most targets don't expect it. Picking one at
> random, the sparc has_work function calls e.g. cpu_interrupts_enabled()
> which does not look like a function that is expecting to be called
> without the BQL.

Why? It only accesses fields for the local CPU. The problem is
interprocedural communication, and only if it does not use
cpu_interrupt().

Alpha -> ok, interrupts
Arm -> see above
AVR -> ok, interrupts + registers
Hexagon -> ok, global registers writes use run_on_cpu afaict
HPPA -> ok, interrupts
i386 -> complex but ok - though it should use qatomic_load_acquire
loongarch -> ok, interrupts + registers
m68k -> ok, interrupts
microblaze -> ok, interrupts
mips -> i think ok, interrupts + registers
openrisc -> ok, interrupts
riscv -> sort of ok, uses BQL for register writes but should use
qatomic_read/set as well
rx -> ok, interrupts
s390 -> probably wrong, s390_cpu_set_state sometimes not on CPU thread?

So the only one that is blatantly wrong is s390; Arm is slightly
wrong, i386 and riscv are technically wrong but have correct locking.

> Is it OK for a has_work function to just take the BQL across
> what it's doing if it doesn't want to be bothered with trying
> to make the handling truly thread safe without a lock? That
> seems to me like it would be a lot simpler and more reliable.

The simplest way to write has_work is to make it use only
cpu_test_interrupt and checks on local registers. That is, use the
synchronization provided by common code.

Paolo


