Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D39F532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ybs-0007AK-Ok; Fri, 27 Mar 2026 00:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5ybp-00076r-84
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:15:45 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5ybn-0004HK-8z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1774584923; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ImtjCiydKRIg+gEb8ISLncPdr5a9tLnby18rdRLtoLHlVeycDUnm6okWSTakL6x2MWKI6bWPpaL9qHxuRbQfSHmQgUTYfRuLpmFdRwafxz+j3zcO9zgjNEfwn/wD/PmyjWbwsJvcsG2c/B8fH1znWt2Wsh79bMYVcpbcEjBQnS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774584923;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0Vm9IVDWvJ7/Ee4bC/QNOgqMgCnDPlG2UmZyM6Ud3i0=; 
 b=ReRuJBZ72G18IwkNgnc+w02f9mkgPkyURPoRji1wNktdSZKlMjcMHm7+oOnmvUWS3SQIZq2ZgtQoHSsfyLzJoySE0hW+cFERUgbt5jNm1KWDmG+ceIz4/ZYCUfUJXEUPSxN0ThevlVSVxdVUpwzOCN62h5ShFmxIsKB5cTjGIh0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774584923; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=0Vm9IVDWvJ7/Ee4bC/QNOgqMgCnDPlG2UmZyM6Ud3i0=;
 b=rnbo+2l0BSwpggGsGhD+emzzUeU368IZQH69C1nybGkDKyCOWR4zI6wCAvWlBe3c
 NihYHtl6v0MdNH+wSMQkFEsH3WfzSoKSksAiicgFRsXAC9mYUofOdTsErMw2bBWLUWq
 2o6sv1CPbnAcp60mj42ySZOsunNtvsViDxlu5Xc4=
Received: by mx.zohomail.com with SMTPS id 1774584920509674.4537690700389;
 Thu, 26 Mar 2026 21:15:20 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:15:15 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 2/9] target/i386/mshv: fix cpuid propagation bug
Message-ID: <20260327-hypersonic-fast-lizard-6f672e@anirudhrb>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-3-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323115711.353793-3-magnuskulke@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 23, 2026 at 12:57:04PM +0100, Magnus Kulke wrote:
> The list argument was missing a pointer and hence e.g. -cpu qemu64 and
> -cpu EPYC would produce the same of cpuid leaves.
> 
> Fixes: 4fa04dd1621 ("target/i386: Register CPUID entries with MSHV")
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


