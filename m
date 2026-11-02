Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC08606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+Za3BoD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNskX-0002eL-Rt; Mon, 02 Nov 2026 09:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsiB-00083t-5b
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi9-0005GG-Nf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5AxJABtUjhPH0VKiaWYWLYGlmOV99WIySfO7K7RwbY=;
 b=h+Za3BoD99H9ayuSHbIC2K7MbPzTtlFuWppX5aeNgSri64WsBs+BiIgZbAUZ1mSqPm+2+E
 oO6vq2fVzuuOv75iB3tkdr+iJlTLRZNCSa2seq3tJvJIy0RG7yObvrGXSPUWHvRelkENVJ
 yMxn0Buubj6BZ0jrY6rkb7t6NLbwAYM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-_M8_NFfANFOt9i6xUkdRvg-1; Mon,
 02 Nov 2026 09:08:28 -0500
X-MC-Unique: _M8_NFfANFOt9i6xUkdRvg-1
X-Mimecast-MFC-AGG-ID: _M8_NFfANFOt9i6xUkdRvg_1793628506
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1597F1955F28; Mon,  2 Nov 2026 14:08:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01E8A1956049; Mon,  2 Nov 2026 14:08:24 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 16/18] hw/usb/redirect-server: Stream interrupt IN
 endpoints
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-17-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-17-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845022.3960472.7149018835120290019.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TyfjPl6Lgm8UNGDmROu5LHcqrGAlz9tyrpdNL8OotC0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6Jkkkje6d1wtaLxQWLGZIajGkc23jr3gOUspm
 3ASTAxEMyKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5T6tD/9D/gkZAqCeh/AA+ooUg2bIId70Ip/ZbgSWTXJnMwNYpRa4IVa9XTDjKS6aQ3ISHbiys1X
 do5GvFmrKFO/ZsOczKvYBEKdW/NDq+34BoHAMuDxJ/ylfMGX33BT2nP5rWIrnzkWbf7/dObC4mb
 vGdW5YrS7H3Fk4AIWZ32Wqm1VBcjyZ1WwZ6TcFjN2iEza1/A0qUGBKr+zBP0wFZLk9g2A9l+fGc
 +usYHrgfywsIFD7Z3dm5j1UWHV+Hde9Jog0z9rGS7FGsu7QR9FOVIshQt1QVPXVCRkPgVj/8bmv
 Kl80hB7vEoM0jEdlXkhBSExH3NgvvC3Kei8K3Ib4DhIte0IQnKzzCekaWngdF5meStKUX51U1JG
 ZSe2h79btEJ+nJf/LkUqnUpgJ0P3LnbVP172AFunGEeb1XPNlKx09puC8nSFVJnHLutN0JXet/C
 EGll2La3iTyBaMkgvjIC1PLFgB0Y6rrotM5h1tfSWmGr8wAvY3R0xNcyrtN4bJZ1yjBEJ5E/9Jn
 RnPyhyhbFyAHec3vi2ABkHNE25iwgnZk+0oSkpj9phj68xuBDiuB14LxdXSGYslWVuHoWTaWI5k
 yVOiYrdKDZUfEezWd0uVnEPJhM7Ct8CQLkO4cMop6tKqzfDsQuhjmz4LKRWB0fqJqaPB+5gGwCI
 LKo2QnUPfJq55sg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:26 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Interrupt IN is not a request and an answer in usbredir. The host asks
> once with start_interrupt_receiving. After that it expects a packet
> every time the device has data.
> 
> Park one IN packet on the device for each streaming endpoint. A device
> that answers USB_RET_ASYNC holds the packet and completes it when it
> has data. A device that answers USB_RET_NAK gives the packet back at
> once, so park a new one when the bus reports a wakeup on that endpoint.
> A slow timer parks one too, for a device that does not report a wakeup.
> A streamed request does not wait on the endpoint's list the way a host
> request does, because this timer already asks again.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


