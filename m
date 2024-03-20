Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70353C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzGw-00032F-Cm; Wed, 20 Mar 2024 12:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzGv-00031q-2b
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:58:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzGt-0003O2-8J
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:58:36 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so7906a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710953913; x=1711558713; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IvteFqqykWWMDTm+Ef4i9teEVqwPMAR0Iarv4Ark4aU=;
 b=p0bGTzSuo1u6i4THgp93NeROGhcaV8dIoSn0SDfZJrrLQ14R3vy0M4bCZuYIFkEv9m
 pIjA8V89crbF/2nLZWmk0L7lZHVZSQgQsvwAvejXc91ot8IkJeVnZgQjm6U7qJimyjqq
 Bb4ZXj1kusjW4wabUs8zM+Zz7TTAQHbbWqqttBhQr36aYBvEFlTLmqoYe2BHCsqYTM5d
 BRe69KD+7hR5B7clpEd42e+4Kfh9nPeojqNsq+6N3EjWsn3C7STm3uvj82R7JvC/gOvk
 8Drsys+6+XB3tuoH1K/Xsh9AxIxtoXnkWBHQHGuzKnc3LnTr5CmXQmzLpbaAUAF9yQsO
 c2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953913; x=1711558713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvteFqqykWWMDTm+Ef4i9teEVqwPMAR0Iarv4Ark4aU=;
 b=ZfzZ+RytdWn240flW33a4VTnA/nhGrRQqI/3gQEfO86FQ039o9wb2d2UmEK2LWlhH7
 BDYaZrPu5v+bATfhQbywYyl7yzjl/eJE+HVRuEFVpsqA/4ZSs25cFiPwXvV0M13wVnkt
 hheujxTFQEU9iwS3005vmpggUnQpKHJxGCaAKgoQS37r2gpw0hkZqww9djrKjKxCY5fW
 AHbXm0lsWNSSu4BrxEpKgoFc+9DyY2rT8Hr506iOmdJH8PgbDYDJhl36KsZ6+DTlxyu1
 aYMZOTP+/LcqM9Mqrv5OGuYiwbZomGFRBYu3n9iDAwWeh+MnNFQlc+eTXMc6o9gOHunn
 THNQ==
X-Gm-Message-State: AOJu0Yxn2sn6+n+U8cOUsCUKXi3s7EBfFhXnZrmpg9+V4RO2W5uLbI6d
 vIcKkn2nnLmjTcz4oAvozIXZxFffZ0Wt/JGMnLdfgxRq8XngpeodmRhdWTVgrDHPa4jMcqLEgVn
 hJRJhNNVPm4OBBzs1dQtRi6+Rz4xMv40O0hH2Yw==
X-Google-Smtp-Source: AGHT+IGkMWVkdHtS8XLFFFo3KGSoN9tWon3EbSVMlJwqTcTyvnHm7i8mTYHs0d0XXDEIaHnaGlav9qE4hfwGpyBjDXM=
X-Received: by 2002:a05:6402:4499:b0:566:2aff:2d38 with SMTP id
 er25-20020a056402449900b005662aff2d38mr4741376edb.26.1710953913698; Wed, 20
 Mar 2024 09:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240320103213.1048405-1-pbonzini@redhat.com>
In-Reply-To: <20240320103213.1048405-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 16:58:23 +0000
Message-ID: <CAFEAcA9qA_v_mbObxv+9BDs0kiepb2ZXkGjJ7jL5kxWDaLpLdA@mail.gmail.com>
Subject: Re: [PULL 0/6] QEMU bug fixes for 20240320
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 20 Mar 2024 at 10:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>
>   Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 05007258f02da253af370387b69fe98e9f37b320:
>
>   meson: remove dead dictionary access (2024-03-20 11:30:49 +0100)
>
> ----------------------------------------------------------------
> * fix use-after-free issue
> * fix i386 TLB issue
> * fix crash with wrong -M confidential-guest-support argument
> * fix NULL pointer dereference in x86 MCE injection
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

