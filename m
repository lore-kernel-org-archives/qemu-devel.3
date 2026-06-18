Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14D7CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBKi-0000iG-Si; Thu, 18 Jun 2026 07:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKf-0000hm-2T
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKb-00013k-8w
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781783687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLskyZ9g8uCEvE5qWktWhS0RvoN/0qpVCu/5BraOSYc=;
 b=QyLl3iUnS0zWKSzvQBLFqnFbao9rpOGmfr1YhM8rF+YwMiqOrByZYzlKGmC0pdxPO6JtAT
 e68uHZS1zQ6jVQp92RRtPBRTPOI7FCNJOBKp4MFRgzWJb6D9YlSoSdx/u8+zTRget745EV
 6tn16gnIOLlhkwgPXcprykMuYi7qk68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-NaPGBSbpMy6UABDs4i64yQ-1; Thu,
 18 Jun 2026 07:54:42 -0400
X-MC-Unique: NaPGBSbpMy6UABDs4i64yQ-1
X-Mimecast-MFC-AGG-ID: NaPGBSbpMy6UABDs4i64yQ_1781783681
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30B8195608E; Thu, 18 Jun 2026 11:54:40 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 715651800480; Thu, 18 Jun 2026 11:54:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 06/35] monitor: add 'chardev' property to Monitor
 base class
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260618105836.991609-7-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-7-berrange@redhat.com>
Date: Thu, 18 Jun 2026 15:54:32 +0400
Message-Id: <178178367253.2477794.784690670232567415.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=292;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JqrHxPrdTTDYPumP98szX7tUuQQFjfvO3zNfldebU3U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqM9x7raxZOyLeM02WtwlqJKL1P0WqV/CF1oGix
 d9NZZsUXH+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajPcewAKCRDa6OEJdZac
 5fKnEAC4D6UVQakWHsIyWnmIwJmvQUk07B5wjwNtj49ZmPLOcnkkoc1yqoQnvBmP+TpSf5g0l8p
 Hmo/GFcyOH+ScvKZNZ+6YeeCIi0NeAm6wjkW7bcQf8DjX8HR8kNCKhqw4rumFqaRS+KbvVvdvPI
 NcLyXu9ikFaD8xVx8ZQCnrM9Eu7LdVwPD082X5z0e51GMiX0FbGyBU/FbvRRwxxufOab44c8jtS
 6mTfNp4gxYq/cfUkAxy77DaQ7Ng4zE/DPVes/3RINXKn5l3R6Xe+mZV2C9cHDssUxYLbtAaF9ii
 90JBIYs7PmkaILqE9NFP4yqbiRrL1sxDT7333jELZKsXELUV2RU9f184PbrpeN2kmaebkj1IFM0
 atx0EXXms5lrsLausnLN3Wcdo5+6UdQ0VjSEjHkhwaNpyV+b5zluCU3BY4d0Zx1kjv8/7eb4JbK
 3PHL+DJLFeFAy3H+o46bDiDLuUYpbL7XJiiKQBQoaPBXqc7TppbLCb8V6xELm6wHHrelQQAFwO9
 zFHlCBsUO+k/VmAXzM5EzZeCyjLtAdB5x6/wdkQRVlQM7H/vZMTVxKGSSyk5nyPgaTri7PGIAaA
 wYMp+2c5EzyyxUHJRp8LPHN6lyV+kcK/fu0dpxjkR+EiJkbob2Em8gqg5tbZm4heryUWJ/PoXuB
 1k/do9eP/Hi0ODw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, 18 Jun 2026 11:58:07 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This is associates both QMP and HMP monitors with a character
> device backend.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


