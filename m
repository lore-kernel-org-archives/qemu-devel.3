Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD365CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrk-0004tR-Rc; Fri, 22 Aug 2025 08:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1upQrh-0004sp-Ds
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:29 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1upQre-0002QA-IX
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:29 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e932ded97easo1935350276.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755865643; x=1756470443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BYsKwztJMauWR7WjTG5BAj51rSQL/be+C1+B8xc7DMM=;
 b=QLMI2DmKAv/ylQ8KM88MXP4Ag6QgGwzEawzKcw1aRtFESj6ys99lFoxdm4ZgFxynB9
 uLTsEPmwNmWMPwbTpx69qLvXwdEi0I251JOoCNHAv5oEg5iJVWFSZwzltcGyRn6FBLxS
 AuNHIXoXqCEWSBY1n0jB13iWhpAl59DNWCZvlL14Hno7FNKcpJBq+y1sN4i7eQgSGDPU
 5s46TScO1Ff+mCMzLxc0FZtRreSputKtnctpwjcNRHUBae9sQ8TZRlRaLEu/vMz8dts+
 927QmmEW4N6+pi43szmvRxDJySnyh7NLH/amHpXNVj4SJLhkme2+yzetyaXg+RcL2bRT
 x3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865643; x=1756470443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BYsKwztJMauWR7WjTG5BAj51rSQL/be+C1+B8xc7DMM=;
 b=X/wZ34wqF+82+dZV0khGz2svIc+Sjnp2l9dF1U67OxVbAhP1EyJ8VUMjBgaMoC7Mfd
 6D41EFLL1fEpYKft3dEMNu/1tnAT5ejaltxhoEewGmd+MZh1UoQnHsdtD3qSQaovc8VQ
 k8RyMxINt+suS1AO95jWEGN06WErYJzI9ASuwOWzgoebKGWQ+DUKkWORWkX9G43+6a2t
 3+wqJndwp/05L3ROZJAJOBDIVgYgpRn5DelQ31R9wE5f+vRrFuhKwjaPV8Lzxn1gzmFy
 h0/hrkgh4kxNs8EnLXXMIzd6q8BF5DvrF4/aT5UDylzgwKqQSB00S2vUSiLeZ3FC0UoW
 Ahtg==
X-Gm-Message-State: AOJu0YyVBNMsulE1zPBWMm9VNp5ltVTTRNfuNgDvEiFsYDMaaV2binca
 o43I9pMInSoFBGzK0vI2Dw7JQBg1wGmnBgc+g7lxZewxz+o2LzZomi6XUP1uZiUXONdEVQw34YP
 C2wTpvlOXZOLobSE1CQ3OLNHGc8eIqjIH+CFE3r9gUA==
X-Gm-Gg: ASbGncvG/vAJiHlrZA1jOGdWFCcT+TnZXDAkfAqGIXz4ExmVdCM8ORWpZqnsnRRQ1wQ
 xf4doKWhVtDNqlMqGa7yD61K9Z6+QK+WfflR0DHMDBWoPVTSeN5upBnrPmNlBmAfLyOGwhq/Y94
 YgS3YclOxw0gfiCvsvLV5p+u76o9RB/tUu+xnJQ0pw/rIT7LR9ePI+Z7JMKgWqqG7UHDtRogZix
 dLaq9qC
X-Google-Smtp-Source: AGHT+IF7er9eyrfv7QjTi7lidx7NPd55hetUoy0ulPmLsgaXGsCsKrTqX+j3ta5+XMTIdENeLr0GxDRNZsYVjCgBnvk=
X-Received: by 2002:a05:6902:310b:b0:e8f:f6d2:b706 with SMTP id
 3f1490d57ef6-e951c2de174mr3142690276.1.1755865643277; Fri, 22 Aug 2025
 05:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-4-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9wQ8qh3Ah+QNNXY6u8ut6ZMVqaxFTvDDhvEGYrazFPsA@mail.gmail.com>
 <CAEWVDmuAkDuss-vB35dOPP-zSOZTEK4WJGfvqLQdHNG-63h51Q@mail.gmail.com>
In-Reply-To: <CAEWVDmuAkDuss-vB35dOPP-zSOZTEK4WJGfvqLQdHNG-63h51Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Aug 2025 13:27:11 +0100
X-Gm-Features: Ac12FXxw2wMywUFCmmHFNV_0tSTgwquaHxpt_o2gB30wsft00vQuWby2sxpI03Q
Message-ID: <CAFEAcA_BV1ThJ_2L5pDd8WQhSPKd2WKbW1eb1Owrr4YswOg9Bg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] target/arm: Added support for SME register
 exposure to
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Thu, 21 Aug 2025 at 22:37, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> Hi,
>
> Regarding having the SME check inside the "if we have SVE" check, we were looking the the
> Arm ARM, specifically the following excerpt from section A1.4:
>
> The architecture provides the following:
>
> - A general-purpose register file.
> - A SIMD&FP register file.
> - If FEAT_SVE or FEAT_SME is implemented, an SVE scalable vector register file and an
> SVE scalable predicate register file.
> - if FEAT_SME is implemented, the scalable ZA storage.
>
> Based on this, we were considering the following update to the change in gdbstub64.c and
> we wanted to get your input.
>
> if (isar_feature_aa64_sve(&cpu->isar) || isar_feature_aa64_sme(&cpu->isar)) {
>             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
>             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>                                      aarch64_gdb_set_sve_reg, feature, 0);
> } else {
>             gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
>                                      aarch64_gdb_set_fpu_reg,
>                                      gdb_find_static_feature("aarch64-fpu.xml"),
>                                      0);
> }
>
> if (isar_feature_aa64_sme(&cpu->isar)) {
>               GDBFeature *sme_feature = arm_gen_dynamic_smereg_feature(cs,
>                     cs->gdb_num_regs);
>               gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
>                     aarch64_gdb_set_sme_reg, sme_feature, 0);
> }

Yes, I think that will be right.

thanks
-- PMM

