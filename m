Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF85C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhPU-0006If-Cn; Wed, 19 Aug 2026 10:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhPS-0006I9-M2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhPR-0004nW-01
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787150211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmXjfwCmTfVMRqKrhfGrzsJ8XvFEy4ttP1QoJxRfwG8=;
 b=Jg2aO17rhNdrvIKQxqQJkpYM6eFWGRDZIKu4huIdXz9eVbzLa1sfYKxhn75Ycl8mi13RU5
 5vMv9PjgWT7Jdv0fkdS/nraSz4ud9Z32LegzdIFWGTh8PnQRn4lKCHYFPjZRHR1so7vFS0
 XrLM7XBjrEghrW1Isi13kLN5YYgU7hw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-CC-F7gelOBiMhSjjYhvCwA-1; Wed,
 19 Aug 2026 10:36:48 -0400
X-MC-Unique: CC-F7gelOBiMhSjjYhvCwA-1
X-Mimecast-MFC-AGG-ID: CC-F7gelOBiMhSjjYhvCwA_1787150205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF8A719560AA; Wed, 19 Aug 2026 14:36:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80E44180049F; Wed, 19 Aug 2026 14:36:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 01/15] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-2-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-2-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 18:35:56 +0400
Message-Id: <178715015696.1965216.10979145162816192852.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=548;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lJtqtwgEC1U6HmL7xalBDYBJQLrSqM3pJKRqM9vgJIc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhb9QF/dOhDDaI3WUVEj4ZjdKKhY7K4mThKwg3
 SO/LS8cmDKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoW/UAAKCRDa6OEJdZac
 5VMHD/907b9lvFATUDj369Pe+3CBRAqXc3ip4WF/2ZxgWau6eRS1MiUnxdCEZmRjn+W7PvPBUqH
 FR1slwlZegaasslZIZ4CzSrL/J0F1JbEa3b/xK14/8i90TYjBR9GQ/TWNA5gNpMOkcrV8D9K/9U
 vAUk1f0DzNyT54EA2hVEHfpWmTv59XYOIPaOoDao8wbf7wvZoWKVR5cw95bqF8+QtuNq5ICy0j1
 6RiOzex/QCqlmyotgE+6ezF3FBBgOmohvl9iZp4vl99NVAnmMSHiJzQhsPbp5B1OEIKeVqnzFKl
 OnwY5INlmlqosX7r6rm36UKknx+RB/w1A8aqQ116Eduuy+YkO5YYOSWIjOjXbsdSDguoZy8RXrN
 lauSfPlvo9fZzPyCrOZKHMCFw29QPE13OjKsNiw+Mocex2HWuvcC3MwO/N12eOu3Z0hwpgp+TLH
 en8Qdy2afqjDIGTvyDO04EUJa6Kp5WKbiRKCz3zAtT7YDHc2DykMvBfCcYLaxKDh8St73EQ0TD/
 Ohu+zlqSDJ37Q0BGq4bDKD3YhiPQ0hynBA8VFJkx8SiScYqrczNeMg0RJpW/vNA1DHUS5Nmek7u
 bERfRyVSvpXZahAsow9UC9OhTMCvCJCXi5XZ3sf4xpM6PdnKajL1l7L9Jxo4vktMOmu4B3OzNW9
 q++ruyXsMsK36Eg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, 19 Aug 2026 14:35:40 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> This macro will be used to generate the boilerplate property_class_get_type_ptr()
> QOM get function for the specified scalar type.
> 
> Note that since the macro is currently unused, the object_class_prop_ptr() helper
> function is temporarily marked as __attribute__((unused)) to allow compilation to
> succeed.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


