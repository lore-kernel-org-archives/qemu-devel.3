Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714ABCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvbi-0005GM-Cx; Mon, 18 May 2026 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wOvbg-0005G5-L7
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wOvbe-0001S7-R3
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779101633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEdAGw+WDecywKmbPmS+XtUU8bm/fXESAUPMoabfpdc=;
 b=IBKTTmsyBUl4CeTKN0w4HVfLMRjGvI7oHqyVNaThpda4Iko6VBDmvA7e3zPxEGF+vmhDVk
 RSrGHgLUMFcdpI+ubwYK4FQd3InlG+uQutt6hm36Dn8LtO54ftilzxChNkn0KvWhGdInxP
 C79gRgYgAL687m5OmtFFAWdf8MYSFOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-Qg02gZDcNSOivJtaNWmD2g-1; Mon,
 18 May 2026 06:53:51 -0400
X-MC-Unique: Qg02gZDcNSOivJtaNWmD2g-1
X-Mimecast-MFC-AGG-ID: Qg02gZDcNSOivJtaNWmD2g_1779101630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 042C519560A1; Mon, 18 May 2026 10:53:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96E491800286; Mon, 18 May 2026 10:53:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7BF751800603; Mon, 18 May 2026 12:53:48 +0200 (CEST)
Date: Mon, 18 May 2026 12:53:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
Message-ID: <agrtSFk-XGA-EcQd@sirius.home.kraxel.org>
References: <agRC56rkfb4z6zSO@redhat.com>
 <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 15, 2026 at 08:49:24AM +0100, Peter Maydell wrote:
> On Wed, 13 May 2026 at 10:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
 
> > The XHCI controller (specifically the hcd-xhci.c variant) would remain
> > as our only option for the virtualization use case, with security process
> > applied to bugs & eligible for CVE assignment:
> 
> I support this; I don't think there's any reason to use anything
> except XHCI in a modern VM, and the others are useful now
> largely in the emulation and retrocomputing areas.

I fully support that too, recommending xhci since 2018 ;)

https://www.kraxel.org/blog/2018/08/qemu-usb-tips/

Except for the claim that windows 7 is in widespread use this
still applies today.

take care,
  Gerd


