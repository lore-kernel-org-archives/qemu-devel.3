Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A1CC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCMB-0000l0-Tv; Mon, 13 Jul 2026 04:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCMA-0000kk-Ou
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:49:42 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCM9-0003hs-Dj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:49:42 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-667f29dc8a4so551016d50.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932580; cv=none;
 d=google.com; s=arc-20260327;
 b=Ie/2hACBHtE+Soe7ugPrimtZU/sxq9B1qk4IiP4pn1nuu1IHr18Bhlklp1ZkBAnqKE
 LTsMcCW/X5wmQPk8AE2jdq4XybZ83rS8/ZzbCnFq9a3GuRniFXsz5+ppiwM348bbghs7
 UoSQ1mAu7ZAM3+u+nELeH5Umoqr9Lwl7ts+SRwfzl5jnAM3o0UCuI9DMtbmjMLxWTGac
 70Nd+lXIbcwqvGsl5/8HE1OYLYD7CkafRlMfyfgInWC6bdrkRmyv6bkCsF3O0bXnBT5U
 tS5tdYzlLEVZPR/2+4Q4CgX7Qd2NHbNTCHbRC/XO4Zg/TY+33glm3ebU82k7jiFhaiJ6
 kqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M/8W/JUMsMobF5NRloR2RDhN7mm5htf1q6nP/rPjY68=;
 fh=rdTXSAnfHLrUhP+xyDrR1W18A8laT+Pb3EbUKJYYbDM=;
 b=BY1Of3XTjKl35cdv49SVlDwidgnrXoXDURNfmGZRIH28L8jFKIMJM6QsLTxIp9JRs3
 8wg1BYpilrpnh2lBUczb79VRToUJYyo+0Vm4lxz0aDMVLMc32qbJtbJDHW9SZsZmTru0
 XWjfkeOxjBE+xApnQeT0RtzIDw+7NZTNFYh82AXbUy1xcXDBYARyC8w9HPRnw4PSVMcC
 25RiiaFIpYL8zqrRY/mHHg6ewWPrarte0xAdOq5Qp/eqjaQjUNymi2K01Z+DJsZOWXr7
 kEEZMGVbJSehZLAezDQQXel7l5gEmy8Ag8c1qRlI9wm0hozxX640DK/sjECshAphlZpE
 Kw6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783932580; x=1784537380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M/8W/JUMsMobF5NRloR2RDhN7mm5htf1q6nP/rPjY68=;
 b=fmL74Yqm4AeEnvmLTop42YzC5N5c7S03D/4QZXXzDPEV0EMPVdHKHXuk2RKddeAKJD
 nmKyWL/2nBo149aFdTEKdLVmrpo4ig+KQZBf2uAU058PCmncktHmYkB9nRU12SE0XJR9
 ojE1rYKl1N1C5OqTb/4otUDmIJpTcbZd9KvMPrddy1VNPtxNbHdFVb3q2p18uk/DKuec
 NWzaAA42ILoXfzSTumP8G55XN2Tni7dXvpFd0yt/WWRwNlt5f4fMuZ3nTtR0joBShg+y
 sONIQlwi/3AHn+4+Un9rQgb176U/tWvU9GEgDXPPRNiqbj28GUSub+xYgoxFTeHxiaMU
 aF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932580; x=1784537380;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M/8W/JUMsMobF5NRloR2RDhN7mm5htf1q6nP/rPjY68=;
 b=RONhfjwThSv2zhN83hvHllxGIzummylpJXA+E1fqnxm1awPSOKw55IQjWfJ4e72Mob
 Sfnojf6DiJy77bbBJFK8M7QoMRag8MLNIZPLQ/W8C+o2z1A+6gHSjqjBBcN8raFqBiMl
 xqhZjwY58cFdDgcbS9SFSe6N3baI5YGS8Fgfk/xoZpQvGArBC+hwd951FWTEWPcI1kzA
 p1b0hw48b/1/GjQejOhuy5jhIffzws6p/CrM/ps4YqqT77CzUelH8PDsTlHC1QzBuaAK
 9oH+5R+SLqtvfpkvd/GHapa4wk7Fmao024tezZ1khm0tZtAVdg61tgH949JVKqbzk+xI
 iQUw==
X-Gm-Message-State: AOJu0Yx1svmBC2db+q6+xgjM0009XnIYILcF0CuBGvRBXhu8V0nUyOqY
 B2/w+cnQjhiPHctDomHl1+HGImCRCh1L6NwXBxpjYDOmbUVu0PSmcwc7yFO3UaHJ0Z9eNRvmCSt
 rmBgDYIS6wfErH4Y1fClWuYYu/p0sw0wqXiZM0e5P3A==
X-Gm-Gg: AfdE7clgSPVtvvlShJYfUSwC7ZwWVGLqbc2qRjna8pT1nfyV/p3SDH1AQASoCVujAN0
 e9AfBSuYBn248TToqpb6aUNcqeJ6U6HOO7vDlQoluyDqbkCcoG3s5gQp33upIbQbWKlMzNj0bB/
 sYDFkrBXeos0aGqaChm6kBKTLFyLJb2aAJL4ATJwOaSg+gCewmbae+MEniLQQuJSFtOov9FscfX
 m8fyKBeWQOyvcttfUHaBWrOznpARUqnwwrnz6aEZEXLj+/u6ZincRjoeoECnsxvR5Tf2kapXqiR
 4vDAGuRQUesn13mZrqbA5iAw4MP/T98ii66ZslBGtwmQsVm0Dp0DBZH0
X-Received: by 2002:a05:690e:13cc:b0:667:e412:6ad8 with SMTP id
 956f58d0204a3-667e4127ef0mr3630485d50.21.1783932579865; Mon, 13 Jul 2026
 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 09:49:28 +0100
X-Gm-Features: AVVi8Cf0t1dxuKJ8UMjkrJXcAevWTHy-6yn8Qf0UtlRnJcXCbMwTbFD1h2erv-k
Message-ID: <CAFEAcA-yyCYS5VDWf9z=iHPv3pQ29JO0vdFmjMew3TvBQEhK3g@mail.gmail.com>
Subject: Re: [PATCH 0/8] More Arm FEAT_FOO documentation updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 8 Jul 2026 at 15:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> While reviewing the latest Arm ARM (M.c) I found a few more feature
> names that have been added for old existing features or we forgot to
> update in our emulation list.
>
> These are all documentation updates so should be good for merging
> during softfreeze.
>
> Alex.
>



Applied to target-arm.next, thanks.

-- PMM

