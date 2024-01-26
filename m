Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A75DC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNoM-0002Wb-9M; Fri, 26 Jan 2024 10:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNoK-0002VM-V7
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:08:04 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNoE-0000eV-48
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:08:04 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55d0031d8b5so280753a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706281676; x=1706886476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rHN7zTO72tlVr/WUg35DcsHaqHe4oMaJWPRu0beJ6+o=;
 b=snjaGCn4y1CKA7LaWU4qfER7ZwdEj2D70E6JyyW+VEpaEjBlLDvnNqBKsCssSR7dYi
 /1U5xZPgJpHUu5/v5YlL2JwIamqhk7t703aVzgApbblm4xltCQUIrJU1V5JPRFO4NLm8
 6s+UjAAjbt8dNIIKj7g1xgkJxCUmMYQjW++hRlZhuWQPBWLe/WBjpbVZG4qHCxPVdBJn
 1ys4rBycqnemZKwIPHaTEgjMTGVjlXdD3nrBHu9b5GuY5vu0qc17qU+3rsM3asFoBXLh
 FUx6fWnrrd1Bznjw8ZCG06kMMwrLr01t1244Foq9xfuBj/WSIDn92n4uPhDLX8Puf8vG
 gALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706281676; x=1706886476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rHN7zTO72tlVr/WUg35DcsHaqHe4oMaJWPRu0beJ6+o=;
 b=PYbMkJbVcxS4dQZgwdNarx+zIQENCp8G3rGkx9HDbPZxWOWGDnEGdOiOyYECZXp8L3
 UUl1sJpJELr5EiBTTvxhmBCnbGzvZZgW/2lPgAwm6gYtqaBaCiO03WiVSvpnyA05byRI
 Jgz898aM7sYYoMWYgbRRGVugWxF3DXk1/dVxMWb94Kip207uCQ3Si14DJXcuqUHo0ihD
 ZshhOJ6BEty8ccC6Yfd5fumPusQlRGIzFg+iA9QD4fCBKDmof08ags/4O1JhNx3UXURP
 0DJQv3Y/nAmvafUcV1m5zVMOVGEpFMQomhikeSHngkpW4Ji3/KwVeLbm42jErDoDBhMM
 lf9w==
X-Gm-Message-State: AOJu0YxN2g7EbggqmUCTXX2ROUhJhLnN+sio9PpeGMhyc5rDNQkcsZRU
 2K9IOX54Xm8WJ1xdjTFIOT51HewL8uvjdO4VMWc57g142onkGDVgU6IIf46EjZ+W7HiivLDDxGr
 SG/yKwcVuvAnhkaMMah5Jpgrn1KerCxd89sVjGw==
X-Google-Smtp-Source: AGHT+IG7FlN+lQZluOWONe0m1h9x5pIn6d16BXI0B/cVluvH4UWpqq63tGr29xp61A1NIVNC7sdBz1m7j6chTSQf26M=
X-Received: by 2002:a05:6402:1bcd:b0:55c:79da:f927 with SMTP id
 ch13-20020a0564021bcd00b0055c79daf927mr926903edb.16.1706281676477; Fri, 26
 Jan 2024 07:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20240126122717.221575-1-kwolf@redhat.com>
In-Reply-To: <20240126122717.221575-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 15:07:45 +0000
Message-ID: <CAFEAcA-AGv5R=ht0hfFdZRJpcapACo0=Pm7eK=O-SguVrsSXSA@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 26 Jan 2024 at 12:28, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:
>
>   Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to acf2b9fce9f402b070a65bea584582df0378da9e:
>
>   iotests/277: Use iotests.sock_dir for socket creation (2024-01-26 12:27:41 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - virtio-blk: Multiqueue fixes and cleanups
> - blklogwrites: Fixes for write_zeroes and superblock update races
> - commit/stream: Allow users to request only format driver names in
>   backing file format
> - monitor: only run coroutine commands in qemu_aio_context
> - Some iotest fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

