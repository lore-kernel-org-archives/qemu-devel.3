Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D96CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PpF-0006YJ-Od; Thu, 02 Oct 2025 16:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Poy-0006Vd-BN
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:22:36 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pop-0007N4-C3
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:22:34 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b551b040930so912883a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436541; x=1760041341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dJil9oqVlamitWm1wrnX6Lq4zJD+ySeF50jNoKgpZik=;
 b=w6Nwea3pa5awH/sof447oINrVUArJy8gYd5EpJtKh/2sTn63S82FjY8KHhob4j7W0e
 AMH0XTNVNzA6cGaDJqZwMCKNtjf/XxklOmy0oMPafDXgoOm3A6JsrHYaihTOpmIgI8DM
 MJ+CyIC6rmaEjXQmcD1PJwsbvkJDRkOZumiNCuUfGbaT30SPjwavP0rLZqtcZwoY8SW6
 9w4AN33xun2fag7zSZvwg6OQ4AEP22TlTE087wr8djYRGCtY59pc8971pycePQJvsjYQ
 rFV3T0crXWm0HQwHCXudI/MxV1HSHH5aY1lO/Ud6T0MF2Wmo17l8PHaeERX+191ALzTy
 jFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436541; x=1760041341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dJil9oqVlamitWm1wrnX6Lq4zJD+ySeF50jNoKgpZik=;
 b=VVtQPY2d+FJM+on8KxgTQPRm6CvFaX1J4oHByVXTP9QF4HBT2pJA0+ebuIGYwvkDbT
 4bTwFPWTNImtKp0QUiV9j0OsC9EkOsuwG7vWbdZ4WkrXKNHB3DwIymUIbguYN36IsgFI
 r31Y5p54zwir+kzF0DIbdGZIyqm1Ouhiu54kfvlYpSpnjzjtgIMw9uG97sxl2YHrNil7
 n3U8+Bwuqg6K6c7rMS0sEu9i0OJa5o/cM43Pg4riZKKXQok9qSlK6jXoNby7RKi5h9Qg
 sibC55ORLDs9zQSupRGurEpJyG2gytDyZr0ShHeNfprKEx0DJ6ZCTnVPymlHA3EsCxSA
 DOlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR68mHOjGTi1/UJPjbkz7pT5vIorp4qTRMqsnt9HIJO7gv8iPUJZiecz3MIhzoYPgCb6j4d0efwbrN@nongnu.org
X-Gm-Message-State: AOJu0YyFW8Sf0v/v3mc/0SP0iILs1bVh3/IZGwGMgZ+fXHWyo3FpWYTl
 rgZA78wtIjDVIXD+FSIKEpLx5nE1krNqciy6Hulnatd0Lcg7PjGyvWSFycIPlxA83Jc=
X-Gm-Gg: ASbGncv5kc4BJoZ/cEOwIEx4IaoqqRZm90FMi7lh7p3FTEBBBsVTsnOCf4UywrfgDvo
 qtru8V0FdCnx9GcnZyQz4foEUIXN3D6qjh7Gyx5xj7/HnHpvo0z21sLZHkoFu4qHRiO22zgHPx/
 nhIJDENZ6ERbzVO3H6DpilLy5y9kkk9v9DIoLC5lDy9wPlxXw8li2JIu0SEdA0tuoQtzlywcxd2
 vwlotpIg86bammT5yEUzSSWCpQNs+2WOLjCs1H4xkbuPi5xSws+1h8wgwPEnXneLP4KNxciVeOy
 oSCfTq4YHiD+kO/uelScE38vXS+UwCh2JETPisHia7ZL1nmVcxnrxokGurVXICUGKlUdV3jwlvV
 Kqxb31hznqOHo2NM8KTYRNIGGQHtLh5TO3F1AQNeTKjiMz3XaJA6ulNmZQZwAsFA=
X-Google-Smtp-Source: AGHT+IHcF8t9F1DdBNZ/kA81R5My+wblOnIrkEgSYjHLsCKQTtsSj1HMJ9jXOFw/a2Frg7DJdRB4hw==
X-Received: by 2002:a17:903:19ec:b0:28e:9427:68f8 with SMTP id
 d9443c01a7336-28e9a513284mr6878855ad.1.1759436541405; 
 Thu, 02 Oct 2025 13:22:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1f1a80sm28671165ad.144.2025.10.02.13.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:22:21 -0700 (PDT)
Message-ID: <e78860d4-9cc3-4d83-a1e9-3e1d3bb00351@linaro.org>
Date: Thu, 2 Oct 2025 13:22:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/33] target/riscv: Move CSR declarations to separate
 csr.h header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-32-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-32-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> Most of these definitions save riscv_csrr, riscv_csrrw, riscv_csr_read,
> riscv_csr_write are only used in target/.  Move declarations to a
> separate headers which will soon be made internal to target/.
> 
> csr.h is temporarily included from cpu.h to not break includes from
> outside target/, this include will be removed in the following commit.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h         | 82 +--------------------------------
>   target/riscv/csr.h         | 94 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.c         |  1 +
>   target/riscv/csr.c         |  1 +
>   target/riscv/gdbstub.c     |  1 +
>   target/riscv/kvm/kvm-cpu.c |  1 +
>   target/riscv/op_helper.c   |  1 +
>   target/riscv/th_csr.c      |  1 +
>   8 files changed, 101 insertions(+), 81 deletions(-)
>   create mode 100644 target/riscv/csr.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


