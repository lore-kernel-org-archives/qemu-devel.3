Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09D9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 14:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCIQX-0004jv-2p; Fri, 24 Oct 2025 10:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vCIQV-0004jV-0Z
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 10:05:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vCIQT-0003a8-1y
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 10:05:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D5C143616;
 Fri, 24 Oct 2025 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078E3C4CEF1;
 Fri, 24 Oct 2025 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761314743;
 bh=kEPbTDZac7CjluEtE5j18ISVJGK6g6nGBRg4GbTVTXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gLLrpYfYY+N8x2bnVbq/kQ4p3chpY7BnLHMvtGumF3h8HRl8eVqyWRcU+EmcHioQe
 crgRy0hCv9eZTpp1z8PuHIJPDPmWtI0VslXA12NzWqAICWUx5AquXcNiybjNAfUdOS
 KKuaz5t5WXPbMfXAKs9EEHWQy07XKse3D4gq0GloinbaWYlSTapWV7mxS5UKgucidW
 AxsSGlztFyXCzEHLbpmHJb/aAOFnXOgcYPrw56D/1FmmtShIFnioWdn0ZwGvq50Ztd
 IYcdN5uNDFyZvKnUWUj29x/RPAZQ9i2NZOaQkKQvidq79mm+H6v9sPrNGl7Qm8mS4p
 9gjFHC3i2fQ/Q==
Date: Fri, 24 Oct 2025 19:29:01 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, 
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v2 0/9] target/i386: SEV: Add support for enabling VMSA
 SEV features
Message-ID: <tu7zyirbskj7gfr3mrwt6wlezslthrzbzvvmuszubvfvclcdhc@oxsy3cjmicoz>
References: <cover.1758794556.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758794556.git.naveen@kernel.org>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=naveen@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Sep 25, 2025 at 03:47:29PM +0530, Naveen N Rao (AMD) wrote:
> This series adds support for enabling VMSA SEV features for SEV-ES and
> SEV-SNP guests. Since that is already supported for IGVM files, some of
> that code is moved to generic path and reused.
> 
> Debug-swap is already supported in KVM today, while patches for enabling
> Secure TSC have been accepted for the upcoming kernel release.

Any other comments on this series?

So far, the only minor change I have on top of this series is the change 
suggested by Markus:

diff --git a/qapi/qom.json b/qapi/qom.json
index 5b830a9ba000..a2b9ccdfe43e 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1010,7 +1010,8 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
-# @debug-swap: enable virtualization of debug registers
+# @debug-swap: enable virtualization of debug registers. This is only
+#     supported on SEV-ES/SEV-SNP guests
 #     (default: false) (since 10.2)
 #
 # Since: 9.1

Otherwise, this series still applies cleanly to current master.

> 
> Roy,
> I haven't been able to test IGVM, so would be great if that is tested to 
> confirm there are no unintended changes there.

I took a stab at this with the buildigvm tool from Roy. I am able to 
boot a Linux guest with an IGVM file generated from that using qemu 
built with this series applied. In addition, with the below change to 
buildigvm, I am able to see Secure TSC being enabled in the guest:

diff --git a/src/vmsa.rs b/src/vmsa.rs
index 3d67a953055e..ac150264c244 100644
--- a/src/vmsa.rs
+++ b/src/vmsa.rs
@@ -70,6 +70,7 @@ fn construct_vmsa(reset_addr: u32, platform: Platform) -> Result<Box<SevVmsa>, B

     if let Platform::SevSnp = platform {
         vmsa.sev_features.set_snp(true);
+        vmsa.sev_features.set_secure_tsc(true);
     }

     Ok(vmsa_box)

I couldn't get it to work with > 1 vCPUs though (I'm possibly missing 
OVMF changes or such).


- Naveen


