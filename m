Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C10CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwk8M-0004RN-CD; Thu, 11 Sep 2025 12:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uwk8K-0004QL-0k
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:26:52 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uwk8I-0000xE-BG
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:26:51 -0400
Received: from example.com (unknown [167.220.208.69])
 by linux.microsoft.com (Postfix) with ESMTPSA id 186462114256;
 Thu, 11 Sep 2025 09:26:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 186462114256
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1757608006;
 bh=RnNa2D0LvBR/ANdd/t0aE0uQ9LainLgotmMqzXME0Z8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ddZ+ZeO83bosFj6lKOLoRIb3pk4sUrD6h5z8IXAVp/YTCaCECUnmLmDBBBgYl7zzV
 GyLTa0LI/8jThHjbpLXYwpSyk/BFxTBeVFdEsa6Kl17jL9pl4zmQuIfY+GJFYZtH8U
 CyFTWiJZmGUYw/wrYvAyWAjjRAbJJ7CY2MRLwCOs=
Date: Thu, 11 Sep 2025 18:26:39 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/26] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aML4PxWTAW8BpW8+@example.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250911025906-mutt-send-email-mst@kernel.org>
 <17ac0ef9-1c10-4f84-be24-b0f25c7e78fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ac0ef9-1c10-4f84-be24-b0f25c7e78fb@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 11, 2025 at 05:21:44PM +0200, Paolo Bonzini wrote:
> On 9/11/25 08:59, Michael S. Tsirkin wrote:
> > On Thu, Aug 07, 2025 at 04:39:25PM +0200, Magnus Kulke wrote:
> > > Hey all,
> > > 
> > > This is the third revision of a patch set implementing an accelerator
> > > for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in various
> > > scenarios. Thank you for the feedback so far. Since the last revision we
> > > incorporated feedback from the last review and identified further areas for
> > > performance fixes, notably in the irqfd handling. I'm looking forward to your
> > > comments.
> > > 
> > > Best regards,
> > > 
> > > magnus
> > 
> > 
> > So regarding merging plans. Did you guys get in touch
> > with Sunil? That's the easiest smoothest path, through
> > an existing maintainer.
> 
> There's hardly any code shared with WHPX; I am on vacation this week but
> I'll do a final review and merge it soon.
> 
> Paolo
> 

Hello Paolo, we intend to post a V4 soon-ish (next week probably) which
will include a necessary update to some IOCTLs calls. that and some minor
changes due to review feedback and a rebase, since this is a couple of
weeks old already. It probably makes sense to to wait for that.

best,

magnus

