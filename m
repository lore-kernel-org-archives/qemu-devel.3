Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FADCC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTl9-00068f-CP; Tue, 03 Jun 2025 11:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uMTl6-00067q-VA
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:41:01 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uMTl5-0001Ft-5q
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:41:00 -0400
Received: from example.com (unknown [167.220.208.71])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5E0142078636;
 Tue,  3 Jun 2025 08:40:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E0142078636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748965256;
 bh=RknjUQnoz5qWQclnrdAhORR4oX6hiPYX+6hzGj4+2QQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iw/tDhnmNQzT3PgiG0ntxuTKUF5djvcqvDW5nF0yam8XhG5FmQR6FsJIaBLCw+BRm
 Fu2nXOmlbppG4ZigVCX55sPYh/bVePIwR7ZsAf7lobnEDV27bFpgSaKnLsl2ae8zhQ
 iMf2GXxajTMjs17D+ID2p1hWBJNN8DW2u9Reomog=
Date: Tue, 3 Jun 2025 17:40:50 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 24/25] target/i386/mshv: Implement mshv_vcpu_run()
Message-ID: <aD8XgghSbUK5rcoQ@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-25-magnuskulke@linux.microsoft.com>
 <aC0Ht-541wBzrUoc@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC0Ht-541wBzrUoc@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
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

On Tue, May 20, 2025 at 10:52:39PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:17PM +0200, Magnus Kulke wrote:
> > +    case HVMSG_GPA_INTERCEPT:
> 
> I'm not sure why you want to handle UNMAPPED_GPA and GPA_INTERCEPT
> separately. In Cloud Hypervisor there is one code path for both.
> 
> Is this due to how the memory address space is set up in QEMU?
> 

yes, indeed. this is a provisiong for the dynamic re-mapping of
overlapping userspace addresses. We can handle both together in this
commit, though.

