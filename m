Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40929CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzl-0005Tu-8K; Fri, 02 Oct 2026 13:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgy3-0000Wr-1J
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxp-0003l6-1q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ9t2YOOebL6cB98bzzlqu70Uno91Rp50azC77ksw0k=;
 b=TQaJtIVoGgVKFUzvNIM28V3X8++NRvYome7psDUVxd9QtbG8uKD2gunMPwvkz8aKSG7rJk
 g8EIy0IjpNiotTbVOyV4jWuMv0k67JTC2HBZ93h2fszP8E6XrXEfvk5CBQ6tTKlZuO0r1U
 ykWs1AGJp6uj6yNl5QRxSOgIxfSutWs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-vs1CX2kXMLiBxPQbEb8Dtw-1; Fri,
 02 Oct 2026 13:22:23 -0400
X-MC-Unique: vs1CX2kXMLiBxPQbEb8Dtw-1
X-Mimecast-MFC-AGG-ID: vs1CX2kXMLiBxPQbEb8Dtw_1790961741
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B72991955F2B; Fri,  2 Oct 2026 17:22:21 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D057130000E4; Fri,  2 Oct 2026 17:22:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 21/28] hw/char: mark common serial / console devicess a
 secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-22-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-22-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166131.3025252.15804110579226789174.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=309;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3i625zs0zRqrDOwzUvcSLrcAcxtVCD3LCYZXUCFhaWI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCZ083AgK4//+Yw4uwWOXwBw2gUcDMAUlT2
 AOhv5khVMiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5eQ5EACPW0m2YqQZqCJiSd0Plfmrpe16ta6hZ6NP+BOqb+MMUPZ+nvN2BMw82h/ygGFCpACXqYl
 /0JhvhMFriK+eVh4k1hFjrRyfc4iMor6JhMpAhGdE+AKHjGXSR+Qq+oW/kABKKuNy1nDT84U16l
 94pUSmKIdsN/FE5cEB1c+LCz5TU1ST9kkdmjcurECOTl/Ncl6L7uuLtE80NLjkBQEek1/+AZGO7
 5UXgzrIztDpJkGEtQNcgRhwBXC2e/wYSv0G7XFHvnHA/unl8VjGReVBmQvFblzkae8erW/KEhkj
 Hp9/vcFQVMooRpo9zJc6D4fk4kXIzik4b/UT7UxvTuDcht4BrpYDkZaFeoOW08qOMgmtwX+VGyy
 J5vRyI6/Nwn5fDOyyQLbc5d4OzStMa/G66w9fOI7vfCsC+EEjI3mB86/mMi3+U4lbb1Tl0yDyca
 j6l4mRaJvK33tWPhtHQQqsKXHxVOHw1Fum49uk6eZr8BPKgJgFly6aLPjXy0Oel7V5YtCKMLLkl
 ou2ALD2sikLZLHp0X99JxkCyHhyMaGQkHqt8wedbW+Ad3c4DqjNfDKVU3beEwHSUAtuEMFw65cT
 Q8iIIcNPUo59m6dCEe6B0tYPA25oRhLodevLhlYdQM3AZECgLHchSn2R63yAzZFQWNEDcf4NdX7
 xCmFqJkto4MX9FA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Fri, 11 Sep 2026 15:36:20 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> These are needed as a baseline feature for many virtualization use
> cases on x86, PPC64 and s390x.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


