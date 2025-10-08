Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B219CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 09:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6QWC-0007N9-Lf; Wed, 08 Oct 2025 05:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6QWA-0007N1-Na
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 05:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6QW8-0006uC-BG
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 05:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759915885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHnqn1ophAeQb2IrwJl/N+5qFIDqmInjn/Kta3UEQhw=;
 b=PFRz7bQW6+zcoYGnbHj1dgzU21UHdZWTYTX6/LiJJ7TZdw+8nMLI289IQc0fADXtzVfeKB
 1d7I1UfNSUVKFztyKrcfkvfR397BeapK5IlcmsvRDUkzckdsWDoFx1xKKWQ7eoniNQ3AtH
 QEiRYqBur8wsqu625JCdYKFdAExd0Ho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-gLKgznf_OFScZI1UZAp6tg-1; Wed,
 08 Oct 2025 05:31:22 -0400
X-MC-Unique: gLKgznf_OFScZI1UZAp6tg-1
X-Mimecast-MFC-AGG-ID: gLKgznf_OFScZI1UZAp6tg_1759915881
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D47B11800366; Wed,  8 Oct 2025 09:31:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E179C180035E; Wed,  8 Oct 2025 09:31:17 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:31:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 3/6] tracetool: "import annotations"
Message-ID: <aOYvYk79kRjKuMqO@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008063546.376603-4-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 08, 2025 at 08:35:42AM +0200, Paolo Bonzini wrote:
> In preparations for adding type annotations, make Python process them lazily.
> 
> This avoids the need to express some annotations as strings.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool.py                         | 2 ++
>  scripts/tracetool/__init__.py                | 2 ++
>  scripts/tracetool/backend/__init__.py        | 2 ++
>  scripts/tracetool/backend/dtrace.py          | 2 ++
>  scripts/tracetool/backend/ftrace.py          | 2 ++
>  scripts/tracetool/backend/log.py             | 2 ++
>  scripts/tracetool/backend/simple.py          | 2 ++
>  scripts/tracetool/backend/syslog.py          | 2 ++
>  scripts/tracetool/backend/ust.py             | 2 ++
>  scripts/tracetool/format/__init__.py         | 2 ++
>  scripts/tracetool/format/c.py                | 2 ++
>  scripts/tracetool/format/d.py                | 2 ++
>  scripts/tracetool/format/h.py                | 2 ++
>  scripts/tracetool/format/log_stap.py         | 2 ++
>  scripts/tracetool/format/rs.py               | 2 ++
>  scripts/tracetool/format/simpletrace_stap.py | 2 ++
>  scripts/tracetool/format/stap.py             | 2 ++
>  scripts/tracetool/format/ust_events_c.py     | 2 ++
>  scripts/tracetool/format/ust_events_h.py     | 2 ++
>  19 files changed, 38 insertions(+)
>

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


