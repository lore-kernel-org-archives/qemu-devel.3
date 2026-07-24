Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EE6C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJYc-0005Rp-Gv; Fri, 24 Jul 2026 13:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnJYa-0005Ps-AR
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:19:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnJYY-0002yy-RJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:19:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso967039b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784913569; x=1785518369; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zTnICLIb4YWZVnYVhcAQ4VApOcH9exyv+qNX9+DCZqk=;
 b=xRKwEe+WFuj4/zkcFpH/SmMMxmxAhkoTpvRtRQOJoR9vduSX90nHVSrR9/XIaj83og
 4fpUrhJVFZcG+BS2yACP6NoYxEfBo/vpWoZpwjAWrD9RTyXMWqrghb2nZ3GSZfs5Xhpg
 DE+tQdb7rcng4Hb38DpQ4Xby53WHT8a/zcbk18cLo/PuTySAHd17zLW3xo3r2vzsOI9q
 syRZ++uHtZc0vPP0AsdX7y22PGDTG4+IxVES7Nbgf+D+0/IRLvnKui6mRchmc4vAxkkH
 g0kIPDCc96c7i9qAoG2adUkHmd/BVR9JgMPKpnI6AAiEpCUw1hRwV8a52Rrm4yYmKJZE
 64SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913569; x=1785518369;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zTnICLIb4YWZVnYVhcAQ4VApOcH9exyv+qNX9+DCZqk=;
 b=ZmZV8l3caV3Gt/sb8RJgSLf/GPy7ua27HTinO7IAXId8ofIjDBw7uJt7gJLX2nlV37
 wc9r1uMmVHfXb5G+majrpRQxrOzAul6E+z01/Gv78sHwq/Wbba0KM3xYTUQGcF4x8mja
 p9mYRC0jDP8tTdE/XWrL1R2kVHMmZK5TJZ3Had/w1VU4A9VpjUrravHp0+18NOV5muUC
 q2nuh7az72BKK5jDSe23ftbQMUY6YIXsnt0AoK+uIdBGAZAH4y+ja/ElEHEalMgGKyQy
 9iJqyotAmGozbJFFEElBrSMV8HOMkDD9lQT2OwNCG/glRBGKC5h/CSQSjGMTe6jHo5sy
 hWyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RohbwDUCc3BmKz1OScvJrq2qhEzTg5ExKBYV/qB5OTksXIuMHUE6uxtjUPOomlzEYcYtB3pgMSvZrrQ@nongnu.org
X-Gm-Message-State: AOJu0YwF01j5ev9TaXIg0RohDCezQ2V61z2TIehfHa1fe4pVTOTAIWPp
 YwNcVH/NDtNVT/UDTciMVESRm/Qs4wPraPqJc+K8yP6bP2FN8Sh7/RcQUUOcg+lF4p4=
X-Gm-Gg: AR+sD13z3vt1B8v5pmTjRRx1AO8PwUtKYFOxC0bI3ZjuVuDfGKoNfx2qZBj+VnJU6T/
 SY4NQaImDYYIz8ocJS1fqE44m3Wcp4aCXs2xJhubACQIYzD/XV4NWZnmPUJeFdwWXa/NPcfA0k6
 WZsUbzI5zJZy4cdAHOWRPloG318Yv2pIqMXLpnAELXlBaUmf2fkYXtObXyykYkTTbpic3cRsnvn
 6Zk/3BR+MZbox6L1fPbIy0uBgfBqtPBm19vpnmeSFkdNJ3CqDdb/It6F1Da/BbSYgbvGuAAZMhh
 xfx0+/g1XEmCvODZcWFtbBUTD4sdN8Bwq7BF9EK6vckVXEXzot/kWIf3xhbwy2iR2kST+VhhV1J
 Xsjq/tbuqwFm5dHt4lPLvwSs546CJM2hd2TMmUub1ry4WscGRrAixEDkwfdMLJlqgXYe++Sd4sC
 xf5mTR2rO0ZYyVaURPBQTpx+3wwBJupqcQ5FSgfUAQow==
X-Received: by 2002:a05:6a00:852:b0:848:46ea:bbe7 with SMTP id
 d2e1a72fcca58-84e2bc6b5d6mr9214178b3a.19.1784913569317; 
 Fri, 24 Jul 2026 10:19:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5344d3a7sm198496b3a.52.2026.07.24.10.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 10:19:28 -0700 (PDT)
Message-ID: <0e0a1d73-b00b-4e7b-8902-373783107f35@linaro.org>
Date: Fri, 24 Jul 2026 10:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
To: Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260714190351.337923-1-iii@linux.ibm.com>
 <20260714190351.337923-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260714190351.337923-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/14/26 12:02, Ilya Leoshkevich wrote:
> Check that DR with a non-representable quotient raises SIGFPE rather than
> crashing the emulator.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/div.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

