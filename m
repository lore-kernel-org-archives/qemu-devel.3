Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC6FCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFN-0002pp-4z; Wed, 10 Jun 2026 17:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFM-0002pQ-4P
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFK-0005bS-D4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWMaYlnULLjFtE1hpHpoJMs1duj1XR4U9CVMyAIxB8U=;
 b=dyJCFfaXp2oYfMu6DFg9qE0mE3IagkPGrwlj2oWFq0nye5R8G+gKrD4muTZAyOhHUnwS8s
 tHRp5MU7FHjJqklSJOVtThX+CbWPozxJpYPQE7rnT63JnCwZ15Ow4OwQvvqsR6j152NGld
 Cf8RyTxtxmS6L9ebKv6KmWnFmMIbZ48=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-4O6uq6WtOP2efJ6vEGynRw-1; Wed,
 10 Jun 2026 17:13:53 -0400
X-MC-Unique: 4O6uq6WtOP2efJ6vEGynRw-1
X-Mimecast-MFC-AGG-ID: 4O6uq6WtOP2efJ6vEGynRw_1781126032
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90301956062; Wed, 10 Jun 2026 21:13:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AF24180028B; Wed, 10 Jun 2026 21:13:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/35] qom: replace 'can_be_deleted' with
 'prepare_delete'
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
In-Reply-To: <20260610123415.2883603-2-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-2-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600312.209622.10566667142398391587.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=725;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7Zu0+HfLCqXbC/O0QEH2KBeun5+A4qM5GdDXl0LRBMU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN8mgVEzi+mMMWlwvmaNY1DWlIAskxNMJKHK
 Qpn4HiNY9mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfAAKCRDa6OEJdZac
 5RgxEACO2g20j8nAY3FNdEfDRq/TLpCuYRjJivdWQ/Sj2P00bZeOaGJq1ZQ/qzG9660kBzZgK9e
 EozBhslG/vWIqHJ5UF0gzjNzDLc5qnMRHHYFIdWQC7do8OM+XdMAENW7z0qHyzORbR0rZQrqIZS
 hcDO+cQOM+Z3ghLLN9P+yyENs8Z4qBaQ91Px0Sjyg6PTqHzkdTXQmYPUTR7pK5kOzUVupuoelFO
 gTtueBSWZUMF5vf9OBSCyBGH3QKuoKz2YKt7mf0/fncNE4L97e2WEGw0POIdBSlUcXKpeug3WIA
 eHXa2PkRYSBmM63Riu8yaKrlgtzqbsgEd4QUdrVslcorjxxPXlos1ITwU2sSiGlhrEK0gf/RdGA
 jFayAl/kCp3TswRD5uEiq1yHY0d0E62KDSUxU7G8YVrXqeG7PIN0UQlP+6IVSEZ1LoI7X7sXQBx
 EBAx+1stu3BWCVij+yG4BcFeQHK5s43NINSiX20uxoRRBdjJzxiZxdg3FjoqBx2NO5ItalkmVEQ
 efjhJNwR6AMo8PFhdNdRIXnifVgMy3kXult+7MwC7rDKsX07xKOSU5cp4ZgDKXvyYVfJbXLg5Ov
 AFD8OkpkJ9Cna96QRFmn8u/OtRj2QEJBDXTv6Y9gUI0pIF5IKLCCbuUtdeX06ECCbqLVnzFsNYH
 d5GNd7TP9aYh86g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, 10 Jun 2026 13:33:41 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> While most objects can perform all their cleanup in the finalizer
> method, there can be interactions with other resources / subsystems
> / threads which require that some cleanup be performed on an user
> creatable object before unparenting it and entering finalization.
> 
> The current 'can_be_deleted' method runs in the deletion path and
> is intended to be used to block deletion. While it could be used
> to perform cleanup tasks, its name suggests it should be free of
> side-effects.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


