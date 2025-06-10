Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7DDC71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXJ-0006bm-Ns; Tue, 10 Jun 2025 08:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyXF-0006aD-IA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyX9-0002Zc-KW
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749560213;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5gsxmS3YBb/LFAIkUU/W0hMLRwggAnMdw0nJPa/0gI=;
 b=JspjpdtcA8qPLTFdxsuVrSTdOFN3LcAUbUwdr5FYUCI77eVU8OfwovwwyT6ji8Kl6bcnq4
 qLWsdIRzGmM3zqn5dTDvEZTS+ueeRLJo8CjbSVpu7HJUa4mdA3zRAJDUYnpitU71OJAiVF
 lQ1itgJ0FmfMgBikwsbxMe0xkKlBI/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-qcbrCAK2PBmpo-GPf6M7cA-1; Tue,
 10 Jun 2025 08:56:50 -0400
X-MC-Unique: qcbrCAK2PBmpo-GPf6M7cA-1
X-Mimecast-MFC-AGG-ID: qcbrCAK2PBmpo-GPf6M7cA_1749560209
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C98A19560B7; Tue, 10 Jun 2025 12:56:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9995A1956087; Tue, 10 Jun 2025 12:56:46 +0000 (UTC)
Date: Tue, 10 Jun 2025 13:56:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 00/31] Skip automatic zero-init of large arrays / structs
 in I/O paths
Message-ID: <aEgri00LXfeRQRJ2@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
 <50405e77-e665-4772-9715-3901730d00fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50405e77-e665-4772-9715-3901730d00fd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 10, 2025 at 02:49:02PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/6/25 14:36, Daniel P. Berrangé wrote:
> > This series is an extension of Stefan's proposal:
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg00736.html
> > 
> > It used '-Wframe-larger-than=4096' to identify all code locations
> > with more than 4k on the stack. Any locations in the I/O paths
> > were chosen to avoid automatic zero-init, to eliminate the performance
> > overhead of the automatic initialization.
> 
> Should we eventually add it to our default CFLAGS?

You mean as a way to impose a hard limit on stack frame size ?

FWIW, the VNC server is biggest at 100kb, but we have a large
number of other big frames - here's a sorted list of frame
sizes vs frequency

      1 103696 
      2 69664 
     46 49184 
      4 42608 
     23 32880 
     23 32864 
      1 32832 
      1 28688 
     36 24800 
     10 24784 
      1 22240 
     21 21760 
      1 20624 
      1 17536 
      2 17168 
      1 16592 
      1 16576 
      1 16544 
      1 16512 
      2 16480 
      2 16464 
      1 16448 
      4 16432 
      1 15136 
      1 12960 
      1 12336 
      1 12048 
      1 10064 
      5 9184 
      1 8832 
      1 8784 
      1 8576 
      1 8448 
      2 8400 
      1 8384 
      2 8304 
      1 8272 
      4 8256 
      1 8240 
      4 8224 
      7 8208 
      2 7120 
      1 6800 
      1 5856 
      1 4928 
      2 4560 
      1 4464 
      1 4336 
      2 4256 
      1 4240 
      2 4224 
      4 4208 
      9 4176 
      9 4160 
     40 4144 
     68 4128 
      9 4112 



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


