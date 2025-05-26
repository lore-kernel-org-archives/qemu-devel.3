Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A612AC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJab4-0002vz-SM; Mon, 26 May 2025 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJab2-0002uh-Tf
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:22:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJab1-00086V-8j
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:22:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so28781955e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748276557; x=1748881357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LtZNrm47KRDKWdVXNhBBuPrDAUteJwlLvbZyBM4VgwQ=;
 b=rB0sLujI/qWoyb3dIufMW76sfLucHr3LM93zjoOUXS84NBz9JBchlsYHPLKq0fu+Bd
 LcVNS0Q1dn3/ow/Yo4yEbUOtoQOaplF+uaqk3rZD4MyMon6MPi5IldaXEUl0YzKrkkj3
 G+ra3N603koYC0slnGEtXNeNSOGBIE4zeP0uJVn+fVGtbhNgCxjUeqw4TJUdLfp+Stmb
 Zby8uMfo3jI3WkdMC0nV6VAlfI8LctRZJhgOrgCiDWxkZJEy+o8IwJHqT4rWmXcVZU6W
 PE4qGO4XU4FkiimxSf2cGA46U2/6QJMgzocaX/et/Py7wFfd7/4LIx1RqRqq1tzMB4Gf
 rLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748276557; x=1748881357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LtZNrm47KRDKWdVXNhBBuPrDAUteJwlLvbZyBM4VgwQ=;
 b=vlfbzmdyjfMgMc4Qz1QTK4jONDep14p+R4RrHOC18cmyCap+k8iCMyRBmSkKsyeQK0
 Os1lTiSfetPU6IAW8ckOFj5tvBMCffIMdgIEiAocThzLTEV7nnZpcVucHCLg063g11Xu
 atnRl51fKab/VZJd4UC8vD1qwGZGJrUkrWfTsd1huY17cv2IHPgowLwjCOa/hdxpVBR8
 a4ASiviF9H1UQTX3vELHIdZuuZ5byZAZDnNtxQlTxbG5mSo+qiu1Ba6PnXRH59VlHeho
 xgQctccv/+V7gTaUNabI4OagYeOCjr5yZUz7FJgC0CFiriQCZzIyU2SJ50jFtoWqpcJL
 /tGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVdhaqd0kW4D0+jabxjiajX+2YTdtp+7Plt+t4+3yb6D+s2y0g+aYlR6Zpk+TCBhvlLhCes8HBvyAZ@nongnu.org
X-Gm-Message-State: AOJu0Yzfqb/4pK4TbB7De95FlSLKCZV+1ydvzVyjhq3e5PIaw44YWAcj
 x/34qsUJpO57DrXeTi2JVAJXjXPmU+5a1ssURdqU7wYSAZX/hq3whExaiyJwhz5FVyQ=
X-Gm-Gg: ASbGncsPVD7u3gnUfMsm0RvLa+pFHVnCWa0mRoLP34/zH+4Wd8izL4dO+eBw0SxSYkC
 itGx2xpABGics4ekX6zQzxF9gu3AU/PNj6NZAX/86afbmgXIrSN0Fp4f4j//n+v6WmQzhWCyeDd
 X5igTm8qCec08qgh6BvrXtBPd4BPUT3aE+y3dFM65fxb+ESThiXKMk8uMHWJ2dAenemzDbtXDLM
 AfxEzJnOouNDVWRbyQ3J8v2+jY5yrzwIcKtUcBKChwscIwKNXdI0FVCHiQt1oG+FiiZrnbuQZco
 vf/wxIymsDwt20zkOkWTSN9US5MWkdut8ddVmt2IWfeFyRpzwY10nMaxZpudQlXaMg==
X-Google-Smtp-Source: AGHT+IGmUXeUyi2cUSHthPWx2bqwjCxU380KTOJ98FLN77OZ7l49wyrOwrImTB0JDtdeYDGUJLCDgQ==
X-Received: by 2002:a05:600c:699a:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-44c91dd08c7mr86525445e9.8.1748276556648; 
 Mon, 26 May 2025 09:22:36 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44f706b9065sm17535445e9.13.2025.05.26.09.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 09:22:35 -0700 (PDT)
Message-ID: <94a25984-1573-4499-be24-9468b7097004@linaro.org>
Date: Mon, 26 May 2025 17:22:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
References: <cover.1747666625.git.neither@nut.email>
 <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
 <f140b06d-53c7-4d32-ab95-1327d2659a37@linaro.org>
 <3626834acffdaf2f6f2504c1dbb2c457601964f2@nut.email>
 <d90dd6ad-71c7-4720-a07f-8504f7fdfece@linaro.org>
 <001e4427e1c1eb53a8c9b4017bda790b34b5cdcc@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <001e4427e1c1eb53a8c9b4017bda790b34b5cdcc@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/26/25 10:54, Julian Ganz wrote:
> Hi Richard,
> 
> May 26, 2025 at 11:01 AM, Richard Henderson wrote:
>> On 5/25/25 21:16, Julian Ganz wrote:
>>> Also, some targets such as tricore only have a dummy/stub do_interrupt
>>>   and handle exceptions differently inside non-returning functions. For
>>>   those, we would call the hooks directly from there as we do now?
>>>
>> It may be only tricore. And you're right, it would be a non-trivial reorg to make tricore fall in line with other implementations. So retaining the separate qemu_plugin_vcpu_exception_cb will be required in the short term.
> 
> Yes, tricore (and hexagon, which I decided to not support) are the only
> ones that don't have a do_interrupt at all.

Hexagon does not yet support system mode, and so is out-of-scope.


r~

