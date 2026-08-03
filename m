Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98205C5516F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 04:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqkSi-0005bI-DK; Mon, 03 Aug 2026 00:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wqkSg-0005b7-CX
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 00:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wqkSe-0006fI-8y
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 00:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785731974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWoFBDB4ifR9wiLwgg4lAyrAWAKz5Xf67mT3dCiY4D8=;
 b=aPqPr+cYBm5+kBCjDqtF6M5qOgDfhgDFKOW+82YQIz26t/IXSgB1vfpAm3k6JvdneC7eu9
 H6hTQ2c2vaXsPTQGhpr/9ALueLG3Z4HJyhnkMcawYbIjTA2fAknRxXD/1852xLEPtzb+Vu
 Mm4Xo5WGu1pg4bz8gQqgsswflTbLDGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-paYtDns4N9KxK29Z0Ow3qQ-1; Mon,
 03 Aug 2026 00:39:31 -0400
X-MC-Unique: paYtDns4N9KxK29Z0Ow3qQ-1
X-Mimecast-MFC-AGG-ID: paYtDns4N9KxK29Z0Ow3qQ_1785731970
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0E7A1800364; Mon,  3 Aug 2026 04:39:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45BFC41C; Mon,  3 Aug 2026 04:39:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96F8521E6920; Mon, 03 Aug 2026 06:39:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RESEND PATCH V10 06/15] monitor: Update tracking iothread
 users with holder
In-Reply-To: <CAK3tnv+g_m27CEj_PRUyHVsViZv74H+dtHmxw9yjEQqSVVuN-Q@mail.gmail.com>
 (Zhang Chen's message of "Sat, 1 Aug 2026 01:10:35 +0800")
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-7-zhangckid@gmail.com>
 <87a4rkplof.fsf@pond.sub.org>
 <CAK3tnv+UMEsZTR12iY74sD42m5nNhYEtyF58QxVoG-JAeUZHcw@mail.gmail.com>
 <87cxw3aah5.fsf@pond.sub.org>
 <CAK3tnv+g_m27CEj_PRUyHVsViZv74H+dtHmxw9yjEQqSVVuN-Q@mail.gmail.com>
Date: Mon, 03 Aug 2026 06:39:26 +0200
Message-ID: <87ik5r6cn5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> On Fri, Jul 31, 2026, 3:23=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > On Tue, Jul 21, 2026 at 8:33=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
>> wrote:
>> >>
>> >> Zhang Chen <zhangckid@gmail.com> writes:
>> >>
>> >> > Based on monitor QOM path tracking iothread users with holder.
>> >> > Introduce the AioContext in the Monitor struct to avoid repeated ca=
lls to
>> >> > iothread_get_aio_context() and ensure symmetrical ref/unref during
>> >> > monitor lifecycle.
>> >> >
>> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> >>
>> >> Why are repeated calls bad?
>> >>
>> >> How would symmetry be lost?
>> >>
>> >
>> > OK, will add detailed comments like this in the next version:
>> >
>> > Avoid repeated calls: Under the holder tracking model, fetching the
>> > AioContext increments the IOThread refcount and registers holder metad=
ata.
>> > Dynamically querying it in helper functions (e.g., suspend, BH schedul=
ing)
>> > leads to redundant refcount churn.
>>
>> Right here, we still have
>>
>>     AioContext *iothread_get_aio_context(IOThread *iothread)
>>     {
>>         return iothread->ctx;
>>     }
>>
>> and complicating code to avoid additional calls feels dubious.
>>
>> PATCH 14 changes it to
>>
>>     AioContext *iothread_get_aio_context(IOThread *iothread,
>>                                          const IOThreadHolder *holder)
>>     {
>>         /* Add IOThreadHolder to the list */
>>         iothread_ref(iothread, holder);
>>
>>         return iothread->ctx;
>>      }
>>
>> Are you making this change in preparation of PATCH 14?
>>
>
>
> Yes, following Stefan's earlier suggestion allows for lifecycle management
> to be completed with minimal disruption.

The commit message is problematic, because it's written as if PATCH 14
was already applied.  Please adjust it.  Something like "A subsequent
patch will make repeated calls ... undesirable."  Same for symmetry.

[...]


