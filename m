Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C129C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmRk-0000w9-Bh; Tue, 13 May 2025 06:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmRP-0000pT-Pm
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:00:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmRL-00075F-CX
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:00:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so37900575e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130445; x=1747735245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A6X/8oxrpAwVwBgKDFjZb6gd7YyOOEgNL2DIro56QAg=;
 b=iWkI9HaNwJbCxy9juIeNi4TYP/cLrqnT1vdMkz2+6eA3IlfvTLAJJ4VY8lgmtpJAyH
 izRLsxYu3od2LWWz/Dba+8tgCZgEOfEo5rwuN1tLsbV2F2GKUa2sM19pV+UJzCq6vpit
 QGy8G+lLDvc7ISnKF2isZ2XAeGrMRs7Ojk4yFpEqVsOAgiefc+phDgjjq05HrRB+6wwi
 poSy5AI2YDyCvP98AEP2BLf7x5n9Wt/ssxFex8TKXmNF/JpgqVo3HzBwa/uUWbsf0AsS
 j+IcEjUpbcyH/F3mi5llQLM7IzerI3GEVSjVq+3znWkZLbqEuS0Na9Agq7ye01LzN9eQ
 6D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130445; x=1747735245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A6X/8oxrpAwVwBgKDFjZb6gd7YyOOEgNL2DIro56QAg=;
 b=XxNLRh4gTcQOOzwrhFs5bjxWSHRC3nYMhxER0iXnUgmupQVgyyigFrgmHEykDWxONn
 jKaZk0Ugan9xsZAihI8HV1pZpeDj7BQqOGasTlPcPe4/J8Ph/fM60RBai0elOCRlqV7a
 u0FTHjW3PR5pHmig1dZZgOy8SWt0czpCv46YxJ+ZRQBvR+EcmV6Wnd2ZM3mm8s3iooHR
 vO6qlyIY9f8nbDkkJO11wmf3zD5S75j7ydU46oEX+jSR3Klf1CSbDdmCLT/PweY7O6ep
 DeydHndlLtJncu9xE0M6vTMW4B3+bard2xzLt32Dio/28ft7zouxKdX5kAxCNeqzAheb
 dF8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZQmdyiToRpAjceNFk3zAS3Yf/CJ1JCK+QZLK50qpwEh8tubesIcT5f5Gm/0+oryd5ZTvwAZCSi7Z+@nongnu.org
X-Gm-Message-State: AOJu0YzsmAAYT181HSjjxWIfySV/ntFnLjpsYawobRT7uSIBezo+6OJj
 4zw0kfh/P541NlGB18Kg52Ka563I2M8XMiAfyfP44CwOzW9H6cC3L47BC8kKMqA=
X-Gm-Gg: ASbGnctK1D5F/U00v3N22Wht27qU2d7vbM5FY+OMb6GJVhYJyJQFEspHe0onsCIaeYc
 C8pww5CAEKRc3qKfKZvO+93remanZIkrSvJUFE1h4rZ9avavMH6W78gDBvitM5zl8tleJY+3DOw
 eWD6hE30EwQPZhYDlLIYBmLaNLUp7Z3PZZzhaUKv3FnC5QXGQkEOjkT4n9AAW17lPZVR55NBdjd
 vBcDGYm+GJmGxh9Q1KgzeUeMJR8zf2dRstQOP0lzS3ODFv150mF69DBE64KsLO1EFGwKVJ5loNV
 LdQrsdQmX0o9j0IOW/aIt0b6g3ITIfnVRAsTlQOqTb7ekiYP5hSoo5JcwxHOmoQGIik/Yi5w7BP
 mSyXqK8Fo6gFx
X-Google-Smtp-Source: AGHT+IE9noWdUSLKLXTSJ+E5Phwdhc/M6/7kGwEv8EQZtG6DJWhggVKOupQOu5BGqxQvxDgrVQ66mg==
X-Received: by 2002:a05:6000:250f:b0:3a1:1215:9bc with SMTP id
 ffacd0b85a97d-3a340d34583mr2205372f8f.27.1747130445153; 
 Tue, 13 May 2025 03:00:45 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2a79sm15364718f8f.48.2025.05.13.03.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:00:44 -0700 (PDT)
Message-ID: <af13ffc1-961f-4f5e-ac32-856faf4f0212@linaro.org>
Date: Tue, 13 May 2025 11:00:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/48] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Needed in target/arm/cpu.c once kvm is possible.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm-stub.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


