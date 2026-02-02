Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF23D172CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmE0-0003MS-9Q; Mon, 02 Feb 2026 00:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmDC-0003AD-Bq
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:11:01 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmmD8-0006LQ-ON
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:10:56 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so3260713b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770009053; x=1770613853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k5Yxknpcj/GXD7/3Be5dia6ccR4/UUl0v0niOv3bGZ8=;
 b=nE9QO2P7uUz+pt6BkTDJKpOeDClgPOb5zkRCWf1RmJAq5M0fHDbG6ozUG7FSj1zQpy
 RtA7WfH/f136mBEutxMffzMWfkgl4AnBRWyOVbTW89ixZT8gs9yuDEbvNo+35ZJvz3HJ
 +/RSQxN8u7BleyhUyf7q3TwacC73wl+frIIkHu/Gzo/g26vxhxvBdocO5bup58Nfp4h3
 /LHzbI9hU1uTUlvfTmNFnTxrbS6EaVvREylKxpL0P7BjijOQJJ4xSg9fIgyVDO4Gfxt2
 q3lBRMgZE05pBKXvgduNzEkAkCbbqQRmYRo/xHv2nswNYHCcZI50caltqoXwBqauzysb
 yHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770009053; x=1770613853;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5Yxknpcj/GXD7/3Be5dia6ccR4/UUl0v0niOv3bGZ8=;
 b=myZj6fu/cI9U4uTeOwgtzXLEgVuz2Cu/6WRQKdlYUun8knJ6Z1mU9oZMq8EQ9em9h+
 39mT/XWZhDR2FdSeUVgBRJnjiymVSFbgXYbzvNirWJWb1sjBZwfF8QT+D+xanIYM6V1P
 xsjqgPIUTIUWzGvjhEap5CXMSXNaQF3Fk+csClQziC17doopUn2vc98veZefjW9ADu9z
 XKMs5B7/5ybJgvIi0adfbZFBL6URd/W72ITbK7RWeCwqIpeXi5RiCZyBC5vtxuYeojmX
 VASlBjSxgNwZc78AnGtdPNfsXO/JV5RCnXi+vsRF5GlM0MdC66dv+bKPkodJfbzOKCWp
 2Dcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1umyeLEtmpTdc8sM4K8P7bI8M0dxqXtAzuiH58YuyYtqzi1aNQudpRaAI+W9syENhRrJKpcuXWgFw@nongnu.org
X-Gm-Message-State: AOJu0YyP47vnjTDI9/RAvdGbPmzbfI8kr8gOyW+jc2kan03FGuWnakbf
 mn3JRjIvKxuJEMtFm2Uh7vCHOFovGvQH8CJfzmWetzKQy/ED5G4igp6SwcVeIM2pRyI=
X-Gm-Gg: AZuq6aIMDQWIpdoS5E/8j/B2xJmyyd7XkdGAeYJYYo0fVuj42ExeKC00VLNIqTRuyu8
 emUXo6fcmq7IrBc+ce7xeNsynNYytHbCxeC/CoyOo1tiktQD1zN0/PTdII/4fsnpryHR3WeUVYg
 qqjqxfAI0yGQD+w5wrsj+PS3QLAndEtivchJk6w7vsxpkkUkGBiq98YY5MwBNMOGAyNoTEOBZwy
 GBiy44dZgQns7axNYBT4f7VuUVXkekuRAQB1hISpz6OXZHRzJouIIH/sUyTYxNWaezi8zwDeQCB
 uAXjr/Se/Y0lFloUldOBQ56+yhJY8TW+bYbikiY0nZMfN/nXYs/LskeOJfa0M+cbRjPYJQTdVAH
 Qk7bXhMW5WsdddmKpNlU3M0ALedAOjTO0jqu05+oH0qTEupdXRgNaJnTsXHBPXoFtETEl5V/s5Q
 IvUYeOdZ0z5UodABv59Sgjow3qPX8GPbLLJXFxmDBX++or1p4/FcCjTS5yenTe87l6uLsMrQ5IT
 yo91Y4DH1mbgkX4W4mFLUMTeKhX98suB9rHnH93wg==
X-Received: by 2002:a05:6a00:3a26:b0:81e:b2ba:5b36 with SMTP id
 d2e1a72fcca58-823ab86af01mr10079971b3a.63.1770009052950; 
 Sun, 01 Feb 2026 21:10:52 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 (bg30dj08q4s9ql12qb2z.ip6.superloop.au.
 [2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c56e20sm15907763b3a.65.2026.02.01.21.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 21:10:52 -0800 (PST)
Message-ID: <2906b6ef-55c5-4548-bc16-a95c35bcfd5e@linaro.org>
Date: Mon, 2 Feb 2026 15:10:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/43] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/30/26 02:08, Peter Maydell wrote:
> Hi; the bulk of this arm pullreq is Shameer's SMMUv3 acceleration
> series; there are a few other minor items in here also.
> 
> thanks
> -- PMM
> 
> The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:
> 
>    Merge tag 'pr-build_fix-20260128' ofhttps://gitlab.com/pbo-linaro/qemu into staging (2026-01-29 13:29:33 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260129
> 
> for you to fetch changes up to 5252c077467a5570bf3b6b6278d206c46f51f9b8:
> 
>    arm: add DCZID_EL0 to idregs array (2026-01-29 13:45:39 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Support SMMUv3 acceleration
>   * A few other minor cleanups and fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

