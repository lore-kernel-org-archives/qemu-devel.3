Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A938BCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFU-0002sQ-Tt; Wed, 10 Jun 2026 17:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFS-0002rh-Re
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFR-0005eu-Iw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tr/Qdlpbq2OhkDVmusrE/rdCQYnn5h1yhioBGGHsyVs=;
 b=ai223Nvii3t24Q7rVMhMqXJBHBmGrprOru5r+WaStiOjDO3geSVDz8ErS0WGv1P287eaZD
 dh08RpG2ay83XjMMZmSswJZZEQfx+uivkDk98XfhcrBypL2r2FZyK2qnvw+Jj2JL8nTQA8
 gh0BaOG9/IN4UqcG9qjG73yMPSJocsM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-dmiPcTDoPxWu7VrPrLzLKA-1; Wed,
 10 Jun 2026 17:14:00 -0400
X-MC-Unique: dmiPcTDoPxWu7VrPrLzLKA-1
X-Mimecast-MFC-AGG-ID: dmiPcTDoPxWu7VrPrLzLKA_1781126039
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B937187B9B0; Wed, 10 Jun 2026 21:13:58 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02F543008B36; Wed, 10 Jun 2026 21:13:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 02/35] monitor: replace 'common' with 'parent_obj'
 in MonitorHMP
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
In-Reply-To: <20260610123415.2883603-3-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-3-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600314.209622.13264922112336530941.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=305;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oPJKCPFyrmriMvXWNDDWtqP8viFwXYP/T+3QFUpMRgY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN9jJHDwPfMk+kKMs+NgoyUqSafAZq4Q6I4V
 Lic5mpAznKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfQAKCRDa6OEJdZac
 5UX2EACWPu6h0ijBgVhJzdbdwXrfaXxLmUvgvBz/cRvnm8RbiqeEW/IeGmDO4oNtJSuY8EG+lIT
 AOp2ZwwkH9dCpaopUAYLRYj4wec0W9c8hJtRWhijzd5frAfiWvn8zTIiC6Fq05Wn6lgDXSsRzYo
 S+oYd6Tp24fAYDNgafzfvvb8NTdo8V7f+0Y2l09/jQKMXssN3MN7X7vyr3JYnDSDfn0OMzWbk7J
 RFjoNTKxPs6JXE6TYCQ7AmhpHe6hQiFtwyj4YvzIuAvFPzF9guA2m7EmmAip9VtoX1I35xyuVuk
 Fyta5NTbpCgSkz+pHEnY7wZkrZ5G3yp3Y/CeoV/VzdxcgtHZg3nNP8OHkanMRxlI8PmiuSbFse6
 PXf1ADbJ3UnZBvKikyqjJV9hpqQHzZXiNR+1w3bFmdVwt8dpN0ovWdG4Yg6P0asVSl3cq+UTDbU
 txsr5Si8h14d6iGyRXKpOpdxEVcFuf2aixwU3vKKRirlgjCG5wPWkds8/wep3OUfDgAzZBgpWAj
 D1Tsw6UA1Zy0e+G7z62uPmGWOimnMn9p6szvsdd178Zy1aIlBf2P0wISgn5JXKP+0h6S7DhrCcz
 y4OB6KYhWfd2uQmyUcPu4Aq9WJ+85uoyfw7pIltxEVXGwgr/Qt6sMjyaLrsx7ug8ukoOOp8ORwy
 7CjKZFzOKGB51Tg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 10 Jun 2026 13:33:42 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The field name 'parent_obj' is standard practice for QOM structs
> so align the HMP monitor.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


