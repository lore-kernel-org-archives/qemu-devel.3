Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE737F36C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnLA-0003fT-G3; Mon, 20 Apr 2026 08:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wEnKp-0003a7-DT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:02:46 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wEnKn-0002X4-U0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:02:39 -0400
Received: from example.com (unknown [167.220.208.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id B660020B7128;
 Mon, 20 Apr 2026 05:02:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B660020B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776686556;
 bh=A0yu6PSKAtx4nEVROn2nI1PS6/gjdxCugWFMQbJZxoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AhUmhVwGTA5crU+qSH8lPZUj9A/Cm14eNVtKL60/h0EYZi285MQHnh4DmtPFDocZp
 s3kqq8CYtJz8wEFJWMFwWAVWHJtghc+4xI95VlCysYUetMIk562mfjcRc/5AdHfJ7N
 wQEbrjhOjHx1uPVDgfKzqXQjOdntayblQec+xmEM=
Date: Mon, 20 Apr 2026 14:02:31 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 30/34] target/i386: add de/compaction to xsave_helper
Message-ID: <aeYV158wcT7A7X3O@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-31-magnuskulke@linux.microsoft.com>
 <83C168E7-02D5-4CD9-9A27-545A88942171@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83C168E7-02D5-4CD9-9A27-545A88942171@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Sat, Apr 18, 2026 at 07:46:25PM +0200, Mohamed Mediouni wrote:
> 
> 
> > On 17. Apr 2026, at 12:56, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> This patch has a tiny problem.
> 
> #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
> void *xsave_buf;
> uint32_t xsave_buf_len;
> #endif
> 
> With the "#if defined(CONFIG_KVM) || defined(CONFIG_HVF)” removed,
> that fixes a TCG only QEMU build.
> 
> Was also able to test that this works as expected on WHPX.

thx, that's right. we can also change the signature to pass xsave_buf
and xsave_buf_len as params, so accelerators which do not have xsave
buffers do not choke on this, it's probably less invasive rather than
including xsave_buf fields for all accelerators.

