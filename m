Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E6AFEFB42
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwjo-0006Il-Mj; Fri, 27 Feb 2026 07:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvwjm-0006IC-BB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvwjk-0003a2-Qn
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772194467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FjUJkF+/PmBJnNQmlMZeB0eh9CxOKPQB4KUBCufMfNM=;
 b=ZGm0H3AcMKhu3JcxdCITXGmWibsOr1fPgtQEqLeV9EBhYo/ZwCLmT92d7/p2JKbcabLd0K
 emadQN/9m2RdPWbwQZUF7TO/H9B/NmxzYkvUjjFbzzVWZ5eSlO3bsWv3/lLJt/Ma1fBinB
 Cdp8bBiiIfi8fscJsYuVMlvvbpYwBc0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-3D5kjEbBPty4BKL-ZreIOw-1; Fri,
 27 Feb 2026 07:14:26 -0500
X-MC-Unique: 3D5kjEbBPty4BKL-ZreIOw-1
X-Mimecast-MFC-AGG-ID: 3D5kjEbBPty4BKL-ZreIOw_1772194465
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48BE319560A1; Fri, 27 Feb 2026 12:14:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F4B71956053; Fri, 27 Feb 2026 12:14:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E7C6A21E6932; Fri, 27 Feb 2026 13:14:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>,  QEMU Developers <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Qemu-block
 <qemu-block@nongnu.org>,  Peter Lieven <pl@dlhnet.de>
Subject: Re: block/nfs.c and libnfs vs Fedora 43
In-Reply-To: <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 26 Feb 2026 10:44:58 +0000")
References: <20260224181440.832943-1-jsnow@redhat.com>
 <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
Date: Fri, 27 Feb 2026 13:14:21 +0100
Message-ID: <87bjha9yea.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

[...]

> I guess for the moment we should fix the Coverity build
> by dropping the --enable-libnfs (and accepting that we
> don't scan block/nfs.c any more). For the longer term:
>
>  * does anybody want to update block/nfs.c ?

Plan A: somebody does that.

>  * or should we mark it as deprecated and plan to eventually
>    drop it, given that the set of supported distros you can
>    build it on is rapidly shrinking ?

Plan B.

I recommend to execute on of them in this development cycle.  We can
always un-deprecate if somebody updates it during the deprecation grace
period.


