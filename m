Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89077CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQH9-0004lZ-S7; Wed, 10 Jun 2026 17:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGU-0003lP-Hs
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGP-0006Pt-Ir
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6bxcITol1mDqfEQ7ajFgW4nTFXVim0dg2yrUVCOJUM=;
 b=IFyraetmkXU1RXCHo2BZ9jnJNj7vRFrblXthJva1G0Vk9QYiGpATdngswk8tvRD1x+i1Dq
 6L2IKVEjrvaYyOjgWosRZXhzQLXLAtHB34WPkkjAXniZZPh9sViEFe0sGSyO77MIsKqw4G
 Cmx4PwF/jnqpsE0SWLr5QdsYd/4xYBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-92PkmKzjMhaxI4rcdHFzXg-1; Wed,
 10 Jun 2026 17:15:01 -0400
X-MC-Unique: 92PkmKzjMhaxI4rcdHFzXg-1
X-Mimecast-MFC-AGG-ID: 92PkmKzjMhaxI4rcdHFzXg_1781126099
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A84C018501D0; Wed, 10 Jun 2026 21:14:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B63C36512; Wed, 10 Jun 2026 21:14:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 13/35] monitor: use class methods for
 monitor_accept_input
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
In-Reply-To: <20260610123415.2883603-14-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-14-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600348.209622.6311595285691643519.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=317;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9jq5+DEUChjYsuHZgWsy32Ysevmg15+xJfGemlG0VqI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOAFXclq16QsHmbh3cfFwG/yHmRvV3IH8tMB
 TdIsGzM5QqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgAAKCRDa6OEJdZac
 5YpOD/4w9Akoj7l+EH6MPQJNtO1yFF+spuTXUBxv2ege4UFdyeCirjQc/GrI6VuCBcERewNxl7a
 pPGkB5zDtg47iiDN+O3C84d6MTfS9+Z/plqhTHgClesEij6ERvfAQCPhX+zIjOrc4BXDLOPdK1K
 ZrcK1QQBeKGtnaG+ZTp4xAaPfQEkxI8VzRnmCR46nNvdYVDaSJYFHuJy6hIVh8ia9rcagrypEMU
 2kRVxg5l3ear3yN0YyOA1hK6SgslomBr93K9Gpx/xrN7N03H50S9cfzXGms7vASwm5KMiVRIQ99
 mE8vIxP07SAg1GSsOkOIoknut66v+a/QhcroqY7YVbUtH0asovHkojmJqka3qEuMfujDl4rzhtK
 jcWGD63YEPPD1+eXgi1TngHIvKFIMulxz5eZyG4tZxs1KMolwh6DvdmhSeE/pv7JTdTyyrUTXyz
 vB0HtHEZeI6ozYQ8prnFxZHI2Copmvo/60lGuFemuBjMKjoSeKN7mYwrfOBaA/Vpmx5laib+Bh1
 /YtH7G3Oj+1ybjk9DrLXUkUptuGl+8ZVciv638or8oxiXceDdOECI9W4B5fwvnnck/SHKOdYatq
 +mra2JU5zAoJStn+UiT/T9GrwaMUJGoHM1GGdIsDqhq/m37Nan0VP4I4Oqo1ZLMC06ho9eBU0y/
 bmgpjqiq/K7TvFg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 10 Jun 2026 13:33:53 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This removes the need for using monitor_is_qmp() to check the
> subclass type, which is an anti-pattern.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


