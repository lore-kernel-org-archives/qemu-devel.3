Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89815C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7tYa-0008Fd-3y; Fri, 17 May 2024 05:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7tYX-0008FF-UW
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7tYS-00056Z-MR
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715936828;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HtbBl1Rj4SG9Y9BtL+88zyOxJHV7yPyKtFdNlCz+tM=;
 b=PWV82g/LgsE3KKBE5Rj15pKgAZ0r9K6sKa5kQ3+d2vhumzHEfuUWOaaJk9rEl70unHJZtd
 GB0RkGEaoSfNXN9phWnUSRvgZALhZpElu5dQohIgvh0JuXj7jhp5UDXl7O5PeYnxxPi6tv
 6903KBCtNFm4r8S3+JObSxRtFc45ppg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Bdsnyg_QPYm5C5YiJ6m-Gw-1; Fri, 17 May 2024 05:07:05 -0400
X-MC-Unique: Bdsnyg_QPYm5C5YiJ6m-Gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C75A185A783;
 Fri, 17 May 2024 09:07:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE165105552A;
 Fri, 17 May 2024 09:07:03 +0000 (UTC)
Date: Fri, 17 May 2024 10:07:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/3] crypto: Restrict pkix_asn1_tab[] to
 crypto-tls-x509-helpers.c
Message-ID: <ZkceNVBZI9kLAL7W@redhat.com>
References: <20240502095642.93368-1-philmd@linaro.org>
 <20240502095642.93368-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502095642.93368-3-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 02, 2024 at 11:56:41AM +0200, Philippe Mathieu-Daudé wrote:
> pkix_asn1_tab[] is only accessed by crypto-tls-x509-helpers.c,
> rename pkix_asn1_tab.c as pkix_asn1_tab.c.inc and include it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/unit/crypto-tls-x509-helpers.h                | 3 ---
>  tests/unit/crypto-tls-x509-helpers.c                | 6 +++++-
>  tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} | 5 +----
>  tests/qtest/meson.build                             | 3 +--
>  tests/unit/meson.build                              | 6 +++---
>  5 files changed, 10 insertions(+), 13 deletions(-)
>  rename tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} (99%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


