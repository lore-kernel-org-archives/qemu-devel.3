Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAB606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=WV9Et0Dc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzmw-0007NC-Tq; Fri, 27 Nov 2026 12:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWzmt-0007Mg-2P
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:31:07 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWzmp-0008O3-Ij
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795800650; bh=KSzW9qiiWIMuPDjX1GEdi0g0yWj8wQ2SBkT9Q2cNMRo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WV9Et0DcotEO7IJosuJbmxWokcntScNWI13PH8SDGPeBnoQHPEYAWpMgROu/Osr51
 +dV9l8bQJo9m5Zpqiw9qsLMGcf2CUCqtwqDmsDBndED1jpOR8VwZckMPSRzRjE6Mik
 EqJorXXALdnBWkEcvMa5VKu8OccQw3SuLYFa4yE8=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 7F10020D7B;
 Fri, 27 Nov 2026 18:30:49 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01AD821E6A04; Fri, 27 Nov 2026 18:30:58 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  jasowangio@gmail.com,  mst@redhat.com,  Nikolay
 N Zorin <zorin@swemel.ru>
Subject: Re: [PATCH 1/1] virtio-net: Fix crash in reporting of
 virtio_net_get_vhost() failure
In-Reply-To: <8a0fb57b-3d87-4fff-a30a-b3c50eb0bae2@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 27 Nov 2026
 17:11:28 +0100")
References: <20261127152354.626137-1-armbru@redhat.com>
 <20261127152354.626137-2-armbru@redhat.com>
 <8a0fb57b-3d87-4fff-a30a-b3c50eb0bae2@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:30:58 +0100
Message-ID: <87cxrqqizx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 27/11/26 16:23, Markus Armbruster wrote:
>> vhost_user_net_save_state() and vhost_user_net_load_state() pass
>> @local_error to error_reportf_err() when virtio_net_get_vhost()
>> failed.  @local_error is null then.  Use error_report() instead.
>> While there, tidy up extra space in a nearby error message.
>> Fixes: 60f543ad917f ("virtio-net: vhost-user: Implement internal migrati=
on")
>> Reported-by: Nikolay N Zorin <zorin@swemel.ru>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/net/virtio-net.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 36edb768b17..6ebc5b1d2fc 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3587,9 +3587,8 @@ static int vhost_user_net_save_state(QEMUFile *f, =
void *pv, size_t size,
>>         vhdev =3D virtio_net_get_vhost(vdev);
>>       if (vhdev =3D=3D NULL) {
>> -        error_reportf_err(local_error,
>> -                          "Error getting vhost back-end of %s device %s=
: ",
>> -                          vdev->name, vdev->parent_obj.canonical_path);
>> +        error_report("Error getting vhost back-end of %s device %s",
>> +                     vdev->name, vdev->parent_obj.canonical_path);
>
> Pre-existing, @parent_obj is internal field, we should access
> it as DEVICE(vdev)->canonical_path (this is error report, not
> fast path, no excuse).

Something like the appended patch?  I hesitate to post this for 11.2...

> Anyway,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Thank you!


diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6ebc5b1d2fc..3984218e08a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3588,7 +3588,7 @@ static int vhost_user_net_save_state(QEMUFile *f, voi=
d *pv, size_t size,
     vhdev =3D virtio_net_get_vhost(vdev);
     if (vhdev =3D=3D NULL) {
         error_report("Error getting vhost back-end of %s device %s",
-                     vdev->name, vdev->parent_obj.canonical_path);
+                     vdev->name, DEVICE(vdev)->canonical_path);
         return -1;
     }
=20
@@ -3596,7 +3596,7 @@ static int vhost_user_net_save_state(QEMUFile *f, voi=
d *pv, size_t size,
     if (ret < 0) {
         error_reportf_err(local_error,
                           "Error saving back-end state of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
+                          vdev->name, DEVICE(vdev)->canonical_path);
         return ret;
     }
=20
@@ -3615,7 +3615,7 @@ static int vhost_user_net_load_state(QEMUFile *f, voi=
d *pv, size_t size,
     vhdev =3D virtio_net_get_vhost(vdev);
     if (vhdev =3D=3D NULL) {
         error_report("Error getting vhost back-end of %s device %s",
-                     vdev->name, vdev->parent_obj.canonical_path);
+                     vdev->name, DEVICE(vdev)->canonical_path);
         return -1;
     }
=20
@@ -3623,7 +3623,7 @@ static int vhost_user_net_load_state(QEMUFile *f, voi=
d *pv, size_t size,
     if (ret < 0) {
         error_reportf_err(local_error,
                           "Error loading back-end state of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
+                          vdev->name, DEVICE(vdev)->canonical_path);
         return ret;
     }
=20
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 115d7740fa5..c3c036ca0c9 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -322,7 +322,7 @@ static int vuf_save_state(QEMUFile *f, void *pv, size_t=
 size,
         error_reportf_err(local_error,
                           "Error saving back-end state of %s device %s "
                           "(tag: \"%s\"): ",
-                          vdev->name, vdev->parent_obj.canonical_path,
+                          vdev->name, DEVICE(vdev)->canonical_path,
                           fs->conf.tag ?: "<none>");
         return ret;
     }
@@ -346,7 +346,7 @@ static int vuf_load_state(QEMUFile *f, void *pv, size_t=
 size,
         error_reportf_err(local_error,
                           "Error loading back-end state of %s device %s "
                           "(tag: \"%s\"): ",
-                          vdev->name, vdev->parent_obj.canonical_path,
+                          vdev->name, DEVICE(vdev)->canonical_path,
                           fs->conf.tag ?: "<none>");
         return ret;
     }
@@ -368,7 +368,7 @@ static int vuf_check_migration_support(void *opaque)
     if (!vhost_supports_device_state(&fs->vhost_dev)) {
         error_report("Back-end of %s device %s (tag: \"%s\") does not supp=
ort "
                      "migration through qemu",
-                     vdev->name, vdev->parent_obj.canonical_path,
+                     vdev->name, DEVICE(vdev)->canonical_path,
                      fs->conf.tag ?: "<none>");
         return -ENOTSUP;
     }

