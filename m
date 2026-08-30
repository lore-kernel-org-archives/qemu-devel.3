Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64ABC61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Zr3-0000fm-8t; Sun, 30 Aug 2026 03:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zqy-0000Xy-92
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:21:20 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0Zqw-0004xB-HD
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074479; x=1819610479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nZzvt0iW2Q7KLQNgSo/G2fUMX1/yU6BP1yQMPTPTucE=;
 b=eI3sGcdOq5JOa3F5jC7HmseCTX4pflg8B+ZtNTcMIWmqh62KKIGON2F9
 Pal2pJS9ohyxxug4ZV48f+9Qg6cWyId5QdHoewha9NG/SPRFTB59bKX8K
 BeVjiVxevR7ev+vgjMLordas+YPYnLthxY6dQkn04xewjnCXA1bpUfR08
 fezg4pP6ZRHLEyXS4Orv82he/fEPF3rq5iMuAC59fF9PGwVmOQUW/9GZW
 VMygcinaFdu6qberOrM5lMHhR7csHp9t8PwHWU5xqyXYDQeNFGwWnAFkZ
 uUHQJGcJgR1ZePfyaiK2PfaI/dFVW/3K9SiAcnnxsK5g1mx0xTstK+fBA w==;
X-CSE-ConnectionGUID: PnP5Whd6QtWxflI6W0ly5A==
X-CSE-MsgGUID: JANdvAPjTYq+ajhsIFQ9UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="88565401"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="88565401"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:21:17 -0700
X-CSE-ConnectionGUID: Scg0oMW4RY2iI0umtxW6dA==
X-CSE-MsgGUID: 7BYKUOHqQEmEENak+UP5wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="265948510"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:21:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 03/10] hw/pci: Add SVC capability and UIO properties to
 PCIe ports
Date: Sun, 30 Aug 2026 15:20:53 +0800
Message-ID: <20260830072053.399466-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <124323713.61787732103161.JavaMail.epsvc@epcpadp1new>
References: <124323713.61787732103161.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:03 +0530, Shrihari E S wrote:
> +static const Property xio3130_upstream_props[] = {
> +    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
> +};

x-256b-flit is a no-op on x3130-upstream: nothing in
xio3130_upstream.c reads PCIEPort::flitmode.  pcie_cap_fill_slot_lnk()
does run from pcie_cap_init(), but returns early -- an upstream port is
a PCIEPort, not a PCIESlot -- and pcie_cap_fill_link_ep_usp(), the path
cxl-upstream and cxl-type3 take, isn't called here.  So with
x-256b-flit=on the Flags bit 15 and LNKSTA2 flit bits stay 0.  I'd
either wire up pcie_cap_fill_link_ep_usp() the way cxl-upstream does,
from its reset handler, or drop x-256b-flit from this hunk.

x-svc has no reader until 7/10 either, so x-svc=on has no effect for
four commits.  Same thing Jonathan asked for on v1: bring the state in
with the patch that uses it.  Here that would fold 3 and 4 into 7.

Many thanks,
Junjie

