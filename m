Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE30AC79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rNu-00038e-6J; Tue, 08 Sep 2026 04:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3rNl-00037s-6j
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:40:48 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3rNe-0007um-0c
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:40:39 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-861a2ae9c51so49518137b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 01:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788856836; cv=none;
 d=google.com; s=arc-20260327;
 b=stJCCTNqWixt5PmQi+uXZZG1hAYUaUzXVZ+cfEN6UtxTkHBq8i/DVn3D1Cj7HRUXXo
 OrXpJjWlNVSXeUusuzsie+hAt06JOw+LJlR1VbDpIfyxs0TEyLbSWKhla3R8rbWgWsSc
 /AkuByIyv2GLbrr8IdTuof+uupZXusRHotT/wZSgWx8dczYFVu64OrQxJZlHrqnufAcX
 Q7P6cu7pU0q6/Dn0+puPRGPWQFjD02Sy/NXWiYhqCrJIvPx1EJudj3mBqgXvRhzCL/yg
 B1Opv6+vkxIFWkj3hH3WBvEhQcM0T1l9tHrL8eVUTacib2KPfZVx9MfxgH0sRgwcLxwF
 7uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XCWezoK2vnKZ6w2pTM57qQ4AqMiu3kxh95olZhOADU8=;
 fh=Dst0vFEtVrFvsxnCJUmAskdwY24haUlqtaHL+byGzvo=;
 b=JayVvulT62Q17XMy2qhMyFXPzjarz/rn8y9c62lmv07BW2/U51bMTYHnABGeNtt4v7
 56biKzv/9em1l/m508PMGq6QKDBMzi87Zma3miJKjzVJn3HutVui587P7/WEDbRps8TX
 b8YU6CyRDzaT00sSHi6mwoSl2DkCamgv3yNBIkqCOB+aI7bF7rjpWK6cWbDJzP9OwaRo
 K7Ekro4TqjmlApIENGWaqib2Lc7LRN+xIyFtp8JULtTpVJmI0kwB7WP34s9jyDYeGVDQ
 VP5/R1EPalbmUX6gKHzCwIaRBv5Paz4/TcOcx6KqaqQm55joMfm6PMLphpdjxhlZyf2r
 0v1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788856836; x=1789461636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XCWezoK2vnKZ6w2pTM57qQ4AqMiu3kxh95olZhOADU8=;
 b=cNMog1DaBDVqfHkFppYSalyzHR7KH2AR73IOp84SVUFhqVASAfG5pHohc8W6f6HOpO
 pSSKcMqlCNTvuU5IjycfB/yBrHeSnHwSIoNfkdxMLunvoyTz9iqfS4rgxGdhEYvom1Ht
 dNhHg1u6KLgQbTLhwgfHt9GNC8KHkaDkKWBA2T2IpgtoPCeCMvJCj/mmMwlVDQIelRL0
 4oiSqgOD7P35Woq9Drq3cVnqTGV7G2wr3hK5O1Murasg6jtNjAwU/pVaxeboV4xr//hF
 0Ndygh3pAsCvknJvn6Z6PZ7ltQWZJ3gUWeyphQ99onfXMwf1bf1BXF1B3sDZ7hVyIIml
 SOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856836; x=1789461636;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XCWezoK2vnKZ6w2pTM57qQ4AqMiu3kxh95olZhOADU8=;
 b=BsTH1ooekE1wX0fq4bX0OWYwZ7jp2UWHwQk1yc/Dv+57GXMSBTdBYkUpmO+U6AOmNT
 Cfp4bVOWCkRXFTNN0rQ6fgrdHU1AsLWrYefy1Xe1vpdFMR9CbGTTfMwLvKBVTQNTeYTt
 74GABg22XwfwUA3gVPyPyV84XxEnWZ205rs7tW3DjA8k5jJcJpYwyn09OLuIwppeqgJW
 0pd7hIsSBij9odCuqixrOu7WsX6YVuDmRSoRQsKSZ9oVjOSEtZ3fZ6aP55CpuVQVkOqP
 x7UchL2x8nwuodXEAjKaCuxvecMleD2IxE748T65oN8YZJ0CCn1593Bls5dTleu6OYLa
 oZ8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx93YDNnwLmoUHCs6W1JHY76ZmtnWhmXXwxX32qbOVZpJLiOEDTpsZh768hu1qcBmWFM98i+2BduoTz@nongnu.org
X-Gm-Message-State: AFuF++miMpOKMMYp9FRsRpNXuYmx10qG8fiG1I7GwjpjMNkeTutJkqKO
 g436HWyD+REnpxXOSdTfixVBU582ApvqsmXGIvNpAAYZv+nv0Fx4sPCHRx5Az42/Zi/OyrGHweq
 P/0CLYtSQQ10OMTvGXAab0zdLSqTfWM1q9gSRhTFKCA==
X-Gm-Gg: AYBFou1SWt2bvmWv3K1XGVCJIGb9i7ccVtBhU515wKrAUrLWk5bsXd9gzHRWsLXf7DA
 XTjNA9kE5/WhWZLyFM3BQweFvzHFhmM8pTBSZ/WmyRuYnx0TybWPV4Xy5P2UFuUnVbS0U4ia+bW
 J15sE9elK5KiQEph3rDP15fmdg78yb1V+gZF4qajlDJUAoBxi0J2uEdhfV5Cbx2m9D04Mwj/gVQ
 uqV9Kc9O3xEmbN3TWsH9xLZ6J2BIfxPvuYljWbGn5x6fV+In1PeTIDhKDFIIoscfZSwrFC+JQEs
 /jK3B0nhuvmf9T1c7BtM6xmx7nNEVTIgsMmu3LwQ8XBvCIXKWifOihkWA+qyq6uFv3kxcmjTj2Y
 qsIO1PVBNVaYjpJHw4y4FK8cmRdCCSSrx+8B62eA=
X-Received: by 2002:a05:690c:f15:b0:873:5bb2:6c26 with SMTP id
 00721157ae682-8735bb26d34mr69378877b3.45.1788856835932; Tue, 08 Sep 2026
 01:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
 <7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com>
 <5aba99f7-5310-4cd3-a38c-3e9b922c8b05@redhat.com>
In-Reply-To: <5aba99f7-5310-4cd3-a38c-3e9b922c8b05@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 09:40:24 +0100
X-Gm-Features: AcwNN1XgADVT9nOqmldpUKTR_qO7xqA2v0HWYs9lF_-D-E7d2pSx9oEnFv2OAAU
Message-ID: <CAFEAcA9tz=Br3dRe3mN1fPkjm4y36eRSWUMs=bU8zDbKczCCsg@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 7 Sept 2026 at 22:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 9/2/26 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On the other hand, if we do have the BQL in exec_halt
> >>> then why is the x86 implementation explicitly taking
> >>> the BQL when it calls apic_poll_irq()?
> >
> > Trying harder, my understanding is apic_poll_irq() only requires
> > the BQL for the apic_update_irq() call, not apic_sync_vapic().
> >
> > So maybe only apic_sync_vapic() belongs to process_async_events(),
> > leaving apic_update_irq() to transition_halt_to_exec().
> >
> > Paolo does that sound like going in the good direction?
> Unfortunately not, because apic_update_irq() is needed to call
> cpu_interrupt() and break out of halt.
>
> By the way... cpu_has_work_after_processing_async_events() is a bit
> long, what about simply cpu_poll_while_halted()?
>
> Answering Peter's question above, the way in which the code is protected
> against the BQL is basically two-fold: 1) kicking the CPU out of
> whatever it's doing, for example in tcg_handle_interrupt, 2) changing
> what other conditions affect cpu_has_work() only in the vCPU thread,
> e.g. with run_on_cpu.

Ah, so it is called without the BQL held? That's quite unusual
for CPU methods, so we should clearly document that. I bet
also that most targets don't expect it. Picking one at
random, the sparc has_work function calls e.g. cpu_interrupts_enabled()
which does not look like a function that is expecting to be called
without the BQL.

Is it OK for a has_work function to just take the BQL across
what it's doing if it doesn't want to be bothered with trying
to make the handling truly thread safe without a lock? That
seems to me like it would be a lot simpler and more reliable.

-- PMM

