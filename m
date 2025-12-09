Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259B5D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSrre-0005TS-Eu; Tue, 09 Dec 2025 02:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vSrrc-0005T5-JY
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:10:24 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vSrra-00029a-K9
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uz9ermxD9uz6md3s9E1PTGq4g+5i6wbfzms4Zz6ojk8=; b=rf5SqxRRdNZ/ttpNw7Jvl4/txm
 1UV1rJDkAKnJnn/MmNBvZHOnLhDEwQVhT/2ubAtqRsvlM7mVjAW64d1fvWR5MdVzSyX+t0SIusV5a
 o5BuCQjq5O7QMUAGiczeyHzte4YyO2iQMU3Nv2nl2S0Vx6whNMpqAP5qj6rurq1j5T1uXxkdcfYGC
 IftvoCexGotmK+Yxc7746emjx6vstkfm1CtbafP+lzXQRXncCj9930bYjTcdTIcLHPBu1Hp7UYUGg
 4ESDiGSIfDWprR9S/1eRkV9VS9zTnmLvfp+83EHXyIeXNT4SxOn1apkFufQnDlTva0YRuDuNKSwAL
 iZ669x+A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vSrrS-00AOOP-LV; Tue, 09 Dec 2025 08:10:14 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1vSrrQ-00BOp3-8F; Tue, 09 Dec 2025 08:10:14 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail with esmtp (Exim 4.96) (envelope-from <asb@igalia.com>)
 id 1vSrrP-005Jp6-2V; Tue, 09 Dec 2025 08:10:12 +0100
MIME-Version: 1.0
Date: Tue, 09 Dec 2025 07:10:12 +0000
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
In-Reply-To: <cover.1764716538.git.asb@igalia.com>
References: <cover.1764716538.git.asb@igalia.com>
Message-ID: <6955a4f0a032b68a2b9fb1d1b6a7b620@igalia.com>
X-Sender: asb@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2025-12-02 23:05, Alex Bradbury wrote:
> This is a resend of my previous patchset which unfortunately seems not to have
> been applied (see
> <https://lore.kernel.org/qemu-devel/cover.1753857212.git.asb@igalia.com/).
> I've rebased on current HEAD, checked it works as expected, and added
> Reviewed-by tags to the patches, which all received review.
> 
> Repeating the summary from last time:
> 
> This series contains one minor feature addition and a series of small
> bugfixes/improvements. The addition that motivates the submission is to add a
> limit argument for the hotblocks plugin, allowing you to control how many
> blocks are printed rather than being hardcoded to the 20 most executed.
> Setting limit=0 and dumping information about all executed blocks is
> incredibly helpful for an analysis script I have downstream.
> 
> This is my first contribution to QEMU. I've attempted to follow all of the
> guidance in the "Submitting a Patch" guide, but apologies if I missed
> anything.
> 
> Alex Bradbury (5):
>   contrib/plugins/hotblocks: Correctly free sorted counts list
>   contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>     blocks
>   contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>     PRId64
>   docs/about/emulation: Add documentation for hotblocks plugin arguments
>   contrib/plugins/hotblocks: Allow limit to be set as a command line
>     argument
> 
>  contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>  docs/about/emulation.rst    | 12 ++++++++++++
>  2 files changed, 26 insertions(+), 6 deletions(-)

Sending a ping as per the guidance at
<https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patch-seems-to-have-been-ignored>,
and also linking to the patch on lore.kernel.org as that page suggests
<https://lore.kernel.org/qemu-devel/cover.1764716538.git.asb@igalia.com/>

Thanks.

Alex

