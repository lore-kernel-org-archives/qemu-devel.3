Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3031BCD5BB8
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 15:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQodf-0007kC-9F; Sat, 23 May 2026 11:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wQodc-0007ja-Ha
 for qemu-devel@nongnu.org; Sat, 23 May 2026 11:51:44 -0400
Received: from mail-07.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wQodX-0005Yi-Qb
 for qemu-devel@nongnu.org; Sat, 23 May 2026 11:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779551488; x=1779810688;
 bh=zqTpfhKA2QEkF4MU3PCDkaOM76zWoG/6Zl/X7vxZmyw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MgLmapNIwZtBafICn8xpcNSp7qigPg6M90NnuSlfcacScToTsJVQe+dQSQCji/0sq
 nOuKrsZB61ljCzEXG3SMnKFS+BbD2NNDB1lEsbPUrI/PiwUgGYAMWfkx2PQ6hlk5nr
 aETZNTD+M6NM3myf8GqbocaDbuvZlxxg4tMZaINWnm8K1N3VD825iBPbB9558Gjoqo
 7gJ7YsidkzAklxk3agSc7Sgte0S5Mj47DrgqdGZ7htVndhWF8PN+zZtdRFRRBbDS0F
 h5gVIPj9SbRFX9DK7Ehr81WCzkyFBdLuQtElGvBs2W0lAlQocsV3N1kLUrs1IMi8U8
 Vkq62ad6eZHrQ==
Date: Sat, 23 May 2026 15:51:21 +0000
To: Richard Henderson <richard.henderson@linaro.org>
From: "Jason L. Wright'" <wrigjl@proton.me>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
Message-ID: <ahHM82Qn7BwxRaVA@Jasons-MacBook-Pro.local>
In-Reply-To: <47c1bfab-8d88-4e61-b374-8c6b101daaaf@linaro.org>
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260519153249.31100-2-wrigjl@proton.me>
 <47c1bfab-8d88-4e61-b374-8c6b101daaaf@linaro.org>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 26f4103653ef58be66dd063f2a795061dea2953a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139; envelope-from=wrigjl@proton.me;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Fri, May 22, 2026 at 04:00:05PM -0700, Richard Henderson wrote:
> I did this myself 9 months ago, but never posted it for some reason.
>=20
> https://gitlab.com/rth7680/qemu/-/commit/2598d4896e19376fbae3926728ac737e=
7bbea190
>=20
> static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo *r=
i,
>                                    bool isread)
> {
>      if (env->cp15.scr_el3 & SCR_TRNDR) {
>          return CP_ACCESS_TRAP_EL3;
>      }
>      /*
>       * Note that FEAT_RNDR_TRAP may be implemented without FEAT_RNDR.
>       * In that case, if the trap is not enabled, the read undefs.
>       */
>      if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
>          return CP_ACCESS_UNDEFINED;
>      }

Should I pull this into my diff and resubmit? It's definitely the
right idea (I didn't think about this possibility).
>=20
>      if (cpu_isar_feature(aa64_rndr, cpu) ||
>          cpu_isar_feature(aa64_rndr_trap, cpu)) {
>          define_arm_cp_regs(cpu, rndr_reginfo);
>      }
>=20
Same with this? (adding the || rndr_trap to what is already there).

--Jason Wright


