Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DBC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZKL-0000IV-L2; Tue, 15 Jul 2025 02:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubZDM-00021G-1V
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:32:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ubZDH-0003XA-Rs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:32:31 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56F6W02B093950
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 15 Jul 2025 15:32:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2kt60vtMY2DfOE87U/cuxC8H5R+F/KM3jrCkiEYwAnA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752561120; v=1;
 b=Onv2sDB6mQbvWQOEbwH4J4wi851MjdiSl+MRTV9UqlsKaWudn38bMRy9KIaVFEVt
 2aAV0WL73qlMgBhLCKyqI5Jkiu3+Xz0+gOgNHpwkRvtVHSmMuQC0CKHeDuIIrIBT
 vGkuc0CifzDfxXgpNpFb3cBTgtL9BbOxzUQvWW2soPPis3LF2dhgvQK6Bxw07EVH
 aY1mzoejqXDxZxencv8DETa+4Cg6iJKtHaO2zBMDxRPvUC3nYWAUsltfUy6aqS3B
 YeqZdTWi1A8Dc3nAPBs+pVWJ8ww/1RTRp/OgEbpf2lmEHysBEnI93wJULOIi3TBT
 CJYMn3vMQ+yx2wXoLfMqlw==
Message-ID: <0704cc6b-0001-4c38-9dfa-d16e6b3df1b2@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 15 Jul 2025 15:32:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gtk: Skip drawing if console surface is NULL
To: Weifeng Liu <weifeng.liu.z@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>
References: <20250714141758.10062-1-weifeng.liu.z@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250714141758.10062-1-weifeng.liu.z@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/14 23:17, Weifeng Liu wrote:
> In gtk draw/render callbacks, add an early NULL check for the console
> surface and skip drawing if it's NULL. Otherwise, attempting to fetch
> its width and height crash. This change fixes Coverity CID 1610328.
> 
> In practice, this case wouldn't happen at all because we always install
> a placeholder surface to the console when there is nothing to display.
> 
> Resolves: Coverity CID 1610328
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

