Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC8CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI01v-0002TN-Q4; Sat, 17 Oct 2026 04:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01k-0002JQ-LT
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI01j-0007Dt-80
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clGClAy5Gg4hTUE7xapu4rCyqOScLwMBkGgDJ3g2TlA=;
 b=fYIWJhCWfAynDCZ/U8d+N+77rEJEntjq2won6RTE3LHkbt7DbjVgweevGFMCvc5S1ywlHg
 RpqK8IdMSRTGJ88PPA4m5hQfXYNhxl50ToKUZ2jgkCNPc3KP5sY+Iz/IlO0Qaok+wMnBbM
 BoqaOjrTcnW3jICK/8l4qLePcrnp9gM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-uqBqRD93MmaL5FLIlJPWsQ-1; Sat,
 17 Oct 2026 08:44:13 +0000
X-MC-Unique: uqBqRD93MmaL5FLIlJPWsQ-1
X-Mimecast-MFC-AGG-ID: uqBqRD93MmaL5FLIlJPWsQ_1792226652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E398180063D; Sat, 17 Oct 2026 08:44:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A87161956089; Sat, 17 Oct 2026 08:44:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 22/23] dump: use get_note_size sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-23-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-23-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656913.1619676.13797679719054599737.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=613;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JJy4zNStzkl0go4ib0x+ovCH2K/bXFin/MNdNifKY58=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNeixNvA9wR+ALobq6SuvyiEjcysnCZyM0w
 z0l6hsLr9SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5fpTD/0f9xE6LOChMK1EiV984WmI5PtJsIA7uZhOVIyfv+W/In7AwX8vC6gbAxvTjXsVe9T4g1w
 OzmfWvA95aXAylCD+DOwrVy76cgHeE/SZehKNltfYu+BDevZpywgXT853QrTaT5/9Z3dAj/xp3u
 IYVnkEqToZUGzzffp8rjFHnuJOIhFqzLjOGxgRB7kyKaodTY2jz4ITMr/XFO6Eg4+ti+P7z+QcB
 rjqsFwXb+kpJwWw2pgsOEQ0+1ys4DFhU/AxggbYbQk6N0ZyiLIGDXI2c2smlFlnuIMCoUN3l1Qc
 QH70+QqKowbzUA9R9JLgEZ9ItFwo236zV310rt9s58vR+UvswI4qVBFdo4lqr9/iBIO054T9E5O
 DcwYcsoUkCZ9HP4v9bVDt1z8O+YkKnKM308SqUjEVokJ5s31cEG5NlkDiqsv+oMJX1gn9H4Y/wy
 U0gPSWJDvVtC5MkAuQcT3ePjiScGi3CiBPgI8xXRHyyz86ymVLfntq+ltu0L/0PFsm6zZu3J8HY
 fW36sxYLKA9i7jEUGZM64rlzn1kAGr0UPitjBLurFo183+Q/KuoWO5ebNHFUrGLNa8DKDZN4HAd
 vGHH9Y6IajdpR/Unm4EYwhwW43tsDIie+0wimQpEEJJNXnwMSL4LP5eZpH75SpEsGgHSL7Z356p
 AheNwN6j0lCzAQQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 16 Oct 2026 11:14:09 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> Now that all targets implement this interface, we can replace the
> cpu_get_note_size() call with the new interface. We still pick the
> first_cpu, which will have to be adapted when we introduce heterogeneous
> emulation.
> 
> A target implementing get_dump_info is expected to implement
> get_note_size as well, so we include this check before calling
> get_dump_info.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


