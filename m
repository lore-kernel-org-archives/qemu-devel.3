Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10229CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclYh-0001wN-RA; Thu, 25 Jun 2026 11:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYe-0001sH-5u
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYc-000427-Sg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9SM8vbBcVg0dBieY8zgrNud+Ic52U0g/rNBQe7VOW0=;
 b=X7nQ3L4fIQlzUWQRgIByxtTV39n24+JXAFtiIV7ar0CiDbhhqc5PVLxhfn570CJ1FCwWxo
 xh3TtxrqUogBA9HgJSC1K35ODHvM2+Ec23yqyusxJYEBBAr2oMnIvZy5n/Ooiuu40DwoV7
 V3nrOCSUkKymFawgCip6pCQVayIPqP8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-syuOE9-5PQCc0S436z1X7A-1; Thu,
 25 Jun 2026 10:59:55 -0400
X-MC-Unique: syuOE9-5PQCc0S436z1X7A-1
X-Mimecast-MFC-AGG-ID: syuOE9-5PQCc0S436z1X7A_1782399593
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C633B19774DD; Thu, 25 Jun 2026 14:59:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D0D41956044; Thu, 25 Jun 2026 14:59:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/9] hw/audio/virtio-sound: allocate an array of streams
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
In-Reply-To: <20260625095250.65073-3-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-3-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957437.405566.15702161461602301135.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=567;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bR8j0VbOY0kB2YJvuPpQ0LSk3jceZYrWz+85tGJPgDo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJaOE16Q2k0Mqkw/kWCHfAPRuZBEr3+Kai2S
 scqli8B882JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5RtzEACubHZhGd9UnN1mOF3osRQFTvWkgsKeiUXU1bf4v2lK3baSnEvVS7dyo9WPUNU26xTUD78
 lh5KgM3GvkKJix9KFK3qk/MH2ym473N3+qKTzVMPVxtC6looKOK4YHHYT3eFR6m60JoxpO2PYOI
 9+3cDK++JP2TFtme/CrIyzBF2K2lJlaWkr1DTZQJEzCiCa1BTi0LR/KTrwNcTMLWJaxZdD0+8Rc
 EsuOus7Pu+cMxkL1jyzJGjMFd3QzDe/tQV4RoZZOrWyutUDbMrERWq4ITaajd95Y6FkzFHKCOj0
 bU5jC8MGN6BJu5qmc9zpkMTR6aK5TFPWOMFw7xds7GFsy86kjHHks//bZjsG24CJs8p5gF23TIp
 zkJcLsK579Ut11JI2mEpt0i+16t9vHPvBKEddkyEut0ETMyYC4jqwxkSrD/FTQYjsukifEDByUv
 FhBhJ7YGG5UCvKBfqet0XFwnHmgLhrMWyu9YI+YbtYf1hz5pSYaDNKPnl6A/hxvXO1XoD7dVB/F
 R/SP3NIVMo0GjVLYUBMEHwmnKVAw+CyJDPOAGKdeOgw+a9OJcFb5iDlvNSCSwFf9s1Xr8aT55rQ
 v9dm3VS6kpctTuF6VK9lfemw3SIXHimnUMFjwjG9A0p9uoR705nt5Eo0BAT9s1btWjpvbjo9o3H
 bEcokWev5pjeaJw==
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

On Thu, 25 Jun 2026 11:52:42 +0200, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
> It is much easier to migrate an array of structs than individual
> structs that are accessed via a pointer to a pointer to an array
> of pointers to struct.
> 
> For this reason, allocate an array of streams in
> virtio_snd_realize() and initialise all stream variables that
> are constant at runtime immediately after allocation.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


