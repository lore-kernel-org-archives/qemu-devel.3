Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8298CCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 02:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIHgy-0001rV-UG; Sun, 09 Nov 2025 21:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kripper@imatronix.cl>)
 id 1vIHgq-0001oY-EB
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 21:31:33 -0500
Received: from ip47.imatronix.com ([200.63.97.110]
 helo=virtualmin.imatronix.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kripper@imatronix.cl>)
 id 1vIHgn-0002mS-0u
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 21:31:32 -0500
Received: from [192.168.1.51] (unknown [156.193.167.209])
 by virtualmin.imatronix.com (Postfix) with ESMTPSA id ECC7B411F8B8
 for <qemu-devel@nongnu.org>; Sun,  9 Nov 2025 23:31:21 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.11.0 virtualmin.imatronix.com ECC7B411F8B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imatronix.cl;
 s=202505; t=1762741882;
 bh=FzHhyhK8/axBBBNf2hSpz6Uu/Kk6tIF36u3QLCiUSKY=;
 h=Date:From:To:Subject:From;
 b=NwKt8ywdVkZ2YI7B+D889hvLmNR3GgnbtxG2ovIQwMBNoXxmMPOFQENxUR3ilV6sR
 pa1xA5MluB0QaFvlAq58MQfFRyhL0VbmR/mrVorJedKdQfVQ8Y56QNTcIBIQR5x256
 4SRUvKrawim8WSad3CyYYUdRnoy5LcN60TTManEb7RRtoTB/m21rhnEEyt+xnT9Bvt
 Jil4ZUqzlOeHTD+rOh206ObS3LZPt+VRP3XGpT5kZ4Cj7rSFEBR/4uUo3FJseWB+1o
 wucmD0dnpx6eBu6nPVoHtabvyC/54hIKeXG9LFWsN8DsofefAfnxCRn3ISgj1vPf7b
 knfIzfu1E973w==
Message-ID: <aea951a3-6e83-4ec1-b287-4d7dba14b674@imatronix.cl>
Date: Sun, 9 Nov 2025 23:31:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Christopher Pereira <kripper@imatronix.cl>
Organization: IMATRONIX S.A.
To: qemu-devel@nongnu.org
Subject: Compact backing chain (sparsify + compress)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=200.63.97.110; envelope-from=kripper@imatronix.cl;
 helo=virtualmin.imatronix.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

I would like to revisit this old thread from 2016 with a special use 
case that I believe should be a standard `virsh` command:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03571.html

**Summary:**

Given this QEMU backing chain:
`base <- snap1 <- snap2 <- snap3 (active)`

We want to merge `base <- snap1 <- snap2` into a new snapshot 
`collapsed-base` that is:
1. Sparsified (`virt-sparsify`)
2. Compressed

The resulting backing chain would be:
`collapsed-base <- snap3 (active)`

**Motivation:**

- We perform daily backup snapshots and never modify existing files (too 
dangerous). We only rebase.
- We collapse older chains into a new `collapsed-base` snapshot to limit 
chain size and avoid performance degradation.

We have been doing this successfully for over 10 years using:

- `qemu-img convert`
- `virt-sparsify`
- `virsh save`
- `qemu-img rebase`
- `virsh resume`

**Problems:**

- There is a small downtime due to `virsh save`/`resume`.
- In recent QEMU versions, `virsh` adds a `backingStore` tag to the XML 
even when using the `--no-metadata` option. This causes inconsistencies 
after `qemu-img rebase`.

We didn’t use QMP because it didn’t support sparsify + compression in 
the past.

**Questions:**

- Is there now a better way to achieve this?
- Could this feature be implemented or supported directly in `virsh`?

In my opinion, this would be the ideal backup solution: we could travel 
in time, sync immutable snapshots to a remote backup server, and 
maintain performance.


