Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F0CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8egd-0000my-1k; Tue, 14 Oct 2025 09:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8ega-0000mk-SQ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8egW-000592-GE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760446996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzunxSYg7+RDPu0I2TT20khBEGvlQjgWis+PAoXRr9E=;
 b=V6uFwgHZEFin9Iqj/grkwQdKPZMbrYXpUsVwzMYrmNtzA/gtXzKr6tlVlHoR3T1zOUXx25
 om15FqKxGGO4COua7y1JumsxGbnn+fm4ddhVm5c4+x32AS+hieK4Z/RpKiqLVtXIRterDy
 0mdDzmMY8Ytx/9zPKQyv/oOXtNyUhaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-tS8jndS2MD-pEkpE9RVUZA-1; Tue,
 14 Oct 2025 09:03:06 -0400
X-MC-Unique: tS8jndS2MD-pEkpE9RVUZA-1
X-Mimecast-MFC-AGG-ID: tS8jndS2MD-pEkpE9RVUZA_1760446984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF8BD180057B; Tue, 14 Oct 2025 13:03:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEFDE1954107; Tue, 14 Oct 2025 13:02:58 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:02:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <aO5J_xOfMmz9QbOE@redhat.com>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <7300d719-e354-480f-9476-19e251a461b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7300d719-e354-480f-9476-19e251a461b1@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 13, 2025 at 09:11:47PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/10/25 09:10, Gerd Hoffmann wrote:
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
> > ---
> >   include/monitor/hmp.h      |   1 +
> >   hw/uefi/ovmf-log.c         | 265 +++++++++++++++++++++++++++++++++++++
> >   tests/qtest/qmp-cmd-test.c |   2 +
> >   hmp-commands-info.hx       |  14 ++
> >   hw/uefi/meson.build        |   2 +-
> >   qapi/machine.json          |  23 ++++
> >   6 files changed, 306 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/uefi/ovmf-log.c
> 
> At a glance, why not "info ovmf-log" and "query-ovmf-log"?

I would say that conceptually any firmware could expose logs in memory
for QEMU to access. So even if we only have an impl for OVMF today,
it makes sense to leave the door open for impls for other firmware
types.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


