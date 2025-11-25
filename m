Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29281D0E6C8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrB5-0002pk-1y; Tue, 25 Nov 2025 06:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vNrAr-0002me-Qz
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:25:36 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vNrAp-0005zx-1P
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:25:32 -0500
Received: from example.com (unknown [167.220.208.65])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9C6F12120E8F;
 Tue, 25 Nov 2025 03:25:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C6F12120E8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1764069925;
 bh=od8ZsCDDKmFt5JQQcLKQ2rzSmGilHXZWjhvv8NxuMII=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ot5WpxCxJP57+6Rl2nofyLt9FfAHva4lurJAsx8+RIY4XX3EzadA5eChZR9bK3bth
 Ir/Czw/z0M/n63/OZKAxE5amuRIqipApE9fv4eEDSItHePbAh1KOSYfXavhYAS1yhN
 5ZEU53fiV2M1+dQAd0cFibjBv6jVfCM7Df0xJixE=
Date: Tue, 25 Nov 2025 12:25:22 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 28/35] target/i386/mshv: Implement mshv_vcpu_run()
Message-ID: <aSWSIoUUOXy1nxpY@example.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-29-pbonzini@redhat.com>
 <CFB6B222-C2AF-4D3F-AFF1-F68BFCA7489B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFB6B222-C2AF-4D3F-AFF1-F68BFCA7489B@gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Nov 09, 2025 at 01:10:50PM +0000, Bernhard Beschow wrote:
> >+static int read_memory(const CPUState *cpu, uint64_t initial_gva,
> >+                       uint64_t initial_gpa, uint64_t gva, uint8_t *data,
> >+                       size_t len)
> >+{
> >+    int ret;
> >+    uint64_t gpa, flags;
> >+
> >+    if (gva == initial_gva) {
> >+        gpa = initial_gpa;
> 
> This assignment is never read and this branch leaves `data` untouched...
> 
> >+    } else {
> >+        flags = HV_TRANSLATE_GVA_VALIDATE_READ;
> >+        ret = translate_gva(cpu, gva, &gpa, flags);
> >+        if (ret < 0) {
> >+            return -1;
> >+        }
> >+
> 
> while this block:
> 
> >+        ret = mshv_guest_mem_read(gpa, data, len, false, false);
> >+        if (ret < 0) {
> >+            error_report("failed to read guest mem");
> >+            return -1;
> >+        }
> 
> is only executed in the else branch which is inconsistent to write_memory(). Is that intended? If so, do we really need the unused assignment above?
> 
> Best regards,
> Bernhard
> 

Thank you for spotting this Bernhard, this is a remnant from an attempt
to optimize gva=>gpa translations, but currently it's dead code. I'll
send a patch.

best,

magnus

