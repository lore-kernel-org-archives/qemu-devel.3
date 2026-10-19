Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C7CCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIiRX-0003Ti-5U; Mon, 19 Oct 2026 04:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIiRS-0003QS-Qh
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIiRO-0004M9-S5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792397394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=QR4Fe1akNxf1xqZnvaTBSKxJjfJCMULKI08OMFQlOLg=;
 b=HCcMGm7jLXzuhnN26Vly3fIJzMujNJYVdOnliewK3YW1LWkA6NXJeSIxLbAKcJk2nAgJup
 dBCY4bvdcZ49GT3ooZIf05Wj8cBQvUqJLm6X3RswvSWbzsIWtP7u6tqeZmPOAIiX1R9vtL
 jw3Ig/xBto4qpBdRpJ+j4f7QJITlSdg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-zV76_5wBO4i8uEPk00E6Bg-1; Mon,
 19 Oct 2026 08:09:51 +0000
X-MC-Unique: zV76_5wBO4i8uEPk00E6Bg-1
X-Mimecast-MFC-AGG-ID: zV76_5wBO4i8uEPk00E6Bg_1792397389
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7420118001E1; Mon, 19 Oct 2026 08:09:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C7791800642; Mon, 19 Oct 2026 08:09:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D191621E6A04; Mon, 19 Oct 2026 10:09:46 +0200 (CEST)
Resent-To: michael.roth@amd.com, jic23@kernel.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, linux-cxl@vger.kernel.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 19 Oct 2026 10:09:46 +0200
Resent-Message-ID: <87qzhm1585.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  Jonathan Cameron <jic23@kernel.org>,
 qemu-arm@nongnu.org,  linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 45/62] include: add QEMU_REPEAT helper macro
In-Reply-To: <20260911-qom-qapi-v5-45-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:35:19 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-45-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 09:45:32 +0200
Message-ID: <87fqy22kwz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Introduce a macro used in following commit, and convert a few existing
> candidates. Inspired by a similar macro in Linux kernel/trace/bpf_trace.c
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 7e6819f670b5..84c3ff05cfb8 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -496,22 +496,11 @@ static size_t vfu_object_bar_rw(PCIDevice *pci_dev,=
 int pci_bar,
>                                   buf, count, is_write);                 =
       \
>      }                                                                   =
       \
>=20=20
> -VFU_OBJECT_BAR_HANDLER(0)
> -VFU_OBJECT_BAR_HANDLER(1)
> -VFU_OBJECT_BAR_HANDLER(2)
> -VFU_OBJECT_BAR_HANDLER(3)
> -VFU_OBJECT_BAR_HANDLER(4)
> -VFU_OBJECT_BAR_HANDLER(5)
> -VFU_OBJECT_BAR_HANDLER(6)
> +QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER)
>=20=20
> +#define VFU_OBJECT_BAR_HANDLER_PTR(BAR_NO) vfu_object_bar##BAR_NO##_hand=
ler,

scripts/checkpatch.pl

    ERROR: Macros with complex values should be enclosed in parenthesis

False positive, I guess.  Can't see offhand how to avoid it.

>  static vfu_region_access_cb_t *vfu_object_bar_handlers[PCI_NUM_REGIONS] =
=3D {
> -    &vfu_object_bar0_handler,
> -    &vfu_object_bar1_handler,
> -    &vfu_object_bar2_handler,
> -    &vfu_object_bar3_handler,
> -    &vfu_object_bar4_handler,
> -    &vfu_object_bar5_handler,
> -    &vfu_object_bar6_handler,
> +    QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER_PTR)
>  };
>=20=20
>  /**

[...]


