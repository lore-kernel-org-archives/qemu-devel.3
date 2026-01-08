Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D527AD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsSD-0001OA-S6; Thu, 08 Jan 2026 11:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdsS7-0001NF-72
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdsS5-0000Zs-2T
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767888091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CNGBI8FvGLRZDhlmj3LctnpObhZk9L0uydjHPHBfV8s=;
 b=SNtuQR0p0UCLLhfFje8lIlc04qsUiiPy3Rhe0LLA5RKCkNmtHLfBHz2VAPilSFHw4Ml2RN
 YuXT3LXEnmcRzuWty345IWjI9WYMY8edN8aIkbhm27Px8n4IKTH0HjwZ8dKSxBVJ4AihFS
 OInjokEEvVO87uxDHD0fSoMQQXMtnIA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-7DlQbrkiOQm5WHu-A3fOtg-1; Thu, 08 Jan 2026 11:01:28 -0500
X-MC-Unique: 7DlQbrkiOQm5WHu-A3fOtg-1
X-Mimecast-MFC-AGG-ID: 7DlQbrkiOQm5WHu-A3fOtg_1767888086
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3c9b8c56so34951075e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767888086; x=1768492886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CNGBI8FvGLRZDhlmj3LctnpObhZk9L0uydjHPHBfV8s=;
 b=ERf5w0RqNAcCNSw+3ofggkyi3/CkXO7LY6a4VUpsASFs6grEhcalMpnKF9KGPT0wZE
 4DAQmZlu1ZwzzVZn37bpu5VFDlgRYvjJi/aEJmYjO1S1t5CNagGK1p8fJqKHtD/JQzVl
 Td0Xa1ZWEReQIbq0NgY5LDhbWvfONVzfpPXQ1qKvd9Sz6GC1GfG+qBdaiTujopU1xzxp
 DDLAawsZR9TuAM1pw08dY3b+PvlQ+DSTDRVyPx9NrRpDPdtKnOUETKnAKEuz7PtB70h6
 GFvzE/GBQwP6Fs+sm4cjAcYRIhJpLuB9OW0OzSFEuUuI0GQP5MnLk4K1Rp/ZJchNId7C
 f14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888086; x=1768492886;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNGBI8FvGLRZDhlmj3LctnpObhZk9L0uydjHPHBfV8s=;
 b=sYa3eGDh9xyUI0HJl9hYDLBqFCGjxtwaExZDrkzLod5E9wW4JsfvmQR+gnggcvPfv6
 uJtvZaelCyUOMooOW6IrVar8uEDDlk+G0tg4hhHzZ8MD04nxZcStqCYZfL5KyLR5h9cg
 s7AN58y2GrGy5yBsp3k9q2aHjJg9VJbz0sv8trLhbhlKhHu8LA6p+vZotFh31KRFR/JD
 XNoZ0pyGCqD0RZvxIxxwMsrx6WIomFfZ1dQDoFMGy4Sn5On8hh/6hJ/Pdull88PRfXsM
 aRjehvQ7VOdDHEv0+XxZ9OQ2RWm+5gihuecX7OoJu8crgFLD4vr2vCa5ZPVYPkUYJv3S
 WlHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA34jY7B2B2qtyJPc9YhaSav5a11c7LDG7E/M0FPZ+laTHCNjxqnrJjOr6PjXNr9Egzve3IuL/Ecrr@nongnu.org
X-Gm-Message-State: AOJu0Yx3Y9Pto0H55U0EFzfXF7U+N8OYiiGbJHoKdtxmh6AtiawUQlHr
 AHEJg82J9ly3Cang6AQCBgsxVrAOtpV07tdywJTehdLrp2c5x9T/mrPaeiMCYviQ6sSSAJM3MT+
 UD4wk00qdh6owC+MXa2+NQ7dl4QM5b3p08F20CELcB63Oczn8FKU7C9Ar
X-Gm-Gg: AY/fxX7uG1g/+OZWmVmfykiwpV7t1nevUYYKUzI4vQWCXxLy9WQjZ8sjehKj66BMYuf
 tiLqFHsxUO9/zNAXnIhiFf22gg7Vh7bmXkREksDFFlgLYrLpvOxNwYZC7HCa6uoFpBp0zoKcphO
 xJXwPh1yR+adne6xpKUMRZ4sTLEKUAxiZUaSB458epNniGwOTfLhBiDJe8P7RNWP/N0qyMBdNOU
 azQhMysxBN0Abg1J+Xisbi/u6d4+nsmVS5+0AdTmOneeejZy+s5xsUN5mxnNft8nZ9LSS8LrKrO
 0RZXbYbKdRmDZgIwF7F4UFR8uv+mjPwNa7uKU7//Lzd1cvdQHJPsCPcHr9G38j9hF97GVM00gLY
 yaJ+zxF4=
X-Received: by 2002:a05:600c:3555:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47d84b3b692mr93244335e9.31.1767888085858; 
 Thu, 08 Jan 2026 08:01:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsH2U1iuocBbwACXUcygCeUEFVCKWqsOGbfyd0JpdQ/eiojSn3N7c51svqIU5LP1hZZt2KuQ==
X-Received: by 2002:a05:600c:3555:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47d84b3b692mr93243535e9.31.1767888085065; 
 Thu, 08 Jan 2026 08:01:25 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d870dd5b1sm44657845e9.4.2026.01.08.08.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:01:24 -0800 (PST)
Message-ID: <099574bf-8817-4c73-9d55-53e571bf8fad@redhat.com>
Date: Thu, 8 Jan 2026 17:01:22 +0100
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Claude just spotted a possible memory leak:

...
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
> +
> +    cert_store->certs[cert_store->count] = *cert;

This copies the cert by value (instead of storing the pointer only), so the 
original buffer is not used anymore afterwards ... (see below)

> +    cert_store->total_bytes += data_buf_size;
> +    cert_store->count++;
> +}
...
> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
> +{
> +    GPtrArray *cert_path_builder;
> +    Error *err = NULL;
> +
> +    cert_path_builder = get_cert_paths(&err);
> +    if (cert_path_builder == NULL) {
> +        error_report_err(err);
> +        exit(1);
> +    }
> +
> +    if (cert_path_builder->len == 0) {
> +        g_ptr_array_free(cert_path_builder, TRUE);
> +        return;
> +    }
> +
> +    if (cert_path_builder->len > MAX_CERTIFICATES - 1) {
> +        error_report("Cert store exceeds maximum of %d certificates", MAX_CERTIFICATES);
> +        g_ptr_array_free(cert_path_builder, TRUE);
> +        exit(1);
> +    }
> +
> +    cert_store->max_cert_size = 0;
> +    cert_store->total_bytes = 0;
> +
> +    for (int i = 0; i < cert_path_builder->len; i++) {
> +        S390IPLCertificate *cert = init_cert((char *) cert_path_builder->pdata[i], &err);
> +        if (!cert) {
> +            error_report_err(err);
> +            g_ptr_array_free(cert_path_builder, TRUE);
> +            exit(1);
> +        }
> +
> +        update_cert_store(cert_store, cert);

... so you should free cert here to avoid leaking memory!

> +    }
> +
> +    g_ptr_array_free(cert_path_builder, TRUE);
> +}
  Thomas


