Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268B0C98310
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5X-0000Z7-Cv; Thu, 24 Sep 2026 03:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5R-0000Wo-4W
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e5P-0001YG-Lq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pygepw5TOdGSGPZzUo8qtA7RnacCDL1Swoj/mb7J/uE=;
 b=agc0BdwfUyFLMynmEKs2Cz3FfHEGs2iq3slk3vLaV0N3Jum7EUAL9si+Y+/YiYPYVex+lm
 +bAkU/gzBbV2J/cwGklMBO60PldxCrQ+zUS+uxUYq2MtnfHXyh5P2Vnf23ofIX8CEIouVY
 eiJ5952Y6PrHJfPkAHUhL+zO8jKr0Rw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-K2znMOE0NnyqRZB22fSV2A-1; Thu,
 24 Sep 2026 03:41:38 -0400
X-MC-Unique: K2znMOE0NnyqRZB22fSV2A-1
X-Mimecast-MFC-AGG-ID: K2znMOE0NnyqRZB22fSV2A_1790235698
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2F881955F2C; Thu, 24 Sep 2026 07:41:37 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23A891956042; Thu, 24 Sep 2026 07:41:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 09/10] hw/tpm: crb: Consider response_buffer->len of
 received response
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-10-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-10-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566487.1794827.12959803552356788522.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=66DWSMiDcENDKek4rSgDBLf/YPRiq5U215Q0at4w0oQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQTcmFnT6anSkJZJQJ7iSp14G7fQ+RP2APgN
 mU9F7g8QnqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEwAKCRDa6OEJdZac
 5b4SEACAASgKNyeHKdGmDbXXvtdcWJV72thKYi+Myed8JGjJHUO6GPr/QeHSKIB5/9hAN4MDlBQ
 Iqo44RpHFTThhlj4AJFua9Z7yWC8k1e74kfrFi+Q/C3QR1Nt+nbTwDmukZGO0nwiEgE6aozGQoI
 t9b+4VX0Ur4vv8YaAPMJDNAxPuwnyoj9P5Y7olEes2nGRhdldiYslrT3Q1SS4N3jNOYk+Q3b6Yc
 YDxQO16GhKM+QdOAKBq8h+ZWYvOx7Jvyva+OJr+tVoZbvxIbjVfGIXYCEfEaKRehhqpRYJ/yQrA
 Utb/zDVIncv0xu4Jyf1IKy2Q1IrJpUZFPI0Sqqy4IK+FS2dfyztk3cqA0AserXsP77B7x7ZvxXY
 EmC/PbW7QNQ19ELkOGTnGj6QsOH1oATsk0BGeyZjI1XPc5rGDCouLGLHXIdRJ2fG/uMB1oLalaU
 kdYHL4s2gUUQ25enMP07gLo2j0zihH8oLWE+u9nUKzMK11LN8gtvaXc3i7B7q2k5N2h7/jP9ieV
 AdpGMben/u9loA63iEJ2wNWEu7TXclBzK5LkajoOqu7lKGfaug/J9JMIlD84q868FBsTvQy6Fxs
 a66gQS6BPALMXMixgmauYgG1XmhC/mD4upnM8R1lANDS5j2+hh4CKvB62PshN4okQvgCDYwYMnC
 eC3vAzHfP1u6B5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> When the CRB receives a TPM reponse from the backend, then reject responses
> that are shorter than the TPM_HEADER_SIZE. When determining the size of the
> reponse, also consider the length of the response_buffer as being possibly
> shorter than the negotiated backend buffer size or the size indicated in
> the response itself.

Since the backend is considered trusted, this is not a security issue.

> 
> Fixes: 2a660ad67d15 ("hw/tpm: Implement TPM CRB chunking logic")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Message-ID: <20260924012527.858527-10-stefanb@linux.ibm.com>
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 4bd1919952c1..6ae2261b43e3 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -325,13 +325,15 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
>      CRBState *s = CRB(ti);
>  
>      ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
> -    if (ret != 0) {
> +    if (ret != 0 || s->response_buffer->len < TPM_HEADER_SIZE) {
>          ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
>                           tpmSts, 1); /* fatal error */
>          tpm_crb_clear_internal_buffers(s);
>      } else {
>          uint32_t actual_resp_size = tpm_cmd_get_size(s->response_buffer->data);
>          uint32_t total_resp_size = MIN(actual_resp_size, s->be_buffer_size);
> +
> +        total_resp_size = MIN(total_resp_size, s->response_buffer->len);
>          g_byte_array_set_size(s->response_buffer, total_resp_size);
>          s->response_offset = 0;
>      }

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


