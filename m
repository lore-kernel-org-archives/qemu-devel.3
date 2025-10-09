Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3BCCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kqc-0005cO-Ad; Thu, 09 Oct 2025 03:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6kqY-0005cF-RQ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6kqO-0008Hm-A2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759994016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5AQECQi/clLIPCy9kCXS2O4tx6Q9lBKFtFWizvFuCSI=;
 b=VLr7m6Ygq+xGbOd+8IShDCifrqpEyeSLpP+pmZFqcYDMvQFxZ7W3blvI+hPurmNTJCQqhF
 b6W3nfCSSMPu4MWYk7HFpFhhkWYwf77UjPkJh36IHVlBA3P/XV/5FnM2vh7ATbotxBAgC2
 82cQ6Ummos6OGVAOuhYCEqgGKd5NAhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-hqn91yQbMZerKajzWHMwmQ-1; Thu,
 09 Oct 2025 03:13:33 -0400
X-MC-Unique: hqn91yQbMZerKajzWHMwmQ-1
X-Mimecast-MFC-AGG-ID: hqn91yQbMZerKajzWHMwmQ_1759994011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D2301800298; Thu,  9 Oct 2025 07:13:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CC831800447; Thu,  9 Oct 2025 07:13:25 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:13:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
Message-ID: <aOdggKKyDtf3z57J@redhat.com>
References: <20251007135216.1687648-1-kraxel@redhat.com>
 <aOcWOQJt-zLbiyUK@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOcWOQJt-zLbiyUK@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 09, 2025 at 01:56:09AM +0000, Dr. David Alan Gilbert wrote:
> * Gerd Hoffmann (kraxel@redhat.com) wrote:
> > Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> > optional support for logging to a memory buffer.  There is guest side
> > support -- for example in linux kernels v6.17+ -- to read that buffer.
> > But that might not helpful if your guest stops booting early enough that
> > guest tooling can not be used yet.  So host side support to read that
> > log buffer is a useful thing to have.
> > 
> > This patch implements both qmp and hmp monitor commands to read the
> > firmware log.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> I'm OK with that, but I wonder if it would be better to have a command
> that wrote the buffer to a file rather than displaying it directly; I don't
> think we normally have anything else which outputs that much raw guest
> provided data directly.
> I assume when it goes wrong you end up with random unprintable junk in
> the buffer.

128 KB is on the high side, but is not terrible. Libvirt (arbitrarily)
caps a QMP reply at 10 MB. Libvirt is going to want to send this on to
the client app and will likely do that streaming in memory, so having
it iin a file is not required from our POV.

IIRC, some of the query-block command replies can get insanely huge
when the qcow2 chain is very long.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


