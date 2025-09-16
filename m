Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6EBCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWac-0005zT-Gv; Tue, 16 Sep 2025 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaL-0005nw-Nf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:11 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa9-0008Il-TQ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7728815e639so3858452b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032567; x=1758637367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kofh5Wdw7zo/AWgs+4bb6219c2CIplWZ+zmDJNsKxAc=;
 b=El7c6qoiOxV1nVQfAjRdqV0O+axfTTcOK0iBd/XFOztsOXmGCn45FuK/O2EE0ficB8
 mEcSnvyGx8S7IGc+dYnc/Kbkhx0X1vvmisHFr1Krb8/XphFia3KT/RgsdUClO2mlelp9
 TUd4k/x3wweYqgqpjFAZPPeHheyV72YjuNG9NMn9Gt9mHz5xdhmkqywqsbP94+ndy6ww
 NQCqJMKoPKyLte6N5WthDgW+sxdv5MiEX19DJGIlD6hwQEtSfguaiq/S76nAdoZ/3fHk
 eVgYhOAxu8/j1roN4sO9dkRcTHgpbF5GwbG5/ciz/+WlERNHvztm07y0wObvku8yYmUx
 YRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032567; x=1758637367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kofh5Wdw7zo/AWgs+4bb6219c2CIplWZ+zmDJNsKxAc=;
 b=Y1fXl3ws5k/0/YVAzuG29DnUpPlLeCJdYbd0VXinzSBnKPIyIWm4/ZjPAlB3S3bjHW
 clr8eXIgDfI2hgm0Ld3AdiBm8Sas2/ECZKnFuHmGx3I3xSBmsPPJx3ECfuT2eV5DILLy
 bpCcRPW0JCBjmUtxXTHA5QVqi+q83HSqEAC6PmSdMQQZeh72K6UDKueBnYFmb1ueLRBR
 AJhn5/SCl00BE0fnM8LMH+wLdNYPy+DXJ1hpoqEKn16AaIQugbT4L+wW31f/rrc2aDzr
 fr74DXFJksDfzxSs1PLFtzzDtmFpziKARrE3xNOTR7ny2GjbiIilMw9NOcPHUxYEiqCI
 KNFw==
X-Gm-Message-State: AOJu0YzfUPOFFieY9CgVENbKDSoXXOLGbyYzVybkHTwfF0HmRm0VHJKl
 5z+EqNtIZeB558aqnZZzkQIhBGs7rLvZqMZwty471PIL9NFcp3djEbXA57kDN4/A2+sr8KANN+r
 6h/JG
X-Gm-Gg: ASbGnculG99hhBF9UXe5Q6WxebD0MU58hswQbR1dptO8fUrxS8lOttgwERYJL4wlHCS
 dKLdY+t97wK0LZLWAwXUv2BR8f8WToNOFzvnIWhbonGapPij7g2pOaH2t8+aUiWMk2SkEF4Wa/r
 mTDaOUy+3Jw4hWZKDXUIm++FSsbjilSei0IRJh2OpbHKgTHTNEqrIrWcVWS/ludab6HjEIzCiQA
 EITUnsuP/4B1wLabVqbCjQZOBtRJ42ENCjnfkLqZKx3fMFWU8lLsTxhfQtXpCa7VgxWnFi4vESm
 S3XEnlNIBMGeq7jQiWo05nHDp3AOj37J2jl2gaX1GYaaJhZ4w3MTAlWS56fXdu+F8h5q+b3pH7B
 l3ZoUT+aPjmzHS+CaA0nLOuWEERNGMmJGBMv2poo=
X-Google-Smtp-Source: AGHT+IFr6bmo8R76A1kIwdM0DmIrtBRMUEQ0YNJqHacot8QVQLXRVjqOP3HHT2GaUNn2laAoMQxoYg==
X-Received: by 2002:a17:903:1207:b0:250:b622:c750 with SMTP id
 d9443c01a7336-25d24da7babmr202078045ad.27.1758032566607; 
 Tue, 16 Sep 2025 07:22:46 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 08/36] target/arm/hvf: Sort the cpreg_indexes array
Date: Tue, 16 Sep 2025 07:22:09 -0700
Message-ID: <20250916142238.664316-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b043eac8c6..99d8672b9b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -925,6 +925,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
+    /* cpreg tuples must be in strictly ascending order */
+    qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
+
     assert(write_cpustate_to_list(arm_cpu, false));
 
     /* Set CP_NO_RAW system registers on init */
-- 
2.43.0


