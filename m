Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2C2CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQIJ-0002Ym-Tc; Wed, 10 Jun 2026 17:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQII-0002KZ-DI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQIG-0007Ti-O9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBZww4VYPf0l8P7lCHDBbGeVbXWqw3E5Q4zUPVQ7Ur8=;
 b=P1AcC6l9pKeTPzh9BQaekfZn4rlWgQeFo7ekbj/zXR37s+4uARh17TtL87twm+p/3MkDXu
 qCnilPTnCjgw6RXZ4G/zrS+gCksEoQsXdBdOffTf5ZDbeUI1jXgmNj5MxSxVVEr8uQSRhb
 N+hgje8HTopqdHMsytbygQOolsYVr/E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-DAtDVgbyNpWc8kkkdGFlWA-1; Wed,
 10 Jun 2026 17:16:56 -0400
X-MC-Unique: DAtDVgbyNpWc8kkkdGFlWA-1
X-Mimecast-MFC-AGG-ID: DAtDVgbyNpWc8kkkdGFlWA_1781126214
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92803188EB5D; Wed, 10 Jun 2026 21:16:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 592402ED4; Wed, 10 Jun 2026 21:16:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 34/35] tests: switch from -mon to -object
 monitor-qmp
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
In-Reply-To: <20260610123415.2883603-35-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-35-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:24 +0400
Message-Id: <178112600408.209622.758891282114268897.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=424;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=C/40iWQX+VUFqpkQprWmoq2J9k8fq5c34hqK0ZXytBo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOGiV9mT14WOO/YY/W17D0rEzN78A42Dtuko
 MuwO6KXw5eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThgAKCRDa6OEJdZac
 5c+0EACX4VuRg2FN9HJ4Og8ohg/rUjjKBtN2QpLd0EJmcJwdVt6kQOwiEp6Xb003Ji8lhhIBxFJ
 mFZ4RJYHw4Hpa/fMr6RkhOrYUVb5aVYo1idWYXfZr+0H1gRClvu0v1Vdfz9V6hIm08aV8TymcO1
 07NtrAP5vd3CBpxKR1Nw3EtuFuLo/nqWjdaGWWzr4Bpd/abDdW+PxQ7swH5kOlZNiBXpU7ukssc
 Jhq/BSNZagqZiB87ANRd/eipPu1BaTL1tfMDAr+37qHgXoypGr5QcezgDKyIsSnzKr4VMp1kTp+
 gOL0YPIT0uvJcpSXecWq+zome5+8mdh1/aX2EC5dEjUVTV5NzpiJO3GnP0bzEO+yQz2s/lYjiFL
 qxRcsVpBKNjZadgd8kSYWiOOWcd/uUoximci017rYaFylLH37C/2rco7zQg53ADbQwwa2qWIqdA
 cn//YEjdMV2pwKt/tKb5HZmlYl7OoXC50Ez/IYcUKIbvOU5A+UyRMbsIPB4Uhrz4RR9ZYEu92Np
 Ba4ICzInMRLbjCOzQrBcWn7lKgqxD//y9DHf4v4+D6dG9ikFBvOkBgEYVA6pjm5NQLhg9XkUdTq
 Sv4zTZu04DS6c7sdV57oX+SWuNCMcJECnUmw1UPjwl9GaXy2C1Js9irtolYhvw7oBfVONDgZQP2
 IlS3Xwt3Fz1/AHg==
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

On Wed, 10 Jun 2026 13:34:14 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Use the new preferred low level option for configuring the
> QMP service in libqtest and the python Machine class used
> by tests. This will avoid triggering deprecation warnings
> after the subsequent commit.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


