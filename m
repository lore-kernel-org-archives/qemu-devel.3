Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05459E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQjy-0005UB-Vn; Wed, 24 Dec 2025 10:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjg-0005AJ-Lq
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:17 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjd-00059m-Ko
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:10 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso890567366b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589907; x=1767194707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivUqCWD2KREPIU5lTjap2u3Qf3HeXg5Qh8hQWzf9tyE=;
 b=ZF7/c6K9RjKNWjIKMzLCGcj+eY2VtTaSNXPVVygR+5pupTGoLi7wDuGC34lAeqxWTt
 8W1fqz+NVw0WhZOUabf+jjn49EeQpe4EwT8tY7JhG/o9TvcjnDXB/zOkYwPNdE3URav7
 UPj0LBd4IHpO+ymyUeW13EnOwpXmVl17Z5UVJ/IkF7+yV/8YM3knaxq4uP5IXYdT3d5T
 mDPKX1jgQJMKwnFKmkNgBniS0SijXlNLC5PkDjBeMXnOxjlbjpguHDUej4glgx2xmWvc
 p435quChuciwgw/Z+aejlWRJSOW8gPg3r+NBg2YV2JEXw1VSGlYyrIPMAdpAz7w6rFLD
 j+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589907; x=1767194707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ivUqCWD2KREPIU5lTjap2u3Qf3HeXg5Qh8hQWzf9tyE=;
 b=USrnZ2reCEKiBfQ5I+2Rg1nZcnD7dqhrXSEtRAvudJIhHKuBIm88PgIOXzFqPz9wkZ
 YFCCZ1ZV1rM2eiZwNex+uKOK17bR0jdxNdV+I1pu1OfQBahn7yrrGY6bSnjtrVJyiktp
 +snik++x6ToijP/+Fi8hIIxXyZap7m3upAab74REAsOo4aJcF4bFulqWsy4tDaKML+AK
 pTIW9RzYWFV8REmENcG9o4Z05qDSkZRxc3MPjKBWWLsexhuBK8nqfUbDDmIsbWzpGyCt
 nPkUxpnhWYs09jh5sisXE+9kjSxHaA99tKSjD3qqF+GEg71J/WvFfQg2p3z2hZZ7Xf6R
 R7ZQ==
X-Gm-Message-State: AOJu0YzXjrHUDhDHMTEunIBoUvB5H5Z4NV8XAUSPjlGHqhqbtnmnq75h
 ePBMdAR3a0osReqBzMXhMd1mAEfX+k2IgYWcrQjgWm0rrbCh37AxuX0uKLd8WrlXTfah7qFySfa
 Yh3oE4cU=
X-Gm-Gg: AY/fxX4qRI7jm/dITieiV+46UPGXqTpzIMAiB5pcaxUEH/npL0cofPmhyMxYOWKdewF
 i9JqlJLdBgP3kMqr/6z4D+QYbkuroUcZ2KfRqr4ZaIjKy9RHA2qm9o+Y1mebG752bGnq59y3ov4
 B+5GEEPnBDU5fn4oKczLPeIOZDTvzZA5fbYQJy7ee1FFJz5nIjPFZ5FRDoymaJwiFhH9gwSOXgP
 ae0js1GaTy8N6wF8M1vAXdTxki4KVXyEoZTrt8gnfg9Q+m/ow/Z0w7ifpyIDJwitSUOCAF55Y6b
 CRY1gKlcfD1W6aK/g7u5JKHcfO0dkAmAbFimqi09hWuaAOxGpQyMYI1AK0M/Fla/U2NWCAEVbVu
 qZ7TzU+SpQQSJCuNrPYrJBD6EjxVn0WiQIqMKHh3//01a60901shUHSDlXSL2P2AG5LcKVVs6NV
 huy21pVl6NfcrFzrXdjhm9cpIf6t4YMBaImaXFkc/LA8SbYzffDyjgg/I=
X-Google-Smtp-Source: AGHT+IHPz9/QtP/uoZdBrLbMg1D9gI4dQBO5dJLZOGT5YOam5evVCBFs8GNKwzX8picnukEa5p9+uw==
X-Received: by 2002:a17:907:3f9d:b0:b7a:5c1a:85e with SMTP id
 a640c23a62f3a-b8036f2d03cmr1994974266b.23.1766589906824; 
 Wed, 24 Dec 2025 07:25:06 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f0e8f1sm1784881366b.53.2025.12.24.07.25.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:25:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 18/25] system: Allow restricting the legacy cpu_ld/st()
 'native-endian' API
Date: Wed, 24 Dec 2025 16:22:01 +0100
Message-ID: <20251224152210.87880-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..a5711bc15a6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,6 +428,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -501,5 +502,6 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0


