Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55501CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHj-0007BG-QI; Wed, 10 Jun 2026 17:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHe-0006Zr-OB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHd-0007Bb-4X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CidYqj4b6Ame++OrGun64f3R7YksnIEmVscAp/ONz90=;
 b=KKuQUDP9hfNWT9RV4RDbLFXp5eeh7VOcc+z6FSz36nOQpHD6aefT8BkxCx2vGfeZDVYY1i
 ZnUO6qDVl2hrT7bVI54ddMvP3tgcx4HAdDV4Fxwgv8cxAvFkEyiPh3ZQ85tcXkVGiYtnAg
 2AYW+Vg3DzNnwgcTiAw8gtHFlAWZuTk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139--79fWI3xOuug6U8B7r5lrQ-1; Wed,
 10 Jun 2026 17:16:17 -0400
X-MC-Unique: -79fWI3xOuug6U8B7r5lrQ-1
X-Mimecast-MFC-AGG-ID: -79fWI3xOuug6U8B7r5lrQ_1781126175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3823195DE23; Wed, 10 Jun 2026 21:16:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B34A23008B35; Wed, 10 Jun 2026 21:16:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 27/35] monitor: implement support for deleting QMP
 objects
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
In-Reply-To: <20260610123415.2883603-28-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-28-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600389.209622.8962131616398640378.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=891;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CxB+9ohdoT9ilgWLIgorQ5BfdgB1sRHpk/QWl4M3u0Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOEe0h4rbqrxAVOJ/gUfhr2XxQntpAfUNaJc
 21UO4Nw6JWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThAAKCRDa6OEJdZac
 5RxKD/4/j2kd7eTMH43YlyehEH5VaxyFrfLXZoDCMVmAeJglo8A8/u8/kQiFJmE1VYgwA18uG4e
 wSB0Unpgl9YcBc8txD5LKNUpK7fAZemE+OWcxTwyREv8QB8RMuxzcxJacG6aSDTWE4dZe7BaDwk
 tKLPhZBJ2LocJj1Rw9bcdQ235uvnz0EyHrgDcOqVSR71xFVyYzVXDKMomFqk6CdfCk8aP1yGvsl
 haH/U9f2jhEE81AdtGhpQPFxa/nM0WR0ylrkAYkiihJ/dDjPuXGKlXCrdYk+59tS+KFr18ikJou
 Rr88tZ7yIPgsOsjkigdm88WoaVUIWj/sIG0R53mfIjCSKvy2HTIxXX4Dpibu4UmXujmmgVbM/mG
 N7HO87TjiPApKxks4TL6EbM5fh9oLNJWtHPwwaYwR12Iac6BojSDxB5C96o0QpHiOxsBFj6a0/A
 B8zHXkMBlZFYyzkUOKc0ST9oceU4z151VkFJ7fV/IExMFF2zdXAT7YyXwBcj2pT8DBF8ejvov9K
 9HEcs0HWWV/M3j75X4xz5xm7VBxujk53Reu8j5jTH8Shje+TQ/0i9lwmDCftkTp6i0BfRUlhVNZ
 E/gVdsqHV1Fn5ZfDmEo0DwX8i04EDceHHYZR9/SaFE0EqWWFrKMzCcAig/wjPO3lvAX0eqDtu3Z
 cDj9mLkIOg00u9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, 10 Jun 2026 13:34:07 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index a82e1aacb61..2e8e5ec721e 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -134,6 +134,7 @@ struct Monitor {
>      char *chardev_id;
>      CharFrontend chr;
>      int suspend_cnt;            /* Needs to be accessed atomically */
> +    bool dead;                  /* awaiting drain after monitor-remove */

I haven't looked into the details, but 'dead' is never read here, ..

> @@ -178,6 +179,7 @@ struct MonitorQMP {
>      Monitor parent_obj;
>      JSONMessageParser parser;
>      bool pretty;
> +    bool setup_pending; /* iothread BH has not yet set up chardev handlers */

and 'setup_pending' is never set.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


