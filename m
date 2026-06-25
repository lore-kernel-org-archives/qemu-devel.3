Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0D1CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclYc-0001rl-ES; Thu, 25 Jun 2026 10:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYZ-0001r1-NJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYY-000413-AZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uo+3Xc23Htz0d0eVJD1JByoGG4wdHA2WB67o8Rltz20=;
 b=OTbtaMijBLzP911XDaCF7QlkmThTwFhhgnmXP3i3s8uEVc1vzw2OW7uU2n3PtSjdLGqzNX
 HicpzPFU4sSyj4/f4yVjCyLsdN21jQFLqK5e6clNlz+Cwd9a7BddkDihUL+JE8GxFexD/r
 ImDonRmIoJ4p0l2jmHmdrYsp2Dk6UPk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-JycHB8_iOh6PUtz-HzuJ6g-1; Thu,
 25 Jun 2026 10:59:48 -0400
X-MC-Unique: JycHB8_iOh6PUtz-HzuJ6g-1
X-Mimecast-MFC-AGG-ID: JycHB8_iOh6PUtz-HzuJ6g_1782399587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51B4F19774FE; Thu, 25 Jun 2026 14:59:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4107E18005B6; Thu, 25 Jun 2026 14:59:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/9] hw/audio/virtio-sound: remove command and
 stream mutexes
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
In-Reply-To: <20260625095250.65073-2-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-2-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957437.405566.331597169630851919.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=521;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K2uhxBIK0x98x/AwPSa4PaRCPnDz4S3dXBo0NF+cuFc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJZPb4tojNZJrVB+FrGUb8aQY74SUUx6wbWa
 C9KFSHpCSqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWQAKCRDa6OEJdZac
 5dhRD/9H95V7lPheHr/4sS+QAquJt62bCZF2WIwjtT77vDSXfJxtEz3wF1QcEHYoT6lzggZ2E7K
 2H8Wv3w1XYrhi5pJsuOVTnDxAbayC6W4pHVaZgtH1Uotq4V4PDuDEpHtaQR+gi2X7Uq/iAHthSW
 8a1tlDgoffTb7o6G1C849PtdLn8on0E8FEv5lH42Jzqt8vj7rT2XVoWxdGVHuyUd03+9yDHgdBU
 ToxY+XGFkPQwOFD8W+U0CzCD3xmjQIvwRpFrbzSRj8sSAegHShj29QiffmNyx+aGNp6O5+8v66C
 gUscCU2bviGFBfmWzzkGj6/KaDfKHAXltUfCwR493phnPRwRErXUYDYi8fbJ51aweNa/OPpxi2r
 /D9v+UMIS4pYflD5N6t2NMUiBgcCdwUjPfz0NaUXO4MsP1KCEnlYcQ8PKJI7oJwkRixN600zlay
 0mDPxSypPl8zd7RI3E/TC5I9sIvMZqHwO/FUK+a1tKJ6qZn3NLYi3QeiVM54+OWfpSdZC0yqE/J
 4X1vH32s7nDHT+7MxKzqdqidXHCDzQTxwTMytFRj2gWFE5v5Es6k8D4TxUalpLLv4EFwgX2w5hn
 o0XP7PXhswlXvRoltHv+C8OeniOIQybd7+ovcFQoi0METG6FMUadpA5NlEv9HsJkPp4eoQ2Z72U
 /N++4wqaVkgQJeQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, 25 Jun 2026 11:52:41 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> All code in virtio-snd.c runs with the BQL held. Remove the
> command queue mutex and the stream queue mutexes. The qatomic
> functions are also not needed.
> 
> [AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>      and then reimplemented the patch idea
> /AM]
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


