Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3430ECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCqv-0008MN-UP; Mon, 12 Oct 2026 06:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqe-0008Jd-EZ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqc-0001b5-IY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gz7D96JRSsL1D/0RjiymvYm78Aa9cK7eXxPUGELstz0=;
 b=F26OIZVJHQGjU7y0uEK+vYeLwGpUY3EVqJ8Nk4TCddvbNeWsJeqyQzoxBItq3O2XqCi10P
 Gl3Gc3XWMgJeyZf23IDvpKxe598Y2K4Vm6orta8iOA+gkM2fw2sb5zlwtopCs+9E0k/gW/
 fTQQITYbvJOVJggcjxsc2PbfCNSu+Lk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-hTrexPuXOOCQFHzq03KrQg-1; Mon,
 12 Oct 2026 10:01:27 +0000
X-MC-Unique: hTrexPuXOOCQFHzq03KrQg-1
X-Mimecast-MFC-AGG-ID: hTrexPuXOOCQFHzq03KrQg_1791799284
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 132C51828B0E; Mon, 12 Oct 2026 10:01:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61EBF18002B7; Mon, 12 Oct 2026 10:01:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 4/8] hw/usb/redirect-server: Announce the exported
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
In-Reply-To: <20261012021634.2006424-5-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
 <20261012021634.2006424-5-jamin_lin@aspeedtech.com>
Date: Mon, 12 Oct 2026 14:01:11 +0400
Message-Id: <179179927145.1642373.4953023747837753145.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=624;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HciilUiKELjZXH+HdLtu5IhMA8l//bfbU8a13WYRWOI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzK/p9DqfCBQndUPaqzdB26LtaIO0AN3wX1IvQ
 0bhCD/tygaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasyv6QAKCRDa6OEJdZac
 5e/vEACw5ChstX+ZnLYbuiuGjy5qGWD90DZZ9nSCkiX0Ara4yBxaYr3pGDXeFWpJjBd3dJBUatB
 a82TQhr0nl+WLvVUeB4v9yP3Ak+1YZGd9b2BwAWBTBM+Elpt1AsOoa1M5m7DbPrKVk/Jxt2DZWP
 KiYQVe5WWjmzcPOReH0Ve6N2BTYQlZzFdn0WMA+UVIl9/oMVZGHXZxq/ONQQWx4j7wlLJp43lEB
 hLFM7wRHTxz9vFaZytZkFB3tQtRuHKciQFnYxdI46VSUZtgHx3rnAxs/ZpEukame3H40ws5YpS7
 UQkwc6r2Ng9wTD7mkMXghyYuo6TBdld4iF9qbUmAM7H+mGa4Dz417pL5qoH+dN5Oc7TTqNeyPvP
 tKNvkC9rJuwowK5BY7k0kvABptPvHzIN10GE0/HMHlFkj7Q7olDfrEa3l7ZqHF8dzdM5/PJ988O
 z5PtEa3a0jNpMJh3HOUexEp8xyFWOeM995O1LjqlrIsgx4Y0oQ4rnfsNXuFbcwX0+n0Spsck6Mt
 X+oqVT2HiskNfQlK4AM4turYCnm5RDddMC8sAbOpCLLJBtoyZke4/AQmNsZ/Q+G98jXKTI9fMeY
 3zGgYUK8ACC/HY/udEpx0RRnfNG092TV4pCH/xo4FkkUNS8NblJMjdnhRwwR4WmUo4thpCtzmFv
 htW8GR9IJ2x7pSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 12 Oct 2026 02:16:40 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Send device_connect when a device is attached and the host has greeted
> us, device_disconnect when it goes away, and handle the bus reset the
> host sends before enumerating.
> 
> device_connect carries no identity. The peer asks the device itself with
> GET_DESCRIPTOR as soon as it enumerates, so anything we put there would
> be made up. The speed is real: it comes from the device on our port.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


