Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47DBC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 08:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkgsO-0005bw-6N; Thu, 14 Mar 2024 04:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rkgsF-0005bW-Fi
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rkgsD-0002yJ-SR
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710406535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fUpohhFCnUMK9YnMRidKk5FmMzdyK1roMOWOQEGjvhI=;
 b=Vw1l3a6+K+KoalnutAo8oEDnMCASW6+usO5RBGM0e2vWHqDGFBuQI83CyLFAp6slfeExxq
 IqYFJkmAgjU63iUveKc7tLSdlL9niSijLaELsYlvh+go6YEQsN6SZS+w4wxyVERVaw4L3I
 qFaPHJMxgalZ1Tta6KWaGOT2CFcHKyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Ej8LXd47Mzqo0B5gc_kVJg-1; Thu, 14 Mar 2024 04:55:32 -0400
X-MC-Unique: Ej8LXd47Mzqo0B5gc_kVJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B4CE1018985
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 08:55:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D7AA3C23;
 Thu, 14 Mar 2024 08:55:31 +0000 (UTC)
Date: Thu, 14 Mar 2024 08:55:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZfK692MsrHaTKSzP@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
 <ZbjDtytv-_-Bz4-S@redhat.com> <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora>
 <ZfB5eBwWXL45sN_K@redhat.com> <CZSKAAQ3HE0Q.32DYA8Y3PX16V@fedora>
 <ZfGIScbYp3htVRMi@redhat.com> <CZTBWJZVA9SG.1U837DUGPOX31@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CZTBWJZVA9SG.1U837DUGPOX31@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 14, 2024 at 09:26:53AM +0100, Anthony Harivel wrote:
> 
> Hi Daniel,
> 
> 
> > You don't need to access it via the /node/ hierarchy
> >
> > The canonical path for CPUs would be
> >
> >   /sys/devices/system/cpu/cpuNNN/topology
> >
> > The core_cpus_list file is giving you hyper-thread siblings within
> > a core, which I don't think is what you want.
> >
> > If you're after discrete physical packages, then 'package_cpus_list'
> > gives you all CPUs within a physical socket (package) I believe.
> >
> 
> Yes, this could work.
> However, on laptop, I've got: 
> cat package_cpus_list
> 0-11
> 
> Where on server: 
> package_cpus_list
> 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46
> 
> I asked my teammate: always the same results. This is I guess due to 
> either a difference in the kernel version or how the kernel is handling 
> the case where there is only one package, versus the case with multiple 
> packages.

Both are the same data format - it is a list of ranges. In the
laptop example, there's only a single range to parse. In the
server example there are many ranges but since each range is
only 1 cpu, it has collapsed the ranges to the single CPU id.

> Anyway, writing a C function to handle both cases might not be easy.

Approximately

  * Read the whole file with g_get_file_contents
  * Use  g_strsplit(data, ",", 0) to get a list of ranges
  * Iterate over the return list of ranges and g_strsplit(range, "-", 2);
      - The returned list should be either a single element (if there was
         no '-'), or a pair of elements (if there was a N-M)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


