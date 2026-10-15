Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D87CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKNs-0000Lv-Ij; Thu, 15 Oct 2026 08:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHKNi-0000JY-Fm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHKNg-0004Nh-2P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydH8fUzF3EAiEsV16+flXTQSe1Z3R98cR3d+oDsZu3o=;
 b=aIvJL2SFdQQShNBT9cM/UxLTKQIg2foM84I/Us6JVjtAeiZJUFoWKK8TeD6n071RO+mBPW
 SI8gWjmNlQf/TK5PXaqahOc94p+rvmF5ggbvgxkEy+ozj2ml7leim1S0T8FAmaklVoi7FB
 T2VIvp3MGRqnBjltU1mvU5xxR5F7TI4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-FnUInRfxNsO6z9gwPiZQOw-1; Thu,
 15 Oct 2026 12:16:06 +0000
X-MC-Unique: FnUInRfxNsO6z9gwPiZQOw-1
X-Mimecast-MFC-AGG-ID: FnUInRfxNsO6z9gwPiZQOw_1792066565
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E3C11801369; Thu, 15 Oct 2026 12:16:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2161F7D9; Thu, 15 Oct 2026 12:16:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/21] system: move SIGBUS signal handling to signal.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20261015112044.1999748-3-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-3-berrange@redhat.com>
Date: Thu, 15 Oct 2026 16:15:52 +0400
Message-Id: <179206655289.744241.3664802622608820829.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=509;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4613oM12I2rmy/KRW1dOP6MrtzBfaaffwHCEsVxCff0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0MP9BV+yihFLrxCvYWq6mutmM45giMeBMh79E
 Qd0968OdMCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatDD/QAKCRDa6OEJdZac
 5W0sD/96MahjOuReoliPdBNyRHoIM4LjYsc10uGz6rAkIjhfayF+RxraN50TnwEdzv8aWM8CeNh
 bIyaM8CX7Z+a4/00owYxTphKKTOsaEoDeg4m8Tyh58f5QYhPVma5BtM1Kiy8zUSHq7y0IwHQK1/
 iTB+tUMeJnd8AJ2o3YtSKRd0SOjmGgdAmzIQTddoteQ23n+AuI59o7vlWWFpw4QKLTBxDNtxPyC
 Z8Hn/9NCj6Qkrg8J0W9cyCsKEoqzCllsu2jm4v96nVEcd0GU0txY0gZbacOva87gBpUUJUqEOQ3
 cyafbbUNBziI8fj+18sV8OvlKdvwsKWohlzVoVFOkUhQC1QqN/2HpDcIzXo2HPz6RG38uwcN486
 rNMX7Fr1YZU0dKQ97lEdK+sjhaWExgFaxw9P0jxb1FAfq8lJTmi8CywD5Z6w88Wf/kZuVR1oOrU
 BKPgAjRB0heathsyr0T57UMoZ9n3rBWJw6SqaOFuIHvJxOkrq9jY8zBgIHyM7UBsA92Q8SzKXU8
 PPzw3xy3NeGvXUSuQ0p2BVghytZfFw+Mz/XtzcKHD0Te8kh+iNsC+L4XZYzH5QSccYboS8lhKug
 2wjIqhDYparxqchL90eStLS1aXrTo9VeJp4R6roTduStAzLi3WUHU1T4z9znbB1R5I5woFFErpj
 ti/5BD2y1sXD0zg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Thu, 15 Oct 2026 12:20:25 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Introduce a new file 'system/signal.c' to hold the SIGBUS signal
> handler, since subsequent commits are going to expand the signal
> handling logic somewhat.
> 
> The existing copyright header/license boilerplate is retained
> instead of a SPDX tag, to respect historic context.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


