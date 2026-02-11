Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825F8EA8125
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq732-0000eZ-Gc; Wed, 11 Feb 2026 05:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq730-0000eE-TV
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq72z-0002x4-Jx
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770804132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xstgm4gDxK9ky5Ra+OZw5M9UpwX3t/IqfrRE1e6IXlw=;
 b=LRadYAjK+IA77QSQAvtMjBwrwT9H7yHK2Zhseq6WVScM3UENqYHpgNZ+SFV828FLxeaOol
 KCsrDe3WZIO9KzCr050C4MaDH6+AT8EiXLVBkaF8u0qRfNt29OOOFisYJS4jIP7oYjxDVo
 aCWvGKV1oGc2bBMio2s6/Svg73Z5Ei4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-aSznKFuYOD2H0j3iLGaNTg-1; Wed,
 11 Feb 2026 05:02:09 -0500
X-MC-Unique: aSznKFuYOD2H0j3iLGaNTg-1
X-Mimecast-MFC-AGG-ID: aSznKFuYOD2H0j3iLGaNTg_1770804128
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 657ED18005AD; Wed, 11 Feb 2026 10:02:08 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0318530001A8; Wed, 11 Feb 2026 10:02:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Feb 2026 14:01:41 +0400
Subject: [PATCH 1/7] audio: fix nominal volume channel (cosmetic)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260211-cleanups-v1-1-e63c96572389@redhat.com>
References: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
In-Reply-To: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=679;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XBLGibyEigNks+WFMeGA/SEdepejgGEzxwPL09cyJGQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpjFOSxaiwIlosp6vOhCbuCiPVivjSXyDIPHDNa
 9ZLvnuiZaiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaYxTkgAKCRDa6OEJdZac
 5SrTD/9W3n3RByaFR5D8nGWOMu+5yYLjr6FALn+hp++2FXYKav4xrlaHnW5KL83j2pd4PH1zpsI
 O31wKYdmtZI/H7lwgI/Q4Edv71qNyife3IC4RxNUcBm08s4OF6RiSLucii1epCu6+PFKGamZ+jv
 HsbqUjof4eZBgOyIMF0wfkG+i/Py+URdQvuMcUNM8Bhj+IY58Bj1dIgIGzmH7E4FRlWVU2pFSJL
 tvQd0GLSXdt/uKSHqOx26JQqvCo6w4zcSV5aVqPPWXYIBTgbdKzEunEnWR1sSsPjWK+kqaGbd6i
 MtyjJqxHC4Ex+VqnBoGmjbW+KvazixU1THDPqpXtU3scN64QZvSji1hT3PHyrfXzMJ4AkML6U2h
 rCyHehZxNNFB4V8MzAMSt0FM/bzqdFdUtQVkYnIicCApnWezr/IsHEWcKKbKXAkLdL0cnUEG03D
 nYODk+ARSTHVBS1ZeVF4bkIoQfVxQYA7TC8SlChaaCu5c5yAD3SvkxJPlRFcJTjMGS6okPN5x4Q
 X/xtnNoYHmb/j6K+Xvmw34ELSDANKcKYpdxUS6Sdq3wq0nevO2reAWL6xz8PHTk7PrKEKpWAv1b
 lhyUd0JV8tAn8r8eG6xZx2RQ8tsrG9vTzLHMwpNGxUYT9VgOgeozUqo43CYlfh3w2CNNp43NpF/
 RePUm364moTImAw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index b7a28f79d4f..e35b22697ee 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1948,7 +1948,7 @@ void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
 
         sw->vol.mute = vol->mute;
         sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
-        sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] /
+        sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] /
             255;
 
         if (hw->pcm_ops->volume_out) {

-- 
2.52.0


