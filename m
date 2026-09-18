Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95655C982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7NEU-0005GM-VN; Thu, 17 Sep 2026 21:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7NES-0005GB-T5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:17:40 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7NER-0005yl-Cs
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:17:40 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea34ef4so133522a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789694257; x=1790299057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xOkOX7kE703GIbeIZS6QTAYQ5+YUQih3IxYL3qOn9QA=;
 b=vRubSpsP6IkugS0qMafbCE/ITw3o6WRIhgD9TXStRrgJEgjy+lIHGLgxzQt6XvqOUf
 08ir5EyYYnjPQMe7k/5HbzYa5Xhj6NTbDBgPDyjyPijheFhc2uCQF00vsagshDkRtsfU
 wHGspPYJokq10yxtGI7lv200Nxbw+O/JlJGrYUi5/tCoOC/bQ5yDb/4EUEj7MOi5Lor7
 BRshrl8XX2MXkRW8DZ58DVx4iKhDBjaWI/7QEdoa8D8LmF72+nBWT+Vl1hCSlBgE715J
 Xe05l4HceCgSwmsBTQVjIwrd5J2GZgXH0jGBoJj8u/wIW2QT09wW1kkMtOT2KCjUuDp+
 ke/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789694257; x=1790299057;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xOkOX7kE703GIbeIZS6QTAYQ5+YUQih3IxYL3qOn9QA=;
 b=u39OEzwnftGygxk/0lS6LS0Bx58tjd/uoTGzwXa+f+jJ4uV5+dGFXJAOlO4wZxGaM4
 SGjSN7aObnqt8dNGfa3rVOc0c9ZalCq3i/mhnqPykUy8mcJBVCxkBBn7okeqoZYOXAUQ
 fxKPx+IpPE9jO+2Phv3h4XlQgaTPw3w/ZtDR62QX6n2tjmSTDkoWlyYyn53FiDMNZ7rs
 iSwKr1/Wl3Fy0qUc7QdxINd91S1MB57kUpUPebkYcpcbC8svTJIt4eW3CUZDfx12ccjx
 wzc9zhv/Fbzw9Iz+pvsbWbikBAINs/jcTHEC0ru6kV3Qv1p637FdKbuxzJ2DpwEQLso+
 rqjA==
X-Gm-Message-State: AFuF++lebOZ0EQ1c9/zEDeWBqDMwGwBmDaP9Y5WEJMpZmbbXj7vQFLdR
 XeHTebtBFlKrIlouRRmIffGg3JZO7K668jGgsCa/MzpMb8Y5M6+Nhd0yzuS4SSgPAF5o1eHpBcB
 iErZJNtI=
X-Gm-Gg: AYBFou0hibxOKD7NUlBgZyk/7hmP+D6xBUZkO1gwdHSWsf2Sdtr+ByYOV3pmmVTKVzt
 N4XVN4B5iLr71yPs/7Rm6OHSHNnbuJy+7GsETnWnWf6tuu6DviThxT9qtIPCiZM4jjr/V5iwGu1
 mwPQHR0Dsxt2auViXUZie9pfhz7snUPgMUiNKZ6pYthzrzfql/nywDOTLl3wDz9PtMYe8J3rBoW
 arG3Ucrbe824gBDEkv7/tfl9ZLC1OMjxN3iwn1gJ5UjkaC9KNuPTvYVxy9zqozCP8aJ93v2JU6N
 oxq/VFZekZ9ZRGxeDAd1VERpBTsb/IHAlbaxBL5AeGI8faRZbCvQVICcayK92YfbIeJDJl01yst
 9pkL4d+VRv7Z2C1Ug2MMj5J3JJ60gE5aJX92snngC4jgXoq1RNo+81D8EaLlRGCvn/I55iK97B9
 jbkoxUsVcn2Hx+pJEW2bLMC13CCCRbWOburE9Poxxk77hFMUKxVdVXmhac74UntfJExrIV52yl+
 a+rMgZ9mw5Ry0Uc8jo85ZbkBvbUhjjqh+BLsO1aG1eeH0ZA737pQovtCuw5cg==
X-Received: by 2002:a17:90b:50c6:b0:39d:e213:9dd3 with SMTP id
 98e67ed59e1d1-39e54cc62d2mr2140621a91.1.1789694257150; 
 Thu, 17 Sep 2026 18:17:37 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:83aa:9d68:3956:350a?
 ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144cdfc2346sm459900c88.4.2026.09.17.18.17.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 18:17:36 -0700 (PDT)
Message-ID: <b84e40b1-fa40-42ac-8868-443c86d8bff1@linaro.org>
Date: Thu, 17 Sep 2026 15:17:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] target/s390x/tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260917213749.36756-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/17/26 11:37, Richard Henderson wrote:
> The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:
> 
>    Merge tag 'pull-loongarch-20260917' ofhttps://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-s390x-20260917
> 
> for you to fetch changes up to 38efe3f4978b9b5e90f88c3c6d0f44b84d3e03a3:
> 
>    tests/tcg/s390x: Test LOAD and STORE REVERSED (2026-09-17 11:33:53 -1000)
> 
> ----------------------------------------------------------------
> target/s390x/tcg: Clean up mem ops and byte swapping

Applied, thanks.

r~

