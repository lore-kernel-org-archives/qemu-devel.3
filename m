Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A705ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCr0-0008Pr-Sm; Mon, 12 Oct 2026 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqt-0008Lx-Bb
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqr-0001dO-Qa
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zio4JvalMy2OeaFQWoIUBhQJ30vZf0WsQUTDb20jzA=;
 b=H8gQrutPa7fq0yeZLeeUF+jJaW19Sy5jl8SSvKscMXiCRnnsapLxxEoBLERaDlz5vOqN2U
 RQIo6lhwivn4/SDmOwWAayGJUlWV3A1riSNgj2Nd/G3sz0Bsmi+Tuo7gcHjfVixW91QW4I
 6n2voMHWnkFeM1SzyVX9a++5xDZFIuU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-OdZMbbjRNwKG3b5h2RE8mg-1; Mon,
 12 Oct 2026 10:01:41 +0000
X-MC-Unique: OdZMbbjRNwKG3b5h2RE8mg-1
X-Mimecast-MFC-AGG-ID: OdZMbbjRNwKG3b5h2RE8mg_1791799299
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30C1F18512C0; Mon, 12 Oct 2026 10:01:36 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0ED55195608E; Mon, 12 Oct 2026 10:01:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
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
In-Reply-To: <20261012021634.2006424-8-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
 <20261012021634.2006424-8-jamin_lin@aspeedtech.com>
Date: Mon, 12 Oct 2026 14:01:11 +0400
Message-Id: <179179927148.1642373.12767301126353819945.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=768;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=G2Ce4hr+XtMhh23mkACwuk6Ug5HQMtEy2Dk219Sd6qY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzK/pn8OKvsf+Mt5M1nRufvcX6xzPVp7o/qWxq
 JlMd6/YNLqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasyv6QAKCRDa6OEJdZac
 5dLnD/9iXyeT8vTFZVJqfogWeX59Rk0wOQFugCUEF/bbpR1uZ9TRxtSs6ZoAODhReff/bjrOL1+
 yamijSbEmOkHthYxHKxI/vzopvgm3fOM08P2JmQ3VSOfYBRJWWRUg4/CM+DDiUC7MOaw9OoF10o
 +/Gk3+AOf0fEyjWxqEZp+UIqZdUTFI1FkR/wHTdXPskEnqNvdrOZnBvV5q05Af2aJsUMTBgDrdT
 VD/Km6+x9yA+vnfEHG2/zPjKepkSS3LCzc+Zl3uuMcL6HTSAaYwUuNd57gchq/y3MWxn5EfmHY4
 +S4iC04ghcIKzfidwVaLPQvzdFIvePFHtbpn4Pa0Z5c6VDozMO5Lhpg2xh/s88emCPSrrAoBmII
 KaX4e4yCqZgeii+A/aDiyn/bsnbxJ+5sxVlA19Q9Qc49w9+rEwEQATvYe2cskuc9nHpCyMCDwBs
 6+nDDtfglHdGauRpHmfE4bq0cGC+qdNy+GleIWAGw2zRWmp5K5/MJpz2Rq0XpWwAPya9RUhRY78
 K57VLq22M+jWJNc/qUZsWoR1ghwR16cYHr2zf/9TJ/NpkCoxIP9vUmT/msrl4ZGBfBKGUEDEkPu
 dQKZMzdVhdy2KsgifsrYKTUAj6bMud1BoJFyLBuEuTt/pU5xtZPHZ3w3jYxstXesmGadQkfnLjD
 PURIAEAMmgIFmng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Mon, 12 Oct 2026 02:16:43 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Interrupt IN is not a request and an answer in usbredir. The host asks
> once with start_interrupt_receiving. After that it expects a packet
> every time the device has data.
> 
> Park one IN packet on the device for each streaming endpoint. A device
> that answers USB_RET_ASYNC holds the packet and completes it when it
> has data. A device that answers USB_RET_NAK gives the packet back at
> once, so park a new one when the bus reports a wakeup on that endpoint.
> A slow timer parks one too, for a device that does not report a wakeup.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


