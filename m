Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD70C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyT65-0002EK-N7; Mon, 24 Aug 2026 07:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wyT64-0002EB-2Y
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:44:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wyT61-0008A0-BK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:44:11 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67OBi0fP012812
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 24 Aug 2026 20:44:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=U52YaPxTOek5l+fYjrz29Kzkrl02OWP68JPjrBsSZHE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787571840; v=1;
 b=Iq1gR2SrMy60qJhdbGQFoq/d361ISH67hWQfv7UZAHPxBuGb0bFMEM0X4Ehuygkk
 lQ7J8fJroicq1x+cdw2Urk3O52YrsRox39C13me+OllXJdpMaKVdyzxhL+XAd2Fi
 TvlbjEe/n85RvefNPiwgcAVt/urbHGRw1Qne8JW5caTtRT+uUijFtMtOX1d8gfYF
 VRKU/JJ+IoEAghEpZvT3YMQ5pU8+yZ/VhNL+ycgh1Hx1aYYmWTXmQVLbwCzPdRtI
 7YxeAlBAcxlofViblZRz30C5DchabxHfcyDztMm+IVX5GlRmzlvXBGlKNdMklbOG
 xdJ5bY2tGwnnW3n6UZcgZA==
Message-ID: <4428c2c5-32a2-4c93-9ad4-5f10e9606fd6@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 24 Aug 2026 20:44:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/egl: fix render node cleanup order
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260820132014.2729748-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260820132014.2729748-1-marcandre.lureau@redhat.com>
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

On 2026/08/20 22:20, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ASAN detected some memory leaks when terminating. Release thread-bound
> EGL state first, destroy the context and terminate the display while the
> GBM device is still alive, then destroy GBM and close the render-node
> fd.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

You may also add:

Fixes: a3cf9b55bbdc ("ui/egl: implement display and EGL cleanup")

Regards,
Akihiko Odaki

