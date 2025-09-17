Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEE0CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuqx-0007WX-KX; Wed, 17 Sep 2025 12:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyuqv-0007Vy-M7
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyuqt-00014B-HT
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758125870;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWOCJ711axGG8BGdsbGwLl4TtsBwP/K0Yl0/kyZfWqc=;
 b=i0Kk3IgaczcW4n3yqDflGnu4f/AYvCCznzNftaA5uHi32OVvPqF/heMn3HvuGRaa4nJR3c
 6kjdpQsrHYd2oDvYeCSfsS+s1FyQ6NJPHbtqfanZuWnNTyJa8rlJuScZLfuG4SsOGs2Jr2
 1vPoMpr0GHLfNSeknPi1PAxpk8sdzCc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-G6NFIAIGNtCyP1-6REeX4g-1; Wed,
 17 Sep 2025 12:17:42 -0400
X-MC-Unique: G6NFIAIGNtCyP1-6REeX4g-1
X-Mimecast-MFC-AGG-ID: G6NFIAIGNtCyP1-6REeX4g_1758125859
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A122F180057E; Wed, 17 Sep 2025 16:17:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B88651955F19; Wed, 17 Sep 2025 16:17:32 +0000 (UTC)
Date: Wed, 17 Sep 2025 17:17:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
Message-ID: <aMrfGUfCSWnvkXzT@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 17, 2025 at 04:08:01PM +0200, Filip Hejsek wrote:
> 
> 
> On September 17, 2025 3:31:57 PM GMT+02:00, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > [...]
> > > > 2. create a timer polling every eg 100ms to check if the winsize has
> > > > changed
> > [...]
> > 
> > I don't think we want a timer polling for an situation that will very
> > rarely arise.  We already add the 'chardev_resize' QMP command, which is
> > a good enough way to kick QEMU to re-read the size.
> 
> So the size provided in the command would be ignored, and QEMU would
> instead query the pty fd?

Actually I was just thinking we ignore the pty and only support the QMP
command. There is little point in trying for access size via the pty
if clients need the QMP command regardless to notify QEMU.

> Note that this would mean there is no size info if the command is
> not used, because the size will be 0x0 when the pty is created by
> QEMU (though we could add device parameters for the initial size).

We shouldn't send any size info to the guest if the hsot backend
does not have it available.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


