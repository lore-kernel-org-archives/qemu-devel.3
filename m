Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27572CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFc-0002uP-VH; Wed, 10 Jun 2026 17:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFb-0002uB-FD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFa-0005hC-4L
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/DUR5fcXyQAiSBUIyBsPyU7X27GhCv/IS5MQJ97hjY=;
 b=fjblcoMk78yWBg00Txi3k934bLVaLmeWISfMAxS7KPyFK6e/w9Xxhhx5KFeFI9AFPBNX6e
 Wcdnoh+b/BWkl2tr1GIR2eNObWZ1m3MVPVOX/6BQLh5yNz7wxiORtaO8eWUePls4zPC+XV
 CMJgFJLkBzJIB4KCzyvoUn1SXlSPnmw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-EXyQldqqMEeF_4EXmQvNhQ-1; Wed,
 10 Jun 2026 17:14:12 -0400
X-MC-Unique: EXyQldqqMEeF_4EXmQvNhQ-1
X-Mimecast-MFC-AGG-ID: EXyQldqqMEeF_4EXmQvNhQ_1781126051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E8719560B2; Wed, 10 Jun 2026 21:14:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E78241800591; Wed, 10 Jun 2026 21:14:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 04/35] monitor: rename monitor_init* to monitor_new*
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-5-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-5-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600319.209622.9959313235028011533.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=384;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TP9Hj47SB30J+n5KrbE2OSj2asTpc/BYoyspTeo37Sg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN9unahe1xbU+Zx7dxocM/5aXlueZQsy76G2
 HUH+Y9Xx0WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfQAKCRDa6OEJdZac
 5ducD/0WkVZOcioaQN3/UlgHLsP1mWbU+5EG8w7tOrX//qdU90xLyvTiim278NvORwBudBBCzLj
 nCbL5pVUdugVT61dLSXGEm1RrBGd/NLoA0jDHAPn/MjGsHf+tAg+K4cq/UIvM/BalEE82gETF1N
 clZzVMwebD7VnCdQs4JShZGQuPeP/kmYbF4mB9EBzEq4k/SThXWtdobwwR+YN/B3NiEGP1a7ISh
 onkbozg+wZaJDb2IPUHfaMkJQkMa0vgEFzB9pPObbqUDJLulAyQeJUyEiZHiLTcq5yVN9CwnG4q
 DQxKsr+I0gdMg62hfuCczfwR+q8ZnHQ0Jy60xlNXxD1d6nfKTRL5ct/YTMAVh7kqVO+2fXdlFfQ
 Wl/bDIepqVnRehj2zXXMf3s9SaQw+1+RUNwyYP7rR94+CLK0oi0j8tfGJVMhGgdmUvwcDY13Uwx
 2KuAJ1OW5hvBer5A7tjxzqPHtKi+jbk57ZPUEijKJvdWpSGTBt3S3ZQo4/oeMxRZsgUk/K3aI3R
 wShTZLsd10rk/YA60zKHYnOvEXx4C8zf0R9/EKvXthqhIM6WGrRAb08rXQ2ICCYP1r6/Bc33JOl
 8b/B587tMR5T/MJfEXhTAUHWlGrKIddXu/WZZ+9B2xN4/wUnGwM5O8D0jzmRuatXf1O8TYR0MZ5
 xU7PtL/xhLuH3sw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, 10 Jun 2026 13:33:44 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The current "monitor_init" functions will clash with the methods of the
> same name that are required by QOM. To ease the transition to QOM,
> rename them out of the way.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


