Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95371C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Om5-0003s0-CL; Wed, 09 Sep 2026 16:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om3-0003qZ-Ko
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om0-0006rC-3W
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ+9d7Ln39T4HbQs4QR//WUPTxzqONQ1OpNC0HXF3S0=;
 b=BmlY8ZBQnf+A7V9hac5H6D+CBbvjFz5owagHh69Epoigo600SD1xBvsPyInCqvKoKnYNoX
 k6SRaGv45xGOTqeCeC/xTzdipx+TXVrm4SWJaHSn2a0uHOhvtiMkW4vqB/68NO9w+Kf+Ve
 0We8IH1RNnXgX8UXblttZexAH9LUyxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Bb_uJNcUPYu4WMCQKeMoNA-1; Wed,
 09 Sep 2026 16:19:58 -0400
X-MC-Unique: Bb_uJNcUPYu4WMCQKeMoNA-1
X-Mimecast-MFC-AGG-ID: Bb_uJNcUPYu4WMCQKeMoNA_1788985197
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFD511956072; Wed,  9 Sep 2026 20:19:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B61B426; Wed,  9 Sep 2026 20:19:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 06/14] system: check security for machine types
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-7-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-7-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517056.2613908.1246383381501606945.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=297;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=a7BCEfmaSi+ks653LhzBZI3R8hiCsSo6ATJpT1x+RR8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9VBLPzW43UrF2lMP25f0ToxRNC4aUenbAZ2
 JUgSAoo6iiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5UdcEACeamJMehCX4+xggadH2NJ7fgpQHoRbyB9V0IYjDVSNcEjlPysFzbspcYo/mxIEK+eYTmQ
 qXqyaD/Jd49+UPIg/edlbzf81wpYzSoOtHv7WG4gupdnNgfJfFBuoJ6W7FpcsBqEtp/mn8vb/ok
 uBAvh81EcUVMJb3kFtlIoJWzBgDoNNzOix4NUmBBGFahwPrF7eNLWl6H6+uLDAmi+QJKS8FkldM
 ZCB9byBkS8oKq0H6q0DVWdKtAue0uRF5bXPcj05GAW/7PHwjZ4arGNqKVj/WlExbrF0g4y4Kbdn
 8tsJkm2ME+aMEvw7nl+TPrMk/dIYlPcLgShat5JhGhZjptD++2kiRr23YrLbuJ/fr2AJUOBEgsJ
 RsfrqsAqaafFQNWqmiNT+vDBSYLl5Py/V77hYIgB1vn7hgnQctt3/i/7gOvoqyCvGVOQ5a+e2Dq
 8qvpg+tVrUlQvUaWHhk3dMsCrdW61apldQEQozjAc0qU1Yv0OYFanYmiKjs7UEo3GWiIEiiQkkZ
 lH7GnVobmJ+LpYB9pXTHRaRrUoACr361+/+TvFeE8GJFW6dMGxHtePcvAWO42jOV224uKSe9gPn
 LfY2Fj6VEtxxMilM6YT9d7grFMg+RLlpSehnm+gwTFlzcpIB9Atd+Ty0vhNetpGlIws72lgUe4A
 bUtQWqHpV8YBJuA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 09 Sep 2026 18:56:48 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This wires up the machine creation code to apply the compat policy
> security check.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


