Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA5CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 11:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyTr7-0004QS-Tz; Tue, 16 Sep 2025 07:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyTr4-0004P6-3s
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uyTqy-0001g5-Eh
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 07:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758022062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+l0iJNAj9MI4FY1p3oxbJYsqGU7ofErcbPW1mu+rxI=;
 b=Rgh5s1smWzAIm6aIkpD+BVsymj0bc7w4XOgsakrH+GEhuQ+VYbRT4S5Rl6ImWTUYuch8cE
 xkq6I0iJcZEVgFfNHVXD2/iWR8T/lNS/Z4Ip/8jLKzUiYjZHy2kToJTaUjoekvQu9enD8m
 EF7TXPFt6Eh0Mo8gSwAHpDR6PpTr+Qw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-9esmBWDwOGiJk-JOt236tg-1; Tue,
 16 Sep 2025 07:27:40 -0400
X-MC-Unique: 9esmBWDwOGiJk-JOt236tg-1
X-Mimecast-MFC-AGG-ID: 9esmBWDwOGiJk-JOt236tg_1758022059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48422195609E; Tue, 16 Sep 2025 11:27:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1E291800451; Tue, 16 Sep 2025 11:27:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D50021E6A27; Tue, 16 Sep 2025 13:27:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 12/12] error: Kill @error_warn
In-Reply-To: <aKRfXdh-bclOVVyb@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Aug 2025 12:26:21 +0100")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
 <aKRfXdh-bclOVVyb@redhat.com>
Date: Tue, 16 Sep 2025 13:27:36 +0200
Message-ID: <87348mprh3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 08, 2025 at 10:08:23AM +0200, Markus Armbruster wrote:
>> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
>> add global &error_warn destination).  It has multiple issues:
>>=20
>> * error.h's big comment was not updated for it.
>>=20
>> * Function contracts were not updated for it.
>>=20
>> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>>   error_prepend() and such.  These crash on @error_warn, as pointed
>>   out by Akihiko Odaki.
>>=20
>> All fixable.  However, after more than two years, we had just of 15
>> uses, of which the last few patches removed eight as unclean or
>> otherwise undesirable.  I didn't look closely enough at the remaining
>> seven to decide whether they are desirable or not.
>>=20
>> I don't think this feature earns its keep.  Drop it.
>>=20
>> Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/error.h           |  6 ------
>>  hw/display/virtio-gpu.c        |  8 ++++++--
>>  hw/net/virtio-net.c            |  8 +++++++-
>>  tests/unit/test-error-report.c | 17 -----------------
>>  ui/gtk.c                       |  6 +++++-
>>  util/error.c                   |  5 +----
>>  6 files changed, 19 insertions(+), 31 deletions(-)
>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 6b5b5dace3..7848e26278 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -1289,6 +1289,8 @@ exit:
>>=20=20
>>  static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
>>  {
>> +    Error *err =3D NULL;
>> +
>>      if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
>>          return true;
>>      }
>> @@ -1306,7 +1308,11 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Er=
ror **errp)
>>          return virtio_net_load_ebpf_fds(n, errp);
>>      }
>>=20=20
>> -    ebpf_rss_load(&n->ebpf_rss, &error_warn);
>> +    ebpf_rss_load(&n->ebpf_rss, &err);
>> +    /* Beware, ebpf_rss_load() can return false with @err unset */
>
> Per our other mail, this is a bug we should fix

Yes, but I still don't know how to fix it.  The remaining open question
is "Is it a programming error when it happens?" in
Message-ID: <87sehfsife.fsf@pond.sub.org>

Help!

>> +    if (err) {
>> +        warn_report_err(err);
>> +    }
>>      return true;
>>  }
>>=20=20
>
> With regards,
> Daniel


