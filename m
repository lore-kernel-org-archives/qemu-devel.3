Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5878CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hdN-00029f-5Y; Tue, 14 Oct 2025 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8hdL-00029L-Do
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:12:19 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8hdI-0005tE-Tn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:12:18 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-781421f5be6so20791477b3.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760458334; x=1761063134; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QYHb+EHjAjIONDz+4Q/jbJWZrU7avRL+3+qKZfFfUZU=;
 b=q9yjr2hXf+9N42ELFS9xOCuAy4yHKAf++On7Blb+sO+ulBLBy9vUCX07WaAbD0sMHZ
 6o41hoF99KaYR3KVQ+k0tSiMN3RYm/aU2jBV8JWFrkdOaJGucRUPx4vcM5F8FVrNpcdl
 mbga6KGr8NBQ0VJ8dl+PLwjaije295kKnpGKNbtlid0srbwoFbCteae5Y5D2NpcKF3tF
 pRZTvcnCQ+YEaVg3aPtGoz+W1Jq9M9iI3jCQPoV4U73FLehVyj+HCS6/vuv8Zip2IiBD
 SEbksdRjPmXBpMPgzN5YwoGtmqNwrX4br/7F2KeYYHFvIeKyhRQi2+yqbMg2WRw1Vfrx
 /JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760458334; x=1761063134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QYHb+EHjAjIONDz+4Q/jbJWZrU7avRL+3+qKZfFfUZU=;
 b=qHxkuKMgroYE0LDRLCkVSJN5CWIO/rhhGH80ibKyhPmK1hBMD8XeREiyXdSm1X1MZN
 NB0QCcoWibG/sjc68SY7UH8L4Df8ikQEiT+vyeD2eiFmqM9vWsP7oDdOr8hbp81PAEPV
 TgIjTL+K2almpEC0tDHjONwYulXR8KuV6h0e1Bg7jjAL3J2cblyEPn5ZAfK1NyPYOtwk
 OQP19z1tq9JXS2gMqATrL3MoshoF4zTBtl8ayaauJwtXtO5syYXI7VRVYI+J4PYLXbmj
 Rib3K5vXKvLJTyW1MNY3+wxEXxOrk/b0J4N3pN4287++6K+tyAlfBiF56yhog5xCaM0W
 ixwg==
X-Gm-Message-State: AOJu0YwM7c1zQbYTKNwZqRiOoi2IjbyvkQVvQPY1q6nbSRjUz3bgFTGq
 Qz89s/NlIwLMaQ+m3vDJbjpPY7/jU4B4FqeL+2Gyi6fD05wor7a8028wnvWsKys45Sw8Fl4h74a
 YJGHwzI3AtlG3GTDGeHGXDwO+zgRauXajuPqkLsQDSQ==
X-Gm-Gg: ASbGncuwPkRLomnyW6yPVqa7x4ncXerfF4lwXqXalf5PxdSHvKWTZpiM86OWs4bmR89
 fp1ytudLTxLBZ3v2ZcVlPoEcUI0+mEzwUDhHlJjK7KKsIRp0fpJYw4tX+nSICYImVGACbakWMCD
 DfxgL5vu9pnvZBIfTF4Ci2FEMFXSQKiNWLWOdGBkJFpvy8L3AKlLASWUTl/xMB3VkqaRAnBThVf
 vf7PKY/S4ingbwbpci1ME3Bz/S8D0c=
X-Google-Smtp-Source: AGHT+IFO4CKdCcJjR4fC4POWfSgG4yKLxW9LUpE4LUAkcSPj+pOovvY9clKmSq1dSQa0uxibEeyKJXX1C62Ae1HJD7w=
X-Received: by 2002:a53:ba8d:0:b0:63d:24f9:5332 with SMTP id
 956f58d0204a3-63d24f953d8mr1173240d50.55.1760458334365; Tue, 14 Oct 2025
 09:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
 <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
 <a630fc58d9f946988bd6c27479543dd1@huawei.com>
 <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
 <880fc89ebcb9404cbc135a501e635671@huawei.com>
 <57c971afc3e64c1cbd48d032fb557c00@huawei.com>
In-Reply-To: <57c971afc3e64c1cbd48d032fb557c00@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 17:12:02 +0100
X-Gm-Features: AS18NWCynkS6OlvtaL1LTU2CTYLa3zbkj14bjXCnh133YUVMfgAdndrCIK_pCXk
Message-ID: <CAFEAcA91-QGjZbGnrffH138WEdrZx9cEQjAzPsQfBg4G6rahGA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 14 Oct 2025 at 17:07, Salil Mehta <salil.mehta@huawei.com> wrote:
> There is one more issue.
>
> /*
>  * Update KVM's MP_STATE based on what QEMU thinks it is
>  */
> static int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
> {
>     if (cap_has_mp_state) {
>         struct kvm_mp_state mp_state = {
>             .mp_state = (cpu->power_state == PSCI_OFF) ?
>             KVM_MP_STATE_STOPPED : KVM_MP_STATE_RUNNABLE
>         };
>         return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
>     }
>     return 0;
> }
>
>
> value of PSCI_OFF = 1 and we do not initialize the default state of power_state.
> This means KVM_MP_STATE state will be configured as RUNNABLE at the first
> instance till the cpu_reset() happens. This is not correct either.

The answer is that nothing should care about the KVM_MP_STATE
until after the CPU has reset for the first time (i.e. we
should never try to KVM_RUN a CPU object we never reset).

-- PMM

