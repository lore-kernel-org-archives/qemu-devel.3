Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3FECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBKq-0000j2-VL; Thu, 18 Jun 2026 07:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKp-0000iu-Cs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBKn-0001Bv-1F
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781783695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOEqR2DHn/HI1WGpi72OpWp24iXF0WFwXgydVzbM+tQ=;
 b=TzgoYcinF134s4eE2cCCjpTe+GbTlxuFcFpAs7+khY8NVdR+IUQ19TscQGbTgqjM4vmKeW
 r0lgHJL+zNwEkr62gpfK+KSZaUxq3sjo0oQGEplI4FOpppcHFxNICDndnoAWqwvn/8eT13
 VlJgEkQuIOmLNx2MgCruCzKF13Fty50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-iv9JT9gdPImAMpd-zrXFpg-1; Thu,
 18 Jun 2026 07:54:54 -0400
X-MC-Unique: iv9JT9gdPImAMpd-zrXFpg-1
X-Mimecast-MFC-AGG-ID: iv9JT9gdPImAMpd-zrXFpg_1781783692
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 358121800EEC; Thu, 18 Jun 2026 11:54:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAE901800480; Thu, 18 Jun 2026 11:54:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 29/35] tests/functional: add a stress test for
 monitor hot unplug
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
In-Reply-To: <20260618105836.991609-30-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-30-berrange@redhat.com>
Date: Thu, 18 Jun 2026 15:54:32 +0400
Message-Id: <178178367255.2477794.17777917664676183352.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=544;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qJ3CZ2ZhC7AEHIlC096bhKaFTA77Wexbl4vZDYx0TU0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqM9x7IR86voMGkPleqSLgoOR6m1hJuYDgz8Wlr
 ipU8BPycKOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajPcewAKCRDa6OEJdZac
 5XLZEACyPVb5aGCSrodhM/0Hgw5iR2A3OJt9Vvp2cjNvSCuukGKAZMMy7uzXfQN/YgTy8HqtwcN
 +iIq/XbA4RM7Qys1M39a+kgLeqzfoV/eKXWNoqwtS01pN3OZIM8Z2RiaOB7J30BuZNZsXC5Uf0P
 TyvypfOAeuDSxPcouSGd5jQx88et6bU3cwCP4aZE0kBsjzmHKWtAtUP/GwlXzIt0Lz0MCXq0qbP
 fHC2Ema5psCGM/2tOmXkLcJtXQW83rqhHT4d4ei/sJDlhODv05VscJFMinWHaWABROwRFJ6TMjN
 rhw+3ON4A8XoTZk+Ztc/oJL/s7oKZtwGU1Bv1jt4pERXDs5joHjlFS7B3YrB7TTPNECqU4SrGJc
 5iyxw8jIX56+ENs1KiV6oCxoJjmcsMsCiOgat8vFta5454C4/vUkYM1jktUaeOku62XaZbL5mAT
 M8P6ikz9AQdXK9PqnJR6eBrVg+gjzbNpRFgaN1jqJD+2GK8E0G98NEi/rBM8R+n7sQtsAsNlvH3
 SUa3dSkJ2FyBp34axrNw4KSAdYoqHPvjy5ZK99iQ7IZmjcy9bS831qzvVSrAfOyM+Mz5u1+78Jw
 aVW9ylHiHCoXCOcwjDI0YIAvj1f6P7FKeW69JbRkPIF4wy5N8Xhli+zseWwLk8x8FC9EhU5HeCB
 dqZMSXvyzTGePpA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, 18 Jun 2026 11:58:30 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> When unplugging a monitor there is a careful synchronization dance
> between the monitor handling the "object-del" command and the
> command processing for the monitor being deleted.
> 
> The stress test runs a busy loop of 'query-qmp-schema' on a second
> monitor, while the primary monitor requests its deletion.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


