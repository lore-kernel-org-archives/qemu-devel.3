Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6A1C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Xr7-0008Sl-6L; Thu, 10 Sep 2026 02:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4Xr2-0008SK-0s
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 02:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4Xqz-0002hB-VW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 02:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789020103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHGDMgU44MIKP/jujva5TAKT8Yp2exwp61Ghvq+JaUQ=;
 b=WaQG1NXRpY3jefZFIlWutrUgYGQVGHMWMqXvv1c/80eDsmKtGST9GwuMalQcMJvEz3aVUL
 XaafI1i3kUB1wIne2RzWiQaV2FIbYJFlPhQrpSz3iMQ3VWSwFr+6f8/3JOFjyba1wHCRGu
 sr5uc/ReVEW/xU5yd3uj0qdNfhdhEX0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-zZmbwIleOUeRXGmNG-rRmw-1; Thu,
 10 Sep 2026 02:01:42 -0400
X-MC-Unique: zZmbwIleOUeRXGmNG-rRmw-1
X-Mimecast-MFC-AGG-ID: zZmbwIleOUeRXGmNG-rRmw_1789020101
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C88418007F0; Thu, 10 Sep 2026 06:01:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCEE11800348; Thu, 10 Sep 2026 06:01:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E04221E6A04; Thu, 10 Sep 2026 08:01:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jason
 Wang <jasowangio@gmail.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH V15 01/14] qapi/misc: Fix missed query-iothreads items
In-Reply-To: <CAK3tnvKuYBi7gMsPCDFQtuVLMVhZ0c4PVQibv=aCgwV4i+5keQ@mail.gmail.com>
 (Zhang Chen's message of "Thu, 10 Sep 2026 13:28:30 +0800")
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-2-zhangckid@gmail.com>
 <5ffaa368-e962-4fed-ac4e-62a8469d9cb2@tls.msk.ru>
 <CAK3tnvKuYBi7gMsPCDFQtuVLMVhZ0c4PVQibv=aCgwV4i+5keQ@mail.gmail.com>
Date: Thu, 10 Sep 2026 08:01:36 +0200
Message-ID: <87a4pphcfz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Mon, Sep 7, 2026 at 3:24=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>>
>> On 9/7/26 09:37, Zhang Chen wrote:
>> > The example is incomplete: it misses members @poll-max-ns, @poll-grow,
>> > @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
>> > (monitor: add poll-* properties into query-iothreads result) and
>> > commit 1793ad0247c (iothread: add aio-max-batch parameter).
>> >
>> > cc: qemu-stable@nongnu.org
>> >
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>
>>
>> This is not technically a part of "iothread: Support tracking and queryi=
ng
>> IOThread holder" series, it's a bugfix by its own.  Can we apply this one
>> without the rest?  I can do it through the trivial-patches tree but it
>> looks like it should go to the qapi tree.
>
> It's OK for me. It looks like the qapi maintainer isn't responding.
> Please apply to the trivial-patches tree and I will drop this patch in
> next version.

I've been responding :)  There's nothing else for QAPI at the moment, so
please take it through qemu-trivial.  Thanks!


