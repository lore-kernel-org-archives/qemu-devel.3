Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88082C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yrJ-0001sw-0Z; Fri, 11 Sep 2026 06:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4yrG-0001ps-WB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:51:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4yrF-0001Tf-BA
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:51:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-851cbd64814so605858b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789123908; x=1789728708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r+PS0ohTfuSIE6GHT921cDMoCZOli+nRg2DKHcAsDU4=;
 b=nrmxfRS5F3PdKq6R1K0vygA9IFhVoohtQuxrLkiafWwicWbUmxGzROZCkrhJN4Pk7a
 fNY6m0Lh7a7in3WTAy0U0NC9zXxwXDGv+nzfdxyY54vBXC/RfzyY3VQCO+q86m6y1Szv
 fTUWvlxD7BHPpYFz1FMRgpLNgbj/OnBevljBqkK/OpnssI5g6Gh8dijSG3sthbFQWXqJ
 kUEyK3yigepUFeRKDIDKEjpXP+3ZnGxoyytNi2eHpjBdHhMMdbwOrljledxSvkllRAhS
 ScEkA8NIk+g48iiuvEou9jeaHtpcOY2BeuO2YXLufbnYJIi3DRkJKwXOdJq5TDKFsU2q
 +dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789123908; x=1789728708;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r+PS0ohTfuSIE6GHT921cDMoCZOli+nRg2DKHcAsDU4=;
 b=qxFYMCHz2BWpSMim6Hz7qcaW5oTUWpMG4E328n8h8XaHVdJz8tuzY7nf2eG4gbndET
 uG1nWqTxwQMMd9l65i2gK0ZSp/GWe7FfIuFDlvX2CeQREBVUOdrfZSPjBm47YBlpqK8O
 KaeTVHDiBh3vTshU9bVEFpodbHft9eP1hXiHrNvE72HEC6uA5hNa7uNOMfy5nGa3Y+r+
 iPbgrSkz2ymNG94lsUn6ana81e/w/a6SV+/v5rR34DPtRXOm55xtO6EtIzAUVTvz0n4o
 WXUznr+z/OywkXsmN3kqmFwTShlI8O4mJkw6+yGIpw+LKXGPiQrZ8kCTd5SqhiIKaDA7
 EPxg==
X-Gm-Message-State: AFuF++kQTgM0cw279x7mE9NmADe3BDcTYZpb0i0RSBbgyGq3uNnOSliq
 2zEcVje0p5QuUl6oAmvr9PXPnM/Gl4KmqSnTubkiKIU7zx4vwfHch/r2z1he78n8EHY=
X-Gm-Gg: AYBFou0r0oXe09p8caHzGlrsUF0OoUNde8pI0CzVXwc9l5DWYZBtdWWaQ6L8vwri+Q4
 bdQnhHutEqJktRP9wNOnN5of326+fPT20qE0vxJzcxituUjZwln1EUR5pDkxmEAXesqxozbY3+f
 KXfCaujBXpVDRJcRISVe44ITyXoaVHe5ZOb2xfpwHDaEm9QHfCav9DLnggqmfY/AWWPiZatvV+6
 NJ2HrIS0jmEn9Rk3aUSqOcpb5e5I8Z50r6/VJ8iAFupFOYk4eKjQGDGiSV3O/59PAACDtDsCyRs
 5oerFX5zNxaz16hHS6wQW29bbxV7KADUG6YPBNH7xKRFWF8pBIuo+N7aPKp10QL3L182NH8X8m2
 oGt0vRpFRMmKm/CXO2oeJaW74l8nBr/4ggqrD92oeOxLsHvUaHW6VCbI7jKMvQzTh2Vt6kafevr
 DlQeYRqgGdGIMzTfE4KBEtxCUdCWVg+C2xTldrPQwo8Vf5TIJNiRIjD1mFywW5VWD91O03nJISt
 6yiPOyWWlY9PoJfN/DIDVc34e2kl5768tAeTvJYgkmxDazzSJ6g6w2hmCE=
X-Received: by 2002:a05:6a20:6a0e:b0:3d3:aee4:66f3 with SMTP id
 adf61e73a8af0-3daed3c130amr6222032637.25.1789123907749; 
 Fri, 11 Sep 2026 03:51:47 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm6141948eec.24.2026.09.11.03.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 03:51:47 -0700 (PDT)
Message-ID: <2c60558e-3f27-41c4-9adf-25a0936d608b@linaro.org>
Date: Fri, 11 Sep 2026 00:51:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] parallels: persistent dirty bitmaps and Format
 Extension hardening
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260910234222.3039975-1-den@openvz.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 9/10/26 13:41, Denis V. Lunev wrote:
> The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-09-11
> 
> for you to fetch changes up to 94336eedb1c98792d595f729c7a284e9e91e6158:
> 
>    tests: Add parallels format support to image-fleecing (2026-09-11 00:54:38 +0200)
> 
> ----------------------------------------------------------------
> parallels patches
> 
> - harden the Format Extension parser against a crafted image
> - add persistent dirty bitmap support: store, remove and report them
> - let image extensions be updated in read-write mode
> - make qemu-img check report the damage it is meant to report
>    instead of dying on it
> - drop the unused clusters at the end of the image
> - cover the new behaviour in the parallels iotests, and run more of
>    the generic ones on parallels

Applied, thanks.

r~

