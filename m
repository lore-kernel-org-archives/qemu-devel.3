Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A64606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NLtUoizO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDy-0002uV-BW; Thu, 29 Oct 2026 13:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUBO-000754-9P
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUB9-0003eE-1e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0EDGrbjdaAR9t8v8JyOSfK6Z1RQz1W/HigtjeUOWx4=;
 b=NLtUoizOsaRodmn2TXjst/hAdz+6j2z9Ugx9+d3Hh75SJfFcUrQy14rO30drSUc013ZIpe
 h2p6jqjdatLs1jkiGIdoAK7uJ23jCvcEprGRaxar0mm6LTVmyY9u5SP4pjzQ1sg0lxJDqD
 nUESdm67fISxL/FkkBne8O7JC83kCFE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-pQB9cybpMrOU_Y_7IgNx9Q-1; Thu,
 29 Oct 2026 13:44:30 -0400
X-MC-Unique: pQB9cybpMrOU_Y_7IgNx9Q-1
X-Mimecast-MFC-AGG-ID: pQB9cybpMrOU_Y_7IgNx9Q_1793295868
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5005A194511E; Thu, 29 Oct 2026 17:44:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8959F1803A60; Thu, 29 Oct 2026 17:44:22 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 5/8] hw/usb/redirect-server: Implement control transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261028034140.367393-6-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-6-jamin_lin@aspeedtech.com>
Date: Thu, 29 Oct 2026 21:44:07 +0400
Message-Id: <179329584773.3884549.9541872438001832575.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=120;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jmziiGCgXfvYdHCHF4hXkvrBjvqE0xJfhlIG7lasPPE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq44XriXxiZJQRMyHa9ObHRq+QEpMXx5FLaWhO6
 U61nXiT2+iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauOF6wAKCRDa6OEJdZac
 5TvnEACTKW/Q9ZjgOb6PLdi7/cBceTEfrgg8zuShi1DfgVV3VFE2xpz5UREU7UKcAtUqfXzlB+l
 w27DTFnyIFCb4o1aQdqBRugkOMWAWzn7PT3fE/O5Vk6duNQaB2Gf06DRK3LDOhbxKd2t7GfwiAE
 FEuKxiJ4DBMhwwd2h7D3EeaJt2xyfx+ZZjMYwxFZPOjKGF5I6Q/oVJM4K7V4KzJVO55fwBjIDSg
 AGHdQy9B9e5Wla9IAdiPnUUSOUwtVlQTuFOJB/rsrp+AP1+LJdkzSHVK1Cbhr3bE+DO0lLNXD2C
 LlAU+pKN+uv2zPXDRr6+wwM+ah03WPvvUB9g1qW5rNv3ZML782l9vvb91s1b+L9hK7fzqZPKAUO
 Xh+V6nWs0jBO7WWEdApNaDDycetduH3ICijWD9KKtrxpx5vtjY8lEuPzll+D+mwtYFiQckgCXyh
 g81a7KVjhT4K/ZSNx4SsG3PXyftATArUAvLleu5CtuSGh9v8pePTub8XmGbwc+Itkbul34bPzDx
 iKv/w5YTl+OZekU2j5VLwVaSLd3okF2GX9l09VoWSuCzPgIdFVSSXfO4UcdPzlZpZjQ/WnQhcIm
 SuRDYUKE8lWvxeZTY9lrkbXuc6XKuIXJBHAfQ3ayz+P7kUcyNDaPCmQtKOHa2imSRinZOBhrbc4
 610Wk9CZI/rVJ8g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


