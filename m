Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C000606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=ZrQdwh/O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV145-0007uE-MQ; Sun, 22 Nov 2026 01:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xV142-0007u1-MA
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 01:28:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xV13z-0001mz-Lm
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 01:28:38 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6AM6SMor024077
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 22 Nov 2026 15:28:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GHzxr2cQta1q1Ik4qPLda329tV0Znowxqjiek69/4gk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1795328902; v=1;
 b=ZrQdwh/ODHuCXFrW+YzhUs0Nz5z3H8WfdmKj0tX6QJC+ppk++wjcArIQlSiYqKLJ
 90VnQcQIPk3Ubo0AVRHZud6ELYbsxzNKpyTfsNGx3r5Vkm7Od4nhdQX+LHnMksYR
 b/N/jwb+Hi195KicsvJlXYtFgZKXm/CQLOizOuakCrioUlDQXkk5rmrA7LeRHcS3
 1cvJ5hTeVb7gbqw5jL4BXIorMGAZn5Cv1aWOL5+P3o3S/PX9xTZaXg9P37QvLfye
 YRpsEULiVBRe6HvmDmvw20QrFWANRKHbg6F8VuBOjyi59AogDC+deSz18ZG+tFXR
 +w8jjeuk8cZJQvxkS93sVw==
Message-ID: <dcdd8f95-024f-46b8-ad1c-42b7c8a047d5@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 22 Nov 2026 15:28:21 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2 0/2] net/checksum.c: Fix errors in dealing
 with IP header length
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowangio@gmail.com>
References: <20261114132350.1456994-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261114132350.1456994-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/14 22:23, Peter Maydell wrote:
> The main point of this patchset is patch 1, which fixes a bug where a
> crafted packet whose header fields claimed a header length smaller
> than its total length could cause us to set ip_len to a negative
> value, which then (because of a signed vs unsigned comparison where
> ip_len gets promoted to unsigned) makes it through range checks so
> that we checksum 64K of data off the end of the packet buffer and then
> write the two byte checksum also potentially off the end of the packet
> buffer.
> 
> This is CVE-2026-127233. The code is used by at least xen-nic,
> virtio-net and the COLO filter rewriter, as well as various
> out-of-security-scope devices, though it's not clear whether the bug
> is exploitable in all those scenarios.
> 
> Patch 2 fixes something noted by one of the reporters in passing,
> which is that we don't account for IP options in figuring out the
> offset of the TCP or UDP header in the packet, which means that we
> will write the checksum to the wrong place. This is just incorrect
> behaviour, not a security issue.
> 
> v1->v2 changes:
>   * use 'size_t' for length argument, and drop assert(length >= 0)
>   * use 'unsigned int' for mac_hdr_len, ip_len, ip_hdr_len
>   * use 'void *' for ip_payload, and drop casts
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    net/checksum.c: Correct handling of IP header length
>    net/checksum: Correct handling of checksums when IP options present
> 
>   include/net/checksum.h |  2 +-
>   net/checksum.c         | 46 ++++++++++++++++++++++++++++++------------
>   2 files changed, 34 insertions(+), 14 deletions(-)
> 

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

