Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDEBF9D0C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcYd-00018O-Dw; Tue, 14 Apr 2026 08:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wCcYX-00017N-O8; Tue, 14 Apr 2026 08:07:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wCcYU-0004YB-An; Tue, 14 Apr 2026 08:07:49 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63EC7Wl1012152
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Apr 2026 21:07:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mfOgw5mTj1Qi2eJsbdXXZOurFL7eVXpYI+Qc6aNj0PY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1776168452; v=1;
 b=UMeYf3KeJDV6IYdpmzDOxj/+0ihOuvp0CyeVfqIa5rKo+Dg+5LVGbXTS2DOtMxGm
 Ge5dvYxIrGKQi1nO9FGfw4ysOLrzgveDVgVYc8TR+ACHi7Z01LY5djGTblKw6Cu7
 GBBkoez2PoTVuigmivjP0wFU1caW1M1vhfZVu3eCVrxWHlEJ64+tQDcHvDBWl5Df
 oQEDVtcasNU3vgKIY3B7r+bfMaIui/CO6kdCOhheqrlteV24bUv58Eues2xGzOZC
 EkuEf6dycwG/be+YXpzt7RHp4WFHWOGJ70B3EjhMlImpkJgdInkvNVDp41++4tbW
 kBXukcXQHZ57iLpgFTt7iQ==
Message-ID: <2dd7e121-bf3f-4ce7-9a1f-fb54369be27b@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 14 Apr 2026 21:07:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cutils: Fix heap corruption under Windows
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
References: <20260414114033.2360-1-shentey@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260414114033.2360-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/04/14 20:40, Bernhard Beschow wrote:
> Under Windows, QEMU would only sporadically start successfully. In the
> G_OS_WIN32 case, get_relocated_path() first determines a cursor
> to the end of the "result" string and then increases its size with
> g_string_set_size(). Since g_string_set_size() may reallocate, the
> cursor may become dangling. Windows may detect this and crash the QEMU
> process with the following message:
> 
>    HEAP: Free Heap block 000000000499B640 modified at 000000000499B684 after it was freed
> 
> Furthermore, QEMU crashes spontaneously, even long after the guest has
> booted. For example, it presumably chrashes due to the guest setting a
> new cursor icon which may be a result of the heap corruption.
> 
> Fix this by determining the cursor on the resized string.
> 
> Fixes: cf60ccc3306c ("cutils: Introduce bundle mechanism")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

