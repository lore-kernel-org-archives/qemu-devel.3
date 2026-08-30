Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45D1C61DB9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 07:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ZrO-00017A-Pd; Sun, 30 Aug 2026 03:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZrN-00016s-Ml
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:21:45 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0ZrM-0004zI-7O
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 03:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788074504; x=1819610504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p1aIId6OF51IkNNctX/PRW+eNkg+BLyFrTHN13rl6Qc=;
 b=LdypoAcUrXmdxaE70l+ug7AkzOxYRGNhPzS02hw1omNXwMekEZOUvTe2
 +CCpHaHr5l9t/nQxcw0nDSQH8vXgdPc4FhPDLM2uyYufSAManCEWngzcE
 lr5SThIsDxtsxuv0iiZuwX5h54xi1mOBrGCt//4022ABUE6QUBa2tIKDv
 feXL4xVZMiSfPNqz7YX98YDF45W1ureP/iXFNZuoRe7glGU9g6k4QzpjH
 /YDeNuXllLY0aYn2TV4hPsDkQLH6r6ASaVv7XzPbwi8l72m+CrGSQmiDb
 4oDJC9JRaGycFOme0x3I9RHd2Rk+8l9JC22QivoKB0yLwk4koOSRD4OLq g==;
X-CSE-ConnectionGUID: Zp5boxcjQmqRH1G3Ag41Aw==
X-CSE-MsgGUID: CsDQmSO4RdqnYvgsyJccCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648925"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="87648925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:21:42 -0700
X-CSE-ConnectionGUID: q7DV/ze/QZKouI+R5fR6uw==
X-CSE-MsgGUID: 82SegnomR8KdHAghDREvOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; d="scan'208";a="266710316"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 00:21:39 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, dave@stgolabs.net, arun.george@samsung.com,
 dongjoo.seo1@samsung.com, s.neeraj@samsung.com, vikash.k5@samsung.com,
 cpgs@samsung.com, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC V2 05/10] hw/cxl: Wire UIO capability into HDM decoder and
 DVSEC registers
Date: Sun, 30 Aug 2026 15:21:18 +0800
Message-ID: <20260830072118.399487-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
References: <1646464088.101787732103895.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=junjie.cao@intel.com;
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

On Wed, 26 Aug 2026 11:04:05 +0530, Shrihari E S wrote:
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     UIO_DECODER_COUNT,
> +                     (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT
> +                     || type == CXL2_ROOT_PORT) && uio ? decoder_count : 0);

The always-true expression from v1 is a real type test now, but UIO
Capable Decoder Count uses the same encoding as Decoder Count -- CXL
3.2 8.2.4.20.1: "See the Decoder Count field in this register for
enumeration" -- so writing decoder_count raw advertises 4h = 8 UIO
decoders while Decoder Count reads 2h = 4.  I read the register back on
a cxl-rp: 0x00042312, bits[3:0] = 2h but bits[19:16] = 4h.
cxl_decoder_count_enc() would line the two up.  The same field
description also marks it reserved for CXL.mem devices ("not permitted
to limit the number of UIO-capable HDM decoders"), so CXL2_TYPE3_DEVICE
should drop out of the count expression.

On the type list itself: 8.2.4.20.1 enumerates UIO Capable for CXL.mem
devices, USPs and CXL Host Bridges, the Host Bridge case being the one
that means "all the root ports within this Host Bridge are capable of
routing UIO requests".  This sets it per root port instead, and
pci_expander_bridge.c passes uio=false for CXL2_RC unconditionally, so
the host bridge never advertises it.  On v1 I said a root port may well
be intended, going off crp->uio_capable in the SVC wiring, but the
enumeration above doesn't list one.  Is the root port the intended
carrier?

> +        if (uio) {
> +            write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] |=
> +                R_CXL_HDM_DECODER0_CTRL_UIO_MASK |
> +                R_CXL_HDM_DECODER0_CTRL_UIG_MASK |
> +                R_CXL_HDM_DECODER0_CTRL_UIW_MASK;
> +        }

The if (uio) block adds UIG and UIW to the write mask for every type,
type3 included.  8.2.4.20.7 makes both "RWL for a switch and a Host
Bridge if the UIO Capable bit ... is set" and then "reserved for
CXL.mem devices."  I wrote 0x00ff0000 to decoder 0's Control register
on an x-uio=on type3 and read it straight back; the same write on a
type3 without x-uio reads back 0.  Gating UIG/UIW on the port types,
and leaving UIO alone, would match the table.

Many thanks,
Junjie

