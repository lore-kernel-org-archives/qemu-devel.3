Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40568C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9qa-0004BS-Bu; Thu, 20 Mar 2025 02:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tv9qY-0004Am-IW
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:57:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tv9qV-0001uJ-U9
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:57:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so3638645e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742453858; x=1743058658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPhtlMEyE1t/TeBfGPHO/YBqHcTOXS9vsZ1BLG2PgpE=;
 b=E9uCPNogdkCqzqgCYSChHFrTOI/6koQech5GuEX3xGVtinwWloRsHzqKR4vxNC3MVU
 6g5N+bz49A00TuhP+qvs5FU9io68i3al3ao+vhm7s9+PXVeSH+CvrNBJB5C45zwSabaa
 J2hfGLEquSsnoQI9IUOgnzudOSe8zjmIgXo3MaKtMsCGuwqTH/wLdEMN+wxuDveovcBF
 l0PFHbZkKSXvg+6n3P1BgWIQ4qYidAwA+mX167c/tFbEdOMjWNHo9oFMe48ImUeX9Q2c
 BPifznLlfpgKbv1+3Wq6DbgikXL0CKY0lLm3i1P/cB4l7byqnIgNR6VpOxckF1BkthA3
 gYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742453858; x=1743058658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPhtlMEyE1t/TeBfGPHO/YBqHcTOXS9vsZ1BLG2PgpE=;
 b=OeCJfnjT2aa5e/vjhhX/1+UKLr7O+nEiM0U5cU0VwGfndVuSfmVBU0oB8vcSgh/y4m
 EKRESb7xftl/Y7u/wUcQva7XPaCqiolbloedGFnQvwdwXgh/kw0nlGehOJzBpOqXLi00
 +29EXU/6mSLehNkQ2WeMkM8sXc/sodI7Ee7BH8QM6x7Ne7pbAAHeBkVhex+OvoOBHtPh
 7k6kfQbkyBXEIOI9R5/UZXEEKaQ586R2hx1dGhAK0rOfm7B1o5K/UOHKy5B/3JdTNG8J
 gsLCpJzoMOY83S2cdCwNR/MZM0wTrBG4eWiSSQfv9/Iu3Jq8/WJ0es5vRT49HrmIuEuo
 gHeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDL5f3KedHA8n+w1PZVfPawh2NodY1ZVHPtVfbnK96ngM0P4gBjgpXpznJqzjM1FsQB7XG3I0ethD2@nongnu.org
X-Gm-Message-State: AOJu0Yxw23QKBg0c/GG8BF72gWVa2+Nuf0WZEMtprfo9+3nDxu0GYxfq
 Q1BlGZjxDaFWP55bewhJfb6t1Yr+RDsHu8h3CMvBX8dt5ZVpMfap5noqe2SUjN8=
X-Gm-Gg: ASbGncuv+tXDhsDjL+5k3a9LhPD2ZWKArFNifoL+Cw43EgQ5gTnAl8hs/SR4UqTELvN
 YE+1bnOsbmwzbaHlL3BBCW3GMwgKUcNLe5LF0aHWZ889IVB1l4fdbo2w079vTwaa1uxggP7tz5C
 ZqA/Rux178WSk1vkChbls5QRGQWnrMI2HSWB+Y/+lnp7yj7AFyr1hbSJPWhPfzWZ9ranQ5hzkl9
 f0dI5IlyMA+/goDXjGBWRpIMxKapbIQu4fjoTf5Vjx3bMqaUedISWlVQcifP8rQMzoHEtLkyeHs
 wVNDCJKQxUqBSLSVrtptataVdTb2ZpM5kdxOl6O49pwksREcSJHOU1HbS+shYqCDAoDttQUyklX
 uQ0lMZEWfnZlR
X-Google-Smtp-Source: AGHT+IGegxNjbS9SRXWUK8OXQcRKYvTXHPQXNFZKYjMWngHkBslKPyrmXKXTXQR6hJx2n7KbbKTZAg==
X-Received: by 2002:a05:600c:4ec6:b0:43c:f575:e305 with SMTP id
 5b1f17b1804b1-43d4378c29emr44900445e9.8.1742453858086; 
 Wed, 19 Mar 2025 23:57:38 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f332cfsm39696625e9.6.2025.03.19.23.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 23:57:37 -0700 (PDT)
Message-ID: <f6f90393-03db-4cc4-85d6-63212853d08e@linaro.org>
Date: Thu, 20 Mar 2025 07:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] gdbstub: assert earlier in handle_read_all_regs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-9-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319182255.3096731-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 19/3/25 19:22, Alex Bennée wrote:
> When things go wrong we want to assert on the register that failed to
> be able to figure out what went wrong.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


