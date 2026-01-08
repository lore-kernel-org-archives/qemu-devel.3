Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7AFD185ED
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdp8M-0005Mi-Bh; Thu, 08 Jan 2026 07:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdp8H-0005MN-Id
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdp8F-0007rJ-5q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767875329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HcZLwK/WpA79U/lHjzl+LO+fALZQb6tg8uZXiPZoFSE=;
 b=T8jzMde0+xkLt/B09V4/uthi3kft040ExGUI7GK2uT1Upxeo4FFzKTs5ossvjVpygH4Fy1
 BAYjEyvfT0Ypia7TEXzdzbx7nMUqcXVBEp0fco2343yy8jnwfJHmgADFy8l230NfXzqNZ/
 K4DHYzpqgV5Lt7189OAker/EyuNM88c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fEXrP_WzNIqXvM5YCa-xZA-1; Thu, 08 Jan 2026 07:28:48 -0500
X-MC-Unique: fEXrP_WzNIqXvM5YCa-xZA-1
X-Mimecast-MFC-AGG-ID: fEXrP_WzNIqXvM5YCa-xZA_1767875327
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d28e7960fso35502885e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767875327; x=1768480127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HcZLwK/WpA79U/lHjzl+LO+fALZQb6tg8uZXiPZoFSE=;
 b=CIHlMYI8Guw7yDP4kgKY248Zuwl6424eVyw/2+HEGR8MvRRQm3OIKQN+MYg/js2GVW
 6GLiC98xANWR6C81NUJjJI1L1Drgk5n/BszAgdgFthUrBPHR+jQuPyjFZw/MZSFaHsva
 uwu9pV9838OtkVxC7Xk9Y/9hxyIAxdC/yY7uJQ2YC6fnsGjNX+5ieBnzdF1OZXeUWBEh
 9QWq+mhnYTaMEeUKqlOdaCmTjqpUF15cWHpwy+UMNrqZZvizScPmSLlPsMqQ44LQxiHR
 /lNdLPxDws6EnK/IOF/zlKuwMoqlKcGM4IcPp6rUTgP+8OvCWP7yPL14Za4oWVtOMT/c
 0cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767875327; x=1768480127;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcZLwK/WpA79U/lHjzl+LO+fALZQb6tg8uZXiPZoFSE=;
 b=ATrFTPXQwsaAVSVWHELtG7AP/++i1zZtbvEIPO+b2XuQRTdcaj6CQK4oT1/oz6qWcO
 6fhVFYbbYcPJs6qDQRTpXEywKVZJCcw8qIqzkTgSA3Y+ebfRASewZfldt8PhSuBG64AU
 lz/4nVmJ/428GcRDzzG3giklAmTLQPZcORgQmLcxw4Ee44nVAY4ncka/T1QHMfISG06P
 7/WTNEQvbcEtayCpNt4vU7di9qbbTEY2GwArsLHWyCLq17WxnpFM5S01SPvq6vdfNU0P
 qplCjwdSr+lN0HnyrYkrjqY1/epMZqebFptB0Te6snAHnyoEbJ1Xix9EoDxIu7NPFxMZ
 7WIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4X0WFgT8yagcA3O7+M242kLTW+8oye6tXrwnBQTI4nqyf+/K7lhUBsADGj6wNb84g3N2pagCh+fRI@nongnu.org
X-Gm-Message-State: AOJu0YyL0/kMS62/OI2KWxePw6cLas1dPc1QiPNPCiZj1gWqzIAEpglz
 f8Yes+lGbH/aWK2cjN/f7RBRld6FIL1QylaP6+usTEYrQGjZRmRvIgUNnVDBuFQFXwNb8gSgiGZ
 /MjS1mFDNS9DdVZEbOLym7GSlbunTWbR8n1BE8BZ2RTLnmgtCkNVP5Uvp
X-Gm-Gg: AY/fxX4H8NVdVxeZo1t2iyw0q+H3Yq22aM+YslGSaqUSireFOtGwWDgYYTVx7h9h853
 EMahu0SVZesYUShvs8h703f7XNBS4mOZXsNdpdbcenuzb+JcEASn9G6iNSb4NFLusJegVOqw96q
 g0aQv17001rUYPtVJe4JvqucH9AAcoE0HFSNMCNpHtrrypVZ2qHe/78T9xuM2lmRJd4qyr7xMo/
 gHrgojwuflGj1ncWUeXp9ahsew7xHhntNrcISL/8zgto0oAY2mqShlTqPw57Q9z3qieBAPpDM7m
 xdvvRMGnIEoTCTmx5KYqWWtVuiEpzoJFrTN1FTediAhb+J7cucb3PbDMTxTeCvjzv0IeRQmHxhq
 Oow7QZjU=
X-Received: by 2002:a05:600c:3152:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47d84b1a33bmr70231855e9.4.1767875327305; 
 Thu, 08 Jan 2026 04:28:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3LpfSmKXapR/ajvkoUnojsj+RrOFT1TcQnUW+kVRewzRv8dTMPNgG4A1yREsl9PkxmlILRw==
X-Received: by 2002:a05:600c:3152:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47d84b1a33bmr70231505e9.4.1767875326858; 
 Thu, 08 Jan 2026 04:28:46 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm16148911f8f.16.2026.01.08.04.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 04:28:46 -0800 (PST)
Message-ID: <f96fdca3-f660-496a-8a81-2d922d0ddfdb@redhat.com>
Date: Thu, 8 Jan 2026 13:28:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/29] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-5-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only X.509 certificates in PEM format are supported, as the
> QEMU command line accepts certificates in PEM format only.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> new file mode 100644
> index 0000000000..cf16911d09
> --- /dev/null
> +++ b/hw/s390x/cert-store.c
> @@ -0,0 +1,211 @@
> +/*
> + * S390 certificate store implementation
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cert-store.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "qemu/cutils.h"
> +#include "crypto/x509-utils.h"
> +#include "qapi/qapi-types-machine-s390x.h"
> +
> +static BootCertificatesList *s390_get_boot_certs(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certs;
> +}
> +
> +static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw, Error **errp)
> +{
> +    S390IPLCertificate *cert = NULL;
> +    g_autofree uint8_t *cert_der = NULL;
> +    size_t der_len = size;
> +    int rc;
> +
> +    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, errp);
> +    if (rc != 0) {
> +        return NULL;
> +    }
> +
> +    cert = g_new0(S390IPLCertificate, 1);
> +    cert->size = size;
> +    cert->der_size = der_len;

Why is only der_len stored here, but cert_der is silently discarded? Could 
you please add a comment explaining this?

> +    /* store raw pointer - ownership transfers to cert */
> +    cert->raw = raw;
> +
> +    return cert;
> +}
> +
> +static S390IPLCertificate *init_cert(char *path, Error **errp)
> +{
> +    char *buf;
> +    size_t size;
> +    char vc_name[VC_NAME_LEN_BYTES];
> +    g_autofree gchar *filename = NULL;
> +    S390IPLCertificate *cert = NULL;
> +    Error *local_err = NULL;
> +
> +    filename = g_path_get_basename(path);
> +
> +    if (!g_file_get_contents(path, &buf, &size, NULL)) {
> +        error_setg(errp, "Failed to load certificate: %s", path);
> +        return NULL;
> +    }
> +
> +    cert = init_cert_x509(size, (uint8_t *)buf, &local_err);
> +    if (cert == NULL) {
> +        error_propagate_prepend(errp, local_err,
> +                                "Failed to initialize certificate: %s: ", path);
> +        g_free(buf);
> +        return NULL;
> +    }
> +
> +    /*
> +     * Left justified certificate name with padding on the right with blanks.
> +     * Convert certificate name to EBCDIC.
> +     */
> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
> +    ebcdic_put(cert->vc_name, vc_name, VC_NAME_LEN_BYTES);
> +
> +    return cert;
> +}
> +
> +static void update_cert_store(S390IPLCertificateStore *cert_store,
> +                              S390IPLCertificate *cert)
> +{
> +    size_t data_buf_size;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +
> +    /* length field is word aligned for later DIAG use */
> +    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
> +    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
> +    cert_buf_size = ROUND_UP(cert->der_size, 4);
> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
> +
> +    if (cert_store->max_cert_size < data_buf_size) {
> +        cert_store->max_cert_size = data_buf_size;
> +    }

The next line looks like we should do a

    g_assert(cert_store->count < MAX_CERTIFICATES)

here first.

> +    cert_store->certs[cert_store->count] = *cert;
> +    cert_store->total_bytes += data_buf_size;
> +    cert_store->count++;
> +}

  Thomas


