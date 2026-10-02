Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A30CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzr-00062C-Es; Fri, 02 Oct 2026 13:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy3-0000X4-2U
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxr-0003lM-Jq
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fak4bGxidLKDm8+4zf2stLqtEk3iS7PCah1litKSQk0=;
 b=end5DjTv/2M28ZHJiWM+r/nI/A6ywhUORnqO8gwwuE4H+7VS2DWCXV5e8xg9Qn5i/Tvv8s
 q2LbzAPszXTiRiANHpf70wK0XoFVIk8AYZeZImsF8fBibDE/Lw/KDq/Jxam4zjFkc+SC9z
 CI83FQn4YNTEXOQxXn64cOj00mECcNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-LC704IdPMLqkiaegcC1f5g-1; Fri,
 02 Oct 2026 13:22:26 -0400
X-MC-Unique: LC704IdPMLqkiaegcC1f5g-1
X-Mimecast-MFC-AGG-ID: LC704IdPMLqkiaegcC1f5g_1790961745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 064DE1954121; Fri,  2 Oct 2026 17:22:25 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39B3F1800351; Fri,  2 Oct 2026 17:22:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 22/28] hw/mem: mark nvdimm, pc-dimm & spapr-nvdimm
 devices as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-23-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-23-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166132.3025252.8374840789569151236.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+hBolatsDZQIj/Z0rZnIsFgzxbSxAAfLtca3N0SKnL8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCTxVY/NfEOmxEI5DosbXgWeTaDwYFNy5pJ
 JpMRccDkcCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5Y4RD/90mrXaHjotyW/NycDhxtaRk30LLlthREYNx5Jr1HC5CDTTPW+Z3mU4AXOB8MpD1nllw/a
 6HxtrcjZExMg4B47l/yLIV8kBUiPH3oCfVor07tirbl8CRQ4xVx9NMbArqYJX+/PE8wXp2ljdto
 xDn/uw/804gJhFQ5aBKHx5qOIVgYCXWCX5jqHRkp4crJIq+N75NB4eWQ9dDN1eKSUn0ElqrIR/S
 b9tVv+FNphFso+vxbZQdytykHGA/tu22KGueOTGHnxX9zqkfELsjsfxykF21dtGQGPCz0G0Xd4I
 5j9cOEfIzMUH5vDutkcLYT1WrsS2PSBlUIMl0yTbvYH/Z3zHHVsg0ozvyO32qHPdKBg96yl8cHD
 ia6b1RQhC5M0bJ/5l9tzmqlDp93m0st3160yd4LndN4eVOAlFxCAO7wyZJ+qOuH2cP+F3rtbyvo
 81qylevm4jxouDm29zISR6vj78IcU0krAmhgqaui2iEUIavvUcahORbN+brJ2qxuYNP7w4bA4rM
 64OIyI25+61AfDpXXvnckQ0+udHRSLmNPXQa4mTRSseJUI3Lq+uff3YDhtJ9K2gGEihB4v8FD2j
 gtWWpYgSDfmCWVDuGo2QsyCtMtaSzoVqJk3pK6KrRkSwDbtG2EEdMN3QX5mStbaZpL7dTmTL8SS
 K0NstiiLHtfkyHg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:21 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These devices are used in virutalization scenarios to support memory
> hotplug and other uses cases.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


