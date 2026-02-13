Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E953EDF14F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqQX-0001NV-J3; Fri, 13 Feb 2026 05:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqQV-0001Bd-LK
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:29:31 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqQT-0000Rm-6J
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:29:31 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ada2c30a1so718474d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770978568; cv=none;
 d=google.com; s=arc-20240605;
 b=YYSRDFR62BWAffM9VHsomyvJWpUOR9LdWZOj4yldAvSmWK1f3zhUF9jQ3ZCci7FZna
 1Nw7kDtNY/KvcDKJvxBM3Gm7bCk3RY0nSJ1qk/MMyK4TFff2YuIINft1CK0vqV+Vfjmh
 LNrKHWQqz+8lZEATltwUzci6GFJg3ne0fw0/nl83VKD1JSR9Nw26pIQqk93fVIdSkvfO
 ay/klmmJpsoi9nZ9qCGkk8gOpOcCCfGvBvhfT2qjzgpI+z+60uiSGPdSjCc4vmxJvSBA
 /iterhlVlR2UGGjs6SGwZZ6tasMP8DLUGURUtYOlTjynHRTh5K6jCdxqEh2G4VgUcJHV
 F0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z0JX64T8lOSgLEftsLGaC3xya31XDkWdbIE8PArAca8=;
 fh=9gKSuuRIWvfKJTowoXlNRdl+QD8s1dol23sP3VoStvM=;
 b=lADOEmLhV9uIatDHKSTUqQNj6Zo7ceFp126SefPTptn0HWd+r+N4NlHojWYOBVqMf9
 /Pkfm4GCom9h2RMQ2WStwBZVtzA+dlI03qCrhQrLE1Cy/zclUZiawR9XZr69nnOSez1f
 pn4dufyeMHepATI9Wqbo2kjqnXohS1g+uMZOSr7+irnVWUfwPuvYKNwzKLiMJPUPJmEc
 8ffxsnBCayiGGsJknzHZRDF+fwbMojAFZsEijyeSCeu0xuxqJDqc+dgnHUsWsTZssG16
 4elBD7T3GVKO+D57Qb3za3ACU89T7UVLdVtqcTooxpv+8P8D5R/1NTftH6tkZ7jG7VNN
 HDiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770978568; x=1771583368; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0JX64T8lOSgLEftsLGaC3xya31XDkWdbIE8PArAca8=;
 b=ZYucTSxo9ZJS4xeORdFkbrnbR1HFlBZZ+XQYmAqZPvghrXeA92HVgAlBGb+2sHdqit
 8VsW2mTmEuydlzxT5Moz8Dgz6GudM17MXhHHLbOseXG0KeTHLQVABWr48y3GzTHqSkut
 rZS2l0/iDn8I+lXuEhP3J7OHcQs3vvjVfEB6GedAybUhb9Nawm0aDinXzTeG3cSMxodQ
 thCXbyzHmY1WzfE6Tfg1cWSpoBCKzbHTrBvQCTl/5nDBRsWu6SKuj0EVhkMO0dtc0GWu
 FSk24+T9/FLICSovixDvBrsNT2HsKoYrrfDVIMtcCtPMxypswCMi208yGBfv02i48Vu6
 AkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978568; x=1771583368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0JX64T8lOSgLEftsLGaC3xya31XDkWdbIE8PArAca8=;
 b=jr+Hi9O1s1sa+7Ridvfoaj4kOmFpm8RgyRs5h06vqQcBA+8s8PmT0h/u3l/AEGjOQS
 n7tGT83kXH3enWQt7cMhlg/QXw9nV5+8basjAg2EzSJoAXGoIkr6ISOvvgPyPyaoij/j
 ++eEELpPxkzOAHE8e0TAEVgEGwX7qC6d57xibXAM7o3k0zbIRcanapzvdSQGF/ip8h9V
 XhAStzlKF86KmakkUT/KDI1yp2IJYfCHkCjfgvn5LIU6zpm7a0RskN/6f8Pzywn4wz+4
 16YnAqUOlx+GBvC/4WfnixeyHOIw9+IxfILhXQYuakZhRw19+E1r+VUGAZtZYv4kQIgb
 WCfg==
X-Gm-Message-State: AOJu0YyzOxeRijH0WgRSydk3AenlOUUrjQNLH6WI7trg323Wk6tJltW4
 qEApefnhTXSEOVBPLws34EwrV96IZQafmeQaIngcCvXi8FdGpnt5QCpup9XX9chWVEZQ1k8ESEF
 tRndG8VoPSOW7Ez8QWhMhIvDWoe9LIrbKM0/AymlRSA==
X-Gm-Gg: AZuq6aJvZmKRwjQILbvb+7mQpw1DVjVjXQo6F2EE5yTLTYw9Nr1lvIfUeZMXDGjUs1+
 YmC4tYS2Qg3Dsu58eP9LzL0aAXn4duV4OYcdm9uR7FUSZJzFFx98D9wKb3alTV0cygGwUp5xD4+
 qjdVd7jB24LL/rYJ29iLdhuaVu9QDSdpxC2QPTnmzwhmg61Pfm3ZQon99LEJiCY7HxXjgJzw9l2
 5+GMBUsTZUI3QccQGYzBr0D7z4tBqLQ3AuG8GsVFR4fvifx1K/HGYgErxbNyV+KsCT2yFlKFy1q
 fy4xGNeL1z8Qc0TD1SdYq2fEnqgrPtUmEGdKYfP2rcLtV5A/JFlFBeZ6k7T0qN16Mmg=
X-Received: by 2002:a05:690e:16a0:b0:64a:e61f:a6f2 with SMTP id
 956f58d0204a3-64c1979ca34mr855227d50.11.1770978568046; Fri, 13 Feb 2026
 02:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260213025544.2497992-1-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 10:29:16 +0000
X-Gm-Features: AZwV_QjfRD42P-ne7qD8-0UDbRL0IhcmJHtDHUYl3g-YaziEPkFH5nH0g1_n6cI
Message-ID: <CAFEAcA9mJcMCUwZQbb19+eZ6uR3DktZbmWTxT8J_B9DOncuJLw@mail.gmail.com>
Subject: Re: [PULL 0/7] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com
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

On Fri, 13 Feb 2026 at 02:55, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The following changes since commit 4ed6a7f2fdc09d9fc3411e83e278da0085122016:
>
>   Merge tag 'pull-block-jobs-2026-02-12' of https://gitlab.com/vsementsov/qemu into staging (2026-02-12 14:35:18 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/quic/qemu tags/pull-hex-20260212
>
> for you to fetch changes up to 27e415963a0928d5ee21113e69675a6fc8b9225f:
>
>   target/hexagon: Remove unused is_finite() (2026-02-12 18:39:51 -0800)
>
> ----------------------------------------------------------------
> Fix how qemu-hexagon handles invalid encodings; cleanup
>
> ----------------------------------------------------------------
> Anton Johansson (1):
>       target/hexagon: Widen MemLog::width to 32 bits
>
> Brian Cain (4):
>       target/hexagon: Fix invalid duplex decoding
>       target/hexagon: Return decode failure for invalid non-duplex encodings
>       tests/tcg/hexagon: Handle SIGILL internally in invalid-slots test
>       target/hexagon: Detect register write conflicts
>
> Marco Liebel (2):
>       target/hexagon: Remove unused EXT_IDX enum
>       target/hexagon: Remove unused is_finite()



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

