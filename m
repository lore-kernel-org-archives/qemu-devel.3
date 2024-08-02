Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5B1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnNG-0003Zd-7g; Fri, 02 Aug 2024 04:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZnNE-0003Z4-UQ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZnND-0002fO-FX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722586250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aw/rFKO34m01nO3k0ZRAEwRYLp8tDrHaDJqnwBAm4cc=;
 b=S0bSrtxAsyR0vouXsMhuVezp0UI40BZ5AjkE1civQ9xUKtP8h+jlQFKRdDI6dR8K07IC6c
 ND6sexHX0QyOo1rYkORHvZmwti+vqfwh3SGyLp4fepNnwv3O1gUtq09v4mPAajXe/Kzhu4
 sjflO37Y92jMFqwgQr75fUukgxz6M9M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-OmHPfXdYNay7RZcjwwt8Cw-1; Fri,
 02 Aug 2024 04:10:47 -0400
X-MC-Unique: OmHPfXdYNay7RZcjwwt8Cw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27A3F1955D44; Fri,  2 Aug 2024 08:10:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBB2C19560AE; Fri,  2 Aug 2024 08:10:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB2E421E668F; Fri,  2 Aug 2024 10:10:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  pkrempa@redhat.com,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] qdev-monitor: avoid QemuOpts in QMP device_add
In-Reply-To: <20240801140552.1021693-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Thu, 1 Aug 2024 10:05:50 -0400")
References: <20240801140552.1021693-1-stefanha@redhat.com>
Date: Fri, 02 Aug 2024 10:10:43 +0200
Message-ID: <87wmkz5oqk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Can we additionally cut out the QemuOpts middleman in
usbback_portid_add()?

    qdict = qdict_new();
    qdict_put_str(qdict, "driver", "usb-host");
    tmp = g_strdup_printf("%s.0", usbif->xendev.qdev.id);
    qdict_put_str(qdict, "bus", tmp);
    g_free(tmp);
    tmp = g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
    qdict_put_str(qdict, "id", tmp);
    g_free(tmp);
    qdict_put_int(qdict, "port", port);
    qdict_put_int(qdict, "hostbus", atoi(busid));
    qdict_put_str(qdict, "hostport", portname);
    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
                                &error_abort);
    usbif->ports[port - 1].dev = USB_DEVICE(qdev_device_add(opts, &local_err));

Trying this is up to you!


