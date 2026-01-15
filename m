Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B36D4116C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLU1-0007qK-Sj; Thu, 15 Jan 2026 06:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgLTv-0007Rg-IF
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgLTt-0001DP-9W
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmBEssY0jXCkxvgR3txCZsFqa9ddUgtti5B0iGwid1M=;
 b=KcJO+LrKAOCN5tNVZbHz5gYJTO9OBjBaImxm1LfExTljI9Jm/jIktdhJ0LtdZr+Hjl9bRx
 uPWlrOFf7SxKSiTW0bLYFa7rho7peMPkOE6oWznLC5RHFq4VcBa08WTqNGikHEjWhLQop2
 50DmEdgs8BYzHh8noA2F+/PX5sVv6/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-sja2D0B5PtSjAIM56mOi8Q-1; Thu,
 15 Jan 2026 06:25:23 -0500
X-MC-Unique: sja2D0B5PtSjAIM56mOi8Q-1
X-Mimecast-MFC-AGG-ID: sja2D0B5PtSjAIM56mOi8Q_1768476322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 706BF1956088; Thu, 15 Jan 2026 11:25:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0AAA1955F22; Thu, 15 Jan 2026 11:25:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49CE021E692D; Thu, 15 Jan 2026 12:25:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Reinoud Zandijk <reinoud@NetBSD.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ryo ONODERA <ryoon@netbsd.org>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
In-Reply-To: <aWjBiwjKpfmnaBSe@gorilla.13thmonkey.org> (Reinoud Zandijk's
 message of "Thu, 15 Jan 2026 11:29:31 +0100")
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org>
 <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
 <5279bbb4-a4b8-4c71-8275-92643b8796d7@redhat.com>
 <aWjBiwjKpfmnaBSe@gorilla.13thmonkey.org>
Date: Thu, 15 Jan 2026 12:25:18 +0100
Message-ID: <87a4yfxgm9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reinoud Zandijk <reinoud@NetBSD.org> writes:

> On Wed, Jan 14, 2026 at 01:17:20PM +0100, Paolo Bonzini wrote:
>> On 1/14/26 12:28, Reinoud Zandijk wrote:

[...]

>> We're not asking you to keep CI up-to-date (which Thomas is doing now,
>> despite having no specific need that I know of to support NetBSD), just to
>> *report* failure to build from source and tell us "hey, that's how we fixed
>> it".  Otherwise we have the false impression that no one even cares about
>> new QEMU on NetBSD.
>
> As pkgsrc normally tracks releases and has a directory with local patches on
> top of that, build errors only show up when we bump the version. Version 10.2
> is now in pkgsrc though I am running 10.1.3 so there is surely interest in
> keeping it running. I could try to commit some more trivial patches in the
> repo here to reduce the diffs some more.

Fixing the build long after it broke is less than ideal.  What would it
take to get NetBSD covered in CI?


