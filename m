Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB36FD59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU7Fa-0005qH-Im; Fri, 12 Dec 2025 12:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1vU7FY-0005lb-Ds
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1vU7FW-0000uG-Ly
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765561693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l8O46gGAcJOpEQfz+tnj+cpg+6hKcqczIUKZ3NUVvtg=;
 b=Hr5Tlni1FP9LO1TH9FnxuHcqRizVsgbzxouj2XqXojhE9koMuUVvCRePwE6kCviU+3BfSr
 Hf06Vqr4sKs7r39JN+KDRZp4gkxJpSxQtKgrDLElwnltc4g9/uZBXmKbRHO3ZNLePZkRZ0
 QKCd0UNpNEBQPPDkiFPlUYRJxYpKqUQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-DpnY63ZhMmqZCrpmeWRLKQ-1; Fri,
 12 Dec 2025 12:47:06 -0500
X-MC-Unique: DpnY63ZhMmqZCrpmeWRLKQ-1
X-Mimecast-MFC-AGG-ID: DpnY63ZhMmqZCrpmeWRLKQ_1765561624
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4196A1956080; Fri, 12 Dec 2025 17:47:04 +0000 (UTC)
Received: from [10.45.225.36] (unknown [10.45.225.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AF9F1956056; Fri, 12 Dec 2025 17:47:01 +0000 (UTC)
Message-ID: <f3c34e18-beda-4c69-b953-a65a20ea0be4@redhat.com>
Date: Fri, 12 Dec 2025 18:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2] Revert "nvme: Fix coroutine waking"
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
References: <20251212102522.38232-1-hreitz@redhat.com>
Content-Language: en-US, cs, cs-CZ
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; keydata=
 xsBNBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAHNK0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT7CwJUEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 AmdVmH4FCRQBT3UACgkQJrNi5H/PIsG+hAf+OKWNwpGDFoSaiHiO5xrox5gmVXCJw9DSXDDo
 5iIX70jNujVDx9ijv6pzcpkDp/Y+PVWXAiA4K1ooeMMeREh+B0ULCS37bpgDih+hzsnBS53V
 YGJFTEWp7F6qn0/joN8CgK/AGewyXLQOdZk2lGnKg8EhIcr791De6OyP8GBXpPsZYCA567ks
 ICbJCOnzdfGl85Ys4tQYQAs9NfYOJp+xtVoFXTaWgYcH74b030i9Ws7SzqzvofPnwsWBHHQZ
 2C9g4t5ZppR3OYLz/ByPJba3bNcK1dQ2Wrg4eCkg0PLlpJgNCzKrqvY8/905zQ92/Jx8Akbt
 W3c/qk5gvlaqgW7iIc7ATQRXFer7AQgAw8JIK9pZUfZWNZirBIwOevkdZu1aLhgH84EfXw40
 ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3m
 dFZMubPG1GJEuubPAAB0huRfjQTvOvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtf
 P+Z3gLCuEDkmEZSh4IKxs0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf
 /h+GfEO8gU/ICJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApv
 c9wORs/3iT9BhwARAQABwsB8BBgBCAAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmXU
 Y6UFCRKLjjUACgkQJrNi5H/PIsHBqwf8CnCF6FqTd27cgJQQloO/E+ETAevMIIpfknD3S+iH
 sqe2j75YuDcHv3n89F4xxNAj6TayKYsTrYBjBSlEfM5ksSCsdFZFaoIWgqyQc05/HRFM5A9V
 Di1ArQweej90swn7GD9JTGE5lUjBseOp0Noy4wQBDNOwk9eYdrS7QQZaBeAwUhsmMaAgKK2z
 95t9PF0bFk8Thuq4RTfkrW8vA8AaZ7UZ356W+7Xl28sWM7aQnE5z3/wU4qWmIOfHDekvtwxe
 1irKojjxnWZYIy4UPN/dQqb+Fb+i+D74k+h/3HI7G5GxeUF4YHk5YtU5cK350qotclNMZ8p7
 9Hw6aAW0t04WWA==
In-Reply-To: <20251212102522.38232-1-hreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------44rI09Eb8iicrJsgJXUJ1hUB"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ldoktor@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------44rI09Eb8iicrJsgJXUJ1hUB
Content-Type: multipart/mixed; boundary="------------mawYXirTZ08QH0t364OK7zRB";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Message-ID: <f3c34e18-beda-4c69-b953-a65a20ea0be4@redhat.com>
Subject: Re: [PATCH for-10.2] Revert "nvme: Fix coroutine waking"
References: <20251212102522.38232-1-hreitz@redhat.com>
In-Reply-To: <20251212102522.38232-1-hreitz@redhat.com>

--------------mawYXirTZ08QH0t364OK7zRB
Content-Type: multipart/mixed; boundary="------------DeTDMpn00dQjmvC548fLBwY0"

--------------DeTDMpn00dQjmvC548fLBwY0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks, tested this on the CI system and with this patch it seems to work=
 well.

Regards,
Luk=C3=A1=C5=A1

Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

Dne 12. 12. 25 v 11:25 Hanna Czenczek napsal(a):
> This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.
>=20
> Luk=C3=A1=C5=A1 Doktor reported a simple single-threaded nvme test case=
 hanging
> and bisected it to this commit.  While we are still investigating, it i=
s
> best to revert the commit for now.
>=20
> (This breaks multiqueue for nvme, but better to have single-queue
> working than neither.)
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/nvme.c | 56 +++++++++++++++++++++++++---------------------------=

>  1 file changed, 27 insertions(+), 29 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 919e14cef9..c3d3b99d1f 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -1200,36 +1200,26 @@ fail:
> =20
>  typedef struct {
>      Coroutine *co;
> -    bool skip_yield;
>      int ret;
> +    AioContext *ctx;
>  } NVMeCoData;
> =20
> +static void nvme_rw_cb_bh(void *opaque)
> +{
> +    NVMeCoData *data =3D opaque;
> +    qemu_coroutine_enter(data->co);
> +}
> +
>  /* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
>  static void nvme_rw_cb(void *opaque, int ret)
>  {
>      NVMeCoData *data =3D opaque;
> -
>      data->ret =3D ret;
> -
> -    if (data->co =3D=3D qemu_coroutine_self()) {
> -        /*
> -         * Fast path: We are inside of the request coroutine (through
> -         * nvme_submit_command, nvme_deferred_fn, nvme_process_complet=
ion).
> -         * We can set data->skip_yield here to keep the coroutine from=

> -         * yielding, and then we don't need to schedule a BH to wake i=
t.
> -         */
> -        data->skip_yield =3D true;
> -    } else {
> -        /*
> -         * Safe to call: The case where we run in the request coroutin=
e is
> -         * handled above, so we must be independent of it; and without=

> -         * skip_yield set, the coroutine will yield.
> -         * No need to release NVMeQueuePair.lock (we are called withou=
t it
> -         * held).  (Note: If we enter the coroutine here, @data will
> -         * probably be dangling once aio_co_wake() returns.)
> -         */
> -        aio_co_wake(data->co);
> +    if (!data->co) {
> +        /* The rw coroutine hasn't yielded, don't try to enter. */
> +        return;
>      }
> +    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
>  }
> =20
>  static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
> @@ -1253,7 +1243,7 @@ static coroutine_fn int nvme_co_prw_aligned(Block=
DriverState *bs,
>          .cdw12 =3D cpu_to_le32(cdw12),
>      };
>      NVMeCoData data =3D {
> -        .co =3D qemu_coroutine_self(),
> +        .ctx =3D bdrv_get_aio_context(bs),
>          .ret =3D -EINPROGRESS,
>      };
> =20
> @@ -1270,7 +1260,9 @@ static coroutine_fn int nvme_co_prw_aligned(Block=
DriverState *bs,
>          return r;
>      }
>      nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
> -    if (!data.skip_yield) {
> +
> +    data.co =3D qemu_coroutine_self();
> +    while (data.ret =3D=3D -EINPROGRESS) {
>          qemu_coroutine_yield();
>      }
> =20
> @@ -1366,7 +1358,7 @@ static coroutine_fn int nvme_co_flush(BlockDriver=
State *bs)
>          .nsid =3D cpu_to_le32(s->nsid),
>      };
>      NVMeCoData data =3D {
> -        .co =3D qemu_coroutine_self(),
> +        .ctx =3D bdrv_get_aio_context(bs),
>          .ret =3D -EINPROGRESS,
>      };
> =20
> @@ -1374,7 +1366,9 @@ static coroutine_fn int nvme_co_flush(BlockDriver=
State *bs)
>      req =3D nvme_get_free_req(ioq);
>      assert(req);
>      nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
> -    if (!data.skip_yield) {
> +
> +    data.co =3D qemu_coroutine_self();
> +    if (data.ret =3D=3D -EINPROGRESS) {
>          qemu_coroutine_yield();
>      }
> =20
> @@ -1415,7 +1409,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(Blo=
ckDriverState *bs,
>      };
> =20
>      NVMeCoData data =3D {
> -        .co =3D qemu_coroutine_self(),
> +        .ctx =3D bdrv_get_aio_context(bs),
>          .ret =3D -EINPROGRESS,
>      };
> =20
> @@ -1435,7 +1429,9 @@ static coroutine_fn int nvme_co_pwrite_zeroes(Blo=
ckDriverState *bs,
>      assert(req);
> =20
>      nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
> -    if (!data.skip_yield) {
> +
> +    data.co =3D qemu_coroutine_self();
> +    while (data.ret =3D=3D -EINPROGRESS) {
>          qemu_coroutine_yield();
>      }
> =20
> @@ -1463,7 +1459,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDri=
verState *bs,
>      };
> =20
>      NVMeCoData data =3D {
> -        .co =3D qemu_coroutine_self(),
> +        .ctx =3D bdrv_get_aio_context(bs),
>          .ret =3D -EINPROGRESS,
>      };
> =20
> @@ -1508,7 +1504,9 @@ static int coroutine_fn nvme_co_pdiscard(BlockDri=
verState *bs,
>      trace_nvme_dsm(s, offset, bytes);
> =20
>      nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
> -    if (!data.skip_yield) {
> +
> +    data.co =3D qemu_coroutine_self();
> +    while (data.ret =3D=3D -EINPROGRESS) {
>          qemu_coroutine_yield();
>      }
> =20

--------------DeTDMpn00dQjmvC548fLBwY0
Content-Type: application/pgp-keys; name="OpenPGP_0x26B362E47FCF22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0x26B362E47FCF22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
xMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEB
AQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEE
BSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2
Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOU
lZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn
6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD0oqSf8aTBzyeKkJHvTPlB6H9a6DMT
bzwaChI7UuRuz81PDL6sDSGVmi+bv+AqF4FB3knFXzsPQkVyniTxTBp7vb27LJcj
gkdE/wDr1E6igrsqMHJ2RqzSwwgl3KqOvtUf9uaTZwFjdwBjk43ivJNV1m4vZCbm
eRvRNx/yKxTO2/0+hrmdaUtjdUeXdnr8+v6Tc2RQX0e9fujdjmqlpqUIhlRbpWc9
Ar5rytZn5Klvck4AqDz5A7P5zFh021Go+VHvkVyTDCwzygBp4uMFiTyRXkWi+M7/
AE5FR5DPCoy0cnOB7HqK9H0PVLXXrNp4t8TrgMjEHHfr3rWLvoZNWKd1Mf7RuD6y
UkUoDNjr3q9LoDSSs7XZJc5GFFRjQZFfiYbCeTnB/lT9mw5kN8/KjJ5NQGUg4yav
/wBjx5wJ92PQ1C+kDccK5980vZthzo60jPam+WTyQPyqQ89ARTSoJ6ZNdZiAwByC
KQsO1LsJ6Cq1/cixsJ7hhny0LY9TSbsrjSu7GH4q8SJpVsbeFx9qcdj9weteT3V8
HZnL7nY5yT3pmu3091cytJJueRizHPU1Lovhu5vrczSSFS33cjoK86cud80mehTh
y+6jPEgJOB7lmprTKR8qM/vjiu6sPCNtF/rQZD3LVsJ4dtFAAiX8qj2iNvZM8tCs
y52H6VXkD7sbGPtzXro8OWp48sY+lMfQbNeBCg+gqlURDos8kaGdYWZEK8elb3g3
xO+kXChiXtGY+Yp5K5Hb9K7K80OB4GRYwMg9uteaTWr6VrbW8g+STgZ/SrjO+xlO
lbc980u9tNRg86zmEitzwM4/CrBhZlZYypAPG05rxjStXutBvlubdm8vjzI88Edx
XtdnKl1bRXKMpWVA6t7EV0Up82jOWpDlZCUZCytvK4G3jn8RSeTnpIQPYGtA7QPm
YH2xmmbYjzsH5YrYzJmck8EYpNwPUGl/drgGnDAB4FMBm8Y+7+tcZ8QdVNnpSW6k
qJss3Oche35/yrs+M8gD3rz34sukWl2QwpZnb5h6AD/Gs6usS6ekjy6GQ3N2pkHU
9K9S0qMR2cXQAjgV5n4ct21DVI4o1zz1r1dYkt4o0J5TvXnVtND08PrqWoyBVgOK
qwgNzuz+NWhCGHBrBXOnQkVge9RSfexThGwGAKjZZFbmrE0QXC5WuB8bWAMMd2q/
NE4z9K9Ac5HNcr4pKHT5EJ6g1VN+8YVF7pxyTB2Ct1IH417B4JuBL4UtATzFuiIz
6Hj9CK8SicNt/wBnjPtXtXgO2e28MQyNjExLj6V2Uk+Y4KrvE6TjGQxppcZ+7T9i
k5wQfbijygexrqscwrk4GDn2NCHI+4w9iKC7ZwVGPang56NxTGNcY5AOfavOfi1H
52kWJUjekrAqD1BHXH/Aa9GckcgjFeda7ZHVm1MSFj+8wmegP/6v51hXqciR04aj
7RvyOW+H9qLS6luLoMhZdsYKnJ+g69q3NZD3LsXvnhhB4GwqKv8AhzQk0jTIXkjH
myZb3AIo1DRIr2QO4JAOQCehrhlJOdzvpwcYWOOlvr21yLLVfN/2QpP610vhrWLq
ZcXMokY+lZ7aDFZXf2j5n+YsUI+UnBHT8TU+m2TQ3SKjMpPIx2H+f5VU+W2hNNS5
tTspdS8mAt0+tcte+Oha3vlywl0A69DU+tpMkSJ5zEN68HPHFchd2F5mOW3MxPO/
aM49KIRutQrScdDrIPFtleyog3JuOMsKyPGrEaasytxuxwaZZQmTyodRtcsyA+ei
lcHHINR+LrZodFjhaQmAtkPtyVPbvz3pqKUjOU24XZyWmf6RNFGgy0jBAPXmvovS
7T+ztJtbQYPlRhfxrw/4Z6R/aHiiGV+YrQGVuOpGMD8yPyr3bLr23D64rtprqcEn
ckLDupX6UnnY7/rULSFv4Gpvz/8API/pWhBY3IP4v1pN6r0IqELKf+WT/wDfNO8u
Y/8ALI49yKLjHNKmOR19q4nUQH1Q27g+S8jlsdGOTgH9K7F0kT7y4H1rndWtzHM0
mFHmHcD71y4pNxTR24GSU2n1JVPm20akA7eMfSmtE2OAcexqKCQx8E1O90kS89T2
rgPSWxSnjG3JA47nFR2kSeaHXkngmk1CZ3iyBxnkD0p2k3UEq/OpjKNjDdx61RSS
SuP1ONZJAcZ2HI9+1RR2URUPHlfUA4p+o3MEt00UbjePmwK07QxhUUgEkdK0TMZJ
PUzjaRkZIDEfnWP4i0qTUdN+zwKC5dcDPvzXXTpHg7Ris1sEyMeAi5H+92ovZ3In
FNWHeFNMGlzfZogCI4cPgD5iSDXUnGeNymqOkqGSWfAy5UE59v8A69aDEkgFcj1F
d1D4bs83Etc9kIMimEyZ4YYp64J4J+hpdorY5yysoI4HFBc+n61nrMM5jyD3U9Kn
E7egrG7NdCxyARt4PrVK7tY3gc7FKgElW5FTiZvQVDdTN9llHy4KkcUO9gW5x4cn
HbtVO/uVs2WSV9u47QT0qdm2Tbf7rVLfwRXdo0EqBkccgivL6ntLYorcwzLgTKfx
pRYRs+8SH8KzrbSbey/deWSgPBHVf8a2ItJs5Chj1Xy8oSwf+E+mDWiSNJQSV2yQ
RxwsCQCR0NI88jDdHw4ORnvWXdLNCh2XaO4UEKuCT+R9qk0eDVJYxNfNGuD8qIOT
VNdTJqxuR3v2i1WTG0nqD2PekijaROzBm6e9IkG6RYI+rP8AqTXSLBGjBkt1DAY3
YGaqlT5zmq11Bi2cElvbJHxnqc+pqYsw+8MD2FCu2cMAPxp+GYfwj6V3pJKx5snd
3ZGfmA+am/MOjE1L5Pv+Qo8r3amIpna/zDIPrinK7BeRUasMc9KyfEHiSy8P2Rlu
G3ysP3cK/ec/0HvWdyh3iXxRa+GtO+1XOHd+I4Q2Gc/4epqCy1HVbrQrW71OGO2f
UHLw26g5SIDOWJ7nj04+tcF4WR/HfxChk1b95BCpm8n+HCnhcemSPrXrfi+2Il06
cfcj8yMj3YKR/wCgmsqrfIzehFOauchccXAJ6NVlgWiUjriql38xJB6VLZXQZPLY
/NXnI9Nsa8RY5xyKbHIGbYyBv95Qa0BtDDpzUqxRbt20Z9cVvEfO1szPWzTdkj8A
MCruRFFk9egp+Vz25qrdTLJII16Dr7UO7MpTb3NPSIW5uzjPKoD6dzW2sgYH1Hb0
qK0iENpDHwCEGamG0nqOK76cVGNjyqknKTYjOp6g/lTQWU/u8496kIU+1RGRCThh
n61ZBMJJCOVH50n709NlRCQjqCRTjKM9D+VMDzXUvihb24aLS7YyHs8/AH0A5I/K
vNtU1W51a8e6vJ2klfqSOg9B6Cs9GJyetG4f3RWVirne/CK5WHx1HGT/AK+CRB9Q
A3/spr3nWrM32kyxqMyKN6D3Hb8eR+NfMPhXUhpPijTr48CKdSxz/CeG/QmvqtSH
iBBzxkGhx5lY0pytqeUzJ8meaoSKVbchwwrsPEukNbym7hX9xIfmA/gb/A1y0keO
MV58oOLsehGakrkaamVbD/KasjVEAyziqv2dZPvDOKs2+lxH5tqgD2ppiYfa5Lni
Jcf7Rpmol9P0e6uIwWkjiZ/yHWr0cShwF6CpNXgCeC9fvJB8otGiQn1OP/rfnWkI
80kjKc+WNzhtN+J+pWZRNQRbuEcFh8j/AJ9DXpOg+KNE1+JTa3I809YJW2uD9M8/
hXzznK/41ErvDJkEiuxaHAfVAjjXovI74pDAjoNwx6EcYrwbRPH+taSERLn7RAP+
WVx84/A9R+dek6H8RNJ1YKt3L9huMY2yfcP0b/HFUpCOrdZIjjG9PUdR/jTftcXc
rn605WE8SyQzh0PKupDA0xlfPzQox9c0wPmGPoTnHNO+b1J/Wmx4KdD1PSlIGeo/
GoGOUkHoPyr6f8B6wNa8I6fcE5kWIRSc/wAS/Kfzxn8a+XxuHf8AI17F8EtaAe+0
mVuuLiLJ/Bv/AGX9aqIXsexSwpIrJIgaNxhlIyCK4fXfDzadJ5sYL2jHhu6H0P8A
jXoAwwpPLSWNoJlDowwQwyCPSpnBTVmaQqOLPI2gKHevarO4zKAmVHet3W9Ck0xz
LErSWjHqOSh9D7e9Zdtp9/f3P2Wzt2U/xzSKVVB/U+1cns5J2OpVE1cSyt3uLpLW
3UPM/wCSjuT7VP8AE1U0z4ZXsEROGMUYbu2ZFJP44rstI0K30a2McZLzPzLMw+Zv
8B7V5r8cdUMejWOmxn/XTb3+ijj9T+lddKnyq73OWpU5noeHqTjj9Ka4yPenc9M8
UcD3oMiNGxxVqOTGOaqfxZ7VKnHFMDf0jxJqmjMTZXckSk/NHnKH/gJ4rq4/ipqq
xqJLS0dgOW+YZ/DNedq+OfzqQHigCqv+oSk70UUhh/jXcfCliPHVmASAUlB56/JR
RVR3EfSEXapz1WiimyjF8USOh0wI7KGuecHGeDRfzSxaloqxyOiyXJVwrEBhsJwf
WiikxI3Zf4vpXgvxs/4/NN/7af0ooq1sJnk4+7TX+6fpRRWYCfwipF+9RRQA9fu1
Mo+UUUUgP//ZwsCUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAFiEE
pApMRcQDTeAqWtSDJrNi5H/PIsEFAmAzSoUFCQzmojUACgkQJrNi5H/PIsG7OAf/
a8JJoqnvKz5Cfuvoa/Otzgk96aB7bcvcbJ0S84k2okAffcIWIs71oMpw5z3mplBJ
JAcrTX0c0A90ySXu6epuzzZm9/5hsBEAf1wk8s/HHF8YlH0NskwpGACQHvN4VqcP
U9NKG/0VQ7+JXmFYkLHct9QBz1I765PeiXadT/5G+E//p33Seaz+zJsSRem9nD6T
iL7vyc2nz0seKLQWeArBMCk14ijaxzrccma9GA1aK2ygQvSXhmAugbD+IzmVEy2n
0GojX4JuQFi1vIorFr473A2zvVP01a2O4+9LmmPIkkv8sLkwTumzvqc0/ElVND1U
c2/jHirhAXajmf7/eJgR1MLAfQQTAQgAJwUCVxXuFAIbAwUJA8JnAAULCQgHAgYV
CAkKCwIEFgIDAQIeAQIXgAAKCRAms2Lkf88iwaXbB/9mpfXcEYVMiIVwVtkZLNeY
7MouMlh47gvRp4bsxCipxIypR8qiPA+mRiwZ4PSL69HJ1XPX6WaqOzpcXYN+Lsu3
8xCyJnVY/EnK7HiekGZneg/2BGl6LEBMdL6k0TI+B6W1MJNCQSWXERIZD0a1qxLR
o1BCIy41B3U72ytnE+/UTqbfTpmsRorZFtRwOa9DtYfwkKtZIuODD6QabIy5cU+z
BqE+geye2kArxUAKKvI7ZZMQRxFQveDeGEWOB+06BFiaZuibf8Dw2EGr0JQ9/UXn
kKelw81eBhlias6Ow9wRMNTXRuudE+L4U7kZrfxift0aeI7fJJUvjIlSNuZYU2E0
wsCUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAFiEEpApMRcQDTeAq
WtSDJrNi5H/PIsEFAlqVjq4FCQdCCrIACgkQJrNi5H/PIsHeBwgAj09DCeVOn5km
NyUaneG6kguilTU5ryMBnF60CpNzWaac4SpsHh7D/ZN3cgSQKIalDf6sptHSug4a
eZhCE0p2kuSkRkxh5kIvql1me2dFE+3T3ZwojnqOloChfq5pErBGOkX5qF/rDRRo
LUGCckEnOmjbgiUebAJYXXlgGEREzeBoWYgEpmkPJg/byagMKtqDUXWnVLBS0brH
Opqh839bdRLmtZ+vi6Q2Qhy9RYPqM9VvFO1sEeO1844go6n+19nMLvUBS/KSGjmV
OZc7+FKomk8xLig9IHoYdQRpMVboJZNak2C0NIaAHy3IDscJ9QwfWKYPEgQAt9cW
BSByFZW0bMLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgBYhBKQK
TEXEA03gKlrUgyazYuR/zyLBBQJeHGosBQkLBW61AAoJECazYuR/zyLBCzQIAJ4f
SEPsm84jrb4WjXjMHc3KZcA2mf/DcBcxTvcwy4BMUrKe4/XUCallR0LAZ9eARc90
RHH2yDnt/HHdI1+QWvct3hFHbB2sYci2o9Ua/U4yLYhV+aZwauMo8I5T+F4Zx2CO
FxcBrZ5+mCEXV19EhUBwJaYzdI4iwUeZXnlXpMlUzjKoCgi5YQP412ivJJ6+Mg4J
jJXTwX16mUTcNqGOM+5naB4JBDj+Hc92PLVJ/1f6yPHNQPUEiTlljUB14JWXj9h1
gaRk+b/uvPFVQJYM3iIxXUTN6QsegCGbUUuF/424YuEl1JfUM3kMMxGN1S/ci3vG
MQtxWSEo6dq7yjVpxZTCwJQEEwEIAD4CGwMFCwkIBwIGFQgJCgsCBBYCAwECHgEC
F4AWIQSkCkxFxANN4Cpa1IMms2Lkf88iwQUCZ1WYfgUJFAFPdQAKCRAms2Lkf88i
weqRB/9gHMUvjIEGKQYIXFQfSp+NAeUsProgvsHg5FmHnDhl0opmlZGVi5KAJuCr
720xYGD5xgnuSFGwhUWjb7UHNDweXbGfWZptRzA26Ri1veI4/ruTnuV9Uy88zSml
y93Ar77xggYDmAanvet0n3b3i26YRaZXjQ468kY+fmMo+WkRVt+LMj7xg3AVOM2s
XQ14Rm5v6Gu7CaERKCYkCvkTBw39t1YzDyzRsdq7rF3LGTuH9M8LTPC9SJSnSYpB
Zv/5vmKkBayTUVpPxh7qGxbthvKhWZlwCwp40Y7VuzEOIO9DY30Uj8on7UkK7r8Q
/oecCd75ItE3ZT2h5+Aq5wZtEkepwsCUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
AgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmITS8wFCQ7H1bUACgkQ
JrNi5H/PIsHj1wgAszZlFUnZjMXz/pjecLBQLAukPW2eYpptJc1nVBGQdXRwQJWn
tLEfgQXqQKJxcktGSOpMfRKsOZBjNWQpo27wdVn8w6lPt7juyMi+ITr86gAqHzQ5
ippzO6XoMjfCX/UkJYDFjWy41DHxIVqHtsOpwK+92ZDGwzdXlBz6wmgy+aM9xPEt
gUmnLzFnp3csVQx6KRQZ7z/y+HdjfSDxgK+87xNaRrM5f9Aupi7k9L4H19xxu0cH
CbchAgV5q3errJWmhSlc0KlWNpAxF5AuYtT6Fl3iLjacVL6AUAvser6Lvu/apFJ1
evamfTAXUSZmfY8fgw6Coi+x3Ni2mBFPS3r+Mc7ATQRXFer7AQgAw8JIK9pZUfZW
NZirBIwOevkdZu1aLhgH84EfXw40ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+
rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3mdFZMubPG1GJEuubPAAB0huRfjQTv
OvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtfP+Z3gLCuEDkmEZSh4IKx
s0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf/h+GfEO8gU/I
CJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApvc9wO
Rs/3iT9BhwARAQABwsB8BBgBCAAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
AmAzSo0FCQzmojUACgkQJrNi5H/PIsFS9Qf/WZ31JQQnQQSbmtm7IOAHYC7kvlQy
8mejWlgeDrPWh3zQIXxiarBpAnYGsHNVOWJ+sjdELYc9bvOcGwXSRRxURArOYfkU
Ok4KmNmqd6eIrOvnFfapLh0xRNx+9y0gYqB9TH/JaCLMPnH+jRGM0ZisNEHyXhem
EXlXPy4vniEvajr4VnvFzD6gExzDjUqIel42BOOyHuXjZQDMEWf2eULSTGHTWXGd
V2XErdS1v4YI/DGvQQPB29UHmb2RsZhKtntq0yoxFD60HzSHlVeiLmG/hAHLDY3d
Bs/GW3RJAbOVttS31llstDtdMEHLn+P81M4dVYzt5mEENPy43Lf+YxM9FcLAfAQY
AQgAJgIbDBYhBKQKTEXEA03gKlrUgyazYuR/zyLBBQJj8yFqBQkQqlq1AAoJECaz
YuR/zyLBbsQH/39OVyF4/gnHn5i2szESfIhk0pQgQ4Vo6kGxi1LQrMTTv+WnaduB
abF2HFtsDQ8p27vdeCIR30cckQITDpNmArumkbXLrp7zYZWMs59t16D+ptCDIrla
Tc8nlrWpT1UQj8t9hXxtwktCRDsXdHy7jSaM4lXcZQC2SroCukjtyfm873uuuypd
plMMfZl6z9+2O/cvFJZDSI1SE6bZLWARQLEzCJf2/rMBsAhMuJMMamafxzKa0IzH
Yc+RwWIseHkWpudJ4QH49a+gEoBkCimKbY0lP8kvV/vEoLe0qvRp146uKwhAN8Hd
jonCs5BU8Ki3/YQ54upjbOpp57suIaefT6LCwHwEGAECACYCGwwWIQSkCkxFxANN
4Cpa1IMms2Lkf88iwQUCWpWPewUJB0ILgAAKCRAms2Lkf88iwb4kB/96ayU8IBbi
CafcSnU43RXTE8bEU5Rsfab5/Tv2lU8mjd0ZPpkUXyrTQYSyrGOnE79zSimxMWsA
3erJNLcqvjjfm5rronl4/5MGSM36+WOZGLdP1eCH90enQmRlAK1yeY2yb/0XT8bM
y9zsKeym0OnhpPQoYx+m+/tetA6SmtKvbCBZ4B01WEI/ZlDL7IDMuYd7k4Y9bWo+
YgEG8SdTYLxq/Q40YojEgBQIXxQKb5gnM/AjAkuGTOuEA2Ko3BBfB+ePwdoSw4Ih
fbpLgZhiYhpjX4YF4eR6HRH8bMRFE+HqN+GDYmIITp+2Bn4MpGOwrejW7DjRph6z
+r2PAuWRqqtpwsB8BBgBCAAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmXU
Y6UFCRKLjjUACgkQJrNi5H/PIsHBqwf8CnCF6FqTd27cgJQQloO/E+ETAevMIIpf
knD3S+iHsqe2j75YuDcHv3n89F4xxNAj6TayKYsTrYBjBSlEfM5ksSCsdFZFaoIW
gqyQc05/HRFM5A9VDi1ArQweej90swn7GD9JTGE5lUjBseOp0Noy4wQBDNOwk9eY
drS7QQZaBeAwUhsmMaAgKK2z95t9PF0bFk8Thuq4RTfkrW8vA8AaZ7UZ356W+7Xl
28sWM7aQnE5z3/wU4qWmIOfHDekvtwxe1irKojjxnWZYIy4UPN/dQqb+Fb+i+D74
k+h/3HI7G5GxeUF4YHk5YtU5cK350qotclNMZ8p79Hw6aAW0t04WWMLAfAQYAQgA
JgIbDBYhBKQKTEXEA03gKlrUgyazYuR/zyLBBQJiE0vTBQkOx9W1AAoJECazYuR/
zyLBSqIH/3iPiKB5TIhBUz4qCNfgCBt6hebZ37W4vJw1m3y1PcklYj9+m0RJ/xxf
CcVeHqgnbKTwkYzthr7NpI1fN3V3LBFnTmDVpuQj8ZO3BMSWwqHvlXF8p6lFDxdp
i93rHhaOOgZvXwtqn9d/xHTO8kJj+R4MOTkjT2rTQSoN13E81SRg73UJ4Iu7YW1P
kmKnmsYltjF6X5fAhWgQdg+6lEF8uwv4AorvgL+vfb5UlOkkFGwnZGKVAydjou0w
zo+3IrOYQDYIgJ9Mx5PJmFqKhhSpYCgx50cRogWlAzCHMYtYeoBzBFEcnpG4wRZQ
5GLbdA0J17EfZN0CBcbK4L1n/kc085PCwHwEGAEIACYCGwwWIQSkCkxFxANN4Cpa
1IMms2Lkf88iwQUCXhxqTwUJCwVutQAKCRAms2Lkf88iwdfeCACyrlND9Kk27opt
Bo2LMBJmoJAOJTl4o8YvWkrGFzK5NxWCpaRJCOCfQanACRDW3oEyd4CdLF4GXWsG
hIgGymP2+/McpZXJdFwgHNQWtyZ8GHJW/TXrGphJ9FLskb2xh83RrLYy29eF+GeZ
cVLsGP1ZCLz3I6byhbEfklqKymB1q4bQl2cEijm/VK25cYpTtNa0SZiNCmfGqfQ6
0BtDHCjZm1x9GO+67pJmL2FuO0Tq2TtT+SgU1ZKbSYdPWPk2ZetD8RRkaPlrVRVG
gW1w1/pCS29BHWaazjkmAVHE2Idh6O+7usA/G1Q3OEjWmJpmfwyKHI/rMv/fzMoM
rrqg5DNHwsB8BBgBAgAPBQJXFer7AhsMBQkDwmcAACEJECazYuR/zyLBFiEEpApM
RcQDTeAqWtSDJrNi5H/PIsEsoAf8COiAuQClMfxDivUqsGRlGd1zyeDgrkuKQ/v9
rkaYC2aYK42DY+O48qG5CRfh3nA6PqTjnZtHs6masxlQ5whmgRhN9TT3KJ4yo03P
xYraU5tQfDxZGn388ooVQqixOtNN9yjmwEeBQobBmvGsD4QShZ2cwrloRLne5S2z
5yUOhZA4gE1/qxG6/HHc71zfWTIYIBc+wpRRte7h6PvhduMYnvQDwloSo2kDnsd4
lzxYsz7ZJ8HXJhkm2pTyOMuYXFXKBDohYqBHhI2LWSQWD7gTbS4OUjr1VWBXovi7
60U/3U2K02lynYr7/iMaEkdR0sUPOyeth+bDwDbcAOCCCcddMQ=3D=3D
=3DXkFe
-----END PGP PUBLIC KEY BLOCK-----

--------------DeTDMpn00dQjmvC548fLBwY0--

--------------mawYXirTZ08QH0t364OK7zRB--

--------------44rI09Eb8iicrJsgJXUJ1hUB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmk8VRMFAwAAAAAACgkQJrNi5H/PIsEK
TAgAp84xAq8sgnyHS0bjgl8SNHLDpRWhENjOnlkgdf2Iqn/wGVoQFy96KjFSJeBVtYbmwXpYZCHW
LrYItks82s13vCWMbwSvaCGRTnIh4xlH9n66n/xkILgHXkJ2WKDTzl2fNg4zQLeyvCnl0HYptMdP
BetK7Ab99yBs+XFxYpBMqWVOiGGETXGUT1AXaLcUpbqxkjPRKwzoE3f36rtXcM8OPgSEjC0HEpcc
+DTql4TZiZ9oPZy3SXxAu+OYteVI4GR49OY5wBj8UxwsSvCfy0lR7+boIxILE6eKddtRY8uqJJgb
ZRrh8C3mjaWEegfl8bZpE8aGsDFaCohdh4eUStHMPQ==
=dFjx
-----END PGP SIGNATURE-----

--------------44rI09Eb8iicrJsgJXUJ1hUB--


