Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA70606A8BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xwh34dCO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmj0-00039u-3C; Fri, 13 Nov 2026 03:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmir-00038u-UP
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRmiq-0002ca-ES
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794558803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BHnXmtxRz72tXP+QQBMVWjfgR2zRKZhCmvw2Zdhcx0=;
 b=Xwh34dCODJqbjcjY78MSPFnTvAdcpco7w9wQtwZCq6SQlWjPpA6/54qa9f8JPX7Cxt2Egq
 N4nNcPJPBGb+UwhYs4REaFQbNX/zqugIJKaF7/y1ABz3FHfejiaJZne7Fx8LAIKzoq0NQc
 pcd+9kpt6p2tBx9MNPZ3lkCVucn1ey4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-olUIIl9-MlmYzhA9Wc9FZQ-1; Fri,
 13 Nov 2026 03:33:19 -0500
X-MC-Unique: olUIIl9-MlmYzhA9Wc9FZQ-1
X-Mimecast-MFC-AGG-ID: olUIIl9-MlmYzhA9Wc9FZQ_1794558798
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D72B1955F73; Fri, 13 Nov 2026 08:33:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 373AF18004D2; Fri, 13 Nov 2026 08:33:16 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5/9] hw/usb/dev-mtp: Validate container length on first
 data packet
From: marcandre.lureau@redhat.com
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Junjie Cao <junjie.cao@linux.dev>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-stable@nongnu.org
In-Reply-To: <20261112174907.158825-6-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-6-tcalifano@redhat.com>
Date: Fri, 13 Nov 2026 12:33:00 +0400
Message-Id: <179455878072.754321.9063742155881524526.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=15wxxngeHLRPa7jSKYpYhWWHTLUk1tLOyDHHp1lfI9Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9ss/hDSNPCVy8g+WUhAthKn+aqNVmqO7hK+Eo
 xNDmCBRsnuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbLPwAKCRDa6OEJdZac
 5VwmEACqOzl/V6LHRNoujYUEqfG51M3DepVFTOc4yc0QT0CC0KljtrOUJic4dE7Qd7I18iQKAf8
 uB/Pf4YubcIuHXgcVx9uVw0OlUFWFTuZSsclbvCX0Y8jS8gc5Lnce0tUekVam7Sxr23MJ2jD+jp
 1HZG6wEuXIERHF3DT+97HEsNwJqMP6BtTR+bkIrpJTYY+FTWAR3HW+XrwATBlnkPnGHsSNnacHT
 v/xlP93gF2D1Df1ZnvgAHTef/hJGnICJ3W1jjAI7t3giQzTeVkqoDT2NFpB/pcWWP1HFzvHlc+B
 F0ONyMxoJ8uYqobeLCEBE3L8J4m8vVbIQ2Jnf/VlTuYpEaJOFmMVe3ai+uA52w7aTR36r9VB6RW
 NszP4EDVPb/MFdq/igHB6j8leRzxXr0S3SFGM2Ep4305EKRxKRLDale1pEAVSrU+ksxNhd1mHKE
 oyyZUWVjA+uT09T/4dsdkK4qdJI8N+uuEPe/pAyfWvbc/gOwIck12bjvEcB8DrK8G6586DbM/W7
 BK+Sn0sIIdV29QC8T2ZxP9HUAT2q7Nw/iHgv1e/GlySPjR6GED1GGQQhUHHFRRmr/JRP4gIIoma
 w4ma116cFsATn9uuvrKQxl7CC3MRjkJw5pOvLbqShsZEYCIP199SJn30F/lxD4/DwL7FiVLRetc
 IYipzZUD498BiQQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> usb_mtp_get_data() subtracts sizeof(mtp_container) from the number of
> bytes received, without checking. A short packet or a header declaring
> less than 12 bytes makes these unsigned values wrap around.
> 
> Reject the transfer if is smaller than the container header.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 88d5f381ecb2 ("usb-mtp: Introduce write support for MTP objects")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
> Suggested-by: Hui Peng <https://gitlab.com/benquike>
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
> Message-ID: <20261112174907.158825-6-tcalifano@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 7233470558db..6fd92e5a687b 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1784,6 +1784,13 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
>              return;
>      }
>      if (d->first) {
> +        if (cpu_to_le32(container->length) < sizeof(mtp_container)) {
> +            usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
> +                                 0, 0, 0, 0);
> +            usb_mtp_data_free(s->data_out);
> +            s->data_out = NULL;
> +            return;

Should it call usb_mtp_reset_pending_write(s) here as well?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


