Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C53CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 05:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYzWE-00012u-U4; Mon, 15 Jun 2026 01:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wYzW8-00011p-6E
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 01:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wYzW5-0007PN-Ek
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 01:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781499942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=749GgfGdWUW3/Slipb2aZKAGcNVdpwppsIML4sFDkeI=;
 b=Ploz+FB8VEGbNhzmkfV7bIm0m83hdh5kBecgFjLWzt7rvBXEY7zHuX7y7k0rH7WdIg5lR/
 0Bk/fjxajdVnfepQf0hYaPfU3LKlcsl94jL4Dpw8EhGS1WW+mKSg212mMIwfT5PNxqUeNg
 a8M6tahLXKWAAIaOzyeTab/to4S8WwM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-25T9ibBwOyeRJ2FdxCSBhg-1; Mon,
 15 Jun 2026 01:05:36 -0400
X-MC-Unique: 25T9ibBwOyeRJ2FdxCSBhg-1
X-Mimecast-MFC-AGG-ID: 25T9ibBwOyeRJ2FdxCSBhg_1781499935
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5670418007F2; Mon, 15 Jun 2026 05:05:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD05636918; Mon, 15 Jun 2026 05:05:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6360721E6A01; Mon, 15 Jun 2026 07:05:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Anthony PERARD <anthony@xenproject.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 2/2] qom/object: Remove pre-C11 check
In-Reply-To: <20260613175151.1357-3-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 13 Jun 2026 19:51:51
 +0200")
References: <20260613175151.1357-1-philmd@oss.qualcomm.com>
 <20260613175151.1357-3-philmd@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 07:05:32 +0200
Message-ID: <87h5n4tmub.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> We mandate a compiler supporting C11 since 2021-06-15 in
> commit d22797ce36a ("configure: Use -std=3Dgnu11"), thus the
> max_align_t type definition exists. Remove what is now dead
> code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

> ---
>  qom/object.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 0ac201de4c1..f79b2cf3618 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -675,18 +675,6 @@ static void object_finalize(void *data)
>      }
>  }
>=20=20
> -/* Find the minimum alignment guaranteed by the system malloc. */
> -#if __STDC_VERSION__ >=3D 201112L
> -typedef max_align_t qemu_max_align_t;
> -#else
> -typedef union {
> -    long l;
> -    void *p;
> -    double d;
> -    long double ld;
> -} qemu_max_align_t;
> -#endif
> -
>  static Object *object_new_with_type(Type type)
>  {
>      Object *obj;
> @@ -703,7 +691,7 @@ static Object *object_new_with_type(Type type)
>       * Do not use qemu_memalign unless required.  Depending on the
>       * implementation, extra alignment implies extra overhead.
>       */
> -    if (likely(align <=3D __alignof__(qemu_max_align_t))) {
> +    if (likely(align <=3D __alignof__(max_align_t))) {
>          obj =3D g_malloc(size);
>          obj_free =3D g_free;
>      } else {
           obj =3D qemu_memalign(align, size);
           obj_free =3D qemu_vfree;
       }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Context leads me to qemu_try_memalign() via qemu_memalign():

   #elif defined(CONFIG_ALIGNED_MALLOC)
       ptr =3D _aligned_malloc(size, alignment);
   #elif defined(CONFIG_VALLOC)
       ptr =3D valloc(size);
   #elif defined(CONFIG_MEMALIGN)
       ptr =3D memalign(alignment, size);
   #else
       #error No function to allocate aligned memory available
   #endif

C11 provides aligned_alloc().


