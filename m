Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8D4CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCr1-0008QO-Ia; Mon, 12 Oct 2026 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqy-0008Od-SC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGCqw-0001e4-6i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBOGrkZWmPIb0gE0hvVFs2KOTYXgyxdbynVosJ+f0P0=;
 b=jAbxq11o7dOdzd4QU+PMhjZrS6KCWEjSTqC3qkHjl41HVA5pdX9mmGi8ee/xi7t5T1sr2y
 aQkhOmctPiQvZXE1vtI1joQaUynhZsivQEYQXftLjC5PNTh1G9OuBMujtfBAJr8GsFve4u
 xym8mx+DBDA0rbL5Ku3jKddaRVkU9O0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-ns3R8ml7OMag4gCxjFB2Pw-1; Mon,
 12 Oct 2026 10:01:46 +0000
X-MC-Unique: ns3R8ml7OMag4gCxjFB2Pw-1
X-Mimecast-MFC-AGG-ID: ns3R8ml7OMag4gCxjFB2Pw_1791799304
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52B57195FD26; Mon, 12 Oct 2026 10:01:40 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF08A426; Mon, 12 Oct 2026 10:01:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 8/8] hw/arm/aspeed: Enable the usbredir server transport
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
In-Reply-To: <20261012021634.2006424-9-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
 <20261012021634.2006424-9-jamin_lin@aspeedtech.com>
Date: Mon, 12 Oct 2026 14:01:11 +0400
Message-Id: <179179927149.1642373.4444155646101667783.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=719;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DnepAXZQSu5awt5j5DCQGL6l7O/6ALwBqetC+Nj0D/0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzK/q9J04icrUGacUA3QSC+hHDcgCvftYCiuUC
 XhqzCoQVKqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasyv6gAKCRDa6OEJdZac
 5T4PEAC0Z4UEE2TWQzEQIGI14v30kuWBSQLYLGSVThWx0VDySHI36MBLoJH6a4X0Zs+9BfcauDs
 G5bhi0z60ErhqfZahvSSUAUGvoBy2YoSgMmhtcAB60WK44uGDIsExFMmLH/yeSLqsR8I5wY8NqV
 3a0HbWsYJeqrvXrkgvPQEoYDlOp+VmLB798QPLjDOzZzGQtwfJOHmmeQATSLaVscvng0iWvHq8w
 qOZ/YUSMnrE3SuI4FS3H7523cuxefrbv1zMgMmHmOaIdscSlb44oDdbNj0xcR06Q1P+Ee2GHmqy
 LRINMKhEfGFUlFyVL3NNzFi8/pPl/lDDvuXtdL+sUVAOry/sKq1bnlKPe3melU8ZiUxii0Z8Ukm
 UB6t1s8RKwqvutWNzr4pfAxumhVHXgSvGyiBUuXe7phgXD82RyYSuqcx4rjtBh9mn+wcyN9Iei4
 sBXaZM2LIRmqbsZfbjDjoDEHEH8hsP7thZWFF/O5kZHCikZL3vwwY21NOGc+u20F+ghxB4M8GVe
 qxLDoe/lhmYSyYj2kRKfWKXrZq+ZLsM0SVFfZQ8PKb628MWjnamfA0tk07ZdrZ0JeEfdUuJK0W+
 +UxaZ3dfn2+9ryQelhCy7k1jpExrCJ3bAJyo8meTA9w30N8MSoRWdlCOpCKgGH4sMQc0Xu4B08S
 h5F/kBYV/2w3A1A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, 12 Oct 2026 02:16:45 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Let the ASPEED machines accept "x-usb-redir-server" with -device, so a
> UDC gadget can be exported to a USB host running in another QEMU:
> 
>   -device x-usb-redir-server,id=redirsrv,chardev=<chr>
>   -device aspeed.udc-gadget,bus=redirsrv.0,udc=/machine/soc/udc
> 
> x-usb-redir-server sits on the main system bus so that the USB bus it
> provides can be found by "bus=<id>.0". That makes it a sysbus device, and
> a sysbus device can only be created with -device if the machine lists it.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


