Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0FDC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqX5N-0000k6-9t; Fri, 07 Mar 2025 07:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqX5I-0000jY-Ja
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqX5F-0007Cf-P4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741351544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KxNQ4Rj10GCLIzVJlqOM7JDlrkroIk5RT1ccUPjrug=;
 b=EelyYLGMcO6g5s/5JueibnA3n2M9aZkoVQonWcCXOBqsBUIF2nadr5fz9vMgWtbqDxaiJI
 p4CM9XWnvTxrNM2ZEMKRtkRDj3eLMFw4DoZfkmR1h2kRnuhPVEIizRGdrSbgjZwdnJM0k7
 4M1PVjT0H4fOS6wZj2wojACeGI4gRYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-xpryIP0IP32v9wfYjvBHKg-1; Fri,
 07 Mar 2025 07:45:40 -0500
X-MC-Unique: xpryIP0IP32v9wfYjvBHKg-1
X-Mimecast-MFC-AGG-ID: xpryIP0IP32v9wfYjvBHKg_1741351540
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC920180899B; Fri,  7 Mar 2025 12:45:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAA181801747; Fri,  7 Mar 2025 12:45:37 +0000 (UTC)
Date: Fri, 7 Mar 2025 12:45:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 10/15] tests/functional: fix race in virtio balloon test
Message-ID: <Z8rqbvqCVVuSPw90@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
 <20250307115314.1096373-11-thuth@redhat.com>
 <69bc17ce-de05-4b4f-88c2-57866c6409c4@linaro.org>
 <1d1756d1-e16c-474d-b220-05829a2a8ab3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d1756d1-e16c-474d-b220-05829a2a8ab3@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 07, 2025 at 01:39:17PM +0100, Thomas Huth wrote:
> On 07/03/2025 13.34, Philippe Mathieu-Daudé wrote:
> > Hi Thomas, Daniel,
> > 
> > On 7/3/25 12:53, Thomas Huth wrote:
> > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > 
> > > There are two race conditions in the recently added virtio balloon
> > > test
> > > 
> > >   * The /dev/vda device node is not ready
> > >   * The virtio-balloon driver has not issued the first stats refresh
> > > 
> > > To fix the former, monitor dmesg for a line about 'vda'.
> > > 
> > > To fix the latter, retry the stats query until seeing fresh data.
> > > 
> > > Adding 'quiet' to the kernel command line reduces serial output
> > > which otherwise slows boot, making it less likely to hit the former
> > > race too.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Message-ID: <20250304183340.3749797-1-berrange@redhat.com>
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > [thuth: Break long line to avoid checkpatch error]
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/functional/test_virtio_balloon.py | 26 ++++++++++++++++++++-----
> > >   1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > This fix isn't really working, and is more of band-aid IIUC.
> > 
> > With the following patch restricting to KVM accel, do we still want it merged?
> 
> Yes, I think it still makes this test more robust.

Agreed, even though this patch isn't perfect it is definitely fixing two
clear race conditions.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


