Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2EBE8383E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Y4-0005NA-NI; Mon, 16 Feb 2026 16:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs6Y2-0005Le-0i
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:54:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs6Y0-00012G-Ft
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:54:29 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a77c1d5c3bso13057315ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771278867; x=1771883667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UM7LVJsxFSpRtd6bXwqCb/fv8D0/2eLsi9HRM+BQdMU=;
 b=us/DTvqRp/x+ZrtSRbXA7zQjl3miz7tytMcar726WxBR1Hb6YkfkGTMjsxwmhC/TAg
 PnD16amW4xLJiHyf6CUIZaU40+do+eqFlPqsn3AGXpFqwI40rAHmff9oWsmgJmPMddMu
 c0O48YqCm3HBUxWHCiRG12tBLVzVx2aoLasl+vQySVSk+3UNTmcJo/sFZNBuK6HZ+JRL
 u0yHIT3nggN5H9DY3giXbOSJGn3MeCjhh+fztcWNfV3enK9CmZyT7vFBar7uW6keWPTr
 Pv2UpQO28azJ0eYm7ax/THpiWaexGutr+dB2v+8OHhI7Pgrgw4psTteYyYNaNUVZDySg
 4pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278867; x=1771883667;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UM7LVJsxFSpRtd6bXwqCb/fv8D0/2eLsi9HRM+BQdMU=;
 b=mEm7CASyayWqiCwkHCMgW32Y7g31wTVIPKEudxdqKArTR5MRcIfbYcgBqCiVSNW28+
 4zA6iRDLIaS8UM+nRdhY0393f1+8z/dnpGodA93NeS3e9Gbnv9bkRZBFLpeL8XqG3dkt
 F3hAb3VuD5HHwjsSsbQ2yedH+gUxVtg7YFMcSvNf2vHSQ2KidNU+aWNTOVBjJUqZTKK/
 p/M3SHgzUOHGQwZPcJAGeC4gAJHyggR9XJUCYZ1n7w0tW/msnQO5Z/6axJTdhHuXA1Is
 vW1VNq9Wo1Zms1lEjtIydFv7JsI/HVSTwJTyiQAZeyB34ddP/OIXQGragyz7597cqEKp
 2koA==
X-Gm-Message-State: AOJu0YyGNhuX4R75eWsSdgjm2zsFJ8V8ZnhDFQ9kRwiyeslreQBBwDc4
 B3LUANAvn3fAzTz9bdG8jsLajyclWjlxN3WU+BLomY3vvG9i+Yd4KQtKnxta4Rn+4hdxZP/qwoN
 mmZQq
X-Gm-Gg: AZuq6aJ8CCTUeflnGJWBZXaj7AKryso+qShRyD9p0dIet9ahdHeTOGx7JiKKfH/TcBt
 Pg6BbeiKvuzyYXGLcMe/3mdRMo0g3UYsdOrGs8RIzbMi+UqLqil79JBBeDl1+PRhHvR35riFwdE
 uvAVIVlLa+FAFJ5jfxhoiiICodurhUMfXrLvwOmnauzrY1R0dtaWm7yCHAJL6p8GSYcCCXLhA6y
 wvyAgcXuQc9z0qYPNE2iHpaQOIHzYS2GZ284SU7ec5BGOveCY6oWYJNEDWwzRk7AibEg9FuZoOL
 WJVqRPdFzaf97HrP5yabc/gv3WaywujJ40JXHIUU0pGqrAiCt2LoW9yA0jrl9vuj9dBrvrVqsJE
 RMTd3cvYVd8feoh6CKHwrM/XbvgVpXNE1rSgUh8HB5G0rovWTyihy7bHAF8k9eReTbXxoWYq57d
 wr9rX8vLwHsremvaVRzC6cGnQlfDPqskCtZKm1LZbITDVc2HyL3WjfLArh8x4ZnnnSA19bW+G+N
 i6ELWIkhMsFXTfscpXhNsKC
X-Received: by 2002:a17:903:183:b0:2a0:fb1c:144c with SMTP id
 d9443c01a7336-2ab504d5ae8mr137048875ad.5.1771278866634; 
 Mon, 16 Feb 2026 13:54:26 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1e87:e093:79fa:89a7?
 ([2401:d002:dc0f:2100:1e87:e093:79fa:89a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6f9ae9sm74328285ad.16.2026.02.16.13.54.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 13:54:26 -0800 (PST)
Message-ID: <05f4ea1c-bc5c-439c-a190-40a3b5e3fcf4@linaro.org>
Date: Tue, 17 Feb 2026 07:54:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Don't use HELPER_H in non-tcg files
To: qemu-devel@nongnu.org
References: <20260216160349.3079657-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216160349.3079657-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/17/26 02:03, Peter Maydell wrote:
> This patchset gets rid of a couple of uses of HELPER_H to pull in the
> TCG helper function prototypes in files that aren't in
> target/arm/tcg:
> 
>   - debug_helper.c has a lot of TCG only code that can
>     happily live in a new tcg/debug.c file instead, and only
>     the CONFIG_TCG code was using the helper prototypes
>   - helper.c was calling exactly one TCG helper function
>     directly, and can be made to call a different function
>     instead for the same effect
> 
> Pierrick: these might be helpful for you with getting the target/arm
> single-binary series to compile when TCG is disabled.  I think it
> might be best to avoid having a single helper.h that gives both the
> helper_foo and the gen_helper_foo prototypes, though: even if it
> doesn't cause compilation failures, only translate*.c need all the
> inline definitions of gen_helper_foo. If you take that approach
> then it would fix the compile errors without needing these patches.
> 
> (I did wonder if we could move target/arm/helper.h into the
> tcg/ subdirectory, since it really is TCG-specific, but it looks
> like the machinery in include/exec/helper* assumes that the target
> has a helper.h in its top level directory.)
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    target/arm: Move TCG-specific code out of debug_helper.c
>    target/arm: Don't require helper prototypes in helper.c
> 
>   target/arm/debug_helper.c                  | 769 ---------------------
>   target/arm/helper.c                        |   5 +-
>   target/arm/{debug_helper.c => tcg/debug.c} | 542 +--------------
>   target/arm/tcg/meson.build                 |   2 +
>   4 files changed, 4 insertions(+), 1314 deletions(-)
>   copy target/arm/{debug_helper.c => tcg/debug.c} (53%)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

