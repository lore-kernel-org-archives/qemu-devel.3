Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068E6CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXRO-0005a0-1s; Mon, 08 Jun 2026 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXRL-0005ZU-Ig
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXRJ-0007js-MG
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780915360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=deQZvy4vd8KpZz3qySTWJvStoSUs3vbQyKR1XDRzec4=;
 b=aIAqS+fpQ9+EsY4xKRBYTKFKWPK62NyrMjWyVqmvQGjqT1zwqs79urt37AIHPuFZFLnJzb
 PFJK3fTbTMc2l3EoJBzfjLLe9aHIeXGZ8YocFQgP6HJ9McHaYTrVWREnUgIp1h8LxSBk2x
 ol0ZHURYTZshVRa/mxeBPbI0R0igxaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-ckFr6u6GNBCKEL6RMSCiKA-1; Mon,
 08 Jun 2026 06:42:32 -0400
X-MC-Unique: ckFr6u6GNBCKEL6RMSCiKA-1
X-Mimecast-MFC-AGG-ID: ckFr6u6GNBCKEL6RMSCiKA_1780915351
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 653501956080; Mon,  8 Jun 2026 10:42:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 088E33008B36; Mon,  8 Jun 2026 10:42:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BBC521E6A01; Mon, 08 Jun 2026 12:42:28 +0200 (CEST)
Resent-To: zhangckid@gmail.com, qemu-devel@nongnu.org, dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 08 Jun 2026 12:42:28 +0200
Resent-Message-ID: <87ecihia97.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V8 15/15] iothread: simplify API by merging
 iothread_get_aio_context variants
In-Reply-To: <CAK3tnvJauCiFZNW84JP39KoXD5NieVV5b+GR_F0yeixYbw3Biw@mail.gmail.com>
 (Zhang Chen's message of "Thu, 4 Jun 2026 19:53:18 +0800")
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-16-zhangckid@gmail.com>
 <87eciorgaj.fsf@pond.sub.org>
 <CAK3tnvJauCiFZNW84JP39KoXD5NieVV5b+GR_F0yeixYbw3Biw@mail.gmail.com>
Date: Mon, 08 Jun 2026 11:34:01 +0200
Message-ID: <875x3tl6k6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Wed, Jun 3, 2026 at 1:41=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:

[...]

>> The patch appears to delete unused iothread_get_aio_context() from
>> iothread.[cg] and to rename iothread_ref_and_get_aio_context() to
>> iothread_get_aio_context().  It leaves iothread_get_aio_context() in
>> tests/unit/iothread.[ch] alone.  The result is confusing: test's
>> iothread_get_aio_context() takes now one parameter less than the regular
>> one.
>>
>> Should you change both versions?
>>
>
> Yes, I already noticed the iothread test, we can change it after
> merging this series.

What about changing it in v9?  Assuming we need a v9.


