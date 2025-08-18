Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DF2CA0EF1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 13:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo02x-0002Jg-CH; Mon, 18 Aug 2025 09:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo02j-0002IY-O5
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:36:58 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo02h-0007FX-LR
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:36:57 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e9455cfb9d1so900317276.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755524210; x=1756129010; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAjH4Iyz3qDt02kIh6J38GNBf4Bwf/iOFclg5e8MRgc=;
 b=QGmmckx8NAXHy7RiZgfY5GPBXgAYrbrTyb1ggwPgTEbVr1CaL7el2ZAtvyi7TthDpw
 GH3e5Y9+PztjU0Yfr7FXkgNV2dyDr7jnNvg/TnuGP24+ua9dcxu725RaJMX9EqBjC/6Y
 85kmvpKlw3jYyN+EC2m9vZKhEZrikaCJ9h2HfwLXYnVnn1I5feUNokNsjYZ3S4h4FdEK
 PUgKxlVeIsLSUuV5NBFbwOLRucW0Pb0F3d3WS7xtRtLdwG+xYVenm/qvV24MZJkGzTQ3
 XVmyFwvz/k7kIm3yUVkR1zTv/utWds6q2uzFQgLyl0up4v3rTMburejAdeEQ/i5Lbyzf
 mQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755524210; x=1756129010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAjH4Iyz3qDt02kIh6J38GNBf4Bwf/iOFclg5e8MRgc=;
 b=tw29tHEI/zqBafxhIHSj55fnmFV+6TwobLI2iRbYjJcSCyST83yb+UfYewKn/LVas6
 UkGMuK6USJiinMj42N7H5co8DxljKWrVbQDLFdMz30bAeODZNrxpDiCDDiVVioCykbjd
 s5j9DVygljU30Zyt/mZ28LJlN9qIqTTBMRvMO9r612txu/BwlrDsevI7Lgbpwx05fBwb
 cGKRQ5aUsIw23P1u7mB2UeGTN3oXyVRBRtM15Az78Tr2gkR2kt3cI3k3SaaM/0Gw6pXy
 NEvORXbUGA6gbtNwODzWx3UP+Q3LseLSecKWsQM1H1DYLaf6kbeqpbTMXmdYRfmZ1Q+p
 M0ng==
X-Gm-Message-State: AOJu0YyoDkCtq0jg/+JPe4MrD3dGiPc/jWfU5jPSKvyHk862ZvIeR73O
 y2hxgRCkhp9gEbP3nbN6M8CAR0miHXBLRbyvaeK24YZGCoV49U+rXKWmhQbZyH7ureo1eqWcJTN
 tbrid/xGBdglT0hCkyzNoHzBp1gM+mNGqv8KJHntUtw==
X-Gm-Gg: ASbGncvqDqP0elBIWVVXv8BjQeS7uiQBboB4TAWmt/8UqA5qgv2krpXNAcdu97v/p86
 xFHSHwiBo1LH3eExqghF8QsYgg5zSAP1njWf5IWMuhVeZUSaXgiPqOSK74pfNYSIUfwbkgpwZ6d
 xiZjkhUdlYA+IWPPpNmd7TV5eg27RSELIHXUBoiZxtZmDpFDfsJiwArQVTtdQ7wR2eqrt9nmmil
 Qcc0A5B
X-Google-Smtp-Source: AGHT+IF2ry/TZ7kdQPnfZWxv40FivnoHgOuYue8o+5V+so99GYxVdIUsq5lk2gmGNm/8Cu7kTga/zHl2qkuCJsqzsI0=
X-Received: by 2002:a05:6902:12cc:b0:e90:526a:ac44 with SMTP id
 3f1490d57ef6-e933200377fmr15205300276.21.1755524209934; Mon, 18 Aug 2025
 06:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-6-richard.henderson@linaro.org>
In-Reply-To: <20250727074202.83141-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Aug 2025 14:36:38 +0100
X-Gm-Features: Ac12FXxSkBbIouVsVUhf8wD7Ph2wZWqpecm627lQ5DcvKWO4rqiRMstXWxSH9P0
Message-ID: <CAFEAcA9gVv1-wwMQO0W5XMn6rTgS-WfeRAQszQ186K6Z_jbaLw@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] target/arm: Implement FEAT_MEC registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 27 Jul 2025 at 08:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> Add all FEAT_MEC registers.  Enable access to the registers via the
> SCTLR2 and TCR2 control bits.  Add the two new cache management
> instructions, which are nops in QEMU because we do not model caches.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Message-ID: <20250711140828.1714666-3-gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Squash 3 patches to add all registers at once.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Phil just mentioned something on IRC which reminded me that there's
a quirk in the FEAT_MEC registers that we need to account for in
our FEAT_NV handling. We wrote a note for ourselves for later about
this in arm_cpreg_traps_in_nv():

     * In particular, note that the released sysreg XML defines that
     * the FEAT_MEC sysregs and instructions do not follow this FEAT_NV
     * trapping rule, so we will need to add an ARM_CP_* flag to indicate
     * "register does not trap on NV" to handle those if/when we implement
     * FEAT_MEC.

(the "rule" being "trap on opc1 =3D=3D 4 or 5"). This corresponds to
the text in the description of the HCR_EL2.NV bit in the Arm ARM
that says it traps:
=E2=80=94 Registers accessed using MRS or MSR with a name ending in _EL2,
  except the following:
   =E2=80=94 SP_EL2.
   =E2=80=94 If FEAT_MEC is implemented, MECID_A0_EL2, MECID_A1_EL2,
     MECID_P0_EL2, MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2, and
     VMECID_P_EL2.

The system insns DC CIDGPAE and DC CIPAE also should not trap
(though the Arm ARM text is more implicit in how it says this
than it is for the registers).

So we need to:
 * define a new ARM_CP_NV2_NO_TRAP ("This sysreg does not got
   trapped to EL2 by HCR_EL2.NV even though its opc1 is in {4, 5}")
 * have arm_cpreg_traps_in_nv() return false if
   ri->type has ARM_CP_NV2_NO_TRAP set (and update the comment)
 * add that to the type for all the sysregs defined by this
   patch that have opc1 =3D=3D 4 or 5

thanks
-- PMM

