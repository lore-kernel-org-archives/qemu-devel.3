Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF6BC98310
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5X-0000Yo-6V; Thu, 24 Sep 2026 03:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5E-0000V9-Ke
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5D-0001XV-84
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04YGUtAG386busyAtgrU1ttmANjTM+oJkB/rdCIB3p0=;
 b=P844/haJiLp6Cr7yDaecpqMWRgYYcEGwTqpHoK2uA+k3UjFTmuDqg8DUJcoFsZ/RHNPGdY
 OTpLlJDxy2g9g0Ma5D1ed/lt7PxOm63DCcyqGS04ffdTxInbryzEj36UC8rqRoHZwpbUef
 D6G3a+Q3IJ1CRNhAS2cZu9ED+0XngZ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-LP9ZCYTRPhSpKKZdPD0l5Q-1; Thu,
 24 Sep 2026 03:41:28 -0400
X-MC-Unique: LP9ZCYTRPhSpKKZdPD0l5Q-1
X-Mimecast-MFC-AGG-ID: LP9ZCYTRPhSpKKZdPD0l5Q_1790235687
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 600631955E97; Thu, 24 Sep 2026 07:41:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96A1418005B3; Thu, 24 Sep 2026 07:41:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-7-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-7-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566486.1794827.4547558565411422420.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=INwN1zeAShard4BtaDjgKEg7CaFVtK+ViSRqiLQoSkI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQTaZL8KlTmUuzZ+lkuHOqMpcKuO9rPsSgry
 qYNUq8/8gOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEwAKCRDa6OEJdZac
 5aRpD/9QswvB7gcz4FEwnwGsAZx8+oxx46TbdFeHjkkv02tdlbNiVowk1DORvX9QU/75gHJlYyN
 7tlvESe+P3WvBQM03rwrtgd1fjYT55hwKcv7zjFYw+iRA6OhRqM2ol5edNSbxM3wwAwabMpIJqh
 r7sFGA409WC69vXlVM7OWcj3+MyVEwFNGbcYW412rv41AAlL616eu5wlV9TCkkP2ivZyF8nBCGK
 OvXfNiUeR/onNftS8eFHGlS+nX9Ncy8LKVqk8vKyh+uga03LNAkgLEmzOhNWTHgEThtP4b6lMpL
 jFMTPSSMT9ps5QAakNLBLJ7GgBj0z1nP7gsIw6kZr/uSqz6gV1Lr6Pca0fBb8WqkuoWPZvfoWvD
 GSbJFzKmHrd4jDeBK+7z2jJ21/XKQoDngF6K9pB3P6kKKetueFODaBjSEMBOIu30OghNfHON1/O
 Gf4/UYWgtu9k1l/XBJX93LNAB9jHxaZAeRnfOUA9kVsd0VPkW/0yW52Vs2hxfma1qRVfi2M63db
 rdwVn8DLz5rJFLSe73Kte9hE0J4TWN0R8ODi5INlpjFzw7PH5KKmzViNiKpQ7crRrMOo+bnuMRN
 4XXBMKaKICXMW/vSa5i/HUBHpsweXr1hjLmqElk5wuLfeRnl0UaCNjeNUK6U8x0iUri7qw5WiIX
 ntOOst7cEuLKzKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> While the backend (thread) is accessing the request and response buffers,
> do not clear those buffers upon a command cancellation. Still clear them
> in all other cases, though.
> 
> Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")

It's the following commit that makes use of it, but ok

This may also lead to OOB read/crashes from malicious guest driver.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Message-ID: <20260924012527.858527-7-stefanb@linux.ibm.com>
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 54fa2042b5a8..e5e33a3a2ff4 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -218,8 +218,9 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>          if (val == CRB_CANCEL_INVOKE) {
>              if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
>                  tpm_backend_cancel_cmd(s->tpmbe);
> +            } else {
> +                tpm_crb_clear_internal_buffers(s);
>              }
> -            tpm_crb_clear_internal_buffers(s);
>          }
>          break;
>      case A_CRB_CTRL_START:

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


