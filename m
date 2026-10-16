Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B8CCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHgzl-0005uw-7u; Fri, 16 Oct 2026 08:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHgzj-0005uf-FR
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:25:07 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHgzh-0001Uy-Lx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:25:07 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-888cbacf70eso69780367b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792153504; cv=none;
 d=google.com; s=arc-20260327;
 b=WtzD6iWVJ0BTsSKozWvKZp0Tj7q2o8XR16qwKOklGzJELvO1RNqxHatWJmNXprviFf
 vTeOwjFq/yS8icY1Lo+KjCIS0qS6gvD+tyIkzeCXaB8jEasCHV1hhBHc6TueOrBoqWxi
 M8cvcnIKL11bFicNQq8uRG51MBp4VRsiurMhPQEr96S6NtbdvXqRpUqxUtd6o/ilwfzl
 nqNwGdIoeKoibzDjjhlfx0tgNSFZFo1T1dovLhQhPCg8gLdPyO8t9MeHnOjCax9G6Dkp
 txPoqLXZsH3k+K4byaImZLCFtENJQ5RWx40GijLL/WJ3mLwAEPmInD7+8HM3BHRMfBdL
 9jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zQ7v723Xwm8CKvdncmpgIg6KtAXzOUldqD/wPY6Bdsk=;
 fh=4Giw25YYZtfLg8PU/tqw40Bkq25vWDFNrgLkVN5GQfQ=;
 b=Ishhln2tcl/cmfAOmv4IEF0D+j8T/rmuLkXw/zqtRr7MsVKhPd/yTTcEpBmfnGTN2T
 P5EV4TPxiNheSwx1gGv//1UhAi3ZR/jt8iRjvo9F1oGRlcm/IQjZc/6tApX0ADVezCKL
 0vIYuPU8PkztXFbYwmcPBIJ4R5nJ0MYXi0SM4+H/XH4MRBKI981I7LLeGAbacC/eBYCj
 WZb5MG3KgGzrvULJtTTizLZcjDm11bBELg1GRCvlcpDoKyNl/+Fnk9LeHCtmCbGQbDaK
 YXU0cO/NKaUSPneBmo9knarUMpaKni+MAcQX3LAni1hP1Nv3ueZopEizXNdOs8TeaaeZ
 IMPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792153504; x=1792758304; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zQ7v723Xwm8CKvdncmpgIg6KtAXzOUldqD/wPY6Bdsk=;
 b=pR0ahONkEAKK6JkJGQtHIKgMMLZW4s1gUM92HLtLXiJHc7Bzuoww3beO4sSpNUE0bn
 dX6+xvyi04CnXYTM6zuTj3HwTPqiTgWUvWEd2PfNHYCO1X7Jm4NYmWqSAqH6iArZYCNX
 ETYpQk5n9WO0RFMwf6vPrJgMRToTn/QkxSYeJLifU0k4YcvCdFwRIuhGv+wQm8banfFP
 zcK1azclPVJd45Nc/R+rkLcVkrwGnAJf3N7Oij5AGn5eag7k5aqaLL7smVNSsblknBZm
 3DMDPLNHaHxxWp37FMcFHMWPOzqQyb85JkrmaT4IdmYMCk2VVao8k+B/p9I15zjwxwjL
 gxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153504; x=1792758304;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zQ7v723Xwm8CKvdncmpgIg6KtAXzOUldqD/wPY6Bdsk=;
 b=sPqna54L5tm0tz7ffTKP/0df2HaJJdSPQ6GQZxgI5xRSkXKtWMScvrmx+5rf9mXn87
 rkGICKgRn4gXUj+z/o0feXzDFGNpjPw7w3Pc3SS13YTZoVKTXjR1H0Xb7z0Dh3fiUprZ
 9ieJQC6fl66e9AMXqIw3+f+RoseL4UXMzMkk0P66dCL4CumjFhGck8k1P+vM29uKA/qw
 Gr4we5AthjiLzPPipdW6bStg33xKEg8utQrY033X8RHx/tl0HAP6B2qYPFg3L8rprgjP
 zkXHMED9tElu8h08BrLF06rLVij51ZB4VJEyqH0YVcrcbxm9lW/OWfoCJf/nDgFj74t0
 Gy8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv1ik0zTo17FSoRYONnyjQRBSzdl4djcRcCEUml3AsfYHg6YuTtredGbu7mRt9INKgidlDd8C//F6e@nongnu.org
X-Gm-Message-State: AFq9FYKUp+o8TSmotWzSqH6Wlp+rM+TzksT1OPMDKoFTPPok7IlpwHSI
 RO0LmfNEqcsrIFOJJuOUZ6E6vORGzHq5dor1fRTa9fF4SK425K5UCAflCJPipIeopAEmrSYxby0
 RMFSihUWrUBHhs3OVyD/ylacYfQdULf+4qKxnnJzzbQ==
X-Gm-Gg: AYBFou0/pPAsNMtm07toDTt52aw7fHyj6QIuakHDFpOCsLlp5ixa9ITYO4YtOFzaAJp
 z1p+Yu9Wx0KT0sFlMrIAsLyykY9kZ5pkJTz8MtQaiqXLgU/1DbD73B6CWn2mHsg4L59XseECVmu
 f7ZayMi3T5pCDBl69DHPf9N51zdRzgCFURFUIstJHXtK3IWVlB4yNtFlGYOuylhYEsVrgqpghvA
 SWioOfxQJVkY0jZPP2yhJGgZ8gay/AmWrMaCujFFQ1KGn6pHboR3hecwysRwcjC50YG9JTd7Cvt
 tJC6rSG8M6JAg7S4L4UX5yJ5HjZynmOFv1ii2G2mhf+DPot7ertqyjfxVroMJZAzSxBjaTENXAN
 MwwbzkYEHcnwDGwXk7o8FwV8j1uzXOlMr/NZr9r0=
X-Received: by 2002:a05:690c:38a:b0:8ab:f06b:4167 with SMTP id
 00721157ae682-8b07ed94faemr70880547b3.13.1792153503619; Fri, 16 Oct 2026
 05:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-13-khushit.shah@nutanix.com>
 <45c37754-2244-4336-9aa8-12d0b89840d4@redhat.com>
In-Reply-To: <45c37754-2244-4336-9aa8-12d0b89840d4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 13:24:52 +0100
X-Gm-Features: AclHuK8QUVErp647tqWp5ytpV4Of4NOKFC85jRCyp3SMOobKD0YHSCkB-sEVa48
Message-ID: <CAFEAcA_VksKhAoAFhV-F-DTdFTp02ZHs8cUrpX5qaOCAJTMOng@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/25] target/arm: add arm-v9.0-a-v1 named CPU model
To: eric.auger@redhat.com
Cc: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, cohuck@redhat.com, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com, 
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com, 
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com, 
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com, 
 mark.caveayland@nutanix.com, ping@khushitshah.com, sandesh.patel@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 16 Oct 2026 at 13:07, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Khushit,
>
> On 9/21/26 2:32 PM, Khushit Shah wrote:
> > Add a KVM-only named CPU model for the Armv9.0-A baseline, following
> > DDI0487 revision M.c. The property list is the architecture-mandated
> > ID-register field view.

> > +static const ArmModelPropValue arm_v9_0_a_v1_props[] = {
> > +    /* ID_AA64PFR0_EL1 */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_EL0", NUM, 1), /* only FEAT_AA64EL0 (Armv9.0) */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_EL1", NUM, 1), /* only FEAT_AA64EL1 (Armv9.0) */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_RAS", NUM, 1), /* FEAT_RAS (Armv8.2) */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_DIT", NUM, 1), /* FEAT_DIT (Armv8.4) */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_CSV2", NUM, 1), /* FEAT_CSV2 (Armv8.5) */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_CSV3", NUM, 1), /* FEAT_CSV3 (Armv8.5) */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_FP", NUM, 1), /* FEAT_FP16 */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR0_EL1_AdvSIMD", NUM, 1), /* FEAT_FP16 */
> I have not found that FP+AdvSIMD (ie FEAT_FP16) were mandated by v9.0
> amybe you want this model to implement FP16 but it does not seems
> strictly mandated in v9.0
> so it might be distinguished from other settings that are truly mandated.

FP/AdvSIMD is one of those things that's technically optional (because
you might have some extremely-embedded special purpose device that
doesn't want FP) but in practice is mandatory. (The Arm ARM says
"This option [no FP] is licensed only for implementations targeting
specialized markets". Anything that might be running Linux and KVM
is not that.

> > +
> > +    /* ID_AA64PFR1_EL1 */
> > +    /* KVM zeroes out these field when MTE is not enabled. */
> > +    MODEL_PROP("SYSREG_ID_AA64PFR1_EL1_MTE_frac", NUM, 0),
> useless as default is 0, no?
> > +    MODEL_PROP("SYSREG_ID_AA64PFR1_EL1_BT", NUM, 1), /* FEAT_BTI (Armv8.5) */
>
>
> > +
> > +    /* ID_AA64MMFR0_EL1 */
> > +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran64", NUM, 0xF), /* not mandatory */
> > +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran4", NUM, 0), /* 4K granular support */
> > +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran16_2", NUM, 1), /* not mandatory */
> > +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran64_2", NUM, 1), /* not mandatory */
> > +    MODEL_PROP("SYSREG_ID_AA64MMFR0_EL1_TGran4_2", NUM, 1), /* not mandatory */
> so the top comment, ie.
>
> +/* Arm-v9.0-a mandatory features. */
>
> should really be updated accordingly. None of that is mandated by v9.0
> spec, right?

The comments here are confusing, because what we really want to point
out here is that for these fields the "not implemented" value is not
always "0" (in some cases it's 0b1111 and in some 0b0001). Where we
set some non-0 value that is the "not implemented" value we should
say that.

Also, no particular granule size is mandatory; you just need to support
at least one, and 4K is most popular, but you can have just 16K or
just 64K if you want. So this is making an actual choice.

-- PMM

