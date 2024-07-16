Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7138C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmmA-0003PA-Fj; Tue, 16 Jul 2024 14:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmm8-0003Hl-J5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmm6-0002st-Fi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153981;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rePiHqOz5dxYh+e6f/8Igv6KGLYN8Y5O6hshE+KW7uQ=;
 b=bkh2BNiuOBEAn4kP9vv7lxZF53T9LbeUBd1OGrJvZh+3iqeHzOMbxCkXGFq8SyqhA+uzjD
 cIQgYv01t+9ymUxbQXu+UEGB0aH1DRjSzEmbC62FUZ1H60Cdch3IA34A+efWQ+hzl9fnjN
 IiphEOam5nR4LAC7HClUOWOnsNYSZm8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-KiiMzAx0NeS8AHe-O8PlBg-1; Tue,
 16 Jul 2024 14:19:38 -0400
X-MC-Unique: KiiMzAx0NeS8AHe-O8PlBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 485EE1956046; Tue, 16 Jul 2024 18:19:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0493C1955F65; Tue, 16 Jul 2024 18:19:32 +0000 (UTC)
Date: Tue, 16 Jul 2024 19:19:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 06/11] tests/functional: Convert some tests that download
 files via fetch_asset()
Message-ID: <Zpa5sewXArwoIo4s@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <20240716112614.1755692-7-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716112614.1755692-7-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Tue, Jul 16, 2024 at 01:26:09PM +0200, Thomas Huth wrote:
> Now that we've got a working fetch_asset() function, we can convert
> some Avocado tests that use this function for downloading their
> required files.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   | 12 +++----
>  tests/functional/meson.build                  | 25 +++++++++++++++
>  .../test_arm_n8x0.py}                         | 25 +++++++--------
>  .../test_avr_mega2560.py}                     | 11 ++++---
>  .../test_loongarch64_virt.py}                 | 16 ++++++----
>  .../test_mips64el_loongson3v.py}              | 26 +++++++--------
>  .../test_netdev_ethtool.py}                   | 32 ++++++-------------
>  .../ppc_405.py => functional/test_ppc_405.py} | 19 ++++++-----
>  8 files changed, 89 insertions(+), 77 deletions(-)
>  rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (71%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (90%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (89%)
>  mode change 100644 => 100755
>  rename tests/{avocado/machine_mips_loongson3v.py => functional/test_mips64el_loongson3v.py} (55%)
>  mode change 100644 => 100755
>  rename tests/{avocado/netdev-ethtool.py => functional/test_netdev_ethtool.py} (81%)
>  mode change 100644 => 100755
>  rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (73%)
>  mode change 100644 => 100755

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


