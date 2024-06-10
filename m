Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B83C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGb5h-0000Sc-12; Mon, 10 Jun 2024 05:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGb5e-0000SJ-RV
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGb5d-0001hk-0P
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718010800;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbwChWmyiRkkEj/OzgpQ6wJ9CLvUqKbTvVxen30QrRk=;
 b=SQZoEFgom/LWY0VJTpywJKtIPfivci7Nq53KuZfXr3egd3dcJnyCDwf+pq9r0/5664eRsB
 l19bybhLi3Zm8dRHYy48nvWj7AuF1+0pzv+eCsDqnqbwETrKpxLmRkgDdE3jpGzn7bM+fN
 Cwdq9QdqVrUNW5PddG+UK5CJT/kT+S0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-RMslvnTuNiG4dZ91zlvtgg-1; Mon,
 10 Jun 2024 05:13:14 -0400
X-MC-Unique: RMslvnTuNiG4dZ91zlvtgg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D49A19560B3; Mon, 10 Jun 2024 09:13:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D21B1956087; Mon, 10 Jun 2024 09:13:09 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:13:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org, dave@treblig.org,
 peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
Subject: Re: [PATCH v3 2/6] Convert 'info tlb' to use generic iterator
Message-ID: <ZmbDosOA7EzarYuJ@redhat.com>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-3-porter@cs.unc.edu>
 <1dd777bb-184d-4c0d-ad80-afa65e0c58bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dd777bb-184d-4c0d-ad80-afa65e0c58bd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 07, 2024 at 08:02:51AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Don,
> 
> (Cc'ing Daniel for HumanReadableText)
> 
> On 6/6/24 16:02, Don Porter wrote:
> > Signed-off-by: Don Porter <porter@cs.unc.edu>
> > ---
> >   include/hw/core/sysemu-cpu-ops.h |   7 +
> >   monitor/hmp-cmds-target.c        |   1 +
> >   target/i386/cpu.h                |   2 +
> >   target/i386/monitor.c            | 217 ++++++-------------------------
> >   4 files changed, 53 insertions(+), 174 deletions(-)
> > 
> > diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> > index eb16a1c3e2..bf3de3e004 100644
> > --- a/include/hw/core/sysemu-cpu-ops.h
> > +++ b/include/hw/core/sysemu-cpu-ops.h
> > @@ -243,6 +243,13 @@ typedef struct SysemuCPUOps {
> >       bool (*mon_flush_page_print_state)(CPUState *cs,
> >                                          struct mem_print_state *state);
> > +    /**
> > +     * @mon_print_pte: Hook called by the monitor to print a page
> > +     * table entry at address addr, with contents pte.
> > +     */
> > +    void (*mon_print_pte) (Monitor *mon, CPUArchState *env, hwaddr addr,
> > +                           hwaddr pte);
> 
> IMO the SysemuCPUOps prototype should not use the monitor and return
> a HumanReadableText:
> 
>       HumanReadableText *(*mon_print_pte)(CPUArchState *env,
>                                           hwaddr addr, hwaddr pte);
> 
> Then define a QMP handler, itself registered to the monitor using
> monitor_register_hmp_info_hrt().

IIUC, this method is called repeatedly from an iterator, so I
think you would need to be instead relpacing the 'Monitor *mon'
parmeter with "GString *str", and print into that buffer.
The HumanReadableText would be created from teh GString higher
up in the call path.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


