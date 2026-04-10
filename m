Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73F2F459E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDDV-0001Z3-9d; Fri, 10 Apr 2026 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wBDDT-0001YO-PR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:52:15 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wBDDS-00080R-An
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:52:15 -0400
Received: from example.com (unknown [167.220.208.74])
 by linux.microsoft.com (Postfix) with ESMTPSA id F0C8720B710C;
 Fri, 10 Apr 2026 07:52:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0C8720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775832732;
 bh=63Hf2FszjsBUIaAZzmHMbil5wnSBAHySP3gg5EF7rxg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SxiS8FYkiNfaPAC5HYOg4iy1CZCs+Oc1FMDswRlJGugDrvl+WgG1q80Qraq0fBgHe
 uc8opL2c8Ev2rmlGQR5yemLUXVSs0/xQZ8fO7ULJq0Oy3BL20F7n/rpdH4O9d3qZ1L
 HAHpTjiB/z7/TyH0AMHmmSNE6Fzr82C2oYk4N0pc=
Date: Fri, 10 Apr 2026 16:52:09 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 1/1] target/i386/mshv: fix read/write memory across the
 page boundary
Message-ID: <adkOmWTzYdnBpp7g@example.com>
References: <20260409175334.181249-1-dblanzeanu@linux.microsoft.com>
 <20260409175334.181249-2-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409175334.181249-2-dblanzeanu@linux.microsoft.com>
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

On Thu, Apr 09, 2026 at 08:53:34PM +0300, Doru Blânzeanu wrote:
> Previously, read_memory and write_memory performed a single GVA-to-GPA
> translation for the entire buffer. If the buffer spanned a page
> boundary, the translated GPA was only valid for the first page, causing
> incorrect reads/writes for the remainder.
> 
> Fix both functions to loop over pages, translating and accessing each
> page-aligned chunk separately.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

Thanks, looks good. Confirmed with tests that the issue is resolved.

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

