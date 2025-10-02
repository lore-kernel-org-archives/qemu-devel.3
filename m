Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C178CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Et0-0006G3-9o; Thu, 02 Oct 2025 04:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v4Esv-0006En-PC
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v4Esf-0000pF-MQ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759394492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGjTtsKXC6FksXU85r08gijBuHfBcTbMDlAttzaQ8nU=;
 b=Be2pj5aFsJzZDQ7D9bLVWRKcvwVPZz9AqeN9y5iEfFBGaYLEuzreEMCbLF4r7jhY6iZej2
 9PC9S40X/0/rYE+fxDPBt4YpZv7R5tnm4pXyl+oIl7OnFpVvai1Vr5mxk4M9+ylBHvBr+d
 vDoNvuQohmFdEPLEGxdBDR2O2bzjK4E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-mi1LLJIoOLixTGbwKJOORw-1; Thu,
 02 Oct 2025 04:41:30 -0400
X-MC-Unique: mi1LLJIoOLixTGbwKJOORw-1
X-Mimecast-MFC-AGG-ID: mi1LLJIoOLixTGbwKJOORw_1759394488
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF2D81956050; Thu,  2 Oct 2025 08:41:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C896A300018D; Thu,  2 Oct 2025 08:41:19 +0000 (UTC)
Date: Thu, 2 Oct 2025 09:41:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aN46rF5w2-wy3IMH@redhat.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 02, 2025 at 10:30:56AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Magnus,
> 
> On 16/9/25 18:48, Magnus Kulke wrote:
> > Hello all,
> > 
> > This is the fourth revision of a patch set implementing an accelerator
> > for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in
> > various scenarios. Thanks for the feedback to the previous revision, I
> > tried to incorporate those. The changes in the currenct patchset beyond
> > the suggested fixes are mostly related to the replacement of retired
> > ioctl calls that will not part of the upstreamed MSHV kernel driver.
> 
> 
> > Magnus Kulke (26):
> >    accel: Add Meson and config support for MSHV accelerator
> 
> >    accel/mshv: Add accelerator skeleton
> >    accel/mshv: Register memory region listeners
> >    accel/mshv: Initialize VM partition
> >    accel/mshv: Add vCPU creation and execution loop
> >    accel/mshv: Add vCPU signal handling
> >    accel/mshv: Handle overlapping mem mappings
>
> Due to my generic work on accelerators, I'll have to refactor these
> patches. Obviously I don't want to break your implementation! Can
> you add some (functional?) tests? Ideally we should be running
> tests on our CI to ensure code doesn't bitrot.

NB our CI systems don't have HyperV available, so it is unrealistic
for us to test it in our CI upstream.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


