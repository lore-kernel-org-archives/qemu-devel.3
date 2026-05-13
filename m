Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE13DCD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8KY-00077i-Fc; Wed, 13 May 2026 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wN8KO-00075r-N9
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wN8KN-0006mt-9b
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0MKkhU2DlWweFtYjhDaS0THBiPb7Ntla0RhsEZpnEc=;
 b=eWsR/ahEv6we9t11F19GMmfHQwjkRauniACzxQRcxoOPJLF+oQuiwMvIaEFQVio5uAWbFx
 L1AaAJJ6bw/OUv0nhhu7ongyiKgINs9xPWyRldXmMTCN+TdMICJgaOEPxiksN3BkKHWBDF
 5QdhtOZGRLYpi9SEK7ngPGjvPO5UKH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-VtIjCp26NlSBUuSL_iXtww-1; Wed,
 13 May 2026 08:04:33 -0400
X-MC-Unique: VtIjCp26NlSBUuSL_iXtww-1
X-Mimecast-MFC-AGG-ID: VtIjCp26NlSBUuSL_iXtww_1778673871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2CE9180075C; Wed, 13 May 2026 12:04:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8983A1800576; Wed, 13 May 2026 12:04:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 04/29] ui/input: Use Linux key codes for internal
 key events
From: marcandre.lureau@redhat.com
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260513-input-v2-4-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
 <20260513-input-v2-4-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 16:04:22 +0400
Message-Id: <177867386225.1892592.16024787865842059974.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Anq7yXco+X1mi20QRWxcBqyiGY4fDU/WWzl124Mz/4g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqBGjI3IxMJhYDcrd7h7LrwA/s7wkFjQp78Xlpt
 9MAwvf6uL+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagRoyAAKCRDa6OEJdZac
 5fG7D/0aA+TFuo2ZmqydIhuFFNcl2pMw6kHugICvUbJ4TZzKoFKctORxenskhOq92t+zRHXt/iG
 MsOmxEvGNg40ZUlbTKII0eMXLeo/VGl+pLwiV3HiKT93OgXRC+1KlOZaWf5cMJO22XphqnAAELf
 1e4G5Evjl1hy5rW5TKXEPCXIFX21B5AeDm09PtQ15CRf8eodmUlw7IlBfefyJVDEvZjaGItsFUp
 SyQOsMUlEXIDmIgTPvpUimrI8An0MSuEAm+uZNPX0PLTw5uY3hoMXvQ6Mu3JKutlXJeMTXJHFji
 ABIkvAOTNITwflwAXQTEz3EaJewO/vI7o82twgip3If6w+SgtA/6K3qyLaYl7P4SPjLe3svKIlV
 blshMGmP7wMnkEcRfjZ6AptxZUDt/p+PNbnoevf+uhPIRU6xB0n0RZp/f+HH+Qi9oOfY3+l9+U8
 m2Hy643qxNN0GCLzNMXVLOwaJe4+vJzZM78xccHFZjLpeQnWu+8BAxsZxwckLchag1aoxiwjvj5
 d1r2QIZGAVZ4wupvKh2seR9QDbCssmwg7UojkI2RxHbKc38Psf02PvBON6jZMQsL+E4FCaYwTua
 5f5e5PlJsMwjaa35FoocRQB3KohYuXcMy1c54dE1mOtXohOH+1nWLwtqn4zWG2FhJJjfYQYNhw3
 9y2Rj+q6ZNAS8kg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 13 May 2026 19:38:20 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> diff --git a/ui/input.c b/ui/input.c
> index 9232dd7fdae..5d155e3af07 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -412,8 +391,8 @@ void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down)
>  
>  void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down)
>  {
> -    QKeyCode code = qemu_input_key_number_to_qcode(num);
> -    qemu_input_event_send_key_qcode(src, code, down);
> +    unsigned int lnx = qemu_input_key_number_to_linux(num);
> +    qemu_input_event_send_key_qcode(src, lnx, down);
>  }

Shouldn't it be qemu_input_event_send_key_linux(src, lnx, down) here?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


