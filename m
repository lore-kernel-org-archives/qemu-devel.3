Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1DCCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY1Jg-0001sb-VH; Fri, 12 Jun 2026 08:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wY1JB-0001pp-6O
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 08:48:26 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wY1J8-00032R-7w
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 08:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781268491;
 bh=Dp9/QpixrUQwl0m1O4IGpeJh2gGSl8J9nef1+f6foFE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GPabOskqKNqE5tNrci9a0OrTLYLoH14+yhz1UFxgtQS0WokGKHiviNV4c8RMUVho8
 yD/QekSfMRTDGegTYtmZ+qXZpSQEF8vz6oTIV7B8roJu6ualJ+Q19ZBQ4yFdesZRQm
 V4Bnh4A4WUK3UuJieZmj72JjlbVchhiFlIotBnbXe8lZVruOnMZdbv7PuKdhBMPS4X
 LnQ24c3f/+oPzUiLMOcRv0qViexhoKU8zjwF6wO+xW6TZfgtgQACbdzAHTEFopVK6E
 nU2tW+hb2Q/NY3xN5cbtX7u0vp1gcDc+/AK2tQSYxRdXlWgErChfbV8XKpAG389irO
 WKpxNrPL0BMcQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id D0F8A2FF3FD;
 Fri, 12 Jun 2026 12:48:11 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 9A8F837C934;
 Fri, 12 Jun 2026 20:48:10 +0800 (CST)
Message-ID: <bd162496-6325-4f96-8ad7-72fbfb3e89f8@sjtu.edu.cn>
Date: Fri, 12 Jun 2026 20:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: use int64_t for the syscall filter return
 value
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260612055642.589337-1-functioner@sjtu.edu.cn>
 <20260612055642.589337-2-functioner@sjtu.edu.cn>
 <87se6sdonm.fsf@draig.linaro.org>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <87se6sdonm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On Fri, 12 Jun 2026 11:43:57 +0100, Alex Bennée wrote:
> All of the arguments here are abi_long which go to int32_t or
> target_long->int64_t so perhaps we should be using that for all args to
> ensure signedness is correct?
You're right that abi_long is signed. I only changed the return value to
keep this callback consistent with the two syscall callbacks that
existed from the first version of the plugin syscall API:
qemu_plugin_vcpu_syscall_cb_t and qemu_plugin_vcpu_syscall_ret_cb_t.
Both use int64_t for num and int64_t for the return value, while the
entry callback passes a1..a8 as uint64_t. This patch matches that.

I'd prefer to keep the arguments as uint64_t. They don't share a single
signedness: pointers and size_t are unsigned, while offsets and fds are
signed. At this boundary they are just register-width words that the
handler casts per syscall, so the correct extension is per-argument-type
(glibc handles them that way too [1]), and forcing them all to int64_t
would be wrong for pointer arguments in particular.

Changing the whole argument vector would also touch several APIs and all
their callers, which is well beyond the scope of this small signedness
fix. So I'd rather keep it to the return value, the one part of this
interface with a well-defined signed meaning.

[1] 
https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/x86_64/x32/sysdep.h#L50

Thanks,
Ziyang Zhang

