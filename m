Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9344C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcEH-0001XM-8g; Fri, 03 Jul 2026 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfcED-0001WX-Ly
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfcEC-0006zg-0S
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783078717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CREgDqzdZj7JfDlFIDeHOGar0tyKoeI7+AhBoIhNngA=;
 b=ZIdJ9wLSyBXjbzJqP3JAX8ECpCys5dwnyqFPCL2JHC+/baJnRv0yxTiWOpxnkrLnAabwgy
 ftKMvXeUI36wR5CIgOy7eJPuIEqgL95w6ZnHhhHicfZOmqu8a191um5SqOtjhfahTIYlIB
 /PSdBzHQipWSeUxb8Hj/eQEkLuxUYZw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-O4H42y2dNUeI_IXvGwwC_A-1; Fri,
 03 Jul 2026 07:38:36 -0400
X-MC-Unique: O4H42y2dNUeI_IXvGwwC_A-1
X-Mimecast-MFC-AGG-ID: O4H42y2dNUeI_IXvGwwC_A_1783078715
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A22F51800350; Fri,  3 Jul 2026 11:38:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE18130030D6; Fri,  3 Jul 2026 11:38:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C06021E6920; Fri, 03 Jul 2026 13:38:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David
 Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Christian
 Brauner <brauner@kernel.org>,  devel@lists.libvirt.org
Subject: Re: [PATCH v6 05/34] monitor: minimal conversion of monitors to QOM
In-Reply-To: <20260702160337.1910921-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2026 17:03:08
 +0100")
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-6-berrange@redhat.com>
Date: Fri, 03 Jul 2026 13:38:31 +0200
Message-ID: <87tsqgwbew.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This introduces a Monitor QOM object, with MonitorHMP and
> MonitorQMP subclasses. This is the bare minimum conversion
> of just the type declarations and replacing g_new/g_free
> with object_new/object_unref. The Monitor base class is
> abstract since only the HMP/QMP variants should ever be
> created.
>
> When created through the existing QemuOpts interfaces, the
> new internal QOM object will get assigned a dynamic ID with
> the format "compat_monitorNNN" which is the historical
> QemuOpts ID naming pattern.

Uh, sometimes the name isn't "compat_monitorNNN".

I'm not sure whether talking about QemuOpts helps or hurts here.  Let me
try not to talk about it:

  This introduces abstract QOM type "monitor", with concrete subtypes
  "monitor-hmp" and "monitor-qmp". This is the bare minimum conversion
  of just the type declarations and replacing g_new/g_free with
  object_new/object_unref.

  Command line option -monitor now creates a monitor-hmp object
  /objects/compat_monitorNNN in addition to the character device
  /chardevs/compat_monitorNNN. NNN counts up from zero.

  Exception: -monitor chardev:ID creates a monitor-hmp object
  /objects/ID, and does not create a character device.

  -qmp and -qmp-pretty work the same, except they create a monitor-qmp
  object.

  -mon now creates a monitor-hmp or monitor-qmp object /objects/ID if
  the option argument provides an ID, else /objects/compat_monitorNNN.

If you want to make the connection to QemuOpts ID, add

  Note that the object's name in /objects/ matches the QemuOpts ID when
  it exists.  The only case where it doesn't exist is -mon without ID.

Finally, point to what's coming:

  A future patch will make "monitor-hmp" and "monitor-qmp" work with
  -object and object-add.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


