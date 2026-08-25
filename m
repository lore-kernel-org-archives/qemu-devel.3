Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB9C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymYB-0005dI-4c; Tue, 25 Aug 2026 04:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wymY7-0005d4-MQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wymY6-0006mf-5p
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787646625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8WGD6sJCe/YxGoNzcWacufSpFiQk+La+NQx1/FHfnQ=;
 b=C0gA1Or6y1nU9gQsH1xk8EIdE+KdflcrTLV2Z1ug1+I+pdl1QqtMpEM7SJ5XufCu5Clgdp
 SX+u8Ogq2GpNCRaMpCADFnTh7RPKahWgdlA9Oovx5QyLpu0ygeMtD05WpTNV57d+kLqc9r
 HnectlJZxQZxPO26SFUi/P5R3XHEVs8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-pohnJIAPNo6S72nJRROsPA-1; Tue,
 25 Aug 2026 04:30:21 -0400
X-MC-Unique: pohnJIAPNo6S72nJRROsPA-1
X-Mimecast-MFC-AGG-ID: pohnJIAPNo6S72nJRROsPA_1787646620
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93BBE186A6E9; Tue, 25 Aug 2026 08:30:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2582E422; Tue, 25 Aug 2026 08:30:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B267F21E6920; Tue, 25 Aug 2026 10:30:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V12 13/15] monitor/hmp: display IOThread holders
In-Reply-To: <CAK3tnvLAcR9j5UkMFE7f+Kc09eGaWG5v4feHMxqTfM8=jFmcbA@mail.gmail.com>
 (Zhang Chen's message of "Mon, 24 Aug 2026 17:19:49 +0800")
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-14-zhangckid@gmail.com>
 <87y0e12okc.fsf@pond.sub.org>
 <CAK3tnvL0N3AK78zwZVLP7ycujGeEHhmyuM6VG+LQd3GRg5CtbA@mail.gmail.com>
 <878q5wvwh6.fsf@pond.sub.org>
 <CAK3tnvLAcR9j5UkMFE7f+Kc09eGaWG5v4feHMxqTfM8=jFmcbA@mail.gmail.com>
Date: Tue, 25 Aug 2026 10:30:17 +0200
Message-ID: <87v78yob52.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Mon, Aug 24, 2026 at 3:24=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>

[...]

>> Back to what got us there.  My attempt to test query-iothreads showing
>> holders failed, because monitors are not usable for this test.  Please
>> show me how to test this.  Ideally, a simple command line and a few
>> simple monitor commands ending with a query-iothreads that shows
>> holders.
>>
>
> Thanks. Here is a reproducer that also exercises holder removal and
> registration by another device type:
>
> $ qemu-system-x86_64 \
>     -S -nodefaults -display none \
>     -object iothread,id=3Diothread0 \
>     -blockdev driver=3Dnull-co,node-name=3Dnull0 \
>     -qmp stdio
>
> First, hotplug a virtio-scsi device and query the IOThread:
> {"execute":"qmp_capabilities"}
> {"execute":"query-iothreads"}
>
> {"return": [{"poll-shrink": 2, "thread-id": 4002255, "poll-weight": 3,
> "aio-max-batch": 0, "poll-grow": 2, "holders": [], "poll-max-ns":
> 32768, "id": "iothread0"}]}
>
> {"execute":"device_add","arguments":{"driver":"virtio-scsi-pci","id":"scs=
i0","iothread":"iothread0"}}
> {"execute":"query-iothreads"}
>
> {"return": [{"poll-shrink": 2, "thread-id": 4002255, "poll-weight": 3,
> "aio-max-batch": 0, "poll-grow": 2, "holders": [{"qom-path":
> "/machine/peripheral/scsi0/virtio-backend", "type": "qom-object"}],
> "poll-max-ns": 32768, "id": "iothread0"}]}
>
>  The result contains:
>   > "holders": [
>
> Remove the device:
>
> {"execute":"device_del","arguments":{"id":"scsi0"}}
> {"return": {}}
>
> {"execute":"query-iothreads"}
> {"return": [{"poll-shrink": 2, "thread-id": 4002255, "poll-weight": 3,
> "aio-max-batch": 0, "poll-grow": 2, "holders": [], "poll-max-ns":
> 32768, "id": "iothread0"}]}
>
> And use the HMP is the same logic, just need change the "-qmp" to "-monit=
or":
> $ qemu-system-x86_64 \
>     -S -nodefaults -display none \
>     -object iothread,id=3Diothread0 \
>     -blockdev driver=3Dnull-co,node-name=3Dnull0 \
>     -monitor stdio
>
> (qemu) info iothreads
> iothread0:
>   thread_id=3D4005900
>   holders=3D
>   poll-max-ns=3D32768
>   poll-grow=3D2
>   poll-shrink=3D2
>   poll-weight=3D3
>   aio-max-batch=3D0
>
> .......

This serves nicely, thanks!

[...]


