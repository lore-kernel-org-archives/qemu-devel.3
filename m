Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D7C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wC1-0000fD-Vm; Fri, 11 Sep 2026 04:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4wC0-0000el-12
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:01:04 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4wBx-0004FW-Uw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:01:03 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1254744a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789113660; x=1789718460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDyZwRcpTAvhH9c4j5ZWCLJdkWNfuQXCdQveVUdWoaU=;
 b=ebYk/HJ/sFwSBCS5ihqOwqvHIsGFNBmrHu1rXzRAKzWT/pIMSb7mriqD0D1kGqd88f
 BLvMyuyKOw0a/MZou0B2n6mtqqm5rlrTWgLdNIPXlfhDcOiHU6x5TJ9ujTSQmGM3RE6G
 E1zRB93jjtvmXH0YDT/X4XmCKsoYTp8bhpZG24jZTYTU8rzlp3hHO8+2zR/ck1MrDo10
 AOnuFHSob5BFmXTE3MzQqQbBqTpJKE9mUF350N4ueuYY3QgP+sm3rWivlLKX2Y4DJkXu
 Hn6WHw5PzRIQ57YtXOc1xV5T+nVqq9nBPCiKwsOK3BIdGJ4RuD/Wy4yesu+3gxybJxDT
 w+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789113660; x=1789718460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gDyZwRcpTAvhH9c4j5ZWCLJdkWNfuQXCdQveVUdWoaU=;
 b=WrqvzEj1TCwnuCb8ouH20mc4g8UoVsa+Wj4+0otZHaH5Qn5Tdv7WjaGNHvSWPPCJrJ
 gVC0RZCTeaFIPkSAuQwoRB0tSZ1WbpS4ggMjW1ooXAvXjANHWNlM8kcLt4xpBsaVNpu+
 glgqS/hoidcYIP2Mdvi+qyed78RWx82a2khFNZrCwMUasp1SwUN6LKIPjMHtGdhmEhj0
 mSQbkf3SG8qcqBrFdflSp5cjvqbF4YminZVDFoPSF+ejnIQ2YBHAVwW8srgjXc+KUCZ6
 SMKG5DYuFoXpZAp9RZtSWLn7BtxzPq0ZS0uGcFWsMARL/TLWTV6kYGUMkL08NRtS880W
 f6NA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf0HRnWqVYp1ZW4WLCo6OFnkqlZE582/U2F7MXLGrdsevhlQD1U/OwsmjkBnMUsifQG5PMmWWKcwrW@nongnu.org
X-Gm-Message-State: AFuF++kPVLxb+6m/xssNJy2xbsiwr73X3k8Py8MBJAiWwOAcEXlmEUMw
 9eoCIX//tCHIsNhViTKeNL+b5Rpx2/uYxslpfgDBQw3GLjYwo/4A8Wv3jUcOv4wxtH0=
X-Gm-Gg: AYBFou3ZNsYIVZKnHYDwV0avS9ERFe8QWiZInNYO81PBrrN5M4MHJVbbyC5Gfo8b4rY
 4Lb5/B/3VBJhQmWPJa2c4/zSUNGAmm6mh1kGV2SIGTePLxC2lv1NtP56alFwv5n66QXoCb1WYKe
 T/Fw4D0oLLgwKdo8uI4oSYcMCelAkPqK0IjW/wOH3TesjdkuNRA2XXnSwUiGhH8jQ2rfPRTgx0X
 lcUw6TXvDsdqp/0/5wL7rfeNAvN49UuajaglxELIhahi5rVH4xC14A3YDJO2FFzO8ytSxIKSvAo
 Fr7BfVEUSn/pTYRJaqErwtq6RqHqUD9gHPoMRHhoP+3B3wNi10tHqmPZ12IQgPU2A9TpfyCAa7j
 le+uJX9FmVuxJGDGelkTBpIjna1kZF2tsHOkk6TLj9soSN9lxWqkTFCrqyDXYOmGTONffnADlW+
 Oq15XE+wCuvYRtrDq4O8qkWI7E70pz+InfTa1YEDhH9bHyfgToM4Hq/lEuU1GZwS6ohIAI5bTlV
 UwyUZ+CAmY6eDFI8gF4XqNOa3TjcUBdOpeYAWrqwhw3ygm3T3hLcgiD1x1ZPddLvyk2sA==
X-Received: by 2002:a17:90a:d445:b0:398:c6e1:dceb with SMTP id
 98e67ed59e1d1-39d77962e7emr10478651a91.9.1789113659904; 
 Fri, 11 Sep 2026 01:00:59 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bac1c716csm2790137eec.2.2026.09.11.01.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 01:00:59 -0700 (PDT)
Message-ID: <66a73bd2-59b0-4be8-ba2c-eee5eaf1924f@linaro.org>
Date: Thu, 10 Sep 2026 22:00:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Linux user patches
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260910192545.768850-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 9/10/26 09:25, Helge Deller wrote:
> The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
> 
>    Merge tag 'qom-qapi-pr-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request
> 
> for you to fetch changes up to f67617fc82b32022901cc4d566caad618f945611:
> 
>    linux-user/x86_64: write the floating-point registers to a core dump (2026-09-10 21:16:34 +0200)
> 
> ----------------------------------------------------------------
> linux-user pull request
> 
> - madvise fixes
> - fix sigcontext on x86 to show correct trap number
> - add hexagon HWCAP support
> - add FP registers in coredump on x86

Applied, thanks.

r~

