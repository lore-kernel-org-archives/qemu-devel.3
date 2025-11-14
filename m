Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84E6CE7A9A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJpvn-0003nE-Lx; Fri, 14 Nov 2025 04:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vJpvc-0003Yx-4g
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vJpva-0003LS-2A
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763111828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=0k9gE9OBnyE+OiyzVseSUkJqX807Y3xb0ASD5xFtiRg=;
 b=BMGcg9eJxE5WtJQppJ7/XpXEhcxThJgBjFGNxamWBbYEOQKget66iAsf7U1mfBpL8ST0Gw
 xrj906r59uAjCB8SO/5MEpFwQk/O48RDIE0muwm4B23tsYX/Z2I3cDFPJeLxYnF8dNZk3h
 XD6K/h1eK0+TXDARHiS9N8HjmYxtyf4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-5Jb_QW3SMpOSOeJQrTTggg-1; Fri,
 14 Nov 2025 04:17:03 -0500
X-MC-Unique: 5Jb_QW3SMpOSOeJQrTTggg-1
X-Mimecast-MFC-AGG-ID: 5Jb_QW3SMpOSOeJQrTTggg_1763111822
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 181C21956094; Fri, 14 Nov 2025 09:17:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EA611955F1B; Fri, 14 Nov 2025 09:17:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 647BC21E6A27; Fri, 14 Nov 2025 10:16:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org, Vikram Garhwal
 <vikram.garhwal@amd.com>
Subject: Incorrect error handling in xen_enable_tpm()
Date: Fri, 14 Nov 2025 10:16:58 +0100
Message-ID: <87jyzt0y9h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Consider xen_enable_tpm() in hw/xen/xen-pvh-common.c:

    static void xen_enable_tpm(XenPVHMachineState *s)
    {
        Error *errp = NULL;

Nitpick: confusing name; we use @errp for Error ** variables, not for
Error * variables.  Better: @err.

        DeviceState *dev;
        SysBusDevice *busdev;

        TPMBackend *be = qemu_find_tpm_be("tpm0");
        if (be == NULL) {
            error_report("Couldn't find tmp0 backend");
            return;
        }
        dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
        object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);

If this fails, @errp changes to non-null.

        object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);

If this then succeeds, @errp remains non-null.  Since we ignore it, we
leak the Error object.

If it also fails, we trip error_setv()'s assertion, because we violate
qapi/error.h rule

 * - You may pass NULL to not receive the error, &error_abort to abort
 *   on error, &error_fatal to exit(1) on error, or a pointer to a
 *   variable containing NULL to receive the error.

Taking a step back from the incorrect error handling: we're setting the
same property *twice*.  Why?

As far as I can tell, property "tpmdev" is not a link.  It's defined
with DEFINE_PROP_TPMBE(), i.e. setting it runs set_tpm() from
backends/tpm/tpm_util.c.  Passes the value to qemu_find_tpm_be(), which
appears to take a TPMBackend ID.

I suspect the object_property_set_link() always fails, and we leak the
Error object.

I'd verify this in a debugger, but I don't have a Xen box handy.

Code goes back to commit 733766cd373 (hw/arm: introduce xenpvh machine).

        busdev = SYS_BUS_DEVICE(dev);
        sysbus_realize_and_unref(busdev, &error_fatal);
        sysbus_mmio_map(busdev, 0, s->cfg.tpm.base);

        trace_xen_enable_tpm(s->cfg.tpm.base);
    }


