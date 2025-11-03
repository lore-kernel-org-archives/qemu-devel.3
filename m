Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A0CCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvHl-0004fA-UP; Mon, 03 Nov 2025 09:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vFto5-0001bN-Dh
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:37:09 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1vFtnv-0008LS-JW
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 07:37:09 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C9C9D40427;
 Mon,  3 Nov 2025 12:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44427C4CEE7;
 Mon,  3 Nov 2025 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762173412;
 bh=mWXdrHzOCRUUaCb0tdaBxxtD+lIZ+f5mNku2nKMaono=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kzrpDEvFz5wO0fVEBdrUMYv0aJE43oOivJZZqX0kRqTl97knQRMcAwbUmPC63Y9LR
 bEBu60NxW/YaIhnhJ04hcraXBj7ro1TEwAqoQtskHDuccZ1jkMngOo9DFXZesJvjL2
 7PEmZl6JHbM8dc1dq/nKxCvDIFS/Sjyxn59SNTGelHpj9BM4rEUc5EEOsjzx6TCANs
 vCEZGlSNe31tE/6CFNUWiWxaktiQWYCmPcspK5K5v3adTmWS291vciPrTP1mTR5gCZ
 8TClLIChV0ueYk4WXtGjF1xVJoQZuI2iuSMCr4PpFb4pe/szb6X++hb2cgovGonRa3
 UijQ4v9E0nS6A==
Message-ID: <07c41b89-2e4b-423c-9577-93001112b04d@kernel.org>
Date: Mon, 3 Nov 2025 13:36:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 qemu-devel@nongnu.org, imammedo@redhat.com
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <c35a21dd-40e5-4fa5-87c4-18ebe8ca73ca@redhat.com>
 <2d0d56d5-72e3-4ae6-b657-96522fde6149@amd.com>
 <eb1b524d-3a8c-481b-85eb-6697f5ee332b@redhat.com>
 <1fc33dfc-ae73-4d23-a21a-a3a5ed480dd1@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <1fc33dfc-ae73-4d23-a21a-a3a5ed480dd1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=david@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 03 Nov 2025 09:11:47 -0500
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

On 03.11.25 04:01, Huang, FangSheng (Jerry) wrote:
> Hi David,

Hi!

> 
> I hope this email finds you well. I wanted to follow up on the SPM
> patch series we discussed back in October.
> 
> I'm reaching out to check on the current status and see if there's
> anything else I should address or any additional information I can
> provide.
> 
> Thank you for your time and guidance on this!

I just commented on the implementation, I think it can be simplified.

Regarding the overall idea it would be great to learn whether Igor as 
any more concerns.

Cheers,

David

