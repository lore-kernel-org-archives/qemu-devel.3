Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P5ZLIUc9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ9mh-0001l2-Td; Tue, 20 Oct 2026 09:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ9mb-0001ka-BJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ9mW-0002aI-Sb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792502487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGXWob1SJgYcqPaw+8oQG0PA5W4traIxOa4rvAJ5udc=;
 b=P5ZLIUc9jl3jy/owW7x9oGHyD9YgIVonRh1/N686sqeJknVbfML+NVaNVNzRPRlAB+07BD
 vaxzSdSzViDoOpf4YJrLfUMPLHFPP2joCC3JYwROxC39+aIiF5eB2hkGCEyr67WLtNt/gc
 4/ddYZ+YoG3R0oDHTmXU+q78HPxsAHM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-pPgQ3JRGPBa-bQTJW_i1hw-1; Tue,
 20 Oct 2026 13:21:16 +0000
X-MC-Unique: pPgQ3JRGPBa-bQTJW_i1hw-1
X-Mimecast-MFC-AGG-ID: pPgQ3JRGPBa-bQTJW_i1hw_1792502475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 012221955BF1; Tue, 20 Oct 2026 13:21:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECB58195608B; Tue, 20 Oct 2026 13:21:13 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 21/21] dump: reimplement cpu_get_note_size using
 get_note_size sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-22-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-22-pierrick.bouvier@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:21:04 +0400
Message-Id: <179250246427.3747302.10422066606645717324.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=501;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=geaZR46GdBiwpCHjEb2N/IeuAj8Y8/zQS+q8shpYZPc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq12rD7whG/31JCkBJ16Du8H7sgYqxDpRzIkiLs
 DYC9TsPahOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdqwwAKCRDa6OEJdZac
 5SaGEACmcWskQamkiIxKl9eGcRf2ip5MqJR247aRApcJLFq+400I02mlxiWBwqKlHFYY6f/eSMb
 VN0ouY/ILPfilkItgXiJPg7xdogmONq/fHLmBJDGFSE3gJ7ptJgvI5elJLodpDGBYSxvyqWXlHd
 LyknI453g0ox0WgAweVDM6rnToKOg44wcU14kMYPI3l8yIvDHjxONXtmE0iLIQkMiXGH4vMtMlS
 mNEqlip4bauX5UG0m7P1HQVRYo4qXwRQavrdx/CGJCUnraVAGmpku8dOZxUE9GlJS1P5blgKi4D
 XldFdvXN3mcrHJcu1RCq7xgPYJSIOH+bpN5tZ+jvFgsHWZXGtdh22XjRt7P2BjgT9vUKog9j5MT
 gKZscIxsjgSZm+fHy7gq+4sw6vCGlwB6RrstG+5ofwDo8xHdV1ru41QMqNyc0fQWUF9ewqk1dlD
 A4rT0fqDamlkEJYIuuJYq+LX61FS51CBUfBM7BEsklbpenTmvCfqg85F2RAWxwlwKM95qCSqe1P
 9zoE++/hJ1BP7aDOsnPbMRuQsscK9HsgsiwRBuPHbHWY6RYKeSQinKbZ1YnJLaezFPrU5HV38GX
 YDc/I1MOzfUlbaS8jzJagmRD/HqqdtbTDqLbqPYT8mj1CzVV1qzMPjuSUvzZTRKZVuDbPgbb0TP
 8hm9Tyvez1J2q8g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 21:26:48 +0000, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> Now that all targets implement the get_note_size sysemu op, we can
> replace the per-target cpu_get_note_size() implementations (and its stub)
> with a single generic version in hw/core/cpu-system.c, taking the cpu as
> parameter, like other dump related sysemu ops wrappers.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


