Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB82BCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0c4u-0002E5-Og; Mon, 22 Sep 2025 04:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0c4s-0002Ae-8e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0c4j-0005kj-G0
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758530348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+j//qdN/pDyeeiFh3NPAEpF9l0HZJY+JBpuz6+RrFbc=;
 b=FancVqb/OI5fW8gPYZRGYc16pFvD07VJ7R1g12e8zdAIp7HoexNOSvUaen27wLZMW42zt0
 jyT22Msv04t1XpmFL+cV94OncMNzGDXJ00lsQbvGwJFcjBG/NcKdEhH347OJWYZzyNb6+v
 CWZ9Rc26CyqhIo+88fUUjiLjZyuEvgQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-5Pq2BEtcMteAbapDIiK0xg-1; Mon,
 22 Sep 2025 04:39:04 -0400
X-MC-Unique: 5Pq2BEtcMteAbapDIiK0xg-1
X-Mimecast-MFC-AGG-ID: 5Pq2BEtcMteAbapDIiK0xg_1758530343
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E82FC195608B; Mon, 22 Sep 2025 08:39:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 087571956056; Mon, 22 Sep 2025 08:39:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BA5821E6A27; Mon, 22 Sep 2025 10:38:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
In-Reply-To: <aM6WB4c1sMtfqM9p@gallifrey> (David Alan Gilbert's message of
 "Sat, 20 Sep 2025 11:54:47 +0000")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-13-berrange@redhat.com>
 <87zfaqwr2a.fsf@pond.sub.org> <aM1aq1HNV7qJdrqI@redhat.com>
 <87ldm9txg0.fsf@pond.sub.org> <aM6WB4c1sMtfqM9p@gallifrey>
Date: Mon, 22 Sep 2025 10:38:59 +0200
Message-ID: <87plbinaos.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Sep 19, 2025 at 02:43:41PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > A number of callers use monitor_cur() followed by !monitor_cur_is_q=
mp().
>> >>=20
>> >> "A number of"?  I can see just one:
>> >>=20
>> >>     int error_vprintf(const char *fmt, va_list ap)
>> >>     {
>> >>         Monitor *cur_mon =3D monitor_cur();
>> >>=20
>> >>         if (cur_mon && !monitor_cur_is_qmp()) {
>> >>             return monitor_vprintf(cur_mon, fmt, ap);
>> >>         }
>> >>         return vfprintf(stderr, fmt, ap);
>> >>     }
>> >
>> > Opps, that'll be referring to the other use of monitor_cur() in my
>> > patches that I then removed when I re-ordered the series.
>> >
>> >>=20
>> >> > This is undesirable because monitor_cur_is_qmp() will itself call
>> >> > monitor_cur() again, and monitor_cur() must acquire locks and do
>> >> > hash table lookups. Introducing a monitor_cur_hmp() helper will
>> >> > combine the two operations into one reducing cost.
>>=20
>> I think the actual interface flaw is having monitor_cur_is_qmp().
>>=20
>> In master, monitor_cur_is_qmp() is only used in monitor/monitor.c.  Both
>> call sites have the value of monitor_cur() available as @cur_mon.
>> They'd be better off calling monitor_is_qmp(cur_mon).
>>=20
>> Note that in master nothing outside monitor/ cares whether a monitor is
>> QMP or HMP.  I like that.
>>=20
>> Your series doesn't preserve this property.
>>=20
>> You move the first call site error_vprintf() from monitor/monitor.c to
>> util/error-report.c in PATCH 11.  QMP vs. HMP is no longer encapsulated.
>> Slighly irksome.
>
> How about a slightly simpler approach, looking above we have:
>
>> >>         if (cur_mon && !monitor_cur_is_qmp()) {
>> >>             return monitor_vprintf(cur_mon, fmt, ap);
>> >>         }
>> >>         return vfprintf(stderr, fmt, ap);
>
> I think we could replace this with:
>
>   ret =3D monitor_vprintf(cur_mon, fmt, ap);
>   if (ret =3D=3D -1) {
>        ret =3D vfprintf(stderr, fmt, ap);
>   }
>   return ret;
>
> monitor_vprintf already -1 exits if !mon or monitor_is_qmp(mon)
>
> Keeps the encapsulation, and is now 'print via the monitor but if it
> can't do it, use printf'

monitor_printf() fails when passed a null monitor[*] or a QMP monitor.
Reporting the error to stderr then is probably better than swallowing
it.  Same if the function somehow picks up more failure modes.

I like it.

One could perhaps object that it makes "report to HMP or else stderr"
less obvious if you don't already know that monitor_vprintf() only
prints to HMP.  I'm okay with that.



[*] Feels more like a programming error, but we can ignore this
distraction.


