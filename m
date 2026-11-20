Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A7606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=Ru9O3iP8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULbb-00069b-Ui; Fri, 20 Nov 2026 05:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xULba-00069H-1y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:12:30 -0500
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xULbY-0008AY-D6
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:12:29 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.249.176])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jWB3D5svrz3wlp;
 Fri, 20 Nov 2026 10:12:24 +0000 (UTC)
Received: from [10.46.51.33] (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 11:12:24 +0100
Message-ID: <08e2e7c2-46d4-448f-a00d-d155e173793a@ovhcloud.com>
Date: Fri, 20 Nov 2026 11:12:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block/nbd: Refresh the connection on block_resize
To: <eblake@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
 <vsementsov@yandex-team.ru>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <stefanha@redhat.com>, <fam@euphon.net>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
 <20261119144632.232457-4-guillaume.vincke@ovhcloud.com>
 <av8ia-EWRqZXchhR@redhat.com>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <av8ia-EWRqZXchhR@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 2091922027239391709
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEq851oOeV52jdwUOrZfxQKGamfspV0QVqE9Sr1f4+CvIpryTEGAR2e3CWDHsu98rh7XQGbvq9hIxSMSRnLPBN0T+/S22oqjEyWveavw37chZNtqGRFiiwD7lkx9n5rwaHU45rMuynaSHaxKyuzrKSS5ip3Qdrphn42ZJV2gOlsN+btTgZ1Ln/5E2zlSA4PpZ9xaZHo2QQMunL7XV5yOVsQ3YRFsXaCDphEPmXoYBAAAmLBmA/OpyB4rKjBOiSuBwouAQivo6bLr+naq1XIGfGb1ohcXxCeQTgY8iUqFZuKwdxbqn+rtliXaC4Z1r64z3szM49UgVf3ozfcSRbH08V6p61EjEgeZKLczN3qbJyBqyFWANe/vMqKuAxgBneEHraxRltpEqy/mdjAYOOzY4SIDKLBdd/n1hTTfBtwNCt8nuSfJgWREDoOtLybDFDA7175nw+Fo6cbrgb2a1wub9y0Kjp4yD2gCNGK3V08BpJUtaRS5UD/0YdaWUn/WksY1XXH133T5ILTfmdRXfkB8BDJ4Sh5EPXLPcRggMmurBVwCKEtHkL6/l9PaEHdmCyYi2LbYmQYFMCeuyzoUHp4ui/g7bDuGXUJLcHLtTj5lxmIO0Onofik5CxziXw53m9jk0YMXMlRc67d4e1oAfs06328NPAVB9OyOq5+LAV5pYNTAA
DKIM-Signature: a=rsa-sha256; bh=gTX/fb6PURFRiF0TALgVWdp1IxGMs4VucPAjG+lIaq4=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795169545; v=1; 
 b=Ru9O3iP8S24kwCxI7t701Jr+dql5lLC4P0YVccAa50FPyDyaKkZxmfbLgxSCVPzyaelgKUW1
 tjhd/8+R8319Lyq6XXrsy5dDbPwh0orkXbc2+mUnINF8ITSl3elvT5uoc7c6vGAIFBKz9l0hH+P
 tWB0ZYCcCoKXNNpAaSLf5Z9M=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
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

On 11/19/26 17:25, Eric Blake wrote:
> On Thu, Nov 19, 2026 at 03:46:30PM +0100, Guillaume Vincke wrote:
>> When an NBD device is resized, two steps are needed to propagate the
>> information. First, as the size is only exchanged at handshake, the
>> connection needs to be reset. Then, the new size needs to be updated by
>> calling bdrv_co_refresh_total_sectors().
>> The QMP block_resize method, by calling bdrv_co_truncate(), takes care
>> of the second step but, considering the NBD connection is lazy, nothing
>> deals with reconnection when the device is idle.
>>
>> This patch uses the new bdrv_co_refresh_connection() to force the
>> handshake by manually starting the reconnection routine.
>> It creates a clean flow to resize an NBD-backed block device on the
>> server side by closing the connection and calling block_resize.
>> When the node is configured with reconnect-delay=0, refreshing starts
>> the reconnection but returns immediately with -EIO. The management
>> application can handle this case by waiting for the connection to be
>> established and re-running block_resize.
>>
>> To detect disconnection, we peek the channel. This does not detect dead
>> peers or disconnected TLS-secured connections. Therefore, this flow
>> will not work if the server does not disconnect cleanly or if the
>> communication is encrypted.
> 
> This is problematic, since unencrypted traffic is more likely to trip
> over denial of service CVE attacks; is there any way we can make
> client disconnect easier to detect even for TLS clients?
> 

I have to admit I focused on my use case but you are right about the
CVE risk.  I will suggest an implementation that supports TLS in v2.


