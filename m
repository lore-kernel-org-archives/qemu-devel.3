Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B3AC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2W71-0001Ze-LT; Fri, 04 Sep 2026 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x2W6y-0001ZD-SW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:45:52 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x2W6w-0002zb-1C
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:45:52 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 684Fjfnk088775
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 5 Sep 2026 00:45:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZXnz4LrWFltezmWHChKm30Hf9Bb2ArjnyAtYpyx1G8E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788536741; v=1;
 b=kGrXT1zSolHdN9FbWjDoblA/yTFvc7avV7fE3cmh+nwcAkSOzxsNEIILuSfGa24P
 ImRGMzRPag5bfwD9rGYFTrXasFsaMbL3SVokpz9QndCu//zJ6Yl0V2e8AFjtxHaN
 ZbHNDR+I4og4DtGxugwkno7Aeqj2/Z5+n13GeVWxX+qqnuzntl5X4D2qsdkITXm9
 MHFtyAixSIR6IcAa6rtqKe0nsU0r8wQpqQNyGaDc+++ImwtzBZnBVyhgaA6kLV5C
 hMe7oCdxHX7TD7VP0JXfkvrVirkAYr0rQx6/r8N2Oi4kc5nsk5giw9n2Wnw16YTx
 CWvfmmWuVTKHgQc4m7YiKQ==
Message-ID: <2fb29042-9403-476f-b45e-c5ef5f5ed93d@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 5 Sep 2026 00:45:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/dbus: fix cursor race, copy cursor data
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260904123020.3108205-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904123020.3108205-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/09/04 21:30, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Eliminates the undefined behavior where virtio-gpu's memcpy() overwrites
> the buffer that an in-flight gvariant still references. Fixes the data
> race where the GDBus worker thread calls cursor_unref() concurrently
> with main thread.
> 
> Fixes: 142ca628a733 ("ui: add a D-Bus display backend")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

