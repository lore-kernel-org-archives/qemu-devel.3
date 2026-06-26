Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D02C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7IV-0002If-Ah; Fri, 26 Jun 2026 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wd7IT-0002IB-BV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wd7IS-0001Hf-2a
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782483162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5uyi1eXJ7KZEgS2qEkLKhkYYRNmeWQ7dSE5IVz0CQA=;
 b=C5NA5ToGPfAN0hPV82xvPLGu//09odXD+2jIExmgENqzFsidSso+4OGbSkJXBBVCUMeb6B
 b0W8Mca0nDtCGAoJuInTVwt4buydXK/CxNacIsbLaoNckTwLXmJgipm0gQlAJOz0Ady7fJ
 5urtAtVNJJjUbsg7ABnltY1jJARI6Gc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-TaogeuXIOYKcWW3a7UTT6Q-1; Fri,
 26 Jun 2026 10:12:39 -0400
X-MC-Unique: TaogeuXIOYKcWW3a7UTT6Q-1
X-Mimecast-MFC-AGG-ID: TaogeuXIOYKcWW3a7UTT6Q_1782483158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41ABC1956049; Fri, 26 Jun 2026 14:12:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C2E21800661; Fri, 26 Jun 2026 14:12:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 8/9] hw/audio/virtio-sound: remove channel positions
 field from VirtIOSoundPCMStream
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260626123531.132078-9-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-9-alexander@mihalicyn.com>
Date: Fri, 26 Jun 2026 18:12:23 +0400
Message-Id: <178248314307.2718091.17411171533577710568.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=309;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yOXp/R87Fu7wr51Mm8H6KeGLwu38Bh2BLiS+x+CAKlc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPojKdbYPDN13z1+O3ZUgpoNjp6RQG7d8suGXH
 nyKE0YbMjeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj6IygAKCRDa6OEJdZac
 5cikEACs5DH+w1j4WrCPfOadizO/ydFD91QDiBGvH83ZijZs0l6QI3QGLGxb5PH5VpbvPfm/j0a
 N+e17BYZgHApZHxg6W9HvAaLWj8ya77scwNEbIv4RtDteglrXl+y7JVVdJmCUjCSRjiRr0WJvik
 EIC3bDJ6jIwI7duXGuLhA/CAou1oeFcCXzFboLDCDqHY6hDkg+YeX7DvHci6aBdzc5vnxR6WSn/
 LBR1i/A0ZZf7cfWt4mtmy9be3wLTocrYrItv/mJvnLDsq4JgvY1ECCf1yh6cfOPQ90t5tae1HUN
 40QfWDFSH9cOi2QgrjDyWBvvPfWPnPxzMz+1PbJw8b9zLWW85gp29IJwBPw2Es4Sd4CJA9L5oZo
 0TbTV8i5LraEyDZSV1OnVc6irnnKK8pN/kpJPy+YIHzXAhFJZSXvXMz6oPsHgrLR8JzclCpHsnP
 Y8D3imMjkS6Ry/DWZnKe9rqVb+HXu3gSz51Wtn/MBx9YaJayGHPBwPc03QH/u0w91g64HFtsyEj
 lGTEbKWm7A7mcrOU/0+Bfia7W5JYvk+IESvwGwUDmveATyqZGPRwsGOKp4263Xc2KmymBSvtq4s
 2n0pG3v4GOFvNqufsiUnfTG/vjJPx9JdQxoTiTHAqvXisJb/W3VS2AlssH4xdRQ5IHpK2nOyoLk
 OJJXSCcplU+Pe3w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Fri, 26 Jun 2026 14:35:30 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> This field seems to be useless currently, as we
> don't implement VIRTIO_SND_R_CHMAP_INFO.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


