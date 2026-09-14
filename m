Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B87C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CEs-0007gY-84; Mon, 14 Sep 2026 15:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CEq-0007fZ-JP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:21:12 -0400
Received: from mail-pz2-x15.google.com ([2607:f8b0:4864:3b::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CEp-0002BL-0t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:21:12 -0400
Received: by mail-pz2-x15.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so2175755a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789413669; x=1790018469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rfdoL6rblesATy78XaqPUOTQSUXFXdMPKdKplUsnJcY=;
 b=VYvz5kEOePSiDnSh4n+Cmp8chs7SVdUv5bjvFtM9n7MUyrss6qzHE6Fna2jLDheuPh
 uA76yXIlq67VByS/nEVOPsfLJtbq7MSx052EvKqdIzwWp7+nCLsY6hsqm/ilh3K6qIy3
 d4k7VLvXkhCSl9U/3zjEwDdB2gE6m1a64wZasa9W+U8BR6Pyy8t44aBi9BX3NkRwl085
 v2BVxw35QKMWKG77AwoKGhZA63ZT1T48ITDtkAkmRU6elPW5IPq6uWDTpgXMvn2v7suM
 OhyK96rxy2yf+XQ62Ea2mexOWa5C08YDtlTaoCqj4Wy6F2a5hdnz83dGtuuf7Pwje6X3
 4dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789413669; x=1790018469;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rfdoL6rblesATy78XaqPUOTQSUXFXdMPKdKplUsnJcY=;
 b=VtgDbdQ9Hqg3KYonucdSBr5v9oajwb6p0cFGlOy3GBH2RnybpYm45qbY5PSwpD5ydD
 hNXUeuiDnqZGp3yc4TqWhWpkOowd6EV+mg5AdqN50BulKo1DDs0PEx+Bm9rY4F+dcAU4
 XnHdERvauyCpc4JRVd2yOqLB1bsOOie2myWUNidWZr/FW9Fpk9MATqVQbOmY0W+h/dBE
 mFfEuy2t82XBy5xB8QMYPKNqvXmfvQM4XqOHHY2hIewmyS/Y6VOdu6OrniF91M6JOmTL
 GXg2kN9/AxmbYGnjohUoH8G//t67q2xgpcnzDXaml4tNbL0gDPGfwgOO+ockXXL0EZ0B
 USig==
X-Gm-Message-State: AFuF++nnqnxNBpKYlgP1/yMdquRwZ/g2nmQHF+yR2G9f06m5iuChfsqJ
 aUC6+bxVMWIzBV4PxuuG0pBteSpVVA5wQGJFyjJbXteUWNUa3hE9B50jhcfSlPi3egsa3X3E007
 lzeb5Wzk=
X-Gm-Gg: AYBFou0fl/FQGVu+AdwqDm3i9IhQpuUeBh4hWxH5wKFnayFenJXCmWh8+Z1YREKNZr8
 cSBswHQhk8zEvARWbcNQnnvV0ZgdSynE6SkKerDL1xQDhSOEpT1v0ZZFWdQnae20KQTJRUOxOtu
 CWmHLsbFVunK7xLqRH2XYXFWldZQN4BjfbvBZv0b1xGoUaP7U/0C1BFyhNVUtW9ap9LeIZ6waHE
 szrdCVrMAN2qayb2GZ3kol3S6ZhOyl3a0kB98lq0gRmdFtzJlAOvGVPTGYjGwizt6wPAkBAZQOv
 TwWIwZDhU/B53dS4MaiilCJiIZpX2tPuMjwr+HiUukZEXoQfXEKjnqX/Mw1aI/nb38s9cf8e6ex
 0A2luwVSaTsVGLvj2Hf/sCFzPczHeauzS8AB0EFMlsJfeZADKiVzvhG70shaAuD8ChZA5WLHVmb
 b/tSzTswmlF8PKZjdyEAgXph6LR+VnWVMzXJ6Nuw6Gm4OaF4f2CsAZU3nCzC87OkNx+bcaMyR+G
 xsby6WceXCDLWGQU4OzKOMJbUvcvg5MEJk1ppKbteIJTZpXpK3fb0l4/mfqEg==
X-Received: by 2002:a05:6a21:113:b0:3da:9f19:bf2 with SMTP id
 adf61e73a8af0-3db4064eb93mr9515445637.18.1789413668844; 
 Mon, 14 Sep 2026 12:21:08 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm31035923eec.28.2026.09.14.12.21.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:21:08 -0700 (PDT)
Message-ID: <d9abde2c-9993-4d44-b2c0-e5cdd1e5d22d@linaro.org>
Date: Mon, 14 Sep 2026 09:21:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] system: report acclerator security status in
 help output
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-6-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::15;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x15.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> When '-accel help' is given, report the security status of each
> accelerator.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   system/vl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

