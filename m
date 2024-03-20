Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFAC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxVP-0006wc-1p; Wed, 20 Mar 2024 11:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxVM-0006vj-Jt
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:24 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxVH-0006a3-K9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:21 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56b93b45779so2854324a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710947118; x=1711551918; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NzUProAvjXhm78+6TwWe8Z0xRDRtmvavrWZ1HGtmQEE=;
 b=oWbM0ru5zAmcWOwQCnHT0ItiZa5jxPQRVgvnJIMlJZfHCQRGCd+xtDhAOk5nND/s/Q
 BRuIqerjwWzLkO4BAKOe7sQEseOt7p+vhKhUOgB5p+mN2q8gWWYQ4ZbiN8scmoNf+RTe
 d7iE8vsvCyDrOEddETINEUh9h0IqpiMmKNooXRYf0xbw2/22c5NicPahWasoL99HZEuT
 6ezqEDnBvIu6KMPjqpjTxBjglPrn87sWPgLO2sIXfHSAl2zCzRMGtNIGfVr0npIO0TL1
 5DPPIgRETGpxobnZV1NziCA+wAGsD0XHE4Tp8s8/ZTFo0aQmcSN4Ayll4Gz5i7s76nLy
 sw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710947118; x=1711551918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzUProAvjXhm78+6TwWe8Z0xRDRtmvavrWZ1HGtmQEE=;
 b=sRTZyUbZVQldJXLTad4QvSuAb5NaVuBGfjItZWmc0vTL6ZNI5/bNNNtzJXZMED0cew
 s3MBUYiSAR85JkFzmB6PJSQ/x28QHBNIoZTm2RImkSVgKUQIVBsebwTqPeC3nrdQwDap
 di9SZyZPTvujIUU7OT9g+gNonrCp2keQswaJV53xONmYrwh5zn2sYMEHdV8JsrarmcWZ
 an60CnSsGR3Xd0Q45jfoAZBnXOuDiToy1S2HJL6lCSaCIuMKkP6yGEjFbsB3wd1k7ADp
 kgcQGJk9Fs+jALj3yujveZBuGwzKBog6zTvrJ5JxbhL8as/fr2y8gZhMogkvJjLQsQQw
 tbRQ==
X-Gm-Message-State: AOJu0Yw5Iu+nWKmvIuIH6z3ShY2Dcl4NfWrTOMz9FZ1NBQlLm28V9OjN
 2P9SmOuccoypqvlG6At4xfWQfVH56iiRWujaVc9t2yu2AI5ABB+/fTlaLCcuZch0uScmiDXz18B
 Zbf9EX10DZ8scxDCnWCvz5Zll+RDENQj7d53nPxob9Rba/gg3
X-Google-Smtp-Source: AGHT+IEPVOWPGUqAblD5YAFDJlVh3aOQJ2239xXf/Wx2GYeP3D9AIW1yRqPUeorky2jwB/0YRc/cyjXxc3/FI9inT4A=
X-Received: by 2002:a05:6402:3881:b0:567:2870:1f1c with SMTP id
 fd1-20020a056402388100b0056728701f1cmr12502300edb.19.1710947118182; Wed, 20
 Mar 2024 08:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240320003223.554145-1-richard.henderson@linaro.org>
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 15:05:07 +0000
Message-ID: <CAFEAcA9juruSER3V=u=JUuc7z2Uuc_e0pdk9gbrq7PjscbJB7A@mail.gmail.com>
Subject: Re: [PULL 0/9] target/hppa fixes for 9.0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 20 Mar 2024 at 00:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:
>
>   Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-pa-20240319
>
> for you to fetch changes up to 518d2f4300e5c50a3e6416fd46e58373781a5267:
>
>   target/hppa: fix do_stdby_e() (2024-03-19 14:08:02 -1000)
>
> ----------------------------------------------------------------
> target/hppa: Fix load/store offset assembly for wide mode
> target/hppa: Fix LDCW,S shift
> target/hppa: Fix SHRPD conditions
> target/hppa: Fix access_id checks
> target/hppa: Exit TB after Flush Instruction Cache
> target/hppa: Fix MFIA result
> target hppa: Fix STDBY,E
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

