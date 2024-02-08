Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D51C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6xD-0005mD-4V; Thu, 08 Feb 2024 11:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY6xA-0005m1-Qk
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:08:44 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY6wv-000190-80
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:08:44 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5610c233b95so34051a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707408508; x=1708013308; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zw3K+kF1g1xtnX3vQzL/uf/MsfjKpDBd/xEq0WYhB6U=;
 b=pYl4zH/N2K562mJpopCN3NmpBT42YBBrQ4AFBmVQiOGEHOJIDDpMg6RH/IOLEpkmwX
 cw4i9raNccprFYV9+aSMzOFGbKbYti7VcF90zXdEVBnJLP/nByT00F6C0Z7vdGq231LX
 R43sWfC0yzoS6/mvi2NpweT4tOxGGIhRP8JiYUHatm/CN/tvhuA9Jdcm6SOXvh7yw/co
 jc1GPQ6W57PLclDkMz61AXYD4nIwFSUpXbxx1v64/qbtEURIcXKAHyhmtin8+e+doOqT
 evnUGp+1ifeXYouq9fqWJ1azQbfuveLhZBw7oUHJ2SrnaQNdzf7xCYkkDrjW0rUCSmBh
 ZbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707408508; x=1708013308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zw3K+kF1g1xtnX3vQzL/uf/MsfjKpDBd/xEq0WYhB6U=;
 b=EBB6lSBOV0l5jzIOb+7j3jIn+7+tgZTkWii9D2jnSMfzCOMPn9nQ/X3d3ctpHRsAb8
 Hhlu3vsscXB+sr/eGgfLTT/ocuYVyo5ZwgEgFHjRSLInHbhN3fHQTVma+AgMZq7CTlkw
 Jm5p1J0tjN7IeqqnKrIGBxdXB1w7iyibIHy0DMHktsj/Ym5pzB8Uz1lRlocv8xLJBzww
 lcoVKEatHoNMfUZy7VbGE+8Xqv3fZCDO1JIJnHD5ujsrfol7isz+rDewAAJZs1DF4nzs
 EsVYnG0xC/6XCRdNyzoutyEXLa914xxzJFzIzl8+Hu78GBhbV6PvUBEpXwMVtA5JJFra
 9raQ==
X-Gm-Message-State: AOJu0YwJohuInkrU9hP9bfodTJJLD0z18jfZSUGWoazztDrLKD7yqfBb
 JS6f/Biu7Don4lER2uMTf5Qhz8nIch7qgs8UMO3Ccom6+plQnqDi90HKaqRNtFCT2rugqtvlyvV
 FVS3zrSalH5duyt3iSzuZpVooWvhNlpt3iqtD/Y5G/BgmK1Xs
X-Google-Smtp-Source: AGHT+IFNnZWTXgrSKDSJ/BBVq5eNVuVyynYMbpK5YqSzdYcs5+/WyTFXxeYywGAJ+3wYTYzPeZTN8oejivnlu5eJW1k=
X-Received: by 2002:aa7:cf06:0:b0:560:4e6:c6d8 with SMTP id
 a6-20020aa7cf06000000b0056004e6c6d8mr6984463edy.19.1707408507831; Thu, 08 Feb
 2024 08:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20240206072225.21187-1-david@redhat.com>
In-Reply-To: <20240206072225.21187-1-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:08:17 +0000
Message-ID: <CAFEAcA9e7SeSmphp8EBq7eXJ7YVzVzufSRDu1OVBDkThfiaJLQ@mail.gmail.com>
Subject: Re: [PULL v3 0/3] Host Memory Backends and Memory devices queue
 2024-02-06
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 6 Feb 2024 at 07:22, David Hildenbrand <david@redhat.com> wrote:
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/davidhildenbrand/qemu.git tags/mem-2024-02-06-v3
>
> for you to fetch changes up to 04accf43df83aa10f06f7dbda3ecf0db97f0c5a6:
>
>   oslib-posix: initialize backend memory objects in parallel (2024-02-06 08:15:22 +0100)
>
> ----------------------------------------------------------------
> Hi,
>
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - Reintroduce memory region size checks for memory devices; the removal
>   lead to some undesired side effects
> - Preallocate memory of memory backends in selected configurations
>   asynchronously (so we preallocate concurrently), to speed up QEMU
>   startup time.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

