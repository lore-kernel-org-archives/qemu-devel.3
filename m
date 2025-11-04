Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C13FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHuX-0003yi-CZ; Tue, 04 Nov 2025 09:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1vGHuU-0003y8-8p; Tue, 04 Nov 2025 09:21:22 -0500
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1vGHuR-00069v-69; Tue, 04 Nov 2025 09:21:22 -0500
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 03ED71520F25;
 Tue,  4 Nov 2025 15:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1762266072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQxk1mchNBo9GYfzOK5XPeMoJ2boXqYPYW5ywn7E/LQ=;
 b=ggW48HRs4FTDLX8GoCGye6qQJcIkNNF+Av9q4OkEa61fdxqpe99jPZSDE7faJvTwunz+9/
 Yt9Xv/vwqqU13s1i4dxr4OPS1s8hmuz3D/sLCcHeWAvdB4vQ8sJDdIjzD+RTBBmqjjnp/F
 3zCqlxirzkZ9eUVZSYXq1sIJgU2CRu9F0hdGGDDHevV0BCDT0SgcnylNTncrwPKym0bGP6
 B4LMZvk2WKJYzGma5jkEHPv3T1E+O2BSNzdNv0YOEeFQVds14Z/HV1FgKoFhWpI81PU/Ij
 B5h8C0lRKKaX+KADnE8nElo+J6fl7cFq+oIxwSmzVFBP69mQzrYqlhA3thCJzw==
Message-ID: <4d304a26-4862-4815-b9a1-d80c4416a16c@dupond.be>
Date: Tue, 4 Nov 2025 15:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qcow2: queue discards when discard-no-unref enabled
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
References: <20250513132628.1055549-1-jean-louis@dupond.be>
 <8d2033db-34e3-434a-aaae-22fe538ddbb6@dupond.be>
Content-Language: en-US, en-GB, nl-BE
In-Reply-To: <8d2033db-34e3-434a-aaae-22fe538ddbb6@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


On 29/08/2025 11:43, Jean-Louis Dupond wrote:
> On 13/05/2025 15:26, Jean-Louis Dupond wrote:
>> Partially based on the proposal of Andrey in
>> https://patchew.org/QEMU/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com/ 
>>
>> Split up this from the rest might get it merged a bit quicker 
>> hopefully :)
>>
>> Since the implementation of discard-no-unref, we did not queue the 
>> discards correctly
>> when discard-no-unref was enabled.
>>
>> Jean-Louis Dupond (2):
>>    qcow2: rename update_refcount_discard to queue_discard
>>    qcow2: put discards in discard queue when discard-no-unref is enabled
>>
>>   block/qcow2-cluster.c  | 16 ++++++----------
>>   block/qcow2-refcount.c | 25 +++++++++++++++++++++----
>>   block/qcow2.h          |  4 ++++
>>   3 files changed, 31 insertions(+), 14 deletions(-)
>>
> This was already reviewed.
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Any chance on getting this merged?
Kind reminder :)
>
> Thanks
> Jean-Louis
>

