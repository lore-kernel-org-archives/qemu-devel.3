Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA98CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFj-0002vE-N4; Wed, 10 Jun 2026 17:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFi-0002v5-BG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFh-0005lN-4F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PuU0I9XAvTmYqFHc8X7m7whP96Q2c3RRpEwTI2CGjdU=;
 b=Q/Y4nsevkjo642ANsrS4hHqBJGz/PIQREIjHcd/OSTTmS/pe1sIK+8BScwRw3/wRR26nFn
 roWe2JtAYEGo108YfhmLVXiRz74rC+jeX9XIgmxAvotc0GO65YjPg9x187YArRkXolXnCh
 9uoRrSVDXQXcdj97tBBLVfqXdnLxkt8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-GmAc0bPHNP-6ZbIbbPC7dA-1; Wed,
 10 Jun 2026 17:14:17 -0400
X-MC-Unique: GmAc0bPHNP-6ZbIbbPC7dA-1
X-Mimecast-MFC-AGG-ID: GmAc0bPHNP-6ZbIbbPC7dA_1781126056
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDA2C195E923; Wed, 10 Jun 2026 21:14:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E16F1954B10; Wed, 10 Jun 2026 21:14:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 05/35] monitor: minimal conversion of monitors to
 QOM
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
In-Reply-To: <20260610123415.2883603-6-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-6-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600321.209622.16634493309970876174.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=424;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dUW4lRiZ4qAmawoEOMOy8e8XHTdiu/Q2IILyflAZqh8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN+A47u1twatzpL35PMcBU5sNo8T30RobiAF
 oAHJSWGr9GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfgAKCRDa6OEJdZac
 5UHmEACyZ3JUSV1fSKCWjsy6FU0lMcmRaq+srHBSmg+VDn9mW3SUiABS7fdjDlAQDsDi6lZV2JI
 GUHXfM0nKsK/UbRtMP2zXUnnKVGTwRDDEWNzuZ9Wo+wnC74z/v7qFaoi20qx91SQPoq90lJfLvb
 69L7YBc7illqZzIreyz0OdDUX9ZO1fsneHshbXnQOy6SEZ/aXoUF2ICVYaZ6T50YvhZs1aus02Q
 1imO+08Xs0ALQt9Qw1Q8I2Io0FYluSiS6wMYRU3oGKLFftMgaDhbH7CoAVVhGbRi7C/LmnZuTwx
 RIJojYB8+F3mouUnkhzXjqqJ5T2kLfYLjNp1N3UWIis3XI9IE53sfvaRonkMUYJfCwZK5vFDLSF
 SB4XUwppHtH/1562mxy1JXU11mHQz/EiaS6o2ceJQ7Hb+89nfaQjWoEjG0gwHMOfVhRRiIltVEY
 IZPqWsiJhn/iIOEbO7sJ26GECDzfvRJswNrDzsi7dZhA50ROLCy9yLsWhXte+bKmrHqaHuow8i7
 x4uwxOyr2921QINKCyOB3aHxBkNM81yJ/I2ApNH4DwJ3k08nDeBS32coCCzZR3ikqaV8Q+Hh9b6
 bmjwbvVM77zqytbziQ0EGDIx3987JSfY0gqSV6NcdnrYaXs7PoLWPDRqMTq2fzkQ+OyJUq/rtYh
 zztIhvfAbufDNiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 10 Jun 2026 13:33:45 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This introduces a Monitor QOM object, with MonitorHMP and
> MonitorQMP subclasses. This is the bare minimum conversion
> of just the type declarations and replacing g_new/g_free
> with object_new/object_unref.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


