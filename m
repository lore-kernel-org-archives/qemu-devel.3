Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B153D49C73
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 08:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljrJ-0003Hl-Ni; Fri, 30 Jan 2026 03:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vljrH-0003Gy-IW
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vljrF-00047j-7d
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769761679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHZjXISBwDhkipLdcuxrAPUMRGBpJn1C8xrxjyvzWns=;
 b=CUI/js/cvR9RbKG6vkvZwaXMIFpoyDAFL5+s+Ps5S8vIxnzMR1xZ0GFqh0hHojIWmjpvs6
 1a9BzvnU7+xcq6nHvXLDWODHz/f9M4cA0S1cHoTmlDSk5hXGE4WI4nH5U1lgiL0XrUqyI/
 as9MpucLJH+nttEfoApo/JOnjsaUJrc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-wg2PDzVDNxOwMUWPLfO6kw-1; Fri, 30 Jan 2026 03:27:58 -0500
X-MC-Unique: wg2PDzVDNxOwMUWPLfO6kw-1
X-Mimecast-MFC-AGG-ID: wg2PDzVDNxOwMUWPLfO6kw_1769761677
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4359d70faa2so1204807f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 00:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769761677; x=1770366477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WHZjXISBwDhkipLdcuxrAPUMRGBpJn1C8xrxjyvzWns=;
 b=EhDZ07UidwdNETRELex9TnOvFcHs7q07YpeT5cU7Yq0qSQkQ1j2jlUUg6V+i45vJo6
 OuvPNDrbO5xp/AEEdQWvp9+iyNVfcHjwvdgs0louZMsesbNFE/Qf0kJDZrb5q0OZ8/PT
 G9l1Nolglhfr1eIZIImuHXT6ZnnQe6KOMc5F+db62HaGl6YEuPZ0kBO0SRBFbfEZpa//
 Z0nLnakaQQ/vRyDwPu2yMvEl4zHXy2UmActrr6pcK43AitJTYWVll1Ip7ze6iDskoZct
 mkW7vxHkm+tsEn5ADvjylE5lpfC0pc1lpLrO0Y1sBHD2sKkT6eZ5lhLIO5CeMeeQUnvw
 vdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769761677; x=1770366477;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHZjXISBwDhkipLdcuxrAPUMRGBpJn1C8xrxjyvzWns=;
 b=bJ+J1bvfuDt5lcv4afKOQJBAH5TGumydgP1AjTIPgwSlGBJEc2EUxBSfjxDKlicq6R
 LqJD4lNq4sopVi112Eq9LR+h+0fZBrOF9lrOUBcQQZGfzTmeGBa0OXn9wTaIJNH2e/kS
 lIHZHNxZNpI+cE7/+Y7XW07HOb2ykbm2yB8766K/cHDt9/W3pcOaDJmZJnv4MQq41Ods
 q/CBhITcMWeKc9YUbdjNOPCMXBvVN0sTvDkfLmF/JBfv+UnUAI+3flBsDVLPkojaTcls
 fSEvUHpCggAuxJGL9bHrFDbEln46k3y72ELtTPAsDfJLXqXUuORmUPcnYD4W9PIdwHO2
 Xmfg==
X-Gm-Message-State: AOJu0Yy3hjkn0WmsS3fs0kKCVAWeR+th8EcoH9OQVFf0Y/NFZ6tlpIPL
 7Z/vS2ZeP2ggsZ2AECtcaAfwWl5s0qFVqfexNPFdeLzhmgmmzcMCsAsB12vnUhqeQtKp0sPKigl
 BYZAviEsxBgPJN7Yt2cJxApEb1HM8Yse1xpTzkHNIemvB/1QBUA1OpfeG
X-Gm-Gg: AZuq6aKCMqgHHFsMtSMakXjTJ4PiOtO2gYmIguF7Xj0OcR9LsRcjuonfnHhQ8xmmsLE
 qAiyVUHyEkmlE6L27NOSJDywFsFdPO6wEJayHuvvTQhDBSaAsps2kjK3VqJO09NexboMZtmyUZw
 FQj29P+9pxMmaVW/2KhSilZ8ZHR0Ku7m7JHeP/kvsW6LcSYHZkyl12wMJ/w4Fu8UTo19aztnwS4
 6GFvbFE+5ebqjV4OuE+qBQ6pNmy8y4/AM+8q+iFmDKszAjC7mC0OS69JYWnp98kABHSj5P9tzxM
 X1U59DO2kr8K5ckDKdU7eCKfSla1h3WxXDATFgM/xWREh7FZoDsLLGzms6NuqyekZXCWZDHRVsT
 neCvwr7cgk/gMFn4GM8YIOoeUOjtmtiD0Ep7hDJ94CRifNlaqsGcFutBRW/28YQS53LZ1qhuJwu
 LxNNjw+mxm/L0rxg==
X-Received: by 2002:a5d:5d13:0:b0:435:a160:4480 with SMTP id
 ffacd0b85a97d-435f3aa9270mr3611333f8f.29.1769761676981; 
 Fri, 30 Jan 2026 00:27:56 -0800 (PST)
X-Received: by 2002:a5d:5d13:0:b0:435:a160:4480 with SMTP id
 ffacd0b85a97d-435f3aa9270mr3611296f8f.29.1769761676538; 
 Fri, 30 Jan 2026 00:27:56 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm22635151f8f.15.2026.01.30.00.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 00:27:55 -0800 (PST)
Message-ID: <ac182e8e-cd4f-467b-b6a8-31f03b70b3b9@redhat.com>
Date: Fri, 30 Jan 2026 09:27:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4 qemu] Exclude TPM ioctls definitions for the
 GNU/Hurd
To: Damien Zammit <damien@zamaudio.com>, bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-4-damien@zamaudio.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260130031954.1661880-4-damien@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/30/26 04:20, Damien Zammit wrote:
> From: Manolo de Medici <manolodemedici@gmail.com>
> 
> The Hurd currently doesn't have any TPM driver, compilation fails
> for missing symbols unless these are left undefined.

This is due to the missing _IO* symbols, not the TPM driver.

Fortunately, these are unused and the whole enum can be removed.  Please 
check if it's also possible to remove

#ifndef _WIN32
#include <sys/uio.h>
#include <sys/ioctl.h>
#endif

#ifdef HAVE_SYS_IOCCOM_H
#include <sys/ioccom.h>
#endif

at the top of the file.

Paolo

> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   backends/tpm/tpm_ioctl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
> index ee2dd15d35..e466311455 100644
> --- a/backends/tpm/tpm_ioctl.h
> +++ b/backends/tpm/tpm_ioctl.h
> @@ -285,7 +285,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
>   #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
>   #define PTM_CAP_LOCK_STORAGE       (1 << 16)
>   
> -#ifndef _WIN32
> +#if !defined(_WIN32) && !defined(__GNU__)
>   enum {
>       PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>       PTM_INIT               = _IOWR('P', 1, ptm_init),


