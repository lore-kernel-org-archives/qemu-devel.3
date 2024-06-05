Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B171C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElBD-0006AJ-Ud; Wed, 05 Jun 2024 03:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElBC-00069H-8s
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:35:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElBA-00077k-KW
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:35:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35e4be5bd7fso3863027f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717572927; x=1718177727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+OsAzN/z+dnIk9OqPxXNxjUgEK1m8xMEAnTjIAhA1Lo=;
 b=eOWzNj68eJIpVrAI/L8dnR9Rl30wKn7yAnddGme6PEKjNkgrxD09gV3jIz6Snx4vEo
 YlcZsNZFTreO4VQqO96q9NflsSmegvdR7+qDo75LpX+oiNwREWQeWDKsdlM2oWRzfEZX
 S8vSj6JDFqTGHOm+dwUbK1a2jL79cTVjgj+wQROrew71j/T6CD2/uc+hbx607iypgoaf
 1PVfZ7qFvgV0g0v68N2ut6WmO+tj+1wDdCe5jnRVd61uz3lNKTp0ph6ynfk3iNeS8fZa
 tJOVPNXLYjef6GVFyzVAaSI0zxqX3Px0hUowdcq4Fb9CpuV+JxRU6RqljQRTywdS8JF0
 RTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572927; x=1718177727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+OsAzN/z+dnIk9OqPxXNxjUgEK1m8xMEAnTjIAhA1Lo=;
 b=mi12QGidbWxjpInFi1/iuLLUSjshwG7AKJMMDlSeyUHvWzaXyrpAQ8XJV2eqeWKFxt
 XTeypI0FSVeKVIRXKfeOKrSHSlafWmO+tDVYdiVcEQYsFq+YLJHpaTCAqMs8I3aHnz3i
 xk4fDcaoN/1yzKhSD4fKZwFSBNAw85Z56QsU5mFrT/jYDVizc5Uu1GcyuqyEgx0gpBF3
 xAi1Dr1Zm9dY2lqtEc+3VGADLMwUyGp4wJbaq+JpOWFEp1AUhjyCLnhhi2aN726eSbVD
 0VE3NoqcCqyk7Yg8bEOZaSS8GZILO+a7PCLsdx/adlAlXBpMjpZgvSTQKD37/7ce4WC2
 17Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFbE2+x190vBXg7fLzeIFsi6QRmyy2rRBr88N4rmfnFZrMvk2LuWuMLGMZ06eLT6cuzu4XZtXFyge5Aci1QDxzulBIXxY=
X-Gm-Message-State: AOJu0YxCB+an73XRnvXk5k5epZC9Skg2j8UqSr214qzXpIox99yCAeFD
 zdSLJblqr/XiFSvYf+fs522+NCQ7FoK/brBYsdogqEKkF2aMVW9fRBL05vD05Fw=
X-Google-Smtp-Source: AGHT+IF2LLS9BvejYc68iRgG85C7Dtt5qa32x8hvkNp3baRKFK//qyDdVnaLaSMIsGmbfXBJFSOLqg==
X-Received: by 2002:a5d:6582:0:b0:34b:3ef6:55b4 with SMTP id
 ffacd0b85a97d-35e84058266mr1185769f8f.7.1717572926844; 
 Wed, 05 Jun 2024 00:35:26 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0f2asm13657890f8f.3.2024.06.05.00.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:35:26 -0700 (PDT)
Message-ID: <d9c6db8f-826f-419e-ab11-9fb70d11c01b@linaro.org>
Date: Wed, 5 Jun 2024 09:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/37] target/sparc: Implement FALIGNDATAi
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-31-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode |  1 +
>   target/sparc/translate.c  | 33 ++++++++++++++++++++++++++++++---
>   2 files changed, 31 insertions(+), 3 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


