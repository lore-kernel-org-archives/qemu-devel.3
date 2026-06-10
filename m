Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3205CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHD-00054M-4F; Wed, 10 Jun 2026 17:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGt-0004LR-KJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQGs-0006tI-1m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=620Dr3Kbk+iG7opiGzBu9iXGNHBFheHPmUT4QsDgsJU=;
 b=Wy092seqd0poVL7uU4dyVqkd5A4mD08vF9gfRDp+HxNN526xAEhG7NB3VoR9VEFscKWHEo
 pX+HNs7iwby7gUhIqFOC3PiYE+4VEvK11q3EYq1MntPpKE2/s4gT3SshDLtWmOJ1qaKwkZ
 pi4KyqMFSo6/NM7ZgE/Z2mrv0pJ61QQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-QHOF_UULM4CysjPzZSO0aw-1; Wed,
 10 Jun 2026 17:15:28 -0400
X-MC-Unique: QHOF_UULM4CysjPzZSO0aw-1
X-Mimecast-MFC-AGG-ID: QHOF_UULM4CysjPzZSO0aw_1781126126
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C76B6195DE2F; Wed, 10 Jun 2026 21:15:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 709D119541B0; Wed, 10 Jun 2026 21:15:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 18/35] monitor: use dynamic cast in QMP commands
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
In-Reply-To: <20260610123415.2883603-19-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-19-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600359.209622.650245451239134030.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=319;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fZK4Ox1+BZcbFTOMGfqykdofWCQgSH59VFtrH+jqPqk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOCB6u7wVolYt5J+rjwig53e4oVWcufLByFn
 q+QHOGmuZyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTggAKCRDa6OEJdZac
 5bqWD/42rBWqCP9Tj34n2vtm5Qb9ZCMqx7UBT7elHYYyHylpRI83t67NczdUebc1pHwSMuagtVp
 n5ZNxeQk0/lxm5qdZiimqptIQqXKzdXPpOjxMtQcvNMkRxvU2u+NEth679Mhm9zoCfsRgD8EV1O
 qUWq72QZdeutq71XYr/fEqRFPurT+zTKK4WxjBWr7hiopc77IdQ1Bi8YTaLCOMWluPRsyB+m8TA
 fg4FutFTgqrz4L99UtTBhHVTgOnwsOJvbe3qJm0hqyxtorC7X7Sk5Ioa1HJdRQshz647Ir4lt+i
 QmApJdgqKpJ7N0A/kO7uWd2NtoxwgN05kkYS49vlB67/YF1ElsoSHmTbORy+zhw8P0M+Fd3TLBI
 cTzq6VwBlnF0j4kdKKVA80Rdwh8iM4ODmJKE3LLKu7kgi1dIpZu00tID5GkPGwHCmTPFugc52vo
 hdOrqxsHWIfXeHT3tiv0XIoMoFkFAAEG9nt4p/VMt5NfuTR0Yx6mTYaYz1TXK4BbroWKKdO+vHE
 fNpeuoDI0JIkC7Dr244NJ/mz8ZqxCp6YGfZTTPhS4079XO1P++cKzSDAE8lXWa8j0Re4j8aNdQn
 DPoAtpcdUYosLux6/xUklVcB1/c8INrJmSnlCIv1jMmaiep8KlKv0kb2RW1q+LrVWhPj7pbzeEM
 0W70UlDEwoq6kjA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, 10 Jun 2026 13:33:58 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Rather than asserting monitor_is_qmp(), use a QOM cast via
> MONITOR_QMP which performs an assert already.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


