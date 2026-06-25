Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC758CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclZ6-0002ld-8i; Thu, 25 Jun 2026 11:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclZ4-0002eb-AK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclZ2-0004KQ-RF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDncTSOv3iCLo8fG7aLNIaABYATx1bh7WOKuiCG8NXA=;
 b=ELtEDRQmKXRXLu7FcPAhD4TQk2jaFg4BdR1+DRVSj8IJ5leHAYhB5WaasfL78C7o3Yi+42
 cMtTLAduIqiCF/B5Rttpv5f7GWEjWmEiZI20Bjd7RapAlSmgp5x2tKkHwdZGCjrs1ink16
 yWybUfQzpBPXyBXp2Bkry0zsTdOll00=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-sMn2YXLXP0yE2oa27euLfg-1; Thu,
 25 Jun 2026 11:00:19 -0400
X-MC-Unique: sMn2YXLXP0yE2oa27euLfg-1
X-Mimecast-MFC-AGG-ID: sMn2YXLXP0yE2oa27euLfg_1782399618
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AD811964CCB; Thu, 25 Jun 2026 15:00:18 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66BFB1956041; Thu, 25 Jun 2026 15:00:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 6/9] hw/audio/virtio-sound: introduce
 virtio_snd_pcm_open()
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260625095250.65073-7-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-7-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957438.405566.12167477433283791537.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=373;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vuSCnkWi0Ac/jiqlT5cVFG11p3z3m48YvjLfNKOliPU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJaFFy1mo4nj9EE1V2BJSFRl/8O59BE6DDfA
 mH6I9/KyF2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5WIrEACRzHLpvTIC8cRPw78F7y0YNeaahAl6f24XEGf1uJ+Ul8j/vZ61j5/YW33Rxkobj6HcH40
 4VrsLlrxoRq7tDtGrU73GkK4HXktD1+10eBQj4IZrWfrNChkloLa/2LVktQQgBqb8I9RVAGYOhC
 +ANxcSIgP4s443lFoGO4xiJwGUknLheSc1m9d3kqUzyWri/j4hHgNWMst1ysax2K6e/c5YAlx0V
 pLVmQucdgzrYLyDcyBGP2WsaDWxm9AFVgxKYacyliM7croE9vgYv3MD9F6i45n3+xx2H2+E2Qad
 JTrWrxo7t5sH6KJxB+JO/wAoEGvI0DIUzAN4qh+u4UZebp9DhOeMaxtUtwhFbs7PoESkscxrLPF
 AG5Z2jZrxomAJ5jQ9uQoLiMjomYrZbnv6TBxxmCpr0RGKPcm6AciATkyzMGoOvggSpQEhXWnxXK
 ge61rsks9zJ7B8PCYmzsWARYqYJ1EsL1bNwnH8y+Fuu6x2bJX95sgsIJg1aU97FrSwMqrcsc2B7
 3MKdMGDPrgGF+g+8plpaLJCEV2zPR92faL2dhdMooUy1T8ejIUfsELrCYR2JUAv2lIedeYaOlVT
 AAVyX0wqN0ILrzMVCVpoe2wIyvG9tDyvZhOHrPMhE4DLIQqa01lYr4Sr0OqvhuJaDQhMAfMllU7
 b93+tW3oO03SuQw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, 25 Jun 2026 11:52:46 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> Split out the function virtio_snd_pcm_open() from
> virtio_snd_pcm_prepare(). A later patch also needs
> the new function. There is no functional change.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


