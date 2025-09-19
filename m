Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864FDCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzagw-0000KK-Rk; Fri, 19 Sep 2025 08:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzagr-0000Hv-2f
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:58:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzagk-0006rT-3a
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:58:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f0e9bd80fso243322b3a.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758286685; x=1758891485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXn99MGWd6AaOoJzMw0D1Q95rFV46OcDMATEU/iCx/s=;
 b=bfAteKh04DEMJymsLsjq5SZMPwSL2L9h92YOug4ircW0D9rV+WU43HInBZzJC6mTTL
 OPimQz8nAKWWy38Wqq7Vkqa305vKeyEsuQqtUu+wG1iho1wqqhW35X7qjZyFHJX796nI
 Xrpl7pCDolpfM0nZ036WyMzNqc+2urg1C89MX4vB6nT7bScCikqpa49pcfUrKweSlOOf
 RfMS/G/AX0oyjN6t1ZhqCUbInutDOIYRqLN1As17AUkrq3FEVTlCkULKyEtiS8IvpXNH
 jyTY1/ahLe3V6nzFwt7QIJbnOW3xPUO7pKofO3HSG4hIk3ZrlGQcM60GBT6YFUVvQjjn
 MP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758286685; x=1758891485;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JXn99MGWd6AaOoJzMw0D1Q95rFV46OcDMATEU/iCx/s=;
 b=ubcgwJTjzuDPgrecyFPiCJj6A/CzUR8xQ3/sMovy3M8SGO5HtFQJAAhSIynvD1pKFZ
 E2FVbIHGU1gPt1RcZDEjWaA14Yzd2Qfcwlf4GKz2ZpqyrZMgD5KYFi/ResfLZ+hoUAsF
 VNQSPY4sj4djcw5cJ4s1AnsFfAuPMwMqbLIOfFrm9XRyoBhfPO7OqkfYp/41IPcanf7g
 TzcMglzeOMViK2UQPEN6iG4qLITXwJitbAnr0NIbUx3dE+TYtAQ4+pafARAKH/GKcuBZ
 02tUVejkNFAUvs3KTKyH6zrp6DpFV39plUJW3U0yH57dK1LYj7BSFsqtw9GgcfD8+Vjn
 21Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTJUEoQtesx4Uss00YRYK7J+lG9WZ4NRF1iQ5lPzTGnNfR+p9wldghdyBDOaEErEBrbIgF3TM4Ou28@nongnu.org
X-Gm-Message-State: AOJu0Yy6KjibMlFoGBeu3ZVM+8uL+7vgFbofZxgpnJI8sCu5ARpeDZOx
 fvv0NxyIQBBafZoPlcoNePadH06f1dMM8Ycetgc5vxhg6dQ0I9EeaXpjw0WpyLbGZn2rExtpPN8
 mjCxO
X-Gm-Gg: ASbGnct6KiEDJpn/GSY5IX44hfvcp1q6OI0fckZdmvsSPss+RCT9sGqv5odj/iJ6AHt
 skrpPo3n2l7Ng8iaBAjdMDSqdGtiMoI5uwWHTikAnIoZJ4Qgd+/WMzOJhYbLgOpyDiU9qMY/PzL
 IIy0nH6i+ZESW/UVscO6CdFBMRFbQld7by6P0wRuddkLU9u7+qk48BOscMoxqCWDmV2z2fHT9nB
 xZa9d9Ex38bWAVLWaXtj1zIsnVtBWcuD6e76H+hujDD4xSCc2cMfIyyB8efeJ33sRJUdmeP0+OA
 nsEqOrvD5TK8fG82CsA6Kmfx8UQJMNB1Cn20FaiuB49FjdTbXfyQR6a9rIGSI7sGke1D7cgFGCA
 Qcler7B3kp2tBPg00SvaDNKKp+Y+yaJ7zcR/nEBQ5EzSRMXs=
X-Google-Smtp-Source: AGHT+IHcJMxwwCSg+0Z96mszqkYvThAfErY7jolcLT5uSBqe08wE71OJwzshXthma0ydebVrEJdwbQ==
X-Received: by 2002:a05:6a20:9392:b0:246:9192:2775 with SMTP id
 adf61e73a8af0-29272b53c3fmr5278019637.46.1758286685353; 
 Fri, 19 Sep 2025 05:58:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b551f98aff6sm1556424a12.9.2025.09.19.05.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 05:58:04 -0700 (PDT)
Message-ID: <927a909c-824e-4c0f-86db-b34c94fa75fa@linaro.org>
Date: Fri, 19 Sep 2025 05:58:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] linux-user: Add syscall dispatch support
To: Arusekk <floss@arusekk.pl>, qemu-devel@nongnu.org
References: <20250904102311.57383-1-richard.henderson@linaro.org>
 <cab5b519-fc2e-4560-9dca-64effbda428a@arusekk.pl>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cab5b519-fc2e-4560-9dca-64effbda428a@arusekk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 9/19/25 00:54, Arusekk wrote:
> By the way, I wonder - why are the VDSO blobs included? Is it for reproducibility/stability?

Not all hosts have cross-compilers available.  We have them for x86_64, with docker 
enabled, but not other hosts.


r~

