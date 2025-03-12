Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3F8C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsKnQ-0003nf-PN; Wed, 12 Mar 2025 08:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsKn0-0003Y5-Vc
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsKmy-0006Ov-DV
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741780937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dk3NmiJxeXQ6/3Qkx/aSmUf7RqJGj7R5Va95FJHrceQ=;
 b=agpUO1nJ2th8KX0YlnV/OYPIocP0+pIeXQhTnEt6l/qIIw+twIfufvWm8bCVh6UdnC20Ke
 NqnH8PdXIPWf4lZCN87xwPTIQThy8eTqV4SaAiYqQ0YWq4VFE9QKQ+15AhDuQteyGaXKaQ
 DYpSZluk7Ebutf9Gv4s6b90x39dHs/8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-WqB6oQDVNVKZ5WLJYN3Awg-1; Wed,
 12 Mar 2025 08:02:16 -0400
X-MC-Unique: WqB6oQDVNVKZ5WLJYN3Awg-1
X-Mimecast-MFC-AGG-ID: WqB6oQDVNVKZ5WLJYN3Awg_1741780934
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8633719560B4; Wed, 12 Mar 2025 12:02:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 553691800268; Wed, 12 Mar 2025 12:02:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 594CA21E66C4; Wed, 12 Mar 2025 13:02:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: qemu-devel@nongnu.org,  arei.gonglei@huawei.com
Subject: Re: [PATCH] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
In-Reply-To: <df42e188-00b7-46cc-8853-163798c62ac2@bytedance.com> (zhenwei
 pi's message of "Wed, 12 Mar 2025 18:28:51 +0800")
References: <20250312101131.1615777-1-armbru@redhat.com>
 <df42e188-00b7-46cc-8853-163798c62ac2@bytedance.com>
Date: Wed, 12 Mar 2025 13:02:09 +0100
Message-ID: <87r032ihj2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

zhenwei pi <pizhenwei@bytedance.com> writes:

> On 3/12/25 18:11, Markus Armbruster wrote:
>> When cryptodev_lkcf_set_op_desc() fails, we report an error, but
>> continue anyway.  This is wrong.  We then pass a non-null @local_error
>> to various functions, which could easily fail error_setv()'s assertion
>> on failure.
>> 
>> Fail the function instead.
>> 
>> When qcrypto_akcipher_new() fails, we fail the function without
>> reporting the error.  This leaks the Error object.
>> 
>> Add the missing error reporting.  This also frees the Error object.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   backends/cryptodev-lkcf.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> 
>> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
>> index 41cf24b737..352c3e8958 100644
>> --- a/backends/cryptodev-lkcf.c
>> +++ b/backends/cryptodev-lkcf.c
>> @@ -330,6 +330,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>>               cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
>>                                          sizeof(op_desc), &local_error) != 0) {
>>               error_report_err(local_error);
>> +            status = -VIRTIO_CRYPTO_ERR;
>> +            goto out;
>>           } else {
>>               key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
>>                                p8info, p8info_len, KCTL_KEY_RING);
>> @@ -346,6 +348,7 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
>>                                           session->key, session->keylen,
>>                                           &local_error);
>>           if (!akcipher) {
>> +            error_report_err(local_error);
>>               status = -VIRTIO_CRYPTO_ERR;
>>               goto out;
>>           }
>
> What about moving several 'error_report_err(local_error);' to:
>
> out:
> if (local_error) {
>      error_report_err(local_error);
> }

I figure you suggest something like the appended patch.  But this led me
to another question.  Consider:

        asym_op_info = task->op_info->u.asym_op_info;
        switch (op_code) {
        case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
            if (key_id >= 0) {
                ret = keyctl_pkey_encrypt(key_id, op_desc,
                    asym_op_info->src, asym_op_info->src_len,
                    asym_op_info->dst, asym_op_info->dst_len);

When keyctl_pkey_encrypt() fails, @local_error remains unset.

            } else {
                ret = qcrypto_akcipher_encrypt(akcipher,
                    asym_op_info->src, asym_op_info->src_len,
                    asym_op_info->dst, asym_op_info->dst_len, &local_error);
            }
            break;

        [More cases that can also fail without setting @local_error]

        default:
            error_setg(&local_error, "Unknown opcode: %u", op_code);
            status = -VIRTIO_CRYPTO_ERR;
            goto out;
        }

        if (ret < 0) {

The switch failed.

            if (!local_error) {

If it failed without setting @local_error, we report a generic error
*unless* errno is EKEYREJECTED.

Aside: checking errno this far from whatever set it is asking for
trouble.  It gets overwritten easily.

                if (errno != EKEYREJECTED) {
                    error_report("Failed do operation with keyctl: %d", errno);
                }

If it failed with setting @local_error, we report that error.

            } else {
                error_report_err(local_error);
            }
            status = op_code == VIRTIO_CRYPTO_AKCIPHER_VERIFY ?
                -VIRTIO_CRYPTO_KEY_REJECTED : -VIRTIO_CRYPTO_ERR;

Status set to negative value.  This will be assigned to task->status
below.

It can therefore become negative *silently* (i.e. without an error
report).  Why is this okay?

        } else {
            status = VIRTIO_CRYPTO_OK;
            asym_op_info->dst_len = ret;
        }

    out:
        if (key_id >= 0) {
            keyctl_unlink(key_id, KCTL_KEY_RING);
        }
        task->status = status;



diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 41cf24b737..0e20797cb3 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -329,7 +329,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
                                            &local_error) != 0 ||
             cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
                                        sizeof(op_desc), &local_error) != 0) {
-            error_report_err(local_error);
+            status = -VIRTIO_CRYPTO_ERR;
+            goto out;
         } else {
             key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
                              p8info, p8info_len, KCTL_KEY_RING);
@@ -410,10 +411,9 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
     if (ret < 0) {
         if (!local_error) {
             if (errno != EKEYREJECTED) {
-                error_report("Failed do operation with keyctl: %d", errno);
+                error_setg_errno(&local_error,
+                                 "Failed do operation with keyctl: %d");
             }
-        } else {
-            error_report_err(local_error);
         }
         status = op_code == VIRTIO_CRYPTO_AKCIPHER_VERIFY ?
             -VIRTIO_CRYPTO_KEY_REJECTED : -VIRTIO_CRYPTO_ERR;
@@ -423,6 +423,9 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
     }
 
 out:
+    if (local_error) {
+        error_report_err(local_error);
+    }
     if (key_id >= 0) {
         keyctl_unlink(key_id, KCTL_KEY_RING);
     }


