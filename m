Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959C4C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTiw-0003pf-T8; Tue, 04 Mar 2025 09:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpTii-0003lS-7F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:58:11 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpTig-00008T-9P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:58:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so26470565e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741100284; x=1741705084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrQ4Tubmr97IIFk7uuXTlrc2UQCvR3jWexkewFvyPaQ=;
 b=hj/2Wo/Cy8w7MOwVl17/u1lqUpXXim87CznhCFzCM/8kivuk4uA1/UZ1C2qZoUzmMx
 Ccn/yo29wq8QLCpKFMLn9W2AsCq5MWHtrbeY4wyz05nmg2DvuihzbuFcXhVN1mvSxHk/
 9QS3Zl9wyuRJQR0CES0X2P/IGB0mA/xdMO29rdBh/cx38VcatLdeUQgGHxk4a/u807wN
 B7yDGBaaTn79VGWFD+M7aRO+CWChHGCTyO4Gxxn4NFV3s66WT0j2csp/c1nbTyapcg/Z
 qhLbClEqBQ1vdTJbO6BzvtVBZrx0SPCT4jRjvZW46jP0/aYhc+37F/hJma/M1myoJFGM
 BTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741100284; x=1741705084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrQ4Tubmr97IIFk7uuXTlrc2UQCvR3jWexkewFvyPaQ=;
 b=CPw0KyovMF85kDpbh3FqEJEvTVeay8pY0ihR2HTj9wKh7Sj9JmH4sWtf+4PIImilwv
 e6VFiwDdtthGBQTbhadWVvFBE1MBywq5txUz47fafZrJ8OazUAtdll9rvr9oDyRn0QtV
 e1XckTTWXtwbrsg8eWLUWaR+I3ee0R0IjLob9QGlGegvhBFd5tPTvxl+KioGEAcSfA1g
 3ugUJI0wXnemr41uilJ4AP57S+xuGtCAk/sbvzkEqI4RiGmqzvg36GKUEDDsUWuBxjnC
 rEGaLDqonB0q7tL+eGVykPhJn0hVD4T63PFwIf7Qd1/kGLxybxj16gZFdLaZ9JN0AvM6
 2NRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjCoPQI9pHMwqS1ualQFjdUBlBBe7NwGj5OPU8XWB1CEOZdsASnxvxIZeqcyKWOD4pYbyloY8ICFAb@nongnu.org
X-Gm-Message-State: AOJu0Yy0EJRJ8WojXf7weOUa1tjITbCn1+6/q9Jw24TSZlM3j/JQ+OfW
 mmXudtPzzN42WLr8almiFLrwTm/G2D4BJcYOTh6emFRSUCfzcZA58Chh4ep+DTA=
X-Gm-Gg: ASbGncvEencBafvfg37LHeWzhec3dGwewY7y/QXts7uHEp270iAlY2eZ6Ep8EX1VCB2
 3Va+DwiICLtOkyRRgZ+YXwOZuJZNFzLYU0ZlmFZj2j6KOPHXubGQEdjX72FAkzb7YzukosKCO69
 zUqXV0Gwm8yjj9yU0jQyQha+OTT4dFlaozpXXyfwTZXs7GmK7J/KY2n+3d00PCyUYFP3nhkPany
 UuITqk7O+K5E/hJNlXGGcHcCJHTDDhLxD2n1celhH4LfNP3MimakpOorOO2THg1ITjQQiD73kzi
 eGIfSMX2Wbcdfk8/CRm/3VR3IkG2wIjEIKUYVJq2SCEJ4drOoa6OB4l5ErwntNldNLlqzKccXtK
 fKcCHtYiBdIfZ
X-Google-Smtp-Source: AGHT+IGbxSRjEVR+T3OfLQwdseH4MPQ6Rv9Q71Wo3ED9lZFyvctZQyUP70sL+95HBXt4tDvTpTck1g==
X-Received: by 2002:a05:600c:1c8c:b0:439:9f97:7d5b with SMTP id
 5b1f17b1804b1-43ba674cb46mr167898515e9.23.1741100283958; 
 Tue, 04 Mar 2025 06:58:03 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc280e55sm10129335e9.3.2025.03.04.06.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 06:58:03 -0800 (PST)
Message-ID: <7e98d6b9-c17c-48e0-9513-e8c45b29a52e@linaro.org>
Date: Tue, 4 Mar 2025 15:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] ufs queue
To: stefanha@redhat.com
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, farosas@suse.de, lvivier@redhat.com,
 Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
References: <cover.1739784105.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1739784105.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Stefan,

On 17/2/25 10:27, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
> 
> The following changes since commit db7aa99ef894e88fc5eedf02ca2579b8c344b2ec:
> 
>    Merge tag 'hw-misc-20250216' of https://github.com/philmd/qemu into staging (2025-02-16 20:48:06 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20250217
> 
> for you to fetch changes up to a54596a96006096798b172a368ae952a231f9f72:
> 
>    tests/qtest/ufs-test: Add test code for MCQ functionality (2025-02-17 18:20:53 +0900)
> 
> ----------------------------------------------------------------
> ufs updates for MCQ testing
> 
> - Remove unused task management request code
> - Implement bitmap-based command descriptor slot allocation for MCQ
> - Add test cases for MCQ initialization and basic read/write operations
> - Fix LSDBS value for legacy single doorbell mode
> 
> ----------------------------------------------------------------
> Jeuk Kim (4):
>        hw/ufs: Fix legacy single doorbell support bit
>        tests/qtest/ufs-test: Cleanup unused code
>        tests/qtest/ufs-test: Prepare for MCQ test
>        tests/qtest/ufs-test: Add test code for MCQ functionality

Just wondering if this PR is on your list or there is a problem
with it...

Regards,

Phil.


