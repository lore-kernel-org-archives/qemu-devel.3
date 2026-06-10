Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EECECD98CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFZ-0002tV-9R; Wed, 10 Jun 2026 17:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFX-0002t3-VN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQFW-0005fk-IW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZPGPoVnsLUfCRv/C4NjbWUGkZZDcyFWlx51AVqilzw=;
 b=al1EJ8hqz83mvHIUXrDieR9phogwUqrJgNJ9T9BKIMWO8qfVmDwrin4nwAUuuOey/oVSb4
 HBsUnWD0TtCHd/RZF8/9YhimFie+/zHPob8XBQ1+E+WxL5jyeDI8h6kPpQCj6rzBYLzpKP
 ClnEOcdINAakLeeFbwghT5Ud8TRfYGA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642--PhYjhhkO_q77zgJT3m3hg-1; Wed,
 10 Jun 2026 17:14:06 -0400
X-MC-Unique: -PhYjhhkO_q77zgJT3m3hg-1
X-Mimecast-MFC-AGG-ID: -PhYjhhkO_q77zgJT3m3hg_1781126045
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 307C81955F06; Wed, 10 Jun 2026 21:14:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEE78180028B; Wed, 10 Jun 2026 21:14:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 03/35] monitor: replace 'common' with 'parent_obj'
 in MonitorQMP
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
In-Reply-To: <20260610123415.2883603-4-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-4-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600316.209622.15081502555680071388.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=305;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LQm8+t9VRiww5jnmT1CEHz0Jff/lFx/A4KkM02X8uOA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdN9KUhigYel/D+9+AK8iuXxIuCMPPEi9mJVX
 WmhElYEGKGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTfQAKCRDa6OEJdZac
 5c10D/9/oX801ZDQw9IhaK9kSxDg9Ho5yPkgyIb/60/u/fRcxewhJy2SxJGt1kSMgZAx45xNV9k
 QEhfB+lebcP6IkuxCzdqrlC+9Agu4jI9MGqbnMsmzhcUxeRxfJ4untpFxh/jlVtATCa6azMk6/n
 iGeo8JV3huG4pG1Fd2HJ9JnEAUNLzNcHkLJZHfRpe5z+JVHBm4Srz6S8bfhNokiF4iOlfoOLjhS
 Xk8VTsCRvjb5mve0r5I6ERRrdrRVDjc9Vzf4trhynCRGsk6UNWkbWX2Pi8okKunRsKHvk/mcUJR
 RhvgydudKqzKs9rRl6GjaXHs6/Y5Qw5kGEYBpepkITAZ9VW2OsPeKre2tc63R19Eq6SKkt1oo3U
 rUlKaMq4MuFtBJM3r4KPD3aByLFj2LzEhsI/B+MQRYA1yic0jOmddK60hHkeWwZbW18jecrIVP1
 3kl4SXjaO0iQqPkPySOYV3TM0PSZ8Z2p6mSEvvnJwGs8dRHtQtzuyGQL3st+wjOHu0fVELUJDpn
 Y3/e2Wu14sjqCDdhXoXDnRyos+p/ENwCXqIvv9GkBGzncaav/uimyccwSQTuQ6MQflhruZh31fk
 JCKx5dAVoJXm/8FENkZ59FZctJ/gr4b+fEbtdFnCbEuWhLHsW4yWOuQVmoVrX5YTyP0PZPuY34G
 hWkPw6ZIcQoANGQ==
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

On Wed, 10 Jun 2026 13:33:43 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The field name 'parent_obj' is standard practice for QOM structs
> so align the QMP monitor.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


