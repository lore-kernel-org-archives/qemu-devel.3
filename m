Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86ADC83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmBw-0004os-6S; Mon, 07 Jul 2025 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYlue-0005eJ-Be
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:29:48 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYlua-00031M-4p
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:29:38 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e898fb745beso3593513276.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751894974; x=1752499774; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TYnMcPleIYNAkshJTZhrTCfgOjED3VmCaQJtjNszuTQ=;
 b=n8sZtd3LuVQWxsLezoy0L4QA6bZ6WDMfN+n+2rpH802jRs5Mjx+LU6kp2Llwi7tA53
 ohWnTVTlzlPZ5C6vWoQCe+5xmyVmctqIQGxAuqOvJNtw3uJUuAE2yk+mtN34kbq8lsSq
 huUevfup4n4Zz/nbPsnmYxirsPSz6Nwrq69c8urkyQzmA3n30msJU2hDOMtKg99gTWYs
 dno2iZrxYDBeD6iyy+pUJL++TqB4oSPE+E8voydxI7fAWEe17nztz+1hSNwGwbc33m5o
 +55AkMfZMJxl5UcZ4kzac5v/cT99lY/ojI6+PykKoUG0VDFIOJUtqTnQAsTpBERIlHvy
 IB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751894974; x=1752499774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYnMcPleIYNAkshJTZhrTCfgOjED3VmCaQJtjNszuTQ=;
 b=d1UuTBxpE0/ITLsJE7ULPcB/EJhVKdcZmZEEQTKRPaeLUUBphglu58GRCnPi+rWZsK
 vAnhqW0CSr36RjTl1PnROZIajcGrVXNvya4htdARjXj2JJLNXtVkrrWwx2nU75Iu/fuv
 bUZc67ljzfOP5lo4+e5tFIF1liP8Xha0GbW0/rnhIbMwouftW9jKPtDH9cwIgdDipK/C
 gYqZqK78hHXp3irdOdwQgfKWv7VD+ib2sh/0sCMqHxdDXpdwGk7fAEqTk0WANI2gKvcO
 EQya0Ulu8lNLeenBqIx8SOXhG9yLv1pXcH/IsXt5H8TB5lb0y1a88dA3Jlv4xsIjyRhE
 SCvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqxwRQ7UUZ2RlmZ5cp3Bu040AXXXANL0idjfvhIfyjJxTcpdt9lmnw+/6tRdY6UaFPDGnZk6n5J7nG@nongnu.org
X-Gm-Message-State: AOJu0Yxf0evzF2Awq/SaCjbv3u6ffXh1Ca953I1OnrgW9AOOifKQMf/y
 Vh4cVMBoqSKCbgBWunWI5LpOyq81WF41E3ij4w8NNp7l9GBm8qrB94v78LAIz746eewobmhpHCY
 KgtzcnXmnJ1RKfc/sa06ebYEJgJ7Zdax0UrXsz5o63A==
X-Gm-Gg: ASbGncs65ESWg+2ISjGhyyKzoVv8PlpoMjPrvgvqBk7hYLD3/X8zvq1ZtKAMEHC0Grh
 vM28YjJaf0N7eeFSb8wQpbER7ciWWC6xuxvimnsTHe3exvryWopegaw7gU+cWe78Rtf4PfJw8Xx
 inRqylvqeqSh3GMDbIw0wQJZZqYOK2ubXOClqMD5+WuSw9
X-Google-Smtp-Source: AGHT+IHDSrZ19p9N/wYEnBvnzOuQ++DPQ26XnYlMUv0Gf03nDnidVAFP+U1UHR3jDFsRM69SAai7Txk3JPFbS9SCNfU=
X-Received: by 2002:a05:690c:4491:b0:70e:61b:afed with SMTP id
 00721157ae682-71667e2423emr159371187b3.7.1751894974319; Mon, 07 Jul 2025
 06:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250707131530.1141759-1-eric.auger@redhat.com>
 <20250707131530.1141759-5-eric.auger@redhat.com>
In-Reply-To: <20250707131530.1141759-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 14:29:23 +0100
X-Gm-Features: Ac12FXxoX9eHgJt5918SpI5ulGCGvE-uQ_KIvtF32w-Dus9nAWJ6HJhVz8fs8vQ
Message-ID: <CAFEAcA9VxC6CXK+iFFAyktuX1jsJ=znpamkvG5TuwowLxdWSsA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] hw/arm/virt: Allow virt extensions with KVM
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org, 
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 hi@alyssa.is
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 7 Jul 2025 at 14:16, Eric Auger <eric.auger@redhat.com> wrote:
>
> From: Haibo Xu <haibo.xu@linaro.org>
>
> Up to now virt support on guest has been only supported with TCG.
> Now it becomes feasible to use it with KVM acceleration.
>
> Check neither in-kernel GICv3 nor aarch64=off is used along with KVM
> EL2.
>
> Also add a migration blocker in case KVM NV is set as some
> GIC registers are most probably not properly saved/restored:
> ICH_AP*R<n>_EL2, ICH_EISR_EL2, ICH_ELRSR_EL2, ICH_HCR_EL2,
> ICH_LR<n>_EL2, etc etc.


> +    if (vms->virt) {
> +        if (!(kvm_enabled() && kvm_arm_el2_supported()) &&
> +            !tcg_enabled() && !qtest_enabled()) {
> +            error_report("mach-virt: %s does not support providing "
> +                         "Virtualization extensions to the guest CPU",
> +                         current_accel_name());
> +            exit(1);
> +        }
> +        if (kvm_enabled()) {
> +            Error *kvm_nv_migration_blocker = NULL;
> +
> +            error_setg(&kvm_nv_migration_blocker,
> +                       "Live migration disabled due to KVM nested virt enabled");
> +            if (migrate_add_blocker(&kvm_nv_migration_blocker, NULL)) {
> +                error_free(kvm_nv_migration_blocker);
> +                return;
> +            }
> +        }
>      }

I think a better place to set the migration blocker is in
the GIC code itself (maybe in kvm_arm_gicv3_realize() ?) : we
want to disable migration for any setup with a GICv3 + KVM + EL2,
not just the virt board.

I also don't understand why we don't hit the assert
in gicv3_init_cpuif() that checks that if we're not TCG
or qtest accelerators then the CPU doesn't have EL2 or EL3.
It looks to me from reading the code that we ought to go
through that function in the KVM case.

The rest of the series looks OK to me.

thanks
-- PMM

