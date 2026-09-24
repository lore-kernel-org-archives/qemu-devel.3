Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0231C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e5Q-0000WN-W0; Thu, 24 Sep 2026 03:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e52-0000SW-Vg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9e4z-0001WU-3X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 03:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790235673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRILgX2ONOWgFy050GX+9P24a08/SyUtpInCeaG5bXQ=;
 b=Z6liQ9N3BeDAb3u5wMHHECA9S9uoPTBNbj/uQZ14z+3oPVoq06j8wp56V27iX1MvbVxeKf
 WzIQ5gc4RwBbexHr4Pbq6wgP1zmJ0tMD+lkK6Bp3MWicvGlFe+HN+CxZeu2wUZ8LzfjZzV
 hrledE0uXyQienymRCOloznZfZEHO8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-gcO-ZKeROoKqngmb3G06kA-1; Thu,
 24 Sep 2026 03:41:11 -0400
X-MC-Unique: gcO-ZKeROoKqngmb3G06kA-1
X-Mimecast-MFC-AGG-ID: gcO-ZKeROoKqngmb3G06kA_1790235670
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B09D21955D74; Thu, 24 Sep 2026 07:41:10 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDDE51956042; Thu, 24 Sep 2026 07:41:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] tpm_util: Pass TPMVersion to function writing
 fatal error response
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
In-Reply-To: <20260924012527.858527-2-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-2-stefanb@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:41:04 +0400
Message-Id: <179023566484.1794827.7857065416987116127.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=N1PjWVb43wP6Q3MeyT1ItHbDFScNJM4U/vkPCeaRW7Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqtNQSpwL9x7oYnAP/nrKbHGBqdapvRFThc0R6h
 bnJ0wkjeOiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarTUEgAKCRDa6OEJdZac
 5ZnlD/9C2/9UI7Exr/wt4oZsZ9L8y+TdpdnO9fs4AQbvH8Okj1TsLDPLaavMSeztBXnX55XoDpc
 5isH08iVQCmOkoGuj+JnnBDfacNumhq+o4MZeSc7kAG5/SxvcdeRUs7TOrBnXd8UF0TLM8amHvW
 SffPndgb028SYRk74KYu014IxxqsMwSrEQnfWpYugoc/eKRhgTiApYlCvmg1XaVgNtX7re7l0k1
 wcCcVXCon5JaWC0SlxdiPgg2bYwRVj/4K6gjuxhVEV0mO+G8EQUZQhRGddtZGwpODmztd17bouv
 iIvub4vfloVd+uVJvMKKAIWLBtIWz+wxRRmwouD9srHg0t+nS5dW+SjktV/yaxJumJRuLWxUaxt
 uQzugEm28Vf9vI3Z/MqbUxtQALwzwpPbGiaADuzFPQ6cuZ9IzbBJ2j0d6FdUyTHsbCIK4/CNenx
 fQEdPa90JHgG+WNPM14UQMeUZczd9St/84qE0mqR6cdpO4WrSo/VY8OGamZYu59yMU6AE9aIt0q
 kLAhsIs1GKy71gNT19+5rdhiYRt4EesAGzrcqlNsvMikM1SS1pZqSQb023r8i6sjsX9+KkLdBAC
 igvU2YdyKYxVV6jCAWz0Wu4nSTqqggL67zuvznQQVtRFmy0i5x8WXXe47g6ckKzbw6FITIxnhtV
 zscR/Fa4+l9BKMg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Have tpm_util_write_fatal_error_response write a TPM version specific
> error response with error code TPM_FAIL for a TPM 1.2 and TPM_RC_FAILURE
> for a TPM 2. Adjust the callers.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Message-ID: <20260924012527.858527-2-stefanb@linux.ibm.com>
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 95d2de2f48b8..16ae44c8d722 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -270,7 +270,8 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
>          tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
>                                    cmd->out, cmd->out_len,
>                                    &cmd->selftest_done, errp) < 0) {
> -        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
> +        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len,
> +                                            TPM_EMULATOR(tb)->tpm_version);
>      }
>  }
>  
> diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
> index a9f35ab7d606..8a4f8183c7c9 100644
> --- a/backends/tpm/tpm_passthrough.c
> +++ b/backends/tpm/tpm_passthrough.c
> @@ -118,7 +118,7 @@ static void tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>  
>  err_exit:
>      if (ret < 0) {
> -        tpm_util_write_fatal_error_response(out, out_len);
> +        tpm_util_write_fatal_error_response(out, out_len, tpm_pt->tpm_version);
>      }
>  
>      tpm_pt->tpm_executing = false;
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index 264bff22a91a..cdb7a4886104 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -87,12 +87,18 @@ const PropertyInfo qdev_prop_tpm = {
>  /*
>   * Write an error message in the given output buffer.
>   */
> -void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
> +                                         TPMVersion tpm_version)
>  {
>      if (out_len >= sizeof(struct tpm_resp_hdr)) {
> -        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
> +        if (tpm_version == TPM_VERSION_1_2) {
> +            tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
> +            tpm_cmd_set_error(out, TPM_FAIL);
> +        } else {

I would rather use a switch/case than fallback

> +            tpm_cmd_set_tag(out, TPM2_ST_NO_SESSIONS);
> +            tpm_cmd_set_error(out, TPM_RC_FAILURE);
> +        }
>          tpm_cmd_set_size(out, sizeof(struct tpm_resp_hdr));
> -        tpm_cmd_set_error(out, TPM_FAIL);
>      }
>  }
>  
> diff --git a/include/system/tpm_util.h b/include/system/tpm_util.h
> index 185869322571..3ab2fe693df1 100644
> --- a/include/system/tpm_util.h
> +++ b/include/system/tpm_util.h
> @@ -25,7 +25,8 @@
>  #include "system/tpm.h"
>  #include "qemu/bswap.h"
>  
> -void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len);
> +void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len,
> +                                         TPMVersion tpm_version);
>  
>  bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
>  

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


