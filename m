Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F30606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=MiCl47Mh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLwqJ-0002xg-D7; Wed, 28 Oct 2026 02:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLwqD-0002xI-Fa; Wed, 28 Oct 2026 02:08:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLwq2-00020G-HR; Wed, 28 Oct 2026 02:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793167717; bh=Uc9+e+8ooESDUhJ4hSBfvsn2zlFsq91BCzmNkVyyDRQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MiCl47Mhx4IxbK2T4GJc5Lkhnkt2uukCaopyrGN2pde4VbTjRCuM8nzLLVhkh8Ca/
 S4HY9JgC6ErdUeEQA09Da+vn6yDV8wKEsfZkrwv+5rUXYMOBEx/zO9SJERJzm3o4U5
 84PRtkQAepeGykFe+/g3npKCJqjpA2EP2ssabhfxxrqrG97c/ZsPpmaEqwPAvp3czN
 tlbO9tiRN9IVww1Hw3JKoFPVOzHfeSEnJxq0xXa2CcekAq24zAt3ECjH3vVFn4MWQ/
 6+ezcW6o76T2Bb3/v0UwkabHNDDglNdpqNokMQ3HAKTzeGfUDDcMxMFyhPegB5pnyR
 WQ9cDEoWDfpDg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E8CE41E1CE1;
 Wed, 28 Oct 2026 09:08:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE57B44D2BF;
 Wed, 28 Oct 2026 09:08:37 +0300 (MSK)
Message-ID: <c7e81851-5f76-4799-9c4f-4bea1e14d46b@tls.msk.ru>
Date: Wed, 28 Oct 2026 09:08:37 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20261012140839.93559-1-tcalifano@redhat.com>
 <55d79d30-cd7b-4673-8fda-434fd701313e@oss.qualcomm.com>
 <4e55719d-647a-4163-87b1-950a89144d48@tls.msk.ru>
 <8ee2e12e-e416-4a3c-8351-54d12d3ee640@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <8ee2e12e-e416-4a3c-8351-54d12d3ee640@oss.qualcomm.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 22:25, Philippe Mathieu-Daudé wrote:
> On 27/10/26 20:10, Michael Tokarev wrote:

>> Curious, why did you send this email?
> 
> Hmm I had this patch queued in my hw-misc queue and had to drop it.
> I'll update my script to stop bugging the list with unuseful info.

It might not be useless, just a bit unclear :)

Thanks,

/mjt

