Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1700C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErDb-0008AP-AH; Tue, 13 May 2025 11:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uErDY-00089v-UE
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uErDX-0003ZS-7p
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747148809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uh2uO+4VmR68p4pGWVoRFJNOhDyrqHhyCdhgGg3OGEQ=;
 b=SukaEzkpEItmvV5cTJcufFlVrEx85+Z/g9j2bdQ2EC502R37rpOxMZKCz1WbeUh9/+vzxf
 r1JfY0oSUGKUZECZL40yfgVPrylU2/bkPcdPp9vdmsnDf/FesqLkNgMQlm9aArW0KIDIDx
 7uIMjU3yYxl1uHv1OfozEKoON2A8R24=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-VCHJ7ePhO4mjaPyttxxggA-1; Tue,
 13 May 2025 11:06:46 -0400
X-MC-Unique: VCHJ7ePhO4mjaPyttxxggA-1
X-Mimecast-MFC-AGG-ID: VCHJ7ePhO4mjaPyttxxggA_1747148805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 848E11955DB2; Tue, 13 May 2025 15:06:44 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.238])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45F1230001A1; Tue, 13 May 2025 15:06:42 +0000 (UTC)
Date: Tue, 13 May 2025 17:06:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 4/4] qemu-img: improve queue depth validation in img_bench
Message-ID: <aCNf_6rx07U6Qmgm@redhat.com>
References: <20250425175252.316807-1-kwolf@redhat.com>
 <20250425175252.316807-5-kwolf@redhat.com>
 <8fb759d6-6682-4962-b81d-ea20dbecd1e9@tls.msk.ru>
 <45fec2ac-9c59-4fe9-b750-8d04aa3e473f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45fec2ac-9c59-4fe9-b750-8d04aa3e473f@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 28.04.2025 um 15:58 hat Michael Tokarev geschrieben:
> 28.04.2025 16:54, Michael Tokarev пишет:
> > 25.04.2025 20:52, Kevin Wolf wrote:
> > > From: Denis Rastyogin <gerben@altlinux.org>
> > > 
> > > This error was discovered by fuzzing qemu-img.
> > > 
> > > Currently, running `qemu-img bench -d 0` in img_bench is allowed,
> > > which is a pointless operation and causes qemu-img to hang.
> > > 
> > > Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> > > Message-ID: <20250327162423.25154-5-gerben@altlinux.org>
> > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >   qemu-img.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/qemu-img.c b/qemu-img.c
> > > index 2044c22a4c..76ac5d3028 100644
> > > --- a/qemu-img.c
> > > +++ b/qemu-img.c
> > > @@ -4571,7 +4571,7 @@ static int img_bench(int argc, char **argv)
> > >           {
> > >               unsigned long res;
> > > -            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
> > > +            if (qemu_strtoul(optarg, NULL, 0, &res) <= 0 || res > INT_MAX) {
> > >                   error_report("Invalid queue depth specified");
> > >                   return 1;
> > >               }
> > 
> > FWIW, it's been covered by my qemu-img options patches for way over a year.
> 
> In particular:
> 
> https://lore.kernel.org/qemu-devel/20240927061121.573271-28-mjt@tls.msk.ru/
> 
> I'm still waiting for some feedback from these patches - heard neither ACK
> nor NACK for this rather large work.

Oops, seems I never continued review after patch 5. I'll get back to it.

However, I don't see the above hunk in that series. Am I missing it or
is there another series of yours waiting for review?

Kevin


