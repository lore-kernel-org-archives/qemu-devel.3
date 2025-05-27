Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158E2C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJx9C-0002yM-7V; Tue, 27 May 2025 12:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uJx9A-0002xp-0r
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:27:24 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uJx97-00012I-5M
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:27:23 -0400
Received: from example.com (unknown [167.220.208.36])
 by linux.microsoft.com (Postfix) with ESMTPSA id C85D82068336;
 Tue, 27 May 2025 09:27:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C85D82068336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748363236;
 bh=pwydJ2N4wgwE+kCvzxEflA/4e7/ZxBKGfqFlC4vN9/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TjsDQhSZRGl00KuoZTH+UVsDZEcsHVqEWu8VyNv8rim7dHqn/IalA5je0NQEaFhjo
 3qcwynBKf03nRZRoCQoNlUJZ8zgJOFeLxqxt806eiEDP2l2vEJxDlFsRRO4dvCu0KK
 SWEnDtRXjyuEi8fDxXPAETojj+xLRuM/pO0IbiuI=
Date: Tue, 27 May 2025 18:27:12 +0200
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
Subject: Re: [RFC PATCH 11/25] accel/mshv: Add basic interrupt injection
 support
Message-ID: <aDXn4CPZIsip4U1T@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-12-magnuskulke@linux.microsoft.com>
 <aCzi2OQRB_YiW7rm@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCzi2OQRB_YiW7rm@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
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

On Tue, May 20, 2025 at 08:15:20PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:04PM +0200, Magnus Kulke wrote:
> > Implement initial interrupt handling logic in the MSHV backend. This
> > includes management of MSI and un/registering of irqfd mechanisms.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> [...]
> > +int mshv_request_interrupt(int vm_fd, uint32_t interrupt_type, uint32_t vector,
> > +                           uint32_t vp_index, bool logical_dest_mode,
> > +                           bool level_triggered)
> > +{
> > +    int ret;
> > +
> > +    if (vector == 0) {
> > +        /* TODO: why do we receive this? */
> 
> You must have seen this in real life, right? We need to convince
> ourselves why this is okay.
> 
> Thanks,
> Wei.
> 

I haven't seen this in real use, I spotted it in the mshvc library and
wondered why we have this clause at this point. We can log a warning if
that occurs.

