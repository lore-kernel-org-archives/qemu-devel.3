Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A934109023A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3EvL-0003hl-Up; Thu, 19 Mar 2026 11:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3EvA-0003hN-AE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 11:04:25 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3Ev6-0003Ou-Kp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 11:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1773932648; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=whZxGTx8WR9RAPEKYcbUrdjUvurxFHBSkh2s0QdZeQk=;
 b=iG1Vq26CgGRICvYpHpQoHFAuYwksX4Oom6WHgLq/O9J+2fHqwxYbRg505hfvRPg1cs1Lcl
 O47nGI2A6UpEi0712Y+3CbVSxyCiD/9RV9QbRhw2dyqdz5DBx9fwUkWVWgFRjLPw885NzR
 Dr0hUU5vKy5AxAFTxNDuGedmyLgPJ4HNUqSzeFJ+JPjtpnzF0LKo4y/EZJiXc0NYRplJUV
 YJH10UMjIhTsP+8uC8jWuXdfdbsBvk6uxUT0u/qvcCvvz56iYi2zRMaP09GKyfNokO3Dv2
 M1P34uRiqRMx4Vdhdeikr6uSuCz/MQyErxvrNZKltwiZ6FDb6Z3bmhckOX0KFA==
From: "hongmainquan" <hongmianquan@bytedance.com>
Subject: Re: [RFC V2 0/2] migration: optimize cpr fd lookup using GHashTable
Mime-Version: 1.0
References: <20260319113830.53867-1-hongmianquan@bytedance.com>
 <abv_bPLyZtfDjpPs@x1.local>
Cc: <qemu-devel@nongnu.org>, <farosas@suse.de>, <mark.kanda@oracle.com>, 
 <bchaney@akamai.com>
Message-Id: <6df681fb-0db1-48a1-bac0-a05229fb2c7d@bytedance.com>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Peter Xu" <peterx@redhat.com>
In-Reply-To: <abv_bPLyZtfDjpPs@x1.local>
X-Lms-Return-Path: <lba+269bc1066+22be41+nongnu.org+hongmianquan@bytedance.com>
Date: Thu, 19 Mar 2026 23:03:48 +0800
X-Original-From: hongmainquan <hongmianquan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.127.230.111;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-111.ptr.blmpb.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks for the reminder. I apologize if I missed any specific points=20
from your v1 review. Could you please point out which specific comments=20
I left unanswered? I will address them immediately.
Regarding your main questions in v1 (performance data and why migrate=20
hash), I have updated them in the cover letter of the v2 series, but=20
I'll summarize the answers here directly for your convenience:

1. Why the lookup is slow, and the performance improvement data:=20
Currently, `find_fd` uses a linear search (O(N)) on a QLIST.
The latency increases with a rising number of fds, and the supporting=20
test data is provided in the cover letter.

2. Why migrate a hash instead of migrating a list and reconstructing it:
My primary goal was to accelerate all `find_fd` lookups. To achieve=20
this, the underlying data source needs to be replaced with a hash table.=20
My initial thought was to simply change the fds structure entirely to a=20
GHashTable and migrate it directly. This approach seemed much more=20
straightforward to implement than maintaining a conversion between QLIST=20
and hash, though, as you rightly pointed out, it does inevitably involve=20
changing the CPR ABI.
Secondly, I was concerned about the timing of converting a QLIST to a=20
GHashTable. The conversion must happen when the fds list is in its final=20
state with no further modifications. However, during normal VM=20
operation, there are ongoing operations that save or modify fds. If the=20
GHashTable were merely an auxiliary structure, we need to keep the QLIST=20
and the GHashTable synchronized.
That said, your suggestion makes a lot of sense. If we treat the=20
GHashTable as the primary structure and only convert it to a QLIST in=20
the pre_save hook right before migration=E2=80=94then reconstruct the hash =
table=20
from the QLIST on the destination, it would completely work. This=20
preserves the original QLIST-based migration ABI.
In short, I believe both approaches are technically feasible, but I=20
agree that my current implementation has the downside of breaking the=20
CPR ABI. I look forward to discussing this further with you.

Thanks.

=E5=9C=A8 2026/3/19 21:51, Peter Xu =E5=86=99=E9=81=93:
> On Thu, Mar 19, 2026 at 07:38:28PM +0800, hongmianquan wrote:
>> Currently, the CPR subsystem in QEMU uses a QLIST to store fds.
>> In scenarios where a large number of
>> fds are involved (such as a VM with many vfio-pci devices), looking up a=
n fd
>> via `cpr_find_fd` becomes a performance bottleneck due to the O(N) linea=
r search.
>> This patch series optimizes the cpr fd storage by replacing the QLIST
>> with a GHashTable. The time complexity for `cpr_find_fd` is reduced
>> from O(N) to O(1).
>=20
> Some unanswered comments here for v1:
>=20
> https://lore.kernel.org/all/aacuTpoMucQ1wrUN@x1.local/#t
>

