Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12578E68974
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6TN7-00025E-OK; Thu, 31 Oct 2024 07:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6TN5-00024x-OX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:29:47 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6TN2-0005ov-PO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:29:46 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so7646021fa.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730374182; x=1730978982; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnqznWKtV9KFBvGbTyJqcobMEec0XRwzrLdpjMaWxP0=;
 b=mjOAIRqw2KKAOwnfvS5bhF+rgClxKaJwO2P86GYCiLb30n+dlxxjdiDr0R+Js7QfsJ
 QtMzhb/rxAWyK3Si+VoklZRPWVIL5O9fbyGZRYp5AF85Jn353JR1SGJ0uN7d8w+dXqk8
 XV5EgwJTHfE2ek2tdOQfmjIU1GOuzTmIZMY4GOGvQmWQqirrO8EmiZFP9y0diy8WGldZ
 tkzdAo06rF0lrxnX33TGSvhc1aBt5kRhKVoj/5kvobZAw+SbxJTeCi8AKTbTZhmIofWp
 e0Ss23oleEfk3dLfmNkFvuy2Y6yJ+jFpNEFVR3B1OANqWKiLS7JI2i0764475RXEOXGR
 VeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730374182; x=1730978982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnqznWKtV9KFBvGbTyJqcobMEec0XRwzrLdpjMaWxP0=;
 b=dd5hlssov3cd6YzJtB9kX2h4Zkcg/OMBRAoXbvsdHe6ZSMnAaAw7m85bMFPq3YHlNm
 VGV258WiLyGc2dLVsNVm/Fv7/DZFSYvSr5nmPIKboUZtPG6VsVN8MsfrAVslrO0YHld2
 dKtJOi8O/3j2IIFcMUYpi4iKYMrRvl6fAmzh+G3wjN89NRFFHi4M7cLHdTY0fA1A5rNy
 HLc8tWlr5b02y03IraP72lBbsFLgdS4WjoEsL2r4bFMANCHPdYGXOiNvUidhqSXWOGvD
 bvsZn4Q4O881uc0XxphlpwBxQoO+uTNfmUJ690IP7Hot0Vl1qVycqfHaGaWpAVAzPS0B
 ypdg==
X-Gm-Message-State: AOJu0Yy3Yq45iu/cKvFgFSanPeAd4zSB2EflBzy/LMQjjncPHieiBmaN
 G3hRRfXdlOuuPjgnvVQsYDwRv22HeNmIP8iavBGnb6FoLygmwiMOGGIIux/UhT49mofGQco5Pu8
 Dcxh+bSaPVbdw0Hl18q/gnxGWqSOXBVnsoN9Urg==
X-Google-Smtp-Source: AGHT+IFWz0qVh5bQvLm3SaD7i0TA4DZn/2rVA6yoTRdtpqDsicQnBF9C1Ts5BHzywhAqQoxpfnZA1kKEaNmv/tMAydg=
X-Received: by 2002:a2e:a58f:0:b0:2fb:51a2:4f63 with SMTP id
 38308e7fff4ca-2fdecbf1a46mr16939991fa.34.1730374182522; Thu, 31 Oct 2024
 04:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 11:29:31 +0000
Message-ID: <CAFEAcA8j21vvgpp7T0QoSna+dLv_OKExcVjVbZ0TmHgaf40ebg@mail.gmail.com>
Subject: Re: [PULL 00/13] virtio-gpu vulkan support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Tue, 29 Oct 2024 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit fdf250e5a37830615e324017cb3a503e84b371=
2c:
>
>   Merge tag 'pull-maintainer-oct-misc-241024-1' of https://gitlab.com/sts=
quad/qemu into staging (2024-10-25 19:12:06 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-virtio-gpu-vulkan-291024-=
1
>
> for you to fetch changes up to 94d0ea1c19289d76ced934711fccd2269e69bb29:
>
>   virtio-gpu: Support Venus context (2024-10-28 16:56:36 +0000)
>
> ----------------------------------------------------------------
> virtio-gpu: add venus/vulkan capability
>
> We are currently lacking a declared maintainer for the sub-system so
> while we look for one I'm merging after testing locally.
>
>   - convert some fprintfs to proper trace events
>   - move timers used by GL devices into GL structures
>   - handle virtio_gpu_virgl_init() failure better
>   - implement unrealize for GL devices
>   - use virgl version numbering to gate features
>   - support context-init feature
>   - don't require udmabuf for virgl only
>   - add virgl resource tracker
>   - allow command submission to be suspended
>   - handle resource blob commands
>   - dynamically handle capabilit sets
>   - add venus context support for passing vulkan


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

