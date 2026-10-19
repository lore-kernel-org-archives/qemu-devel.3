Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2763CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIn3n-0008NO-3A; Mon, 19 Oct 2026 09:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIn3g-0008Mn-L7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIn3e-0005wl-Qz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792415141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kV7Tc7mRNwSqujjo1xPDFzUdbavaM8JaxSFB36oeQtg=;
 b=ULrvGOW0Bq/kyD7AZhkjcsaPNFPg2C37jzjh30QTXGijQrUgn7DLzELlY3stXQtVils3cH
 gpHwBJ42Wa8SGgbuHksb02aOAkNpGXYwkSz3wP6AqJrKf8RDvp3iLPe8eW6jEYxFc8LHWJ
 JImQ4JWlOTITb4+93NPWzcTPazl/3xw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-VBlEnvoDOcGZ2wnIaLwvqw-1; Mon,
 19 Oct 2026 13:05:37 +0000
X-MC-Unique: VBlEnvoDOcGZ2wnIaLwvqw-1
X-Mimecast-MFC-AGG-ID: VBlEnvoDOcGZ2wnIaLwvqw_1792415132
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 004D31954B3B; Mon, 19 Oct 2026 13:05:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF4A47E2; Mon, 19 Oct 2026 13:05:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 706FD21E6A04; Mon, 19 Oct 2026 15:05:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Alberto Garcia <berto@igalia.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>,  qemu-block@nongnu.org,
 linux-cxl@vger.kernel.org,  kvm@vger.kernel.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v5 17/62] qom: convert struct properties to QAPI-aware
 registration
In-Reply-To: <20260911-qom-qapi-v5-17-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:34:51 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-17-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 15:05:28 +0200
Message-ID: <87ik2xzvqf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Convert all callers of object_property_add() and
> object_class_property_add() that register struct-typed properties with
> QAPI visitor-based getters/setters to use object_property_add_qapi() and
> object_class_property_add_qapi() instead.
>
> This replaces the manual string type name with a reference to the
> generated QAPITypeInfo constant, enabling QMP introspection to report
> accurate QAPI type information for struct properties. Existing
> getters/setters are preserved unchanged.
>
> The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
> (not a real QAPI type) to "CXLFixedMemoryWindowOptions".
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  authz/list.c              |  2 +-
>  block/throttle-groups.c   |  5 +++--
>  chardev/char-socket.c     |  3 ++-
>  hw/core/machine.c         | 11 +++++++----
>  hw/cxl/cxl-host.c         |  4 +++-
>  hw/remote/vfio-user-obj.c |  5 +++--
>  hw/vfio-user/pci.c        |  5 +++--
>  target/i386/cpu.c         | 11 ++++++++---
>  target/i386/kvm/tdx.c     |  4 +++-
>  target/s390x/cpu-system.c |  4 +++-
>  10 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/authz/list.c b/authz/list.c
> index 363b2ee12c98..ed3d346004c2 100644
> --- a/authz/list.c
> +++ b/authz/list.c
> @@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *d=
ata)
>          .set =3D qauthz_list_prop_set_policy,
>      ));
>=20=20
> -    object_class_property_add(oc, "rules", "QAuthZListRule",
> +    object_class_property_add_qapi(oc, "rules", &QAuthZListRule_type_inf=
o,
>                                qauthz_list_prop_get_rules,
>                                qauthz_list_prop_set_rules,
>                                NULL, NULL);

docs/devel/style.rst (for what it's worth):

    In case of function, there are several variants:

    * 4 spaces indent from the beginning
    * align the secondary lines just after the opening parenthesis of the f=
irst

    For example:

    .. code-block:: c

        do_something(x, y,
            z);

        do_something(x, y,
                     z);

        do_something(x, do_another(y,
                                   z));

Thoughts?

[...]


