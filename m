Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9D606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDXAhoVA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNshS-0007gm-Si; Mon, 02 Nov 2026 09:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshQ-0007fz-Dr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshO-00059F-RH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6rrMF5g7kSJjjz4JgR/DJELGyW6HUEWAKJW78oBWTs=;
 b=VDXAhoVA6upJGuF5kYzETm3re401a0XQsWltJc8DGOINrKEYi3+teLnTmeRpgDJSzWLD2s
 n/ixxUzQiSE2FvGmhULaa8vNLNPQlDsksfBQ5ZFyT8S7DFpSXkMbIHyrlY9WeBjM7IwYsQ
 ld6e5KWOZHvQvshk9rzAL1dO+0l/au4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-k2dcesXvMiGXIQHyQbl_aw-1; Mon,
 02 Nov 2026 09:07:42 -0500
X-MC-Unique: k2dcesXvMiGXIQHyQbl_aw-1
X-Mimecast-MFC-AGG-ID: k2dcesXvMiGXIQHyQbl_aw_1793628459
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59E231955D66; Mon,  2 Nov 2026 14:07:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B15C630000E3; Mon,  2 Nov 2026 14:07:35 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 01/18] hw/usb/bus: Add an auto-hub flag to the USB bus
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-2-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-2-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845005.3960472.6869995164240582772.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=459;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pAw5eg4Arl/ByoHFAYRPJQb/M2YDquuUFg0/97XLg1g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6Jkj81VS6SlcWI4Rwy61JYstprlWUXrEY6lpy
 wc1SZFRb7uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZIwAKCRDa6OEJdZac
 5QYyD/wPeJ8nM4weGI/sX8DMt0EeH7uYANAptfmfk41PheaO/7plM2Of4Zm2/6AppYmjB8uJw5j
 7aMh/2Ozw+k7hO03zeLNiS7XA1f27jXKUtARK4Bb5vRQhNtpinnBhPh/ohaLObS1QsU+58Y6Shx
 H7ZLV27gqTf2tOrvfBF5M/F16Nx9l90XHSy+Vi5KCruu5cXiuxgg8PQN7rEq5i6JUz33hHEQg2D
 4xxxXvkXvea75Upv8+LaWsUJhYSUgaYEknAaXRhiBmb0sA3CbO1RHHt/cIkAjIwIgtcs//hgmEt
 zWie0/ywlexmtlVimlLw5dVKI1E/9sQZxEEsx8oRZgdJdBdbvPcGHN8WP/WrOe26+9Fy2zA6rHs
 44/rYiAE+T5owtGlLkZu1KSc4cR1rAyj8R8JtBeQPU7sKSk7zV7xeya2rqQP4yqCaxmqE+Jne8A
 h8q7quPbYLpLIKaF8uKFRM7GovMGojSVJkCtUgSwxEvYcQeaosoYJCgim6oXZuqRI91aJGS1cyM
 RYiTTsSzCgKDD76SjGiNwpaL440PaERbSlIgN0s5j1uaYhDao2aWY6yG0HEtqGeyHKDaBUZQIpz
 jYdjTNFp6xH2MjYulYRfmZ4n7mpT5U2hCziavVJOGXNlhJ5JSa3aHxxj3DzcKFcEqmoBnntH6mE
 Tdj2SPUXYkm/6wg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:04 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> usb_claim_port() plugs a usb-hub into the last free port, so that more
> devices fit. Every bus gets that today, and a controller cannot turn
> it off.
> 
> Add auto_hub and have usb_claim_port() check it. usb_bus_new() turns it
> on.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


