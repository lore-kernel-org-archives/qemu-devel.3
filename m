Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83E0C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsHyS-0007X1-Hi; Wed, 12 Mar 2025 05:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tsHy9-0007RV-1c
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 05:01:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tsHy6-0002lf-GZ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 05:01:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22113560c57so120079785ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1741770096; x=1742374896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mwqginh0uCEpZFomsXPwiOlQgrggGcyROt7lzoDFie4=;
 b=b/ilCXZpDMdfWOQbA2WepU9SvBnd31zpwJu4dE8kmvf5lXXfD62x/5/1DMCJDM4v1M
 AB1DBSJ/dtFRW9mKQ7JCjPZD06fRxxN86q22hBqtW4ucT2ZkvkXl3M0OdFhPuYSjnpRa
 JVhfwxWzIWcdRI9tZhdhp4uadW5Kc+bTx+IOPGoCivo08Twtxg9KXGpob4d+91YCEpre
 9tkfElJGPKYQJvF6knqxKwI1Ff7pt829bHG6mUmGOBbREPIKkvacApSNIf4tT7LBU9d0
 Euv6QEzPa4kUossqup6ZKWZ0B+AGnsknLcGuwfXM67i3M6rZzB1PdDNVoN97skcufdg8
 5mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741770096; x=1742374896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwqginh0uCEpZFomsXPwiOlQgrggGcyROt7lzoDFie4=;
 b=NiNiMZnIaWHoXJr0r3SxpyqUio1dniDeCoFO0MULiBrcoIitHpsypp4ha/Mf1MVo98
 He0O+ck9Jrlp+G7NuWHz67Gi5iGF3acO/537SePy9vagsGFzEaXdWvsHLo7Ep+GgDnag
 zF2t5e4NcjnKRCBN4F1skeqWX80R0bhJPe/SAk42JOaNf8Ti+RKf+Qx7+fhAOshNBbER
 nF3l0Ye2bVjnlnwjsUINp8SLXzHC/z7jT89W8DhthWyW261lsXVKxsudzFEXLbdfs1na
 0NW7/UyckQl38mIBQsJkuP+6O0aJBFmbCmrmUpyBz+LHTQxlqxhfqDHsWNIyNkD2rNt8
 snyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmXvlP2nbtgupuwJjnYo+7Nce8HZFc4gorY8ChoOg8bUZKJ8WEgV6aQE9q1VeN54ljSXKL4aN3kcT6@nongnu.org
X-Gm-Message-State: AOJu0Yw/2zuZQVrS3t3Ju4vhQ5yPYx3jS1cIcNml6hDGS713lrILUUo0
 i08iqjSZas0czEffwNoUPi51lPd6KuuVL22MCbLmH+/aTLdq4wbnCfiB1tAiROI=
X-Gm-Gg: ASbGncvtwPnB1L27IAarNqFdzmQMR18IbZ0WJ/AzTK4uKNikyF/V3Xc3wRziQoEESDk
 r4Eypru0+VU5oIRqeN2rVCf/LOrjz5SIMhjh1wARZ8Ejg/+0illx5rSLyYGDhs7Bi8YA1/TlIwW
 0P+8d3CFWkwHcY/hPpipKzTQat63ihzxtw3LOOGIqEpW1pY8gDrY8vTSaPv8ix0+MRKh/A4y0zh
 5es7i0WZ6tEuJR5qN45ch7KlFOZ27pzgXQChXQR22XQeZlgtNoU3Wz6Gzr8x636dRNjFP60JQM7
 JIVHNyZIyF2nv9vfWoC161rHjRYHwwCj5b1TLAkg+w4gVBySZA==
X-Google-Smtp-Source: AGHT+IE2WfObrdHGEM7mO6Vdv5uGx9rGxc3TSRZAl6I/m/R20rxGYLUD+eF+qYi9W0T950bSPjRVhw==
X-Received: by 2002:a05:6a00:3d55:b0:736:52d7:daca with SMTP id
 d2e1a72fcca58-736aaadf019mr32406722b3a.18.1741770095707; 
 Wed, 12 Mar 2025 02:01:35 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.7]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ded451c1sm5018232b3a.119.2025.03.12.02.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 02:01:35 -0700 (PDT)
Message-ID: <85ed8afb-09d7-47a6-8c67-f9298b11c092@bytedance.com>
Date: Wed, 12 Mar 2025 17:01:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad error handling in cryptodev_lkcf_execute_task(), need advice
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <87cyemoeiw.fsf@pond.sub.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <87cyemoeiw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x636.google.com
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



On 3/12/25 16:10, Markus Armbruster wrote:
> scripts/coccinelle/error-use-after-free.cocci led me to this function:
> 
>      static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>      {
>          CryptoDevBackendLKCFSession *session = task->sess;
>          CryptoDevBackendAsymOpInfo *asym_op_info;
>          bool kick = false;
>          int ret, status, op_code = task->op_info->op_code;
>          size_t p8info_len;
>          g_autofree uint8_t *p8info = NULL;
>          Error *local_error = NULL;
>          key_serial_t key_id = INVALID_KEY_ID;
>          char op_desc[64];
>          g_autoptr(QCryptoAkCipher) akcipher = NULL;
> 
>          /**
>           * We only offload private key session:
>           * 1. currently, the Linux kernel can only accept public key wrapped
>           * with X.509 certificates, but unfortunately the cost of making a
>           * ceritificate with public key is too expensive.
>           * 2. generally, public key related compution is fast, just compute it with
>           * thread-pool.
>           */
>          if (session->keytype == QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
>              if (qcrypto_akcipher_export_p8info(&session->akcipher_opts,
>                                                 session->key, session->keylen,
>                                                 &p8info, &p8info_len,
>                                                 &local_error) != 0 ||
>                  cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
>                                             sizeof(op_desc), &local_error) != 0) {
>                  error_report_err(local_error);
> 
> Reporting an error, but continue anyway.  This is suspicious.
> 
> Note for later: @local_error is now non-null.
> 
>              } else {
>                  key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
>                                   p8info, p8info_len, KCTL_KEY_RING);
>              }
>          }
> 
>          if (key_id < 0) {
>              if (!qcrypto_akcipher_supports(&session->akcipher_opts)) {
>                  status = -VIRTIO_CRYPTO_NOTSUPP;
>                  goto out;
>              }
>              akcipher = qcrypto_akcipher_new(&session->akcipher_opts,
>                                              session->keytype,
>                                              session->key, session->keylen,
>                                              &local_error);
> 
> Passing non-null @local_error to qcrypto_akcipher_new().  This is wrong.
> When qcrypto_akcipher_new() fails and passes &local_error to
> error_setg(), error_setv()'s assertion will fail.
> 
> Two possible fixes:
> 
> 1. If continuing after cryptodev_lkcf_set_op_desc() is correct, we need
> to clear @local_error there.  Since it's not actually an error then, we
> should almost certainly not use error_report_err() there.  *Maybe*
> warn_report_err().
> 
> 2. If continuing is wrong, we probably need set @status (to what?) and
> goto out.
> 
> What is the correct fix?
> 

Hi,

It's fatal error of a crypto task, so it should not continue. setting 
status as VIRTIO_CRYPTO_ERR should be fine.

Thanks!

[remove Lei He from cc list, he has already resigned from bytedance]

>              if (!akcipher) {
>                  status = -VIRTIO_CRYPTO_ERR;
>                  goto out;
>              }
>          }
> 
>      [...]
> 
>      out:
>          if (key_id >= 0) {
>              keyctl_unlink(key_id, KCTL_KEY_RING);
>          }
>          task->status = status;
> 
>          qemu_mutex_lock(&task->lkcf->rsp_mutex);
>          if (QSIMPLEQ_EMPTY(&task->lkcf->responses)) {
>              kick = true;
>          }
>          QSIMPLEQ_INSERT_TAIL(&task->lkcf->responses, task, queue);
>          qemu_mutex_unlock(&task->lkcf->rsp_mutex);
> 
>          if (kick) {
>              eventfd_write(task->lkcf->eventfd, 1);
>          }
>      }
> 


