Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E780C624D6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 03:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2KJI-0000TX-TP; Thu, 03 Sep 2026 23:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1x2KJH-0000Sl-4g; Thu, 03 Sep 2026 23:09:47 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1x2KJF-0000Y3-7E; Thu, 03 Sep 2026 23:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1788491385; x=1820027385;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9Y4wgbNgAjv+eE+KIA/oCpZuJVblXsW/G+HiW1/93os=;
 b=fHCTqPvRuE6VnMWNgSvoqdhB62+Yh/J2dSy15NX8zefRwy2CL5UipVgA
 cQ+ZEAeh5ydOk4u81bDlRg6vwuZKPZbHkPcqzaHbQ8ozYJQWRXKvb4sRA
 jnj0IW1iTfz39Ie2K5oX4kY1fT6cGxxsoRzECEBlziraLGF3L3WtkCBC9
 t5Dg/BkYD9Bs1erp5XlVDxC/iqi1aaiQjSl+Pj3nBGKQfd1fhqYbGFReO
 gu+YJE+7DJunTcp678ZBEuJ6eU7OYbhsKK1crjmDRaGoQXJlmGp/ejw2C
 rsFvsdL6Bnq5p34AhNQDlhKtV5a93v4VDmGs+jKy0U402aM3IZqyElNF8 w==;
X-CSE-ConnectionGUID: 76ui1K6FSmSpZ/aa7xKLFg==
X-CSE-MsgGUID: 1U9U2KkvSVakedxHz0ULWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="231554971"
X-IronPort-AV: E=Sophos;i="6.25,260,1779116400"; d="scan'208";a="231554971"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 12:09:40 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 6ACCA406110;
 Fri,  4 Sep 2026 03:09:40 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 18A301800D6B;
 Fri,  4 Sep 2026 03:09:40 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.19.125])
 by az2uksmom4.o.css.fujitsu.com (Postfix) with SMTP id 1C2954045ED;
 Fri,  4 Sep 2026 03:09:33 +0000 (UTC)
Date: Fri, 4 Sep 2026 12:09:32 +0900
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, 
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <apo185JSe61bK3zm@FCCLS0092175.localdomain>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903193611.1058589-8-mathieu.poirier@linaro.org>
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=enju.kohei@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kohei Enju <enju.kohei@fujitsu.com>
From:  Kohei Enju via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 09/03 13:35, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a Realm is requested, create a scratch Realm VM by setting bit 8

nit:
KVM_VM_TYPE_ARM_REALM is no longer defined as 1 << 8, so shouldn't this
be updated as well?

> of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> for the guest PA size.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

