Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1767AF94CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 05:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFQ76-0003ya-61; Wed, 22 Apr 2026 01:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1wFQ73-0003y7-Id; Wed, 22 Apr 2026 01:27:01 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1wFQ72-0005tA-94; Wed, 22 Apr 2026 01:27:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D290360018;
 Wed, 22 Apr 2026 05:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B6C19425;
 Wed, 22 Apr 2026 05:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776835610;
 bh=Mr6jyxXpaFQ/zvd2q4/jSjN7XaudJqSWIJIjxknXnWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=poJwDpVEXDBu7ZgNe+KdhhHD7hf8yGlLegpPgcV2sGKT9k7Od0vYaw2V2hLBNVdF+
 z+7+6oB0k89sx94YCnFPc9JnklOXBI+gkv/lfZa5zoSx3+vvP6kFyf8h57nTZy+UsB
 7cv6YUWtGEuCoDCyn572DJz2qCk4Zw80yHJf0uHo5UoF5xj/WltQGreQU0zIks1A4N
 ZKypG8ZbUnw35IW4QWLFo6PUO9fwCfwwPPUh7UPtNWbCNM00LFZ4mTn2hUhhCA1J5A
 YRCAyWNXaaOkJh++IKYA66N+y60YvDCa2h9kekZTI2beUehb4zTj+WrkO0X42Cyl7f
 3ojWMBZ/Li/TA==
Date: Wed, 22 Apr 2026 05:26:49 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v3 01/14] accel/mshv: move msr.c to target/i386
Message-ID: <20260422052649.GA797788@liuwe-devbox-debian-v2.local>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-1-469f544778ba@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-1-469f544778ba@linux.microsoft.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=wei.liu@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 21, 2026 at 05:21:46AM +0000, Aastha Rawat wrote:
> This file has x86 specific implementations. Move this file to i386
> folder in preparation for ARM64 MSHV support.
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>

Normally these tags go in chronological order.

 Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
 Acked-by: Wei Liu <wei.liu@kernel.org>
 Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

No need to resend. Just something to keep in mind for the future.

Wei

