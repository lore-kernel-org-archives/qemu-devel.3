Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC4DC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5gfp-0003w2-2d; Sun, 13 Sep 2026 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x5gfl-0003v3-2b; Sun, 13 Sep 2026 05:38:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x5gfi-0008Bg-Sx; Sun, 13 Sep 2026 05:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789292279; bh=eHqiEQQEJSDq24PXF/WoIfIUs/VyXEkibqq75FCIjlM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rJM8YgYx6Y/crIS+5fIpi/odAhR3p7DpmBRO7XFi9vwSdBtr90QuHJ9szBHEkNOmY
 /l/ldVzA8Gbl0jXWqlt1X/mfYDxLPUFJJVoMIvDPm/ZgHN0J//zRUdBbHXqIAwFGJh
 dCuhLxzHaed+jAp5O/8CT72spqJ/65eoP2dwes+B+F1qFx3aXgRw13rmcqABmDaJZJ
 HHdQsu9spDHpfenK65n73y5C+7tB4YxRn8hKfUBZazTC+Fcnt37A1HTCLwJ1NxQXDk
 +m/lD3ITyMUuJnpY7UThBRxhNEUeRtSpoUkgsHf1eyBl+nOG5oBtLu9b+Ny54oF/h9
 nFnMhuRizl1/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56E511D4720;
 Sun, 13 Sep 2026 12:37:59 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC34F427596;
 Sun, 13 Sep 2026 12:38:35 +0300 (MSK)
Message-ID: <f237f0b2-d869-4c7a-a930-b48f2f712cf5@tls.msk.ru>
Date: Sun, 13 Sep 2026 12:38:35 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PULL v2 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260728153849.601939-1-den@openvz.org>
 <52e606b3-507b-4869-bf29-97437d4ff84f@tls.msk.ru>
 <73e4dbf1-9b9b-44a3-8032-9fc443028bb5@tls.msk.ru>
 <a0ba6a1a-fdb8-4a44-9d77-fa818bf02757@tls.msk.ru>
 <ba976401-0982-4b3c-a7c0-54f24a4e61b9@virtuozzo.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ba976401-0982-4b3c-a7c0-54f24a4e61b9@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/12/26 13:18, Denis V. Lunev wrote:

> Please apologize me. I have missed that letter.

Denis, thank you for your reply, and for following-up.

> You approach is correct. Parallels image driver in reality
> in the best case is used for image library at my opinion.
> qemu-img info, qemu-img check, qemu-img convert. We never
> run VMs with it and I believe that is true for the
> whole world. At least the auditory is quite small.
> 
> Your approach is correct. There is no much sense to move
> this to stable.
I see.

I think we can fix at least some of these in stable series
anyway, - it doesn't hurt, as long as it doesn't require
significant maintenance efforts.  Especially when there's
a CVE assigned - people want to be clean of CVE issues,
even if these aren't real issues.  So if it'll come with
a CVE, I'll pick things up, maybe with some previous
fixes in this area to avoid back-porting.

Thank you for the explanation!

/mjt

