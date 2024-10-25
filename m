Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E03D0C607
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4JX2-0007wW-PV; Fri, 25 Oct 2024 08:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4JX0-0007uk-8l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:35:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4JWy-00016U-IR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:35:05 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cbb719839eso759136a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729859703; x=1730464503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+gQ+QVDfE7wD4hTZogpP0X8TWBzJ8Qv1S3V4EEfzjc=;
 b=ZCrGxeCJUB34VwQhYT1MKzInn72uMQv+3lXv9KxP3ZeR4H2djMydVCm1x2+TEIcVPF
 jfN9dZXVrpB+xTHN3GLrf6zEo5jEQLpSG1LSh+1hlRf24c9hqRjL7TjPNY/UncVR45Pm
 84Lgh1PZcHsOYmVYLLxRHp0Np0Eszaui6XAfnVa3aNC54kWSYwqn+JnTBTI+J9t04hnG
 CK4qiiRbopVljwf0tMAlWpgWnorGz58faWkbvVcy58iTbsI9/Lh9WNwPG2ns01ELQlMY
 GoKxLyBWItEKoJDQMIl9t0cekGvwAaeYi/MhAfPyzHONW8BhXaOczzU8W79lQxIm9iJy
 dsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729859703; x=1730464503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+gQ+QVDfE7wD4hTZogpP0X8TWBzJ8Qv1S3V4EEfzjc=;
 b=KrfDYJe33RF+M5UIj1OU375S906zHOeclWlHXoLZMsrbreNzzVVXtZ/BSBNmAp/CMV
 Vdle25soLktjSfXA0E77Is6l1OU27MhGMxK07GNAsj5T5NiEGvxZAn6IxZt5fQg/BDzD
 rP1SyhhaJzVvoBIaaA9qxRTLCp9qdTUtC8Qm6JC25wX8J1iMjxNW1qiL+24HaA/YsWU1
 qTSKBNLyKBLvCyqU+0vi//HK/Cob3sjwKmgfzkGZZidHQ9RsMy/Z6e2x5z9Myiuy3EGE
 bS9uIqqJs58+meIEs0ceIWehckU0n3V6WKyYj7vzzEoVKQzRTjNg26kBGIMmIR5F2MSU
 0ikg==
X-Gm-Message-State: AOJu0Yw7T9BHZ/FqrRD/8JXRGYXP529tiKpSfuGgK6lhlbfPFOwFrapP
 CV6Gfnx8MDSxB9LVVi14ll2XAfbRF25tyXCBA16rPeX/5cojGnwWBzmKMvn8nRTh1WtaOBghg06
 sritUcl8R8L3quiKBMTVRh6w//Gqhr6JFJrz2oaGvHsjp9/UG
X-Google-Smtp-Source: AGHT+IGGjpzXND4FEqr8A6HHq+h4vBqaRv/PmoTrJCOcecHQSahlj4iGdBnIqU3aIHM39NV/xEB465Lj/YAGn4MqLAU=
X-Received: by 2002:a05:6402:26d3:b0:5c9:76b6:d14e with SMTP id
 4fb4d7f45d1cf-5cba24608bdmr3162434a12.16.1729859702839; Fri, 25 Oct 2024
 05:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241023131710.906748-1-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 13:34:52 +0100
Message-ID: <CAFEAcA-_0-yHKt+dViHa5N=_2Ec=ovwHTVLvA2eDy_8SXoat5A@mail.gmail.com>
Subject: Re: [PULL 00/23] s390-ccw bios update
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 23 Oct 2024 at 14:17, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-23
>
> for you to fetch changes up to 239e351ec415ff3673d9da70d70ca3a5dd95a2f0:
>
>   pc-bios/s390-ccw: Update s390-ccw.img with the full boot order support feature (2024-10-23 06:53:44 +0200)
>
> ----------------------------------------------------------------
> * Allow multiple boot devices (via bootindex properties) on s390x
> * Avoid TEXTREL relocations in the s390-ccw.img firmware
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

