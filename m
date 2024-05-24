Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F74C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPrC-0007F9-TT; Fri, 24 May 2024 04:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPr9-0007C4-Qq
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:00:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPqy-0006xi-Qc
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:00:43 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-68194ee2174so478612a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716537639; x=1717142439;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jrghs866eeKjtAq7SYzsGMP/6e+gx3kxu9bBYPhSOJI=;
 b=L3gYbz7+zoxSiChoI/sYWXKKEwIouQimxg8A4hquTVucxAHnrGTfmMJhTnWaD3egeh
 eFxV4+57VWjx2V1y3LglVUFkQLk9d+exZN5KR3eMb+PRgjMLDby9z2GMJlHIvxolk+x6
 bXFufH+AGBmdeuhwqjF1oxg16HFXpnOuqav8tywJqQm129qMJdpr3Cih13E6hfgd7TGy
 9PYI7VoQ78JtXJCpBfWb7H3ZjZD2aArFzBnAM61XIoTLcIIldAiXbp1JHqkd1V2sBpFj
 vL1WbWr44G3KyxEPvZgI5uu68a2eDWQCEH74xZdJFPVf6qHYkiD3b+ffiUzginjSofZq
 rgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716537639; x=1717142439;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jrghs866eeKjtAq7SYzsGMP/6e+gx3kxu9bBYPhSOJI=;
 b=VXm9i1YnQr9Kxtkw81Unm/B0S1kAoiS44WSWQp0eXh/zTDCrXButgeYk5e6Cf6lVGt
 yIHuNQ+k+5w6JwQPSLDi4BGwqZ4DIXrw7vJZy2MxZGk5zvQxJHEEmybF1x9fzrRjTcCw
 K0bAVPrBToAWUF5J2XrDNBRWMxPRwdnTzG6e9HPe/o4YPEIE3ywltdyclu1AGb7j911y
 C15tNj9m4SxgwuWDtizqGWqINOJDZNKQ9I6rwtPJSfG3EL+cFcKzA3Kx6v+4hH+EDJeV
 CX5KXoTsumPWRitmLpYfhUZM+CLkOEUkUkmqcMn/npVOJjcP9NFf1zWcnrD+vjAPLr/R
 DQgg==
X-Gm-Message-State: AOJu0YwqmZsrLHrl3PBdOkVZfjCGxXRh6n34ZAkGZ24iOZzSVIQP0hip
 Kl5qTPR36FymST7nKBsnxlKwDSaYprJFM1hTEvMAOpetVpHozS+H7SRKI26EoCs=
X-Google-Smtp-Source: AGHT+IFVj9Jk9D0ZKpyk05256iTXkAgk3RxdM/iRIw0uT35kYOTZO4/P9nOlmHmLJ+emQrVDo8qxOA==
X-Received: by 2002:a17:90b:b11:b0:2bd:f690:67c8 with SMTP id
 98e67ed59e1d1-2bf5f106605mr1307214a91.27.1716537638973; 
 Fri, 24 May 2024 01:00:38 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2bdd9ed90c6sm2771083a91.8.2024.05.24.01.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 01:00:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC 0/2] meson: Pass objects to declare_dependency()
Date: Fri, 24 May 2024 17:00:21 +0900
Message-Id: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVJUGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMT3fykrNTkkmJd45RkA/NUEwvTJPM0JaDqgqLUtMwKsEnRSkFuzkq
 xtbUAZjVOi14AAAA=
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-2c6f2
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Based-on: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
("[PATCH v4 0/4] Fix sanitizer errors with clang 18.1.1")

This is changes suggested by Paolo Bonzini at:
https://lore.kernel.org/all/CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTohFn=Og@mail.gmail.com/

Unfortunately it broke builds on my system. Below are the errors I
observed:

clang  -o qemu-img libauthz.a.p/authz_base.c.o libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o libauthz.a.p/authz_simple.c.o libauthz.a.p/authz_pamacct.c.o libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o libblock.a.p/block.c.o libblock.a.p/blockjob.c.o libblock.a.p/job.c.o libblock.a.p/qemu-io-cmds.c.o libblock.a.p/replication.c.o libblock.a.p/nbd_client.c.o libblock.a.p/nbd_client-connection.c.o libblock.a.p/nbd_common.c.o libblock.a.p/scsi_utils.c.o libblock.a.p/scsi_pr-manager.c.o libblock.a.p/scsi_pr-manager-helper.c.o libblock.a.p/block_accounting.c.o libblock.a.p/block_aio_task.c.o libblock.a.p/block_amend.c.o libblock.a.p/block_backup.c.o libblock.a.p/block_blkdebug.c.o libblock.a.p/block_blklogwrites.c.o libblock.a.p/block_blkverify.c.o libblock.a.p/block_block-backend.c.o libblock.a.p/block_block-copy.c.o libblock.a.p/block_commit.c.o libblock.a.p/block_copy-before-write.c.o libblock.a.p/block_copy-on-read.c.o libblock.a.p/block_create.c.o libblock.a.p/block_crypto.c.o libblock.a.p/block_dirty-bitmap.c.o libblock.a.p/block_filter-compress.c.o libblock.a.p/block_graph-lock.c.o libblock.a.p/block_io.c.o libblock.a.p/block_mirror.c.o libblock.a.p/block_nbd.c.o libblock.a.p/block_null.c.o libblock.a.p/block_preallocate.c.o libblock.a.p/block_progress_meter.c.o libblock.a.p/block_qapi.c.o libblock.a.p/block_qcow2.c.o libblock.a.p/block_qcow2-bitmap.c.o libblock.a.p/block_qcow2-cache.c.o libblock.a.p/block_qcow2-cluster.c.o libblock.a.p/block_qcow2-refcount.c.o libblock.a.p/block_qcow2-snapshot.c.o libblock.a.p/block_qcow2-threads.c.o libblock.a.p/block_quorum.c.o libblock.a.p/block_raw-format.c.o libblock.a.p/block_reqlist.c.o libblock.a.p/block_snapshot.c.o libblock.a.p/block_snapshot-access.c.o libblock.a.p/block_throttle.c.o libblock.a.p/block_throttle-groups.c.o libblock.a.p/block_write-threshold.c.o libblock.a.p/block_qcow.c.o libblock.a.p/block_vdi.c.o libblock.a.p/block_vhdx-endian.c.o libblock.a.p/block_vhdx-log.c.o libblock.a.p/block_vhdx.c.o libblock.a.p/block_vmdk.c.o libblock.a.p/block_vpc.c.o libblock.a.p/block_cloop.c.o libblock.a.p/block_bochs.c.o libblock.a.p/block_vvfat.c.o libblock.a.p/block_dmg.c.o libblock.a.p/block_qed-check.c.o libblock.a.p/block_qed-cluster.c.o libblock.a.p/block_qed-l2-cache.c.o libblock.a.p/block_qed-table.c.o libblock.a.p/block_qed.c.o libblock.a.p/block_parallels.c.o libblock.a.p/block_parallels-ext.c.o libblock.a.p/block_file-posix.c.o libblock.a.p/block_nvme.c.o libblock.a.p/block_replication.c.o libblock.a.p/block_stream.c.o libblock.a.p/block_monitor_bitmap-qmp-cmds.c.o libblock.a.p/block_curl.c.o libblock.a.p/block_ssh.c.o libblock.a.p/block_dmg-bz2.c.o libblock.a.p/meson-generated_.._block_block-gen.c.o libcrypto.a.p/crypto_afsplit.c.o libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o libcrypto.a.p/crypto_ivgen-essiv.c.o libcrypto.a.p/crypto_ivgen-plain.c.o libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o libcrypto.a.p/crypto_tlscredsanon.c.o libcrypto.a.p/crypto_tlscredspsk.c.o libcrypto.a.p/crypto_tlscredsx509.c.o libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o libcrypto.a.p/crypto_hash-gnutls.c.o libcrypto.a.p/crypto_hmac-gnutls.c.o libcrypto.a.p/crypto_pbkdf-gnutls.c.o libcrypto.a.p/crypto_secret_keyring.c.o libio.a.p/io_channel-buffer.c.o libio.a.p/io_channel-command.c.o libio.a.p/io_channel-file.c.o libio.a.p/io_channel-null.c.o libio.a.p/io_channel-socket.c.o libio.a.p/io_channel-tls.c.o libio.a.p/io_channel-util.c.o libio.a.p/io_channel-watch.c.o libio.a.p/io_channel-websock.c.o libio.a.p/io_channel.c.o libio.a.p/io_dns-resolver.c.o libio.a.p/io_net-listener.c.o libio.a.p/io_task.c.o libevent-loop-base.a.p/event-loop-base.c.o qemu-img.p/qemu-img.c.o -Werror -flto -Wl,--as-needed -Wl,--no-undefined -pie -fsanitize=cfi-icall -fsanitize-cfi-icall-generalize-pointers -fsanitize=undefined -fsanitize=address -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -fuse-ld=lld -Wl,--start-group libqemuutil.a subprojects/libvhost-user/libvhost-user-glib.a subprojects/libvhost-user/libvhost-user.a @block.syms /usr/lib64/libgio-2.0.so /usr/lib64/libgobject-2.0.so /usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -pthread /usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1.so -Wl,--end-group
ld.lld: error: undefined symbol: pam_start
>>> referenced by pamacct.c:40 (/home/me/q/var/qemu/build/../authz/pamacct.c:40)
>>>               qemu-img.lto.o:(qauthz_pam_is_allowed.cfi)

ld.lld: error: undefined symbol: pam_strerror
>>> referenced by pamacct.c:45 (/home/me/q/var/qemu/build/../authz/pamacct.c:45)
>>>               qemu-img.lto.o:(qauthz_pam_is_allowed.cfi)
>>> referenced by pamacct.c:53 (/home/me/q/var/qemu/build/../authz/pamacct.c:53)
>>>               qemu-img.lto.o:(qauthz_pam_is_allowed.cfi)

ld.lld: error: undefined symbol: pam_acct_mgmt
>>> referenced by pamacct.c:50 (/home/me/q/var/qemu/build/../authz/pamacct.c:50)
>>>               qemu-img.lto.o:(qauthz_pam_is_allowed.cfi)

ld.lld: error: undefined symbol: pam_end
>>> referenced by pamacct.c:51 (/home/me/q/var/qemu/build/../authz/pamacct.c:51)
>>>               qemu-img.lto.o:(qauthz_pam_is_allowed.cfi)

ld.lld: error: undefined symbol: ZSTD_createCCtx
>>> referenced by qcow2-threads.c:203 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:203)
>>>               qemu-img.lto.o:(qcow2_zstd_compress.cfi)

ld.lld: error: undefined symbol: ZSTD_compressStream2
>>> referenced by qcow2-threads.c:225 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:225)
>>>               qemu-img.lto.o:(qcow2_zstd_compress.cfi)

ld.lld: error: undefined symbol: ZSTD_freeCCtx
>>> referenced by qcow2-threads.c:240 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:240)
>>>               qemu-img.lto.o:(qcow2_zstd_compress.cfi)

ld.lld: error: undefined symbol: deflateInit2_
>>> referenced by qcow2-threads.c:101 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:101)
>>>               qemu-img.lto.o:(qcow2_zlib_compress.cfi)
>>> referenced by qcow.c:1081 (/home/me/q/var/qemu/build/../block/qcow.c:1081)
>>>               qemu-img.lto.o:(qcow_co_pwritev_compressed.cfi)

ld.lld: error: undefined symbol: deflate
>>> referenced by qcow2-threads.c:116 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:116)
>>>               qemu-img.lto.o:(qcow2_zlib_compress.cfi)
>>> referenced by qcow.c:1094 (/home/me/q/var/qemu/build/../block/qcow.c:1094)
>>>               qemu-img.lto.o:(qcow_co_pwritev_compressed.cfi)

ld.lld: error: undefined symbol: deflateEnd
>>> referenced by qcow2-threads.c:123 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:123)
>>>               qemu-img.lto.o:(qcow2_zlib_compress.cfi)
>>> referenced by qcow.c:1102 (/home/me/q/var/qemu/build/../block/qcow.c:1102)
>>>               qemu-img.lto.o:(qcow_co_pwritev_compressed.cfi)
>>> referenced by qcow.c:1096 (/home/me/q/var/qemu/build/../block/qcow.c:1096)
>>>               qemu-img.lto.o:(qcow_co_pwritev_compressed.cfi)

ld.lld: error: undefined symbol: ZSTD_createDCtx
>>> referenced by qcow2-threads.c:271 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:271)
>>>               qemu-img.lto.o:(qcow2_zstd_decompress.cfi)

ld.lld: error: undefined symbol: ZSTD_decompressStream
>>> referenced by qcow2-threads.c:291 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:291)
>>>               qemu-img.lto.o:(qcow2_zstd_decompress.cfi)

ld.lld: error: undefined symbol: ZSTD_isError
>>> referenced by qcow2-threads.c:293 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:293)
>>>               qemu-img.lto.o:(qcow2_zstd_decompress.cfi)

ld.lld: error: undefined symbol: ZSTD_freeDCtx
>>> referenced by qcow2-threads.c:322 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:322)
>>>               qemu-img.lto.o:(qcow2_zstd_decompress.cfi)
>>> referenced by qcow2-threads.c:322 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:322)
>>>               qemu-img.lto.o:(qcow2_zstd_decompress.cfi)

ld.lld: error: undefined symbol: inflateInit2_
>>> referenced by qcow2-threads.c:152 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:152)
>>>               qemu-img.lto.o:(qcow2_zlib_decompress.cfi)
>>> referenced by qcow.c:581 (/home/me/q/var/qemu/build/../block/qcow.c:581)
>>>               qemu-img.lto.o:(decompress_cluster)

ld.lld: error: undefined symbol: inflate
>>> referenced by qcow2-threads.c:157 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:157)
>>>               qemu-img.lto.o:(qcow2_zlib_decompress.cfi)
>>> referenced by qcow.c:584 (/home/me/q/var/qemu/build/../block/qcow.c:584)
>>>               qemu-img.lto.o:(decompress_cluster)
>>> referenced by cloop.c:244 (/home/me/q/var/qemu/build/../block/cloop.c:244)
>>>               qemu-img.lto.o:(cloop_read_block)
>>> referenced 3 more times

ld.lld: error: undefined symbol: inflateEnd
>>> referenced by qcow2-threads.c:169 (/home/me/q/var/qemu/build/../block/qcow2-threads.c:169)
>>>               qemu-img.lto.o:(qcow2_zlib_decompress.cfi)
>>> referenced by qcow.c:0 (/home/me/q/var/qemu/build/../block/qcow.c:0)
>>>               qemu-img.lto.o:(decompress_cluster)
>>> referenced by qcow.c:0 (/home/me/q/var/qemu/build/../block/qcow.c:0)
>>>               qemu-img.lto.o:(decompress_cluster)
>>> referenced 2 more times

ld.lld: error: undefined symbol: uncompress
>>> referenced by vmdk.c:1958 (/home/me/q/var/qemu/build/../block/vmdk.c:1958)
>>>               qemu-img.lto.o:(vmdk_read_extent)

ld.lld: error: undefined symbol: compress
>>> referenced by vmdk.c:1865 (/home/me/q/var/qemu/build/../block/vmdk.c:1865)
>>>               qemu-img.lto.o:(vmdk_write_extent)

ld.lld: error: undefined symbol: inflateReset
>>> referenced by cloop.c:240 (/home/me/q/var/qemu/build/../block/cloop.c:240)
>>>               qemu-img.lto.o:(cloop_read_block)
>>> referenced by cloop.c:240 (/home/me/q/var/qemu/build/../block/cloop.c:240)
>>>               qemu-img.lto.o:(cloop_read_block)
>>> referenced by dmg.c:658 (/home/me/q/var/qemu/build/../block/dmg.c:658)
>>>               qemu-img.lto.o:(dmg_read_chunk)
>>> referenced 1 more times

ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)
clang: error: linker command failed with exit code 1 (use -v to see invocation)
ninja: build stopped: subcommand failed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      meson: Pass objects to declare_dependency()
      Revert "meson: Propagate gnutls dependency"

 docs/devel/build-system.rst           |  2 +-
 meson.build                           | 31 ++++++++++++++++---------------
 block/meson.build                     |  2 +-
 gdbstub/meson.build                   |  4 ++--
 io/meson.build                        |  2 +-
 storage-daemon/meson.build            |  2 +-
 subprojects/libvhost-user/meson.build |  2 +-
 tests/qtest/libqos/meson.build        |  2 +-
 ui/meson.build                        |  2 +-
 9 files changed, 25 insertions(+), 24 deletions(-)
---
base-commit: 4a207ef32de97bc785ced1987eacab7665b49420
change-id: 20240524-objects-3dc07e485b7f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


