Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1E2FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMzV-0003Eb-EP; Thu, 30 Apr 2026 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wIMzT-0003ES-Rb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:43:24 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wIMzS-0006kT-Iy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:43:23 -0400
Received: from linux.microsoft.com (unknown [167.220.197.153])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7FAF620B7175;
 Thu, 30 Apr 2026 01:43:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FAF620B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777538600;
 bh=TwUPM6f/U3C0ck2pifkgR+NkVOM92Y1XMFFR7BsBEeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0niDp7ZkJPMpFWhxzUVRGy36cm21MzSZxHDVk9oz2GakP/V/SXW/to6ZAIc6u5wK
 7v11q0QahUC1XfFX5CqLLcGonre0A7pbwdyxZFxa6cJ5kP8yMXTVelQolNd2BB/Izs
 ywe11nbKxhWw4taUVI6aU3ZnDTKPfwexXUXUj2nY=
Date: Thu, 30 Apr 2026 11:43:10 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH v6 1/9] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <afMWHioNOYvQ4PIV@linux.microsoft.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
 <20260416121116.527927-2-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416121116.527927-2-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 16, 2026 at 02:11:08PM +0200, Magnus Kulke wrote:
> When using the extended request format we can instruct the hypervisor to
> provision enough space for requested XSAVE features. This is required
> for supporting QEMU models provided via the -cpu flag properly.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  accel/mshv/mshv-all.c          |  71 ++++++++++--
>  include/hw/hyperv/hvgdk_mini.h |   2 +
>  include/hw/hyperv/hvhdk.h      | 195 +++++++++++++++++++++++++++++++++
>  3 files changed, 261 insertions(+), 7 deletions(-)

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

