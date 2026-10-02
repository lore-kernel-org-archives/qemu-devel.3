Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08875CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzp-0005vp-Gv; Fri, 02 Oct 2026 13:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy3-0000X9-1Y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxu-0003mP-Bt
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOriw+LghHj9+vMG1cT3+MK/B4WqYAF6qOuDOKE7MfI=;
 b=RvGYtMN4U7EmW32pnmj1Lw77DoTGftyZmJ/wAN0DE2BXJ9xyPpzDW596wPkWVXSoRbGbno
 MZeBGhqvskFiLlELTDi3HD7K8PPoYKb1p6DYmUBvcdH3m13U/jWz+/5QwLvL1dI5kuqES6
 TpgX97JgIRwKNtKEHRqcbvp/7AhuMBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-S7z4tXkPNrmfa_jO6cqFpg-1; Fri,
 02 Oct 2026 13:22:29 -0400
X-MC-Unique: S7z4tXkPNrmfa_jO6cqFpg-1
X-Mimecast-MFC-AGG-ID: S7z4tXkPNrmfa_jO6cqFpg_1790961748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EAAB1955EAB; Fri,  2 Oct 2026 17:22:28 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4375B180049F; Fri,  2 Oct 2026 17:22:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 23/28] hw/uefi: mark the EFI vars service as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-24-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-24-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166134.3025252.936615391375619409.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=293;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M37xF/NbMOdOpLB4jOwsy1nFVdoOjkEEGL3m01AKXQM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCiEK0jUwP3HNtqom6v+0KbBo/5lzpS2K3m
 G5wgXBxj7+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5f8dEACLQMHp121WvdYZRzZAYUqu/4KkuUD3HC9jtzTBEZgO+bBgV73vMY2KYCFE9Elvfdq508C
 NJt5HCLiXMvWtkUw6ZAjVr+nC9qNuWkgCYLsHNVHw6pIvSEKTH8RKcEouv7IRt2uEeN/A1pZChB
 TEPmNiYUEbf0VSYZclwdUZvfE91Bz3FuhjefZJjIgdPev3hkNyefq7PB6oD5GKLElm9gbsk0e78
 hdQ1Ye3C5sYMN9hDBT1QPmewH34x4+uRV8q/UTfzB4bJ1Tf9xWd2iRhKSaoxB4hXfocWtjxGGnw
 y+CqT9va0jaV2h8g3MYQETz5xQeUgmWCs9InMpHkzTQXW5XCjJZV2sz6w4ezQVrrrNJK9keUZdm
 NJ13a4PN2VQyen15XCiSs9aNtUaHuhmmtCp1ZZTllFeo1bfB5Vxwm5Ta0ws5iflDlJTkXmJ/Goz
 RT+qXnNYnEU4S2H4q0LMrcdO1jFq5eiBIOEjdaGHci47P/jpP6yZqTDsK4z8zlhvV1jljs695zS
 zaIlUoHOL9n+LZODwU+j6wXPceWZ8OIyExYzZafsoa6gK4rQ9dBe24N846ewMeBVaP8+vFJ2/PB
 rUEnroF+q1uqP34MpXhws02i6JcALcCNoF/FomRJgoyDFQOGLZwI7AhkDdnYCVZjU6WDzjpOwZ/
 SbTbn/tVwmvy4nw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
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

On Fri, 11 Sep 2026 15:36:22 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This is used to persist EFI variables when NVRAM is not available
> or undesirable.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


