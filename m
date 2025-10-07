Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE42CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62v4-0000mu-4V; Tue, 07 Oct 2025 04:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62v2-0000mT-Nm
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:19:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62v0-0002Fh-W1
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:19:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so53806465e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825172; x=1760429972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9p249xkIP82VTD57yJI9EMH5vgB2T9S3AbZV2dRRgA=;
 b=KhngiqAhv0PkoirrcvVQWHCGKJwhlvOZJ84ZX+JSBDsYfSLxDCKkqNQtvdTk6ctb7/
 MyLziJICr26Rd8O23kWmlfhMEgR/rIngN4aWAovRD/Oh9LBh3TMEJmZT2nXM8alRkI1/
 cXpirVcDpAX8E7TeDN3lITsHX/VMyxLGvVc7SApaV0Z3p8EMRYPCvus1qQDn465oikHG
 /b3WtiuDEiwPZc7X/TqtvrsaG+9wX8jTwfVmFygt+k/jbez83D84ruGvII8TtBPrjIJi
 CZ0f+MBgLXz/NLtVXIEIaU4cQg5aLsKBfxXiuHOY6P4FBHmHDrHNh6VIkFxZlf9Ps3KF
 zFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825172; x=1760429972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o9p249xkIP82VTD57yJI9EMH5vgB2T9S3AbZV2dRRgA=;
 b=Em9xjgyUnBLqcN/prbFdfKvz2Aixm/Fl+/19wFLnfCRNTFv5Y0c0XZuHFNf+kZ0rd8
 cn4XM2Jp2XMVYGx9BHcZPZZV1eCraBFfT4bH81SOjrHX62mba2M5+pvKb5QtmdTBwB4a
 ULajTu/7NnXDq7ytuI6palMs6aYR1SbQWGCopVBky0M2l7Qv3sjHC4+Vv4TbA9CRJf6f
 Ms5KejuBC+5wvTlRTieAQFx3UGl78r+22nEanAvAjJ7agxy/NlpNPGm9AtOPY6Ic2Obg
 VCDx8gl5NyltVJ1W5ci2TcVyJQ6mma6oK0cUuuKbzKXo0nI0WfPdw8eGbV/Eh8lyhrLp
 +vNQ==
X-Gm-Message-State: AOJu0YztpJX5kT8lYF08j4Z0Vgz/QTBjsw5PFiKD2EsI8Hqp3wB/WGTT
 ZhQ/rp1CzEw0Ab6zIafXi6/BPeEjX0XvZAgfMlsc/7Xnyq47mLl+Sbk3m2lYKtEHkqHPb+kl1sT
 6nsbZWx7UTg==
X-Gm-Gg: ASbGncvksScVpxVRkeos73aDvQvyWYzX/ACJbcVnrgmcl4hhgLpDU/SbPC0y3Lz4bLG
 cM7hTDWADSnXY5bMueJrLR+IBAM9MuaUHIt5Ox4UL5Vvzm3tZQwP8lieT1fGKUTJXrOW/Kvd0Cj
 9gXSzHM4j/b598yydZTZEvMC/3C81UwfUcr+dX6jjemNfyUgM+dGiHu05+2nundd3jkqcDB8vxS
 WAEnP3r767wNkfTG2ggWgoCUHcHW9ALtrlbdQX4m4oFSoS6Xc6KXrb7EkqXBXpkGIZO32nQ7C1j
 u44NHb6CF9Cpxc/e/Q6pFMoPvcCnAAXGSH7MQpBpPRJR1eLNyqPkLrci4P5G63A/30lLdMQpWSQ
 E8geQFMflwfG5HOXiSef/2wIU7qohyxiusr+2EEKWn+Mn0Qx2CuwgTB52bwbi8JWrBNNwxJJaKJ
 9TaOdhd83pXjVuIQN0Yg==
X-Google-Smtp-Source: AGHT+IEFKXHCN9xuHHy+WlvTkf3dGEws6TAvxkEgi7GgML0qma5/2/dX3HtzBssjnJTA1hRQjyWYBw==
X-Received: by 2002:a05:600c:8b65:b0:46e:5a5b:db60 with SMTP id
 5b1f17b1804b1-46e71168c20mr112491745e9.31.1759825171917; 
 Tue, 07 Oct 2025 01:19:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e5fdsm196292355e9.6.2025.10.07.01.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:19:31 -0700 (PDT)
Message-ID: <225f6427-f950-4260-a95c-cf7dbe2e7867@linaro.org>
Date: Tue, 7 Oct 2025 10:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/alpha: Access CPUState::cpu_index via helper
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250925010438.59755-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925010438.59755-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 25/9/25 03:04, Philippe Mathieu-Daudé wrote:
> CPUState::cpu_index is a target agnostic field, meant
> for common code (i.e. accel/ and system/ folders).
> 
> Target specific code should use the CPUClass::get_arch_id()
> helper, even if there is a 1:1 mapping.
> 
> In preparation of generic changes around CPU indexing,
> introduce the whoami helper to access the generic
> CPUState::cpu_index field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/helper.h     | 1 +
>   target/alpha/sys_helper.c | 5 +++++
>   target/alpha/translate.c  | 3 +--
>   3 files changed, 7 insertions(+), 2 deletions(-)

Patch queued, thanks.

