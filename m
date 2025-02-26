Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F74AC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIVg-0002Yu-LG; Wed, 26 Feb 2025 09:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tnIVM-0002UP-Rs
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:35:26 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tnIVI-0002aa-TT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:35:19 -0500
Received: from rainloop.ispras.ru (unknown [83.149.199.84])
 by mail.ispras.ru (Postfix) with ESMTPSA id 32BA640B2296;
 Wed, 26 Feb 2025 14:35:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 32BA640B2296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1740580509;
 bh=6bTZpNIiT8cXawT9uCq5F5br+4ZxEoQ9x/hDVdIF4TU=;
 h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
 b=Qe/E497IxXgnSZDVzhAMihRucFQb3R3ChiVxArsKg6gK42wH457jN6lVzUn3TsYyH
 4j1zQ1EcJACwaclJTEmOJb70o3KfA7juwrHEUCaVEPYs2syw/PwEPdXauRKd6k4+6m
 yDHezSNHf9iAJnl5aUCsBcbXMk7chNv2QqEM4q2A=
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 14:35:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From: mordan@ispras.ru
Message-ID: <fdc027c4ffee8bedc1e28d4c21ed8f8b@ispras.ru>
Subject: Re: [PATCH] Fix data race with the state Field of ThreadPoolElement
To: "Paolo Bonzini" <pbonzini@redhat.com>, "Thomas Huth"
 <thuth@redhat.com>
Cc: "Stefan Hajnoczi" <stefanha@redhat.com>,
 "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 "=?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org, "Vadim Mutilin"
 <mutilin@ispras.ru>, "Alexey Khoroshilov" <khoroshilov@ispras.ru>
In-Reply-To: <286270ed-cc59-4fe9-88c2-ad08798ed08a@redhat.com>
References: <286270ed-cc59-4fe9-88c2-ad08798ed08a@redhat.com>
 <20250219161223.3340431-1-mordan@ispras.ru>
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mordan@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello! Please take a look at the new version of the patch here: https://l=
ore.kernel.org/all/20250224161719.3831357-1-mordan@ispras.ru=0AThank you!=
=0A=0AFebruary 20, 2025 6:10 AM, "Paolo Bonzini" <pbonzini@redhat.com> wr=
ote:=0A=0A> On 2/19/25 17:12, Vitalii Mordan wrote:=0A> =0A>> diff --git =
a/util/thread-pool.c b/util/thread-pool.c=0A>> index 27eb777e85..6c5f4d08=
5b 100644=0A>> --- a/util/thread-pool.c=0A>> +++ b/util/thread-pool.c=0A>=
> @@ -111,9 +111,8 @@ static void *worker_thread(void *opaque)=0A>> ret =
=3D req->func(req->arg);=0A> =0A> req->ret =3D ret;=0A>> - /* Write ret b=
efore state. */=0A>> - smp_wmb();=0A>> - req->state =3D THREAD_DONE;=0A>>=
 + /* Atomically update state after setting ret. */=0A>> + qatomic_store_=
release(&req->state, THREAD_DONE);=0A> =0A> This is good.=0A> =0A>> @@ -1=
80,7 +179,7 @@ static void thread_pool_completion_bh(void *opaque)=0A> =
=0A> restart:=0A>> QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {=0A>=
> - if (elem->state !=3D THREAD_DONE) {=0A>> + if (qatomic_load_acquire(&=
elem->state) !=3D THREAD_DONE) {=0A> =0A> This is good, but it needs a co=
mment and it can replace the smp_rmb() below.=0A> =0A>> continue;=0A>> }=
=0A> =0A> @@ -223,12 +222,12 @@ static void thread_pool_cancel(BlockAIOCB=
 *acb)=0A>> trace_thread_pool_cancel(elem, elem->common.opaque);=0A> =0A>=
 QEMU_LOCK_GUARD(&pool->lock);=0A>> - if (elem->state =3D=3D THREAD_QUEUE=
D) {=0A>> + if (qatomic_load_acquire(&elem->state) =3D=3D THREAD_QUEUED) =
{=0A> =0A> This is not ordering anything so it can be qatomic_read/qatomi=
c_set (technically the one below=0A> doesn't even need that, but it's fin=
e).=0A> =0A>> QTAILQ_REMOVE(&pool->request_list, elem, reqs);=0A>> qemu_b=
h_schedule(pool->completion_bh);=0A> =0A> - elem->state =3D THREAD_DONE;=
=0A>> elem->ret =3D -ECANCELED;=0A>> + qatomic_store_release(&elem->state=
, THREAD_DONE);=0A>> }=0A> =0A> }=0A>> @@ -251,8 +250,8 @@ BlockAIOCB *th=
read_pool_submit_aio(ThreadPoolFunc *func, void *arg,=0A>> req =3D qemu_a=
io_get(&thread_pool_aiocb_info, NULL, cb, opaque);=0A>> req->func =3D fun=
c;=0A>> req->arg =3D arg;=0A>> - req->state =3D THREAD_QUEUED;=0A>> req->=
pool =3D pool;=0A>> + qatomic_store_release(&req->state, THREAD_QUEUED);=
=0A> =0A> This does not need any atomic access, because there is ordering=
 via pool->lock (which protects the=0A> request_list). There's no need to=
 do store-release and load-acquire except to order with another=0A> store=
 or load, and in fact adding unnecessary acquire/release is harder to und=
erstand.=0A> =0A> Paolo=0A> =0A>> QLIST_INSERT_HEAD(&pool->head, req, all=
);=0A=0A-- Vitalii Mordan=0ALinux Verification Center, ISPRAS=0Aweb: http=
://linuxtesting.org=0Ae-mail: mordan@ispras.ru

