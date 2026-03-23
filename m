Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C5DEC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cwV-00039J-NR; Mon, 23 Mar 2026 06:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4cwU-00037Z-Mz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:55:30 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4cwT-0006PY-4d
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:55:30 -0400
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id EC3CC20B710C;
 Mon, 23 Mar 2026 03:55:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC3CC20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774263326;
 bh=UoKyOrcG2WKMPQTR/47/W97fTNp1233WxnbU68sy07A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TnOHiNBp2WzI9AcIFg4S2LT5PdBTIOvnVulSdwmBrAuIy+FOZ7SGhDlH/SdQcgNjP
 3NTxKzxhGmP9GyfwRVP8vM5npfgV12E/Fx/l5NnOn8LfTXhdmQkuMZHKy4Lp8m0dVf
 yuxfu/ArxNAN8fizya/1usqiZh7klPiArYS4+TxE=
Date: Mon, 23 Mar 2026 11:55:22 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 1/9] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <acEcGhuIsOm27yUo@example.com>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-2-magnuskulke@linux.microsoft.com>
 <20260312-tested-garnet-hippo-cb71ee@anirudhrb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-tested-garnet-hippo-cb71ee@anirudhrb>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Mar 12, 2026 at 10:47:24AM +0000, Anirudh Rayabharam wrote:
> Why not just call the param property_code instead of feature_bank? That
> way this function can be used for other properties too.
> 

makes sense

> > +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(feature_banks) > MSHV_NUM_CPU_FEATURES_BANKS);
> 
> Is this really useful since we're not using the feature_banks array
> anywhere?
> 

yeah that's arguable. the intent is to detect drift between the number of
feature banks defined in the header and what we handle in the args. we
can just assert == 2 for now.

thanks,

magnus

