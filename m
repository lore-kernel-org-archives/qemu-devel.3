Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3C2C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 02:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxNx-0004Mj-8d; Tue, 28 Jan 2025 21:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxNp-0004L2-Jr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 21:00:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxNn-000899-Ad
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 21:00:48 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216395e151bso3367155ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 18:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738116045; x=1738720845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bou/z/43On1QDRojHbmbjXKRoFmn5z5zCeklB25HCuY=;
 b=qB+qhuL5cAtedce8bGuOIFulya1nEmDKyJtxKL+FrQC62RsUTthanlbKZHOHOVL9tF
 fJK2hWUKtQaHFPuKOjJJmvLBEG+5pruL4R8KWHCaAEbHFoEuUaFEBkFmh+kQeWGyVzD/
 xJEOBGVtDV/YHDh/n21D6YW+syB697cTMchxCspnV0fQBt4/8PILLctb7Hzid1nN9lEr
 VgyhEAlx32bNfhkC5zOa4+EUsglseFsZQHw+tPpAa/DINjiTqLtI4CoanvpZMW+WQ1oH
 UrAcXP3ZzDtBrJKZ/J5JY7ST2xCMhAkOzFI0d1SZO7SB4O4b1kKgQ/HIL6GPsDErGr+8
 gS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738116045; x=1738720845;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bou/z/43On1QDRojHbmbjXKRoFmn5z5zCeklB25HCuY=;
 b=Q0lWQHmDnIeG2ZriGMUIeDinaXJSa4lYhAQPEbbtkJwO4fkGNNX4UZ4azNsyPzO3MD
 ylYHKhDCS+AUuAVuShbMeg3XuNNfgRW8cl+gyAYqzEtTdvP+4v8RVXBahOoLnVh1CJjH
 eqj8LkxjE6TpO+0P2G/c/PGZtzGZWirDldP1yrYC4aMMiKIKovOAG2QCLBi70vcw+w0F
 ZCA68gIXa7UxrPtJGHUfVC3Eao3TZAZby/dvtZR4mPUhmoYrxMOkNF5eWbCVOg6hj3B8
 u0JkBYPqsJvutGKemBDHRRTqh/fE0POa5nuzln4Qi/fbXc17xmEePgHmmlRvOnbMGJ8b
 3LVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiBjrRQyO3LcZh8kC47R51cQ0flLeUGg0RVHpz3nOMErovFgt2mTtTUQBHHVbAj/kOaigTviK+levX@nongnu.org
X-Gm-Message-State: AOJu0Yx3UTILDS83W60B5i/cxxYTHFkiDp8oQCXgqZqc5tSG8smEYo5N
 8dGIKPjJnX1hqs+51NpE7nxqZsO6cTKX55oLgN+K/mMsO5+AX97BUwWmVGt7ieY=
X-Gm-Gg: ASbGncsAWX7/Y8+OfxuDIx/kFp7X/uwCp/VKKcgxmyId4TLenRFlORck4JGTgcw8zLX
 85Q3VeNd/hCsWvnvarme3bCn2pHHAy5h578LucMBRJ0cfevAN3jRUrSioht2CNxnHdWWTk8mY/V
 xiinoZ7NSQUR86pFXJupLyhgNm7WhePExmHdx4tPxxYB1bg0GV70PS08oXtCZpjiw89/LGzSba4
 B25q75dub5wbzZoaw82JvYqlG79rUtxe7KvxvuMHE+JDMY7fEmDcX2JQywezurGWS8nxh/VldMz
 sSWwSds1nZ/kFr2dpufynVy8XGklXhEBFGMzcnrlf0SYWoyPbSrhmj+QJQ==
X-Google-Smtp-Source: AGHT+IE1mdb1XeCwS6vpDoRObckpBSN0D9BvjGriTNnvuCSnekgAltNyEUwbxLhnR91lY/gRx5tLsA==
X-Received: by 2002:a17:903:11cd:b0:21a:7e04:7021 with SMTP id
 d9443c01a7336-21dd781a1a6mr21234695ad.24.1738116044723; 
 Tue, 28 Jan 2025 18:00:44 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c52asm89067235ad.43.2025.01.28.18.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 18:00:44 -0800 (PST)
Message-ID: <6f445eb1-2626-4a08-abbb-580cdd7fe682@linaro.org>
Date: Tue, 28 Jan 2025 18:00:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
From: Richard Henderson <richard.henderson@linaro.org>
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
 <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
Content-Language: en-US
In-Reply-To: <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/28/25 17:52, Richard Henderson wrote:
> On 1/28/25 14:45, deller@kernel.org wrote:
>> +    if (ctx->is_pa20 && (a->dr == 2)) {
>> +        /* Exit TB to recalculate gva_offset_mask on %dr2 */
>> +        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
>> +    }
> 
> Where does this update happen?  I think you've missed that step.

To expand on this, I believe you want a new helper, invoked here, which calls 
update_gva_offset_mask().  Then exit the tb as you do above.

We don't really have to go back to the main loop, but we can't chain with 
DISAS_IAQ_N_STALE either.  We'd have to invent another DISAS thingy for an exact fit.  For 
something that's probably called once at boot and never again, it hardly seems worth the 
effort.


r~

