Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE92C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJL9-0008Ah-3Q; Wed, 12 Mar 2025 06:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tsJKe-00088Q-Ln
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:29:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tsJKa-0001Dy-UY
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:29:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-225b5448519so3362925ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1741775335; x=1742380135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3BtjizH5Ho++5dzXa0ULY2nUsqO9vOA+29CGg6S8JI=;
 b=F4pvuWnvUnkh0vUx4bG2WKTCy0/oni6g+Qn9/VHVhm83eG68W1cUjcAieOcC4NVAPQ
 7kVSVeMyX1D0S8/XdtiegSgY4YjFSBIN+elSVghgVqGZb/KNilbiBhWEW/8LCCKuCRBH
 uRf4Du1BNs5vbBBOnnpIx3Z/PJ0p6dYcHAE+Z+W0acmNzKO0ejtGzuFjkPEr7AUkwUc6
 KlPDV+Us3C3buHoz2xPyiv4EzW+ORtLTosrS8YY1f4LeFrUfO24s9SmA4DO4VZa/cvta
 LjUpQf19dqihO93srh8GRc7g13vxObbJOPZYLKaScRhrKTW7ni8yhoA/n6Y1cODlRyP5
 H9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741775335; x=1742380135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N3BtjizH5Ho++5dzXa0ULY2nUsqO9vOA+29CGg6S8JI=;
 b=PGu6Euy2TFv5U74bbhQAvPepXxt3py22mBx9CuhJjr1DeU3huc23U53JJIk6Ae2j5p
 h+t6g70a6H/ve6WcjcHxhkTCVhpysOj2ZNeAua5fHCV0v2hogII6Qcw4Q2PQDx7rRrqT
 bKYJHZC4ufJdxm8rxTQWmY0PhQNcFNDnpSwrcKt0vgYklBgtnoMiC6qrkyhP/z9NU+7o
 yqhEp0NDQa8/X5kGnNXTs6mH7rw/zT+/mgTrllhSZlzWTcVJaSGSXHJXDT165Zsewh8q
 1rfq7YjAQVmTbCT2P57+Fc/qmjIghLy45VCjhXYDZ1oQonMR+oNKPn5ujr7QP8BJ/ob1
 ClNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcVN4FPFB7XA7mMKcCMo52eq51L8xJI70GZ/BS+yoBq7bJwKBrMUAaGC4qmIX2+N7nbjvG/clw2Qz/@nongnu.org
X-Gm-Message-State: AOJu0YyH2rw0JIPnWFE4L7+nd9ocbX4g0W4wqNJGH48WBhw6rkJq8URn
 ISzjZ5WIdb0ntx+Y1yDFMu4UEk8JxkoXsdI/ttGWRnw97A/wNyXG/+3+SRc3Z9o=
X-Gm-Gg: ASbGncvzP1puNadL7Bbbq47bN8B73ssyWQvn+HZhPR6QuXSiAFXQzvvB/O7OMhI5RaG
 jDY1hgiTMbBnl4BeReeF6LDeCmaeX/SGmGSpjh/um3LH+2xr84I3rzWlob+Z3J4764HG1xtAS6R
 TDM4fp78+aOvdrtWjSuQtojIaXAGdTVdFcKwwxAINSvpA8Uy1Y5G4lSFGTfEuY340j32L9jmDQ/
 ZkAa07Pxis5VYwYYIi8DzFIem8f4g7oiltD+ZPNstM3YFotuEq+1MhCABv4X2HxWYO05/ho+XcC
 RDwe/KWn9krQTawDfcvbxiMaO/QkZzOsHFGq0K+OTmdQ16idmKg=
X-Google-Smtp-Source: AGHT+IHO8VosBTupLTCOr940p6FgqgLkDOOItIO8B76m0d3KfJ5lGjyvSHNclWNbFrN97iK1r9a0yw==
X-Received: by 2002:a05:6a00:2315:b0:734:b136:9c39 with SMTP id
 d2e1a72fcca58-736aaad1d50mr33623512b3a.19.1741775334797; 
 Wed, 12 Mar 2025 03:28:54 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736cc310f34sm6844554b3a.150.2025.03.12.03.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:28:54 -0700 (PDT)
Message-ID: <df42e188-00b7-46cc-8853-163798c62ac2@bytedance.com>
Date: Wed, 12 Mar 2025 18:28:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com
References: <20250312101131.1615777-1-armbru@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20250312101131.1615777-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/12/25 18:11, Markus Armbruster wrote:
> When cryptodev_lkcf_set_op_desc() fails, we report an error, but
> continue anyway.  This is wrong.  We then pass a non-null @local_error
> to various functions, which could easily fail error_setv()'s assertion
> on failure.
> 
> Fail the function instead.
> 
> When qcrypto_akcipher_new() fails, we fail the function without
> reporting the error.  This leaks the Error object.
> 
> Add the missing error reporting.  This also frees the Error object.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/cryptodev-lkcf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 41cf24b737..352c3e8958 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -330,6 +330,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>               cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
>                                          sizeof(op_desc), &local_error) != 0) {
>               error_report_err(local_error);
> +            status = -VIRTIO_CRYPTO_ERR;
> +            goto out;
>           } else {
>               key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
>                                p8info, p8info_len, KCTL_KEY_RING);
> @@ -346,6 +348,7 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>                                           session->key, session->keylen,
>                                           &local_error);
>           if (!akcipher) {
> +            error_report_err(local_error);
>               status = -VIRTIO_CRYPTO_ERR;
>               goto out;
>           }

What about moving several 'error_report_err(local_error);' to:

out:
if (local_error) {
     error_report_err(local_error);
}

