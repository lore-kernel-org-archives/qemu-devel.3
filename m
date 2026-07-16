Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D2C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNw4-00070h-G2; Thu, 16 Jul 2026 11:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkNw0-0006xe-Bq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:23:36 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkNvx-0006mK-DV
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:23:36 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66GFNKFb065921
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2026 00:23:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8/xtml1j7D2eTeyL3SFzlkBooMsohjlpb74qaspMCws=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784215400; v=1;
 b=JCHAiCayVZt/ep0/wP/JcOPU8wF43SVG1SBhzYtpumQallYLXCzwtQdoEzd1iztP
 rZZnYBZIKnM3qrKOD22NiZ7x4onqFlXms5lC24mAYHUnoHXdkYfMBd2UPXUMG52V
 kUrduMGKYCV38povg2AQwoSe9sN3TP7hj8lq5Wrn8GdZiDaCxl4Pbrx9+9vdZ9QR
 xTq7TeMickTYqVFUsfc7KEEc8Fs1N58J5fOczCJOrOueMOn8vhLkSeTHwDO2GmXy
 CJlT7AzbJSH2eO2Ug9GDUjdcUlFT/0CWlJ+6cisiMmNoXJ9H4hi/rrOfJBXhuzUj
 1PY0qupNo0fhIH57DkTLxg==
Message-ID: <7737de1c-b52a-4e5a-a4c8-ff3b813a4086@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 17 Jul 2026 00:23:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: handle migration iov allocation
 failure
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260716144524.3661103-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260716144524.3661103-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/16 23:45, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> An unbounded iov_cnt from the migration stream drives two g_new()
> allocations whose combined size can exceed available memory, causing
> GLib to abort the process.
> 
> Switch to g_try_new() and propagate the failure as a migration error.
> 
> Fixes: 0c244e50ee12 ("virtio-gpu: add live migration support")
> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3753
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

