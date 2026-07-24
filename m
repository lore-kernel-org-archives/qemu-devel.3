Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E9BC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCBT-0004Je-Ep; Fri, 24 Jul 2026 05:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wnCBS-0004H0-I7; Fri, 24 Jul 2026 05:27:10 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wnCBQ-00027i-Sq; Fri, 24 Jul 2026 05:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/sRfksuQhCqD1jfcM40GEYbB8OW9IMnxIrjX3iypYgs=; b=X9iecXxjHpM8H5KbD8RbO+wWzU
 eUmMWrLzkf7t+2u4JVqGV/Qgnfp28M1TEEjGbCrAfPMoBDpOHPO1cItg6ByqTHz+me2T8xsE6E2wW
 t2EK99/dm1l5vw6vsjUqkgzA24XPvZVwTjJ4MBEopA6PaNnXDVRibyvojo84a62g93NLW+w9dQG6q
 sONuSAiFQnLMrPAew7VcE0rmQKzWz0i8/5pHkuQaDJoa2k1W379Mm/HLX44bzq0rH6G1PckAeJYvo
 5uN2PXj/m8a6E2rCJhpdTzmNID1KSyDl6lpySgRFaD/GBRbz8+IGMUi11x7sGjVx1v2hi627PkgIq
 3+vLvkfh79spP0VCFLwnGvzW9beP2ZrwNnurweKsvnEO+ox+SmGWimfPVcVN/Klo+WFrXOeZdW+tn
 SPm4R/q9MWSdJu3cFi4/i7u4xa+xhNHl7BZ7hF6mGu0Ez6bAfp9Y1bdNFx3/ZGWsADzzO84cXSPoi
 9dplDzhMdza1nmxhDBXKZX8kzZFFmAgdm4tIlqBWCvxZX/vM+Qmqp/SJlFRMWzE6Dzh90bqYAColO
 nEBT3CmFz9t8C5iCRB6d6X0v1Wk3p3yXWIUNu7Ert9FQ7gJrSg+3fKnhYgaE6RayhYsoJlY3Pmt85
 GLyGIPLrbGSxz2xQiRflrvJgcEFRjIfhjtMtdmX6o=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH v3 1/2] hw/9pfs/virtio: drain in-flight PDUs before
 virtio-9p unrealize
Date: Fri, 24 Jul 2026 11:26:50 +0200
Message-ID: <5687443.Sb9uPGUboI@weasel>
In-Reply-To: <e661a5e9-cead-4537-9496-8948eaecd5d8@oss.qualcomm.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
 <bc503aefffd20b1806941b3ef708afbd92f0aef2.1784809978.git.qemu_oss@crudebyte.com>
 <e661a5e9-cead-4537-9496-8948eaecd5d8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 24 July 2026 09:45:39 CEST Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Christian,
>=20
> On 23/7/26 14:43, Christian Schoenebeck wrote:
> > From: Jia Jia <physicalmtea@gmail.com>
> >=20
> > A guest can trigger a heap-use-after-free in the virtio transport
> > unrealize path by submitting a Treaddir request and immediately
> > ejecting the device via ACPI PCI hotplug. The unrealize path frees
> > struct LocalData while a worker thread still holds a reference
> > on it, causing a UAF in local_open_nofollow().
> >=20
> > Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()
> > before final server cleanup. This ensures all coroutines completed,
> > all FIDs are closed, and no worker thread still holds references
> > on 9p server state when it is freed.
> >=20
> > Fixes: 6cecf09373 ("virtio-9p-device: add minimal unrealize handler")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3937
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > [ Christian Schoenebeck: add commit log message. ]
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >=20
> >   hw/9pfs/virtio-9p-device.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index 50dc93091d..1ec48fc9e0 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState
> > *dev)>=20
> >       V9fsVirtioState *v =3D VIRTIO_9P(dev);
> >       V9fsState *s =3D &v->state;
> >=20
> > +    v9fs_reset(s);
>=20
> While doing the same, virtio_9p_reset(vdev) seems a better API access.
> Also calling RESET on UNREALIZE deserves some comment:
>=20
>          virtio_9p_reset(vdev); /* Drain in-flight PDUs */
>=20
> Could you update that in 9p.next?

Well, I can add a comment, then I should probably add a more detailled comm=
ent=20
why draining the in-flight PDUs is needed, which I thought would already be=
=20
covered by the verbose commit log message.

About the virtio_9p_reset() change: I don't think that's needed.=20
virtio_9p_reset exists because it acts as callback for resetting the virtio=
=20
device.

But I don't see the usefulness of adding another call to the call stack in=
=20
virtio_9p_device_unrealize() which does the same, with more instructions?

Also note my other notes to your comments on patch 2, i.e. security fixes,=
=20
narro release window, etc.?

=20
> >       virtio_delete_queue(v->vq);
> >       virtio_cleanup(vdev);
> >       v9fs_device_unrealize_common(s);





