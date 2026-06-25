Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAAECDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclZc-0003ZJ-Q0; Thu, 25 Jun 2026 11:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclZA-0002vv-7N
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclZ8-0004LG-RV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9qgZ9Vd/toWp9+BtnCjWXJ6jiESYrg4JtO8aE80OVw=;
 b=NwOxg5XCLHBSGKdIUjPBXEtwPhqi9KhWWBDVmcOhIvSS5eMZRwX2jdWqtvX/e+6yFw/d8u
 nqBNyyieTbF4UMdMEWVcN51Imbp3/jgdLRJ7e1s+eSKdqrFOV0bEcdWNlCWAq43c28VIMt
 uLS7T4Y3u5wcZkd9NYKnNhXpg0Afcy4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-uNtyOBSoPcm-FIHsoXDOuw-1; Thu,
 25 Jun 2026 11:00:25 -0400
X-MC-Unique: uNtyOBSoPcm-FIHsoXDOuw-1
X-Mimecast-MFC-AGG-ID: uNtyOBSoPcm-FIHsoXDOuw_1782399624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42EDB195F17C; Thu, 25 Jun 2026 15:00:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AC40180056E; Thu, 25 Jun 2026 15:00:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 7/9] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
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
In-Reply-To: <20260625095250.65073-8-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-8-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957439.405566.8025367087476768515.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=382;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MyaEmo9P3/Q1s2IQ7zGs9Gqbt7IoZ6AA2zXJzRm/eiA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJar/TxH0Odhf9lZwwVlap5iMAZaihNwUw1d
 7ojBBYkUM+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5eMoD/4+zRUC1/3eDdQP3wHqveXoxRRYa+yLOTsc/G4cq7Voc0IdjrfmF5JlbjLWD38Jj8Ukb5B
 5RRsNsK7VfhJJ6bpG7g2HCHxZusxoCcA/VaN++ULlh0KdVhr7HI+LjElwGMUq1ULsnzz34st1dl
 g+NIDU33IL0THpPN4/hWU+a6wJO7Rzn3X7BnbrrgHOxMvTOy1t9CrSPB1jI+GyOi2xXqpMkr0FL
 2jkvGCii3H0o2DZwWXPIL3148nYcyOCvoEm1i/dQMNxqHEVd/7pfLhlp+tBj+x7FkPbbo2kSC7D
 59uQRKn+EDFyOMdKx1hQLFxSFaKOd+hTt4KQDnSSU70Zcww6L/KMl6vadeIpCPNPGMdbAUUBOiB
 y1oQsmTDKadXe3bVLSIDCndu2b5Kg6ZL/ygRujy6eipkstm1R+HbeA8HGZWTQkb9X56unJsWJkR
 kjanDeHuHysNQaPsQ/yJgGUSbiPGr014mPRUMQ7UWCMQykR0QVwjM4Yx99MLWI2rW9Xn8d4JdjI
 D3IQArePpWYRtps2UBSw4NZEk8nmyHanSCwUYpvRk8VTh1krOgbxFhsLs3c6cYuY6r2IzEoDaIX
 D5SQZXxbojcwfSvBNMgikGuqTOzNTqatSmTqx4QLlHBUFIguSb7POQY+Tmg/vPKuEH/ZZi4olAe
 UEkhJLewRkNdr8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 25 Jun 2026 11:52:47 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> Split out the function virtio_snd_pcm_set_active() from
> virtio_snd_pcm_start_stop(). A later patch also needs this
> new funcion. There is no functional change.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


