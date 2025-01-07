Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ECEE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3q2-0006U9-OZ; Tue, 07 Jan 2025 02:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3pz-0006RQ-VD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:17:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3py-00076c-Ei
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:17:15 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385dece873cso5612296f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234232; x=1736839032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8By1IY6jZOuKwnUDQ3PVj9Z8sAA0n/LSf0S0enlnUos=;
 b=tTH9jGYxZ+FtsI8rjkFQyY+bMo5kn2+j5YzU+ykx3zIRZjVEPIAtPPY57BDHkoTeNR
 K3vaVDQX+uL+wXh+RRoliRUF6waTZ02nK2hW8YWGCAOSaaPlPXHU7JgKhg+WlLVCJrj6
 vhGvDTTOgHxkZw3/Hrd8tE4t76l0MSrHEayxrUjM3wRODWms8eaiRCfVIoZDTxjD8K4H
 BNYaTWoCViKE3FDJ6WFrWl5EPZr7iHoFu+ji/CxadFr+J/LtzvmUp6g2D9SD0h269MOC
 8tsqOaQ883mVkLQABd2Q2Ep/eGp+5Jm4yEnujThpGyJZmkNziAnVVi8TnpachKaKwQdF
 baug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234232; x=1736839032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8By1IY6jZOuKwnUDQ3PVj9Z8sAA0n/LSf0S0enlnUos=;
 b=q++cfMCAuduXOlgYWjEPEouFCQ1NRuSD7Udnhv2JVjGpjRxymHr1GJ0MOGb29plOQ8
 TFm5n9fVHYnrzprQDztQXAQgqJuJc7wG/+0Qhk1PynAWCtyUe1aNDb/FQijfb/D+XIwz
 YeC2A1EQ8t5EcGM+vIgn1yParKE0Yojvv57OQSqqDZk/g0aiu0O2ksRRLpvK8ZkaaaQK
 VXJ5fv5NTppeQVJ9+iYQRTq+UmK/ZJ8MdJwcdeUA1EEEOYXFUQCW64baudEJ7jW86KLp
 +H1MaL00YkGUKX3UuMtwNLy3tm2SjH1/efFBN1wNtYpKe8fR8qUAAyhEnBXqJ0ZR4eYf
 xMnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPRnZB7KAgnu6TQKuVS6Ub2q24cEqMP36mcxBjPTr7ZPbKhR54AIJ8lqMG7ks55QlIt0XcwCNnPuM@nongnu.org
X-Gm-Message-State: AOJu0YxWgqEMIJ9/Jk2FDzCJO2cYotlp+gsxim2eSvwAxZUYUequYFFt
 6//YLf9OvF48hH8RBXEDZPwQVeOLA4Dz9d5ecjOgSSoAeG4DEE0d7sic9kyKadtO57jX3TSgqNf
 q3ec=
X-Gm-Gg: ASbGncvyGw5S456fRGMHNVRFFh+zWqdB8+I343oRKpbJjaFQiciTHiuhG2yHhiTZ0yQ
 b5ltQQqbB2/61fuFhcadNHidUQdvyYONTw/7Gtv4go0nl69a7OcJrVgUvFcwH6H5EGOuXJC/YHA
 5jTy7F2QhTRzN2Czsspkjfupslfd+rpLh3tjYUhsd+3YmmEJEW3Gdc37MxEM84BVVRI5W7+Kmmn
 n2qvOpEUmVzpScuZvTawf1Lb/d8y/+ugz3udwrnXzhW4eGVA+hYNvp76iNxim4Ox62xvb2Eolgy
 RQwoBkbZR2Ee/5O+8GAq3VyR
X-Google-Smtp-Source: AGHT+IGLgsi4auc07ZWZIxj0yEkvZBXitiAUIJEteUT6hCFAVEj3waBnGv66BI5RR2Rzs3hK+L7PRg==
X-Received: by 2002:a5d:584b:0:b0:386:373f:47c4 with SMTP id
 ffacd0b85a97d-38a224053d8mr52969833f8f.49.1736234232601; 
 Mon, 06 Jan 2025 23:17:12 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472casm50438734f8f.45.2025.01.06.23.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:17:12 -0800 (PST)
Message-ID: <9320fa29-4aa9-4fbf-b1a5-9df6b666505a@linaro.org>
Date: Tue, 7 Jan 2025 08:17:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/73] target/tricore: Use tcg_op_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Do not reference TCG_TARGET_HAS_* directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/tricore/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


