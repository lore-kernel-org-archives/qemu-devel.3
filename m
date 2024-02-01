Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4531AC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZV3-0000mE-Nl; Thu, 01 Feb 2024 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZV2-0000lB-ET
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:01:12 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZUz-0006pq-Iq
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:01:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so1550602a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706803268; x=1707408068; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNAeX9MhSd8JANkjCMN1qO6Ct0M9y4aZLFPmuSALAM4=;
 b=f5AJWXB9eK14lSyubNtgR3orXdLQyM5kSw5XE1Vefr+c7NiZD1jrYQOQSuWicrXDtc
 3gQXi2QPnfrNOgo7UUnoqqitnOUMuojALvTeYc8RJoUtmSuvHeUvE+oMn+h0h0lXb7dT
 K+6UEUfbXLHJx2HsvmFGLjDphG9zliUG/fhfEKyqND96yow+AHcm1Cu6qSSs3tTkLawc
 UTmpcbHb+UcZvYM5Q8a0N/p7A8mUBMCta5Qift3+oyHc/SZYMqeESYHHy4EgBOM5hXV2
 gUdiEfuyPEo2DS71azv8yKk2ymjc6TjhJh4sw3GzjjC/ACqk5UMG9vagk9Z0qOzALhEA
 /p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706803268; x=1707408068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNAeX9MhSd8JANkjCMN1qO6Ct0M9y4aZLFPmuSALAM4=;
 b=mhynQZwEiwl1mZnXhwQCi3THoL5no9Dx0BFhN7iFCHe3d1EDMC07eLNEEaEQUg+CDd
 voUPo1nfNIaIHcmNhkhDroDJtQbi8PS9xc4zvB/NsfbU5wZbDDqSGs0dKh0enzCAyjHn
 PiKMEqr8Dcf30ZvcBtnEeeMJdmzhzxiTA704MBPr7GznGpcrKA8ODkTv6DSfx6tcHuZR
 uK77D/h74SgxtohHXP5exZHYaXSr82VFnsFvIr5LJ3ckIQh6lIapxTuh+6QP5sQiG2R2
 Ysr8D8dl0AasHUsRPGim/pXUkrxn2snqazXvGD/kYZKMZ2TOP+9/FJCwvWOFRgCGr3ye
 R4PA==
X-Gm-Message-State: AOJu0YxC18HW1Sdy4HRXyBT/p5Qqmy+d2tDG2iDLFn087ZCzdbK9a4fM
 4q7ovqjb1XkYUJHP+ako2DfJgp3+WFqI4eJoGqd5yBT2zqe4jBGY6z9q1c7oX4Dy8RZHryGDLkm
 MDYigsDLqluZBka06KhkoeReDaDC/XXHhva9n3A==
X-Google-Smtp-Source: AGHT+IGjhK81r+/kYIABzLNHX37BHHtuIiDYBNMC0rxsvrb7yC7FdU3p9sGF2z0S4EReUawqCm3spucjmfv4rJ5Ppu4=
X-Received: by 2002:a05:6402:2211:b0:55f:6b8:b2fb with SMTP id
 cq17-20020a056402221100b0055f06b8b2fbmr3625596edb.1.1706803267744; Thu, 01
 Feb 2024 08:01:07 -0800 (PST)
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
In-Reply-To: <87msskkyce.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:00:56 +0000
Message-ID: <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sajjan Rao <sajjanr@gmail.com>, 
 Gregory Price <gregory.price@memverge.com>, 
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 15:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > So, that looks like:
> >  * we call cpu_tb_exec(), which executes some generated code
> >  * that generated code calls the lookup_tb_ptr helper to see
> >    if we have a generated TB already for the address we're going
> >    to execute next
> >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> >    address for the guest address
> >  * this results in a TLB walk for an instruction fetch
> >  * the page table descriptor load is to IO memory
> >  * io_prepare assumes it needs to do a TLB recompile, because
> >    can_do_io is clear
> >
> > I am not surprised that the corner case of "the guest put its
> > page tables in an MMIO device" has not yet come up :-)
> >
> > I'm really not sure how the icount handling should interact
> > with that...
>
> Its not just icount - we need to handle it for all modes now. That said
> seeing as we are at the end of a block shouldn't can_do_io be set?

The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
which happens earlier than the tb_stop callback (it can
happen in the trans function for branch etc insns, for
example).

I think it should be OK to clear can_do_io at the start
of the lookup_tb_ptr helper, something like:
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 977576ca143..7818537f318 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     uint64_t cs_base;
     uint32_t flags, cflags;

+    /*
+     * By definition we've just finished a TB, so I/O is OK.
+     * Avoid the possibility of calling cpu_io_recompile() if
+     * a page table walk triggered by tb_lookup() calling
+     * probe_access_internal() happens to touch an MMIO device.
+     * The next TB, if we chain to it, will clear the flag again.
+     */
+    cpu->neg.can_do_io =3D true;
+
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);

     cflags =3D curr_cflags(cpu);

-- PMM

