Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF9EFED2FE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dLa-0002Wk-Fv; Thu, 12 Mar 2026 06:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0dLU-0002S7-PQ; Thu, 12 Mar 2026 06:32:49 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0dLR-0000pu-IT; Thu, 12 Mar 2026 06:32:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773311548; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SU6WmAGvqd0qcD5K61JZ5vZdznym88uXGWQUDPIRPOJT+EOaRtIL3BftJm9lO2WeiAEBj282qBKHG/wVK8SFxlefvTBoD+8o7RaJh8HTmuEMRUZGE+dn4fN2xRH1tBB7k5x8/vdlx7PNw4NCneIYjILFlYjv/cMXIZXGZZ+lULA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773311548;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=s32HOtqxdiJY954NKgr5HVPzCNq/Bx7hUuggqZ3CYJE=; 
 b=ak/DFO/q44cxlYF6hAOqBSoyqGtd0BEVx14qfYyWMb0WC+Vk9rzcGNPky/Qae4ZFE6k7bF/SQGeDmMWtfyPNJd3/jFojl+QpLx7bHwxS1HMArBznmGFAsmHMCVQ/k4R3YKDLFkYfe0IWCldJVbYNa9h9PXadqXFh18ertvdTDAs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773311548; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=s32HOtqxdiJY954NKgr5HVPzCNq/Bx7hUuggqZ3CYJE=;
 b=KItbeIRT6dX0+r7+2wPVstnISO/Lwgd+sb+/ZZMOSE/2v+CBnRU5eBqQB7O3Url9
 zKX1B+3rB5fsL1JtvLkURDjvqh+Ep/uJ4lQlpVSZbJeiwCX4WOYCY5zIZmqNQMYQ6ej
 7B2A3/p+seBcafYgaa4IzgECxASsE+9MMGbGPWLU=
Received: by mx.zohomail.com with SMTPS id 1773311545808424.84325510702547;
 Thu, 12 Mar 2026 03:32:25 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:32:20 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
Message-ID: <20260312-lucky-cocky-whippet-2a5f3d@anirudhrb>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
 <199EF957-0EBD-4E14-8453-1C5FA5B14063@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199EF957-0EBD-4E14-8453-1C5FA5B14063@unpredictable.fr>
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
Message-ID: <20260312103220.M11I628qms8xZoo3ZI2fe9IygS-hdeJw0KBqCo12BCw@z>

On Wed, Mar 11, 2026 at 04:35:31PM +0100, Mohamed Mediouni wrote:
> 
> 
> > On 11. Mar 2026, at 16:15, Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> > From: Aastha Rawat <aastharawat@linux.microsoft.com>
> > 
> > Enable access_vp_regs feature for regs. In arm64, this feature bit
> > allows the guest to set VP registers using hypercall. This wasn't
> > required for x86 because such registers are set using wrmsr instead of
> > hypercall.
> > 
> Hello,
> 
> Could you split this into two patches? With the hvhdk.h changes in another patch.

Any reason why?

Throughout this series we're introducing hv*dk changes along with the
code using them. Isn't that a good idea?

Thanks,
Anirudh.


