Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E63410F92E9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dSi-0001L0-8O; Tue, 31 Mar 2026 14:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7dSg-0001D2-BQ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:05:10 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7dSc-0002yW-4P
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:05:08 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-66ba9dfe83bso4496962a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 11:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774980301; cv=none;
 d=google.com; s=arc-20240605;
 b=LlMap4CQS/uypClhP1+c2quKks71Fj/C2oFOyl7i9lkAR1C+YP9FlRUyhP4kOyDMh4
 zcH63C+3/Ko65ixtUgB/Z4216yYb6RGiCLu3kdeQh/Z6Kt3u6gPWI8u5kEO4Ua2UGUc5
 nrqBM+3enH8hcZCzqbLoLBbkcjnAGYFSKpA09adQlOPaVsR7BjBTRqMb7qiA02GhP7Zf
 ixQ9VkJkt2qnDk02TnQtaV4sJmmka/34fKvX83ee+zQn1ntXUpby5tGw6s3+8731ruXU
 iCyMTAmlrNW0g9VqzmwMp9XEFcG1I/XZx1qjdlBfYsM58uML8qD8IlXHYKCXwDuQ+FZf
 Lg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V8plN5LZT0s/nEZoBnXrJg+KBlMml1yvJx8S9l40jhs=;
 fh=Ex4Y9D13TzP9Un/NlXA3fHszubsOTjRrzsGdwZWGnvQ=;
 b=WxJaLMT0gxPD8hmPfFMl1GSNXfbaxkXkN30x09z0ESe/JbmvWjdIyA51fJBlcyyJlO
 BcMSX/MTCEyrQkBiy2Hd/ZoG76If1kiwnqX4KiB0EZdgBiNGMpUTjb1gQ/CUpAVQ7lP2
 QLHSiBK2JooPjlWF9V4SmS121beUDx0+xqEB2KC9bvptAYSMphJoWq2xYIVDOW4c9Eak
 DM5IwsRA3wydBnefbCelsPeD+fd2Q5JIKGkZ1Syd2k8eDLemHznb/MQJUozVJWYuL9zt
 eEInYdB7SUJWTJAKswdyuldJR57YYr9YNKqvAsnRl1wC+CnwcyYos4gWnQNusKbome+N
 NhgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774980301; x=1775585101; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V8plN5LZT0s/nEZoBnXrJg+KBlMml1yvJx8S9l40jhs=;
 b=L6ncPXnkcL2kk1lKFWC8v5LoiDITOslVAP9pmQfU3wpBzwmpvYRwKQX0l+ph1Udq5x
 p1axDyocTgwLPO9CXzeZ7HxL6JFzxl+IUVE21P3418JDYev4wSRdgda4kyrUJhO6m2Jl
 WGN78SuAgkoxnnGcRmtqNokxOvc7+9YgYh5AszFthJKvfI9WQsWxSSc8D6Osg/zpqb5S
 p7W+GFca0edXW0LmOgKC9oQCEm5HKEbSYa1RVJgOK+hRaWO1zYGGoBMRB7yvsBfiFyrx
 hDbGt4pCuFc1xWAvgy/gGNBPorMufJ9C2HCo82F7a/j2tckNe0UtxJbMvSXQQY8Lg1l3
 PEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980301; x=1775585101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8plN5LZT0s/nEZoBnXrJg+KBlMml1yvJx8S9l40jhs=;
 b=l80tptYQ6fv8/iPKIGq2UnFPoKJeUNrVTPRQFDAVueZBwNzDnv9e9OSp5Zdq4ZYK7D
 no+XG3Q0KgG2hO7sYR0PJgGIiOZ9pEwbAQZ7bdVCgy1lVl6Pnh3rZVv5vqCjaJwbEGJP
 YHPcZ+IzxfqIuyOuJryfovSE6C+i77BIUIT2q9SilxSS6+NfGnmwzGP1PO5FP6Vj1GV6
 BX48tndjHJnHsdfZGdUBkJdTLeCP2k+Q8/FMoTCfT4BNrErvKir5QXFge+na975nuoeD
 mXS+C6/o1QZ8UkVh0qzj+AFMSc/hkN4Jjj4+KdOFPxkSTqLVCRVAEObvXSp2bUzFieG8
 MnQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWolzDA3PDlpG8u8RvTRJhmoixTDn8tj8Urf0uSsyeObRL7j+qN4i3VNKyLmisoMya4jhQ0P64FwAnD@nongnu.org
X-Gm-Message-State: AOJu0YwJLhr/bxOEi/ewDDbFCd8eZxxFabB5nSg1KmD/kMRMxANRCUcD
 bp5ztbajulinTxnph6ICG3wcgMEH8MubmLFvzMNLMagivvFFHNMMuui7zyf0lZcuzJFBc9hTOk+
 Ab0HOH7PRcEv091hwdnEE9IPCwQkIGmTlCMO99h2ttg==
X-Gm-Gg: ATEYQzye31I/WTdd/LuFoVB/Tw/UqrJSOgZV18/brlR6sVbsZxvEyL6GYtN6gBqINLm
 Jw2cCriShHx5SE+SG+egt2k9Ema8CX0k88yo+Z/e+utVOuBG2UQC/WcPn1o24IdUUfadGB1GH0/
 Qm4CV/wolBuJsmliNeU7FqqACGWOojjI1HYwpdLO5/tNTr7MQ3OKcXJyRqwrJ8SKcO4emViigKs
 HLLV3nhnnJaYEnwionTOWlv33BMfbAFnZOv72tqo3+1iM2T9fUt+8cUis9ln5K/wn6bFuEUG1tX
 66UTDPmxITeW96j0esp/k2oLlFXcolOPPpkmtgxmH3fcH/x5IvL2JgmO40SJzV0qDUs=
X-Received: by 2002:a05:6402:350f:b0:66c:359b:646d with SMTP id
 4fb4d7f45d1cf-66dafeb8342mr339979a12.6.1774980301065; Tue, 31 Mar 2026
 11:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260331150352.256332-1-kwolf@redhat.com>
In-Reply-To: <20260331150352.256332-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 19:04:46 +0100
X-Gm-Features: AQROBzBfgpXKopcR6wHP-oFJoU3G-AIudZAzfo4qdkj-23N0zYDSZtA9piugyH0
Message-ID: <CAFEAcA96LU2GW3MVmqbuONiwwGiho5D6Cx9OtPvtRANPwjfwQQ@mail.gmail.com>
Subject: Re: [PULL 0/6] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 31 Mar 2026 at 16:04, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 49ea0100202fe448be1d0f3ea5384cd51b5e6a58:
>
>   Merge tag 'migration-20260330-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-03-31 09:39:52 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kmwolf/qemu.git tags/for-upstream
>
> for you to fetch changes up to a55402d5c3a8c63c801de86896f86c9abeda0ca8:
>
>   block: Fix crash after setting latency historygram with single bin (2026-03-31 15:47:52 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - ide: Fix potential assertion failure on VM stop for PIO read error
> - scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
> - vhost-user-blk-server: fix opt_io_size=1 causing severe Windows I/O degradation
> - monitor: Fix deadlock in monitor_cleanup
> - Fix filename references in comments
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

