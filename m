Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F93CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCqu-0008LN-2O; Mon, 12 Oct 2026 06:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqd-0008JY-34
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqb-0001an-5d
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NgcmBD/bL+V8EjyCp92u62sKVnVWXEGGSokH6CcobU=;
 b=ErS8IM9TLrzdybu8Jvj7orGJYdi42rlQa0hiZlsukmPgk1Gz9ep1RMglAJgHWOJq7heTVt
 KF20wc4Uxn5oHnHTqkfC2gT2k9m/9/Mr65cUeD0ZxBLlXxrXCktg1ItPELAuHYvurETQxa
 G17PH9pCHxzsWekzjTA3YU67Ax8dH1Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-eoI6tAkpM_yj-zSvtyZHlw-1; Mon,
 12 Oct 2026 10:01:22 +0000
X-MC-Unique: eoI6tAkpM_yj-zSvtyZHlw-1
X-Mimecast-MFC-AGG-ID: eoI6tAkpM_yj-zSvtyZHlw_1791799281
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADD91195BDFE; Mon, 12 Oct 2026 10:01:19 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 925E61955F73; Mon, 12 Oct 2026 10:01:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/8] hw/usb/redirect-server: Add a usbredir server
 device
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-3-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
 <20261012021634.2006424-3-jamin_lin@aspeedtech.com>
Date: Mon, 12 Oct 2026 14:01:11 +0400
Message-Id: <179179927143.1642373.5714306428472142574.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=610;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oomY2FdthtOx3LeQd3wPN4ncpU4G1vEaHqCTcJdXk1I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzK/oZk8y3OJvf0GAwvGcpc0G49b+IT1QlCTMc
 NDlIq/6ivWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasyv6AAKCRDa6OEJdZac
 5ReTD/4sxs2a86NQowu0bfRcNgCqHT4kp9HNen6CcnalZbI7Erv9asoMox6cXfwBzMQV9NDKWrz
 flEh/ATWVR5xTq84Z5jTGuui8IeCLjlJDrJg3LU/Y67vx/sr0FSKLlX31HW28kVrkisWe3ypqoL
 4G9A/2unL200KU9IVGYkqojsFYCd8R6gb97Ot/OpGfCTVzUDKKBn8n7FUm5PA8kje/WxbUlteAD
 ednbitbVS5paf2O7AU++DKXPs31iy2VsxXBFh5LEsDEVWBuaz1nTMx/bT+1YCMpaZqf5HE/870U
 TViwFmAqEWvxhy2bve8O6YWlLyKsDm/fiMOaF0it2M5CEPROnTKVGY9kErIL0UN+UsO64EKKc1n
 /RGzxIs7QDbZ24twVsnB6myhyfLepD2jqcLSovLPv85D//5xixrL1Ef5RILTsa1+C9Na4ZLmR6Z
 sQy0OwPM2DgsxcG135cGtnUAKNZ1o345awjJ+tUtH0AkC/whuEtAFqL0DJsPVRqpH3UR1ibvMLy
 Mz3LHdsURHVnteMDGnXbtB5sL8Zj8XblytThCpovuiDn2rWNJz0+JavkhaPkGMKHwz5+hkYzq9n
 ujOdUd+BYGcHrkuvkZBtNrJMKjazQa8rBG18VN31fjowA24WdXohi+R9sRHWaLATfkA3R3ytJY2
 wykR8mKfsQpWVVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, 12 Oct 2026 02:16:37 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Add "x-usb-redir-server". It exports a USB device from this QEMU to a
> USB host in another QEMU, using the usbredir protocol. The other side is
> the existing "usb-redir" device.
> 
> The name has an "x-" prefix because the device is experimental. It has
> to sit on the sysbus so that qdev can find the USB bus it provides, and
> that may change later, so the name is not fixed yet.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


