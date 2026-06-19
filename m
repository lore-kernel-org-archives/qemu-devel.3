Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9EBCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waUIZ-0006zk-JG; Fri, 19 Jun 2026 04:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1waUIY-0006zb-0n
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:09:58 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1waUIV-0004JC-Is
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1781856587; x=1782115787;
 bh=gCYyTipDVLSMmIqEZMEscx4MtxOu/VfFzAfF9BaSv6I=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=JZyIeT8Kf5Ms7qTsWnt5jHXn3XqGru5/SMrfRTPI7aL81xJiW8mds7mU8BA3yoVmo
 UF8NNw8pLrvv3wwOYqJ0PfVUIJPQztLQZnBRDettjZeDFjgybFak4LKXFo0m471dfT
 TXPrc6igVm/7ipjHrjzUG57yeHkxg6Z6zk2OaUaDL6norDGSQLjJKe02UL8kpZfcbc
 o4CoE9OLgiJ4i6pezZGHx0aBY2bnCISMwZs1Rpl2HL0opb0OCjr7aiSELnSTi/AfAm
 dqyS54elPbBTYbiNZ02rLcYVumCDXpHosE97EnUpSdQPBQ9inue9dba0i9hweriz1a
 UDnp2VFnqJFjw==
Date: Fri, 19 Jun 2026 08:09:42 +0000
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH] audio: converts malloc to g_new and free to g_free
Message-ID: <20260619080934.237834-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 06175f0f190bdb2a37772ef2edf80ad98388dbf7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169;
 envelope-from=christianslima@proton.me; helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Following the qemu coding style change malloc to g_new, the advantage
are that g_new can catch multiplication overflowing size_t and allow
catch more type errors because it returns the type itself.

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 hw/audio/fmopl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index a63ad0f04d..19c4b388f3 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -607,24 +607,24 @@ static int OPLOpenTable( void )
 =09double pom;
=20
 =09/* allocate dynamic tables */
-=09if( (TL_TABLE =3D malloc(TL_MAX*2*sizeof(int32_t))) =3D=3D NULL)
+=09if( (TL_TABLE =3D g_new(int32_t, TL_MAX * 2)) =3D=3D NULL)
 =09=09return 0;
-=09if( (SIN_TABLE =3D malloc(SIN_ENT*4 *sizeof(int32_t *))) =3D=3D NULL)
+=09if( (SIN_TABLE =3D g_new(int32_t *, SIN_ENT * 4)) =3D=3D NULL)
 =09{
-=09=09free(TL_TABLE);
+=09=09g_free(TL_TABLE);
 =09=09return 0;
 =09}
-=09if( (AMS_TABLE =3D malloc(AMS_ENT*2 *sizeof(int32_t))) =3D=3D NULL)
+=09if( (AMS_TABLE =3D g_new(int32_t, AMS_ENT * 2)) =3D=3D NULL)
 =09{
-=09=09free(TL_TABLE);
-=09=09free(SIN_TABLE);
+=09=09g_free(TL_TABLE);
+=09=09g_free(SIN_TABLE);
 =09=09return 0;
 =09}
-=09if( (VIB_TABLE =3D malloc(VIB_ENT*2 *sizeof(int32_t))) =3D=3D NULL)
+=09if( (VIB_TABLE =3D g_new(int32_t, VIB_ENT * 2)) =3D=3D NULL)
 =09{
-=09=09free(TL_TABLE);
-=09=09free(SIN_TABLE);
-=09=09free(AMS_TABLE);
+=09=09g_free(TL_TABLE);
+=09=09g_free(SIN_TABLE);
+=09=09g_free(AMS_TABLE);
 =09=09return 0;
 =09}
     ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
--=20
2.53.0



