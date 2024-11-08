Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08345D5C0D3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QGC-0003yi-Cn; Fri, 08 Nov 2024 09:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9QGA-0003y6-3o
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:46:50 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9QG8-0005D7-Lf
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:46:49 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ceb75f9631so2756694a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731077207; x=1731682007; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5NFuzJpnZp01M31MV7pxlj1GxcMZSbkV82l/yoo64nM=;
 b=tP2FcGEuAGzavHLak4EeTP8sW9kZlg6zGV4KODpGO2v2EGcoi0+h7fcEzVEmBFqiOZ
 QGMIcN/bTY0/Ir07Gtpk9G7YJDRtcck712qMlvCuRe5hMbm7rGxl3wLY8v754AiaxyD5
 vIlQMD3DvbPrb5CJnlOwUtEptHJ+6iJksIVzml5tlCyV7N6roow9XTntuSjzFGMw7I9E
 V7xMccQsgO5RAN6tp8rnPEcliVaPG4NQJH2LeVLyLR5ymf18XdpsKNmw0Z8LYGHBnsm5
 d343+SuvE6mGehEkRM1EIab6ZMSndsWPtVvq3S1dv1em5RfdULNlM5Ua17m+yJe6SWiE
 vxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731077207; x=1731682007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NFuzJpnZp01M31MV7pxlj1GxcMZSbkV82l/yoo64nM=;
 b=uD2bauDltzbff8eXCGeafqD/Nv0pTRIuYlXOZQyK+VKh5BtHEeAnCWLgtajBk5aloq
 yTG8T8vD7OQDStFZ+Nweag8pA+mvRCdEJWXO/bsX4nkrJffTyO8591KEH21D2NPImVpE
 EFgpaPGz5VyJ1Gq8PorAUIq3Km5qYTA/6xOsTo6r3dMi08tdZyP7DiUgPTCwRJzY/IzF
 GwvMzCA5RFNAe46YJ4pwEJUNJGK+fYidYayywowcjhqP435c/Ao0nN2kmAw8shwMW16W
 jPZFJzEUoOcwsNU2C7xiHIg6EQKFs1ato1go/hgLwpiQmS1TY4WLv/xa1RR0m4uKRPy0
 iPdg==
X-Gm-Message-State: AOJu0Ywu4YpL6Dsu56RpXUqkLLOPsXwuuFSCw/1RLbfWdSjg703tkJf1
 o0WKAWbekZQWB0u6ijgC8TB6AVALWRVmPo3jZIQbcdLuyCrUXU39qDwupe/IS1PHkELsgeUzkdw
 JxA812sLdW9YnLxF6FIogpxxoZmQbjdGK0B5ZtQ==
X-Google-Smtp-Source: AGHT+IFlCN70qhFANVGwHaExbjUszjBVMwdLncdL1Y8WSpZqT6fzGbJCTaiDe3DiBjD5SwOZjppssEINIuZp8GE/gTU=
X-Received: by 2002:a05:6402:268e:b0:5c9:76b6:d14e with SMTP id
 4fb4d7f45d1cf-5cf0a31f545mr2645345a12.16.1731077206930; Fri, 08 Nov 2024
 06:46:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731059803.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1731059803.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 14:46:36 +0000
Message-ID: <CAFEAcA9Y1FzxUCOafdUBs1BRoJ5wxXRTb+wacP8VGsqo9008Jg@mail.gmail.com>
Subject: Re: [PULL for-9.2 0/1] 9p queue 2024-11-08
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Akihiro Suda <suda.kyoto@gmail.com>, jan.dubois@suse.com,
 anders.f.bjorklund@gmail.com, 
 Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 8 Nov 2024 at 10:05, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit feef1866d1366d651e6a3cb8c9cf1a9aabb81395:
>
>   Merge tag 'pull-riscv-to-apply-20241107' of https://github.com/alistair23/qemu into staging (2024-11-07 15:08:05 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20241108
>
> for you to fetch changes up to 042b4ebfd2298ae01553844124f27d651cdb1071:
>
>   9pfs: fix crash on 'Treaddir' request (2024-11-08 10:38:12 +0100)
>
> ----------------------------------------------------------------
> * Fix crash with a bad 9p client.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

