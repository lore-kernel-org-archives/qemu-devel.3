Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12305CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKynB-00033K-CR; Thu, 07 May 2026 09:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKynA-00032r-0B
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:29:28 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyn8-0008VB-AK
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:29:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1778160555; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O90NT4cKduTAdd0kPAjeDGuB/pE0dBNT1WP7LR/Sbu7GkK4oIEclVC40sAVsMwD9hzARinJMA+dInpxnjffW+zVFyZKRIQLJpel1ul/2S9XdZrGgx9NhEnAOp447tlHtYrO+esbt/TtY20jfR7OkAniiYrGYIRZyj8Uuw69AxPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778160555;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sDWRijJ8Tsiz50EEzoyY+11fMLrv3yglA7GW1BeRTQo=; 
 b=a2ZDbQV8THrraBzWg+085qsLpDqUys/+tU/dYEvDys9J37PyCXlwiqzeBqR6QTj1imTAlYgyxn9jTggA30/gOS/WA4vSW25HHXkM5TDt6e/HCVj6jxA+MBZExkeR7WeATXXRGbG5b5LkhCPoiWvIzYGwcK+V7yieRvsEzbg2f0U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778160555; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=sDWRijJ8Tsiz50EEzoyY+11fMLrv3yglA7GW1BeRTQo=;
 b=Da1yctUkYy/IVVnwbC5mMv/gtQrQwwBHS4u6FolTlImfaVgMwGdbJ1PspNwwDoQZ
 oi8JB9mTOoTHq/paL4hV/lsP8ZUgBj8cHZufUOu7FWL7A5V7/p84hCZCnJ2qfvfGV3N
 o4Lt5AjNxl9zrJ9e1c4SSITPcmBVbRAStHl/XW10=
Received: by mx.zohomail.com with SMTPS id 1778160554319777.9706590523184;
 Thu, 7 May 2026 06:29:14 -0700 (PDT)
Date: Thu, 7 May 2026 13:29:09 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/7] target/i386/mshv: use the register page to set
 registers
Message-ID: <20260507-olive-tuatara-of-effort-d4b97f@anirudhrb>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
 <20260505185028.237207-7-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-7-dblanzeanu@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, May 05, 2026 at 09:50:27PM +0300, Doru Blânzeanu wrote:
> Update mshv_store_regs to use the register page when it is mmapped and
> valid to set registers.
> Otherwise use the ioctls to set the registers.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 45 +++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


