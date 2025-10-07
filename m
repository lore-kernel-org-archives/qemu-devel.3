Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71C1CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 15:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v69Nu-00071j-Os; Tue, 07 Oct 2025 11:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v69Nr-00070f-AT; Tue, 07 Oct 2025 11:13:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v69NU-0001SC-W2; Tue, 07 Oct 2025 11:13:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2EA77807B9;
 Tue, 07 Oct 2025 18:13:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:152::1:3c] (unknown
 [2a02:6bf:8080:152::1:3c])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DDnklL0FoW20-M3EFNryr; Tue, 07 Oct 2025 18:13:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759849993;
 bh=FVyQvGVcMvweMXMBrcSoIzx4/Q1nsQnlRoU2RPn6I6Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=C5sD+zGuxnQWiFJSP7/6Eeqe7+lZBIw3ZUNh9N8fa1dnAizL++kXAkhkp3Fx2ax79
 CaLAvWIidj+qUd29rdtpc//tgV8t3jk+pPHVQiYddMocNEmp4/CGOnkbSIhy9CGwPv
 JNjCLj81EUa3Orz7t+c/F9KA0xLTBGqbuqejgJFM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0ce196f8-e881-4273-bf9d-e9c0b4f7f308@yandex-team.ru>
Date: Tue, 7 Oct 2025 18:13:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] file-posix: populate pwrite_zeroes_alignment
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>, Hanna Reitz <hreitz@redhat.com>
References: <20251007141700.71891-1-stefanha@redhat.com>
 <20251007141700.71891-2-stefanha@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251007141700.71891-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 07.10.25 17:16, Stefan Hajnoczi wrote:
> Linux block devices require write zeroes alignment whereas files do not.
> 
> It may come as a surprise that block devices opened in buffered I/O mode
> require the alignment for write zeroes requests although normal
> read/write requests do not.
> 
> Therefore it is necessary to populate the pwrite_zeroes_alignment field.
> 
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

