Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F33F506CC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fH-0000lv-RV; Mon, 16 Mar 2026 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w27ey-0000ig-21
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:09 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w27ew-0003WS-2N
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:03 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ad46a44easo4272650d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 06:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773666420; cv=none;
 d=google.com; s=arc-20240605;
 b=cknIdyYdgKrYknUmcbHiYc4FTCp/Uu+cqeBL1HXypJJJuQJ+FhViNy+/lYLCUAeFhU
 ArnvJyNJ4IEaETlecwPW4xjfhn7HfO9NrEBhkf5ME3jSuj9mSIcpmF0e+QHoKVXvcNe8
 kOeDfpWDFCVKe1itwdPg9e5hE0ycBQzOLg3v+NbXiUE37lwxoGaNrCSYw1Z8agZmUfiU
 5162Hz+ECoNCWXYs7m59BDKlIONNFiGZ/+5FFetJZx/QxX4wRvHB32ULaPIAhoYPk9bG
 AdzyD0kUFe82g6oteCYd+RjJbHfnUGqb6nUH7O/8TaSU3YfcHLqhDmFmx6H/BEV2qSfs
 dl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yMsomZp6n37JSvHKSmE3PKLqlvI8hkK4PKskYilwpNg=;
 fh=RPNY6OfUikqkdeWdw9bVW8FaPMjmiURiIMAUrJaD8OY=;
 b=hPZNHSkXFVZV8sxUci/FsC5nGcLR82u744aV2OY2D6kJl42mtnLgy8eB4BVg6qyFlu
 HMmihXjYRBFqBWg0+ObIOSgGOngfpsa8jtLRC06+2F2qdyu/NZ9hdpSVKIypN8/YTcd1
 e1wgpibjI29pRYAldC6Cdjv8iByYlhIvK34+Sswuub+q7rlcLGNHej1LwzTMVlhcC5Yw
 gjAr/0UPpmKWT13mnCJ5i2Aeq86uhSoFDwPI3Yqcie7hiNVMyhbYKpKie9Qc4ct+Fxvf
 VQGBvbxUQ/pn9xcPrt5HPw7KvFuDzaHHSZeielthSBa43ZDV4OVwtuqYR5fex8jF1O8K
 kvgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773666420; x=1774271220; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yMsomZp6n37JSvHKSmE3PKLqlvI8hkK4PKskYilwpNg=;
 b=QcYUvHnwwa91BvdZHahi3KPHd3QLNDHZez53nP2EUqt7sy3byDyrqf8hWvK9Foh6hH
 1ave9FfI9OUTE1HsOeBjQL1LY0BSvw4Gx8/gej2Jr3aDH2TG1UCWm+ilAWjlyM8xpoVF
 iR3BRBV78YL7UMpfm1dNKjSv8IunudFdjIb/wwgI0JGblVwK5tWkz1XJGgQZQGzLvtbh
 hSGpepsUwhXFW69kTl8kZ0v8WnID53WWit0I7K/BI4Nixnau7pXFl+EUP19N/s/ESrIE
 8LYoyfOYUEXxbDjkYPhdoF1cHTx2KKWXKnaNokREcHte4+UEPqQWlWWjUCXSofPdXinA
 dntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773666420; x=1774271220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMsomZp6n37JSvHKSmE3PKLqlvI8hkK4PKskYilwpNg=;
 b=mKiecjr9/JpAKPkmoSOV3D5v00370JCA8ICbcTzsQcOxC1Ij/mLXM4JijjNIK5ra35
 BYsNzKDuKFE26Wn68R6ZCd7Q24E535ZMNMQ4KsgWUt6ySuB885XrwImlxe5Estw9Rzab
 cMKfHdjxzXZ61zB72jvmzatfAl2xwzWVMue5XvB1YSWnQUzZL0h13PGsM1iBlG4AAT5e
 PaEq7X7OoyJHESfiKngNcp5WHs3NaM0k1otcHvNb1/TlcRbHtMky3q0I3/wyump0Ce1w
 YPaIfMEyZfLMBF8vV3w+t59MsgH6xzDBVNoOZW9lV8cza8ZOBpf51hhYU+gPEjnfPD5Y
 nxxA==
X-Gm-Message-State: AOJu0YzHQS2sUliIw/C8YGcNBQpECcPh1rEQkMsetOaAH+Ah9eorYfXJ
 i2ZNSGnABSllXwGIcTd1nfeQJL19iakwWqJVL8OuJLuKL3CkwWRsI1uay50r28Gw5cwld4K6xkM
 /33m7KDdgyAH3GlzzELa0EYKMTAvEWUZevkWStnmjtQ==
X-Gm-Gg: ATEYQzxRMF3NcrtVwAnojCs4ofwWF42M4aafAGkCeM8Q2OsvjYurquk9rx39R5gUXoE
 hd4O6+lueBAurxdftmkaf7D6mFpVD0YYY5yvKecAfDFVVrxGGRHRdaxJxi/XijeG0ci+A5VjHoF
 AiEHJqETjzYuDAqf9e2lAmUzxADYIZ0jTITrj+ZaqEQLgtfigAQxxoJtW/Siqd4rXtCmRcG1yws
 6A7JbhFKS+aPykWr0o436ykg4oPzC02qRa4S7iqQfx+lPlFGc9HEGraVhXLfWXDlfEoLv7t5+ae
 /+UBWOmjuvBGTpIdSUcKDBH2d+xU0+w50XXs8TYgRANpX/3zQC3J5n4IneYIEhNIq1w=
X-Received: by 2002:a53:c285:0:b0:64c:9f87:ffc8 with SMTP id
 956f58d0204a3-64e62f6af51mr9623429d50.27.1773666419550; Mon, 16 Mar 2026
 06:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260313183009.34221-1-deller@kernel.org>
In-Reply-To: <20260313183009.34221-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 13:06:47 +0000
X-Gm-Features: AaiRm52hfrVh7J5JAkHvZcBJt3KNspRLRUDK9Fq6dzuBd-NF3pyB9OPetNvKc7g
Message-ID: <CAFEAcA9TshuDuHf-39-hbygmWjjdPprJOXJGUuA-yF1ydwtyKw@mail.gmail.com>
Subject: Re: [PULL 0/2] Linux user for v11 patches
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 13 Mar 2026 at 18:31, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11-pull-request
>
> for you to fetch changes up to 5e5b278d2b1b81fc2b5ca09dba4848f81cd3a718:
>
>   linux-user: fix mremap with old_size=0 for shared mappings (2026-03-12 21:03:48 +0100)
>
> ----------------------------------------------------------------
> Two linux-user patches
>
> Two linux-user patches from Razvan Ghiorghe.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

