Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E37C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrDf-0001Cf-2C; Tue, 25 Aug 2026 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyrDd-0001CJ-TL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 09:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyrDc-0006eq-Cv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 09:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787664574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzkIFCZZIsxLexbkMexhnvbZt64Y23EsiRO7Y6mWj5k=;
 b=KZU7JoZKa09Djn1UrfEutdZKb7Vwa72FFQUbh31i0SPc7GEd0IUtx3UqpKk/hJQ5TYi23W
 R25dzdQgEseSR/u6KBmcGVqxzltVfD5UJZMPGIyGMMlsOE1q//ee92RLmoz0c29JmNVYHv
 dgbFxhGOT7TmUYk2/dfP/iMALDWl0bU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-sk-HR7MZNFuIOde-Zs0iPA-1; Tue,
 25 Aug 2026 09:29:31 -0400
X-MC-Unique: sk-HR7MZNFuIOde-Zs0iPA-1
X-Mimecast-MFC-AGG-ID: sk-HR7MZNFuIOde-Zs0iPA_1787664569
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE16419373F3; Tue, 25 Aug 2026 13:29:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07EB330002F1; Tue, 25 Aug 2026 13:29:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7414921E6920; Tue, 25 Aug 2026 15:29:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>, mst@redhat.com,
 imammedo@redhat.com,  anisinha@redhat.com,  philmd@mailo.com,
 aurelien@aurel32.net,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v4 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL
 from object prop to class prop
In-Reply-To: <277163fc-e50b-4b56-b3a9-79db32313c33@nutanix.com> (Mark
 Cave-Ayland's message of "Tue, 25 Aug 2026 13:53:33 +0100")
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-15-mark.caveayland@nutanix.com>
 <aoxBd0tGArc8rwdf@redhat.com>
 <1fd9946e-1d2a-462a-93e3-238f2c67a1b6@nutanix.com>
 <87fr02pt27.fsf@pond.sub.org>
 <277163fc-e50b-4b56-b3a9-79db32313c33@nutanix.com>
Date: Tue, 25 Aug 2026 15:29:25 +0200
Message-ID: <87o6eql45m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

[...]

> Thanks for the pointers as it's something else to add to my set of notes as to how we should best model these things in QEMU. I wonder if there is a suitable place in the documentation we could add this?

docs/devel/style.rst has a section "Error handling and reporting".

There's quite a bit of documentation in qapi/error.h.

Feel free to propose improvements.


