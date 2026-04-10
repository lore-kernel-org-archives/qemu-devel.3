Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C94BF44846
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBAVt-0003rH-TR; Fri, 10 Apr 2026 07:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAVr-0003oZ-Ok
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:59:03 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAVq-00049E-Db
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:59:03 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65009bfdcfdso2182136d50.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775822341; cv=none;
 d=google.com; s=arc-20240605;
 b=VAJlK/wpA6Oo4Z1lpDif++ZDR+WwuD2dVgufouAwqtWM2GV/6199pWEsZkawkEGV1W
 rKNRflTh6QWlSTSEiY1DhAp2W4aGXtfteA8TLz3aFeh6Y7R6zHMfqOkVzMtJfkDzWp7B
 wW52kuIk/R36mWUFNtFRuPYT+f5GM5o9c1/Rb8en0XaVxg5v0sVzosnsUGEw5TDPr2oo
 WEabjC4bIL+kiczaJ4jgC+R9DFoul2E0xVWW9qFlO8846x34uglKA8HQojsqQ3oneKll
 vSapFEEM1sfSHbAe1KjACP9ZGCrjholEXtrHGxBGMXYawE5z/K3yHlV+WRJuWn8XPlun
 qbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Uq66mCbcqASreJ6ptwxhmLSaNhojTvxyaCd+23Rfjw8=;
 fh=amMF70sjUkCcXnSBEU+jRz59fNRSlOvQModqxkkIMLU=;
 b=KGIT0eSy0/Kl7yNL7YgJZu0n58SO7ay9GflUTqAPLHf/2cgNm3jZgnXuNejgymZa2C
 akhapudxv/WxRy8EoD6BwdooZ6dE8jple+JtUHlkDPO7e/KiE4B5rxSLr2S6+GBbSejO
 W+bmTORTew7/lCDCKxb++rt3rOde01S9BoUsgwW4A6NeAAaTJRIckv0V6PdETO84rAou
 9/SBdCQY28lUsNFBEXKyW/wk7s/RwONQiatl6rNZXjDhsrLk6TXR4CbPfRk5UQ/InyKu
 gl19BYdMn/Kj8VdQat30b4buILH4yqknWUMb+lQVK+J1qzO05ZCgw5GaxzOR93RWvHNs
 RBBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775822341; x=1776427141; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uq66mCbcqASreJ6ptwxhmLSaNhojTvxyaCd+23Rfjw8=;
 b=EplyAS7/BPoeEETQEL0j6+XEk0d+FGJhlGAep7Q/nEpee/yidp0kSiTHACw2D3uIc3
 63ASi6VyWOBizwyu0/j38eTR3VhCowRxLyGEQLpd/KjiL0xW0SqTv56WXZxG7G++XNUW
 VLDPHniJS45Ci+0a+YKojOLWYTDAvbO4PpsVnWvLcRi03z28dVofxRSLdMMK4eixyQtl
 UQbgmqkUnpzBT9dz0g/WIxPPEEfXKQwoxjNIXxU+k8kpV9OAq6EtFi5B1v75Xe4qNkbr
 MLznJmIGJnWYkhEnW21OBO5CMugQAUdI9gIGTFD2QChfWSR7ZDruZrxzTsd4hOuo6Nhe
 Sfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775822341; x=1776427141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uq66mCbcqASreJ6ptwxhmLSaNhojTvxyaCd+23Rfjw8=;
 b=Mzw2NVrCcDSHcPy0nzb0s9jEVhCq/PhS1TpOJWZqDziuGszL08jmuZhrjFbn4EV4Hp
 zMwePaEDCMlES8ypI6nS7Kho9hgFQ8mzsLMqGjNR7pGL/uq9+4pjs+V2HnuUgSLU1upz
 ZDUz5mmd43Q9WEDsrBhDaDzwgb34Jtj8YpqIOvYfGZksIQ2i8gIz8ag38VvtYyI9peQV
 8fJcAnn0JlrAbGq/1AzGeHem6ZHL0jJNhZxpdTs3/p+ICA79d2/ZBaf0LADMcGwTQ0WL
 p2UPGCFao20MzOK7gn2Ee6ljAS0Er8aEPpn2nJMcVJDXt7v+w0Gvz+x8bsKwjdkl7/FB
 R84w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW08Ru4K7JIwBzXKjYdhwSayUEjchZPRLciHgT/WN23wIphGVkD50eGLqwdIJbCrNk58VaZ2t2SxYPO@nongnu.org
X-Gm-Message-State: AOJu0YzP+QSqHLnoN/vC2o8AVBvz86oh+0doEeGGE16iV1DZJHBMK2ha
 RPH1yC9riqQfHrtneQTrUH8cQQLtXVGkxZse/1PKQeG48SUWkfh1h89uf+PPlvWAZokDcDkImAc
 ZXknaP5Y1HxSHitcRhk/QGog3UgZkhSs5lYea2G5LSg==
X-Gm-Gg: AeBDietoTEs0IJa01qYKlY4B7vvxgeS6BeFXyS7WHO+IVd5A9WljZ9WNnUstoX04nQ9
 94NnftX+gupnWaOIj30mCrMwYfodedS/r0Bu0XmZj+yJ3Ji9DIsaw+NX9eSz5t83pSysymaBZZq
 akZ0IHvuV80RLfMjypy21f+i8QTC1xvulBkHSdj460yFzxe5hTBRl0UtQGmE3Fqq2u0Typ/SHo0
 VAiHsazxeNSW5BWN6mrzMWUeh+J4X+OunYQGRzRmCq6Dr/c2YkNFOZgcE0MB3KKzK8Gyq69QHea
 aqUWjBTm1nkQhlGuESHetozboki9Ig86NQEFRs2ODOHJGL5JrZ6T2XxidFjEI2pBVvY=
X-Received: by 2002:a05:690e:4393:b0:64e:e47b:2476 with SMTP id
 956f58d0204a3-65198bcf642mr1703703d50.43.1775822341334; Fri, 10 Apr 2026
 04:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-6-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 12:58:49 +0100
X-Gm-Features: AQROBzCe68DrKNa960VUelWx6OeNeQ_U0UpAv8Ph1hRmXTGHd4HpysiP_1n9EzA
Message-ID: <CAFEAcA80Lb0ZskKwLxSL1tKSLT=D=CpSek7ghQnypkHmQcyZ3A@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] target/arm/helper: Define cpreg migration
 tolerance for DGBDTR_EL0
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> We want to remove AArch32 DBGDTRTX which was erroneously exposed.
> This was attempted by 655659a74a36b ("target/arm: Correct encoding
> of Debug Communications Channel registers") but it was discovered
> that the removal of this debug register broke forward migration on
> TCG. Now we have the cpreg migration tolerance infrastructure, we
> can declare one for the DBGDTRTX. This allow to revert the reinstate
> patch.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7389f2988c4..3cba62705dc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6426,9 +6426,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              .fgt = FGT_CLIDR_EL1,
>              .resetvalue = GET_IDREG(isar, CLIDR)
>          };
> +        uint64_t dbgtr_el0_kvmidx =
> +            cpreg_to_kvm_id(ENCODE_CP_REG(14, 0, 1, 0, 5, 3, 0));
> +
>          define_one_arm_cp_reg(cpu, &clidr);
>          define_arm_cp_regs(cpu, v7_cp_reginfo);
>          define_debug_regs(cpu);
> +        arm_register_cpreg_mig_tolerance(cpu, dbgtr_el0_kvmidx,
> +                                         0, 0, ToleranceNotOnBothEnds);


This needs a comment to explain why we're doing it.

thanks
-- PMM

