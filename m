Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADFFC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYivc-0007qK-P7; Tue, 30 Jul 2024 05:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYivb-0007iR-Dp
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYivZ-0003tL-Ec
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722330832;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSLlIJR2ZPU1Tj2WbafVSnV32Cdn2vklNmUjcUUffwU=;
 b=fmMh3btiz7O1pgvNGm+CQFixKZ1GxcAcO/FjqxOKVs5iQcBNUtkn+268ONCZ1z1VyOdcOv
 rrbZSJEvAEgu29+RA77NXe/ulRrTyimVZ5lFkv9yX3pkyIOnqtEcrxiLu474/8Tj7yKppj
 mFwmDqR3IcGwvL4tWuuhyW7IZc8xwc4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-C85vXwjOPM67FfiNoxbJfw-1; Tue,
 30 Jul 2024 05:13:48 -0400
X-MC-Unique: C85vXwjOPM67FfiNoxbJfw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 571EC1955D4F; Tue, 30 Jul 2024 09:13:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E423B1955E89; Tue, 30 Jul 2024 09:13:28 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:13:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com,
 andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com,
 kwolf@redhat.com, leetroy@gmail.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 mtosatti@redhat.com, nsg@linux.ibm.com, pasic@linux.ibm.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, pl@dlhnet.de,
 richard.henderson@linaro.org, stefanha@redhat.com,
 steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 01/18] qapi: Smarter camel_to_upper() to reduce need for
 'prefix'
Message-ID: <ZqiutRoQuAsrllfj@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730081032.1246748-2-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 30, 2024 at 10:10:15AM +0200, Markus Armbruster wrote:
> camel_to_upper() converts its argument from camel case to upper case
> with '_' between words.  Used for generated enumeration constant
> prefixes.
> 
> When some of the words are spelled all caps, where exactly to insert
> '_' is guesswork.  camel_to_upper()'s guesses are bad enough in places
> to make people override them with a 'prefix' in the schema.
> 
> Rewrite it to guess better:
> 
> 1. Insert '_' after a non-upper case character followed by an upper
>    case character:
> 
>        OneTwo -> ONE_TWO
>        One2Three -> ONE2_THREE
> 
> 2. Insert '_' before the last upper case character followed by a
>    non-upper case character:
> 
>        ACRONYMWord -> ACRONYM_Word
> 
>    Except at the beginning (as in OneTwo above), or when there is
>    already one:
> 
>        AbCd -> AB_CD
> 
> This changes the default enumeration constant prefix for a number of
> enums.  Generated enumeration constants change only where the default
> is not overridden with 'prefix'.
> 
> The following enumerations without a 'prefix' change:
> 
>     enum       	     	 	    old camel_to_upper()
>     				    new camel_to_upper()
>     ------------------------------------------------------------------
>     DisplayGLMode                   DISPLAYGL_MODE
> 				    DISPLAY_GL_MODE
>     EbpfProgramID                   EBPF_PROGRAMID
> 				    EBPF_PROGRAM_ID
>     HmatLBDataType                  HMATLB_DATA_TYPE
> 				    HMAT_LB_DATA_TYPE
>     HmatLBMemoryHierarchy           HMATLB_MEMORY_HIERARCHY
> 				    HMAT_LB_MEMORY_HIERARCHY
>     MultiFDCompression              MULTIFD_COMPRESSION
> 				    MULTI_FD_COMPRESSION
>     OffAutoPCIBAR                   OFF_AUTOPCIBAR
> 				    OFF_AUTO_PCIBAR
>     QCryptoBlockFormat              Q_CRYPTO_BLOCK_FORMAT
> 				    QCRYPTO_BLOCK_FORMAT
>     QCryptoBlockLUKSKeyslotState    Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE
> 				    QCRYPTO_BLOCK_LUKS_KEYSLOT_STATE
>     QKeyCode                        Q_KEY_CODE
>     				    QKEY_CODE
>     XDbgBlockGraphNodeType          X_DBG_BLOCK_GRAPH_NODE_TYPE
> 				    XDBG_BLOCK_GRAPH_NODE_TYPE
>     TestUnionEnumA		    TEST_UNION_ENUMA
>     				    TEST_UNION_ENUM_A
> 
> Add a 'prefix' so generated code doesn't change now.  Subsequent
> commits will remove most of them again.  Two will remain:
> MULTIFD_COMPRESSION, because migration code generally spells "multifd"
> that way, and Q_KEY_CODE, because that one is baked into
> subprojects/keycodemapdb/tools/keymap-gen.
> 
> The following enumerations with a 'prefix' change so that the prefix
> is now superfluous:
> 
>     enum       	     	 	    old camel_to_upper()
>     				    new camel_to_upper() [equal to prefix]
>     ------------------------------------------------------------------
>     BlkdebugIOType                  BLKDEBUGIO_TYPE
> 				    BLKDEBUG_IO_TYPE
>     QCryptoTLSCredsEndpoint         Q_CRYPTOTLS_CREDS_ENDPOINT
> 				    QCRYPTO_TLS_CREDS_ENDPOINT
>     QCryptoSecretFormat             Q_CRYPTO_SECRET_FORMAT
> 				    QCRYPTO_SECRET_FORMAT
>     QCryptoCipherMode               Q_CRYPTO_CIPHER_MODE
> 				    QCRYPTO_CIPHER_MODE
>     QCryptodevBackendType           Q_CRYPTODEV_BACKEND_TYPE
> 				    QCRYPTODEV_BACKEND_TYPE
>     QType [builtin]                 Q_TYPE
> 				    QTYPE
> 
> Drop these prefixes.
> 
> The following enumerations with a 'prefix' change without making the
> 'prefix' superfluous:
> 
>     enum       	     	 	    old camel_to_upper()
>     				    new camel_to_upper() [equal to prefix]
> 				    prefix
>     ------------------------------------------------------------------
>     CpuS390Entitlement              CPUS390_ENTITLEMENT
> 				    CPU_S390_ENTITLEMENT
> 				    S390_CPU_ENTITLEMENT
>     CpuS390Polarization             CPUS390_POLARIZATION
> 				    CPU_S390_POLARIZATION
> 				    S390_CPU_POLARIZATION
>     CpuS390State                    CPUS390_STATE
> 				    CPU_S390_STATE
> 				    S390_CPU_STATE
>     QAuthZListFormat                Q_AUTHZ_LIST_FORMAT
> 				    QAUTH_Z_LIST_FORMAT
> 				    QAUTHZ_LIST_FORMAT
>     QAuthZListPolicy                Q_AUTHZ_LIST_POLICY
> 				    QAUTH_Z_LIST_POLICY
> 				    QAUTHZ_LIST_POLICY
>     QCryptoAkCipherAlgorithm        Q_CRYPTO_AK_CIPHER_ALGORITHM
> 				    QCRYPTO_AK_CIPHER_ALGORITHM
> 				    QCRYPTO_AKCIPHER_ALG
>     QCryptoAkCipherKeyType          Q_CRYPTO_AK_CIPHER_KEY_TYPE
> 				    QCRYPTO_AK_CIPHER_KEY_TYPE
> 				    QCRYPTO_AKCIPHER_KEY_TYPE
>     QCryptoCipherAlgorithm          Q_CRYPTO_CIPHER_ALGORITHM
> 				    QCRYPTO_CIPHER_ALGORITHM
> 				    QCRYPTO_CIPHER_ALG
>     QCryptoHashAlgorithm            Q_CRYPTO_HASH_ALGORITHM
> 				    QCRYPTO_HASH_ALGORITHM
> 				    QCRYPTO_HASH_ALG
>     QCryptoIVGenAlgorithm           Q_CRYPTOIV_GEN_ALGORITHM
> 				    QCRYPTO_IV_GEN_ALGORITHM
> 				    QCRYPTO_IVGEN_ALG
>     QCryptoRSAPaddingAlgorithm      Q_CRYPTORSA_PADDING_ALGORITHM
> 				    QCRYPTO_RSA_PADDING_ALGORITHM
> 				    QCRYPTO_RSA_PADDING_ALG
>     QCryptodevBackendAlgType        Q_CRYPTODEV_BACKEND_ALG_TYPE
> 				    QCRYPTODEV_BACKEND_ALG_TYPE
> 				    QCRYPTODEV_BACKEND_ALG
>     QCryptodevBackendServiceType    Q_CRYPTODEV_BACKEND_SERVICE_TYPE
> 				    QCRYPTODEV_BACKEND_SERVICE_TYPE
> 				    QCRYPTODEV_BACKEND_SERVICE
> 
> Subsequent commits will tweak things to remove most of these prefixes.
> Only QAUTHZ_LIST_FORMAT and QAUTHZ_LIST_POLICY will remain.

IIUC from above those two result in 

			    QAUTH_Z_LIST_FORMAT
			    QAUTH_Z_LIST_POLICY

Is it possible to add a 3rd rule

 *  Single uppercase letter folds into the previous word

or are there valid cases where we have a single uppercase
that we want to preserve ?

It sure would be nice to eliminate the 'prefix' concept,
that we've clearly over-used, if we can kill the only 2
remaining examples.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json                     |  3 +-
>  qapi/common.json                         |  1 +
>  qapi/crypto.json                         |  6 ++--
>  qapi/cryptodev.json                      |  1 -
>  qapi/ebpf.json                           |  1 +
>  qapi/machine.json                        |  1 +
>  qapi/migration.json                      |  1 +
>  qapi/ui.json                             |  2 ++
>  scripts/qapi/common.py                   | 42 ++++++++++++++----------
>  scripts/qapi/schema.py                   |  2 +-
>  tests/qapi-schema/alternate-array.out    |  1 -
>  tests/qapi-schema/comments.out           |  1 -
>  tests/qapi-schema/doc-good.out           |  1 -
>  tests/qapi-schema/empty.out              |  1 -
>  tests/qapi-schema/include-repetition.out |  1 -
>  tests/qapi-schema/include-simple.out     |  1 -
>  tests/qapi-schema/indented-expr.out      |  1 -
>  tests/qapi-schema/qapi-schema-test.json  |  1 +
>  tests/qapi-schema/qapi-schema-test.out   |  2 +-
>  19 files changed, 37 insertions(+), 33 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


