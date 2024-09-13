Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF5FA3754
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6RF-0004F2-KW; Fri, 13 Sep 2024 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp6RE-0004EX-7l
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:34:16 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp6RC-00051w-EP
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:34:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c413cf5de5so2720295a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726234453; x=1726839253; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h5Ox6NqJ/3U82v4lizB182BtUMaP2CIdSeplt1kRs/U=;
 b=NfnfAfbWY5B+jvS54xXzje1ogBQbLwD4T6e8Ysr04WSp2FkugNR26ufXcm7S2tJ28J
 rOAzsLLfvdj4P7P9YW0S+DCxuxlqupS41lKT3GDus/Q2iVRqeekho/ZszcpsUJ8RWbsl
 AnrJdKF2SKNOflv4xkmWesNnWZyn0YsmnAH+mznZ5StUJIGiPwRToWDfpqXh98epCL1t
 GGEP0ofPgcNu0drfBbhySqBD2/0dv+aA2l7e1NsgeC7aABhEsgCHOMmb6HNEHjm7M6gI
 9t9NM0XE2cWsj250AIE5UUEaQ/P6Pf4HDf2xBT45aalh2aJMtRANuT+bdjFrCcCF4oVM
 eZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726234453; x=1726839253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h5Ox6NqJ/3U82v4lizB182BtUMaP2CIdSeplt1kRs/U=;
 b=Ql21tunAQRgTAcdqSoUlI8WzD2USIOVFrZ8H7Qja50Ab+kk5HOj2cWkUq//QnOX0Pd
 XIVoW2F7bbryEeDYY5rQ0nQu+6+YU7GJqnSVKWVSMHa+ChQZcBQ7bSCKpM6PNWgLmEcy
 9Q0rODDpd6oia8xPIBAD6zA1iUtOufRKKLDPsPnvgLxgOTF//BzeC/9d2bLVLiU/tZgR
 IMgt7gH0wx7yBFB8XGVqrjcxyt7rBBF5qcrCZ4r+YlpFvFxw2nbwfEg+hkiTGKy7bjGt
 x+X9+TGacCRJCoOHY8rTyoxjRyOZGyvPOqBi51b5opFjEW0x6OWrR3DuiEaYGTZgoRRy
 L1HA==
X-Gm-Message-State: AOJu0YzGSAR/qpSeQvqVuuT7jTfUbx0KiaPUWnKa85kXzVZpZEUhjApi
 3sITiCZGrJ/xwv+sqceljk1OkhccldJ6BR8vxhDdThmuxEb+Liugo08d6lcVB2zXHlCfXs3iDME
 sa2ViHksz/ssj+bTb+rU/M279C3ZN5wWHiGgZ5Wc0VpMUI5gD
X-Google-Smtp-Source: AGHT+IGwq3U4EPXMH4bfmRRu5EuoYj1T0GvbyT00Na6qL2tRk+OE+bj+/PrBfLomoVsESnEriD4h9Xo/iIVuU+A7P2s=
X-Received: by 2002:a05:6402:500c:b0:5c0:bba5:60d2 with SMTP id
 4fb4d7f45d1cf-5c413e2cf48mr5288180a12.21.1726234452604; Fri, 13 Sep 2024
 06:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240912053043.1131626-1-richard.henderson@linaro.org>
In-Reply-To: <20240912053043.1131626-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 14:34:01 +0100
Message-ID: <CAFEAcA9=XthoWyUZBweOn8d_MMFKcKCbFmPnHPbPrbnDNKFjOQ@mail.gmail.com>
Subject: Re: [PULL 0/5] target/sparc patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 12 Sept 2024 at 06:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:
>
>   Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/stsquad/qemu into staging (2024-09-11 13:17:29 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-sparc-20240911
>
> for you to fetch changes up to d2a0c3a7f7740a3d563c8c3ef1fffcc87a36213d:
>
>   target/sparc: Add gen_trap_if_nofpu_fpexception (2024-09-11 19:54:55 -0700)
>
> ----------------------------------------------------------------
> target/sparc: Implement single entry FP Queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

