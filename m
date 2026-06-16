Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765EDCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZL8R-0005hw-Kv; Tue, 16 Jun 2026 00:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wZL8O-0005hg-SS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:10:45 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wZL8K-0007Wd-UY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781583025;
 bh=5mmdOBRANMCgcm506FKmwzUH9jKo1MyBDOyxBAJGrw8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kOuzxGZIFdBo1Zj2VfSi61PneZUYfwQcQksSpaBQtgR1n/8Lz38DcxBeAgdGICxhu
 P6GkeODgmrLMdi7E5nygiX6uwZUK5LUUKiQmwa1qTna+a+zjlC4GENyUIySIed4ynf
 OBjmXHYe4xkfp8JEEgdZO4Xgn74Bg5C59A50vlh//I/32/N9uLBzmQvz8Y/PMqSa1j
 29HE1qe23cGvmqN+HfzXVi0L/K4NPY8UiH/1T2QVXJxJRzk4xFfAz3fUftNnoLl39F
 LssZ+ji25T6tFN9SsdMS0xhWbN9lzJ2GiXCY4G0QtsgNhJako4/ApCpMrfCl9znBQw
 iZlvFRMRc1+HQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 0D21D2FF379;
 Tue, 16 Jun 2026 04:10:25 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0777237C8C7;
 Tue, 16 Jun 2026 12:10:23 +0800 (CST)
Message-ID: <ec256e96-5519-40ac-a0cd-b16acb6e8e04@sjtu.edu.cn>
Date: Tue, 16 Jun 2026 12:10:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: use int64_t for the syscall filter return
 value
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
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
 <bd162496-6325-4f96-8ad7-72fbfb3e89f8@sjtu.edu.cn>
 <102068b3-f181-49f4-addc-4444afbc03a9@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <102068b3-f181-49f4-addc-4444afbc03a9@oss.qualcomm.com>
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

Hi Pierrick,

On Mon, 15 Jun 2026 10:46:16 -0700, Pierrick Bouvier wrote:
> We can't expose target dependent types, so having unsigned types for
> args and ret was the correct thing to do. This way, a plugin can decide
> to use any bit pattern, and upper part is discarded if needed.
> 
> For args, we explicitly clamp values depending on target:
> https://gitlab.com/qemu-project/qemu/-/blob/master/plugins/core.c?ref_type=heads#L554
> 
> For ret, the type conversion is handled by writing ret to a temporary
> variable, before sending it back:
> https://gitlab.com/qemu-project/qemu/-/blob/master/linux-user/syscall.c?ref_type=heads#L14622
> 
> Indeed, there is an inconsistency between syscall_ret and syscall_filter
> on that. However, they do different things:
> - syscall_ret will read the value, so having a signed is mandatory.
> `if ret < 0` needs to work.
> - syscall_filter will only set it, so having a signed in not mandatory.
> `*ret = -1` still does what is expected.
> 
>  From that, I'm not sure any change is needed, but feel free to point a
> use case I missed where this matter for syscall filter.
> 
> Regards,
> Pierrick

You're right, and thanks for the detailed explanation. There is no
correctness issue here: the filter only sets sysret, and *sysret = -1
behaves the same whether the pointer is signed or unsigned, so nothing
is functionally broken.

My concern is purely about consistency. The syscall return value appears
in both callbacks: qemu_plugin_vcpu_syscall_filter_cb_t passes it as a
writable sysret and qemu_plugin_vcpu_syscall_ret_cb_t passes it as a
readable value, but in both it is the same kind of thing, a syscall
return value, whose semantics are inherently signed (the negative range
encodes errno). Having the write side use uint64_t while the read side
uses int64_t looks surprising to a plugin user, since it is the same
signed quantity in both places. Keeping the two consistent makes the
intent clearer, and as a bonus lets a filter write *sysret = -EINVAL
without an implicit signed to unsigned conversion.

As you say this is not mandatory, so I am happy to drop it if you would
rather leave it as is. It just seemed like a small readability
improvement given the two callbacks describe the same value.

Regards,
Ziyang Zhang


