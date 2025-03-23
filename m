Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3001CC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 18:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQI1-00046k-Dz; Sun, 23 Mar 2025 14:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQI0-00046b-1p
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:43:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQHy-0003EQ-HX
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:43:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-225477548e1so63640955ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742755393; x=1743360193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gN3ce/i310WYM016X3bH0mv11j4UVD5p2UZ6WiXMNrk=;
 b=m5xIeicZk2Xw1rFt3iGmyroWwEcgx/QJfIdgg6VZyJ2y8/cKzgr9m5WIGLhXPjmKss
 UkvnIrPgmRmi6Qil+AncmEWWGbQNtzu2faXquDONJiucKYTYd35xOlVzPLwgaipZmbF9
 gK6HxWNJEI+mW9Vnkj2WGhr79wtcnyPIZ27al/t5Nco56RNhxVoURxfUQWkwszSZegZc
 QlQGepslXecdDvqyKaqMILZA1X+hceHvdywQnQun3CL6/feAB7oyuPIiRMS8FCQIZT9t
 5VegNnIyYiv7oHDTI5Iw9m9Z7IqV+aSRv0f1UgxWiJcvq2dmbjGisHqXJjw4rkT55kup
 Lxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742755393; x=1743360193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gN3ce/i310WYM016X3bH0mv11j4UVD5p2UZ6WiXMNrk=;
 b=I1M2rPmj2hrW2bsj1B0vCm17cD1UHSv76RgsKM7+ldSDJOvX20RmJZxwaFDJ6d76oN
 fMA2d4jnEgEP59PrHI1r8U2Kcen6eAsWYitwZwps2STweC0VVOqNX6G96UClJ/YHBTXT
 TNLglWkNsCkGDrG64u13xx7X+JmxEHOREDMcel0poq6WZ4OvRMnsjpOHnhTy5jVLUSpa
 G9QzJzJktXXtOwahIAvBFCwFKbh8BZk+khI9s0FkqRCZfbgt9K/3jZMaw0en704TefqC
 rJ8Pn+yCiv1tP9ElTNk3fIKG+44ClcKBpKpm/Kuk7DP5Pdjber7HpB5ink23zd5GecoZ
 4oTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaseGcNj9SpD1NhOtkJ5dIdfxjALZ0wfcsiBEcvz7h+2ZP56M0PA2y3OljMfaD0VZJYykub2IzeFw2@nongnu.org
X-Gm-Message-State: AOJu0YyaBHEWpKwoR2y9Xno4zKAFiT5NgeeyF6fRAqfY5/7FAXmn0wLj
 gjfEsfwoRrZXeXn3y5q3/a112gOh2JztW4VQ30kJA66jbgPJGcTjNLpbz2gAtrE=
X-Gm-Gg: ASbGncsqPN6LUHEcROAkzl+mqtNcMy3KF7i6Im14L98MQJ8P3rAubyRUuqNZZ/1LcTi
 fWZG3Q6QVGXj0q0pU6lkWrMBsBXGsLsxK3iP1B9+wzfUChICKPgFbyhoHKEOa2QAPr1ZzU6uZKC
 n9kP1QeonEoM8DVOdlQD4eW6V6LZBXH0zKfRfiWWwoxLEKd6NayLUzdhPxmMHX6b+e8vTEgvUoK
 m4RDpd0SPX1pePMLINZQIDAgCi8vlV8Qda7RtmuVyWcKrsX82MkGM9tGTBW2mIedpkR4FCvRd0T
 9Sba/CbhZnP2IkZv4DZGGlkfRNFbzcCFwdwWqlA5Zd7r7WgNctAh5wJ225SlwsRne118iLeKrbG
 Iik7uP5PG
X-Google-Smtp-Source: AGHT+IFJWnaEPYZIXd1eKStygn0sVXthdfGwH0obVr4VOWkZogd0oNQrcz0DSKRbG5lPVYbKdnBuvA==
X-Received: by 2002:a05:6a00:391c:b0:736:4d44:8b77 with SMTP id
 d2e1a72fcca58-739059b3e94mr19658341b3a.8.1742755392729; 
 Sun, 23 Mar 2025 11:43:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7392027bde9sm2526263b3a.113.2025.03.23.11.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:43:12 -0700 (PDT)
Message-ID: <c5b9136b-abe7-47cb-9341-ff0280d53ef1@linaro.org>
Date: Sun, 23 Mar 2025 11:43:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/4] tcg: Convert TCGState::mttcg_enabled to
 TriState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321155925.96626-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
> Use the OnOffAuto type as 3-state.
> 
> Since the TCGState instance is zero-initialized, the
> mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).
> 
> In tcg_init_machine(), if mttcg_enabled is still AUTO,
> set a default value (effectively inlining the
> default_mttcg_enabled() method content).
> 
> Instead of emiting a warning when the 'thread' property
> is set in tcg_set_thread(), emit it in tcg_init_machine()
> where it is consumed.
> 
> In the tcg_get_thread() getter, consider AUTO / OFF states
> as "single", otherwise ON is "multi".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I think it would be better to leave the warning where it is for this patch.
Move the warning when required by other changes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

