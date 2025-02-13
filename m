Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F01DC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaJb-00058e-35; Thu, 13 Feb 2025 09:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaJZ-000586-F4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:35:41 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaJW-0000Lf-Go
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:35:41 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dd011ff8bso743133f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739457337; x=1740062137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6YG8SUpbhJq8GAeggDXY71fRmnn10IHNn+kyBtETFg=;
 b=ze5uuevCrRrD9vPYAyqEd67fE7medwmSkfKqENkfnZjlAP6kbPS0YFrQiYftEZuqnI
 GGpiADD9kOnz4kswg8eN9t6NwVMvOjKN8aqlM26kMIcPKUZAyIhejBdDck9WvFDGV2Ul
 MpvctN855uPXcL0ZmpsVmLYnlWhKoaVPEDhlgikB2HaIHqlSIW1zP1mNRFa8WbW/i+9p
 FRN4U22oyYP+1eqsd46ifDGlgFj4dob9LmXYfY1tyGO7XL0cIFKHB6ELAAp+nzWGtdUX
 YuWj6+udt5IPVbssfGhdeI1gZFVU4SEnaPXlrtwVbnTqt6zCkixRlmGGrgOJopmuQk+E
 /3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457337; x=1740062137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R6YG8SUpbhJq8GAeggDXY71fRmnn10IHNn+kyBtETFg=;
 b=uoMI4Drxr30qIIlgSZ4QmuQXiZGEuecUYBf40BnNSzdndIHWk5mj+UqjrZ7f/uFToD
 T4900VlUfHcL/xWuvV2c05vCD5bh8hoNb3pDasnczfKnshgOh40fDhD0wtuqm8vLsy3v
 F+fM74jJ+f2CRgLWz6O1QNBCwQTVpf/m3FqMkjPouvMFctuDaXgvr0qBlyvwNcd97X2f
 6Sc6MljNxqnqemDoCiXJSYOy59T8IfjEpr+CiuhhHXuvKeya76oilvJgqXhSQoDq/xzm
 e4cI57Zazk3e8CLC85JBuX4IqHy+3d5sm2Eru/36k2gaQbbeNF28tsP9zk2ZFoPI2EdQ
 p+ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEGY7/1IQGQX+Ycmrmt20H9REUcOVpfPjxWgu7W4ApDfsutm9PumpPDtc+7AIclCZrXGqQNwQadvJR@nongnu.org
X-Gm-Message-State: AOJu0Yz7Kpw5bssKc2RM3OAF+820zYT8yCbeC61hpEt/+t1LAQ2kAKUz
 lexAmGZ8F5l1dDLBTcVaJz36dYn8aZmDVbnYgPAK0v/D82GcXVGbqXoeHgP90HQ=
X-Gm-Gg: ASbGncur4UcMgHmyvaG3ColkpJ/D24ADoxKmCPo00kiODZdqdcIBU9ZKtczMVNPja5r
 cYhIx+L6nTuPKeQdvFe/47P4lUvHOo1xXjW5Nk7UvgnHIw5ksUQAjshxR6a0qb8XM9vtCMgW+ro
 e8f7IlNb+FGWh+IZMrDbsr0RjDNyLkz3k750Ed3n9FXgSDYPmmZz6InMqqqnIsyXr5NupESBiX7
 vXFb++jtbpQijr8aDCxyztCpGYQpisP98IgB++fHaX8vCaSlxYNi+OrQQIZBIuRj0lqfwTDTYv+
 61Y8TVyZnMI6DQnP3vlGaGvqhhFXznJxBn+xB9I2pLN4FOR/iivPzBxv0vOllr8tMADXmWFh6A=
 =
X-Google-Smtp-Source: AGHT+IEHzDHWF2/YLOBAvJX/aWKiij/k6hT74XgDRxZmzviQ/lxmFx8lfEAXGuLcDgCkfT4xaPCL0A==
X-Received: by 2002:a5d:6dae:0:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-38dea2e8e5bmr8977956f8f.35.1739457336905; 
 Thu, 13 Feb 2025 06:35:36 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dd5acsm2095536f8f.35.2025.02.13.06.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:35:35 -0800 (PST)
Message-ID: <90247441-bb24-4f60-952a-20d2ed7831b0@linaro.org>
Date: Thu, 13 Feb 2025 15:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] tcg/i386: Drop addrhi from prepare_host_addr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> The guest address will now always fit in one register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 56 ++++++++++++++-------------------------
>   1 file changed, 20 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


