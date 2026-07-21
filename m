Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5037C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmANL-0003r2-Iy; Tue, 21 Jul 2026 09:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmANK-0003qq-Ia
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmANI-0005Wu-Ap
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784639946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCyPK+2XSHZ5BDckkQgVmgaarr787w6zzeQT+B59V7E=;
 b=RHwBGL/kj7yKJqwyNgMfcNx7azoTKFwsYtfS1sFq7xRpmT1UcR7qmnUyeyltSE+v6yuCMQ
 8DT1yklSrMe7HDCWIyOEfi9+NljSPLNco+3qe0Yb8vBZ8LWXYKL0Dd9wyQztFqTxTeD3hM
 6oPtdixcH3Of0n750zh94jvK4+8zw0o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-CK9fBM7HOsmWS9CEvts8aQ-1; Tue,
 21 Jul 2026 09:12:59 -0400
X-MC-Unique: CK9fBM7HOsmWS9CEvts8aQ-1
X-Mimecast-MFC-AGG-ID: CK9fBM7HOsmWS9CEvts8aQ_1784639577
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 667881926B7D; Tue, 21 Jul 2026 13:12:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D15AB1954235; Tue, 21 Jul 2026 13:12:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CC0D21E6920; Tue, 21 Jul 2026 15:12:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/5] util/qemu-sockets: add TCP_USER_TIMEOUT support
In-Reply-To: <20260720053335.2316729-1-Mitsuru.Kariya@oss.nttdata.com>
 (Mitsuru Kariya's message of "Mon, 20 Jul 2026 14:33:35 +0900")
References: <20260524073442.435408-5-Mitsuru.Kariya@oss.nttdata.com>
 <87se758rv2.fsf@pond.sub.org>
 <20260720053335.2316729-1-Mitsuru.Kariya@oss.nttdata.com>
Date: Tue, 21 Jul 2026 15:12:54 +0200
Message-ID: <87ecgwo59l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com> writes:

> Thank you for reviewing, and I'm sorry for the late reply.
>
> Markus Armbruster <armbru@redhat.com> writes:
>> Actually, it's "transmitted data may remain unacknowledged, or
>> buffered data may remain untransmitted".  Moreover, the interaction
>> with @keep-alive is not mentioned.  ...  Have it point to tcp(7) for
>> details?  Perhaps something like [...]  What do you think?
>
> Agreed, thanks -- adopted in v2.  I took your wording almost verbatim,
> with two small adjustments:
>   - reflowed to stay within the 70-column limit the QAPI doc checker
>     enforces (the original wrapping tripped it), and
>   - kept "(Since 11.1)" to match the neighbouring members.
> The interaction with @keep-alive is left to the tcp(7) reference, as you
> suggested, to keep it short.  I also updated the -netdev stream
> addr.user-timeout entry in qemu-options.hx to match (per your other
> comment).  I've added your Suggested-by to the patch.
>
> The text now reads:
>
>   # @user-timeout: maximum time in milliseconds that transmitted data
>   #     may remain unacknowledged, or buffered data may remain
>   #     untransmitted, before the connection is closed.  See tcp(7)
>   #     for details.  Only supported for TCP sockets on systems where
>   #     the TCP_USER_TIMEOUT socket option is defined (Linux only).
>   #     When set to 0, system setting is used.  (Since 11.1)

Better.

Swap "See tcp(7) for details." and the next sentence, to hopefully help
the reader understand what to look for in tcp(7)?


