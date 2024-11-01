Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ACFE6F06C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ul3-0003FO-7C; Fri, 01 Nov 2024 12:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6ul0-0003Ew-Ol
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:44:18 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uky-0003Fl-W9
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:44:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso2844070a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730479453; x=1731084253; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6prfUdwoVFEFtH4lbhu/TslgfXEs/k/FSjN4uRh+2wQ=;
 b=YSGmntw9a19kcvcP5eDzhELRayGBBkYw5drpbh/kJh0i1txTzcHR8Ud4sbyaYX2wFM
 70auSdUCdPj5DfxdfsGqRg59KE1/Mcmi26/H5rPItDVmaYvwj/Y8Z0GQNXl12x+RBPb3
 dYT7enu8pa+21fHVSz1TTYgdL6TOgdJLQeyHrwrEosdQhElJ7FiMD3Op6xeNOw1VAeJJ
 suf3cETZvPx/TbZJOZhWmQHZVe+VuQtiVjh6MrAm31AWNtXYsKyYOj2LjxOmTncG4RT7
 AplFtB7Rtq25qV0+kwk52gFuoyUSqforCUuTUl8y/JBM8GsLksW2H9gnQie769z+8RFU
 NLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730479453; x=1731084253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6prfUdwoVFEFtH4lbhu/TslgfXEs/k/FSjN4uRh+2wQ=;
 b=L6Czpm5vbt3WzHJs6o5VxQdBBeusGcS4w4Ik04LxWSezmB4HeFWV3H7FgnwaFZX1p3
 eOo1QlvqHfIQGvrCMfN8ssK92YTx/yT/5yV8AaQXeBKnPNo/cBL3XfIYffNvDWDyNy/w
 KstoX7tGGOuVdbVfwJ84g2IlxOCASTNXZsKQoD5eXqRyT2W882ZLvJjwGtzZG8TpyjPb
 HP8tJG85FvkD8gCMu+HxEPedwBDNRkRCUUw//XbCZbveKLdBbG0nVfcPgdhXUkSkV95O
 dhB+iVOT/HQrlGYLF8Ro1ocB7zApOzF5lCSlyUTrJ22lcQ3ImMMIarsk3vn0tbSuJ6+o
 tX8g==
X-Gm-Message-State: AOJu0YxPB/7L4U8aSz6jn66K2QjCNgxczDZQdcL/Ve5sze0brDbJG/3U
 ZLOd6F1Wg8e+4nL1BQkjgaBcLsD1/2h7ZI3NA8wxcFYRlviQf0ouze93G+00m/49EH0/s6uPbxf
 LU7b+CUiFWTTaduQZfeXTHBxuRPd/iyipq7hOYA==
X-Google-Smtp-Source: AGHT+IHerrCp1TNIYVR26M1ToOkrev4OIEfJ3zGq6eO6DbACbjPyzXFSG9xnxjPZOIdavhlE0VBRziyBBtQLHW7SVMo=
X-Received: by 2002:a05:6402:50cc:b0:5cb:7780:f1f6 with SMTP id
 4fb4d7f45d1cf-5cbbf94ebeamr16489330a12.33.1730479453124; Fri, 01 Nov 2024
 09:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241031042130.98450-1-philmd@linaro.org>
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2024 16:44:01 +0000
Message-ID: <CAFEAcA9iGx7haujfFsmiZLtVH0SCgcVFbt90BYB-dWQgHnkGZg@mail.gmail.com>
Subject: Re: [PULL 00/14] MIPS patches for 2024-10-31
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 31 Oct 2024 at 04:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f=
29:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into s=
taging (2024-10-29 14:00:43 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/mips-20241031
>
> for you to fetch changes up to dcc3c68c844fef7bc018ab53f0993b8d44137d77:
>
>   target/mips: Remove unused CPUMIPSState::current_fpu field (2024-10-31 =
00:48:45 -0300)
>
> ----------------------------------------------------------------
> MIPS patches queue
>
> - Migrate missing CP0 TLB MemoryMapID register (Yongbok)
> - Enable MSA ASE for mips32r6-generic (Aleksandar)
> - Convert Loongson LEXT opcodes to decodetree (Phil)
> - Introduce ase_3d_available and disas_mt_available helpers (Phil)
>
> ----------------------------------------------------------------

Hi; it looks like this breaks the foolong2e functional test:

https://gitlab.com/qemu-project/qemu/-/jobs/8249048723

12/15 qemu:func-thorough+func-mips64el-thorough+thorough /
func-mips64el-mips64el_fuloong2e ERROR 2.54s

Guest kernel panics rather than booting.

thanks
-- PMM

