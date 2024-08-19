Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD48C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 10:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfzlt-0005I6-Iq; Mon, 19 Aug 2024 06:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sfzls-0005Hc-Rx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sfzlp-0006gs-NJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724063871;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y2M+WmXbfFlFvtknci35g93YfmX2VjFtWiY/7EjxODs=;
 b=BYVdcSn7iD4uwul18HLhfD8gzZfOC7vATZm3Hr3QMwoh/xG0gqBFDRiFqruNSsLdne8lna
 dorJqs0SbGrNIA+sWAwI/8ngIsb2aWfz2OmIDA1YzdkPfF073BKZn8HC0qUchmZzbSn8et
 3i8MH4gVUUUSsoxlFxz44UXitcaDfmY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-pS56cpPuN_GFIVaqMlqokg-1; Mon,
 19 Aug 2024 06:37:48 -0400
X-MC-Unique: pS56cpPuN_GFIVaqMlqokg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 661DE19560A2; Mon, 19 Aug 2024 10:37:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF76619560A3; Mon, 19 Aug 2024 10:37:40 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:37:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
Message-ID: <ZsMgcUtCvXqbYigI@redhat.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240818114257.21456-5-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Sun, Aug 18, 2024 at 05:42:55PM +0600, Dorjoy Chowdhury wrote:
> AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> is used for stripped down TPM functionality like attestation. This commit
> adds the built-in NSM device in the nitro-enclave machine type.
> 
> In Nitro Enclaves, all the PCRs start in a known zero state and the first
> 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
> contain the SHA384 hashes related to the EIF file used to boot the
> VM for validation.
> 
> Some optional nitro-enclave machine options have been added:
>     - 'id': Enclave identifier, reflected in the module-id of the NSM
> device. If not provided, a default id will be set.
>     - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> of the NSM device.
>     - 'parent-id': Parent instance identifier, reflected in PCR4 of the
> NSM device.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  crypto/meson.build              |   2 +-
>  crypto/x509-utils.c             |  73 +++++++++++
>  include/crypto/x509-utils.h     |  22 ++++

Preferrably add these 3 in a standlone commit, since its is good practice
to separate commits adding infra, from commits adding usage of infra.

>  hw/core/eif.c                   | 225 +++++++++++++++++++++++++++++---
>  hw/core/eif.h                   |   5 +-
>  hw/core/meson.build             |   4 +-
>  hw/i386/Kconfig                 |   1 +
>  hw/i386/nitro_enclave.c         | 141 +++++++++++++++++++-
>  include/hw/i386/nitro_enclave.h |  26 ++++
>  9 files changed, 479 insertions(+), 20 deletions(-)
>  create mode 100644 crypto/x509-utils.c
>  create mode 100644 include/crypto/x509-utils.h
> 
> diff --git a/crypto/meson.build b/crypto/meson.build
> index c46f9c22a7..09633194ed 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -62,7 +62,7 @@ endif
>  if gcrypt.found()
>    util_ss.add(gcrypt, files('random-gcrypt.c'))
>  elif gnutls.found()
> -  util_ss.add(gnutls, files('random-gnutls.c'))
> +  util_ss.add(gnutls, files('random-gnutls.c', 'x509-utils.c'))
>  elif get_option('rng_none')
>    util_ss.add(files('random-none.c'))
>  else

This logic block is handling preferences for the RNG impl.

We want to be compiling x509-utils.c *anytime* gnutls is
found, regardless of what we prioritize for RNG backend.
Also it should be added to crypto_ss, not util_ss.

So put this as its own standalone block

  if gnutls.found()
    crypto_ss.add(files('x509-utils.c'))
  endif

> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> new file mode 100644
> index 0000000000..2422eb995c
> --- /dev/null
> +++ b/crypto/x509-utils.c
> @@ -0,0 +1,73 @@
> +/*
> + * X.509 certificate related helpers
> + *
> + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "crypto/x509-utils.h"
> +#include <gnutls/gnutls.h>
> +#include <gnutls/crypto.h>
> +#include <gnutls/x509.h>
> +
> +static int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {

Can make this 'const' too

> +    [QCRYPTO_HASH_ALG_MD5] = GNUTLS_DIG_MD5,
> +    [QCRYPTO_HASH_ALG_SHA1] = GNUTLS_DIG_SHA1,
> +    [QCRYPTO_HASH_ALG_SHA224] = GNUTLS_DIG_SHA224,
> +    [QCRYPTO_HASH_ALG_SHA256] = GNUTLS_DIG_SHA256,
> +    [QCRYPTO_HASH_ALG_SHA384] = GNUTLS_DIG_SHA384,
> +    [QCRYPTO_HASH_ALG_SHA512] = GNUTLS_DIG_SHA512,
> +    [QCRYPTO_HASH_ALG_RIPEMD160] = GNUTLS_DIG_RMD160,
> +};
> +
> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgorithm alg,
> +                                      uint8_t **result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    int ret;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};

Assign '*result = NULL' &&  '*resultlen = 0' here at the start, so we
have clear semantics on failure.


> +
> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        error_setg(errp, "Unknown hash algorithm");
> +        return -1;
> +    }
> +
> +    gnutls_x509_crt_init(&crt);
> +
> +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    ret = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +    if (*resultlen == 0) {
> +        *resultlen = ret;
> +        *result = g_new0(uint8_t, *resultlen);
> +    } else if (*resultlen < ret) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than hash %d",
> +                   *resultlen, ret);
> +        goto cleanup;
> +    }
> +
> +    if (gnutls_x509_crt_get_fingerprint(crt,
> +                                        qcrypto_to_gnutls_hash_alg_map[alg],
> +                                        *result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get fingerprint from certificate");
> +        goto cleanup;

We should free(*result) and *result = NULL; && *resultlen = 0  here to
undo the previous step.

> +    }
> +
> +    return 0;
> +
> + cleanup:


> +    gnutls_x509_crt_deinit(crt);
> +    return -1;
> +}
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> index 5558879a96..8e15142d36 100644
> --- a/hw/core/eif.c
> +++ b/hw/core/eif.c
> @@ -11,7 +11,10 @@
>  #include "qemu/osdep.h"
>  #include "qemu/bswap.h"
>  #include "qapi/error.h"
> +#include "crypto/hash.h"
> +#include "crypto/x509-utils.h"
>  #include <zlib.h> /* for crc32 */
> +#include <cbor.h>
>  
>  #include "hw/core/eif.h"
>  
> @@ -180,11 +183,10 @@ static void safe_unlink(char *f)
>   * Upon success, the caller is reponsible for unlinking and freeing *kernel_path
>   */
>  static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
> -                            uint32_t *crc, Error **errp)
> +                            uint8_t *kernel, uint32_t *crc, Error **errp)
>  {
>      size_t got;
>      FILE *tmp_file = NULL;
> -    uint8_t *kernel = NULL;
>  
>      *kernel_path = NULL;
>      if (!get_tmp_file("eif-kernel-XXXXXX", kernel_path, errp)) {
> @@ -198,7 +200,6 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
>          goto cleanup;
>      }
>  
> -    kernel = g_malloc(size);
>      got = fread(kernel, 1, size, f);
>      if ((uint64_t) got != size) {
>          error_setg(errp, "Failed to read EIF kernel section data");
> @@ -213,7 +214,6 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
>      }
>  
>      *crc = crc32(*crc, kernel, size);
> -    g_free(kernel);
>      fclose(tmp_file);
>  
>      return true;
> @@ -225,7 +225,6 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
>      g_free(*kernel_path);
>      *kernel_path = NULL;
>  
> -    g_free(kernel);
>      return false;
>  }
>  
> @@ -243,29 +242,115 @@ static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
>  }
>  
>  static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
> -                             uint32_t *crc, Error **errp)
> +                             uint8_t *ramdisk, uint32_t *crc, Error **errp)
>  {
>      size_t got;
> -    uint8_t *ramdisk = g_malloc(size);
>  
>      got = fread(ramdisk, 1, size, eif);
>      if ((uint64_t) got != size) {
>          error_setg(errp, "Failed to read EIF ramdisk section data");
> -        goto cleanup;
> +        return false;
>      }
>  
>      got = fwrite(ramdisk, 1, size, initrd);
>      if ((uint64_t) got != size) {
>          error_setg(errp, "Failed to write EIF ramdisk data to temporary file");
> -        goto cleanup;
> +        return false;
>      }
>  
>      *crc = crc32(*crc, ramdisk, size);
> -    g_free(ramdisk);
> +    return true;
> +}

Just fold this into the earlier commit in the series that added these functions.

> +
> +static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
> +                                             uint8_t *sha384,
> +                                             uint32_t *crc,
> +                                             Error **errp)
> +{
> +    size_t got;
> +    uint8_t *sig = NULL;
> +    uint8_t *cert = NULL;

Declare both of these with 'g_autofree' since they both are temporary
buffers that need to be free on both success & failure paths.

> +    cbor_item_t *item = NULL;
> +    cbor_item_t *pcr0 = NULL;
> +    size_t len;
> +    size_t hash_len = 48;
> +    struct cbor_pair *pair;
> +    struct cbor_load_result result;

Add  'bool ret = false' here

> +
> +    sig = g_malloc(size);
> +    got = fread(sig, 1, size, eif);
> +    if ((uint64_t) got != size) {
> +        error_setg(errp, "Failed to read EIF signature section data");
> +        goto cleanup;
> +    }
> +
> +    *crc = crc32(*crc, sig, size);
> +
> +    item = cbor_load(sig, size, &result);
> +    if (!item || result.error.code != CBOR_ERR_NONE) {
> +        error_setg(errp, "Failed to load signature section data as CBOR");
> +        goto cleanup;
> +    }
> +    if (!cbor_isa_array(item) || cbor_array_size(item) < 1) {
> +        error_setg(errp, "Invalid signature CBOR");
> +        goto cleanu;p
> +    }
> +    pcr0 = cbor_array_get(item, 0);
> +    if (!pcr0) {
> +        error_setg(errp, "Failed to get PCR0 signature");
> +        goto cleanup;
> +    }
> +    if (!cbor_isa_map(pcr0) || cbor_map_size(pcr0) != 2) {
> +        error_setg(errp, "Invalid signature CBOR");
> +        goto cleanup;
> +    }
> +    pair = cbor_map_handle(pcr0);
> +    if (!cbor_isa_string(pair->key) || cbor_string_length(pair->key) != 19 ||
> +        memcmp(cbor_string_handle(pair->key), "signing_certificate", 19) != 0) {
> +        error_setg(errp, "Invalid signautre CBOR");
> +        goto cleanup;
> +    }
> +    if (!cbor_isa_array(pair->value)) {
> +        error_setg(errp, "Invalid signature CBOR");
> +        goto cleanup;
> +    }
> +    len = cbor_array_size(pair->value);
> +    if (len == 0) {
> +        error_setg(errp, "Invalid signature CBOR");
> +        goto cleanup;
> +    }
> +    cert = g_malloc(len);
> +    for (int i = 0; i < len; ++i) {
> +        cbor_item_t *tmp = cbor_array_get(pair->value, i);
> +        if (!tmp) {
> +            error_setg(errp, "Invalid signature CBOR");
> +            goto cleanup;
> +        }
> +        if (!cbor_isa_uint(tmp) || cbor_int_get_width(tmp) != CBOR_INT_8) {
> +            cbor_decref(&tmp);
> +            error_setg(errp, "Invalid signature CBOR");
> +            goto cleanup;
> +        }
> +        cert[i] = cbor_get_uint8(tmp);
> +        cbor_decref(&tmp);
> +    }
> +
> +    if (qcrypto_get_x509_cert_fingerprint(cert, len, QCRYPTO_HASH_ALG_SHA384,
> +                                          &sha384, &hash_len, errp)) {
> +        goto cleanup;
> +    }

Nothing is free'ing  item & pcr0

> +
>      return true;

Change this to

    ret = true;

and allow to fallthrough the cleanup: label, so we get the
freeing of item & pcr0 on both success & failure
>  
>   cleanup:
> -    g_free(ramdisk);
> +    g_free(sig);
> +    g_free(cert);

Remove these two since we can g_autofree them[

> +    if (pcr0) {
> +        cbor_decref(&pcr0);
> +    }
> +    if (item) {
> +        cbor_decref(&item);
> +    }
>      return false;

   return ret;

>  }
>  
> @@ -299,7 +384,9 @@ static long get_file_size(FILE *f, Error **errp)
>   */
>  bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                     char **kernel_path, char **initrd_path, char **cmdline,
> -                   Error **errp)
> +                   uint8_t *image_sha384, uint8_t *bootstrap_sha384,
> +                   uint8_t *app_sha384, uint8_t *fingerprint_sha384,
> +                   bool *signature_found, Error **errp)
>  {
>      FILE *f = NULL;
>      FILE *machine_initrd_f = NULL;
> @@ -308,7 +395,19 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>      uint32_t crc = 0;
>      EifHeader eif_header;
>      bool seen_sections[EIF_SECTION_MAX] = {false};
> -
> +    /* kernel + ramdisks + cmdline sha384 hash */
> +    struct iovec image_hash_iovecs[MAX_SECTIONS + 1];
> +    int image_hash_iovec_cnt = 0;
> +    /* kernel + boot ramdisk + cmdline sha384 hash */
> +    struct iovec bootstrap_hash_iovecs[3];
> +    int bootstrap_hash_iovec_cnt = 0;
> +    /* application ramdisk(s) hash */
> +    struct iovec app_hash_iovecs[MAX_SECTIONS + 1];
> +    int app_hash_iovec_cnt = 0;
> +    uint8_t *ptr = NULL;
> +    size_t digest_len;
> +
> +    *signature_found = false;
>      *kernel_path = *initrd_path = *cmdline = NULL;
>  
>      f = fopen(eif_path, "rb");
> @@ -373,8 +472,18 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                             "section");
>                  goto cleanup;
>              }
> +
> +            ptr = g_malloc(section_header.section_size);
> +
> +            image_hash_iovecs[image_hash_iovec_cnt].iov_base = ptr;
> +            image_hash_iovecs[image_hash_iovec_cnt++].iov_len =
> +                section_header.section_size;
> +            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt].iov_base = ptr;
> +            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt++].iov_len =
> +                section_header.section_size;
> +
>              if (!read_eif_kernel(f, section_header.section_size, kernel_path,
> -                                 &crc, errp)) {
> +                                 ptr, &crc, errp)) {
>                  goto cleanup;
>              }
>  
> @@ -382,6 +491,7 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>          case EIF_SECTION_CMDLINE:
>          {
>              uint64_t size;
> +            uint8_t *cmdline_copy;
>              if (seen_sections[EIF_SECTION_CMDLINE]) {
>                  error_setg(errp, "Invalid EIF image. More than 1 cmdline "
>                             "section");
> @@ -394,6 +504,19 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>              }
>              (*cmdline)[size] = '\0';
>  
> +            /*
> +             * We make a copy of '*cmdline' for putting it in iovecs so that
> +             * we can easily free all the iovec entries later as we cannot
> +             * free '*cmdline' which is used by the caller.
> +             */
> +            cmdline_copy = g_malloc(size);
> +            memcpy(cmdline_copy, *cmdline, size);

Replace by 1 liner:

   cmdline_copy = g_memdup2(*cmdline, size);

> +            image_hash_iovecs[image_hash_iovec_cnt].iov_base = cmdline_copy;
> +            image_hash_iovecs[image_hash_iovec_cnt++].iov_len = size;
> +            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt].iov_base =
> +                cmdline_copy;
> +            bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt++].iov_len = size;
> +
>              break;
>          }
>          case EIF_SECTION_RAMDISK:
> @@ -414,13 +537,41 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                  }
>              }
>  
> +            ptr = g_malloc(section_header.section_size);
> +
> +            image_hash_iovecs[image_hash_iovec_cnt].iov_base = ptr;
> +            image_hash_iovecs[image_hash_iovec_cnt++].iov_len =
> +                section_header.section_size;
> +            /*
> +             * If it's the first ramdisk, we need to hash it into bootstrap,
> +             * otherwise we need to hash it into app.
> +             */
> +            if (!seen_sections[EIF_SECTION_RAMDISK]) {
> +                bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt].iov_base = ptr;
> +                bootstrap_hash_iovecs[bootstrap_hash_iovec_cnt++].iov_len =
> +                    section_header.section_size;
> +            } else {
> +                app_hash_iovecs[app_hash_iovec_cnt].iov_base = ptr;
> +                app_hash_iovecs[app_hash_iovec_cnt++].iov_len =
> +                    section_header.section_size;
> +            }
> +
>              if (!read_eif_ramdisk(f, initrd_path_f, section_header.section_size,
> -                                  &crc, errp)) {
> +                                  ptr, &crc, errp)) {
>                  goto cleanup;
>              }
>  
>              break;
>          }
> +        case EIF_SECTION_SIGNATURE:
> +            *signature_found = true;
> +            if (!get_signature_fingerprint_sha384(f,
> +                                                  section_header.section_size,
> +                                                  fingerprint_sha384, &crc,
> +                                                  errp)) {
> +                goto cleanup;
> +            }
> +            break;
>          default:
>              /* other sections including invalid or unknown sections */
>          {
> @@ -483,18 +634,60 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
>              goto cleanup;
>          }
>  
> +        ptr = g_malloc(machine_initrd_size);
> +
> +        image_hash_iovecs[image_hash_iovec_cnt].iov_base = ptr;
> +        image_hash_iovecs[image_hash_iovec_cnt++].iov_len = machine_initrd_size;
> +        app_hash_iovecs[app_hash_iovec_cnt].iov_base = ptr;
> +        app_hash_iovecs[app_hash_iovec_cnt++].iov_len = machine_initrd_size;
> +
>          if (!read_eif_ramdisk(machine_initrd_f, initrd_path_f,
> -                              machine_initrd_size, &crc, errp)) {
> +                              machine_initrd_size, ptr, &crc, errp)) {
>              goto cleanup;
>          }
>      }
>  
> +    digest_len = 48;

You might as well use the constant "SHA384_BYTE_LEN" this patch
already adds.


> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, image_hash_iovecs,
> +                            image_hash_iovec_cnt, &image_sha384, &digest_len,
> +                            errp) < 0) {
> +        goto cleanup;
> +
> +    }
> +
> +    digest_len = 48;
> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, bootstrap_hash_iovecs,
> +                            bootstrap_hash_iovec_cnt, &bootstrap_sha384,
> +                            &digest_len, errp) < 0) {
> +        goto cleanup;
> +
> +    }
> +
> +    digest_len = 48;
> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA384, app_hash_iovecs,
> +                            app_hash_iovec_cnt, &app_sha384, &digest_len,
> +                            errp) < 0) {
> +        goto cleanup;
> +
> +    }
> +
> +    /*
> +     * We only need to free image_hash_iovec entries because bootstrap and
> +     * app iovec entries are subsets of image_hash_iovec entries.
> +     */
> +    for (int i = 0; i < image_hash_iovec_cnt; ++i) {
> +        g_free(image_hash_iovecs[i].iov_base);
> +    }
>      fclose(f);
>      fclose(initrd_path_f);
>      safe_fclose(machine_initrd_f);
>      return true;
>  
>   cleanup:
> +    for (int i = 0; i < image_hash_iovec_cnt; ++i) {
> +        g_free(image_hash_iovecs[i].iov_base);
> +    }
> +
>      safe_fclose(f);
>      safe_fclose(initrd_path_f);
>      safe_fclose(machine_initrd_f);


> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index f32d1ad943..8dc4552e35 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -12,6 +12,8 @@ hwcore_ss.add(files(
>    'qdev-clock.c',
>  ))
>  
> +libcbor = dependency('libcbor', version: '>=0.7.0')

Our pattern is to have all 'dependency()' listed in the top level meson.build.
Not quite sure why we do that but best to follow the pattern IMHO.

Also, to be able to test this, we need to get libcbor added to our containers

Look at the "Adding new build pre-requisites" section in docs/devel/testing.rst

I'll review the submission to libvirt-ci.git that you'll need to do as part of
this


> +static void nitro_enclave_machine_reset(MachineState *machine,
> +                                        ShutdownCause reason)
> +{
> +    NitroEnclaveMachineClass *ne_class =
> +        NITRO_ENCLAVE_MACHINE_GET_CLASS(machine);
> +    NitroEnclaveMachineState *ne_state = NITRO_ENCLAVE_MACHINE(machine);
> +
> +    ne_class->parent_reset(machine, reason);
> +
> +    memset(ne_state->vnsm->pcrs, 0, sizeof(ne_state->vnsm->pcrs));
> +
> +    /* PCR0 */
> +    ne_state->vnsm->extend_pcr(ne_state->vnsm, 0, ne_state->image_sha384,
> +                               SHA384_BYTE_LEN);
> +    /* PCR1 */
> +    ne_state->vnsm->extend_pcr(ne_state->vnsm, 1, ne_state->bootstrap_sha384,
> +                               SHA384_BYTE_LEN);
> +    /* PCR2 */
> +    ne_state->vnsm->extend_pcr(ne_state->vnsm, 2, ne_state->app_sha384,
> +                               SHA384_BYTE_LEN);
> +    /* PCR3 */
> +    if (ne_state->parent_role) {
> +        ne_state->vnsm->extend_pcr(ne_state->vnsm, 3,
> +                                   (uint8_t *) ne_state->parent_role,
> +                                   strlen(ne_state->parent_role));
> +    }
> +    /* PCR4 */
> +    if (ne_state->parent_id) {
> +        ne_state->vnsm->extend_pcr(ne_state->vnsm, 4,
> +                                   (uint8_t *) ne_state->parent_id,
> +                                   strlen(ne_state->parent_id));
> +    }
> +    /* PCR8 */
> +    if (ne_state->signature_found) {
> +        ne_state->vnsm->extend_pcr(ne_state->vnsm, 8,
> +                                   ne_state->fingerprint_sha384,
> +                                   SHA384_BYTE_LEN);
> +    }
> +
> +    /* First 16 PCRs are locked from boot and reserved for nitro enclave */
> +    for (int i = 0; i < 16; ++i) {
> +        ne_state->vnsm->lock_pcr(ne_state->vnsm, i);
> +    }

Worth  NITRO_PCR_MAX constant ?

>  static void nitro_enclave_machine_initfn(Object *obj)
>  {
>      MicrovmMachineState *mms = MICROVM_MACHINE(obj);
>      X86MachineState *x86ms = X86_MACHINE(obj);
> +    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
> +
> +    nems->id = g_strdup("i-234-enc5678");

Is this some magic string that the Nitro spec requires ? If so, probably
worth a #define constant for it with a comment about rationale.

>  
>      /* AWS nitro enclaves have PCIE and ACPI disabled */
>      mms->pcie = ON_OFF_AUTO_OFF;
> @@ -103,9 +170,13 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
>      Error *err = NULL;
>      char *eif_kernel, *eif_initrd, *eif_cmdline;
>      MachineState *machine = MACHINE(x86ms);
> +    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(x86ms);
>  
>      if (!read_eif_file(machine->kernel_filename, machine->initrd_filename,
> -                       &eif_kernel, &eif_initrd, &eif_cmdline, &err)) {
> +                       &eif_kernel, &eif_initrd, &eif_cmdline,
> +                       nems->image_sha384, nems->bootstrap_sha384,
> +                       nems->app_sha384, nems->fingerprint_sha384,
> +                       &(nems->signature_found), &err)) {
>          error_report_err(err);
>          exit(1);
>      }
> @@ -176,6 +247,54 @@ static void nitro_enclave_set_vsock_chardev_id(Object *obj, const char *value,
>      nems->vsock = g_strdup(value);
>  }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


