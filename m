Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0111125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LpM-00035R-CI; Wed, 11 Mar 2026 11:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LpH-00033O-Hd; Wed, 11 Mar 2026 11:50:23 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LpF-0001W2-Im; Wed, 11 Mar 2026 11:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773244209; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=noPJQKYSCNMwyEaDKkL47dG3XHD/4YXZnNwMiPq++faRYQaXgnZ6aGwEP2UMftG3KkKgUeezsCKX2nl1or1D3UeF8likl6kfi8bpuyIR0/8uGMcDqNK12yFuZxkv6LX6SDug0SVmutpdyGLGO0md199G6EbQbZGpkiQymHdovRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773244209;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rOHtAu21/nhMjEVF9QL94+aY0c5AdHXy2IwiMewilvg=; 
 b=YWO/NGDLUl2XQlHX0XY3vP6x8hd1CV5bYdski12j+w+tZjOIguPGlIPsncxIuwQ2LQV2qFSz05AY/ctH9NSZulJrUEYtaxICBzg+BUXuWl/Xmq5sYRu+BgGJ2VPh7LWv2r6IoHj9FYlvWwdyvwylTID9xJHAZnZMOjJHyDN+SHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773244209; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=rOHtAu21/nhMjEVF9QL94+aY0c5AdHXy2IwiMewilvg=;
 b=ZV723ulfzNwfpSUNnaX3Dc4mhHpQFiDQ3Give0xhGwDXWxnmbHuuFcWshcI6y6GG
 szW5FLQKyNXiwExjPBnvuSDRRkvUM/SAH1BbhRXSgGmHUXStpHnHcNyxuDgkUKo9twt
 Z1UxnnVqnoD9OQ1ySYC4JeXGv5alu0X7M3t9yJRg=
Received: by mx.zohomail.com with SMTPS id 1773244208119410.32290772941315;
 Wed, 11 Mar 2026 08:50:08 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:50:03 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 01/14] accel/mshv: provision guests with the same
 features as host
Message-ID: <20260311-rebel-impressive-civet-6fb011@anirudhrb>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-1-c31699b7bc1f@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-1-c31699b7bc1f@anirudhrb.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 11, 2026 at 03:15:28PM +0000, Anirudh Rayabharam (Microsoft) wrote:
> Query HV_PARTITION_PROPERTY_PROCESSOR_FEATURES to obtain the feature set
> supported by the host and pass on this feature set to the guest during
> partition creation.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

I'll drop this patch in v2 in favor of Magnus' patch here:

https://lore.kernel.org/qemu-devel/20260311113505.1177878-2-magnuskulke@linux.microsoft.com/#t

Anirudh.


