Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7213CE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 18:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMt7L-0006st-FP; Sun, 15 Dec 2024 13:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMt79-0006pw-Vo
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 13:13:12 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMt78-0002u4-EN
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 13:13:11 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ebb1652729so1035811b6e.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 10:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734286389; x=1734891189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YEnn89xyBmB0xUOfyovA/6uWHjkWrH3n8IaHdk6FHKU=;
 b=jD9W3wAk1KHoC4stI3l2KBR7MksztwQ3U9yufY7WqEQSvpah05molgTL/jATIlR/kL
 ve7qMRW/BWUhEfdyzlLwvdCHXRmy9NRLkSsaysoyKzUnQj1RUUxF3fckmT5bSNisVdWx
 mdroRN7lW0nH1m3MSqxir+p1+b1PdFijojA56OEJw+4CHXKyLM7LixbhqXI2khX+15NK
 qXh19DsMYyz1sPpRjvKTLCc5HInKyxomhOLVeRkiA7k8lFpK+S5L21FQjclGslUcLXFi
 sP2vt7/VHyroGf35mAwxxgvNc8I8FcyCqbL0HPZXC04TGncrEHkDA81rRWqkFUemmZL1
 A1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734286389; x=1734891189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YEnn89xyBmB0xUOfyovA/6uWHjkWrH3n8IaHdk6FHKU=;
 b=TBLH6FqJjkJe0B+up0ayqJ9C7xTkzgWWoJ8zV5D2Yg4fA1fzmO+BhSIqGVht1DEUMT
 WXeAjnuwY9WCo6isfuttFQ2GPPdabxlkI+OsiHQDE7OJh2NMZ9QFz5CG00VuGqxw5aCw
 jANsdQutDN1Fm+/HRLiWKA60YutKG9FDxoJkigBMx/4QtOIHCmBx0IkuFEygWF7AnI60
 gvZketQ+hqs3QAPY6ojGVfj89Z0ujWzGBuGhVOyWEO/b7MioJqf7TpNiCBs8oASLsHCm
 KMKHWHEwLWP6rH3XohTlcryumiIinZjIeutGTmTYXSpe6aZ+9VPB9QmZw/Rxe0btLwzN
 lqAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA5n0lp4Wqvf7TmxHbPahXv7QGaSacZ+0XtbpLh0EzL+dnN8zdm7uD6EjiWOS/51wCH8BDBfSFKhNe@nongnu.org
X-Gm-Message-State: AOJu0YxSyuQUGS2fogb1TBg9tO61+sQgoj81xHJbcbA8pC2RXihoqpbZ
 6NwXFLiXJ2QPgRZqchqHR1Vl4fC4f+HpIwnZ+XH+ZPjmm3MXD7POLcWDGRs4j7o=
X-Gm-Gg: ASbGnctjSXH7qhj0S49byVls+Rop3jjhNeJ4Nwo3/ZPOzderIQhdgLml5LrlLZyEOEg
 cuLBZVtrqFRViD/HDTsmpTgFjPqg+vTrXbiS3/rW1w6B/wet3WeifpNOgdhk7+8K3mH4J7yChFu
 jD0779cG9tjWvaNYrA+3sr2ztGLtbSnXEG+TxO5b0UgFYkJXJN0QM383PeeM9B6CP0zoGb9LkRb
 XFSDmVZJUA492hGzhFwYnqpMFPhnF3PYSod2KH4r94MPxk9iTuFJCwQkbwhq/h+SNyeba3qle51
 wskQgUA+9qdnyeMDh+3hCtAhLiNOvMpZS4M=
X-Google-Smtp-Source: AGHT+IFtjUR9sbPTQloyhQY3feoK6hn8QBbMuDraPFr4w9m+qgkqxLc2BF9lymvv//bwMvgI/MFfdg==
X-Received: by 2002:a05:6808:d4c:b0:3ea:5705:2a2f with SMTP id
 5614622812f47-3eba69a195emr5663951b6e.43.1734286388855; 
 Sun, 15 Dec 2024 10:13:08 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb492a328sm1129059b6e.44.2024.12.15.10.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 10:13:08 -0800 (PST)
Message-ID: <d1d0989f-880a-4322-8b72-e777304df8d5@linaro.org>
Date: Sun, 15 Dec 2024 12:13:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/71] whole-tree: Constify Property structures
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <15525622-FE2B-404D-9D4D-2EC8745A763B@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <15525622-FE2B-404D-9D4D-2EC8745A763B@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 12/14/24 12:40, Bernhard Beschow wrote:
> Maybe extend checkpatch to catch these in the future? (Not meant to be a blocker)

I believe I have a way to enforce this at build-time, for a follow-up patch set.

r~


