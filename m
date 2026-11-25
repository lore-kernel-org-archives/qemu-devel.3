Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025C606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=OFEvp+83
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIz1-0003hC-Gz; Wed, 25 Nov 2026 14:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xWIyy-0003gx-UI
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:48:44 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xWIyw-0006IP-F0
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:48:43 -0500
Received: from example.com (p3e9c0c19.dip0.t-ipconnect.de [62.156.12.25])
 by linux.microsoft.com (Postfix) with ESMTPSA id D14C220B7170;
 Wed, 25 Nov 2026 11:48:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D14C220B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795636116;
 bh=ptTHxHfMKXfjZZ8mZw5wQK6IiOq920p/9BbjL4OGMZ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OFEvp+83gLxZfcGXAJmtbaIIxEYsZYv+XuYUpQgsNcPL8hFedeiislCgtxkWkxKlI
 8O4gpHQD/zyOC/vdRUriTYxDFPNTIbvG39V7eu1AvBPf5wiAxjVr4QrVF+c+nTB3u8
 Cv0pV/17Omd0FfTmnHV3n+ok+K7P8jJsvJXbb9n8=
Date: Wed, 25 Nov 2026 20:48:36 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] accel/mshv: mark VGA mem as dirty in mshv_log_sync
Message-ID: <awc7lEeaH/eL0ZAq@example.com>
References: <20261125131114.49490-1-magnuskulke@linux.microsoft.com>
 <47BB5DB2-727F-4232-AA01-0B7F0BAE99A8@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47BB5DB2-727F-4232-AA01-0B7F0BAE99A8@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 03:29:08PM +0100, Mohamed Mediouni wrote:
> 
> 
> > On 25. Nov 2026, at 14:11, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> > 
> > The accelerator needs to report changed video memory for the VGA display
> > update (e.g. for a VNC backend). We currently report the full section as
> > dirty. MSHV enables hypervisor dirty tracking only during migration, so
> > a VGA-only refresh is not able to query that bitmap.
> > 
> > During migrations we will use the migration dirty-log.
> 
> Hi,
> 
> Is there a blocker to having granular dirty tracking only for the VGA frame buffer area
> as always-on?

Hey Mohamed,

currently dirty page tracking is only enabled during migration. I have
put sth in the backlog to look into a discrete dirty tracking for the
VGA buffer as an optimization. I vaguely remember that there was a
problem w/ mshv regarding that, but I don't remember details atm.

best,

magnus

