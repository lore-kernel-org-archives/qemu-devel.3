Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36403D7495D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVs1-00032J-0F; Fri, 19 Dec 2025 03:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vWVs0-00032A-1E
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vWVrx-0001oy-Cf
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766132987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8bc0bT1FPYX4Nz6ORHeCkiHbgyRCusSFjrsKsfqfCw=;
 b=DVadn9woD9vCUQHufouqyE8bbzLnYb3FFA00YYZcDFskc8AQOtwTXxOqOT30jtUVYefIrV
 YkOevsg7wg/4fkFZakePurHUwpNKXqKGQOAlv7SrlhGC/V4Qn9sXlDi2M+WsjT/SK0Spe9
 fyb2mnnxk3R2/nmQVZMCjhBPmRVREdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-E-5I6BRjOgqfF2RsSY8OHg-1; Fri,
 19 Dec 2025 03:29:45 -0500
X-MC-Unique: E-5I6BRjOgqfF2RsSY8OHg-1
X-Mimecast-MFC-AGG-ID: E-5I6BRjOgqfF2RsSY8OHg_1766132984
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8953218001FE; Fri, 19 Dec 2025 08:29:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E0021800352; Fri, 19 Dec 2025 08:29:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C1A431800080; Fri, 19 Dec 2025 09:29:41 +0100 (CET)
Date: Fri, 19 Dec 2025 09:29:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 02/28] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
Message-ID: <efg3epkd6abvyeth4jlxozwdrwmzljccfolfbuphon74ecx56k@qoz746p6sivf>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-3-anisinha@redhat.com>
 <g62pujgmeihlmi27yl5opbvpta2mob2k3kyqu52yezscx2ooi5@kuddvxmpu756>
 <99622010-AC9C-4E67-87FF-8D5D01771A09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99622010-AC9C-4E67-87FF-8D5D01771A09@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 18, 2025 at 05:26:42PM +0530, Ani Sinha wrote:
> 
> 
> > On 17 Dec 2025, at 7:44 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> >  Hi,
> > 
> >> +    /*
> >> +     * different accelerators implement how to close the old file handle of
> >> +     * the accelerator descriptor and create a new one here. Resetting
> >> +     * file handle is necessary to create a new confidential VM context post
> >> +     * VM reset.
> >> +     */
> >> +    if (current_machine->cgs && reason == SHUTDOWN_CAUSE_GUEST_RESET) {
> > 
> > So, the vmfd code is unly used in confidential VMs.  I think it makes
> > sense to offer some option to enable that for non-confidential VMs too.
> > Useful for development and also for testing this in qemu CI.
> 
> Good idea. However, for non-coco, there is really no reason to change
> vm file descriptor. So it has to be some config option only for
> testing and development.

Yes.

> I am open to suggestions as to what kind of
> option we can consider.

I think a machine option makes sense, so it can be accessed similar to ->cgs

take care,
  Gerd


