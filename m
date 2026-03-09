Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE7CF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyq-0008QU-UI; Mon, 09 Mar 2026 10:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbyp-0008D5-74
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:53:11 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzbyn-0005uv-IH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:53:10 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso14475396d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067988; cv=none;
 d=google.com; s=arc-20240605;
 b=KsZp9oY5s7isvMJdruw35dmgIbN9JytrWkfZEW50pe6s1REZXEwTwLl9zBWg3RQ8Ly
 rFyteR1RHXVkAlaJh3xDx+lk4OSei6yszNITHv0XdGIYTItHH1ZVs+PrelUe3118Jkr5
 6WoAH01c3pT1oPZFXal8D2/o+FOWvAduwAlPa3AAK8yHs6kH/ZuSWVCRDnAk3++Z6ckP
 1xy4G/AY2oy1OlPwFxtv5R+x20xNsnQb3DxaK/DswdMnhgZIcw/LJ6FuYCL9UidCvEfo
 bROrQPe7f4y7qkOcahIuPRcG2l9a3YOFKQjWN1Tga+TUr4oWx+jgDmBp7rBkOYiYhMtb
 3W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lmlr5xwlzExeVLyiIX4eKEZ6XfFdWyLdssC3qJF98xs=;
 fh=6mXm2x7XU3vkaqkwJdrMVgOFjOs5JYw8sBWPsuaLgiU=;
 b=Fenrhp9su/6Rb7LHhbyelwGVSDifwRpdX6zS7zNP92QMaCLK9b2sHYx5n4wezTsZBk
 ksKI+Tf7Wm8TjOQX6xRRgNgCS0HhoUpQlnmZLoIR9kB8mDZlcSV4anTr0tNvgU13hscn
 kJsf/ayyxAG5YEpjtttRbKsSrYy7zt1hs2cUAJq0k1nyx9DmWWQxmVQL0AxX3N+nKhf4
 0+foXUr/BT9eBZ9QvxoHLwK9Lb7lySpynp0uFn2s5k57RO/odI44R2JIM1C8PYCeF4iR
 2OWBLgOmZSbVZ13NMqjmdIZ6z64QPvs0vonJST3MPLJOIZsQQlsOgrF7EbtBDzU2Z2Jg
 0cgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067988; x=1773672788; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lmlr5xwlzExeVLyiIX4eKEZ6XfFdWyLdssC3qJF98xs=;
 b=FETEH71L3VqN0wqche1F9/rG1WJX076YvhFDpa1qZWomQeF2Ip0Rb4vnyOQ4DL7sii
 5YYdo7vxQcxrxEP+5QQYkXj00qGIOftm9ZTKWz5bLAenMrMEddu0f6BIhX8WlNb/VDmC
 /PMa+axFjYoHHo8DXnPFpJEEnwsMiJHYDBc/lxKTmJ22qhsDfSZGDUn86fueXe3Zn3ZV
 X1VBU3RY1axSMgHU2uCYuK8BzCH5zCXmC0/HEitwuZSwXYduylME7/Uqnmchwgu7hY45
 rDwpJnXnpHIJLl7KrkYfSpu5MZ+FDWbUAJ3AsmqfYS3OTDpeuYSE+Y1k2U4t+A1hkVIP
 5GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067988; x=1773672788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lmlr5xwlzExeVLyiIX4eKEZ6XfFdWyLdssC3qJF98xs=;
 b=i2ZxvgIS5Obe0gea5VKUboBWBZSIqo/psv65kHe/ZLAby4RIOFTIwPfqNKGRDhUrx6
 KitoaEaecv1KHAeW/aGNIgC30E7/wFOUpyuIQQNs8dfeFInW1deJfd8FdCN2gwWGUj+O
 oqqr67BUcFX94eubPL61aWSL/bgLjymTvSF14I3QMa/XsZ39Fr9YKitTkmyFUlMgB9np
 hbyBn9gZDSmYWR+6A/MXI/zaXeqYBJEKTpB26TgeFtWzlNoiM3Psd1UgVEkVSIjvZ6ua
 LTiNO5ju0dGBqrkuMsf7uhPydVy3qeV2IJGYZ9NwUowChB0ydVoLeRqY/QZ1u74SQtiT
 nfoA==
X-Gm-Message-State: AOJu0Yw/6E0NOhRgoovGXvU0E3Amqqz8cHTeZjAyeSKlBOeuMYUv+Gks
 ULYkMEgg6SnjM/yBIc9zhcDOAPoLOycwCY4OzhZbCVJQz7S7kmc4JHRCO+wn0dZMTWvBFAuWdfu
 CDGopZCLYMq94pem/1ng6qkIz24bdqEmp0IzOBt/yvw==
X-Gm-Gg: ATEYQzxaQg9bHtQ1oAGnaMBUDPzD0TS7fADGjxiwhSG81NuKWrdFT/S5uB3SZIRETHz
 HjhpJ2PqzUSfUX9XuOrmVFU5yufr2SoLsizdrWLPY8O+YKOPSLrTbn/+VrlixBTAgVouakz4PAb
 3Bc3k4prrE9PzSDLtNZMBvvbN7nfoviSDVZdrmALLPtbL/E8PvNo9BG9GEM3AeTiVMygkbAi/ps
 GJ/IK0ep8sfb95FFEXhU1aDdvIjPylmxvH9gKPMRKr5ghSKuR19/Hzac/Ies7APC3d2YgjIp4rQ
 s1N6EDuIzV0ZL66bNDDfvTV9m9HdNVUYv3Wi9YOgVJ80hRKkBDrPWw10DRAVpHe1qCU=
X-Received: by 2002:a05:690e:444d:b0:64a:bde9:3423 with SMTP id
 956f58d0204a3-64d15477513mr6647221d50.9.1773067988458; Mon, 09 Mar 2026
 07:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260309064436.51860-1-edgar.iglesias@gmail.com>
In-Reply-To: <20260309064436.51860-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 14:52:56 +0000
X-Gm-Features: AaiRm52x_MZSsoQWEpX_SVubQ81MNXoACRIsTZMqUhmaBur07rlXpMyBFnbdJgk
Message-ID: <CAFEAcA90Xmi0iFXQj1Z7FaNJ+cqHNHL8sQ8yi6Yo2avKwRXY4w@mail.gmail.com>
Subject: Re: [PULL v1 0/5] xen: pvh: Add machine option to disable the mapcache
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 9 Mar 2026 at 06:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
>   Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/edgars-xen-queue-2026-02-09
>
> for you to fetch changes up to 83d1d9a49e8eb970f87508ae4ce0f222084df365:
>
>   hw/xen: xenpvh: Add prop to enable/disable the mapcache (2026-03-09 03:24:02 +0100)
>
> ----------------------------------------------------------------
> Edgars Xen queue
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

