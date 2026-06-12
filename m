Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2764CD4F2C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwoE-0004g8-1F; Fri, 12 Jun 2026 04:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wXwoB-0004eG-9i
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:00:07 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wXwo7-0006kx-GD
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781251195;
 bh=G/V5/EcHNJbREIPC5YRGlK3cJWo3mJ0PtudbdPYETBw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oiIncb4nT6dcEKSbntw2mkU5MwhzKxU/+URRUSJkSkkpiUnE/Dj+CofCbq2joHER5
 KR77tOucjsvlT4adQozJk3F1apIKEQxpAaUbQQ/nWnTYiU4GVQzlIltT/i1TkkstZO
 EeT74JAKXZiQsfnoz7U2zwi5xcQqc+SKgu2mVihrBP/lufjpzSHHDkzTUnkjieXYxV
 X/pEaZbYAhV75DxGYNDM0XjkEl8cuFy+/ffAH0+6pM6FpfrW2KJxyYdU6kaN3zISHf
 JmPw3StDSW8tVPKfgeuVI+JKAbbvhsJaMjzp3/bWm2GX46VKSh3EC1IxkmgQFHwix1
 vXycVXNQ068ng==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id F2BA32FF4AE;
 Fri, 12 Jun 2026 07:59:54 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 7314437C941;
 Fri, 12 Jun 2026 15:59:54 +0800 (CST)
Message-ID: <79ab65c5-b16e-41c3-b815-df87ba09f89a@sjtu.edu.cn>
Date: Fri, 12 Jun 2026 15:59:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] plugins: fix syscall filter return value type
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260612055642.589337-1-functioner@sjtu.edu.cn>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <20260612055642.589337-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
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

On Fri, 12 Jun 2026 13:56:41 +0800, Ziyang Zhang wrote:
> Hi,
> 
> The syscall filter plugin interface was introduced by me earlier.

Syscall filter PATCH reference:
https://lore.kernel.org/qemu-devel/20251214144620.179282-1-functioner@sjtu.edu.cn/

