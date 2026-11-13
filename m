Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC1606A8BA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgwzR79b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmj0-00039h-1x; Fri, 13 Nov 2026 03:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmih-00037T-Ms
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmig-0002bV-2F
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794558792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QClPFLA585xo4WwjNU/w5tPSTuGpZggLWBonRXa4lPk=;
 b=hgwzR79bDc13Lx2wFn1ympm3y077YKUHsbTvTh4N7IARnmAqFF/okMStu3JchlDBU7SF0N
 lFGKig+e3hhyU3hLT0+jFdMABJ6LZZ0x7U/OGedT/W8wTvjqEeGvuM+wf0nHeEZs6Xw9xV
 4LtORKgVf9FUdA2ZzD1tnwrHY0DHYoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-oOyt0tEeNXasF-zsooNQcQ-1; Fri,
 13 Nov 2026 03:33:09 -0500
X-MC-Unique: oOyt0tEeNXasF-zsooNQcQ-1
X-Mimecast-MFC-AGG-ID: oOyt0tEeNXasF-zsooNQcQ_1794558788
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75D8C195604B; Fri, 13 Nov 2026 08:33:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF88D428; Fri, 13 Nov 2026 08:33:05 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/9] hw/usb/dev-mtp: Reset pending write state on
 cancel, reset and error
From: marcandre.lureau@redhat.com
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Junjie Cao <junjie.cao@linux.dev>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-stable@nongnu.org
In-Reply-To: <20261112174907.158825-3-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-3-tcalifano@redhat.com>
Date: Fri, 13 Nov 2026 12:33:00 +0400
Message-Id: <179455878071.754321.2481506478534104185.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Fot43jM8OJ3MmpMvBulbIxPTW7NSliPc5ep3mvsUyjw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9ss+WoORsK9lk35vXHU771klG6tVH/iCMBgsd
 kSN7kK4VWiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbLPgAKCRDa6OEJdZac
 5S/AD/49HvaDmezbQT/K2FSejrPs2ueN39k+PuvI8XGrfprJh4JUO3qzUIZNdF97N9I8DShKCfR
 vsWDY9az1iYQzu8zL5+M8qqErEtm0D48pyTQ43DFPQ0MHcNPiMLQK9nkihL6Y+Dvb1DQc0p8hU6
 BvFp/07IjB6QiNXQRts5SOc3s1IHb5iGxrinps2+1bXRF3Dcm4x0i4QdhDi3YOdkkOiub8zjF5Z
 EHpvooC3mIT+8xWQi2215DLYolnMbQ9mkHmcZMoa91tE3IP/g7gRozqGROapVGyMWxE+AVD0BSm
 epwVKkDgajubKJiVHsOYx/G9nsZwOzFGlk7jKWG6lA29CBiCo6wuCUqroLq4RAkYgo5yl6Io6s2
 rQlfb0MYxIWLPYDoB+F9u4QuOZftr9QaXxcu3Qq7zsrC/KaM3aawnRdzXLO7fSViis7jhx2wEk6
 u6Um10MIFBHv4Oja3y+I3BqkCG0i2SOkzHxKbNiX+qqc/afH8xLvMbm4oPxlo/uJx5ss/S5d+xU
 TduwRIp8C5KywTnz7aSAkkQhdfLy7NEDDNYWvVFu5U9kFLbBSUesefy5qYdo1Z2Vv8VCdr2bG/I
 mjmJvh3Y49/+qpe6mqkhJTmb6fwqTunS3JVllgi5Ol7mO1CBctIKgxUADctzoZ1wXJZJNAJywNX
 SSdb11aXT+8xLRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The pending state (s->dataset.filename, s->data_out, s->write_pending)
> was only partially released when a transaction was canceled, the session
> closed, the device reset, or the write failed. This left dangling
> pointers and leaked memory.
> 
> Free and clear these fields consistently on all those paths, and route
> the early error in usb_mtp_write_data() through the common cleanup.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
> Suggested-by: Hui Peng <https://gitlab.com/benquike>
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
> Message-ID: <20261112174907.158825-3-tcalifano@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index bc5a6f089178..1c14770a9c05 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1236,6 +1236,13 @@ static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
>      }
>  }
>  
> +static void usb_mtp_reset_pending_write(MTPState *s) {

QEMU C style puts the opening brace of a function definition on its own line.

> +    g_free(s->dataset.filename);
> +    s->dataset.filename = NULL;
> +    s->write_pending = false;
> +    s->dataset.size = 0;

Consider also clearing dataset.format and dataset.parent_handle here.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


