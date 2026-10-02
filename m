Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCC1CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzj-0005CA-82; Fri, 02 Oct 2026 13:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy4-0000Xi-Mc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy3-0003p4-ES
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGXglyin6o1YnCJq2kD2rscpcytOiPmgHEZgX3OWp/4=;
 b=ZWutAj3YFXDC+19z1ZjXspPtcXTIQRNKzkfYRJ6uv3wgvrEvOPInApjQDYcaBfhb1HSg2d
 Pdb7uai/g6x+SG+7YmcmkDCp4PAMu4KpsxBWeREqNZ0kdRCJK1TPrIVxjj/UkzEqOdtr7d
 eKHjd233ODi81NfIWQ89ZX+pTObHlTM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-9QrLD9LIMqGfKHUCbjL-1g-1; Fri,
 02 Oct 2026 13:22:39 -0400
X-MC-Unique: 9QrLD9LIMqGfKHUCbjL-1g-1
X-Mimecast-MFC-AGG-ID: 9QrLD9LIMqGfKHUCbjL-1g_1790961758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38F7C1954121; Fri,  2 Oct 2026 17:22:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CE321800351; Fri,  2 Oct 2026 17:22:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 26/28] hw: device AMD, Intel and ARM IOMMUs as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-27-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-27-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166136.3025252.292036806890302152.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=336;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2w47OdY8X64cy6/RH7KGYjLAQjIW5+wbMAeD8NQNfd0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCGnd+3y0WJKj+OVcxuNWalsPpltzlw8Ly7
 LD1wvDwz5yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5SCED/sG8OtKpP2uG4CPl9svS/RoUQ+uIVmWcP1bOuuqWnuuATHdZ3yt06+9qgQLzqx3LG5S7Tn
 c3D/0yUpkLQJpLN/LzPfvVqPDdMPTFnEsefZ4oA+8VhBEE0kcyRhps1+E7uWF7GtOZoK7YZ6VPA
 PjUXDMLZFZf5v5O6/jEBCinlHKn73oIrgO+iCTGEWpMzZEkmEZHXHFOwMd0x+zyA5lPWX5W8tnE
 /x2wXAwufP57iXtPtd8sSuEjBgo1QA/nXSRSUH0ZE69B4BegRm7t5bfF+dhM9cl7ljHr4Sz+J1X
 fXWHCamFfajkPiFrejzV3pXuWP+N0xvfFraaTzACqXAnjj5MJQ+Sx7eYNn8uTHfrhdlJ58qeT9d
 HSzzYalFie75frQMdbaKOAVSOntH0ATLeyLHKgo54Xt7Q4Cpp0rR8KKPRUMsQ+nQwaGXlvmT+0K
 vyOqA+RA6M7SSM7Vl34lMlFVOfQpx+o7o5She3uI535o/qo5AQ+eWu678uEyTWN/PTr5vwOQred
 WRi5q/Uf95+3y0lRd2gi5QGNwrr0iBoNiIhKuq29YQgAONM1XFp5VoWy5966Qx7rxYMMdmOgdVj
 HxtrjoYwBwFcG6aYdy7lwbvUk2SGBybIWIfB7fUfHW3BlIoxZbMiXvRZtELA6l4tAgfk5b4kW38
 XH5VeP5KWbf9MrA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Fri, 11 Sep 2026 15:36:25 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These are needed in virtualization use cases to support PCI device
> assignment use cases so must provide a security boundary.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


