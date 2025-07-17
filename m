Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A73C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTk5-0002fY-GD; Thu, 17 Jul 2025 14:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ucR3N-0000VZ-Tk
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ucR3M-0001Tj-3x
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOdZ6vknGqEKLo+MkxlB5vfqxJiRop2oZTCAk6xk2ok=;
 b=M/L7+tunZrQK23wqLNP2q55LvkgMlHdCCoKQCsGT3JKWjMNEed/GPgU1ZIFGpouio+Xrju
 42CJV3SASIG8u2uu42gIaRBfUxh3kbt5HLuChhyetLQ1PP3KuZcEOULa0PcFL6qU5yg/1p
 /c7qXiqsvk36kqdwyLYP0of4zjWhVz0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-A55RM5NpO3eUfHZS5Cyy5w-1; Thu,
 17 Jul 2025 12:01:39 -0400
X-MC-Unique: A55RM5NpO3eUfHZS5Cyy5w-1
X-Mimecast-MFC-AGG-ID: A55RM5NpO3eUfHZS5Cyy5w_1752768099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E54401956057; Thu, 17 Jul 2025 16:01:37 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.244])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73CE818016F9; Thu, 17 Jul 2025 16:01:35 +0000 (UTC)
Date: Thu, 17 Jul 2025 18:01:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v4 00/27] refresh qemu-img options handling
Message-ID: <aHkeXJm4yPflHmAk@redhat.com>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
 <aHahGW6CItioKv2B@redhat.com>
 <a6bf0765-107a-4f01-bf56-3176374b843f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bf0765-107a-4f01-bf56-3176374b843f@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 17.07.2025 um 10:27 hat Michael Tokarev geschrieben:
> On 15.07.2025 21:42, Kevin Wolf wrote:
> > Am 31.05.2025 um 19:15 hat Michael Tokarev geschrieben:
> > > This is another iteration of this patch series, which tries
> > > to add missing command-line options, --help output, make it
> > > all more or less consistent, etc.
> > > 
> > > I addressed (hopefully) all comments so far, mostly by Kevin.
> > > I ended up (so far) with a bit different wording somewhere.
> > 
> > Thanks, I tweaked the wording and style a little bit here and there,
> > fixed some qemu-iotests and applied it to the block branch.
> 
> Thank you very much Kevin.  It was.. long :)
> 
> I'm not sure I follow - which iotests did you have to tweak?
> It shouldn't affect iotests, maybe only if we have some stuff
> testing for --help or invalid options?

Yes, there were some changed error messages for invalid options that
appeared in reference output.

Kevin


