Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A1606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ha3FgUxM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN3R6-00058T-K4; Sat, 31 Oct 2026 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xN3R5-00058L-BA
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xN3R4-0005Bn-20
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 03:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793431409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62FmMalj4JslFcj/8pvcN0huwgOGqefp/qPZEUPG7QY=;
 b=ha3FgUxMSGEe1r9wxBrYE6zyHGnoyKanovPE8/8Gz0r5hornVApMVaa0y4IGcbsG5orkPW
 UhlohJnpboA8BvUnUnfMMc1iu0Z5KXNiTFaXyt49xZeCH2QNmgfPX6bDZDj+VBoEEDPmBw
 FEs527/t1A+WMr2B58dmTktwOggaX8o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-v9aedIvpNqy6TzdTUJFsdg-1; Sat,
 31 Oct 2026 03:23:23 -0400
X-MC-Unique: v9aedIvpNqy6TzdTUJFsdg-1
X-Mimecast-MFC-AGG-ID: v9aedIvpNqy6TzdTUJFsdg_1793431402
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E460180066E; Sat, 31 Oct 2026 07:23:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0381A1800495; Sat, 31 Oct 2026 07:23:20 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/4] ui/vnc-clipboard: factor out clipboard peer
 registration
From: marcandre.lureau@redhat.com
To: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261030141442.264308-4-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
 <20261030141442.264308-4-lucas.kornicki@nutanix.com>
Date: Sat, 31 Oct 2026 11:23:07 +0400
Message-Id: <179343138751.2067999.8594296569917696065.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=474;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q2qWfshe5FWnpWPxX5900E+V7BpCHJS7GJ2xVw1HVGQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5Zde4qNZByXVhr0lT/ZGgjUZMARYSJ2LLKFEg
 +qiRvxxHEeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauWXXgAKCRDa6OEJdZac
 5XqnD/4lwbwBplCDDmyn+YnfQe4u7WtJhh43P+2kuUBi9rN51qR+oKuuH4hBJUUZsQzPgdWCQRS
 7j74UMlON6NIloeSjA+oRNOG3HqNR62N13DZ14uVpPry9dwJIbS3uIAB3Ap0RbKWdabA/G8/a5X
 ZlQbwUtssQFgU/GeYrIp/ahtrgPetxMSMEIfKPglOoZPH8Wnrg3cxoEli3hna8u2SITZc7jaTKZ
 lhJB78LjKBamtjFcmLsD8B7wYMEPvw2zPmUYUZfHoVDF6SqU+4pZ93nhFd0LFoNgpHjm0mqnGh5
 l0nyjtAt1tawKL0ADSC7s28lfvOpsNJDf1Nw0MPPBP0VOTeX5EOV72yBV4ucCrW+q3btGye8Zo6
 uDqFXiO0krfCHrW3ktozqAWN39jyTvTJZGC/B/kMoYApZdZL/FeVYUcVJCqGmS2KaJwrCPhrnD/
 QYmHyOBLT9XBg3MqJuvvULYH5mfYJtCuNQ6aMVTJkZX06wAqSiM6zns+s7pEqdOkIrD0fRtz7ag
 RCaba2QVNIferIk2Kr1oGYj3tGW0RjaohJaIwU0tyPYIa7w1AtJZ9vPZQyu0cuiCnr4QRORCdrq
 b4rnB1lMGeTon7nR+amRIw6WU8OrZ6fjxgHFxmPzINql4F8bbiVb5CN6KwLuqgfH/jBYcIq5QtL
 FzvyqSVYRHHtgVQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 15:14:41 +0100, Lukasz Kornicki <lucas.kornicki@nutanix.com> wrote:
> VNC clipboard peer is registered inline from vnc_server_cut_text_caps.
> 
> Move the registration logic into a function so a subsequent change can
> register the peer independently of extended clipboard capability.
> 
> No functional change.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


