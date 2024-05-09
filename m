Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0EFC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 14:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s54z6-000083-5t; Thu, 09 May 2024 10:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s54z2-00006B-Gh
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s54z0-0000Xn-HI
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715265774;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWpsefT9732PAKZ8O8zhmmPqTHlV9coM34VJBc7Gf3c=;
 b=btACSh5RgG8M0VRRpAefUPwPC3TJ4V+8bERhgt1FV3Kwfp1dFR3vtA5GvGpqndfqpptr3Z
 wZOnnQikvc4BfUALqyTEbWAZS4hNrIoHwX+IWjVk/Akym5M3JhLT3qttrgTrc7u6vSZqNP
 0ofv6UNaL6wD+ytf3fhHAQAMI0vo+fw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-naWbcMj6PmSEP8AZ2Qf3kw-1; Thu,
 09 May 2024 10:42:50 -0400
X-MC-Unique: naWbcMj6PmSEP8AZ2Qf3kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D64BB3C11C61;
 Thu,  9 May 2024 14:42:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7874820898C0;
 Thu,  9 May 2024 14:42:46 +0000 (UTC)
Date: Thu, 9 May 2024 15:42:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 08/14] include/hw: add macros for deprecation & removal
 of versioned machines
Message-ID: <Zjzg5AAdysA6-_Kd@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
 <20240501182759.2934195-9-berrange@redhat.com>
 <b8027831-9f15-42e4-aa52-a071dc7bd384@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8027831-9f15-42e4-aa52-a071dc7bd384@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 02, 2024 at 12:59:05PM +0200, Thomas Huth wrote:
> On 01/05/2024 20.27, Daniel P. Berrangé wrote:
> > Versioned machines live for a long time to provide back compat for
> > incoming migration and restore of saved images. To guide users away from
> > usage of old machines, however, we want to deprecate any older than 3
> > years (equiv of 9 releases), and delete any older than 6 years (equiva
> > of 18 releases).
> > 
> > To get a standardized deprecation message and avoid having to remember
> > to manually add it after three years, this introduces two macros to be
> > used by targets when defining versioned machines.
> > 
> > * MACHINE_VER_DEPRECATION(major, minor)
> > 
> >    Automates the task of setting the 'deprecation_reason' field on the
> >    machine, if-and-only-if the major/minor version is older than 3 years.
> > 
> > * MACHINE_VER_DEPRECATION(major, minor)
> 
> That should be MACHINE_VER_DELETION instead.

Opps, yes.

> 
> >    Simulates the deletion of by skipping registration of the QOM type
> >    for a versioned machine, if-and-only-if the major/minor version is
> >    older than 6 years.
> > 
> > By using these two macros there is no longer any manual work required
> > per-release to deprecate old machines. By preventing the use of machines
> > that have reached their deletion date, it is also no neccessary to
> 
> s/neccessary/necessary/
> 
> > manually delete machines per-release. Deletion can be batched up once a
> > year or whenever makes most sense.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/hw/boards.h | 84 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 84 insertions(+)
> 
> With the typos fixed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


