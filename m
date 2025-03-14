Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63203C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 08:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0VY-0008Os-A7; Fri, 14 Mar 2025 04:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tt0VR-0008OG-0m
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:35:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tt0VO-0005rE-4p
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:35:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso37182045ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1741941289; x=1742546089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8HbuZI52DDi2rIAbp/+KMPrO0b0q4wrtbF6byXMfpc=;
 b=L6Yt5VBXq+k7Py4D2oHBpGhBrgyKf2xvo/pkuDwbJQSMKO6++TLVajS46irDiJCEYG
 XCJXwxdS3896Fud1oLKYo4L8lc04qEnKeSly9jHJ0Jeh9gLVDHEuXRZVNl9M25mnReo8
 uFl1SyPqjpf+UvsWATqYKmisXj4ihll4m6mertIoWBFhcBjx5ioaia1Q0MUxf21AxPE8
 +JJj0sURbDAByPCaxFBcT+l0YGKytXSsp8eedoGwOfjccRsXCg8Xg1V9TJCz78pe2aOn
 tNYu9fixYRY/+BOggQKmSOcYXY5ofx1aAa+o6TH/IvKxAnxDq62gWr6Ha0tQzBGiIsXe
 sFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741941289; x=1742546089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8HbuZI52DDi2rIAbp/+KMPrO0b0q4wrtbF6byXMfpc=;
 b=hIadNzXJ9xPgBJRfzBqxKOnAkSeN5AG1hKckXb3Z6TU/cP/lMRZnlUVyqhma/Q0m1q
 7c0Htb7sTmb+r8Tnr/h4NM7+OAoDDUAkQSVAcpERkWZQPtXWPatkAXoWRGAYs0us4Qv6
 267tenpTK/hdf0OIy8tmANVrFFjFIrLASKiSCyaePB96Bo9kyngpJzHx6DhoNMHKFuQM
 8JyRHqaxtY8q2+BL61yhM8c+JqDKaBniWnhePmGYj2CCncgiQ0g/QWT6tFalPjGH1TDK
 IhmA2+i88VCgLdyfRoXKwwe4TWHyCLf7JBSCUjM31Q3sf75OZcb9SzK2RzdLnSQ/UcoE
 JVEQ==
X-Gm-Message-State: AOJu0YwHA15Nlv43DwrsU/db1Q3aFTZZb7jWt+4KExWJb5uNeUc7DMgB
 mqVVVMovf6hXtLh6ivHHJfs4S0l3DQcSQy4eaj1OI7foXhyryO4PqTov4+OOxkEn2WLn1K+rnpr
 7
X-Gm-Gg: ASbGncs/i5H8yxEFyRb19mvSAkXQDYaxzqbWeAsGYuEfMAPY2pF3maDJXGTYem/PD0s
 chbwmwwty6woxh4lluijAXD6dRJTyRRWlZfpdbUcI9U3zr99rMYKv9X6FzpNghwrUKdySu5z46c
 R4FutJMreerf/vWlgG0GpzB7ejELLL5mKnFxrPUWfGzlXNNAqbFVikhMsrrGk5GcbK3MIVALixb
 sDJ11Ecd9VbxzILvv4yImh0vt96jScCBY03Ffgt9ZGp6BrHrKsJAuYDh2r+iuFzLTiLV9/ULrDf
 YKWVwJitwxtUVnrOqdKixZIkIGXSSiuXNXmvruZUwbVsg2Lji58=
X-Google-Smtp-Source: AGHT+IE6wzm++N2XfcmUbovfL0BgmMluj41ODuX6ULB9V/oIA0ci4M1v66eEoTzijcuTHcU7FWOJlg==
X-Received: by 2002:a05:6a21:394c:b0:1f5:790c:947 with SMTP id
 adf61e73a8af0-1f5c11bb371mr2969625637.19.1741941288624; 
 Fri, 14 Mar 2025 01:34:48 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167df8csm2493951b3a.117.2025.03.14.01.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 01:34:48 -0700 (PDT)
Message-ID: <44db6eee-2cba-43f0-8977-382e44af3b6f@bytedance.com>
Date: Fri, 14 Mar 2025 16:34:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com
References: <20250312101131.1615777-1-armbru@redhat.com>
 <df42e188-00b7-46cc-8853-163798c62ac2@bytedance.com>
 <87r032ihj2.fsf@pond.sub.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <87r032ihj2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62c.google.com
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

Hi Markus,

Current code style seems buggy, I think the main reason is that the 
Error *errp is not generated at right place. keyctl_pkey_XXX fails 
without new error, qcrypto_akcipher_XXX fails with new error, but they 
are in the same switch-case code block. If we can separate crypto 
operations into two functions - cryptodev_lkcf_keyctl_op and 
cryptodev_lkcf_qakcipher_op, and the error is generate inside the 
functions, it may be handled easily. Then applying your changes, it seem 
more clear. What do you think?

+static inline int cryptodev_lkcf_keyctl_op(key_serial_t key_id, int 
op_code, char *op_desc,
+                      CryptoDevBackendAsymOpInfo *asym_op_info, Error 
**errp)
+{
+    int ret = -1;
+
+    switch (op_code) {
+    case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
+        ret = keyctl_pkey_encrypt(key_id, op_desc,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len);
+        break;
+
+    case VIRTIO_CRYPTO_AKCIPHER_DECRYPT:
+        ret = keyctl_pkey_decrypt(key_id, op_desc,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len);
+        break;
+
+    case VIRTIO_CRYPTO_AKCIPHER_SIGN:
+        ret = keyctl_pkey_sign(key_id, op_desc,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len);
+        break;
+
+    case VIRTIO_CRYPTO_AKCIPHER_VERIFY:
+        ret = keyctl_pkey_verify(key_id, op_desc,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len);
+        break;
+
+    default:
+        error_setg(errp, "Unknown opcode: %u", op_code);
+    }
+
+    if (ret && !*errp) {
+        error_setg_errno(errp, errno, "Failed do operation with keyctl");
+    }
+
+    return ret;
+}
+
+static inline int cryptodev_lkcf_qakcipher_op(QCryptoAkCipher 
*akcipher, int op_code, char *op_desc,
+                      CryptoDevBackendAsymOpInfo *asym_op_info, Error 
**errp)
+{
+    int ret = -1;
+
+    switch (op_code) {
+    case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
+         ret = qcrypto_akcipher_encrypt(akcipher,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len, errp);
+        break;
+
+    case VIRTIO_CRYPTO_AKCIPHER_DECRYPT:
+        ret = qcrypto_akcipher_decrypt(akcipher,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len, errp);
+        break;
+
+    case VIRTIO_CRYPTO_AKCIPHER_SIGN:
+        ret = qcrypto_akcipher_sign(akcipher,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len, errp);
+        break;
+
+    case VIRTIO_CRYPTO_AKCIPHER_VERIFY:
+        ret = qcrypto_akcipher_verify(akcipher,
+            asym_op_info->src, asym_op_info->src_len,
+            asym_op_info->dst, asym_op_info->dst_len, errp);
+        break;
+
+    default:
+        error_setg(errp, "Unknown opcode: %u", op_code);
+    }
+
+    return ret;
+}
+
  static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
  {
      CryptoDevBackendLKCFSession *session = task->sess;
@@ -336,6 +414,7 @@ static void 
cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
          }
      }

+    asym_op_info = task->op_info->u.asym_op_info;
      if (key_id < 0) {
          if (!qcrypto_akcipher_supports(&session->akcipher_opts)) {
              status = -VIRTIO_CRYPTO_NOTSUPP;
@@ -349,72 +428,13 @@ static void 
cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
              status = -VIRTIO_CRYPTO_ERR;
              goto out;
          }
-    }
-
-    asym_op_info = task->op_info->u.asym_op_info;
-    switch (op_code) {
-    case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
-        if (key_id >= 0) {
-            ret = keyctl_pkey_encrypt(key_id, op_desc,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len);
-        } else {
-            ret = qcrypto_akcipher_encrypt(akcipher,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len, &local_error);
-        }
-        break;

-    case VIRTIO_CRYPTO_AKCIPHER_DECRYPT:
-        if (key_id >= 0) {
-            ret = keyctl_pkey_decrypt(key_id, op_desc,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len);
-        } else {
-            ret = qcrypto_akcipher_decrypt(akcipher,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len, &local_error);
-        }
-        break;
-
-    case VIRTIO_CRYPTO_AKCIPHER_SIGN:
-        if (key_id >= 0) {
-            ret = keyctl_pkey_sign(key_id, op_desc,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len);
-        } else {
-            ret = qcrypto_akcipher_sign(akcipher,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len, &local_error);
-        }
-        break;
-
-    case VIRTIO_CRYPTO_AKCIPHER_VERIFY:
-        if (key_id >= 0) {
-            ret = keyctl_pkey_verify(key_id, op_desc,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len);
-        } else {
-            ret = qcrypto_akcipher_verify(akcipher,
-                asym_op_info->src, asym_op_info->src_len,
-                asym_op_info->dst, asym_op_info->dst_len, &local_error);
-        }
-        break;
-
-    default:
-        error_setg(&local_error, "Unknown opcode: %u", op_code);
-        status = -VIRTIO_CRYPTO_ERR;
-        goto out;
+        ret = cryptodev_lkcf_qakcipher_op(akcipher, op_code, op_desc, 
asym_op_info, &local_error);
+    } else {
+        ret = cryptodev_lkcf_keyctl_op(key_id, op_code, op_desc, 
asym_op_info, &local_error);
      }

      if (ret < 0) {
-        if (!local_error) {
-            if (errno != EKEYREJECTED) {
-                error_report("Failed do operation with keyctl: %d", errno);
-            }
-        } else {
-            error_report_err(local_error);
-        }
          status = op_code == VIRTIO_CRYPTO_AKCIPHER_VERIFY ?
              -VIRTIO_CRYPTO_KEY_REJECTED : -VIRTIO_CRYPTO_ERR;
      } else {



On 3/12/25 20:02, Markus Armbruster wrote:
> zhenwei pi <pizhenwei@bytedance.com> writes:
> 
>> On 3/12/25 18:11, Markus Armbruster wrote:
>>> When cryptodev_lkcf_set_op_desc() fails, we report an error, but
>>> continue anyway.  This is wrong.  We then pass a non-null @local_error
>>> to various functions, which could easily fail error_setv()'s assertion
>>> on failure.
>>>
>>> Fail the function instead.
>>>
>>> When qcrypto_akcipher_new() fails, we fail the function without
>>> reporting the error.  This leaks the Error object.
>>>
>>> Add the missing error reporting.  This also frees the Error object.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    backends/cryptodev-lkcf.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
>>> index 41cf24b737..352c3e8958 100644
>>> --- a/backends/cryptodev-lkcf.c
>>> +++ b/backends/cryptodev-lkcf.c
>>> @@ -330,6 +330,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>>>                cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
>>>                                           sizeof(op_desc), &local_error) != 0) {
>>>                error_report_err(local_error);
>>> +            status = -VIRTIO_CRYPTO_ERR;
>>> +            goto out;
>>>            } else {
>>>                key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
>>>                                 p8info, p8info_len, KCTL_KEY_RING);
>>> @@ -346,6 +348,7 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>>>                                            session->key, session->keylen,
>>>                                            &local_error);
>>>            if (!akcipher) {
>>> +            error_report_err(local_error);
>>>                status = -VIRTIO_CRYPTO_ERR;
>>>                goto out;
>>>            }
>>
>> What about moving several 'error_report_err(local_error);' to:
>>
>> out:
>> if (local_error) {
>>       error_report_err(local_error);
>> }
> 
> I figure you suggest something like the appended patch.  But this led me
> to another question.  Consider:
> 
>          asym_op_info = task->op_info->u.asym_op_info;
>          switch (op_code) {
>          case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
>              if (key_id >= 0) {
>                  ret = keyctl_pkey_encrypt(key_id, op_desc,
>                      asym_op_info->src, asym_op_info->src_len,
>                      asym_op_info->dst, asym_op_info->dst_len);
> 
> When keyctl_pkey_encrypt() fails, @local_error remains unset.
> 
>              } else {
>                  ret = qcrypto_akcipher_encrypt(akcipher,
>                      asym_op_info->src, asym_op_info->src_len,
>                      asym_op_info->dst, asym_op_info->dst_len, &local_error);
>              }
>              break;
> 
>          [More cases that can also fail without setting @local_error]
> 
>          default:
>              error_setg(&local_error, "Unknown opcode: %u", op_code);
>              status = -VIRTIO_CRYPTO_ERR;
>              goto out;
>          }
> 
>          if (ret < 0) {
> 
> The switch failed.
> 
>              if (!local_error) {
> 
> If it failed without setting @local_error, we report a generic error
> *unless* errno is EKEYREJECTED.
> 
> Aside: checking errno this far from whatever set it is asking for
> trouble.  It gets overwritten easily.
> 
>                  if (errno != EKEYREJECTED) {
>                      error_report("Failed do operation with keyctl: %d", errno);
>                  }
> 
> If it failed with setting @local_error, we report that error.
> 
>              } else {
>                  error_report_err(local_error);
>              }
>              status = op_code == VIRTIO_CRYPTO_AKCIPHER_VERIFY ?
>                  -VIRTIO_CRYPTO_KEY_REJECTED : -VIRTIO_CRYPTO_ERR;
> 
> Status set to negative value.  This will be assigned to task->status
> below.
> 
> It can therefore become negative *silently* (i.e. without an error
> report).  Why is this okay?
> 
>          } else {
>              status = VIRTIO_CRYPTO_OK;
>              asym_op_info->dst_len = ret;
>          }
> 
>      out:
>          if (key_id >= 0) {
>              keyctl_unlink(key_id, KCTL_KEY_RING);
>          }
>          task->status = status;
> 
> 
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 41cf24b737..0e20797cb3 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -329,7 +329,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>                                              &local_error) != 0 ||
>               cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
>                                          sizeof(op_desc), &local_error) != 0) {
> -            error_report_err(local_error);
> +            status = -VIRTIO_CRYPTO_ERR;
> +            goto out;
>           } else {
>               key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
>                                p8info, p8info_len, KCTL_KEY_RING);
> @@ -410,10 +411,9 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>       if (ret < 0) {
>           if (!local_error) {
>               if (errno != EKEYREJECTED) {
> -                error_report("Failed do operation with keyctl: %d", errno);
> +                error_setg_errno(&local_error,
> +                                 "Failed do operation with keyctl: %d");
>               }
> -        } else {
> -            error_report_err(local_error);
>           }
>           status = op_code == VIRTIO_CRYPTO_AKCIPHER_VERIFY ?
>               -VIRTIO_CRYPTO_KEY_REJECTED : -VIRTIO_CRYPTO_ERR;
> @@ -423,6 +423,9 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>       }
>   
>   out:
> +    if (local_error) {
> +        error_report_err(local_error);
> +    }
>       if (key_id >= 0) {
>           keyctl_unlink(key_id, KCTL_KEY_RING);
>       }
> 


