Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C15CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHZ-0005op-TR; Wed, 10 Jun 2026 17:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHA-0004pL-2r
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQH7-0006yj-4G
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHlHaiE7Jpu2auw9z6L5cVdnkLo0ia4QwebOZZSpxvU=;
 b=eVFxKmbcnoz+EHj+tTuPWXq0oBu3lsTf/4NDFxYMaNNXvdYOphodIvQ2b523PE4t0f5gOF
 YMvZ4obC2y0tc4THpvTmUjVKLfT+ClT9WXNMTGdqAcxPNLs+DpEFWzI1Y1yYjkFjOV2XAd
 93CVSnjz5shNlcjC8+EqE29dzrMm0LM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-LQmtWysoNX2QVc6olgmehQ-1; Wed,
 10 Jun 2026 17:15:44 -0400
X-MC-Unique: LQmtWysoNX2QVc6olgmehQ-1
X-Mimecast-MFC-AGG-ID: LQmtWysoNX2QVc6olgmehQ_1781126143
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04C9E186D55D; Wed, 10 Jun 2026 21:15:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1066E1954B10; Wed, 10 Jun 2026 21:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 21/35] monitor: eliminate
 monitor_is_hmp_non_interactive method
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
In-Reply-To: <20260610123415.2883603-22-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-22-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600365.209622.12161913708760129363.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=509;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=maIrWP2aeAL1bVlqT311Hc3rDrh/onOO2bEBPaJmfW0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdODFupu2s6SObThDWLDAl3ALhADpxZtSeDGD
 WyC00YHRWaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgwAKCRDa6OEJdZac
 5aUoD/sGJEKN2epb1lV/2dZeXmL4Hkz6WXr/JA91/VmhE7FWQCbr8dY6ye0+mfwgnyj84/CefvX
 wZYi05h+LoC1BLxdmExn7otJ1uCYL73LTSZmdurxCS+8BT1NfenptbLnZsm4XMZafJ1lqpIk9WB
 0JTBcZtSAK7AmJCJ4AmE0aPynxFWm4H2YC4qF9AbRqP+rdjIuNCBLA41Nxs1ONvEeD8GbyHV3a9
 WVNLv8HYE30aJasAjawU0oIuHdv075Y5ldOULSQ8HownZYqReppZYOoRGzcYe2B9/rE/ZV2BfbS
 E5HCmd1B/SrPP/ZlYxpi7PXHVe6F2XnHyS/vK7r0D3g8C8gC5mvd0jLTULvQoaB6WJtcTUssdM6
 VrMbHLhhAX+3tVH0pXGWrvISiD9Dh2fLIXw46gaGxNctcLntq8jLgr4sqxquFgDj6HmSwuhJQrd
 54qLtH0k3MUNPJzLuSpB0LkVjC06TQCbP/rw80sXQpSExFV8uajmmqswBj4bJheC/4Pi4X+6Xiq
 vw0ub5iMHcmhqA9jY1/GNExg8VBeKmn9YR+FIZ5c4bYBcpmqMSBQqNtPavGnIlbUUMyThA3O5up
 YBLcySY5XxbhKqE2DO/7GXabSjBjXFh+ln0+XnitsMg9lOCJXe2tiZ+G0b6Kl/LDIBI692XbFM3
 6yUz8RcjiB+Rm4g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, 10 Jun 2026 13:34:01 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The monitor_is_hmp_non_interactive method is used by
> monitor_suspend and monitor_resume, to make them a no-op
> if the HMP does not use readline.
> 
> There are only a handful of callers of suspend/resume and
> they can be made to skip the call when readline is not
> present.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


