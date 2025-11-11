Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF020CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsWs-00037a-Bx; Tue, 11 Nov 2025 12:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIsVn-0001k9-5O
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIsVj-0001QK-Rn
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762883429;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/5k6Zv3bFjP+S9LKnE1EhHuUwVL2y66SegrfTu0prw=;
 b=X69AYBlq4aaSX28TgDfCEIRlhKDT7WzQ1hqZY6yUlQ7c2wT5uiXdwrl92KYAMDppwApmxe
 xwsY9L13qy/r5DosXg2xMWSigHFUwolqjLtQHDUTWwlL/44CCy91z1Ajx/N5YAsnvnM8/J
 MTEpN5vmDtm93YWKmTkKnnzRLw1bnFc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-t3gG3aYoOvOCBoVYe3El7w-1; Tue,
 11 Nov 2025 12:50:24 -0500
X-MC-Unique: t3gG3aYoOvOCBoVYe3El7w-1
X-Mimecast-MFC-AGG-ID: t3gG3aYoOvOCBoVYe3El7w_1762883422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC216180048E; Tue, 11 Nov 2025 17:50:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEB471800451; Tue, 11 Nov 2025 17:50:15 +0000 (UTC)
Date: Tue, 11 Nov 2025 17:50:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 15/16] gitlab: make the schedule rules a bit more general
Message-ID: <aRN3VFAjOur1075y@redhat.com>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-16-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111171724.78201-16-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 11, 2025 at 05:17:22PM +0000, Alex Bennée wrote:
> By default no jobs should run under the schedule and then we can be
> more explicit for the ones that we need to. Otherwise I trigger all my
> custom runners every time I do a scheduled run.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.d/base.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


