Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A457C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 06:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy1ZA-00044O-EL; Sun, 23 Aug 2026 02:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wy1Z8-00043j-9f; Sun, 23 Aug 2026 02:20:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wy1Z6-0008F2-H7; Sun, 23 Aug 2026 02:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787465982; bh=pqfaTmS/rkvRST87XkXYkNUAF3Di/GLDEZKDvMZswU4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=x5FAyYCTrSo9+gNX5Ult/215I4+H/zwgEK3iNiZTthJNreTrNODr0w00w1MFqGteH
 tX1aP8OtQ2Zb/Dn8uu/cusmqt9slITihFQsLrGr7Ne0pP/GXZYlNtOIjyyeALHwan+
 Zh+Cz4d9mWcc1jBs4qpHP+ycZ6BTHRp9j2WKc78yrVei7T3JHino3FfrGTEoDlZ2dj
 Z39SK43oVshw1JBjorfv7h0erbetnikzEPdzbYbG5rvNx3J/eSGZK1+KnXMb9p51yG
 XbgYitNZRapJT98cBkUAGrL2nIN6uZHOu4IzMSG7pokZlfmzNLx9antkBBJo3Zqb/r
 7/yhiGiK88BNg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E98A51CD7B4;
 Sun, 23 Aug 2026 09:19:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7C440412734;
 Sun, 23 Aug 2026 09:20:15 +0300 (MSK)
Message-ID: <2816e3b2-aa46-4874-b82e-aae48f51b1d6@tls.msk.ru>
Date: Sun, 23 Aug 2026 09:19:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: unregister vm_change_state handler and
 BHs on device exit (CVE-2026-63322)
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: jianghaotian.sunday@gmail.com, qemu-devel@nongnu.org, philmd@mailo.com,
 vsementsov@yandex-team.ru, farosas@suse.de, qemu-stable@nongnu.org,
 Haotian Jiang <sundayjiang@tencent.com>
References: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
 <1ce9ea25-bd59-47d1-bf26-9c5af0851dc9@redhat.com>
 <CAJ+F1CJMSxZmXWdffp-RaOyx8sBx5v7fBMkrPTGMa+hpNS+Yhg@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAJ+F1CJMSxZmXWdffp-RaOyx8sBx5v7fBMkrPTGMa+hpNS+Yhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

On 7/21/26 18:37, Marc-André Lureau wrote:
[...]
> I am afraid trying to fix the leaks is going into a rabbit hole (at
> least I did). Probably it is best to queue this fix and handle the
> leaks post 11.1 imho
> 
> @jianghaotian.sunday@gmail.com Are you working on a new version?

v11.1.0 is out, and the first stable release after that, v11.1.1,
is about to be frozen (tomorrow) - do we have something here? :)

Thanks,

/mjt


