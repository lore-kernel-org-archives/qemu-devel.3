Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB80CC02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfk4W-00042d-7T; Wed, 05 Feb 2025 13:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfk4U-000427-Ha
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:24:22 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfk4K-00006O-54
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:24:14 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso2988757a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738779850; x=1739384650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGGavXi3UNEcY6VrRAtJoSSirlQQH7uuuHAbhVgoFaQ=;
 b=azhn7/laWz8gOdITWDo4wgwnjwZ7KXlZyOIXsAMLbO19LoJiyVwSK+WLVW1DeLO+wz
 Pf7MPsKiq8rcqxTgeohzBxeIbEWUHq5sk9YyiCzqX73xdhlM0+12zRumv3QGxBIO0kto
 SsKC7BNyYPyDvGrzUaFGwd0KAXKOwjRlGuRbmATjsDch84kX7sMGhTFrixOfiAQyqyg8
 kVZtYjLaa37NMhfAthG6OdbSGmIbUp31zOj0tK9C/AaoW3XvnCsl6EJ0VXWRZ3AfxMpb
 XxSf59oKpDOKdsmCZnbDEZbINW7F06FxpaxUWH9QSDH3/gE6y4VsAcjJiQVjNSx/LcTV
 +0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738779850; x=1739384650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGGavXi3UNEcY6VrRAtJoSSirlQQH7uuuHAbhVgoFaQ=;
 b=o9l5xiPMXcm5qe6FpVk6jjLhCbybJQeTroQ3EkJXVF2kSm6DGBPFPFX43wVseFE2B0
 yb4Fnwt6mahybpHGrbezXPrWTf+FhwNlacN/0mdSC14P+LJxng/+YUZQ/faTA5BAC/sz
 hcxb9OlyiooIYOXmWKZjXY5uPkVZ8QTNBU0nJopUacJQMpQ9nPdarYkmCMThRDqn0c1J
 soSeyEmp540mzcXZ5egzQ0Vq3ya6l5ezcM0KVOMJHih4SKnuofyyrQyL6d2BXmBZG2oX
 OrUj3yR05fLDaaGYqbwwKZf55gOPwwjT71og4OB2pL1eEeYyGO6vK0FQ3X6Z8CneGTwl
 0vyQ==
X-Gm-Message-State: AOJu0YwRnQieJbDzrck7/jVe6pS1IkBLiPvcN/Q6D4g7IhKSeuMsnB4L
 wgE9T5VoWvtkiHFGNJGvOEv9CwSL7YBxqMulAOWJSrtohk4t8RMBAUmLxCVRZtCUb93U1XTySHA
 K
X-Gm-Gg: ASbGncvRD8DMW95ZHlkAWBxaUGnx9kYVon3hmSRRFTZMLRY66nHoAaKF2dkDoTbfau2
 SnMWKErSBVJZKgpKrNELFs1RkBYiV51UZb8hPvP8x8MlmFHzlK5jCgA8I+yxrOVkbLJJV5cJ136
 xGmGs2fv/Hfptiu/hUB32HRyLt+RS9t9tpd3D29ulXvRWOcy8wzC41pPNJwGaz4lTUP+K/uRGEy
 cIZ1LY1fDDUIdQFrm03KPKFaQRSRbrs5Ipoh2xRPjX7C0IpxiSeexKI8E99rlS2EcUXbqauLpLa
 9upRpuqgStQDoq3YDrCWvKRPVlasO6As/an3Z5u1V+EG4U6vXC8I3+I=
X-Google-Smtp-Source: AGHT+IGjaohE/LDET8mf8iNXbL+rYxTIsEvZnIJu39ZQhgKHiPl7tMYSWvOhArYzClqW6kquPtrovA==
X-Received: by 2002:a05:6a00:3393:b0:725:973f:9d53 with SMTP id
 d2e1a72fcca58-730351ead83mr5691731b3a.15.1738779850190; 
 Wed, 05 Feb 2025 10:24:10 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba3e4sm12847853b3a.85.2025.02.05.10.24.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:24:09 -0800 (PST)
Message-ID: <18acac8d-271a-4641-893e-93096f31a2ac@linaro.org>
Date: Wed, 5 Feb 2025 10:24:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
To: qemu-devel@nongnu.org
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250205155946.2811296-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/5/25 07:59, Daniel P. Berrangé wrote:
> +
> +'''
> +Decorator to skip execution of a test on 32-bit targets
> +Example:
> +
> +  @skipIf32BitTarget()
> +'''
> +def skipIf32BitTarget():
> +    enoughBits = sys.maxsize > 2**32

This will work for true 32-bit hosts, and possibly for containers running emulation, but 
it won't work for cross-compilation (x86_64 to i686 or aarch64 to arm).

Perhaps "file qemu-system-foo" | grep "ELF 32-bit" ?
I don't know that we've actually selected the executable at this point though...


r~

