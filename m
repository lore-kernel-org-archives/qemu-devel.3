Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC4AC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgMx-0007XO-Lz; Wed, 19 Aug 2026 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwgMv-0007TW-T8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:30:13 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwgMt-0007dz-SI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:30:13 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso1655620d50.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787146210; cv=none;
 d=google.com; s=arc-20260327;
 b=rV5HkuujS2mt7soorPkPNm2DLz6ZDoO0R8txpONEGulvQ9arkKS5cRmKWtw4bPL9j0
 OcZO1W/rpH9D5u52meq6hUK3ceEhUme6U9YAUQCMXiIgaPmIJcZdfpvhBMRr+XFK8mry
 fxB8ueEjk6T0rt7Hgh+iZDvETtIyfUe+USgmqWsMSfRM0DrltRzZkJ+s9XttMxsvCXm5
 yrVrthwu311qDQ2QQn0nYSHV44tC/IkZ5dzd4wejBiL7d4CX+IbFFrBYEUcfd/NhQtBs
 mG70BBxq1WGbN+QBTotAHw6ciZn7HTeijYNJow+Q7PS2LFHrYt6LYPXWfSCZFG+ycKG5
 inNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O+oLSNF4ouTMvFnMYOX/B+vSGWBF0VyKOFSdcr4VLEg=;
 fh=HEd2KinW/5H8X5QS9sSjJK6YyyHgY+d4GK9cnYpcuvE=;
 b=Z0xmcg66/g9zs90SvdnATz5aJJH7FPnVgDJndlaD77le1JLZZoTNL8dySP526Gcr6k
 Vc38rEMqTiQ6xSsLkJgFUFcSTmEl1Mavb2DrA7/KJi3TIX/UO5wWYR86rT7Fbmh3rbFi
 9kheS/zxnGRGKrwJwlvR6YXjoZwfLTrv2C4uvUMPxbx81EuEsFLGMWmOv7eUi2MIqGuX
 GBQex35/F7D+Cx7z2wJfzhfhWTBQhVGeUq3VPKBkuE5fJ7bYOJ/WLHkFGpj1iOyOkjkY
 CQCCCms+VJ0sZ6uoGqBDCHokwwW81nG4TBIsn8Pu7QlhvjV3MDZq1ioysKFfvlH9eCAf
 Cwiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787146210; x=1787751010; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O+oLSNF4ouTMvFnMYOX/B+vSGWBF0VyKOFSdcr4VLEg=;
 b=rtFdA4T/+CBGuYZYUaPCu2Mt/y5zoyvP/SX63PvI6Rr3+3ilP1EJIhVpvPmiCKV72C
 8tSuiYW3KoU9VpehFj99w6S3HvGLINch/abIXdpuedIYQ7z0k+8JR3Apym7+XDM/dFTM
 6QcBkFvUibZIYsE49NqU5ck3qzoPeFDwxgEEaOWEx1yjDTsfdzTExPS9G74nP17OVm1y
 cJf9ZsX7qot20AknNeTmMbopgw4wZ/7bHznCK2jT8APPDKI/qXUl3Ak1d6sOeGtXP3fw
 8MOqbQBV/ybSZI3ylSuv8pLdGyXlcypbPVi6pG/IlmPCQVRq0CvC9d+fILf69Us5Sovf
 EbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787146210; x=1787751010;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O+oLSNF4ouTMvFnMYOX/B+vSGWBF0VyKOFSdcr4VLEg=;
 b=JfXpz0OGFUZ2Bl18BzXSNQkV+k/JsGLd3dziUNB+M+hYVdETElpsjKNUp/15U64Zo7
 zGDIq958cl4ufd25I4/1qf2nVA6mm67oL/cYmXHHSZym/F5RJspl3xfxoyTctO2gHyBi
 9OYRwohYrfbp46bI7Ablt2OjPnR6rJkSXYr8S4k+lbIpH2B12Jy3uOM/XOolZAWCOrdY
 dMAnNTiMZeGFP9OHeL5FJeH4vbc0t0btdf/h1oqmK9wkfacqprLchRBzEwTno0VnifcE
 mlTkc26zAuwupV8mfNwdhBpW1gK3dlx9Y//aDjbgq61OVv2CdRYD/4r5HCpWiyFaMKHN
 LeQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEzwns3RLmiMh6E8LGSraVxLM2RZRKhBujdk6zsx89alYFtosn+Y2R/xX5DhFbTFzkm7yJv9h+UjWm@nongnu.org
X-Gm-Message-State: AFuF++mnWIpnzmJtqIyyImjSMhKUy2AFnbzeNQx/YHyk1mRgDwit+f0v
 +xMNrzmS0q1hhW6nqLB35PcXgLVFNihDuWPTDuAyGJ6UV6WoE+jy3zfe8oAhA15EbyzghSsjF8+
 MfHiYQ3JxsgOshbvKWFTOkz6WYgPb1qVuOlj1UQxhYQ==
X-Gm-Gg: AR+sD10RYr7T0ms1g0Xl80ivJ3lD3+4mwjdAqMPUUSMddLkeWRi3hmBOCyCywsWL37x
 2B9ViHxJB2uvEueYu2+VIEwg62PgihKdkZIm0dltWg+RchO83Uh23SPwwAe9n40UcMpRQsl7oWu
 mjqJrmB0TuEub6JsX7ZY7l67a+W0TikNMyUY8OM0BYvcOaDkekJyzS8wUIpyyQ0AnrtQGVx58Mk
 1rMlsX+7oDBSzr4CuledlDyO4AdD3YayiRI4HVVYoP7bPeH/tJhXIC4sS3oPoDEQ8uwjHqPQvLH
 DS8mJRka8d3hlDDpHUTj7zFkTtmqYB+dnb9/ibWTw+YKojHawH7U5VLapuW2KtS5ajmC7l/M8YQ
 DrthY4LDnOPUyGPDgGRlRSG9T1dy+7fFA3cf7Ib+Ren6r
X-Received: by 2002:a05:690e:1589:10b0:667:c09c:4a36 with SMTP id
 956f58d0204a3-66ccb5eaedemr1410988d50.11.1787146209870; Wed, 19 Aug 2026
 06:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787114994.git.daniel@makrotopia.org>
In-Reply-To: <cover.1787114994.git.daniel@makrotopia.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Aug 2026 14:29:57 +0100
X-Gm-Features: AcwNN1W33Ap0lPEQ7LEHv5dUFsopRrxh_IpDcx10ahgu-UxPhRRnzpg-hGX-Mag
Message-ID: <CAFEAcA-kkKrduX6r85vLTFixRZ8pgvXpZDjR_-DTSz0h_+kDOg@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/misc/applesmc: Implement writes, the shutdown
 watchdog and get-key-type
To: daniel@makrotopia.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Kane-Chen-AS <kane_chen@aspeedtech.com>, jack wang <163wangjack@gmail.com>,
 qemu-devel@nongnu.org, Matthew Jackson <matthew@pq.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 19 Aug 2026 at 07:41, Daniel Golle <daniel@makrotopia.org> wrote:
>
> QEMU's AppleSMC device only implements the SMC read command, so every
> other command a guest issues fails with kSMCBadCommand. Tracing a macOS
> guest shows it relies on two more: the write command (0x11) and
> get-key-type (0x13). The missing write command delays boot (macOS retries
> failed boot-time key writes) and produces a stream of
> SMCWDT::setWatchdogTimer errors at shutdown; the missing get-key-type is
> rejected dozens of times during boot.

How does this series fit in with Matthew Jackson's set of patches
https://patchew.org/QEMU/20260720164930.68383-1-matthew@pq.io/

?

thanks
-- PMM

