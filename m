Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DE0CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNrG-000149-S5; Mon, 11 May 2026 06:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMNr5-0000zv-AS
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMNr3-0000ZJ-AK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778495235;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZJ+puVqsXjYx3RtmQGGoQag+v2327RJpj+NwSKlM47k=;
 b=TecVhkovKbXKmC1MKoiohkAatQM1ipUrHQAaC8xylcFN/Gj8lyizkjWS9IHnD6fY1cOPSF
 /1yvM2dtmVQ89vqRtm01LcIoSzRHj06nBXhAZlMGqFR0tuOnXdYFA37Cq2bY50VQtBlwQL
 REc8ZpGLYCst0F26qBcibgiE8hX5FTg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-6QuLEpwzMfuaWGPfKLWZPA-1; Mon,
 11 May 2026 06:27:14 -0400
X-MC-Unique: 6QuLEpwzMfuaWGPfKLWZPA-1
X-Mimecast-MFC-AGG-ID: 6QuLEpwzMfuaWGPfKLWZPA_1778495233
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E969718005B4; Mon, 11 May 2026 10:27:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CF0019560A6; Mon, 11 May 2026 10:27:10 +0000 (UTC)
Date: Mon, 11 May 2026 11:27:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 mst@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Message-ID: <agGu-vg1lPvEjalp@redhat.com>
References: <20260114013257.3500578-1-ruanjinjie@huawei.com>
 <92cecc93-1f68-44f2-8d0b-934e868d3e2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92cecc93-1f68-44f2-8d0b-934e868d3e2c@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 09:06:54AM +0200, Paolo Bonzini wrote:
> On 1/14/26 02:32, Jinjie Ruan wrote:
> > In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
> > "NANOSECONDS_PER_SECOND" may overflow the uint64_t type, which will
> > cause the QEMU Linux Virtual Machine's RTC time to jump and in turn
> > triggers a kernel Soft Lockup and ultimately leads to a crash.
> > 
> > Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
> > because get_guest_rtc_ns() is used either take the remainder of
> > NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
> > 
> > Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Thanks, queued - I also renamed the function to
> get_rtc_ns_since_last_update().  It's not entirely accurate due the presence
> of the sub-second offset s->offset, but it's good enough.
> 
> I have also considered changing the function to return a struct timespec.  I
> didn't like it too much because struct timespec uses a time_t which is
> possibly 32-bit.  Now, QEMU is probably broken for Y2038 anyway, but having
> time_t dependencies in device emulation code is not great; at least mktimegm
> and gmtime_r could be rewritten easily.

For system mode at least, we can assume time_t will be 64-bit only
since we drop 32-bit host OS support.

For user mode, we can likewise assume 64-bit host OS, but still have
to deal with potential 32-bit time_t for the guest OS. One could
argue that in the user mode case though, the guest ABI is what is
broken for Y2038 - QEMU is just honouring the (broken) ABI that is
defined.

The tools could be impacted by 32-bit issues I guess, but we still
have 10+ years to kill off the 32-bit host OS build support for
tools

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


