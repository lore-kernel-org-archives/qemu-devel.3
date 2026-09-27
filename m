Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA63FC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 19:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAv0o-0005qI-AC; Sun, 27 Sep 2026 15:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAv0k-0005q5-99
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 15:58:10 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAv0i-0002Og-LQ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 15:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790539086; x=1791143886; i=deller@gmx.de;
 bh=I9wqRvtoGq6kWuLpqrYfZlZLGgP6ACPhPlkVVfqa/VM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UPVqVQqh1JjZcxTOy6kCLLX/l/Z2ArldLlEbochvGQP4/LMrjlfhRBjCNRL8Yuon
 8xAeczQzYzxj/pwDvJ3d0hVIkMGyF9YMQzp8qeUqIIPD93FhfNG0OQhXkGPqinadA
 vt3D9qabxbrj2f+vG3HuczGQRW9Eu3ajz3OMor9lSxfYU+MFQWuzt0P+YmPIRiIfa
 qF4FMgDKZcP8RpR8xTgs88uVuvH0mPjkyQDLcj3j+POAnyNYedSL3gJIc3Wpt1sdU
 HqW+57SO6SWoyMOKj7HE+SAxz4vMhEoh9eYf3g/kBgGUF+XHWhrzzCd/gD/eGNxfy
 HqS/1kRnlCosl2BhnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1xJ4TI2hmo-00JflX; Sun, 27
 Sep 2026 21:58:06 +0200
Message-ID: <15546670-c901-47c5-a308-22fb8931e248@gmx.de>
Date: Sun, 27 Sep 2026 21:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] usb/hid: handle mouse feature report for
 wheel/pan multipliers
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-5-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260331170823.72511-5-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIuU51vtz2GipKL1QZ5Hqe0gL/6HsAbG0v/ilH3iq1M3YJ+iPXX
 4WoL/dv2+qfXFyeOF7NIZZd0W5L59Br7USU7Rrth2imuW9uEzOOkzHXJ7PlpX1JSFzg/4J2
 TZqVOK4GV0t1hz8mzTipBJAVgiWhWSJQn/ezZ4CTjVXwhHhF7G9Ea0/IQIesLiIYgitS3Q8
 WH7W1rcdzTceow0tKMb+A==
UI-OutboundReport: notjunk:1;M01:P0:5oUdeKL9fHM=;JBKgzBZ5XgEfsiLXS47OM6NU2Sq
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/31/26 19:08, Soumyajyotii Ssarkar wrote:
> Implement HID feature report handlers (GET_REPORT/SET_REPORT) for
> report ID 0x02 to allow guests to configure wheel/pan resolution
> multipliers.
>=20
> Multiplier encoding:
> - Bits [1:0]: wheel_multiplier (0=3D+-1, 1=3D+-4, 2=3D+-8, 3=3D+-16)
> - Bits [3:2]: pan_multiplier (0=3D+-1, 1=3D+-4, 2=3D+-8, 3=3D+-16)
>=20
> Supports flexible payload formats (with/without report ID byte).
> Allows Windows guests to dynamically adjust scroll sensitivity without
> driver installation.
>=20
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>   hw/usb/dev-hid.c       | 65 ++++++++++++++++++++++++++++++++++++------
>   include/hw/input/hid.h |  2 ++
>   2 files changed, 59 insertions(+), 8 deletions(-)
LGTM,

Reviewed-by: Helge Deller <deller@gmx.de>

