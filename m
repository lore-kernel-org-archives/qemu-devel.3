Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504BAC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNmK-0004TJ-1n; Mon, 24 Aug 2026 02:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyNmG-0004Su-9W
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:03:25 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyNmD-0005jY-Ra
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:03:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3811f512167so4232302a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787551398; x=1788156198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnosYV9fBX0MrYj+g4xU0hjD+hBe4GG2oxX4u/74ANg=;
 b=Xbb1SzK7PeDLAsH4GnrYWouN7szMYpe5QUSDsDx8UQoi+1V2hn1tpHOV0DebrTjyxh
 oD+fDSWs3r4nfdpx3wkH3wN+EGUrcj1fgHCVOkL7VQTROzUQCxR9p6VhWujynL5o3YDd
 WOVOrX0ZUGfm/FH6uyfQ1WbjtwUce6sL/fYPKKDhjZlXsAZ/rACvFnxifpw/1q1LikCB
 a/a533AJGYzkv9FxRpuua1C7jiMzI2Ojdywq/Z5ydB9k5pm07mW72QbvRaoMx+lobsR0
 2fsHJVYdUQ6b7maK3HdrcxYPTl71WuGD3+hvKkLd/T6B3K56HPafOUws5jaOzlBSJCz8
 q6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551398; x=1788156198;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZnosYV9fBX0MrYj+g4xU0hjD+hBe4GG2oxX4u/74ANg=;
 b=KwvTuS26XkKzXgRd6TMZZYIT1Fy07YX2h/5hf2KNIsDHpbnY+ZSMqdEgE7yXrAO28R
 8IY76Qo8Wu2sXrwE5GunYkmnYEWa/woXZ+uDZtH2HmZbw9DOVU/msG9qi5reaO0Ap6ck
 ZwtyNZzAyCxnkzo6tUrqc2iL2Kq3apM4GviEahbH07o/aO3VRwXaP+SJ70o8xIIzqw4g
 Qc0CikGFl5hamDnv1YKa37/wDM4XqkGYLKjV38o1aDjQh0cf3Mt70b2+z2a+OSe68Xup
 9pERLCevoShRIabCFJikrSiaup/Uu6UXEf9lNDexiVcPz+Y2x7wnB64+z86cbbpjzEty
 0mQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox0bDsrI5fdHC1IYBlls3OU0VY3FlJ/pIhSkYaGoT4lnaToNXmCm0Twa2/aB60zi3IwFpR4Cs+3Xr0@nongnu.org
X-Gm-Message-State: AFuF++kw1ARGnFcEI0piG0vjkAyoosJUDPEpOkNLm2ajc7r9JYxxPGRQ
 mE7fVVJNGlVxkQuG2nbU7o6pqhJ+u0rnj78waq++8GN6Dr91Z5uoD2PdGNqWtBgMpGlYERF3IXA
 MbM0n
X-Gm-Gg: AR+sD11qFNjxXw9y4gJ77j5hRua5t6aNSXQxrir5pg/Tv6kd9fDNCYJDejOp9NhpX23
 10Ze5+uu5WJO0AI+y1wYSjslWGfyw1/CS2fXIiCvELoveaQ0PpESpGx5ZoZY7AaJqHS19azIpX0
 DjV1pykCkpT9unAT3mBfBzrCt62uN42AlOc9lUmoSis5sQ/MMDHwQRMy0nlX47jSuEoS5oQOsWk
 Zxg23SD98n6cRdU/Uf2K5kgn5A40mt1T81NI1Cc4cDMVBVv3OIWfkGflciNwcOk6XMpllOAZXvT
 QQ0x9lbqs9RhA0F/id+JKhUj8FXhlQQnIaLyXCJQGXksQGObsz4nFPo/yPzwj1NCf9XBo+3l0nq
 nI8MLWM0wKAjRYN+CP5v9H5ZCkLvWeOEBBCkSc4qk63H1tNUbcyHQa0UdIySxdEfH6erD3ChPFk
 PEJE/JCWg0QSFUAqC08zJRoJHTXf72BUNP9yat50xzJ1gykIhc4Pk6Xkc3QTDkuDm98bxvEURH1
 ttYej6Uw/EzYaz8iA==
X-Received: by 2002:a17:90b:3142:b0:37f:e177:f58 with SMTP id
 98e67ed59e1d1-395c35e27c2mr40877133a91.9.1787551398100; 
 Sun, 23 Aug 2026 23:03:18 -0700 (PDT)
Received: from [192.168.72.187] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e49b4094sm9504550a91.5.2026.08.23.23.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 23:03:17 -0700 (PDT)
Message-ID: <7144766f-4c2a-4bc1-b3f3-d1022a43780d@linaro.org>
Date: Sun, 23 Aug 2026 23:03:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] ppc-for-11.2 queue
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20260823073536.40282-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260823073536.40282-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/23/26 00:35, Harsh Prateek Bora wrote:
> The following changes since commit eea8fe61b8be8f3016e522e6af24924a0266ca95:
> 
>    Merge tag 'igvm-20260821-pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2026-08-21 10:39:31 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-20260823
> 
> for you to fetch changes up to 45caf67b9a6a446629e1c133b76a3d9a3cebdcf1:
> 
>    MAINTAINERS: add self as reviewer for PowerPC RAS (2026-08-23 11:42:57 +0530)
> 
> ----------------------------------------------------------------
> PPC PR for 11.2 - 20260823
> 
> * powernv: boot OpenBSD on POWER9
> * Misc fixes in target/ppc and spapr_watchdog
> * MAINTAINERS: adding reviewers - Amit (PPC KVM, sPAPR) and Shivang (PPC RAS)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

