Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42E7C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtj6j-0007Xm-Nl; Tue, 11 Aug 2026 05:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtj6h-0007XN-Eo
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtj6f-0007rd-VH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786441751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KfMfz53moTWyczoewga8UXZ2cq3ksrVOkXkgBxyRho=;
 b=Gzkh00lQATu8vqj/psUmk+Iy9ISiWN04VgVEWsVD1WmMwQ9MO8t+ov/HLghw5K78cNDPqM
 BKEugI4ugt/V4hPrYNzbEpxosTOe49mx6PM9mHmw5R2t0SFKuyg+JZlPWB9RV/VgJKxF1M
 jwY1LLj7O2Ss+3dI72mM6TWKmQ53JWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-p2KO2simNAq9khKLrkUl-w-1; Tue,
 11 Aug 2026 05:49:08 -0400
X-MC-Unique: p2KO2simNAq9khKLrkUl-w-1
X-Mimecast-MFC-AGG-ID: p2KO2simNAq9khKLrkUl-w_1786441747
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B0218001CD; Tue, 11 Aug 2026 09:49:07 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E18C180034C; Tue, 11 Aug 2026 09:49:05 +0000 (UTC)
Date: Tue, 11 Aug 2026 10:49:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/4] hw/nmi: Safer vCPU delivery
Message-ID: <anrwDkuc9LoY3uhg@redhat.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
 <ac8e5e46-eb2f-4e7d-aad8-390a940829e9@oss.qualcomm.com>
 <81799d60-4409-4286-8795-192e1b8ea4fa@oss.qualcomm.com>
 <eff6e1f7-e477-42ea-a80a-14349bacb97b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eff6e1f7-e477-42ea-a80a-14349bacb97b@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 11, 2026 at 11:36:59AM +0200, Philippe Mathieu-Daudé wrote:
> On 11/8/26 10:50, Philippe Mathieu-DaudÃ© wrote:
> > On 11/8/26 10:44, Philippe Mathieu-DaudÃ© wrote:
> > > On 10/8/26 23:37, Philippe Mathieu-DaudÃ© wrote:
> > > > Hi Marc-André,
> > > > 
> > > > I don't remember what I suggested particularly for
> > > > 20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com,
> > > > but this series is what I had in mind back then.
> > > > 
> > > > If you find it worthy, please consider including it
> > > > in your "Make HMP optional" work.
> > > 
> > > Not well explained, this series disentangle HMP from
> > > the generic NMI class.
> 
> Actually previous version is better:
> https://lore.kernel.org/qemu-devel/20240220150833.13674-1-philmd@linaro.org/

Are you going to rebase & resend that ?   The old thread has a lot
of commentary that I don't think it is worth reviewing the old code
again until updated.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


