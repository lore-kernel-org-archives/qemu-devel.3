Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDECE95A8E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 20:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vag2o-0007Wx-GX; Tue, 30 Dec 2025 15:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vag2X-0007W5-IM
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 15:09:57 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vag2W-0001uL-7m
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 15:09:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A2ACD406FF;
 Tue, 30 Dec 2025 20:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A9C4CEFB;
 Tue, 30 Dec 2025 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767125386;
 bh=aqrOF7X5C4o8/+26DTyO9tGelKslMskHPwbK+xdniko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eg+ZR+BlE8aJZJxJY6YP/5A8qtLiTWPieqO/5Rw0RfZA4rLvbs91JhzbydEWP88+H
 7oZ/kG9cxHbizi1OA3AT/OiNVCNMP0TGrbcCA3zTGRJTMcw47mZyZuFm0Z3tiXxT5F
 s/CpdQNd244rOWBpvzU4x8twLRbgAlX8DhrCqcMPLSK9M3cX9t1w1ICMvuQqR0wRz8
 aLnduYWc3cZX6/g25wutVSgJj98EUdiqb/23s+3FkZd4YRauRQ2njngPp3jWG5u+9D
 SDvMBynGGRSh8iT97wcEItykf0IWzO2QSuaeVj6YzFk1WvTevctD5CAREGEHIW3jhX
 MeOnMfGZL3amw==
Message-ID: <9713eeae-65fb-4b6e-b5c8-5ffc2c5b4044@kernel.org>
Date: Tue, 30 Dec 2025 21:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] numa: add 'spm' option for Specific Purpose Memory
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com, Alistair Popple <apopple@nvidia.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 Paul Blinzer <Paul.Blinzer@amd.com>, dan.j.williams@intel.com
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <20251209093841.2250527-2-FangSheng.Huang@amd.com>
 <20251223095605.0000065d@huawei.com>
 <586a3535-ffa1-4d13-8bb5-c1b922a90a43@kernel.org>
 <bcad3442-0ed2-4046-a2a6-5176a7530f93@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <bcad3442-0ed2-4046-a2a6-5176a7530f93@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>>
>> Just curious, it's the same on real hardware, right?
>>
> 
> Hi David, could you clarify what you're asking about? Whether the SPM
> semantics are the same, or whether this QEMU implementation matches real
> hardware behavior?

Yes exactly. If it matches real hardware behavior then there are no real 
surprises exposed by the QEMU implementation.

-- 
Cheers

David

