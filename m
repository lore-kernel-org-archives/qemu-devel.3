Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C75C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x04qy-0007tq-B8; Fri, 28 Aug 2026 18:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04qw-0007tL-Lx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:15:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04qv-0000IW-0F
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:15:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1625403a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787955312; x=1788560112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=36ii43Ol0ZFQwf247LxQrRpEfIVtYkFcZrFxznWA5a8=;
 b=M4AF9AmN+lh2/bbOhbPXtzePkMGq6JyuITxupBvhORKmJjGq773+qI5qfAPsJZ/5+R
 i+rnZDw49ojwyaE5sqpYcEiUAXgRtc/VWLC1HCxgOUjFJZe2IhP9U3H3EP0aqd4UclNc
 r9rJ5r4P5f7LwpLp5/r+pjXII5pt4PQE+/7rfmW6wGdLg2WtBOy2AAuYt4F1ypRF5TJk
 aWXIWXMifwutw2W9PjolT8F6ydSM3Bs6i6U2gGOrjRHYXaHN8Wg7VDlycqTS14iEeVEl
 M7IR3kaBbHsNUdwq9Ksb4lJJ++YsCv/XLvP62qemXhETUt29VUoukjdi4DeqZnFRSTa8
 M/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787955312; x=1788560112;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36ii43Ol0ZFQwf247LxQrRpEfIVtYkFcZrFxznWA5a8=;
 b=r67QTofSKnsi/px3nIvheH5t71vJ8cu+YZ51v78tJ2W82Ppzt2B3RiIlRz8Q4gy6i0
 J2JQPwfF/VoN1UqrR8qB1Rxptgb27F+BEuisqaJ28TEaQTg+bUHz6sieYrVSk3meSa54
 f8MNtW0ygTQyhBWZlo2LdibFzmwvLdKZKvTVS+mOF2SbRIqW2/bYvpgpYk7E+eECYmKI
 VXb8BB10HOciaQmHbi8p9GXHCZpfvsEQjc/eNoxDVGyMnTeznN9jXEgrAeDUagghe/BA
 gZhCjrj0ypnrom28A8+qpjZ41TjkjAGyIjkm2uyXDHXQJbOMihofzkRvjZRxXaygU/jQ
 zi1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBympyCiHZQ3AMTQKU/mf+SAyX8i6LCqhu0pWDVt5VvbH1dwK5/YuUo6aIz6UARkbcGPyluUz09419wg@nongnu.org
X-Gm-Message-State: AFuF++m319/yIgpFhyr47GGa930Oc+5ABrATbqFQh5BCZGBUYOo8TRCr
 tvXVXraFcu71wtFGC9aahPzzi1ReZfKVbkeDSceyAedDGJBZYJnb/i7IoclyTs5QfvQ=
X-Gm-Gg: AYBFou0219vRf2Fss1XFNOwWAxRIPRfZw/IkcBXVSI2bVXfOOzTJQIYhKRFxN/DY17H
 p8tdd//Ak1WzTOtClr2B72kl7surIATHCuasDm12JzVreRFuaynhsqXSYeTTaY0sB8euinb3soF
 8UM9d4EB8xR3OkChrjOg3ZPEiP8JniUU3JAIIaRAXLOmKl7DRNsL8J4sfebiXfRWQeRiwhFAZdR
 460w5BMnZIp/xKZAYY3ypbKk/Iv465GfTFpDswaIKKQl3jJVjDbq67Lq5PwR/oRI1njSX32cZzQ
 bIuSE4zvtu4bZBgAMWRd7n5oFbbXJe3WRXfqBpn026zwu2JmWtAFwHHkJmy89GRzujPC6kZgb8G
 8I+AdBSjeed2A743RsIzdBpMTyQ2kqzvMRZoD6/P7fEJZBI3CEdmef3zpvuE1nMLjUYsX6XDnIV
 ZOgZMGMImOMDwjBMjMbXBNbHfOWjPUi1tA48kb4ZJhMG3G9k/OW7CGrPMRxCX33Klia7Abhrv3+
 qJLnyP906zsSiCqXMIzKbTGX9782jI=
X-Received: by 2002:a17:90b:1dcd:b0:398:9be5:b416 with SMTP id
 98e67ed59e1d1-3989be5b4f8mr4104468a91.17.1787955311558; 
 Fri, 28 Aug 2026 15:15:11 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd0079sm9092120a91.5.2026.08.28.15.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 15:15:11 -0700 (PDT)
Message-ID: <838b1d64-fe70-4aa0-8a71-d276240db3b4@linaro.org>
Date: Fri, 28 Aug 2026 15:15:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/30] Migration patches for 2026-08-28
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260828155845.2874508-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 8/28/26 08:58, Fabiano Rosas wrote:
> The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:
> 
>    tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/migration-20260828-pull-request
> 
> for you to fetch changes up to 96e7412cd5581edf6bd3b966afa3abeb53b5a6a9:
> 
>    migration/postcopy: fix page_requested leak for vhost-user shared pages (2026-08-28 09:09:32 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - New feature: Fast Snapshot Load
> - Cleanups and hardening of RDMA code
> - Cleanups and hardening of vmstate code
> - Fix for vhost-user postcopy hang
> - Fix for CVE-2026-6426

Applied, thanks.

r~

