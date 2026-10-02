Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70943CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgza-0004Wu-R4; Fri, 02 Oct 2026 13:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxR-00008a-SP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxP-0003bL-Hk
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/uj6QtTGbG8wlVOQwgZObmAkOhqUVZBsFUfwWSlAvg=;
 b=LPC0kujKl1gYiTtozs+6iLTe2JZjK91TWOrku3nhGmW4Fb6Xs8OWxwAPlE9t4Pajrtx7l0
 hDp1nywKy8oXwD0LeAC6Dop6HO4sWghvgwZiMqCxA2V0uSxMTSHlXeCWvOtFoECCFCh9Xu
 LG2xiQ4wRNeX0NFgGL9kzzJ1BH5tW0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-EaRmABzaMOWtSEBiUtjpPQ-1; Fri,
 02 Oct 2026 13:21:59 -0400
X-MC-Unique: EaRmABzaMOWtSEBiUtjpPQ-1
X-Mimecast-MFC-AGG-ID: EaRmABzaMOWtSEBiUtjpPQ_1790961718
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CD8C1955F11; Fri,  2 Oct 2026 17:21:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CF991800351; Fri,  2 Oct 2026 17:21:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 14/28] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-15-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-15-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166122.3025252.10335557019299370237.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=374;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kUpbm6Ni0vdDYzpLnvqSHByQqKV0BEAQE3Hpa670dzw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCTW6VD+8g/Vv93u/oC4SiZb6u98W752kHJ
 He+BhxwBquJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5WLZD/9tGW+SDAa1j6P1JeoqOEPRqErAuWYA+JTAgh/zALUXnfIIV+ZPo3qA74IqW/ZtzqvyYZk
 3Qrtqg8uixnHJ+VSiT9CKt43uQNFMcr3XAcvU1FUvLNrP9pr6pzP899V2TnKj3U9sq1D/QnpIjg
 qohw7Hi9qQLefaxYXOIdRqfItSmiZsqFNFsHWE17P8qINAPkp1kwZ7kbxdMTS9pjQWFsb4v6Un8
 nSASS12yJlw3auSjTqs9S7MkqzBiTr20HnMHOi+lfD0j9wP5QX3SRo+LuDOskVJQOS8+aqYv+C2
 NtuqHZUW/dFH+QFoOv3oznkNC3n+UUXeHXYZGxEsEED3XuG0XHh6+rjYSRQ5KPPpK3l9dE+ralB
 vZ9Zji3fkGlpm+DdfvTF7bj7V3sKLdw6eyZPB0WZbJrgdV9CBXXB8+XN2wy77HzNPv19BjXzr70
 UzVEETkJhXuXYfh/waCY/xWN2gzlXIihfr+tbjNQ40rLwY/8ctc0WuRU8NZy4X9S9iaSbYz3ofs
 dworsje8jTh1IkB1bSKyFCS6Asq8pJxZj1rYx3l/UB4O+h8nB5j1cNI5nROjbzhLlHplvOsUytj
 2uvMZhuuusknc7eGPUKK/Kz3QYQy4Il1cvznzOLlHyGIYd56qOr5KX555Taqg6HYhRg8Mud83cN
 onjAFgUIMMJXwzA==
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

On Fri, 11 Sep 2026 15:36:13 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These have a long history of usage in virtualization scenarios on
> x86, for OS which lack modern virtio drivers for storage, and thus
> must be considered secure.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


