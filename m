Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB13CC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjRb-00007R-Pv; Fri, 05 Apr 2024 09:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rsjRL-0008Qp-PC; Fri, 05 Apr 2024 09:17:09 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rsjRE-0003A9-CQ; Fri, 05 Apr 2024 09:17:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:72a:0:640:b4cc:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9335060DC2;
 Fri,  5 Apr 2024 16:16:50 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b538::1:32] (unknown
 [2a02:6b8:b081:b538::1:32])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nGV04K0GZW20-pTQ4DPX7; Fri, 05 Apr 2024 16:16:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712323009;
 bh=0B+tS775upLBtLxY66R68aU9+UdrWvVGnRVoavuCSag=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dvh/kBQC12Yd4pkNS7/+6OEHvgycj89R5VO/TbIvF21hxS/+MQ+8NMegvwGbiRUsJ
 NQaGEBXaLUCO709qxrYackHvN4LuVliJNWN9I5eeP6MGUAiR02YTcpRBDhAgKVcAOW
 fQCvkZ+aueScEt7y4vyDrGCRvho0rCEmnEchN6IQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f43f10bd-87f5-4361-a074-a18b892225b4@yandex-team.ru>
Date: Fri, 5 Apr 2024 16:16:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] blockcommit: Reopen base image as RO after abort
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20240404091136.129811-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240404091136.129811-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.04.24 12:11, Alexander Ivanov wrote:
> If a blockcommit is aborted the base image remains in RW mode, that leads
> to a fail of subsequent live migration.
> 
> How to reproduce:
>    $ virsh snapshot-create-as vm snp1 --disk-only
> 
>    *** write something to the disk inside the guest ***
> 
>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
>    $ lsof /vzt/vm.qcow2
>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
>    $ cat /proc/433203/fdinfo/45
>    pos:    0
>    flags:  02140002 <==== The last 2 means RW mode
> 
> If the base image is in RW mode at the end of blockcommit and was in RO
> mode before blockcommit, reopen the base BDS in RO.
> 
> Signed-off-by: Alexander Ivanov<alexander.ivanov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

Thanks, applied to my block branch.

-- 
Best regards,
Vladimir


