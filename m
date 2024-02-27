Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2EAC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuQb-00082M-UT; Tue, 27 Feb 2024 05:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reuQM-0007rW-AM
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:10:59 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reuQB-0000kw-7I
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:10:54 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so5388056a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 02:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709028645; x=1709633445; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mTlkIIB59WxwCFh0CWBReiEBOBdxEY75ZbMexqjTFVI=;
 b=DGDhM05rhsFd3E8VyiGYippTy8zzMLgohD1yjRm4Sdy6egC1r+3fF9M754D2IjylSg
 YxmkOqiLoEuYEfZ7Wy4Ngegd3OT1S3aKlhEL1K3HsfILgOxbE2M2U5YZt8dS9RSjeJax
 B57/JkkVnEHzgia1BRb9W/ysSrCqalWahnQ2X8dfTd5faLwAH72q78UGLwFZnpZdVvQ4
 Fc9b783a59P1PvDcbLVa5aQPATkTxSAzJtvgSK3RB7Kq+8eEmbAHZ8JX9WwNi2aZ1lu1
 DLB88VGFpCNseltG80YLAwuq+OeH6RZj0rjDCBwKZfYJiigHzNp0U+1uF0qOg2mMX7WH
 abKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709028645; x=1709633445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mTlkIIB59WxwCFh0CWBReiEBOBdxEY75ZbMexqjTFVI=;
 b=vQB47H6wbDy567o2MWnvGIEJY/iQNyF8JROJps2PUpJ3tciLoXXn5y48rAlzaxPTQb
 MFRSOVLE1/DvMUPksc81rZG21cmS2MxNtc0ldyjcB2i2cyj8VwTlPlR9tqfJt2yMvhP5
 BEnyUtmfCr2biSMrOxngUuhTKCdeRwDGQBxT2ckrp+TVsaukxqGlvekZtHYf4h3xCuJa
 gNuZVyX031DhPRLBMYMwP97j9YWb1pbvBsC+Vaxag/yvfDzayRDhpY7c4fKHopqdNFUC
 RQUc/ByEvj6yTrruedFRzFyru/5OXNtJSGK/zQIV1fUKd+7/qL6vPhqAjyLjJg+sVFuS
 OSYw==
X-Gm-Message-State: AOJu0YxCPi8KsPxH8owITDyIEpiWdZ2sINEB/YGDWQ3lMfUVMJCYF6WX
 maBiCMwlh79sHfw1E0F1v0FfwFbHp9wVkUUxFDZCdy2AAX2mL3e1X/bJ1QqivqKPcQMC21ASqh6
 3vUdPrZKGW2Ip8SxmRuKRAwSv9t+KFYCy903F2Q==
X-Google-Smtp-Source: AGHT+IHDyDrGYUyu02ukXW8eNm7yJInKoaaslad3Vqt0dAQNpdtqGQfLfo8FxWGjgZNUSbMD42d0O79SeMXcfPh9/+A=
X-Received: by 2002:aa7:c706:0:b0:566:2f24:b065 with SMTP id
 i6-20020aa7c706000000b005662f24b065mr1250628edq.34.1709028645451; Tue, 27 Feb
 2024 02:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20240226160003.903191-1-kraxel@redhat.com>
In-Reply-To: <20240226160003.903191-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 10:10:34 +0000
Message-ID: <CAFEAcA-yzvUDoS_GVAO3JxYr+_GdXXE42LsvfQLikXoS8wOncQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Edk2 stable202402 20240226 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 16:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 4a4efae44f19528589204581e9e2fab69c5d39aa:
>
>   Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging (2024-01-23 13:40:45 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/edk2-stable202402-20240226-pull-request
>
> for you to fetch changes up to 658178c3d4e95b3f4106e25ec5a209356e339032:
>
>   update edk2 binaries to edk2-stable202402 (2024-02-26 10:23:25 +0100)
>
> ----------------------------------------------------------------
> firmware: update to edk2-stable202402
>
> Update edk2 to the latest release tagged end of last week.
>
> Cc stable this time because we should move away from the
> git snapshot update done in January.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

