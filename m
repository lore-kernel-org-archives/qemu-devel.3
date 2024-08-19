Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4472AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 10:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfzwa-0003x8-43; Mon, 19 Aug 2024 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sfzwX-0003w7-HR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sfzwU-0008LR-KB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724064533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SSORt3o46ppt3E1b8/QbdBVhysubwrYntWzIF1MRJOI=;
 b=QPxmjdt0TU3RgB7dnOxKDMAO6SzR2BSxByxJvVHkjjZ6FJ9OJGm4ds1PocsLkpunZqBkwI
 PZfrvLygpNIqDlG5KOox9WwfsF6FAJRcHrm9XPW/KObupJCw7BKutag9cMETU3Xd0W5v1E
 vMnb2gYnCcIlpPAJgzqP8wQSzJpr3bo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-k2fswHR7PpuMHhDnXsG8jw-1; Mon,
 19 Aug 2024 06:48:49 -0400
X-MC-Unique: k2fswHR7PpuMHhDnXsG8jw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F2A819560B4; Mon, 19 Aug 2024 10:48:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FECA1955BED; Mon, 19 Aug 2024 10:48:42 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:48:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v4 3/6] device/virtio-nsm: Support for Nitro Secure
 Module device
Message-ID: <ZsMjB4q7akK2lu0L@redhat.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-4-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240818114257.21456-4-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 18, 2024 at 05:42:54PM +0600, Dorjoy Chowdhury wrote:
> Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves for
> stripped down TPM functionality like cryptographic attestation. The
> requests to and responses from NSM device are CBOR[2] encoded.
> 
> This commit adds support for NSM device in QEMU. Although related to
> AWS Nitro Enclaves, the virito-nsm device is independent and can be
> used in other machine types as well. The libcbor[3] library has been
> used for the CBOR encoding and decoding functionalities.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> [2] http://cbor.io/
> [3] https://libcbor.readthedocs.io/en/latest/
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  MAINTAINERS                      |   10 +
>  hw/virtio/Kconfig                |    5 +
>  hw/virtio/cbor-helpers.c         |  292 ++++++
>  hw/virtio/meson.build            |    4 +
>  hw/virtio/virtio-nsm-pci.c       |   73 ++
>  hw/virtio/virtio-nsm.c           | 1648 ++++++++++++++++++++++++++++++
>  include/hw/virtio/cbor-helpers.h |   43 +
>  include/hw/virtio/virtio-nsm.h   |   59 ++
>  8 files changed, 2134 insertions(+)
>  create mode 100644 hw/virtio/cbor-helpers.c
>  create mode 100644 hw/virtio/virtio-nsm-pci.c
>  create mode 100644 hw/virtio/virtio-nsm.c
>  create mode 100644 include/hw/virtio/cbor-helpers.h
>  create mode 100644 include/hw/virtio/virtio-nsm.h
> 

> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 621fc65454..7ccb61cf74 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -48,12 +48,15 @@ else
>    system_virtio_ss.add(files('vhost-stub.c'))
>  endif
>  
> +libcbor = dependency('libcbor', version: '>=0.7.0')

In the following patch I suggest that we should have this at the top level
meson.build. Now that I see you're referencing this twice in different
places, we definitely want it in the top meson.build.

ALso the CI changes in Mention in the following patch should be in whatever
patch first introduces the libcbor dependency.



> diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
> new file mode 100644
> index 0000000000..e91848a2b0
> --- /dev/null
> +++ b/hw/virtio/virtio-nsm.c

> +static bool add_protected_header_to_cose(cbor_item_t *cose)
> +{
> +    cbor_item_t *map = NULL;
> +    cbor_item_t *key = NULL;
> +    cbor_item_t *value = NULL;
> +    cbor_item_t *bs = NULL;
> +    size_t len;
> +    bool r = false;
> +    size_t buf_len = 4096;
> +    uint8_t *buf = g_malloc(buf_len);

g_autofree avoids the manual  g_free call.

> +
> +    map = cbor_new_definite_map(1);
> +    if (!map) {
> +        goto cleanup;
> +    }
> +    key = cbor_build_uint8(1);
> +    if (!key) {
> +        goto cleanup;
> +    }
> +    value = cbor_new_int8();
> +    if (!value) {
> +        goto cleanup;
> +    }
> +    cbor_mark_negint(value);
> +    /* we don't actually sign the data, so we use -1 as the 'alg' value */
> +    cbor_set_uint8(value, 0);
> +
> +    if (!qemu_cbor_map_add(map, key, value)) {
> +        goto cleanup;
> +    }
> +
> +    len = cbor_serialize(map, buf, buf_len);
> +    if (len == 0) {
> +        goto cleanup_map;
> +    }
> +
> +    bs = cbor_build_bytestring(buf, len);
> +    if (!bs) {
> +        goto cleanup_map;
> +    }
> +    if (!qemu_cbor_array_push(cose, bs)) {
> +        cbor_decref(&bs);
> +        goto cleanup_map;
> +    }
> +    r = true;
> +    goto cleanup_map;
> +
> + cleanup:
> +    if (key) {
> +        cbor_decref(&key);
> +    }
> +    if (value) {
> +        cbor_decref(&value);
> +    }
> +
> + cleanup_map:
> +    if (map) {
> +        cbor_decref(&map);
> +    }
> +    g_free(buf);
> +    return r;
> +}
> +



> +static bool handle_Attestation(VirtIONSM *vnsm, struct iovec *request,
> +                               struct iovec *response, Error **errp)
> +{
> +    cbor_item_t *root = NULL;
> +    cbor_item_t *cose = NULL;
> +    cbor_item_t *nested_map;
> +    size_t len;
> +    NSMAttestationReq nsm_req;
> +    enum NSMResponseTypes type;
> +    bool r = false;
> +    size_t buf_len = 16384;
> +    uint8_t *buf = g_malloc(buf_len);

Another suitable for g_autofree

> +
> +    type = get_nsm_attestation_req(request->iov_base, request->iov_len,
> +                                   &nsm_req);
> +    if (type != NSM_SUCCESS) {
> +        if (error_response(response, type, errp)) {
> +            r = true;
> +        }
> +        goto out;
> +    }
> +
> +    cose = cbor_new_definite_array(4);
> +    if (!cose) {
> +        goto err;
> +    }
> +    if (!add_protected_header_to_cose(cose)) {
> +        goto err;
> +    }
> +    if (!add_unprotected_header_to_cose(cose)) {
> +        goto err;
> +    }
> +
> +    if (nsm_req.public_key_len > 0) {
> +        memcpy(vnsm->public_key, nsm_req.public_key, nsm_req.public_key_len);
> +        vnsm->public_key_len = nsm_req.public_key_len;
> +    }
> +    if (nsm_req.user_data_len > 0) {
> +        memcpy(vnsm->user_data, nsm_req.user_data, nsm_req.user_data_len);
> +        vnsm->user_data_len = nsm_req.user_data_len;
> +    }
> +    if (nsm_req.nonce_len > 0) {
> +        memcpy(vnsm->nonce, nsm_req.nonce, nsm_req.nonce_len);
> +        vnsm->nonce_len = nsm_req.nonce_len;
> +    }
> +
> +    if (!add_payload_to_cose(cose, vnsm)) {
> +        goto err;
> +    }
> +
> +    if (!add_signature_to_cose(cose)) {
> +        goto err;
> +    }
> +
> +    len = cbor_serialize(cose, buf, buf_len);
> +    if (len == 0) {
> +        goto err;
> +    }
> +
> +    root = cbor_new_definite_map(1);
> +    if (!root) {
> +        goto err;
> +    }
> +    if (!qemu_cbor_add_map_to_map(root, "Attestation", 1, &nested_map)) {
> +        goto err;
> +    }
> +    if (!qemu_cbor_add_bytestring_to_map(nested_map, "document", buf, len)) {
> +        goto err;
> +    }
> +
> +    len = cbor_serialize(root, response->iov_base, response->iov_len);
> +    if (len == 0) {
> +        if (error_response(response, NSM_BUFFER_TOO_SMALL, errp)) {
> +            r = true;
> +        }
> +        goto out;
> +    }
> +
> +    response->iov_len = len;
> +    r = true;
> +
> + out:
> +    if (root) {
> +        cbor_decref(&root);
> +    }
> +    if (cose) {
> +        cbor_decref(&cose);
> +    }
> +    g_free(buf);
> +    return r;
> +
> + err:
> +    error_setg(errp, "Failed to initialize Attestation response");
> +    goto out;
> +}
> +

> +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *out_elem = NULL;
> +    VirtQueueElement *in_elem = NULL;

Both can be 'g_autofree' , to remove the duplicated g_free calls

> +    VirtIONSM *vnsm = VIRTIO_NSM(vdev);
> +    Error *err = NULL;
> +
> +    out_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!out_elem) {
> +        /* nothing in virtqueue */
> +        return;
> +    }
> +
> +    if (out_elem->out_num != 1) {
> +        virtio_error(vdev, "Expected one request buffer first in virtqueue");
> +        goto cleanup;
> +    }
> +
> +    in_elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!in_elem) {
> +        virtio_error(vdev, "Expected response buffer after request buffer "
> +                     "in virtqueue");
> +        goto cleanup;
> +    }
> +    if (in_elem->in_num != 1) {
> +        virtio_error(vdev, "Expected one response buffer after request buffer "
> +                     "in virtqueue");
> +        goto cleanup;
> +    }
> +
> +    if (!get_nsm_request_response(vnsm, out_elem->out_sg, in_elem->in_sg,
> +                                  &err)) {
> +        error_report_err(err);
> +        virtio_error(vdev, "Failed to get NSM request response");
> +        goto cleanup;
> +    }
> +
> +    virtqueue_push(vq, out_elem, 0);
> +    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
> +    g_free(out_elem);
> +    g_free(in_elem);
> +    virtio_notify(vdev, vq);
> +    return;
> +
> + cleanup:
> +    if (out_elem) {
> +        virtqueue_detach_element(vq, out_elem, 0);
> +    }
> +    if (in_elem) {
> +        virtqueue_detach_element(vq, in_elem, 0);
> +    }
> +    g_free(out_elem);
> +    g_free(in_elem);
> +    return;
> +}



> diff --git a/include/hw/virtio/virtio-nsm.h b/include/hw/virtio/virtio-nsm.h
> new file mode 100644
> index 0000000000..7901c19fe4
> --- /dev/null
> +++ b/include/hw/virtio/virtio-nsm.h
> @@ -0,0 +1,59 @@
> +/*
> + * AWS Nitro Secure Module (NSM) device
> + *
> + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#ifndef QEMU_VIRTIO_NSM_H
> +#define QEMU_VIRTIO_NSM_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "qom/object.h"
> +
> +#define NSM_MAX_PCRS 32
> +#define NSM_USER_DATA_MAX_SIZE 512
> +#define NSM_NONCE_MAX_SIZE 512
> +#define NSM_PUBLIC_KEY_MAX_SIZE 1024


> +#define SHA384_BYTE_LEN 48

Hmm, you've added this in two different headers now, which suggests
we should have it in a common header. include/qcrypto/hash.h is the
obvious place to put this, so how about adding

  #define QCRYPTO_HASH_DIGEST_LEN_MD5       16
  #define QCRYPTO_HASH_DIGEST_LEN_SHA1      20
  #define QCRYPTO_HASH_DIGEST_LEN_SHA224    28
  #define QCRYPTO_HASH_DIGEST_LEN_SHA256    32
  #define QCRYPTO_HASH_DIGEST_LEN_SHA384    48
  #define QCRYPTO_HASH_DIGEST_LEN_SHA512    64
  #define QCRYPTO_HASH_DIGEST_LEN_RIPEMD160 20

then updating qcrypto_hash_alg_size table to use these constants
too.

THis should be a standalone commit at the start of the series.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


