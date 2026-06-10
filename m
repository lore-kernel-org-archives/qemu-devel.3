Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D441BCD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHr-0000BO-SH; Wed, 10 Jun 2026 17:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHo-000850-V6
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHn-0007E2-E8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1UKcYr/on2mtPOZ7Kv59xyON1PI7wVDCltnBmjD5DU=;
 b=NMD9DKijq8Z2631jizmQ7LmN6fvCcM63WEtJ3mMdannoNShi2MBCDlmtdr688VIOzcgKU4
 VRFU2dcgorRIFjo6qa8m8Z+ZNPD9InpjwioT6sPm3OZ12X87w4X+77IT8wX/8aUMnGPfFf
 SxAJCKKSUfREKB8a/CXpJrrR3BNSlf8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-rAcVP6vaNpKMSUknEiV6Lw-1; Wed,
 10 Jun 2026 17:16:27 -0400
X-MC-Unique: rAcVP6vaNpKMSUknEiV6Lw-1
X-Mimecast-MFC-AGG-ID: rAcVP6vaNpKMSUknEiV6Lw_1781126186
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56D26187B9B0; Wed, 10 Jun 2026 21:16:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 123FC36922; Wed, 10 Jun 2026 21:16:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 29/35] tests/functional: add e2e test for dynamic
 QMP monitor hotplug
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-30-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-30-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600393.209622.12796352260496353681.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=603;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SOXoZpq37mefv47Ipl6nsDQU8/CKrzibWPCpeIFiMSQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOFMjYH4Ulml9kIXDN/4pdkNfoQZrznYvz2Z
 cfB3Vagjp6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThQAKCRDa6OEJdZac
 5bdYD/0YFTwJdCJcXxfbMMaWjdo+tjs0RoQFkVRC8NdJlEKhnQrmMLlHW9X69nTkjTkgGY7ps83
 vULHSWtXi6DGAAF1ZUAH0+37qh0xLbnehMqdiCPCY6EqJEoymid/unvC01ECVFZrtBLc6+Ao06+
 OKY0aWOvhWXJByC+qsCQeWRhllDJTjTWsg1YFcf51dtrMdZs/GqHDboYU2mt8VRl137PXhik/26
 Uj4rJRgvRkiR6+tHmfHPDG9HuqoSTqwNMJRj8SgIR/WFnhj3/P2koUSM+UPpcDwob8vrAImsOtM
 nG0Fnrrv69kYHAdE7lOuJBMYAiHlL/kVbd4KifAEQKG2Q7JMrs93y6dXbQxY/lDCsofwIw1sVYH
 PyCNifRfU1PKe9HqKWdCIrQA/6VuQ1yO5iR3ZNlveEP8zJfw9Fkn46Imnquuu/nMVHqfFR0Ux6R
 4DEGHPnlOtYK4EYoTBEGAgu4TRk434PEUQOYqe42KBj9pCc5eejVQE/l+LscKryLWAw6T7Fdt8O
 9FXcGIte+WYz+eMo4b5ndWSglzp0Xy5V22VvKy1QhvPEBAc0FPxnHcRaM7IGdPXsqI2yhLjBOKh
 zr42R2+sxIsbB3BBbF0UllRblJx1b7axxBsLDzhElK3bbidBysnV43Uq+QxgIGOhBDZK6l1DNm4
 PLvOWB4+lIUUdNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Jun 2026 13:34:09 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Add functional tests that exercise dynamic monitor hotplug with real
> socket connections:
> 
> - Hotplug cycle: chardev-add a unix socket, object-add, connect to the
>   socket, receive the QMP greeting, negotiate capabilities, send
>   query-version, disconnect, remove the monitor and chardev, then repeat
>   the entire cycle a second time to verify cleanup and reuse.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


