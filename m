Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E273C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQJy-0001cJ-JV; Tue, 18 Aug 2026 16:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQJx-0001c7-5p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwQJv-0001V0-D4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEUCv+K3v6EhozbZHUTtFQpBuSNARnGEGVf2YsbPnQg=;
 b=ijXlBEJWAS38bfr+tNcZY5ZGY9RrWlu+XjShRp1lavehA4iJiJEyqBXKqzh75UreiDtdAo
 DRJb18Gg+yHbDrgN/AnmNJQHkOJwwpHAgmgQGg2RlKChfNxuf2LuJTY2XxLs5QA+4DHtCb
 +kA0LUZjqc0gFFvSWXp43ogVpQT09G8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-dk5JJNapOIWARjZmtdQs8g-1; Tue,
 18 Aug 2026 16:21:57 -0400
X-MC-Unique: dk5JJNapOIWARjZmtdQs8g-1
X-Mimecast-MFC-AGG-ID: dk5JJNapOIWARjZmtdQs8g_1787084516
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303D41956057; Tue, 18 Aug 2026 20:21:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFD2D423; Tue, 18 Aug 2026 20:21:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/32] Encode object type security status in code
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
Date: Wed, 19 Aug 2026 00:21:49 +0400
Message-Id: <178708450915.1320462.4853548767474440832.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4237;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=892WSDoQGVSENd9axX7+2MN9Aco+L1QBHzY+AqKz93U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhL7fwZ+Oe9pYosvMZUNNVo9/vaKBeTG3K8AM4
 yAFfGHbXu2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoS+3wAKCRDa6OEJdZac
 5c4bD/9at09nZ/eopJfXCh01Ibq6ZadiA0dSQEqv7pr8aN7Fi2Vd81W/kXG4RhMnCZBMlQAL7Nr
 7qakD0IEM/XmeCuuxf2063mqWi8mGU6eVXbINFKntx84vuNVXct+CrbrHgER6cyq9J3tyF0qwHO
 5T1tTwuQ5hdShZ/OaRZ/b0OG98kDMoIcKQY5djPVbbwYoi79+lo8RrbtNwcBpnqB/AauoQWafVo
 84luMBvoYCrB3bHL/zmIE1LmGrUWMHa8E28g/XKWMqcNQR+bMO2zdNrzkIutmKJZYqYmm4tuJTq
 wDNbiM86oFogDwYwi2FWb6rPM9VcfFfN3G0uMRy5yuVNcXQntZq3QXRIbSmKgeT36geXVhBGIyv
 3Cj04rbi+I9rHCw7a5/FCxokUjkFMtmOEloA0uOOJXzKiGIX9idos7aU/WAdYO2BC5/ZKn/nq9s
 NTbaFFLdqHxX7X4YI2ipZB2js+QO6WenNzqpcu3VeKFrjYWxFzVwXNJzLi4mT5qFDIt5V5jYVg5
 U05GMlEZj41CLJWw4LA7mroLF/mldnZ/CYnOOx5788CHj9Pa2QApyX6umQ9j9xhLAwLKg0L0/nH
 buapwXXt4EK4S+MdGZkUT1Dgtb6GAPz9A3EvvP+jxaxk4yczqV54MyaYk44JWlZ4tZsrgHx2+k2
 FHihxdNQoBgOQRg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> Our docs/system/security.rst file loosely classifies code into that
> applicable for 'virtualization' vs 'non-virtualization' use cases.
> Only code relevant to the former group is eligible for security
> bug handling. Peter's recent proposal pointed out that we are
> increasingly hitting the limits of such a crude classification
> 
> Michael suggested that with the increased complexity, docs are not
> going to be an effective way to convey the information, and we
> need to re-consider embedding this info in code.  This also allows
> users to validate a configuration's security status when starting
> a guest, or modifying a running guest.
> 
> This series is an attempt to start the embedding process.
> 
> Probably I should split in multiple series. One introducing the
> overall framework, and then multiple series doing type annotations,
> as the latter really need to be CC'd to maintainers, but the CC
> list would be way too huge on this combined series. At least this
> combined series shows what the real world implictions of this code
> approach will be though.
> 
> It starts with QOM, adding a "bool secure" property to the
> TypeInfo struct, which get turned into a flag on the Type
> struct. This enables querying any ObjectClass to ask whether or
> not it is declared secure.
> 
> By only using a single boolean flag, at runtime we are unable
> to distinguish between "marked insecure" and "no decision,
> implicitly insecure". As such, all our existing code is
> initially considered insecure, except for that which gets
> explicit annotation.
> 
> The "-compat" argument gains a new parameter
> 
>   * insecure-types=accept|reject|warn
> 
>     The default 'accept' preserves historical behaviour of
>     anything being permissible. The other two options both
>     identify use of types that are not explicitly marked
>     as secure.
> 
> The code annotations are useful immediately, but to make the
> new -compat switch useful, we need to annotate as much as is
> possible. This series makes a strong attempt to do that across
> a large subset of the codebase. My guidance was to mark enough
> as being 'secure', that a downstream RHEL build of QEMU would
> have explicit anntation of most of its devices, with most being
> secure given they target virtualization use cases.
> 
> This annotation is 90% complete for the x86 target, but more
> work is needed to finish it and then address the arch specific
> devices for arm, ppc, s390.
> 
> Example: TCG is explicitly insecure, KVM is explicitly secure:
> 
>   $ qemu-system-x86_64 -display none -compat insecure-types=reject -accel tcg
>   qemu-system-x86_64: -accel tcg: Type 'tcg-accel' does not provide a security boundary to protect against untrusted workloads
>   $ qemu-system-x86_64 -display none -compat insecure-types=reject -accel kvm
>   ^C
> 
> Example: isapc machine type is explicitly insecure
> 
>   $ qemu-system-x86_64 -display none -compat insecure-types=reject -machine isapc
>   qemu-system-x86_64: Type 'isapc-machine' does not provide a security boundary to protect against untrusted workloads
> 
> Example: checks also apply in HMP, ne2k_pci is insecure
> 
>   $ ./build/qemu-system-x86_64 -display none -compat insecure-types=reject -monitor stdio -accel kvm
>   QEMU 10.1.50 monitor - type 'help' for more information
>   (qemu) device_add ne2k_pci
>   Error: Type 'ne2k_pci' does not provide a security boundary to protect against untrusted workloads
> 
> Example: checks also apply in QMP:
> 
>   $ ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 -display none -compat insecure-types=reject -accel kvm
>   Welcome to the QMP low-level shell!
>   Connected
>   (QEMU) device_add driver=ne2k_oci
>   {"error": {"class": "GenericError", "desc": "Type 'ne2k_pci' does not provide a security boundary to protect against untrusted workloads"}}
>   (QEMU) device_add driver=virtio-net
>   {"return": {}}
> 

I'd really like to have this already to help us do some security triage!
The framework looks fine to me. The annotations will require a bit of
discussion, probably.

please make a v3

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


