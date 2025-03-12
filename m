Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC7AC2BA1B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 08:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsHBE-0003we-JY; Wed, 12 Mar 2025 04:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsHAs-0003sZ-4E
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsHAp-000358-SB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741767041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=QYTDfH46++q7wEEKJJsU8D5HdUcvBLSBrV30K1lhG+o=;
 b=ENZTY/yjNX+7oa6T9y5JsFpautDbdj886KbVH+3mfEhtRjvbsaAAy7hu708CfzCW8z3mct
 aREDrKeRo90TFsmxfCrKBLjAevNVrr12Bz8/H0BxBbFxvJSVIFhU+S63yiLKEiA8rvo9DU
 VdrTUkjMPp9t50xXQGoCGBEN46v7Dao=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-1D7IT9JFPoezSkF60wZVNA-1; Wed,
 12 Mar 2025 04:10:39 -0400
X-MC-Unique: 1D7IT9JFPoezSkF60wZVNA-1
X-Mimecast-MFC-AGG-ID: 1D7IT9JFPoezSkF60wZVNA_1741767038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA5521955BD2; Wed, 12 Mar 2025 08:10:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E27FF1801751; Wed, 12 Mar 2025 08:10:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A17021E675E; Wed, 12 Mar 2025 09:10:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei He <helei.sig11@bytedance.com>, Michael S. Tsirkin <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Zhenwei Pi
 <pizhenwei@bytedance.com>
Subject: Bad error handling in cryptodev_lkcf_execute_task(), need advice
Date: Wed, 12 Mar 2025 09:10:31 +0100
Message-ID: <87cyemoeiw.fsf@pond.sub.org>
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

scripts/coccinelle/error-use-after-free.cocci led me to this function:

    static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
    {
        CryptoDevBackendLKCFSession *session = task->sess;
        CryptoDevBackendAsymOpInfo *asym_op_info;
        bool kick = false;
        int ret, status, op_code = task->op_info->op_code;
        size_t p8info_len;
        g_autofree uint8_t *p8info = NULL;
        Error *local_error = NULL;
        key_serial_t key_id = INVALID_KEY_ID;
        char op_desc[64];
        g_autoptr(QCryptoAkCipher) akcipher = NULL;

        /**
         * We only offload private key session:
         * 1. currently, the Linux kernel can only accept public key wrapped
         * with X.509 certificates, but unfortunately the cost of making a
         * ceritificate with public key is too expensive.
         * 2. generally, public key related compution is fast, just compute it with
         * thread-pool.
         */
        if (session->keytype == QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
            if (qcrypto_akcipher_export_p8info(&session->akcipher_opts,
                                               session->key, session->keylen,
                                               &p8info, &p8info_len,
                                               &local_error) != 0 ||
                cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
                                           sizeof(op_desc), &local_error) != 0) {
                error_report_err(local_error);

Reporting an error, but continue anyway.  This is suspicious.

Note for later: @local_error is now non-null.

            } else {
                key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
                                 p8info, p8info_len, KCTL_KEY_RING);
            }
        }

        if (key_id < 0) {
            if (!qcrypto_akcipher_supports(&session->akcipher_opts)) {
                status = -VIRTIO_CRYPTO_NOTSUPP;
                goto out;
            }
            akcipher = qcrypto_akcipher_new(&session->akcipher_opts,
                                            session->keytype,
                                            session->key, session->keylen,
                                            &local_error);

Passing non-null @local_error to qcrypto_akcipher_new().  This is wrong.
When qcrypto_akcipher_new() fails and passes &local_error to
error_setg(), error_setv()'s assertion will fail.

Two possible fixes:

1. If continuing after cryptodev_lkcf_set_op_desc() is correct, we need
to clear @local_error there.  Since it's not actually an error then, we
should almost certainly not use error_report_err() there.  *Maybe*
warn_report_err().

2. If continuing is wrong, we probably need set @status (to what?) and
goto out.

What is the correct fix?

            if (!akcipher) {
                status = -VIRTIO_CRYPTO_ERR;
                goto out;
            }
        }

    [...]

    out:
        if (key_id >= 0) {
            keyctl_unlink(key_id, KCTL_KEY_RING);
        }
        task->status = status;

        qemu_mutex_lock(&task->lkcf->rsp_mutex);
        if (QSIMPLEQ_EMPTY(&task->lkcf->responses)) {
            kick = true;
        }
        QSIMPLEQ_INSERT_TAIL(&task->lkcf->responses, task, queue);
        qemu_mutex_unlock(&task->lkcf->rsp_mutex);

        if (kick) {
            eventfd_write(task->lkcf->eventfd, 1);
        }
    }


