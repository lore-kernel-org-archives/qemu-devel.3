Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D4AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0BK-0004z9-Ac; Tue, 07 Jul 2026 03:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh0BJ-0004yy-5D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh0BH-00063H-GZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783409122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnWFM15/Pteee7xY8knlJKEpTgQJbVtCB5xqqBmJLLk=;
 b=LeGx3/ZXKvMTdZNUqi1AeKEQDv9/vaeo6VPIffWf0zkeXfkIVWoIzpAnEP32EX5OYTUszx
 Ge0GVQrn4hImZUU5oMi0CAXpCgs7ncC+SuufTgYCwxKLgkT3Nz4qbP7ZiKJieIMv/MFgBU
 r2hUPoIMdA4QSZD1JUa84Sq1qRaVNac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-gEW8RVAVN96tk44izhjs0A-1; Tue,
 07 Jul 2026 03:25:20 -0400
X-MC-Unique: gEW8RVAVN96tk44izhjs0A-1
X-Mimecast-MFC-AGG-ID: gEW8RVAVN96tk44izhjs0A_1783409119
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB89E1805C2B; Tue,  7 Jul 2026 07:25:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AF271955F71; Tue,  7 Jul 2026 07:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB89F21E6920; Tue, 07 Jul 2026 09:25:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Christian Brauner <brauner@kernel.org>,
 devel@lists.libvirt.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v7 05/35] monitor: minimal conversion of monitors to QOM
In-Reply-To: <87tsqbjnrb.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 07 Jul 2026 08:51:36 +0200")
References: <20260706135824.2623960-1-berrange@redhat.com>
 <20260706135824.2623960-6-berrange@redhat.com>
 <87tsqbjnrb.fsf@pond.sub.org>
Date: Tue, 07 Jul 2026 09:25:15 +0200
Message-ID: <87y0fni7ms.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> This introduces abstract QOM type "monitor", with concrete subtypes
>> "monitor-hmp" and "monitor-qmp". This is the bare minimum conversion
>> of just the type declarations and replacing g_new/g_free with
>> object_new/object_unref.
>>
>> Command line option "-monitor" now creates a "monitor-hmp" object
>> "/objects/compat_monitorNNN" in addition to the character device
>> "/chardevs/compat_monitorNNN". NNN counts up from zero.
>>
>> Exception: "-monitor chardev:ID" creates a "monitor-hmp" object
>> "/objects/ID", and does not create a character device.
>>
>> "-qmp" and "-qmp-pretty" work the same, except they create a
>> "monitor-qmp" object.
>>
>> "-mon" now creates either a "monitor-hmp" or "monitor-qmp" object
>> "/objects/ID" if the option argument provides an ID, else
>> "/objects/compat_monitorNNN".
>>
>> "-gdbstub" and "-serial mon:..." now create a "monitor-hmp" object
>> "/objects/compat_monitorNNN".
>>
>> Note that the object's name in "/objects/" matches the QemuOpts ID when
>> it exists.  The only cases where it doesn't exist are "-mon" without ID,
>> "-gdbstub" and "-serial mon:".
>>
>> A future patch will make "monitor-hmp" and "monitor-qmp" work with
>> "-object" and "object-add".
>>
>> Note: there is a slight change in the NNN values assigned. The old
>> code would increment the counter for every monitor added, regardless
>> of whether it needed a "compat_monitorNNN" ID assignment. Now it is
>> only incremented when an automatic ID assigned is needed, from any
>> of -mon, -gdbstub or -serial.
>
> This isn't quite right.  The old code increments the counter for every
> monitor added with monitor_parse(), i.e. the monitors added with
> -monitor, -qmp, -qmp-pretty, and most default monitors.  -mon, -serial
> mon:..., and -gdbstub don't use monitor_parse().
>
> If we don't need a respin (which seems likely), I can amend this to
>
>   Note: there is a slight change in the NNN values assigned. The old
>   code would increment the counter for every monitor added (except for
>   -mon, -serial mon:..., -gdbstub), regardless of whether it needed a
>   "compat_monitorNNN" ID assignment. Now it is only incremented when an
>   automatic ID assigned is needed (but even for -mon, -serial mon:...,
>   -gdbstub).
>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Preferably with the change to NNN stated more precisely
Reviewed-by: Markus Armbruster <armbru@redhat.com>


