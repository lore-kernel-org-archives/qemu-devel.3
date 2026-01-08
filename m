Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D7D1D495
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwpV-0006nH-Fy; Thu, 08 Jan 2026 15:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwpT-0006mQ-Bk
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:41:59 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwpS-0008Cf-1G
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:41:59 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c13771b2cf9so2591605a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904916; x=1768509716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JtyQ115NrIQL1bkFu6JJ3tDIj4YisNNisgq46FvkCFo=;
 b=edJEwgOD50zFWni4YeKeiz3k6yMjAJubg2Tp981F3OyhwydESSYefvncR8pNzQoO//
 qzUCQDYcyjn3Fr5crnn/U8wgDiZO96kOtRQpl7YmwEmyWmOgYDS4mJqeeTIPldFBg3q8
 6c5tXJUzQWmOYKy+Kd2VgGGGmLCW9E058KkxX/VpWF4gO3xjfCa5sLkc1RpuRYkORUfO
 7yQ/SKW0AqvrdlnW6BA39Df5rc9IKvbxvvqJ/jsH8z5h0hNPOm+mtLWYMURhLm+Cbci0
 1eiBzWWygzf4/jisTvaofjHg9FD5NhKWllweAEwDU+TZug+Ev3FyImyawsgpO+7tPbp7
 qSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904916; x=1768509716;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtyQ115NrIQL1bkFu6JJ3tDIj4YisNNisgq46FvkCFo=;
 b=UAF5fH73c/S67nsGbYT6UGG3DjtVekMJqfv6ymJm6IeOatdZoDiSwO30LjTXhcyBRX
 TpJDEyirRo4ZTowAJf5HYZQaw1Yip/f9VXAP8aGJRgOzAHf1th6/hUu0wqiFtkDDWyA9
 KzdISGRSa2A1p8Yuhj1RkNwzy6xkI5J+v+hzND1YF5WiV5v3Y6j7ngQgi+tg76bKzVlj
 U1y3RFrNhpFUx2160ftM5qbM3viOHKtv4PQcoGG3zxhFsLYI9EPvIOSS8VoYKGLw4JDe
 sWYAnFAXniJzyBG8WkqWukneYEqewgILgGI0Zmxkvz7ufhRJdwjOY3ffGvngCcmGVUCQ
 8/2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe2gGlfZGhStekwZfxDOnH3jFceINrhQCu+QOdficPHHgEY6K9AmmFE8TcE3hzlVZkSNwCa299RCqk@nongnu.org
X-Gm-Message-State: AOJu0YwvpsnT0g5Ve7SELNvROD/h5p0F/mZUFbxEujERzpRT73HGGjzX
 rhEYg0MvOGTUFcWyMC22DbrDWBMMhmgJXQv7joPY7gDl6rkTsN5lnVH6/FmJYCWcJsI=
X-Gm-Gg: AY/fxX6hNZPH8BB1tofPRZFDA7EzekTcoIdiofeGf9mt+sahC+N/cmQpKFwaB/C5AxX
 KkDNltjkORb8sg2yDmfEqV2wbySibFEI/mBm6NgYtawKR+YYdE2WAa0oA2sorf/0dBiU3EfbvV3
 Ul9m9qnQnIU4Yxxf3699nLKWnzo9+uXdUD04f919PnT48li5mxeCrNWQwkUgB1dVG2Aw1KSppQ2
 2l0mbG9xPp0pKEbCsi4tBKtiBXJDjYzTGTKgi10mUJ9pTm0yxyw9ZSb19ZPx5CKq5zbCD56LwR6
 H+uL9wHm11VR4fsNU5N5PQg4XW6Tl35k8zP6ebUEYoGqY9stHBbvE03DGCh3PPq6pOe3HaP4Q9P
 9AoxHEjiqhgWcFfeaGi1EHXqKBnJdbFoylIJ8/Xp1HrTb2gl5VpKka3yS1J+yn4CSvG3owF8XlT
 yEHaaidnfJVCbcHFPu19rGGUJ0EulYqIkTtXoHTCsQwS/bDzJC9vbx0I0C
X-Google-Smtp-Source: AGHT+IH+un/DeJTx2RuHpFWqeXO8j/1lGHDiMlolA8JB99nCG6Pei5f5xHdCWcmTRIzenk6eW/WzFw==
X-Received: by 2002:a17:903:15ce:b0:295:62d:5004 with SMTP id
 d9443c01a7336-2a3ee456360mr69343895ad.26.1767904915796; 
 Thu, 08 Jan 2026 12:41:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2df6sm87248645ad.61.2026.01.08.12.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:41:55 -0800 (PST)
Message-ID: <d0f6a8c9-a11b-4164-a949-a33a5a568e69@linaro.org>
Date: Thu, 8 Jan 2026 12:41:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/50] tcg/tci: Drop TCG_TARGET_REG_BITS tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target-has.h |  2 --
>   tcg/tci.c                | 50 ++-------------------------------------
>   tcg/tci/tcg-target.c.inc | 51 ++++++----------------------------------
>   3 files changed, 9 insertions(+), 94 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

