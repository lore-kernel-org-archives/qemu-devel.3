Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C62C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyid6-0005C4-Q4; Tue, 25 Aug 2026 00:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyid5-0005Bo-FR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:19:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyid3-0003R2-Sk
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:19:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cf452def93so2668735ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787631556; x=1788236356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N9qqYWwKqgrA3sBD4nCgTIC307xBPl/APa3fKAB6sDg=;
 b=q7CYk1dYPO7nWA/ZPL1CmuIoCRCdQwotxr6ovSqW1ut0naxrghsjmo3V5ngwwX0afi
 vmdDEjfiJhBk+F0P5ITKCanD1J36J08WX4SJ5kaHsUQuftiD5axwItfMv7PyOP9ybWxh
 ZhybAwYH5SiYjf7AjAr4h9NE0Erhb1hBSqRzRN3I8Wp4leoD7bM63Xa9DLY/vt+Sk2Sx
 3ar5r0D3ZCMIWTpx3mg3JosB1gS7MAbJ+cLABRfOA1Lvd9yQZ9lKPClRSLaBESVmo4nW
 s9a4cT5Pb+QFyKySkZ0OeVmlmKmeynanBAYsoFMq6BTTVkVihDONUKlluyIMemMqaFa0
 5t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787631556; x=1788236356;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9qqYWwKqgrA3sBD4nCgTIC307xBPl/APa3fKAB6sDg=;
 b=IRuubKcPswVjp1zGY/2Gjlpb2dinEX6CgVa6FbBtTdsheZvtGAAiwfimjU7n7R+Yqx
 u0QTPa616ouwK520/F2W86eyC19fHO4O5mapn+JORhNG9sqj3GeQBOwWu1FlWluoNbCY
 fEJGYhXEWKffngRi+R4te3OxXghel/1NpdgLiLGfsNflBHmsPPk8TAGbYsJYDTH6Fyis
 NzBJxRtW46O2k77FjSWTz1G/xKnaiPPltra/c32LDopwjjyxw+jhx/mGby59eyJ/Kr6H
 BP00Gv++I6QpveNC5A2heuxhxqKJNpgrzK+UjAhtBsKyAdY+VWqUZ44t99qMESBjz8w6
 XPVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzjtrFfgqHjfF/BA29RLR0jlu88ymyFvSaYt8UDA2+WU6LtUdLMtyjyuJAQDdyTOs2AtPOwlh+kOkt@nongnu.org
X-Gm-Message-State: AFuF++nfZWzd+teny7ZRM0eeedIMRhKqYxvI0k9YfpRnBOqIeAmtLdlz
 XfBkwASfPdI7cXoG8xpPzgsMA4n6TTobh+yv4E98sFLnj99KdJMqYkxZUE+ewHS4cl0=
X-Gm-Gg: AR+sD12jeDJ31C+/JUKVZoowYGsiY4uSJuOsyoT/Nq8aT/CSEFK3ucClMmdiIEF6Kwj
 8uMbHfJzshE1edcIFKy+PBv1fmFY4OGzzoALVY7LfVRI/iQo6RK0pCo1dewC+SFwbEMPvrU8ykc
 tQOg8Qwchb0P09OJDcbV05qgs6UtP/Drry5yEmkFGlxjgzjj01SorNOcdDu0Plw0VR3r7IYnB68
 V2v1JJBuLIsGWAXcOgRMhlvC802TW7nVe7FVyCg0U2Yw5sNtRFX95CXQRF61KbBqy4VGKAv3UYn
 ouRPw2aVfWleezcnu2ctQix2pDnJ+hxfTy007WAmj9ja9YM7eHIll4lxbsW2OgF8v/qFQ264m6a
 FjrC0Eb0wNHwSpAvP6S6m5o8nJioOtshWIQe31L/vNS/mGJfXDDlOAgbPGMzHlJV11Z94VzMS7G
 2FCxo27CdeyFAOoLqg6iEiLIF1fwBj+sMJ0hBVbU+YgVsiqkVuM0x7rIQ9jrCRs99Di9t8JsLeZ
 RtkJ0i6j4MeIEjwddxuSnNI05ux
X-Received: by 2002:a17:90b:2543:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-39645aaa837mr4425629a91.6.1787631556275; 
 Mon, 24 Aug 2026 21:19:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b4d52asm2193152a91.8.2026.08.24.21.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 21:19:15 -0700 (PDT)
Message-ID: <10227953-16ad-41d2-bb66-67908c309c51@linaro.org>
Date: Mon, 24 Aug 2026 21:19:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, mikail.sadic@ibm.com, clg@kaod.org
References: <cover.1787548791.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1787548791.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/23/26 22:27, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit eea8fe61b8be8f3016e522e6af24924a0266ca95:
> 
>    Merge tag 'igvm-20260821-pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2026-08-21 10:39:31 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260824
> 
> for you to fetch changes up to 6ed05d5e65208a5ee23a02667d5df0dc6491c156:
> 
>    hw/ufs: Add a generic SysBus frontend (2026-08-24 14:17:29 +0900)
> 
> ----------------------------------------------------------------
> ufs queue
> 
> - Separate the UFS controller core from the PCI frontend

Applied, thanks.

r~

