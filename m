Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCFACA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkdt-0004Do-PF; Thu, 08 Oct 2026 05:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEkdr-0004DX-FK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEkdp-0004rq-Bl
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791452540;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PUKch78Lnna0aki2M/M0N5Gqy+cjIQfMGQ8mftW+JnY=;
 b=Pisw2HLv7dkVtzl3UC361XDqUKleUfE5fl60vdap2HSyu9kTXpV0LlHxA91QLvsnZUhFhg
 q79Ek9xJ9sk5RO2PWZwVaHzBeiNLCMJavGOW1FfK6TH3Ic1Fy9ir53/6jxU4E9740lOwlh
 5qSk6EADWP3iOJgZ4n2BTttdLYi/oZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-zWiuXf2KOBqbcpH0MDW1lw-1; Thu,
 8 Oct 2026 09:42:16 +0000
X-MC-Unique: zWiuXf2KOBqbcpH0MDW1lw-1
X-Mimecast-MFC-AGG-ID: zWiuXf2KOBqbcpH0MDW1lw_1791452534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CF851955DAD; Thu,  8 Oct 2026 09:42:13 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12EA830001BB; Thu,  8 Oct 2026 09:42:06 +0000 (UTC)
Date: Thu, 8 Oct 2026 10:42:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
Message-ID: <asdlbOZBSYIaCMIh@redhat.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
> > This allows a combined binary to register machine types from all its targets.
> > Consequently, QMP `query-machines` can return machine entries from every
> > target, even when `none` is selected. For example, a client can query the
> > combined machine list with:
> > 
> > ```json
> > { "execute": "query-machines" }
> > ```
> > 
> > The returned list includes the registered machine classes from all linked
> > targets. This is separate from selecting a machine: with `-target none`,
> > `-M virt` reports the targets that provide `virt` instead of choosing one
> > arbitrarily:
> > 
> > ```text
> > qemu-system -target none -M virt
> > unsupported machine type: "virt" for target "none"
> > Available for targets:
> >   aarch64
> >   arm
> > ```
> >
> 
> From the long conversation on a previous thread, I thought we reached
> the conclusion that if we didn't expose any ambiguous name, then -target
> option is unnecessary, or maybe I got lost on track of this thread.
> 
> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
> 
> I'm not sure which semantic we want to have with -target none. If there
> is no ambiguous name registered, we just don't need it at all. It's a
> win-win IMHO.

Yes, if we expose unique names for every machine, then -target is then
redundant.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


