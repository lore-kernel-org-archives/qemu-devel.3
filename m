Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F7AC98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5R-0000WO-0Z; Thu, 24 Sep 2026 03:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e57-0000UZ-V7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e56-0001XB-Hf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HJCqrFOEtoU+iTuVAvHV7JxnBKKaEaF7Oin6fETBU0=;
 b=VRbG+5BuWCnXWtRl86NmN1dXiQeN55dSNA1clX2NOQ59kVvRkz3m0dTfxytPDCwfOtm7i5
 Evy1A0IcY4qmh1XG0YGVaZmB107iP+FFheBXbAAlhsbx7wzFs3FH5SdBxj7OMH76KWjRMC
 1Gt3+z/+eYYGNKPwgnyVuWTRPu4TWIg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-NSJ8zba6Oe6Somu8wPxkFQ-1; Thu,
 24 Sep 2026 03:41:21 -0400
X-MC-Unique: NSJ8zba6Oe6Somu8wPxkFQ-1
X-Mimecast-MFC-AGG-ID: NSJ8zba6Oe6Somu8wPxkFQ_1790235680
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0BB195608A; Thu, 24 Sep 2026 07:41:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08C90427; Thu, 24 Sep 2026 07:41:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 04/10] hw/tpm: tis: Only read from response buffer if
 rw_offset < len
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-5-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-5-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566485.1794827.7521598151635314490.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oMWsqXXsIeyeBiw+Nr6ohtCjr/SSjlnX82ToXzCXJNM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQT0A4CSCoB8Vmnvs97dt9YAkS9a+Tvw9tWp
 w8ynlMMSwiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEwAKCRDa6OEJdZac
 5WlnD/9pF8f3RC3kPycSn00mlcrfWVag6SZfxgWcP4DBZp7sNqYYuaW1+X6whowMJiwRkPTcOFw
 VEScG3VEwYbjWTa+rGKU07G140KrOP2coZkyFKTyXR2Wnvoq8LKp/eLq00Oc41tOecJpUVxiwvx
 Pa6Cjl1RW8Lp7EAviZd22jiNe4vHZayor13mj2JDVKwR2sKrBAHAfD4C0SKgw2pPprWPvFN9mFp
 gSBCvupYmLT+foXQECvdTVjkvTUdJSinkIUPOXT3QsoyDSyZ1Np7BmifpFP4gsBvHgI4IaAu6Dv
 sYpkbeuN7WL8B7dSkEGlQWT1xQDiNMqTtGltT9UwW7C0qE89ZMccQcUR5Hc8CvHCp64qyoVRvQy
 I2hrHJBhXDeVsDeKKJP/3pMKC3Sb4HPaDQufk/P7CugYJQHY7A99+f7XJ3S+av5dIQikRcPxU7y
 eZt6fBYmqdSC3rGlVM+LV5S+GxvvxZRqW4NxYepoENU2cSHOr5MxNciEqJUdpdD5+yHjofZvyWH
 AE4ZJAEEdAKKPUeY/MkvX0ZBDXyxxclhm4WW3ItxPerK9EyigfEbmQRI9UJvXM+pvFX81HRObSF
 E32RNPHT6yvSMlhHxYIsRkSIu6EXmwdyVUD/BugaU7DSbkANNT+YQFMOe84E+/hdMYIqbinx+JZ
 QYAhaHQFt4SiXmA==
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

> Only read a byte from the response buffer, if the rw_offset < len.

OOB read from malicious driver is CVE-level.

> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Message-ID: <20260924012527.858527-5-stefanb@linux.ibm.com>
>
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index a134d5c20599..4ba228116b64 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -273,13 +273,15 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
>          len = MIN(tpm_cmd_get_size(&s->buffer),
>                    s->be_buffer_size);
>  
> -        ret = s->buffer[s->rw_offset++];
> +        if (s->rw_offset < len) {
> +            ret = s->buffer[s->rw_offset++];
> +            trace_tpm_tis_data_read(ret, s->rw_offset - 1);
> +        }
>          if (s->rw_offset >= len) {
>              /* got last byte */
>              tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
>              tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
>          }
> -        trace_tpm_tis_data_read(ret, s->rw_offset - 1);
>      }
>  
>      return ret;

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


