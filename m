Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CD7D29DEC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfagI-0008WV-9C; Tue, 13 Jan 2026 04:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfagF-0008SD-9r
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfagD-0001QK-KX
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768296433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUUjNGAdXIsW3u+Cs7rkzYgDYmwtwnKXlXlx5Estgqg=;
 b=ACwedFZCFISlWTr5Vz/xSD1oT1cI7uKTgQMhye28JFeLGuUJFWfa02nARy/FUYobK9u1AZ
 AjYJtvL0i/7M6djJgeWu+v5GsE1lo834Wy7PcTd2Gm8D7XZUSfGhR+zG78J2Ef7whP4Wua
 ZupZdSdDPWV5OGRpSOeGFKNdb7L4+3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-5ununNtcODCIonhmXqns6g-1; Tue,
 13 Jan 2026 04:27:09 -0500
X-MC-Unique: 5ununNtcODCIonhmXqns6g-1
X-Mimecast-MFC-AGG-ID: 5ununNtcODCIonhmXqns6g_1768296428
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A22D219560B9; Tue, 13 Jan 2026 09:27:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4094F1956048; Tue, 13 Jan 2026 09:27:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C860721E66C9; Tue, 13 Jan 2026 10:27:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  devel@lists.libvirt.org,
 qemu-block@nongnu.org,  qemu-rust@nongnu.org,  Stefan Weil
 <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 08/24] util: add API to fetch the current thread name
In-Reply-To: <20260108170338.2693853-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:22
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-9-berrange@redhat.com>
Date: Tue, 13 Jan 2026 10:27:04 +0100
Message-ID: <878qe1c17b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> This will be used to include the thread name in error reports
> in a later patch. It returns a const string stored in a thread
> local to avoid memory allocation when it is called repeatedly
> in a single thread. The thread name should be set at the very
> start of the thread execution, which is the case when using
> qemu_thread_create.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/thread.h    |  1 +
>  meson.build              | 21 +++++++++++++++++
>  util/qemu-thread-posix.c | 33 ++++++++++++++++++++++++++-
>  util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
>  4 files changed, 99 insertions(+), 5 deletions(-)

Tempted to store the thread name in TLS and call it a day.


