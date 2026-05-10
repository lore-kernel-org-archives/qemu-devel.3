Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A0CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 06:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLxEd-0008Bw-Hg; Sun, 10 May 2026 02:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxEb-0008BL-BC
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxEa-0003km-5C
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778392907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p30t2HWw2IXhu5zAsLXFGJNllg/iVp/i88KXjAiTc9M=;
 b=TbdlckHVQWdFx3wDDpvvAYArmW1YPL1lA35FE0NJqcwKDckm7L3nxNhqGtehGk0n7qf8T1
 jGkwh990bgvX0cuVzFWJH99qIePfhEwK9D92Kau3Scz/lFG3bgnMnaJi72XoUD2RES4+KV
 j/Jn4jGaCrHi2/wn0ECAl5NuJV4Ti2M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-s3wyIf-hNz2pak7xT-9JsQ-1; Sun,
 10 May 2026 02:01:44 -0400
X-MC-Unique: s3wyIf-hNz2pak7xT-9JsQ-1
X-Mimecast-MFC-AGG-ID: s3wyIf-hNz2pak7xT-9JsQ_1778392902
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD7F1956089; Sun, 10 May 2026 06:01:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4D8118004A3; Sun, 10 May 2026 06:01:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC 12/28] hw/input/ps2: Use Linux key codes
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
In-Reply-To: <20260509-input-v1-12-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <20260509-input-v1-12-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 May 2026 10:01:15 +0400
Message-Id: <177839287567.1301060.18218108403655321396.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=459;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=X46TTTRxW5jkr4fHcUERh340vPFOp8AP/XqQHe6Hgo8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAB8umdvHO/rpShe+tIE04jUPdXrLhZIhEjvV3
 jWqhX5wWbSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagAfLgAKCRDa6OEJdZac
 5c3rD/95XJ+UsC6j+9CX1x0H9dtJS4SX34DTlJvefSXwQplFnqEIlT8JzVrA5/TxavY07s3IMKc
 O2dftmzTChVylBCcifoNTIbxgXz/tpf8JEuAfAze+7mjejwUFCtmJELjJzGPeuSGWw4BxHaMV80
 wSMK1S9p27x6gnYmkHJd1vWM12674mH0HEkZAv8JaOzxzsUbwzPR6wawTn7xYNzu51OmELC2+d3
 bOAfI6FTJdyDDtauiI63Q4HCifHFJkXJuRnb/KBpi8Z1SKG/iuHclowGcQx6gwd+mscXpxj/OfT
 VfsqWAmxnXDHcL3VtA2RaIJCZQcohWHu5WvVl9ri4UAIDxe/EMPNfTAXo60C7KVOye6tSl+Nd6y
 fJtDDpzjcDDDhk4UMoo9EeWwMQ6eHJZp3GkfsByB4m5hza2Q9ye+iHY90nilhbSfjqlPfv1ZerM
 vP1wPmzgT7rjtj6UNecakGBPRHIq5z7zSqTgV4tvHUhZpBWSVjsdArn90Hh9Z25LHbW8eJWk/qJ
 dc7WT+YAxZJqiaCjJJNIo/pbPe4/IIQOt5bunpIftfwwcK1KHzNPbqZp4a4uvrGqlqMmVHtwX91
 Odjrmht7tBoNC7QJjs/QOSwknOROZvH9hKcTdD39KuCr1xw+kVKkD8AOo85mDQv5jdvI/0lUH67
 zw06W2n+7nSUz8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Sat, 09 May 2026 19:34:24 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 93c3c737205..1f266bc6a07 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -126,17 +127,17 @@ static uint8_t translate_table[256] = {
>  static unsigned int ps2_modifier_bit(QKeyCode key)

QemuInputKeyEvent.key is unsigned int after patch 4.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


