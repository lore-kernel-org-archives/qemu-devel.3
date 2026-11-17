Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21B606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=kWpnYvg9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKe3-00065E-K4; Tue, 17 Nov 2026 09:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTKdh-00063U-KM
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:58:32 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTKdf-0000hD-J1
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1794927495; bh=lgcHjJy01yWYnl1Fg5rvRkVuFDyiYuZ4XtWy0dgNako=;
 h=From:To:Cc:Subject:Date:From;
 b=kWpnYvg9KwhFzyips1M58NQSjtCk26qLt86ddVEPvcafF1gGWvTXcN1TaLbhf04oC
 W3jzPryFAYrgNLN36NaJIxwGxP3CO3fedQfNnKx/zzHSClpUEjg0+yxlCJkil7uQ3v
 +qBPyuUPdtuWkWMw+VgUgVYtX3sb6MlDenbdYoLw=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 8D9482017D;
 Tue, 17 Nov 2026 15:58:15 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C42121E6A04; Tue, 17 Nov 2026 15:58:21 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jagannathan Raman
 <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: x-remote-object breaks QOM introspection
Date: Tue, 17 Nov 2026 15:58:21 +0100
Message-ID: <87jymbjyia.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Watch this:

    $ qemu-system-x86_64 -S -nodefaults -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 90, "minor": 1, "major": 11}, "package": "v11.2.0-rc0-3-g38171f59ccb-dirty"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute": "qom-list-properties", "arguments": {"typename": "x-remote-object"}}
--> qemu-system-x86_64: (null) is not a PCI device
    {"return": [{"name": "type", "type": "string", "qapi-type": "str"}, {"name": "devid", "type": "string", "qapi-type": "str"}, {"name": "fd", "type": "string", "qapi-type": "str"}]}

The error message is suspicious.  Origin:

    static void remote_object_machine_done(Notifier *notifier, void *data)
    {
        RemoteObject *o = container_of(notifier, RemoteObject, machine_done);
        DeviceState *dev = NULL;
        QIOChannel *ioc = NULL;
        Coroutine *co = NULL;
        RemoteCommDev *comdev = NULL;
        Error *err = NULL;

        dev = qdev_find_recursive(sysbus_get_default(), o->devid);
        if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
            error_report("%s is not a PCI device", o->devid);
            return;
        }

o->devid is null, dev is null.

Glibc's %s shows null pointer as "(null)".  There are libcs that simply
crash.

Stack backtrace:

    #0  remote_object_machine_done (notifier=0x5555587d17e8, data=0x0)
        at ../hw/remote/remote-obj.c:93
    #1  0x000055555578700e in qemu_add_machine_init_done_notifier
        (notify=0x5555587d17e8) at ../hw/core/machine.c:1721
    #2  0x00005555556f26dd in remote_object_init (obj=0x5555587d17c0)
        at ../hw/remote/remote-obj.c:149
    #3  0x0000555555cbda2d in object_init_with_type
        (obj=0x5555587d17c0, ti=0x5555577c02d0) at ../qom/object.c:430
    #4  0x0000555555cbde2c in object_initialize_with_type
        (obj=0x5555587d17c0, size=136, type=0x5555577c02d0) at ../qom/object.c:512
    #5  0x0000555555cbe6fa in object_new_with_type (type=0x5555577c02d0)
        at ../qom/object.c:710
    #6  0x0000555555cbe784 in object_new
        (typename=0x555558356a10 "x-remote-object") at ../qom/object.c:726
    #7  0x0000555555e2d6be in qmp_qom_list_properties
        (typename=0x555558356a10 "x-remote-object", errp=0x7fffffffd888)
        at ../qom/qom-qmp-cmds.c:290
    [...]

I believe using qemu_add_machine_init_done_notifier() is wrong here.
Could we use UserCreatableClass method complete()?

Aside: we should probably check all uses of
qemu_add_machine_init_done_notifier().

