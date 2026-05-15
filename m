Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70651CD4F49
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtMw-0006qU-5p; Fri, 15 May 2026 10:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtMc-0006El-No
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:18:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtMa-0006JV-FQ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:18:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso50475955e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854683; cv=none;
 d=google.com; s=arc-20240605;
 b=L46mDC44QDecB9w7pjqQl6xFp5ZpoUmYCXwlKEs08SkzvSTwLAiYinKxm8SmRPk05v
 3x41OOQ7Up4xToPLpK5G3yFTXRT1tR9eUFWlvlAjTwOItrg3QJAN6wjiHzxMX9DpAnim
 9l3EsmJT3/g/+XoaIOlLEBsO+YbTszIof9UOKhikEc29df/MLafRd1JXqbNlMkpDs2Q4
 zuIDHNb0ZOOyGW53xjke5YyAoeMGcERE6OV9ZBnmiVIT5bcqzQyVDcFJ/iOD2zOIwxWq
 ABmKdae1r3KIJtrOlnc3zyCjZTUJSEdKE7/034DW+10qhSLo2XW7spLxAAbp14yjH8xz
 J4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AbQxVi9gMiMY502LQoaVxdBmf73hOT0iFzK3nVKBvZI=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=VXxNw6u1/b3VBQur43TfxR+GLVWyLUOH2s6ITzMYf1rY72RbxkLETkBN9u3y9MOU9B
 zhGxT9B9L0nZxzB3rIgfaJiyZh0G83jTFnwvnVMg7BQyG/yMYrhP8nwnsjlW8tFC904h
 ribemthT6F0wUunh9w7ej2320nxJTJLA7a21LXjAeyRjB/6HPupVfAVmLiFyAKH4Eb/W
 aWBj9Ahb7qOcMKQWCcfgJ7OZMO79eXeLQ+/lQbgA2D51YNki3a3/M5d1D2w3SIrstyGm
 ptU5W03EIvTAw148kjbGchPkossthcAalcxeZt2zlkEEJjBmEw01lffZYTGo442Ugucb
 GHUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854683; x=1779459483; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbQxVi9gMiMY502LQoaVxdBmf73hOT0iFzK3nVKBvZI=;
 b=QkkizBWFMt0gsm0nOjdlZcDFEcSmgofhKJ7nhmbgNIvz4Z1R7MRYF4iOeasNGjPoDF
 4sFn28l2MRehAOOv3A7p9wLRQ5BnZrScDkZzv8qo1EX3xQ8hJFR5GdIFsYAcdre5Ie/R
 S90Oyjv07nrh4xXfB0p3BD6lRokxe31KfReJirS/9h/eSAQA3w80kBNmvNY/hfBrlRGD
 z9jVATMidVvjCBaRXMihVaEw2gf1iHit8sZfG2YGw5tU1EaInt53cBciTDeGcPkP0ZdI
 +wxDw9Dd+QZtjBMroiUcBGzY8ICCeHqjy4HIC3LYH+LQ3ioeek61fzQLOnCWpmZS+wB6
 QurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854683; x=1779459483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AbQxVi9gMiMY502LQoaVxdBmf73hOT0iFzK3nVKBvZI=;
 b=PJMI0BCWBSeebXCqj/xj6TN8Ao/SkcCPvPFhqiJ1Wv4V2i+qR+q6NsD3NdUXEPTeuk
 lKAle6C4Y35a5ottxOIH+bSLlHzAZCWX+sINEwPUNRr+J9bPB+Gk4a2iLY/qTwuhu7N7
 lB1LiXeDF73Fck9QjhQ1K+guxSiyXywec5yufbrYaW24vcr+Tqh8nxMCQG5SXFkRkPgw
 nslU+uJRvoAPKl0SLNp59AkDzgIvXhjTNT+4RRt8OVvbEbZe1FTU1bhy+rd/YpDlLoak
 JWe2NVMZw98XSKfvJk+fuWm0RfXajkmNpjLRS5aVcC2esUlI+EDPewffJKu8Dqm31ahn
 OodQ==
X-Gm-Message-State: AOJu0YyQB6AyAp5CRHPWKpTb2TUi4/67CoY8L8+YWhJhtliH5GxsNlhy
 qvcsYJn28I9y4X9nI8rf5ph7/PmFG7Lz/GgieSUwxDBB9OwExbowjlqeSWpWPDZRcOn98zyK60+
 NRk9yep1t3ZpjUsB4puVXgqAyON+VfVRbj3V9cQMI6g==
X-Gm-Gg: Acq92OEYJ1gI8HETBjMgRGuLvastjU7UW2BoGm5DISUV0tevW0mlEGmNb1suJmpuFxp
 l1QTkR6FPSWH6yC5FtBFihIR3nJ9GqqLjnoTuIifNwyNn7azLykPBXZFUzP0g7WzynecOAx8tb7
 jI1kGRfqR6aTVao7mOhM6ibefNv5TpzN/taEykfNpIS/vsu5e/8r0/l+nLi63+kqjhItC88nH+e
 unT/1pDKAAjRQAjS9PiW0gXxZfv9d1GgXhYGLOvwhIXt+3Jha3XFrkQhM2Uh97YR0ZKaHLziKtj
 ehIV79Xd5Crn+PgUHKob6/1undjE+o0pjFm47Wl+FzfcOKwLpQ==
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48fe60e473bmr55038915e9.2.1778854682658; Fri, 15 May 2026
 07:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-8-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-8-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:17:36 +0300
X-Gm-Features: AVHnY4KkMK36SAgboBSnD4WqtwZyH5W-WW_KxyRic0kTolHb47xqz0jix2AGKHI
Message-ID: <CAAjaMXbfiZUNWE51fSVDVV_f0=QO0bPG=3Te3qNOWkS2XcGxfQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/20] target/arm: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Fri, May 15, 2026 at 5:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Introduce a source set common to system / user.
> No logical change intended.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/meson.build     | 21 +++++++++--------
>  target/arm/tcg/meson.build | 48 ++++++++++++--------------------------
>  2 files changed, 26 insertions(+), 43 deletions(-)
>
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 4723f9f170a..e56fc943bdf 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -1,6 +1,7 @@
>  arm_ss =3D ss.source_set()
>  arm_common_ss =3D ss.source_set()
>  arm_common_system_ss =3D ss.source_set()
> +arm_common_user_system_ss =3D ss.source_set()
>  arm_system_ss =3D ss.source_set()
>  arm_stubs_ss =3D ss.source_set()
>  arm_user_ss =3D ss.source_set()
> @@ -16,6 +17,13 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>  arm_common_ss.add(files(
>    'mmuidx.c',
>  ))
> +arm_common_user_system_ss.add(files(
> +  'cpregs-gcs.c',
> +  'cpregs-pmu.c',
> +  'debug_helper.c',
> +  'helper.c',
> +  'vfp_fpscr.c',
> +))
>
>  arm_common_system_ss.add(files(
>    'arm-qmp-cmds.c',
> @@ -26,11 +34,6 @@ arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('=
hyp_gdbstub.c'))
>  arm_user_ss.add(files('cpu.c'))
>  arm_stubs_ss.add(files('cpu32-stubs.c'))
>  arm_user_ss.add(files(
> -  'cpregs-gcs.c',
> -  'cpregs-pmu.c',
> -  'debug_helper.c',
> -  'helper.c',
> -  'vfp_fpscr.c',
>    'el2-stubs.c',
>    'cpregs-omap-stub.c',
>  ))
> @@ -45,15 +48,10 @@ arm_common_system_ss.add(files(
>    'arch_dump.c',
>    'arm-powerctl.c',
>    'cortex-regs.c',
> -  'cpregs-gcs.c',
>    'cpregs-omap.c',
> -  'cpregs-pmu.c',
>    'cpu-irq.c',
> -  'debug_helper.c',
> -  'helper.c',
>    'machine.c',
>    'ptw.c',
> -  'vfp_fpscr.c',
>  ))
>
>  subdir('hvf')
> @@ -65,6 +63,9 @@ else
>      arm_common_system_ss.add(files('tcg-stubs.c'))
>  endif
>
> +arm_user_ss.add_all(arm_common_user_system_ss)
> +arm_common_system_ss.add_all(arm_common_user_system_ss)
> +
>  target_arch +=3D {'arm': arm_ss}
>  target_system_arch +=3D {'arm': arm_system_ss}
>  target_user_arch +=3D {'arm': arm_user_ss}
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 4fb2c15f7e0..9eeccb2adca 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -52,59 +52,41 @@ arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_t=
rue: files('cpu-v7m.c'))
>  arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>
>  arm_common_ss.add(zlib)
> -
>  arm_common_ss.add(files(
>    'arith_helper.c',
>    'crypto_helper.c',
>  ))
>
> -arm_common_system_ss.add(
> +arm_common_user_system_ss.add(
>    m_nocp_d,
>    mve_d,
>    neon_d,
>    translate32_d,
>    vfp_d,
>    files(
> -  'cpregs-at.c',
>    'debug.c',
> -  'gicv5-cpuif.c',
> -  'hflags.c',
>    'gengvec.c',
> +  'hflags.c',
>    'm_helper.c',
>    'mve_helper.c',
>    'neon_helper.c',
>    'op_helper.c',
> +  'translate.c',
> +  'translate-m-nocp.c',
> +  'translate-mve.c',
> +  'translate-neon.c',
> +  'translate-vfp.c',
> +  'vec_helper.c',
> +  'vfp_helper.c',
> +))
> +
> +arm_common_system_ss.add(files(
> +  'cpregs-at.c',
> +  'gicv5-cpuif.c',
>    'psci.c',
>    'tlb_helper.c',
>    'tlb-insns.c',
> -  'translate.c',
> -  'translate-m-nocp.c',
> -  'translate-mve.c',
> -  'translate-neon.c',
> -  'translate-vfp.c',
> -  'vec_helper.c',
> -  'vfp_helper.c',
>  ))
> -arm_user_ss.add(
> -  m_nocp_d,
> -  mve_d,
> -  neon_d,
> -  translate32_d,
> -  vfp_d,
> -  files(
> -  'debug.c',
> -  'gengvec.c',
> -  'hflags.c',
> -  'm_helper.c',
> -  'mve_helper.c',
> -  'neon_helper.c',
> -  'op_helper.c',
> +arm_user_ss.add(files(
>    'tlb_helper.c',
> -  'translate.c',
> -  'translate-m-nocp.c',
> -  'translate-mve.c',
> -  'translate-neon.c',
> -  'translate-vfp.c',
> -  'vec_helper.c',
> -  'vfp_helper.c',
>  ))
> --
> 2.53.0
>

