Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754FBC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHnk-0000io-TS; Tue, 20 May 2025 03:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHnh-0000hY-7Q
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHne-00068I-0P
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747727647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5W192i+yDnsm8OjG5xdVppDZHOt5FHE5nKNBLrYRTpA=;
 b=UxdkeFHmzj94RvQaK551XK3c299IvYHy/jGwP0L5fWlnM+F5BNd0WTFRO7M7gxIWBXldhd
 CwvOZQEqPUgvnsS6rsGx5+4CDM7wcShrQByPCsO9TM5kMv+lYiL0O/kQzqibe684w3ewB/
 Kr3Eyg1SrT/YYoE1RwH3BHaMsSwbCbU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-OQK9D0YAPFi54HH8d1l-uQ-1; Tue,
 20 May 2025 03:54:03 -0400
X-MC-Unique: OQK9D0YAPFi54HH8d1l-uQ-1
X-Mimecast-MFC-AGG-ID: OQK9D0YAPFi54HH8d1l-uQ_1747727642
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD1BA19560B1; Tue, 20 May 2025 07:54:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E76DC1955F21; Tue, 20 May 2025 07:54:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45D6821E6757; Tue, 20 May 2025 09:53:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  qemu-rust@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,  Cleber Rosa
 <crosa@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/8] Python: Fix 'make check-dev' and modernize to 3.9+
In-Reply-To: <20250519182153.3835722-1-jsnow@redhat.com> (John Snow's message
 of "Mon, 19 May 2025 14:21:44 -0400")
References: <20250519182153.3835722-1-jsnow@redhat.com>
Date: Tue, 20 May 2025 09:53:58 +0200
Message-ID: <871psjbtux.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> This series does a couple things that I'll probably end up splitting out
> into smaller series if history is any guide, but either way, here it
> goes:
>
> A) Convert qemu.git/python/ to a PEP517/pyproject.toml
> package. Ultimately this means deleting setup.py and fully migrating to
> newer python infrastructure. I think this should be safe to do by now,
> but admittedly I am not *confident* as it relies on setuptools versions
> in the wild, not python versions. My motivation for trying it is to fix
> "make check-dev", which has been broken for the last two Fedora releases
> under newer setuptools which have started removing support for the
> pre-PEP517 packaging formats, which will only continue to get worse from
> here on out.
>
> B) Sync changes from the qemu.qmp package back over to qemu.git. I know
> I need to decouple this badly, but in order to do so, I need to make
> sure they're synchronized to be assured that the switch to the
> standalone version won't break anything, so this is a necessary
> step. It's happening here because of the 3.6+ compat crud we are still
> carrying in qemu.git that has since been removed from the standalone
> library.
>
> C) Move us to 3.9+ style type hints. I know it feels like we just got
> the type hints settled and we're already changing them. Sorry about
> that. They are deprecated in 3.9, and *could* be removed at any time. I
> figured now was a good time as any to get rid of them before they become
> a problem randomly some day in the future.
>
> D) Update the mypy configuration to check under multiple Python versions
> more effectively and thoroughly.
>
> Whew.
> --js

Appears to be

Based-on: <20250519170055.3693275-1-jsnow@redhat.com>


