Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A701CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbG7-0007Np-8E; Wed, 20 May 2026 03:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPbFS-0006L5-O3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPbFQ-0002bg-9A
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779261700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtBOl4zIbWZbQqIVS4sNGRkTOoogX+TIHrat9LV3qqU=;
 b=dpNPEw07PvSEAOkZAHy7XdaSNp5N2PZf8jtL/d77baml+AGgn0js5kQSYgDmZ3R38Bxyv+
 JT+Iu/nC7Qw8/kur0MzCHb2fm/M7hGQyBHYDHUADnWYJv/TZ5Ls90BH5h7Pphe3j/6sJHV
 pEEqdDnAdj4MfN41GRFvisBI0XI+NgA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-qzxvKtrENF6r4Co7YEQFoA-1; Wed,
 20 May 2026 03:21:38 -0400
X-MC-Unique: qzxvKtrENF6r4Co7YEQFoA-1
X-Mimecast-MFC-AGG-ID: qzxvKtrENF6r4Co7YEQFoA_1779261696
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBC7A195605A; Wed, 20 May 2026 07:21:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6286F19560A2; Wed, 20 May 2026 07:21:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/29] ui/input: Decouple internal and QAPI input events
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
In-Reply-To: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-input-v3-0-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 20 May 2026 11:21:25 +0400
Message-Id: <177926168571.1572392.14569855807808341063.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=658;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=a1Ovtm7Cs7a+ONwLqWQp0AZKDqAnP3SzXMNy0d8vBi8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDWD4WcOiIOLTJTrsu0aJwLa43pEspnjCsGLpZ
 W+UpCkWe+CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag1g+AAKCRDa6OEJdZac
 5cZCD/4/Ae62H/IukZEKV+HnxFcQVHNX2Ve1fAOmEX5wdgG7xr5cmRaSgzQhZ6nOIsAzXtlXBLY
 xLTsnfaCWiLzQNAYEk8lptK+ufiXAGTSoMJ8bJs5cbjkleiQ7x7BQs0b2lMy/W50vLSQUD1mnSm
 Fowkptdh7ZTRZQ/fMJwsP13/typzSEnaSaTHZYMN1ON3yCp1rxpV083liNT1FSpr+py0C7P/xSp
 ZJBxECRsRquEe2Z3TeyV3XKia2BcHitEJUiucMGwmvRislyT4rQSsmmPIFbAYQezKVI214kAmiq
 r2VSI/agmzjzjmzaLdQvwBplcp/4Ec/1LXBX1OsnjLALXBjnnhKWQLp+p/P8mpPoIsnrhw/KPrO
 YrBsrFJ5Jt+0xk/SiHuK1tRNlliLL+PNyO/b12io9P9k4eJdeEsUnJaE9hb+X0Agy8excI5mXRi
 wpRjqZwmRQnyNV9kocT8hk06S5VIAFSWyE5rIiakDKsLC5/HxFUibDvvcscAlxy6savRxtZnGAI
 0cRCr7NKf/v1FuRJgE+zUOSN4KTLJRQ4mrmKETOWfMNE5BTao1C8BymfrhqzbkLBPXTQxQNxy9X
 ywEJaYl0DoubQeygabSk69u0Gc7lAWadcB16oZJWUnYu/UO7xos0HVBUbe0u2VLd7CZqqqMXke/
 NB5yJoYuhMArqcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
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

On Wed, 20 May 2026 15:47:43 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> ui/input: Decouple internal and QAPI input events
> 
> The internal input event representation has different requirements from
> the QAPI representation. Using QAPI types directly spreads QAPI-specific
> constraints throughout the internal input code. Keep that impact
> localized by decoupling the two representations with a dedicated
> conversion layer. The decoupled internal representation has the
> following benefits:
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


