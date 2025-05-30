Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FE3C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 20:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL6BT-0005Ct-AQ; Fri, 30 May 2025 16:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uL6BR-0005Ce-O9; Fri, 30 May 2025 16:18:30 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uL6BQ-0004Sa-33; Fri, 30 May 2025 16:18:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 883075C651F;
 Fri, 30 May 2025 20:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077D6C4CEE9;
 Fri, 30 May 2025 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748636297;
 bh=gD4OE8mGUgFikae1GLGN4X9YkI2G5QLIpQiO20Ua8Eo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ItY80usAQwQa/V4EOFuzUL2OBmBnHjgkUrDNB181AvSdwC8INWh823XFJjMlNL5nS
 XkIviVDRfnwSF5BkbT3VoDQJlGSg0QdGJYU0mJniMkxJxzkOI0/II2pzYh3XBZpCAN
 Noogt39otuzayagT1RqWAnwBRdF/uZA7hNtUfiD7wE5x66QL/h4+y4KHYwJPsfHObw
 OKKgjqXX5dzAFLcs7xWOaoTGLUslmED6EzwsFDyR5hPiy3N7ct51hBuNUSuZLEiBVP
 BpXV1LCUpAvD95BwGjT+9sRZaiGSIoH3Nk9EqJ9q6VFmqsLBunBbkdog7XlDck+33f
 E45JMJZ1WTHQg==
Date: Fri, 30 May 2025 22:18:10 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/20] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250530221810.694ce02e@foz.lan>
In-Reply-To: <20250530164903.0f9f8444@imammedo.users.ipa.redhat.com>
References: <cover.1747722973.git.mchehab+huawei@kernel.org>
 <aa74b756f633dbee5442cf4baa2c1d81a669d2f9.1747722973.git.mchehab+huawei@kernel.org>
 <20250528174212.2823d3de@imammedo.users.ipa.redhat.com>
 <20250530080120-mutt-send-email-mst@kernel.org>
 <20250530164903.0f9f8444@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Fri, 30 May 2025 16:49:03 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 30 May 2025 08:01:28 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, May 28, 2025 at 05:42:12PM +0200, Igor Mammedov wrote:  
> > > On Tue, 20 May 2025 08:41:31 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Create a new property (x-has-hest-addr) and use it to detect if
> > > > the GHES table offsets can be calculated from the HEST address
> > > > (qemu 10.0 and upper) or via the legacy way via an offset obtained
> > > > from the hardware_errors firmware file.    
> > > 
> > > 
> > > it doesn't apply to current master anymore    
> > 
> > indeed. Mauro?  
> 
> Michael,
> it's trivial conflict in machine compat,
> could you fix it up while applying?

IMHO, that's the best. The thing is, as code gets merged upstream with
backports, conflicts happen.

I can re-send the series, if you prefer, as I'm keeping it rebasing it
from time to time at:
	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submitted?ref_type=heads

(it is on the top of upstream/master)

But even that might have conflicts on your test tree if you pick
other patches touching this backport table:

> -GlobalProperty hw_compat_10_0[] = {};
> +GlobalProperty hw_compat_10_0[] = {
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> +};

(this was the code when I sent the PR. When applying upstream,
such hunk is now(*):

 GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
+    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
 };


(*) https://gitlab.com/mchehab_kernel/qemu/-/commit/08c4859f8c6f36d7dccf2b773be88847e5d1fe0c

If you still prefer that I resubmit the entire PR, let me know.

Regards,
Mauro

