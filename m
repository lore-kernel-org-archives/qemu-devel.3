Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDDCCD98E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj2F-0007fx-29; Wed, 17 Jun 2026 01:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wZj2C-0007fN-2B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:56 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wZj29-0003yF-Ep
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781674899;
 bh=4nEAJPnhBXE8/X0TZ0dV86nuXZGp8FhmYR5+XrGrnDE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OJmYspgkebpKpwWS5h5Sz7i/9GkW5DzfHslYlx4wlYFpGZr9sleWE/en1IcKlm41H
 b07YH8Znp/2t2yq7nBtufEiw0e7Z1TAcNiRrmtU9m3uwAzBNln/edJEN0EHuAjQZqG
 em1bVhpTnBAmId+ODHR+j3D9UI7dIIlSbDiKtLh61zHcqD5PmYhuMbv98a7vT47zwH
 g36nKgg0g6lYRky1gPTHnLxZUd6yq1LCKpC5iFS07LflPENYpjRThOfXz5QbkQG2Fc
 VtaUb5ECyKkwe9wQtvMqoLp7ehPM4BHgbJMUuIaT4RZtig1oHKtYcOtGW8wfkx2SfY
 EkAGS/ETZei2Q==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 59B762FF3F6;
 Wed, 17 Jun 2026 05:41:39 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 31BF537C951;
 Wed, 17 Jun 2026 13:41:38 +0800 (CST)
Message-ID: <a9765b91-1d96-4549-b160-e3e271880d2a@sjtu.edu.cn>
Date: Wed, 17 Jun 2026 13:41:36 +0800
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
 <ec256e96-5519-40ac-a0cd-b16acb6e8e04@sjtu.edu.cn>
 <848e1ecb-cced-4c6c-a4c5-3daf3ed0edc2@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <848e1ecb-cced-4c6c-a4c5-3daf3ed0edc2@oss.qualcomm.com>
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

On Tue, 16 Jun 2026 11:21:52 -0700, Pierrick Bouvier wrote:
> Would that be ok for you to wait for it to come down (hopefully before
> end of the week), and then publish a new version of yours rebased on
> top? I can ping you once it's merged if you want.

Thanks. I will send a new patch later.

